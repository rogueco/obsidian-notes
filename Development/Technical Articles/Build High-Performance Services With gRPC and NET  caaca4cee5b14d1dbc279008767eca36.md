# Build High-Performance Services With gRPC and .NET 5

Article Link: https://medium.com/swlh/build-high-performance-services-with-grpc-and-net-5-7605ffe9b2a2
Author: Hammad Abbasi
Date Added: August 26, 2021 4:02 PM
Tag: .NET, Microservices, gRPC

NET 5 has been [released](https://devblogs.microsoft.com/dotnet/announcing-net-5-0/) and It comes with a lot of exciting features, new technologies and performance improvements. It unifies the .net environment and replaces .NET Core. In this blog, we’ll focus on building high performance services using gRPC and .NET 5.

# **Why gRPC?**

gRPC is not another buzzword being thrown around. It’s a popular open-source RPC framework. It has been around for a while but it’s built on new technologies like HTTP/2 and Protobuf. It’s platform-independent as it offers language-neutral contract language — which is designed for high-performance modern apps.

# **How does it compare with WCF and REST ?**

WCF, which is also a RPC framework and achieves the same goals, but there are some key differences:

- gRPC uses Http/2 (You can learn more about Http/2 [in detail here](https://medium.com/swlh/a-beginners-guide-to-http-2-and-its-importance-700f619bbfe7)).
- It uses a faster binary protocol which makes it more efficient for computers to parse.
- It supports Multiplexing over a single connection (It means multiple requests can be sent without request blocking each other).
- It uses [ProtoBuf](https://medium.com/better-programming/understanding-protocol-buffers-43c5bced0d47) which providers faster serialization/deserialization and also uses less bandwidth than other text-based formats.
- There’s much better tooling in .NET 5 to automatically generate boilerplate code to hide the remoting complexity so you may focus on business logic.
- Streaming allows multiple responses to be sent to the client and also the client to server and bi-directional streaming.
- It’s designed for low latency and high throughput so it’s great for lightweight microservices where performance is critical.
- Deadlines/timeouts and cancellation allows the client to specify how long they are willing to wait for an RPC to complete.

# **Inter-Process Communication**

gRPC calls are sent usually over tcp sockets. However, if the client and server are on the same machine gRPC can use custom transport like Unix Sockets, Name Pipes, etc in IPC scenarios.

# **Getting Started**

- Install [.NET 5.0 Runtime and SDK](https://dotnet.microsoft.com/download/dotnet/5.0)
- Update Visual Studio 2019 to 16.8 or later (There’s a [C# extension](https://code.visualstudio.com/docs/languages/dotnet) that supports .NET 5.0 and C#9 for Visual Studio Code)

# **Create your First gRPC Service**

1. Open Visual Studio (16.8) and Create a new project
2. Select gRPC project template

![https://miro.medium.com/max/1400/1*7WaBR6ueg0bk2S-KLTxL-Q.png](https://miro.medium.com/max/1400/1*7WaBR6ueg0bk2S-KLTxL-Q.png)

3. Select ASP.NET Core gRPC Service (You can see the “ .NET 5.0” in the framework drop if installed correctly)

![https://miro.medium.com/max/1400/1*Z5l3IR8FZVqckX0a8dEcbQ.png](https://miro.medium.com/max/1400/1*Z5l3IR8FZVqckX0a8dEcbQ.png)

4. Enable Docker Support if you want to containerize this service (to be run as a docker container).

It will create the asp.net core app with gRPC service. Let’s explore the solution folder — Protos -> greet.proto file.

![https://miro.medium.com/max/778/1*GGk44SCN-ZDxoo2a06UgeA.png](https://miro.medium.com/max/778/1*GGk44SCN-ZDxoo2a06UgeA.png)

# **What is Proto file?**

Since gRPC is a contract first RPC framework, therefore the contract is defined in the proto file — which is the heart of gRPC. It’s a language-agnostic way of defining your apis and the messages.

![https://miro.medium.com/max/1400/1*yMOAluCktDnmD508KgYIog.png](https://miro.medium.com/max/1400/1*yMOAluCktDnmD508KgYIog.png)

This proto file contains service definition — which in our case is Greeter

SayHello is the method that takes a request and returns a response.

HelloRequest and HelloReply are declared as messages and can have properties similar to classes and simply defines the strongly typed data that will be transmitted.

Let’s explore the gRPC service (GreeterService.cs in our case)

![https://miro.medium.com/max/1400/1*5R7FwhYW4JWPKxbQX1EwuQ.png](https://miro.medium.com/max/1400/1*5R7FwhYW4JWPKxbQX1EwuQ.png)

This server implements the same method (defined in the proto file above) and takes the HelloRequest object as a parameter and returns HelloReply in response

(Advanced: It also has ServerCallContext object — It’s a context for server-side calls and is used for authenticating and authorizing gRPC calls).

# **Code Generation — Where the Magic Happens**

You might wonder where are GreeterBase, HelloRequest, and HelloReply files? Well, that’s where the magic happens and they are automatically generated so they hide all the routing and remoting complexities.

Code generation in action

![https://miro.medium.com/max/2810/1*i5WDQhWo5CD0QWnTkOogQA.png](https://miro.medium.com/max/2810/1*i5WDQhWo5CD0QWnTkOogQA.png)

![https://miro.medium.com/max/2762/1*NMD1bftS1y57SBwg6vcfug.png](https://miro.medium.com/max/2762/1*NMD1bftS1y57SBwg6vcfug.png)

# **Let’s run this service**

open the console and navigate to the service directory

type : dotnet run

![https://miro.medium.com/max/1400/1*SoaeFgz_m8zI6npMxEFBTQ.png](https://miro.medium.com/max/1400/1*SoaeFgz_m8zI6npMxEFBTQ.png)

You will notice that the service is up and running using kestral webserver.

If you try to the url in the browser, you will get the following message:

![https://miro.medium.com/max/1400/1*tJEUQKfZNXXha7LFfXrBWw.png](https://miro.medium.com/max/1400/1*tJEUQKfZNXXha7LFfXrBWw.png)

Yes!— Unlike REST services, you need to create a client in order to communicate with gRPC service.

**Let’s create a gRPC Client:**

- Create a new.net 5.0 console app.
- Right Click on Project — Add — Connected Service

![https://miro.medium.com/max/1400/1*AZI62uR7BbHTCEJVa6_XNQ.png](https://miro.medium.com/max/1400/1*AZI62uR7BbHTCEJVa6_XNQ.png)

- Choose gRPC service reference

![https://miro.medium.com/max/1400/1*1HRoIYyiFPz_PzDFIf3zZg.png](https://miro.medium.com/max/1400/1*1HRoIYyiFPz_PzDFIf3zZg.png)

- Locate the proto file (It needs to be known by both server and the client).
- from class type dropdown — choose Client to generate client-side code generation

![https://miro.medium.com/max/1400/1*VtYk9qYGENZ1sxvKku9TtQ.png](https://miro.medium.com/max/1400/1*VtYk9qYGENZ1sxvKku9TtQ.png)

- After finishing, service reference will be added to the project as shown below.

![https://miro.medium.com/max/1400/1*eQywiUAufTkRF-VxNZWA8g.png](https://miro.medium.com/max/1400/1*eQywiUAufTkRF-VxNZWA8g.png)

(Hint: check .csproj file, it will contain the necessary tags for gRPC service e.g protobuf)

Let’s write some code in Program.cs to communicate with gRPC service.

```
using GreeterService;using Grpc.Net.Client;using System;namespace gRPCClientDemo{class Program{static async System.Threading.Tasks.Task  Main(string[] args){var channel = GrpcChannel.ForAddress("https://localhost:5001");var client = new Greeter.GreeterClient(channel);var response = await client.SayHelloAsync(      new HelloRequest{      Name = ".NET 5 - grpcClient"      });Console.WriteLine("From Server: " + response.Message);Console.ReadKey();}
}
}
```

Build your project, run it and you may see the below output.

![https://miro.medium.com/max/1400/1*EchiM5jD6RoZZ5jq4kK1XQ.png](https://miro.medium.com/max/1400/1*EchiM5jD6RoZZ5jq4kK1XQ.png)

If you check the console (for service) You will find the logs for your client call.

![https://miro.medium.com/max/1400/1*5mdYCKORm_IdEB_UxUPUPA.png](https://miro.medium.com/max/1400/1*5mdYCKORm_IdEB_UxUPUPA.png)

Let’s analyze the client code:

# **Creating a Channel**

The first step is to create a gRPC channel (as shown below, make sure to add the relevant namespace for your service and also “Grpc.Net.Client”.

```
var channel = GrpcChannel.ForAddress("https://localhost:5001");
```

This will create the gRPC channel for a specific address. Please note that creating a channel can be expensive, so it’s better to reuse it for performance benefits.

# **Make gRPC Call**

```
var client = new Greeter.GreeterClient(channel);var response = await client.SayHelloAsync(new HelloRequest
{Name = ".NET 5 - grpcClient"});Console.WriteLine("From Server: " + response.Message);
```

This is a unary call — The client sends a request message and a response message is returned when the service finishes.

(Note: Every service method in *.proto file creates two methods: an async method and a blocking method )

That’s it! we have completed our first gRPC server and client implementation in .NET 5.

# **What’s Next?**

There’s so much more to learn from [here](https://docs.microsoft.com/en-gb/aspnet/core/grpc/?view=aspnetcore-5.0). Like using bi-directional streaming, Running gRPC on docker containers, create JSON WebAPIs from gRPC and so much more. Stay tuned!