# Using gRPC in Microservices for Building a high-performance Interservice Communication with .Net 5

Article Link: https://medium.com/aspnetrun/using-grpc-in-microservices-for-building-a-high-performance-interservice-communication-with-net-5-11f3e5fa0e9d
Author: Mehmet Özkaya
Date Added: October 23, 2021 3:47 PM
Tag: .NET, Microservices, gRPC

![https://miro.medium.com/max/1188/1*Pnif69jyAxlAINoOTb6QjA.png](https://miro.medium.com/max/1188/1*Pnif69jyAxlAINoOTb6QjA.png)

gRPC usage of Microservices Communication

In this article, we’re going to learn how to Build a Highly Performant Inter-service Communication with gRPC for ASP NET 5 Microservices.

We will introduce gRPC as a modern high-performance RPC framework for ASP.NET Core and for interservice communication.gRPC uses HTTP/2 as base transport protocol and ProtoBuf encoding for efficient and fast communication.

# **gRPC usage of Microservices**

Microservices are modern distributed systems so with gRPC in ASP.NET 5, we will develop high-performance, cross-platform applications for building distributed systems and APIs.

![https://miro.medium.com/max/700/1*HRO6F1VnuK_3YOo_oPgxvg.png](https://miro.medium.com/max/700/1*HRO6F1VnuK_3YOo_oPgxvg.png)

It’s an ideal choice for communication between backend microservices, internal network applications, or iot devices and services. With the release of ASP.NET 5, Microsoft has added first-class support for creating gRPC services with aspnet5.

This article will led you get started building, developing and managing gRPC servers and clients on distributed microservices architecture.

# **Step by Step Development w/ Course**

![https://miro.medium.com/max/700/1*_NadT2xrfl_47szBHh2Q1w.png](https://miro.medium.com/max/700/1*_NadT2xrfl_47szBHh2Q1w.png)

**[I have just published a new course — Using gRPC in Microservices Communication with .Net 5.](https://www.udemy.com/course/using-grpc-in-microservices-communication-with-net-5/?couponCode=OCTOBER2021)**

In the course, we are going to build a **high-performance gRPC Inter-Service Communication between backend microservices with .Net 5 and Asp.Net5.**

# **Source Code**

**[Get the Source Code from AspnetRun Microservices Github](https://github.com/aspnetrun/run-aspnet-grpc)** — Clone or fork this repository, if you like don’t forget the star :) If you find or ask anything you can directly open issue on repository.

# **Overall Picture**

See the overall picture. You can see that we will have 6 microservices which we are going to develop.We will use Worker Services and Asp.Net 5 Grpc applications to build client and server gRPC components defining proto service definition contracts.

![https://miro.medium.com/max/700/1*3BJ8VWRmANeMFBOLCVzg8g.png](https://miro.medium.com/max/700/1*3BJ8VWRmANeMFBOLCVzg8g.png)

Basically we will implement **e-commerce** logic with only gRPC communication. We will have 3 gRPC server applications which are **Product** — **ShoppingCart** and **Discount** gRPC services. And we will have 2 worker services which are **Product** and **ShoppingCart Worker Service**. Worker services will be client and perform operations over the gRPC server applications. And we will secure the **gRPC services** with standalone **Identity Server** microservices with **OAuth 2.0** and **JWT** token.

## **ProductGrpc Server Application**

First of all, we are going to develop ProductGrpc project. This will be asp.net gRPC server web application and expose apis for Product Crud operations.

## **Product Worker Service**

After that, we are going to develop Product Worker Service project for consuming ProductGrpc services. This product worker service project will be the client of ProductGrpc application and generate products and insert bulk product records into Product database by using client streaming gRPC proto services of ProductGrpc application. This operation will be in a time interval and looping as a service application.

## **ShoppingCartGrpc Server Application**

After that, we are going to develop ShoppingCartGrpc project. This will be asp.net gRPC server web application and expose apis for SC and SC items operations. The grpc services will be create sc and add or remove item into sc.

## **ShoppingCart Worker Service**

After that, we are going to develop ShoppingCart Worker Service project for consuming ShoppingCartGrpc services. This ShoppingCart worker service project will be the client of both ProductGrpc and ShoppingCartGrpc application. This worker service will read the products from ProductGrpc and create sc and add product items into sc by using gRPC proto services of ProductGrpc and ShoppingCartGrpc application. This operation will be in a time interval and looping as a service application.

## **DiscountGrpc Server Application**

When adding product item into SC, it will retrieve the discount value and calculate the final price of product. This communication also will be gRPC call with SCGrpc and DiscountGrpc application.

## **Identity Server**

Also, we are going to develop centralized standalone Authentication Server with implementing IdentityServer4 package and the name of microservice is Identity Server.Identity Server4 is an open source framework which implements OpenId Connect and OAuth2 protocols for .Net Core.With IdentityServer, we can provide protect our SC gRPC services with OAuth 2.0 and JWT tokens. SC Worker will get the token before send request to SC Grpc server application.

> By the end of this article, you will have a practical understanding of how to use gRPC to implement a fast and distributed microservices systems.And Also you’ll learn how to secure protected grpc services with IdentityServer in a microservices architecture.
> 

# **Background**

You can follow the previous article which explains overall microservice architecture of this example.

**[Check for the previous article which explained overall microservice architecture of this repository.](https://medium.com/aspnetrun/microservices-architecture-on-net-3b4865eea03f)**

# **Prerequisites**

- Install the .NET 5 or above SDK
- Install Visual Studio 2019 v16.x or above

# **Introduction**

We will implement **e-commerce** logic with only gRPC communication. We will have 3 gRPC server applications which are **Product** — **ShoppingCart** and **Discount** gRPC services. And we will have 2 worker services which are **Product** and **ShoppingCart Worker Service**. Worker services will be client and perform operations over the gRPC server applications. And we will secure the **gRPC services** with standalone **Identity Server** microservices with **OAuth 2.0** and **JWT** token.

# **Code Structure**

Let’s check our project code structure on the visual studio solution explorer window. You can see the 4 solution folder and inside of that folder you will see Grpc server and client worker projects which we had see on the overall picture.

![https://miro.medium.com/max/413/1*2Mh4WrwFpnBhBNL1Vsz-bA.png](https://miro.medium.com/max/413/1*2Mh4WrwFpnBhBNL1Vsz-bA.png)

If we expand the projects, you will see that;Under Product folder; **ProductGrpc** is a gRPC aspnet application which includes crud api operations.**ProductWorkerService** is a WorkerService template application which consumes and perform operations over the product grpc server application.As the same way you can follow the **ShoppingCart** and **Discount** folders.And also we have **IdentityServer** is a standalone Identity Provider for our architecture.

> Before we start we should learn the basics of terminology.
> 

# **What is gRPC ?**

gRPC (gRPC Remote Procedure Calls) is an open source remote procedure call (RPC) system initially developed at Google.gRPC is a framework to efficiently connect services and build distributed systems.

![https://miro.medium.com/max/693/1*7MqxM2kFRpclxwXo_d11XA.png](https://miro.medium.com/max/693/1*7MqxM2kFRpclxwXo_d11XA.png)

It is focused on high performance and uses the HTTP/2 protocol to transport binary messages. It is relies on the Protocol Buffers language to define service contracts. Protocol Buffers, also known as Protobuf, allow you to define the interface to be used in service to service communication regardless of the programming language.

It generates cross-platform client and server bindings for many languages. Most common usage scenarios include connecting services in microservices style architecture and connect mobile devices, browser clients to backend services.

The gRPC framework allows developers to create services that can communicate with each other efficiently and independently from their preferred programming language.

Once you define a contract with Protobuf, this contract can be used by each service to automatically generate the code that sets up the communication infrastructure.

This feature simplifies the creation of service interaction and, together with high performance, makes gRPC the ideal framework for creating microservices.

# **How gRPC works ?**

In GRPC, a client application can directly call a method on a server application on a different machine like it were a local object, making it easy for you to build distributed applications and services.

![https://miro.medium.com/max/680/1*UaJAgjEb2mSf15Fm2rHwKg.png](https://miro.medium.com/max/680/1*UaJAgjEb2mSf15Fm2rHwKg.png)

As with many RPC systems, gRPC is based on the idea of defining a service that specifies methods that can be called remotely with their parameters and return types. On the server side, the server implements this interface and runs a gRPC server to handle client calls. On the client side, the client has a stub that provides the same methods as the server.

gRPC clients and servers can work and talk to each other in a different of environments, from servers to your own desktop applications, and that can be written in any language that gRPC supports. For example, you can easily create a gRPC server in Java or c# with clients in Go, Python or Ruby.

# **Working with Protocol Buffers**

gRPC uses Protocol Buffers by Default.Protocol Buffers are Google’s open source mechanism for serializing structured data.

![https://miro.medium.com/max/658/1*BFRC0wUmDLFDzntKYIGzpw.png](https://miro.medium.com/max/658/1*BFRC0wUmDLFDzntKYIGzpw.png)

When working with protocol buffers, the first step is to define the structure of the data you want to serialize in a proto file: this is an ordinary text file with the extension .proto.The protocol buffer data is structured as messages where each message is a small logical information record containing a series of name-value pairs called fields.

Once you’ve determined your data structures, you use the protocol buffer compiler protocol to create data access classes in the languages you prefer from your protocol definition.

You can find the whole language guide into google’s offical documentation of protocol buffer language. Let me add the link as below.[https://developers.google.com/protocol-buffers/docs/overview](https://developers.google.com/protocol-buffers/docs/overview)

# **gRPC Method Types — RPC life cycles**

gRPC lets you define four kinds of service method:

![https://miro.medium.com/max/700/1*t6ITFSyO5RmPmc0onISyIg.png](https://miro.medium.com/max/700/1*t6ITFSyO5RmPmc0onISyIg.png)

**Unary RPCs** where the client sends a single request to the server and returns a single response back, just like a normal function call.

**Server streaming RPCs** where the client sends a request to the server and gets a stream to read a sequence of messages back. The client reads from the returned stream until there are no more messages. gRPC guarantees message ordering within an individual RPC call.

**Client streaming RPCs** where the client writes a sequence of messages and sends them to the server, again using a provided stream. Once the client has finished writing the messages, it waits for the server to read them and return its response. Again gRPC guarantees message ordering within an individual RPC call.

**Bidirectional streaming RPCs** where both sides send a sequence of messages using a read-write stream. The two streams operate independently, so clients and servers can read and write in whatever order they like: for example, the server could wait to receive all the client messages before writing its responses, or it could alternately read a message then write a message, or some other combination of reads and writes.

# **gRPC Development Workflow**

So far we had a good definitions of gRPC and proto buffer files. So now we can summarize the development workflow of gRPC.

![https://miro.medium.com/max/700/1*Xp3RInvYZsmiv-v2dU1YwQ.png](https://miro.medium.com/max/700/1*Xp3RInvYZsmiv-v2dU1YwQ.png)

gRPC uses a contract-first approach to API development. Services and messages are defined in *.proto files.

gRPC uses Protocol Buffers so we are start to developing protobuf file.Protocol Buffers is a way to define the structure of data that you want to serialize.

Once we define the structure of data in a file with .proto extension, we use protoc compiler to generate data access classes in your preferred language(s) from your proto definition.This will generate the data access classes from your application. We choose the C# client during the article.

# **Advantages of gRPC**

General advantages of gRPC:

- Using HTTP / 2

These differences of HTTP / 2 provide 30–40% more performance. In addition, since gRPC uses binary serialization, it needs both more performance and less bandwidth than json serialization.

- Higher performance and less bandwidth usage than json with binary serialization
- Supporting a wide audience with multi-language / platform support
- Open Source and the powerful comminity behind it
- Supports Bi-directional Streaming operations
- Support SSL / TLS usage
- Supports many Authentication methods

# **gRPC vs REST**

gRPC is in an advantadge position against REST-based APIs that have become popular in recent years. Because of the protobuf format, messages take up less space and therefore communication is faster.

![https://miro.medium.com/max/700/1*vaU2meX4-H4vWtff_9OkdA.png](https://miro.medium.com/max/700/1*vaU2meX4-H4vWtff_9OkdA.png)

Unlike REST, gRPC works on a contract file basis, similar to SOAP.

Encoding and Decoding part of gRPC requests takes place on the client machine. That’s why the JSON encode / decode you make for REST apis on your machine is not a problem for you here.

You do not need to serialize (serialization / deserialization) for type conversions between different languages because your data type is clear on the contract and the code for your target language is generated from there.

# **gRPC usage of Microservices Communication**

gRPC is primarily used with backend services.

![https://miro.medium.com/max/594/1*Pnif69jyAxlAINoOTb6QjA.png](https://miro.medium.com/max/594/1*Pnif69jyAxlAINoOTb6QjA.png)

But also gRPC using for the following scenarios:

- Synchronous backend microservice-to-microservice communication where an immediate response is required to continue processing.
- Polyglot environments that need to support mixed programming platforms.
- Low latency and high throughput communication where performance is critical.
- Point-to-point real-time communication — gRPC can push messages in real time without polling and has excellent support for bi-directional streaming.
- Network constrained environments — binary gRPC messages are always smaller than an equivalent text-based JSON message.

# **Example of gRPC in Microservices Communication**

Think about that we have a Web-Marketting API Gateway and this will forward to request to Shopping Aggregator Microservice.

![https://miro.medium.com/max/700/1*HRO6F1VnuK_3YOo_oPgxvg.png](https://miro.medium.com/max/700/1*HRO6F1VnuK_3YOo_oPgxvg.png)

This Shopping Aggregator Microservice receives a single request from a client, dispatches it to various microservices, aggregates the results, and sends them back to the requesting client. Such operations typically require synchronous communication as to produce an immediate response.

In this example, backend calls from the Aggregator are performed using gRPC.gRPC communication requires both client and server components.

You can see that Shopping Aggregator implements a gRPC client.The client makes synchronous gRPC calls to backend microservices, this backend microservices are implement a gRPC server.

As you can see that, The gRPC endpoints must be configured for the HTTP/2 protocol that is required for gRPC communication.

In microservices world, most of communication use asynchronous communication patterns but some operations require direct calls. gRPC should be the primary choice for direct synchronous communication between microservices. Its high-performance communication protocol, based on HTTP/2 and protocol buffers, make it a perfect choice.

# **gRPC with .NET**

gRPC support in .NET is one of the best implementations along the other languages.

![https://miro.medium.com/max/655/1*ObkUL1h0crTeT6gT5EtANA.png](https://miro.medium.com/max/655/1*ObkUL1h0crTeT6gT5EtANA.png)

Last year Microsoft contributed a new implementation of gRPC for .NET to the Cloud Native Computing Foundation — CNCF. Built on top of Kestrel and HttpClient, gRPC for .NET makes gRPC a first-class member of the .NET ecosystem.

gRPC is integrated into .NET Core 3.0 SDK and later.

The SDK includes tooling for endpoint routing, built-in IoC, and logging. The open-source Kestrel web server supports HTTP/2 connections.

Also a Visual Studio 2019 template that scaffolds a skeleton project for a gRPC service. Note how .NET Core fully supports Windows, Linux, and macOS.

Both the client and server take advantage of the built-in gRPC generated code from the .NET Core SDK. Client-side stubs provide the plumbing to invoke remote gRPC calls. Server-side components provide gRPC plumbing that custom service classes can inherit and consume.

# **gRPC performance in .NET 5**

gRPC and .NET 5 are really fast.

![https://miro.medium.com/max/700/1*PrWxbD8tdtC0_kZmMW9k0A.png](https://miro.medium.com/max/700/1*PrWxbD8tdtC0_kZmMW9k0A.png)

In a community run benchmark of different gRPC server implementations, .NET gets the highest requests per second after Rust, and is just ahead of C++ and Go.You can see the image that comparison of performance with other languages.

This result builds on top of the work done in .NET 5. The benchmarks show .NET 5 server performance is 60% faster than .NET Core 3.1. .NET 5 client performance is 230% faster than .NET Core 3.1.

Performance is a very important feature when it comes to communications on scaling cloud applications. So with .Net and gRPC is being very good alternative to implement backend microservices with .net and communicate with gRPC.

****[gRPC performance improvements in .NET 5 | ASP.NET BlogJames gRPC is a modern open source remote procedure call framework. There are many exciting features in gRPC: real-time…**
devblogs.microsoft.com](https://devblogs.microsoft.com/aspnet/grpc-performance-improvements-in-net-5/)

# **HelloWorld gRPC with Asp.Net 5**

In this section, we are going to learn how to build gRPC in Asp.Net 5 projects with developing HelloWorld API operations.We will starting with creating empty web application and develop gRPC implementation with step by step.

We are going to cover the;

- Developing hello.proto Protocol Buffer File (protobuf file) for gRPC Contract-First API Development
- Implementing gRPC Service Class which Inherits from gRPC generated service
- Configure gRPC Service with Registering Asp.Net Dependecy Injection and Configure with Mapping GrpcService in Asp.Net Middleware
- Run the Application as exposing gRPC Services
- Create GrpcHelloWorldClient Client Application for gRPC Server
- Consume Grpc HelloService API From Client Console Application with GrpcChannel
- Scaffolding gRPC Server with gRPC Template of Visual Studio

## **Create Asp.Net Core Empty Web Project For HelloWorld Grpc**

First, we are going to create;

Create Asp.Net Core Web Empty Project :Right Click Solution — Add new Web Empty — HTTPS — https required for http2 tls protocol**— Solution name : GrpcHelloWorld— Project name : GrpcHelloWorldServer**After that, the first step we will start with adding Grpc.AspNet Nuget packages in our project.

**Add Nuget Package**Grpc.AspNetCore → this includes tools etc packages..

We can continue with the most important part of any gRPC project. Let’s Create “Protos” folder and under the Protos folder, add new protobuf file which name is hello.proto :

Create “Protos” folderAdd new protobuf filehello.proto

gRPC uses a contract-first approach to API development. Services and messages are defined in *.proto files.

## **Developing hello.proto Protocol Buffer File (protobuf file) for gRPC Contract-First API Development**

First, we are going to open hello.proto file. Because, gRPC uses a contract-first approach to API development. Services and messages are defined in *.proto files:

Develop hello.proto file; Let me write first and I will explain details after that.

```
syntax = “proto3”;option csharp_namespace = “GrpcHelloWorldServer”;package helloworld;service HelloService {
 rpc SayHello (HelloRequest) returns (HelloResponse);
 }message HelloRequest {
 string name = 1;
 }message HelloResponse {
 string message = 1;
 }
```

Ok now, let me explain this proto file;

First, The syntax statement tells the protobuf compiler what syntax we are going to use. it’s important to specify which protobuf version we are using.The second statement is optional and it tells the protobuf compiler to generate C# classes within the specified namespace: GrpcHelloWorldServer.

After that, we have Defined a HelloService. The HelloService service defines a SayHello call. SayHello sends a HelloRequest message and receives a HelloResponse message.

So we are defining the HelloRequest and HelloResponse message types like data transfer objects (DTOs). This messages and services will be generated for accessing from our application.

After that, we should Add this proto file in our project file item groups in order to attach and generate proto file c# codes.— So Go to **GrpcHelloWorldServer.csproj** project file;

**Edit the GrpcHelloWorldServer.csproj project file:**Right-click the project and select Edit Project File.

Add an item group with a <Protobuf> element that refers to the greet.proto file:

```
<ItemGroup>
 <Protobuf Include=”Protos\hello.proto” GrpcServices=”Server” />
 </ItemGroup>
```

If not exist, make sure that it should be stored in project file. This will provide to generate C# proto class when build the application.

Now we can build the project. When we build the project, it compiles the proto file and it will generate c# proto class.Right-click the project and Build the projectit compiles the proto file

Also we can check Properties of Proto file with F4**Build Action = Protobuf compilergRPC stub Classes = Server only**

As you can see that, we set the “Build Action = Protobuf compiler”, that means when building and compile the project, visual studio also build this hello.proto file with the “Protobuf compiler”.

Also we set the “gRPC stub Classes = Server only”, that means when generate the c# class, it will arrange the codes as a Server of gRPC Api project. So by this way we can implement server logics with generated scaffolding c# proto class.

**Check the Generated Class**Click “Show All Files” of Solution WindowGo to -> obj-debug-netcoreapp-protos-> HelloGrpc.csSee that our class is generated;public static partial class HelloService

As you can see that, HelloService.cs class generated by visual studio and it will provide to connect gRPC service as a server role. Now we can use this class and implement our server logics with connectting gRPC API.

## **Implementing gRPC Service Class which Inherits from gRPC generated service**

In this part, we are going to implement gRPC Service Class which Inherits from gRPC generated service class.Let’s take an action.

First, we are going to create Service folder under our application.After that we can;

**Add Service Class into Service Folder**

HelloWorldService

Inherit from gRPC generated service class**public class HelloWorldService : HelloService.HelloServiceBase**

As you can see that we should inherit our Service class from generated gRPC server class.And we can use all features of asp.net in here like logging, configurations and other dependency injections, so its so powerfull to use gRPC with .net. We can use all features of aspnet in this class.For example let’s add logger object.

```
public class HelloWorldService : HelloService.HelloServiceBase
 {
 private readonly ILogger<HelloWorldService> _logger;public HelloWorldService(ILogger<HelloWorldService> logger)
 {
 _logger = logger;
 }
```

Let me develop our gRPC service method which is **SayHello**. You can implement the method with using “**override**” keyword.

```
public override Task<HelloResponse> SayHello(HelloRequest request, ServerCallContext context)
 {
 string resultMessage = $”Hello {request.Name}”;var response = new HelloResponse
 {
 Message = resultMessage
 };return Task.FromResult(response);
 }
```

Once we generated proto file as a server gRPC stub Classes, we can override actual operation inside the our service class with overriding the actual service method from proto file.As you can see that, in this method we get the HelloRequest message as a parameter and return to “HelloResponse” message with adding “Hello” keyword.So that means we have implemented gRPC service method in our application.

## **Configure gRPC Service with Registering Asp.Net Dependecy Injection and Configure with Mapping GrpcService in Asp.Net Middleware**

We are going to configure gRPC Service in our aspnet project. So we will apply 2 steps;1- Configure gRPC Service with Registering Asp.Net Dependecy Injection — this is in Startup.ConfigureServices method2- Configure with Mapping GrpcService in Asp.Net Middleware — this is in Startup.Configure method.

First, open Startup.cs and locate the ConfigureServices method;

```
 public void ConfigureServices(IServiceCollection services)
 {
 services.AddGrpc();
 }
```

We added AddGrpc extention method, by this way, it will inject grpc related classes for our application.After that we should open gRPC api protocol for our application. In order to do that we should Map gRPC service into our endpoints.

```
public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
 app.UseEndpoints(endpoints =>
 {
 endpoints.MapGrpcService<HelloWorldService>();
```

As you can see that, we have configured our application as a grpc server. So now we are ready to run application.

**Run the application**Change Run Profile to “GRPCHelloWorld” and Run the applicationSee 5001 https port worked — [https://localhost:5001/](https://localhost:5001/)

**See the Logs**

info: Microsoft.Hosting.Lifetime[0]Now listening on: [https://localhost:5001](https://localhost:5001/)info: Microsoft.Hosting.Lifetime[0]Application started. Press Ctrl+C to shut down.info: Microsoft.Hosting.Lifetime[0]Hosting environment: Developmentinfo: Microsoft.Hosting.Lifetime[0]Content root path: C:\Users\ezozkme\source\repos\grpc-examples\section1\GrpcHelloWorld\GrpcHelloWorldServer

As you can see that port 5001 listening for gRPC calls. Now we can continue to develop client application.

# **Building Product Grpc Microservices for Exposing Product CRUD APIs**

In this section, we are going to perform CRUD operations on Product Grpc microservices. We will exposing apis over the http2 grpc protocol for Product microservices. After that we will consume this grpc service methods from client application so we will develop to client application. This ProductGrpc microservices will be the first part of our big picture, so we will extend microservices with gRPC protocol in order to provide inter-service communication between microservices.

## **Big Picture**

Let’s check out our big picture of the architecture of what we are going to build one by one.

![https://miro.medium.com/max/700/1*B0EtRDOTzkUPHN0E-Ax8HA.png](https://miro.medium.com/max/700/1*B0EtRDOTzkUPHN0E-Ax8HA.png)

In this section, as you can see the selected box, we are going to build Product Grpc Microservices for Exposing Product CRUD APIs with gRPC.

Let me give some brief information, We are going to;

- Create Product Grpc Microservices Project in Grpc Microservices SolutionSet Product Grpc Microservices Database with Entity Framework In-Memory Database in Code-First Approach
- Seeding In-Memory Database with Entity Framework Core for ProductGrpc Microservices
- Developing product.proto ProtoBuf file for Exposing Crud Services in Product Grpc Microservices
- Generate Proto Service Class from Product proto File in Product Grpc Microservices
- Developing ProductService class to Implement Grpc Proto Service Methods in Product Grpc Microservices
- Create Client Console Application for Consuming Product Grpc Microservices
- Consume GetProductAsync Product Grpc Server Method from Client Console Application

Let’s take an action.

## **Create Product Grpc Microservices Project in Grpc Microservices Solution**

We are going to Create Product Grpc Microservices Project in Grpc Microservices Visual Studio Solution.First of all, we are going to create a new solution and project. So this is the first step to start development of our big picture;

Create Asp.Net Grpc Template Project : — HTTPS — https required for http2 tls protocol— Solution name : GrpcMicroservices— Project name : ProductGrpc

Lets Quick check the files again;This project generated by default template of gRPC project;

We can Check the files;

- Nuget Packages
- Protos Folder
- Services Folder
- Startup.cs
- appsettings.json
- launchSettings

And you can see the Run profile of project, they created custom project run profile on https 5001 port.

So, as you can see that, grpc template handled all the things for us that we can proceed with database development of **ProductGrpc** microservices.

## **Developing product.proto ProtoBuf file for Exposing Crud Services in Product Grpc Microservices**

We are going to develop “product.proto” ProtoBuf file for Exposing Crud Services in Product Grpc Microservices.Let’s take an action.

First of all, we are going to start with deleting Greet proto file and GreetService. Of course we should delete from Startup endpoint middleware.Delete greet.protoDelete GreeterServiceComment on Startupendpoints.MapGrpcService<ProductService>();

Now we can create “product.proto” file under the Protos folder.

**Develop proto file**product.proto file;

```
syntax = “proto3”;option csharp_namespace = “ProductGrpc.Protos”;import “google/protobuf/timestamp.proto”;
 import “google/protobuf/empty.proto”;service ProductProtoService {
 rpc GetProduct (GetProductRequest) returns (ProductModel);
 rpc GetAllProducts (GetAllProductsRequest) returns (stream ProductModel);rpc AddProduct (AddProductRequest) returns (ProductModel);
 rpc UpdateProduct (UpdateProductRequest) returns (ProductModel);
 rpc DeleteProduct (DeleteProductRequest) returns (DeleteProductResponse);rpc InsertBulkProduct (stream ProductModel) returns (InsertBulkProductResponse);rpc Test (google.protobuf.Empty) returns (google.protobuf.Empty);
 }message GetProductRequest {
 int32 productId = 1;
 }message GetAllProductsRequest{
 }message AddProductRequest {
 ProductModel product = 1;
 }message UpdateProductRequest {
 ProductModel product = 1;
 }message DeleteProductRequest {
 int32 productId = 1;
 }message DeleteProductResponse {
 bool success = 1;
 }message InsertBulkProductResponse {
 bool success = 1;
 int32 insertCount = 2;
 }message ProductModel{
 int32 productId = 1;
 string name = 2;
 string description = 3;
 float price = 4;
 ProductStatus status = 5;
 google.protobuf.Timestamp createdTime = 6;
 }enum ProductStatus {
 INSTOCK = 0;
 LOW = 1;
 NONE = 2;
 }

```

Ok now, let me explain this proto file;

First, The syntax statement tells the protobuf compiler what syntax we are going to use. it’s important to specify which protobuf version we are using.The second statement is optional and it tells the protobuf compiler to generate C# classes within the specified namespace: ProductGrpc.Protos.

After that, we have Defined a ProductProtoService.The ProductProtoService has crud methods which will be the gRPC sevices. And along with this, it has Message classes.

We have defined generic model with ProductModel message type and use this type as a response objects.For example for rpc GetProduct method we used GetProductRequest message as a request, and use ProductModel as a response.rpc GetProduct (GetProductRequest) returns (ProductModel);

As the same way we have implemented Add/Update/Delete methods.

We have 1 server stream and 1 client stream methods which are GetAllProducts and InsertBulkProduct.

- rpc GetAllProducts (GetAllProductsRequest) returns (stream ProductModel);
- rpc InsertBulkProduct (stream ProductModel) returns (InsertBulkProductResponse);

As you can see that we put stream keyword according to server or client part of the message. We will see the implementation of this methods.We also have enum type for ProductStatus, this will also support in proto files and also generates in consume classes.

So we are defining the ProductProtoService and This messages and services will be generated for accessing from our application. As you can see that, we have developed our contract based product.proto protobuf file. Now we can generate server codes from this file.

## **Developing ProductService class to Implement Grpc Proto Service Methods in Product Grpc Microservices**

We are going to develop ProductService class to Implement Grpc Proto Service Methods in Product Grpc Microservices.Let’s take an action.

First of all, we should create a new class :**— Class Name : ProductService.cs**

After that we should inherit from the ProtoService class which is generated from Visual Studio.

```
public class ProductService : ProductProtoService.ProductProtoServiceBase
```

Ok, now we can start to implement our main methods of product.proto contract file in the ProductGrpc microservices.

— Let me develop;— GetProduct method;

```
public override async Task<ProductModel> GetProduct(GetProductRequest request,
 ServerCallContext context)
 {
 var product = await _productDbContext.Product.FindAsync(request.ProductId);
 if (product == null)
 {
 throw new RpcException(new Status(StatusCode.NotFound, $”Product with ID={request.ProductId} is not found.”));
 }
 var productModel = _mapper.Map<ProductModel>(product);
 return productModel;
 }
```

In this method, we used **_productDbContext** in order to get product data from database. And return productModel object which is our proto message type class.

Also you can see that we should convert to Timestamp for datetime values. Because Timestamp is google welknow types for the datetime objects, we have to cast our datetime object to Timestamp by using FromDateTime method.

```
CreatedTime = Timestamp.FromDateTime(product.CreateTime)
```

Finally, we should not forget to mapping our ProductService class as a gRPC service in Startup class.We are going to Register ProductService into aspnet pipeline to new grpc service.

Go to Startup.cs — Configure

```
app.UseEndpoints(endpoints =>
 {
 endpoints.MapGrpcService<ProductService>();
```

I am not going to develop all details in here, this will be the **Asp.Net Core gRPC Project** which implemented CRUD operations for Product Entity with **Entity Framework In-Memory Database**.

So you can check development of this project into github link of project;

****[aspnetrun/run-aspnet-grpcYou can't perform that action at this time. You signed in with another tab or window. You signed out in another tab or…**
github.com](https://github.com/aspnetrun/run-aspnet-grpc)

# **Building Product WorkerService for Generate and Insert Product to ProductGrpc Microservices**

In this section, we are going to build Product WorkerService for Generate and Insert Product to ProductGrpc Microservices.This application will generate products and add to products into Product db with consuming product grpc services.

## **Big Picture**

Let’s check out our big picture of the architecture of what we are going to build one by one.

![https://miro.medium.com/max/700/1*vcAQc9jSMi3POzdinZu7gA.png](https://miro.medium.com/max/700/1*vcAQc9jSMi3POzdinZu7gA.png)

In this section, as you can see the selected box, we are going to build Product WorkerService for Generate and Insert Product to ProductGrpc Microservices.

Let me give some brief information, we are going to;

- Create Product Worker Service Project in Grpc Microservices Solution
- Add Connected Service Proto to Product Worker Service Project for Consuming ProductGrpc Microservice
- Set Configuration with appsettings.json file into Product Worker Service Project
- Consume Product Grpc Server Method From Product Worker Client Application
- Focus on Big Picture and Product Worker Add Products to Product Grpc Server
- Generate Products with ProductFactory class in Product Worker Service Application
- Logging in Product Worker Service Client Application and Product Grpc Server Application

Let’s take an action.

## **Create Product Worker Service Project in Grpc Microservices Solution**

We are going to Create Product Worker Service Project in Grpc Microservices Visual Studio Solution.Worker service will work in a time interval and provide to load ProductGrpc microservices.

First of all, we are going to create a new project. So we will follow our big picture of Product microservices.

Create new “**Worker Service**” template :— Solution name : GrpcMicroservices— Project name : ProductWorkerService

Let me Explain worker project;This project type is a typical microsoft service projects which provide to work on background.But it is fully integrated with .net environment like Background class implementation, built-in dependency injection, Configuration , Logging and so on.

## **Consume Product Grpc Server Method From Product Worker Client Application**

We are going to Consume Product Grpc Server Method From Product Worker Client Application.Let’s take an action.

First of all, we are going to open Worker.cs — ExecuteAsync method of Worker application :Go to Worker.cs — ExecuteAsync method

Develop consume method in here;

```
protected override async Task ExecuteAsync(CancellationToken stoppingToken)
 {
 while (!stoppingToken.IsCancellationRequested)
 {
 _logger.LogInformation(“Worker running at: {time}”, DateTimeOffset.Now);

 try
 {
 using var channel = GrpcChannel.ForAddress(_config.GetValue<string>(“WorkerService:ServerUrl”));
 var client = new ProductProtoService.ProductProtoServiceClient(channel);_logger.LogInformation(“AddProductAsync started..”);
 var addProductResponse = await client.AddProductAsync(await _factory.Generate());
 _logger.LogInformation(“AddProduct Response: {product}”, addProductResponse.ToString());
 }
 catch (Exception exception)
 {
 _logger.LogError(exception.Message);
 throw exception;
 }await Task.Delay(_config.GetValue<int>(“WorkerService:TaskInterval”), stoppingToken);
 }
 }
```

In this code, first of all we get the server url from the configuration and create client object with using proto generated classes.After that consume client GetProductAsync method gen get the product.

# **Building Shopping Cart Grpc Server Application for Storing Products into Cart**

In this section, we are going to build Shopping Cart Grpc Server Application for Storing Products into Cart.This application will the gRPC server application for Shopping Cart and the items.

## **Big Picture**

Let’s check out our big picture of the architecture of what we are going to build one by one.

![https://miro.medium.com/max/700/1*pHUMGCTPkTOBbCOQU-p-1g.png](https://miro.medium.com/max/700/1*pHUMGCTPkTOBbCOQU-p-1g.png)

In this section, as you can see the selected box, we are going to build Shopping Cart Grpc Server Application for Storing Products into Cart.

Let me give some brief information, We are going to;

- Create Shopping Cart Grpc Microservices Project in Grpc Microservices Solution
- Set Shopping Cart Grpc Microservices Database with Entity Framework In-Memory Database in Code-First Approach
- Seeding In-Memory Database with Entity Framework Core for ShoppingCartGrpc Microservices
- Developing product.proto ProtoBuf file for Exposing Crud Services in ShoppingCart Grpc Microservices
- Generate Proto Service Class from ShoppingCart proto File in ShoppingCart Grpc Microservices
- Developing ShoppingCartService class to Implement Grpc Proto Service Methods in ShoppingCart Grpc Microservices
- Implementing AutoMapper into ShoppingCartService Class of ShoppingCart Grpc Microservices
- Developing AddItemIntoShoppingCart Client Stream Server Method in the ShoppingCartService class

Let’s take an action.

## **Create Shopping Cart Grpc Microservices Project in Grpc Microservices Solution**

We are going to Create Shopping Cart Grpc Microservices Project in Grpc Microservices Visual Studio Solution.

We are going to create a new Project for Shopping Cart Grpc Server Application

Create Asp.Net Grpc Template Project : — HTTPS — https required for http2 tls protocol— Solution name : GrpcMicroservices— Project name : ShoppingCartGrpc

## **Developing product.proto ProtoBuf file for Exposing Crud Services in ShoppingCart Grpc Microservices**

we are going to develop “product.proto” ProtoBuf file for Exposing Crud Services in ShoppingCart Grpc Microservices.

Now we can create “ShoppingCart.proto” file under the Protos folder.

Develop proto filedevelop ShoppingCart.proto file

```
syntax = “proto3”;option csharp_namespace = “ShoppingCartGrpc.Protos”;service ShoppingCartProtoService {rpc GetShoppingCart (GetShoppingCartRequest) returns (ShoppingCartModel);rpc CreateShoppingCart (ShoppingCartModel) returns (ShoppingCartModel);

 rpc AddItemIntoShoppingCart (stream AddItemIntoShoppingCartRequest) returns (AddItemIntoShoppingCartResponse);
 rpc RemoveItemIntoShoppingCart (RemoveItemIntoShoppingCartRequest) returns (RemoveItemIntoShoppingCartResponse);
 }message GetShoppingCartRequest {
 string username = 1;
 }message AddItemIntoShoppingCartRequest{
 string username = 1;
 string discountCode = 2;
 ShoppingCartItemModel newCartItem = 3;
 }message AddItemIntoShoppingCartResponse{
 bool success = 1;
 int32 insertCount = 2;
 }message RemoveItemIntoShoppingCartRequest {
 string username = 1;
 ShoppingCartItemModel removeCartItem = 2;
 }message RemoveItemIntoShoppingCartResponse {
 bool success = 1;
 }message ShoppingCartModel {
 string username = 1;
 repeated ShoppingCartItemModel cartItems = 2;
 }message ShoppingCartItemModel {
 int32 quantity = 1;
 string color = 2;
 float price = 3;
 int32 productId = 4;
 string productname = 5;
 }
```

First, The syntax statement tells the protobuf compiler what syntax we are going to use. it’s important to specify which protobuf version we are using.The second statement is optional and it tells the protobuf compiler to generate C# classes within the specified namespace: ProductGrpc.Protos.

After that, we have Defined a ShoppingCartProtoService.The ShoppingCartProtoService has get-create and add item into sc methods which will be the gRPC sevices. And along with this, it has Message classes.

We have defined generic model with ShoppingCartModel and ShoppingCartItemModel message type and use this type as a request and response objects.For example for rpc CreateShoppingCart method we used ShoppingCartModel message as a request and response.rpc CreateShoppingCart (ShoppingCartModel) returns (ShoppingCartModel);

As the same way we have implemented Add/Remove ItemIntoShoppingCart methods.

We have 1 client stream methods which is AddItemIntoShoppingCart, this will use when adding items into sc.

rpc AddItemIntoShoppingCart (stream AddItemIntoShoppingCartRequest) returns (AddItemIntoShoppingCartResponse);

As you can see that we put stream keyword in the request part of the message. We will see the implementation of this methods.

So we are defining the ShoppingCartProtoService and This messages and services will be generated for accessing from our application.

## **Developing ShoppingCartService class to Implement Grpc Proto Service Methods in ShoppingCart Grpc Microservices**

We are going to develop ShoppingCartService class to Implement Grpc Proto Service Methods in ShoppingCart Grpc Microservices.

First of all, we should create a new class : Under “Services” Folder :— Class Name : ShoppingCartService.cs

Now we can ready to override proto methods,— write “override” and see overridable methods.

```
public override async Task<ShoppingCartModel> GetShoppingCart(GetShoppingCartRequest request, ServerCallContext context)
 {
 var shoppingCart = await _shoppingCartDbContext.ShoppingCart.FirstOrDefaultAsync(s => s.UserName == request.Username);
 if (shoppingCart == null)
 {
 throw new RpcException(new Status(StatusCode.NotFound, $”ShoppingCart with UserName={request.Username} is not found.”));
 }var shoppingCartModel = _mapper.Map<ShoppingCartModel>(shoppingCart);
 return shoppingCartModel;
 }
```

In this method, we used _productDbContext in order to get product data from database. And return productModel object which is our proto message type class.

But in order to create ShoppingCartModel, its good to use AutoMapper.

CreateShoppingCart method;

```
public override async Task<ShoppingCartModel> CreateShoppingCart(ShoppingCartModel request, ServerCallContext context)
 {
 var shoppingCart = _mapper.Map<ShoppingCart>(request);var isExist = await _shoppingCartDbContext.ShoppingCart.AnyAsync(s => s.UserName == shoppingCart.UserName);
 if (isExist)
 {
 _logger.LogError(“Invalid UserName for ShoppingCart creation. UserName : {userName}”, shoppingCart.UserName);
 throw new RpcException(new Status(StatusCode.NotFound, $”ShoppingCart with UserName={request.Username} is already exist.”));
 }_shoppingCartDbContext.ShoppingCart.Add(shoppingCart);
 await _shoppingCartDbContext.SaveChangesAsync();_logger.LogInformation(“ShoppingCart is successfully created.UserName : {userName}”, shoppingCart.UserName);var shoppingCartModel = _mapper.Map<ShoppingCartModel>(shoppingCart);
 return shoppingCartModel;
 }
```

In this method, we used _shoppingCartDbContext in order to get sc data from database. And return shoppingCartModel object which is our proto message type class.We checked the ShoppingCart with username, if already exist then return an error. If not exist we have created new sc with no items and return to model class.

## **Developing AddItemIntoShoppingCart Client Stream Server Method in the ShoppingCartService class**

We are going to develop AddItemIntoShoppingCart Client Stream Server Method in the ShoppingCartService class.This method will be client stream method that data comes from the ShoppingCart Worker Client application in a stream format and this data will insert shopping cart and items data in ShoppingCart Grpc Microservices with stream format.

Now we can ready to override proto methods,Ok, now we can start to implement our Client Stream Server Method which is — AddItemIntoShoppingCart— Let me develop;

Go to ShoppingCartService.cs— AddItemIntoShoppingCart method;

```
[AllowAnonymous]
 public override async Task<AddItemIntoShoppingCartResponse> AddItemIntoShoppingCart(IAsyncStreamReader<AddItemIntoShoppingCartRequest> requestStream, ServerCallContext context)
 {
 while (await requestStream.MoveNext())
 {
 // Get sc if exist or not
 // Check item if exist in sc or not
 // if item exist +1 quantity
 // if not exist add new item into sc
 // check discount and set the item price

 var shoppingCart = await _shoppingCartDbContext.ShoppingCart.FirstOrDefaultAsync(s => s.UserName == requestStream.Current.Username);
 if (shoppingCart == null)
 {
 throw new RpcException(new Status(StatusCode.NotFound, $”ShoppingCart with UserName={requestStream.Current.Username} is not found.”));
 }var newAddedCartItem = _mapper.Map<ShoppingCartItem>(requestStream.Current.NewCartItem);
 var cartItem = shoppingCart.Items.FirstOrDefault(i => i.ProductId == newAddedCartItem.ProductId);
 if(null != cartItem)
 {
 cartItem.Quantity++;
 }
 else
 {
 // GRPC CALL DISCOUNT SERVICE — check discount and set the item price
 var discount = await _discountService.GetDiscount(requestStream.Current.DiscountCode);
 newAddedCartItem.Price -= discount.Amount;shoppingCart.Items.Add(newAddedCartItem);
 }
 }var insertCount = await _shoppingCartDbContext.SaveChangesAsync();var response = new AddItemIntoShoppingCartResponse
 {
 Success = insertCount > 0,
 InsertCount = insertCount
 };return response;
 }
```

Basically, in this code, we get the request stream of shopping cart items and add to ef.core _shoppingCartDbContext Product collection since the stream is finished. We have iterated IAsyncStreamReader object.

— But in the while stream item, we have some logics that we have developed;

// Get sc if exist or not// Check item if exist in sc or not// if item exist +1 quantity// if not exist add new item into sc// check discount and set the item price

We used _shoppingCartDbContext in order to get sc data from database.And return shoppingCartModel object which is our proto message type class.We checked the ShoppingCart with username, if already exist then return an error. If not exist we have created new sc with no items and return to model class.Then we we checked the sc item with productId, if product is already existing then increase the quantity, if not exist then we should get the discount value with consuming Discount Service with gRPC.

![https://miro.medium.com/max/700/1*2DuT87YXIm1ioCI48UhmeQ.png](https://miro.medium.com/max/700/1*2DuT87YXIm1ioCI48UhmeQ.png)

So we should also develop DiscountGrpc project as a server of Discounts. We will communicate with Discount service over the snyc grpc call. I am not going to develop in here but you can check the code of DiscountGrpc project, it is similar to ProductGrpc service project. The idea is that to be owner of Discount data and expose gRPC apis in order to access Discount data from ShoppingCartGrpc project.

# **Building ShoppingCart WorkerService for Retrieve Products and Add to ShoppingCart with consuming ProductGrpc and ShoppingCartGrpc Microservices**

We are going to build ShoppingCart WorkerService for Retrieve Products and Add to ShoppingCart with consuming ProductGrpc and ShoppingCartGrpc Microservices.This application will includes all logics and consume both Product and Shoppingcart in order to perform our business logic.

## **Big Picture**

Let’s check out our big picture of the architecture of what we are going to build one by one.

![https://miro.medium.com/max/700/1*H5bXaLpCUdFX4hlti7ybCw.png](https://miro.medium.com/max/700/1*H5bXaLpCUdFX4hlti7ybCw.png)

In this section, as you can see the selected box, we are going to build ShoppingCart WorkerService for Retrieve Products and Add to ShoppingCart with consuming ProductGrpc and ShoppingCartGrpc Microservices.

Let me give some brief information, We are going to;

- Create ShoppingCart Worker Service Project in Grpc Microservices Solution
- Add Connected Services Proto to ShoppingCart Worker Service Project for Consuming ProductGrpc and ShoppingCartGrpc Microservices
- Set Configuration with appsettings.json file into ShoppingCart Worker Service Project
- Consume Product and ShoppingCart Grpc Server Method From ShoppingCart Worker Client Application
- Focus on Big Picture — ShoppingCart Worker — Get Products with Server Stream and Add Items to Shopping Cart with Client Stream
- Running All Grpc Server Microservices with Product and ShoppingCart Worker Service

Let’s take an action.

## **Consume Product and ShoppingCart Grpc Server Method From ShoppingCart Worker Client Application**

we are going to Consume Product and ShoppingCart Grpc Server Method From ShoppingCart Worker Client Application.

First of all, we are going to open Worker.cs — ExecuteAsync method of Worker application :Go to Worker.cs — ExecuteAsync method

Develop consume method in here;

//Create SC if not exist//Retrieve products from product grpc with server stream//Add sc items into SC with client stream

Worker.cs — ExecuteAsync

```
protected override async Task ExecuteAsync(CancellationToken stoppingToken)
 {
 while (!stoppingToken.IsCancellationRequested)
 {
 _logger.LogInformation(“Worker running at: {time}”, DateTimeOffset.Now);//0 Get Token from IS4
 //1 Create SC if not exist
 //2 Retrieve products from product grpc with server stream
 //3 Add sc items into SC with client stream//0 Get Token from IS4
 var token = await GetTokenFromIS4();//1 Create SC if not exist
 using var scChannel = GrpcChannel.ForAddress(_config.GetValue<string>(“WorkerService:ShoppingCartServerUrl”));
 var scClient = new ShoppingCartProtoService.ShoppingCartProtoServiceClient(scChannel);var scModel = await GetOrCreateShoppingCartAsync(scClient, token);// open sc client stream
 using var scClientStream = scClient.AddItemIntoShoppingCart();//2 Retrieve products from product grpc with server stream
 using var productChannel = GrpcChannel.ForAddress(_config.GetValue<string>(“WorkerService:ProductServerUrl”));
 var productClient = new ProductProtoService.ProductProtoServiceClient(productChannel);_logger.LogInformation(“GetAllProducts started..”);
 using var clientData = productClient.GetAllProducts(new GetAllProductsRequest());
 await foreach (var responseData in clientData.ResponseStream.ReadAllAsync())
 {
 _logger.LogInformation(“GetAllProducts Stream Response: {responseData}”, responseData);//3 Add sc items into SC with client stream
 var addNewScItem = new AddItemIntoShoppingCartRequest
 {
 Username = _config.GetValue<string>(“WorkerService:UserName”),
 DiscountCode = “CODE_100”,
 NewCartItem = new ShoppingCartItemModel
 {
 ProductId = responseData.ProductId,
 Productname = responseData.Name,
 Price = responseData.Price,
 Color = “Black”,
 Quantity = 1
 }
 };await scClientStream.RequestStream.WriteAsync(addNewScItem);
 _logger.LogInformation(“ShoppingCart Client Stream Added New Item : {addNewScItem}”, addNewScItem);
 }
 await scClientStream.RequestStream.CompleteAsync();var addItemIntoShoppingCartResponse = await scClientStream;
 _logger.LogInformation(“AddItemIntoShoppingCart Client Stream Response: {addItemIntoShoppingCartResponse}”, addItemIntoShoppingCartResponse);await Task.Delay(_config.GetValue<int>(“WorkerService:TaskInterval”), stoppingToken);
 }
 }
```

In this code, first of all we get or create the shopping cart with sc grpc call that can be add or remove items.After that Retrieve products from product grpc with server stream.Before reading products we open sc channel in order to ready for client streaming.And while reading product stream, performing Add sc items into SC operation with client stream.Of course we logged for all steps into this method.

As you can see that, we have developed our sc worker service application with consuming both Product and SC Grpc server applications.

# **Authenticate gRPC Services with IdentityServer4 Protect ShoppingCartGrpc Method with OAuth 2.0 and JWT Bearer Token**

We are going to Authenticate gRPC Services with IdentityServer4 Protect ShoppingCartGrpc Method with OAuth 2.0 and JWT Bearer Token.This application will be the security layer of our gRPC server applications.

## **Big Picture**

Let’s check out our big picture of the architecture of what we are going to build one by one.

![https://miro.medium.com/max/700/1*-3iy9vHOkqMGtYKfLx1szQ.png](https://miro.medium.com/max/700/1*-3iy9vHOkqMGtYKfLx1szQ.png)

In this section, as you can see the selected box, we are going to Authenticate gRPC Services with IdentityServer4 Protect ShoppingCartGrpc Method with OAuth 2.0 and JWT Bearer Token.

Let me give some brief information, We are going to;

- Building IdentityServer4 Authentication Microservices for Securing ShoppingCartGrpc Server Application
- Configure IdentityServer4 with Adding Config Class for Clients, Resources, Scopes and TestUsers
- Securing ShoppingCart Grpc Services with IdentityServer4 OAuth 2.0 and JWT Bearer Token
- Testing to Access ShoppingCart Grpc Services without Token
- Get Token From IS4 and Make Grpc Call to ShoppingCart Grpc Services with JWT Token Header from ShoppingCart Worker Service
- Set Token to Grpc Header when Call to ShoppingCart Grpc Services
- Run Entire Applications and See the Big Picture in Your Local

Let’s take an action.

## **Building and Configuring IdentityServer4 Authentication Microservices for Securing ShoppingCartGrpc Server Application**

We are going to build standalone IdentityServer4 Authentication Microservices for Securing ShoppingCartGrpc Server Application.This will be the Authentication Server that can be generate and validate the jwt token.

First of all, we are going to create a new project. So we will follow our big picture of IdentityServer microservices.

Create new Folder — “Authentication”Create Asp.Net Core Empty Project :Right Click — Add new Empty Web App — HTTPS — n : IdentityServer

Right Click Manage Nuget Packages :Browse IdentityServerInstall IdentityServer4

```
Go to Startup.cs and Configure Services
 Register into DI
 public void ConfigureServices(IServiceCollection services)
 {
 services.AddIdentityServer();
 }Add pipeline
 app.UseRouting();
 app.UseIdentityServer();
```

## **Configure IdentityServer4 with Adding Config Class for Clients, Resources, Scopes and TestUsers**

We are going to add Config Class for Clients, Resources, Scopes and TestUsers definitions on IdentityServer4.

First of all, we are going to do is create a new Config class. This class will consist of different configurations related to Users, Clients, IdentityResources, etc. So, let’s add them one by one.

```
public class Config
 {
 public static IEnumerable<Client> Clients =>
 new Client[]
 {
 new Client
 {
 ClientId = “ShoppingCartClient”,
 AllowedGrantTypes = GrantTypes.ClientCredentials,
 ClientSecrets =
 {
 new Secret(“secret”.Sha256())
 },
 AllowedScopes = { “ShoppingCartAPI” }
 }
 };public static IEnumerable<ApiScope> ApiScopes =>
 new ApiScope[]
 {
 new ApiScope(“ShoppingCartAPI”, “Shopping Cart API”)
 };public static IEnumerable<ApiResource> ApiResources =>
 new ApiResource[]
 {
 };public static IEnumerable<IdentityResource> IdentityResources =>
 new IdentityResource[]
 {
 };public static List<TestUser> TestUsers =>
 new List<TestUser>
 {
 };
 }
```

And finally, we should configure IdentityServer as per our protected resource. That means we should summarize the identity server configuration.

Configuring IdentityServerStartup.cspublic void ConfigureServices(IServiceCollection services){services.AddIdentityServer().AddInMemoryClients(Config.Clients).AddInMemoryApiScopes(Config.ApiScopes).AddDeveloperSigningCredential();}

## **Securing ShoppingCart Grpc Services with IdentityServer4 OAuth 2.0 and JWT Bearer Token**

We are going to Secure ShoppingCart Grpc Services with IdentityServer4 OAuth 2.0 and JWT Bearer Token.

First of all, we are going to locate “**ShoppingCartGrpc**” project again.Go to “**ShoppingCartGrpc**”

Adding a Nuget Dependency into ShoppingCartGrpc

**package Microsoft.AspNetCore.Authentication.JwtBearer**

After that, in order to activate jwt bearer token athentication, we should register JWT Authentication into asp.net core dependency injection method. In the Startup.cs — ConfigureServices method, we should register and configure jwt authentication with adding service collection.

Add the Authentication services to DI (dependency injection)

```
public void ConfigureServices(IServiceCollection services)

 services.AddAuthentication(“Bearer”)
 .AddJwtBearer(“Bearer”, options =>
 {
 options.Authority = “https://localhost:5005”;
 options.TokenValidationParameters = new TokenValidationParameters
 {
 ValidateAudience = false
 };
 });services.AddAuthorization();
```

We use the AddAuthentication method to add authentication services to the dependency-injection of our web api project. Moreover, we use the AddJwtBearer method to configure support for our Authorization Server.In that method, we specify thatAuthority — This address refers to our IdentityServer in order to use when sending OpenID Connect callsTokenValidationParameters — ValidateAudience is that there is a Audience value for received OpenID Connect tokens, but we don’t require to check validation.

And finally, we should;

**Authorize the GRPC Service** class which is ShoppingCartService in ShoppingCartGrpc project. By this way we can protect our api resources.

```
[Authorize]
 public class ShoppingCartService : ShoppingCartProtoService.ShoppingCartProtoServiceBase
```

— So we have finished to development of protect ShoppingCartGrpc Services with IS4 by getting and validating jwt token.

## **Get Token From IS4 and Make Grpc Call to ShoppingCart Grpc Services with JWT Token Header from ShoppingCart Worker Service**

We are going to Get Token From IS4 and Make Grpc Call to ShoppingCart Grpc Services with JWT Token Header from ShoppingCart Worker Service.So we should go to ShoppingCart Worker Service.

First of all, we are going to locate “ShoppingCartWorkerService” project again.Go to “**ShoppingCartWorkerService**”

Adding a Nuget Dependency into ShoppingCartWorkerServiceAdd the IdentityModel NuGet package to your client.package IdentityModel

Add New Step into our logic and adding new method for getting token;

Go to Worker.cs — ExecuteAsync

```
++ //0 Get Token from IS4
 //1 Create SC if not exist
 //2 Retrieve products from product grpc with server stream
 //3 Add sc items into SC with client stream//0 Get Token from IS4
 var token = await GetTokenFromIS4();Let me develop the get token method;private async Task<string> GetTokenFromIS4()
 {
 // discover endpoints from metadata
 var client = new HttpClient();
 var disco = await client.GetDiscoveryDocumentAsync(“https://localhost:5005”);
 if (disco.IsError)
 {
 Console.WriteLine(disco.Error);
 return string.Empty;
 }// request token
 var tokenResponse = await client.RequestClientCredentialsTokenAsync(new ClientCredentialsTokenRequest
 {
 Address = disco.TokenEndpoint,ClientId = “ShoppingCartClient”,
 ClientSecret = “secret”,
 Scope = “ShoppingCartAPI”
 });if (tokenResponse.IsError)
 {
 Console.WriteLine(tokenResponse.Error);
 return string.Empty;
 }return tokenResponse.AccessToken;
 }
```

In this method, first of all, we get the discover endpoints from metadata with giving IS4 server url in GetDiscoveryDocumentAsync method. This methods comes from the IdentityModel package.After that request the token from the client object calling with ClientCredentialsTokenRequest. This request parameters should be same as the IdentityServer — Config class. Because it will evaluate the token request by that definitions. You can see the IdenttiyServer — Config.cs

And finally, it will return us a tokenResponse that can be access the token with tokenResponse.AccessToken.

I have try to implement **main logics** of our **big picture of the application**. We have discussed all microservices on the project.

You can check the whole source code of these developments into **github link** of project;

****[aspnetrun/run-aspnet-grpcYou can’t perform that action at this time. You signed in with another tab or window. You signed out in another tab or…**
github.com](https://github.com/aspnetrun/run-aspnet-grpc)

# **Step by Step Development w/ Course**

![https://miro.medium.com/max/1400/1*_NadT2xrfl_47szBHh2Q1w.png](https://miro.medium.com/max/1400/1*_NadT2xrfl_47szBHh2Q1w.png)

**[I have just published a new course — Using gRPC in Microservices Communication with .Net 5.](https://www.udemy.com/course/using-grpc-in-microservices-communication-with-net-5/?couponCode=OCTOBER2021)**In the course, we are going to build a **high-performance gRPC Inter-Service Communication between backend microservices with .Net 5 and Asp.Net5.**

# **References**

[https://grpc.io/docs/what-is-grpc/introduction/](https://grpc.io/docs/what-is-grpc/introduction/)[https://grpc.io/docs/what-is-grpc/core-concepts/](https://grpc.io/docs/what-is-grpc/core-concepts/)[https://grpc.io/docs/languages/csharp/basics/](https://grpc.io/docs/languages/csharp/basics/)[https://developers.google.com/protocol-buffers/docs/proto3#simple](https://developers.google.com/protocol-buffers/docs/proto3#simple)

[https://auth0.com/blog/implementing-microservices-grpc-dotnet-core-3/](https://auth0.com/blog/implementing-microservices-grpc-dotnet-core-3/)[https://www.jetbrains.com/dotnet/guide/tutorials/dotnet-days-online-2020/build-a-highly-performant-interservice-communication-with-grpc-for-asp-net-core/](https://www.jetbrains.com/dotnet/guide/tutorials/dotnet-days-online-2020/build-a-highly-performant-interservice-communication-with-grpc-for-asp-net-core/)[https://www.ndcconferences.com/slot/modern-distributed-systems-with-grpc-in-asp-net-core-3](https://www.ndcconferences.com/slot/modern-distributed-systems-with-grpc-in-asp-net-core-3)

[http://www.canertosuner.com/post/grpc-nedir-net-core-grpc-service-olusturma](http://www.canertosuner.com/post/grpc-nedir-net-core-grpc-service-olusturma)[https://medium.com/@berkemrecabuk/grpc-net-core-ile-client-server-streaming-2824e2082a98](https://medium.com/@berkemrecabuk/grpc-net-core-ile-client-server-streaming-2824e2082a98)

[https://devblogs.microsoft.com/aspnet/grpc-performance-improvements-in-net-5/](https://devblogs.microsoft.com/aspnet/grpc-performance-improvements-in-net-5/)

[https://docs.microsoft.com/en-us/dotnet/architecture/cloud-native/grpc](https://docs.microsoft.com/en-us/dotnet/architecture/cloud-native/grpc)[https://medium.com/@akshitjain_74512/inter-service-communication-with-grpc-d815a561e3a1](https://medium.com/@akshitjain_74512/inter-service-communication-with-grpc-d815a561e3a1)