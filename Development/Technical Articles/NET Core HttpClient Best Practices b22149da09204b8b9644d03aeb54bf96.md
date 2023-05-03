# .NET Core HttpClient Best Practices

Article Link: https://bytedev.medium.com/net-core-httpclient-best-practices-4c1b20e32c6
Author: bytedev
Date Added: October 4, 2021 10:09 AM
Tag: .NET, Coding Standards

.NET Core HttpClient Best Practices

The following are a set of best practices for using the HttpClient object in .NET Core when communicating with web APIs. Note that probably not all practices would be recommended in all situations. There can always be good reasons to break from a certain practice.

This list is not supposed to be exhaustive and will probably be edited over time.

All code examples are in C#.

![https://miro.medium.com/max/1400/1*ieJcKNY9tGAv-qWGf30XXQ.jpeg](https://miro.medium.com/max/1400/1*ieJcKNY9tGAv-qWGf30XXQ.jpeg)

# **Manage HttpClient instances with HttpClientFactory**

HttpClient implements IDisposable. However, unlike most disposable types in .NET the HttpClient should rarely be explicitly disposed.

When we dispose of the HttpClient the underlying HttpClientHandler is also disposed and the connection is closed. Any additional requests mean the connection must be reopened. Re-opening connections is a slow and costly operation and may even lead to socket exhaustion.

However, if a HttpClientHandler is never disposed (and it’s connection is never closed) it leads us to a different problem: not honouring changes in DNS. This reusing of the connection can lead our HttpClient to make requests to the wrong server.

To help with these two problems .NET Core (2.1+) provides the HttpClientFactory to help when instantiating instances of HttpClient. When the factory is called to create an instance of HttpClient the underlying HttpClientHandler is taken from a pool. Handlers exist in the pool for a default of 2 minutes before they are disposed. This means the connection closing/re-opening problem is mitigated while at the same time honouring changes in DNS.

There are a few different ways to use HttpClientFactory. Further information can be found below:

- [Talking Dotnet: 3 ways to use HTTPClientFactory in ASP.NET Core 2.1](https://www.talkingdotnet.com/3-ways-to-use-httpclientfactory-in-asp-net-core-2-1/)
- [Microsoft: Use IHttpClientFactory to implement resilient HTTP requests](https://docs.microsoft.com/en-us/dotnet/architecture/microservices/implement-resilient-applications/use-httpclientfactory-to-implement-resilient-http-requests)

# **Use SendAsync**

Instead of the particular HTTP verb based shortcut methods on HttpClient (such as GetAsync, PostAsync etc.) use the SendAsync method.

This method allows you to create a particular request object (HttpRequestMessage) that is then passed to the method.

There are two main benefits to using a HttpRequestMessage in conjunction with SendAsync:

1. It allows more specific control over the request that might not be possible using the HTTP verb style shortcut methods.
2. Headers can be placed on the individual request rather than on the HttpClient itself. A HttpClient instance should be shared across requests so any default headers set on the client will be used for all requests the HttpClient performs. In most circumstances this is not a good idea as the same HttpClient instance could be potentially used to perform different types of requests, to different endpoints, with different headers etc.

# **Always set the Accept request header**

Setting the Accept header on the request with a content MIME type (such as `application/json` ) allows the API to know what format the client expects the response content to be in (i.e. the format the client supports). If the API supports multiple data formats then it will be able to return the data in the format the client will be able to understand.

The Accept request header can either be set on the HttpClient:

```csharp
var mt = new MediaTypeWithQualityHeaderValue("application/json");

client.DefaultRequetHeaders.Accept.Add(mt);
```

Or can be set on the request object itself:

```csharp
var request = new HttpRequestMessage(HttpMethod.Get, "api/orders");

var mt = new MediaTypeWithQualityHeaderValue("application/json");

request.Headers.Accept.Add(mt);
```

Note that defining the required content type on the Accept request header is often described as being part of “content negotiation”. However, content negotiation can be used to specify much more that just the content type, including version, language, encoding etc.

# **Use Streams when reading responses**

When calling a web API we would often follow a process:

1. Wait for response and it’s content to completely arrive
2. Parse content to a string
3. Deserialize the string to an object

We can cut out the use of this intermediary string object in step 2 by reading the response content as a stream and then providing the stream directly to the serializer. This will lower our memory usage as well as often improving performance.

The following example demonstrates how we can achieve this when using Json.NET in .NET Core:

```csharp
var response = await client.SendAsync(request);

using(var stream = await response.Content.ReadAsStreamAsync())
{
    using (var streamReader = new StreamReader(stream))
    {
      using (var jsonTextReader = new JsonTextReader(streamReader))
      {
        var customer = new JsonSerializer().Deserialize<Customer>(jsonTextReader);      
	  
        // do something with the customer
      }
    }
}
```

# **Start reading response content ASAP**

When using an instance of HttpClient by default any requests made will consider the response ready to use once the entire response has arrived (headers + body content).

Following on from the improvement in the “Use Streams when reading responses” section (where we no longer use an intermediary string object and instead use a stream) we can tell the HttpClient that we want to start reading the response content once the response headers have arrived rather than once the entire response has arrived.

We can do this by passing a HttpCompletionOption argument through when calling SendAsync on the client:

```csharp
var response = await client.SendAsync(request, HttpCompletionOption.ResponseHeadersRead);
```

The response content should then be read as a stream in the same way as in the “Use Streams when reading responses” section.

# **Define custom Content types**

Define your own custom content types that encapsulate different common content types used by your HttpClient.

For example custom JsonContent and XmlContent types that derive from StringContent:

```csharp
public class JsonContent : StringContent
{
    public JsonContent(string content)
        : this(content, Encoding.UTF8)
    {
    }

    public JsonContent(string content, Encoding encoding)
        : base(content, encoding, "application/json")
    {
    }
}

public class XmlContent : StringContent
{
    public XmlContent(string content) 
        : this(content, Encoding.UTF8)
    {
    }

    public XmlContent(string content, Encoding encoding)
        : base(content, encoding, "application/xml")
    {
    }
}
```

These types can then be used on the HttpRequestMessage that we send from SendSync:

```csharp
var request = new HttpRequestMessage(HttpMethod.Post, "api/orders");

request.Content = new JsonContent(json);
```

# **Check the response status code**

Never assume a request worked. Instead always check the response’s HTTP status code before examining the response’s content.

For example:

```csharp
var response = await client.SendAsync(request);

if (response.StatusCode == HttpStatusCode.Unauthorized)
{
    // need to refresh the request security token!
}

if (response.IsSuccessStatusCode)
{
    // the status code was 2xx
}
```

# **Check the response content on errors**

In particular situations the API might return a 4xx (client request error) or 5xx (server error). After examining the response code (as mentioned in the “Check the response status code” section above) it is usually a good idea to read the response content as it often has additional useful information on the problem.

For example in this case handling a 400 Bad Request response error by retrieving the details from the content:

```csharp
var response = await client.SendAsync(request);

if (response.StatusCode == HttpStatusCode.BadRequest)
{
    var details = await response.Content.ReadAsStringAsync();
}
```

Many APIs do not use status codes in a very specific way. For example simply returning a 400 or 500 when ever there is a problem or even just returning 200 in all situations. Determining the actual problem from these codes alone can be quite difficult so inspecting the response content as well is usually recommended.

# **Check the response Content-Type**

You may have set the Accept type on your client but that does not guarantee the API will “play ball” and return content in the data format you specified.

For this reason it is recommended that before examining/deserializing the response content you check the response’s content type is what you expect. This way you can better handle the response appropriately.

For example:

```csharp
var response = await client.SendAsync(request);

if (response.Content.Headers.ContentType.MediaType == "application/json")
{
    var json = await response.Content.ReadAsStringAsync();
  
    var order = JsonConvert.DeserializeObject<Order>(json);
}
```

It should be noted that this is not a fool proof way of determining the response content data format as an API can still possibly “lie” and send data of a different format to the one specified in the response header.

# **Use Cancellation Tokens**

Making HTTP calls to an API can be a relatively slow process (in comparative computing terms) so you should provide the option to cancel calls. This also allows you to free up resources as quickly as possible.

HttpClient’s asynchronous methods, such as SendAsync, provide the ability to pass in a cancellation token.

For example:

```csharp
public async Task<Order> GetOrderAsync(CancellationToken cancellationToken = default)
{
    // setup your client & request
  
    var response = await client.SendAsync(request, cancellationToken);
}
```

# **Use Compression when dealing with large responses**

If the API supports it you may be able to state you want the response to be compressed. Hence reducing its size over the wire.

For example:

```csharp
// Tell HttpClient to auto decompress responses using the 
// particular compression method (e.g. GZip).
var client = new HttpClient(new HttpClientHandler
{
    AutomaticDecompression = DecompressionMethods.GZip
});

// ...

// Tell the API we only want responses in gzip format.
request.Headers.AcceptEncoding.Add(new StringWithQualityHeaderValue("gzip"));
```

There is always an added overhead to using compression so simply requesting all responses be compressed regardless of the response content size will probably not be a good idea. The larger the response the more likely you are to gain a performance improvement using compression. As with everything it’s best to test.