[URL Link](https://medium.com/@__hungrywolf/microservices-service-to-service-to-invocation-with-dapr-and-net-22f2e0be2779)

_Prerequisites : C#, basic of Web API, Visual Studio, Docker Desktop_

So you’ve heard of microservices or Dapr and want to learn more? Perhaps you’d like to learn some code to get started. I can assist you.

**Microservices**:- It is an architectural style that structures an application as a collection of services that are  
1\. Highly maintainable and testable  
2\. Loosely coupled  
3\. Independently deployable  
4\. Organized around business capabilities

Microservice is a way to implement distributed system. All microservices are distributed systems but all distributed systems are not microservices.

_Hey, but why do I need this?_ The more people work on a deployable unit, the less efficient it becomes. Microservice helps in this case, where smaller teams can work on a single deployable unit. These units may or may not be affected by other units. They communicate with one another through various means. That’s where Dapr comes into the picture.

[**Dapr**](https://dapr.io/):- Dapr codifies the best practices for building microservice applications into open, independent APIs called building blocks that enable you to build portable applications with the language and framework of your choice. One microservice, for example, is written in Python, while another is written in.NET. They can also easily communicate using Dapr.

Dapr provides so many necessary functionalities for microservice architecture.

![](https://miro.medium.com/max/1400/1*KTEutl6q0o5_Tik1oYmlmA.png)

Dapr

In this article, I’ll primarily discuss service-to-service invocation.

![](https://miro.medium.com/max/1400/1*-DXHlEOF5S1J_Nkzt_9nUg.png)

[Dapr’s service invocation process](https://docs.dapr.io/developing-applications/building-blocks/service-invocation/service-invocation-overview/#service-invocation)

1.  Service A makes an HTTP or gRPC call targeting Service B. The call goes to the local Dapr sidecar.
2.  Dapr discovers Service B’s location using the name resolution component which is running on the given hosting platform.
3.  Dapr forwards the message to Service B’s Dapr sidecar (always gRPC calls)
4.  Service B’s Dapr sidecar forwards the request to the specified endpoint (or method) on Service B. Service B then runs its business logic code.
5.  Service B sends a response to Service A. The response goes to Service B’s sidecar.
6.  Dapr forwards the response to Service A’s Dapr sidecar.
7.  Service A receives the response.

There are a few new words like a sidecar. Let’s understand them one by one.

**Sidecar**:-

![](https://miro.medium.com/max/1400/1*aQ9_XAv8F7mkKK-d5P9i5g.jpeg)

Bike with sidecar

In the above image, a sidecar is attached to the bike. Logically, Dapr distributed application capabilities provider is attached to our Service. That’s why the name sidecar. The Dapr APIs are run and exposed on a separate process ( i.e. the Dapr sidecar) running alongside your application. The Dapr sidecar process is named **_daprd_**.

**Name Resolution Component**:- This component helps in finding the sidecar of the desired service. Dapr provides users with the ability to call other applications that have unique ids. This functionality allows apps to interact with one another via named identifiers and puts the burden of service discovery on the Dapr runtime.

**mTLS Encryption**:- Mutual Transport Layer Security (mTLS) is a process that establishes an encrypted TLS connection in which both parties use digital certificates( X.509) to authenticate each other. I won’t go in deep on why we need this. If interested, you may have a look at this [Wikipedia article.](https://en.m.wikipedia.org/wiki/Fallacies_of_distributed_computing)

In a distributed system, Dapr sidecar architecture helps in locating other services, calling other services securely, and handling retries in case of temporary service interruptions.

After a basic introductory theory, now let’s do a practical example. [_You Know the Rules and So Do I_](https://github.com/hungrywoolf/CSharp/tree/main/Microservices)_._

I would create two microservices(Web APIs) with the names ServiceOne and ServiceTwo.

**Basic Configuration**:-

![](https://miro.medium.com/max/1400/1*ZpMezVykbPDuqVuunNoISQ.png)

ASP.NET Core Web API

Two NuGet packages Dapr.Client and Dapr.AspNetCore is required.

![](https://miro.medium.com/max/1400/1*k0s0_RRcPs-fvW3padaS_w.png)

Dapr NuGets for ASP.NET Core

Let’s now create the project ServiceOne with Dapr.

## **1\. Folder Structure:-**

(You may keep the folder structure the way you prefer.)

![](https://miro.medium.com/max/1060/1*9RTeV_wxiTvZxWkx2lI9PQ.png)

Folder Hierarchy

## **2\. Startup.cs**:-

Add Dapr integration

![](https://miro.medium.com/max/1400/1*qzlEWeHbud-XU3tuw1Yltw.png)

ServiceOne Startup.cs

## **3\. IDaprClientHelper**:-

In this interface, I declared a method definition with the name ResponseByDaprClient. This method’s implementation contains steps to invoke other microservices using sidecar.

![](https://miro.medium.com/max/1400/1*b3lSdPvMzPYmmO8lh-jaxw.png)

IDaprClientHelper

## **4.** **DaprClientHelper**:-

![](https://miro.medium.com/max/1400/1*RNNaLEaEfKMCdTUB6-Shtw.png)

DaprClientHelper

ResponseByDaprClient method has so many concepts. Let’s understand them.

**4.1 httpMethod**:- Every API has a unique HTTP request method like PATCH/POST/GET/PUT/DELETE. httpMethod contains this HTTP request method details.

**4.2 appId**:- Name Resolution Component uses this appId to find and perform service invocation for that particular service. AppId would be mentioned in docker-compose.yaml. I will discuss it later in this article.

**4.3 endPoint**:- Relative API controller path .

**4.4 daprClient**:- The Dapr client package allows interacting with other Dapr applications from a .NET application. The daprClient is an instance of DaprClientBuilder that would be used to call other dapr services.

**4.5 daprRequest**:- A HttpRequestMessage that can be used to perform service invocation for the application identified by appId and invokes the method specified by methodName(endPoint) with the HTTP method specified by httpMethod.

**4.6 InvokeMethodAsync**:- Perform service invocation using the request provided by _request._ If the response has a success status code the body will de-serialized using JSON to a value of type T. Other wise an exception will be thrown.

## **5\. IServiceTwoHelper**:-

![](https://miro.medium.com/max/1220/1*irL1RzHkyuMS8ZiaozVP1g.png)

In this interface, I declared a method definition with the name GetMessage. This method’s implementation contains steps to call ServiceTwo’s API named GetMessage.

![](https://miro.medium.com/max/1400/1*Op9EGKfxNUwYT6xt-uKtUg.png)

ServiceTwo GetMessage API Controller

## **6\. ServiceTwoHelper**:-

![](https://miro.medium.com/max/1400/1*IdAOaPxtU04NS3fQaxD87g.png)

I have injected IDaprClientHelper in this class, so I can use ResponseByDaprClient method for ServiceOne to ServiceTwo communication. ResponseByDaprClient takes three parameters as input.

**_httpMethod_**\- HttpMethod.Get in this case because ServiceTwo API is a Get method.

**_appId_**\- “servicetwoapp”, this name will be mentioned in the docker-compose file.

**_endPoint_**\- “/Home/GetMessage”, it is the address of ServiceTwo API.

## 7\. HomeController:-

![](https://miro.medium.com/max/1400/1*TgrnFx-wuA6dc5l8rKgDLQ.png)

HomeController

Now the _docker-compose.yaml_ file.

![](https://miro.medium.com/max/1400/1*bGAxW_q3w6j0Ql5WWi0JMQ.png)

docker-compose.yaml

I explained a basic docker-compose file in [this article](https://medium.com/@__hungrywolf/web-api-and-docker-compose-453f9b824ff9). So here, I am going to focus on the sidecar part i.e. serviceoneapp-dapr and servicetwoapp-dapr.

-   **_image_**: daprd is just the name of the Dapr sidecar process. There are many [published Docker images](https://docs.dapr.io/operations/hosting/self-hosted/self-hosted-with-docker/#images) for each of the Dapr components available on Docker Hub. You may use daprd:latest for the latest release. You should always use fix and stable version for the production environment.
-   **_command_**: It contains a collection of instructions to run a Dapr sidecar.
-   **_app-id_**: ResponseByDaprClient uses this name. The name resolution component uses this name to find the required Dapr sidecar.
-   **_app-port_**: This port number will be the same as an exposed port of service’s Dockerfile.

![](https://miro.medium.com/max/1400/1*dKPoblj--ZsIds9EyUowNA.png)

ServiceOne Dockerfile Expose Port

-   [**_components_**](https://docs.dapr.io/concepts/components-concept/): It is a configuration that defines which state store to use or which pub-sub to use or which binding to use etc.
-   **_network\_mode_**: Using network\_mode, I placed two containers serviceoneapp-dapr and serviceoneapp in the same namespace. It means both have the same IP and the same open TCP ports.

_Hey, that’s a lot of explanation but does it even works._  
Now Let’s test it.

```
>>>docker compose updeploying....( wink)
```

Any application can invoke a Dapr sidecar by using the native invoke API built into Dapr. The API can be called with either HTTP or gRPC. Use the following URL to call the HTTP API:

```
http://localhost:<dapr-port>/v1.0/invoke/<application-id>/method/<method-name>
```

-   `<dapr-port>` the HTTP port that Dapr is listening on.
-   `<application-id>` application ID of the service to call.
-   `<method-name>` name of the method to invoke on the remote service.

![](https://miro.medium.com/max/1400/1*EC00I--cPWWtoTQUleXGmw.png)

Call to ServiceOne sidecar which invokes ServiceTwo

![](https://miro.medium.com/max/1400/1*031eSm3JhhfOgkNoG8g_Zg.png)

Call to ServiceTwo sidecar

That’s how I accomplished service-to-service invocation using docker-compose, Dapr, and a web API.

Friendly Suggestion: Keep the code for every microservice in a separate repository.

Any comments or suggestions would be greatly appreciated.