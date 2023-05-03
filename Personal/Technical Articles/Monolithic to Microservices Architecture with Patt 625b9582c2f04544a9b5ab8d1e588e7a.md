# Monolithic to Microservices Architecture with Patterns & Best Practices

Article Link: https://medium.com/design-microservices-architecture-with-patterns/monolithic-to-microservices-architecture-with-patterns-best-practices-a768272797b2
Author: Mehmet Özkaya
Date Added: August 25, 2021 9:43 AM
Tag: .NET, Design-Patterns, Microservices

In this article, we’re going to learn **how to Design Microservices Architecture** with using **Design Patterns, Principles** and the **Best Practices.** We will using the right architecture design patterns and techniques.

By the end of the article, you will Learn how to **handle millions of request** with designing system for **high availability, high scalability, low latency**, and **resilience** to network failures on microservices distributed architectures.

![https://miro.medium.com/max/1400/0*6j5agId6R0Mw5i8y.png](https://miro.medium.com/max/1400/0*6j5agId6R0Mw5i8y.png)

Event-Driven Architecture

This course is will be the **journey of software architecture design** with step by step evolving architecture monolithic to event driven microservices.

We will start the basics of software architecture with designing **e-commerce monolithic architecture** that handles low amount of requests.

![https://miro.medium.com/max/1400/1*DWU3V32PqcnbKNKBBDYe7w.png](https://miro.medium.com/max/1400/1*DWU3V32PqcnbKNKBBDYe7w.png)

Journey of Design Architectures

After that step by step **evolves** the architecture with

- **Layered Architecture**
- **SOA**
- **Microservices**
- and lastly **Event Driven Microservices Architectures**

with designing together that handle millions of requests.

# **Step by Step Design Architectures w/ Course**

![https://miro.medium.com/max/1400/1*McvB7aYhVUhcRlDI-Z9G1A.png](https://miro.medium.com/max/1400/1*McvB7aYhVUhcRlDI-Z9G1A.png)

**[I have just published a new course — Design Microservices Architecture with Patterns & Principles.](https://www.udemy.com/course/design-microservices-architecture-with-patterns-principles/?couponCode=DESIGN)**

In this course, we’re going to learn **how to Design Microservices Architecture** with using **Design Patterns, Principles** and the **Best Practices.** We will start with designing **Monolithic** to **Event-Driven Microservices** step by step and together using the right architecture design patterns and techniques.

# **Article Flow**

In the article flow will be the both theoretical and practical information;

- We will learn a specific pattern, **why** and **where** we should **use**
- After that we will see the **Reference architectures** that applied these patterns
- After that we will design our architecture with applying this newly learned pattern with together
- And lastly we will decide which **Technologies** can be choices for that architectures.

So we will **Iterate** and **Evolves** architecture Monolithic to **Event-Driven Microservices Architectures.**

# **Evolve architecture**

We will evolve these architectures as per questions

- How we can scale the application ?
- How many request that we need to handle in our application ?
- how many second Latency is acceptable for our arch ?

So we evolve these questions according to;

![https://miro.medium.com/max/1400/1*bwhc_M2sdO4_wuLT3DszSQ.png](https://miro.medium.com/max/1400/1*bwhc_M2sdO4_wuLT3DszSQ.png)

Scalability and reliability are measures of how well your application can be served to end-users. If our e-commerce application can serve millions of users without noticeable downtime, then we can say the system is highly scalable and reliable. **Scalability** and **availability** are probably the major factors for designing good architecture.

Scalability = e-commerce application should able to serve millions of users

Availability = e-commerce application should available 24/7

Maintainability = e-commerce application should develop several years

Efficiency = e-commerce application should response acceptable latency like < 2 sec — short response latency

## **Request per Second and Acceptable Latency**

Ok, lets talk about acceptable latency,how we can make our application for acceptable latency, if our application get use more and more users ?

Please see the table;

![https://miro.medium.com/max/1400/1*4s3R5WrinrWhIf7onqZ0-g.png](https://miro.medium.com/max/1400/1*4s3R5WrinrWhIf7onqZ0-g.png)

As you can see in the table, we will start a small e-commerce application that get only 2K concurrent user and gets 500 request per second.And we will design our e-commerce architecture as per these expected volumes.After that, when our business grow and grow, it will required more resources to accommodate bigger request counts, and we will see how we can evolve our architecture as per these numbers.

# **Monolithic Architecture**

There are many approaches and patterns that evolved over decades of software development, and all have their own benefits and challenges.

So we will start with understanding existing approaches to architecting our e-commerce application and evolve and shifting to the cloud.In order to understand cloud-native microservices, we need to understand what are monolithic applications and how led us to move from monolithic to microservices.

![https://miro.medium.com/max/1400/1*HuM5OTnmQNUC2oIwiOn22A.png](https://miro.medium.com/max/1400/1*HuM5OTnmQNUC2oIwiOn22A.png)

When it comes to legacy applications, we can say that most of legacy applications are mainly implemented as a monolithic architecture.

If all the functionalities of a project exists in a single codebase,then that application is known as monolithic application. In the monolith pattern, everything from user interface, business codes and database calls is included in the same codebase.

All application concerns are contained in a single big deployment.Even the monolithic applications can design in different layers like presentation, business and data layer and then deploy that codebase as single jar/war file.

There are several advantages to the monolith approach that we will discuss them in the upcoming videos. But let me say some main advantages and disadvantages here.

Since it is a single code base, its easy to pull and get started to project.Since project structure in 1 project and easy to debug business interactions across different modules.

Unfortunately, the monolith architecture has lots of disadvantages, we can say that;

- It becomes too large in code size with time thats why its really difficult to manage.
- Difficult to work in parallel in the same code base.
- Hard to implement new features on legacy big monolithic applications
- Any change, requires deploying a new version of the entire application.

and so on..

As you can see that we understand Monolithic Architecture.

## **When to use Monolithic Architecture**

Even monolithic architecture has lots of disadvantages, if you are building small application, still monolithic architecture is one of the best architecture that you can apply for your projects. Because, In many ways, monolithic apps are straightforward.

They’re straightforward to:BuildTestDeployTroubleshootScale vertically (scale up)

is very easy and fast.

It is simple to develop relative to microservices where skilled developers are required in order to identify and develop the services. It is Easier to deploy as only a single jar/war file is deployed.

# **Design the Monolithic Architecture**

In this section we are going to design our e-commerce application with the monolithic architecture step by step.We will iterate the architecture design one by one as per requirements.

We should always start with writing down FRs (Functional Requirements) and NFRs (Non-Functional Requirements).

## **Functional Requirements**

- List products
- Filter products as per brand and categories
- Put products into the shopping cart
- Apply coupon for discounts and see the total cost all for all of the items in shopping cart
- Checkout the shopping cart and create an order
- List my old orders and order items history

## **Non-Functional Requirements**

- Scalability
- Increase Concurrent User

Also, its good to add principles in our picture in order to remember them always.

## **Principles**

- KISS
- YAGNI

We are going to consider these principles when design our architecture.

![https://miro.medium.com/max/1400/1*7qfNAGcYiHfuJvAhlArRkw.png](https://miro.medium.com/max/1400/1*7qfNAGcYiHfuJvAhlArRkw.png)

As you can see that we have designed our e-commerce application with Monolithic Architecture.

We have added the big e-commerce box what is the components of our e-commerce application; Shop UI, Catalog Service, SC Service, Discount Service, Order Service. As you can see that all modules of this traditional web application are single artifacts in the container.

This monolithic application has a massive codebase that includes all modules. If you introduce new modules to this application, you have to make changes to the existing code and then deploy the artifact with a different code to the Tomcat server. We followed our KISS principle that is keep it simple.And we will refactor our design as per requirements and step by step iterate together.

## **Scalability of Monolithic Architecture**

As you can see the image, we have scale the Monolithic Architecture with horizontal scaling by adding 2 more application servers and put a Load Balancer on front of the Monolithic application between client and the e-commerce application.

In order to provide scalability on Monolithic architecture. We need to increate E-Commerce application server. And put the Load balancer on front of our application.

Basically, Load Balancer will accommodate the request and send request to our e-commerce application servers with using consistent hashing algorithms. This will provide to load equally for the servers.

## **Adapting Technology Stack**

We are going to Technology choices — Adapting Technology Stack.

![https://miro.medium.com/max/1400/1*HvO5sB0BNRkeG0iVfQ7zoQ.png](https://miro.medium.com/max/1400/1*HvO5sB0BNRkeG0iVfQ7zoQ.png)

As you can see the image, we have picked the potential options for our e-commerce monolithic application. NGINX is very good option for Load Balancing and also Java — Oracle is standart implementations of this kind of applications.

# **Microservices Architecture**

Microservice are small business services that can work together and can be deployed autonomously / independently.

> From Martin Fowlers Microservices article;The microservice architectural style is an approach to developing a single application as a suite of small services, each running in its own process and communicating with lightweight mechanisms, often an HTTP or gRPC API.
> 

So we can say that, Microservices architecture is a cloud native architectural approach in which applications composed of many loosely coupled and independently deployable smaller components.

**Microservices**— have their own technology stack, included the database and data management model;— communicate to each other over a combination of REST APIs, event streaming, and message brokers;— are organized by business capability, with the line separating services often referred to as a bounded context.we will also see how we can decouple microservices with bounded context in the upcoming sections.

## **Microservices Characteristics**

Microservices are small, independent, and loosely coupled. A single small team of developers can write and maintain a service. Each service is a separate codebase, which can be managed by a small development team.

Services can be deployed independently. A team can update an existing service without rebuilding and redeploying the entire application.

Services are responsible for persisting their own data or external state. This differs from the traditional model, where a separate data layer handles data persistence.

## **Benefits of Microservices Architecture**

Agility.One of the most important characteristic of microservices is that because the services are smaller and independently deployable.

Small, focused teams.A microservice should be small enough that a single feature team can build, test, and deploy it.

Scalability.Microservices can be scaled independently, so you scale out sub-services that require less resources, without scaling out the entire application.

## **Challenges of Microservices Architecture**

Complexity.Microservices application has lots of services need to work together and should create a value. Since there are lots of services, that means there is more moving parts than the monolithic application.

Network problems and latency.So since microservice are small and communicate with inter-service communication, we should manage network problems.

Data integrity.Microservice has its own data persistence. So data consistency can be a challenge.

# **Design Microservice Architecture**

In this section, we are going to design the Microservice architecture step by step. Iterate the arch design one by one as per requirements.

![https://miro.medium.com/max/1400/1*9y2T-6LxfebMBpMEtYY82Q.png](https://miro.medium.com/max/1400/1*9y2T-6LxfebMBpMEtYY82Q.png)

We have followed to Database-per-Services Pattern when designing microservices architecture and put database of all microservices. And microservices are decomposed from monolithic application modules with separated standalone services.

So now these database can be polyglot persistence. That means Product ms can use NoSQL document database SC ms can use NoSQL key-value pair database and Order ms can use Relational database as per ms data storage requirements.

## **Evolve the Architecture**

Lets see the microservices architecture image and think about that what is missing on this architecture ? What is the pain point of this architecture ? How we can evolve this architecture to better one in order to be more scalability, availability, able to accommodate more concurrent requests ?

![https://miro.medium.com/max/1238/1*Hcj_yr-TpqpQduCv38hmnQ.png](https://miro.medium.com/max/1238/1*Hcj_yr-TpqpQduCv38hmnQ.png)

See that UI and Microservices communication are directly, and it seems hard to manage communications.We now we should focus on Microservices communications !!

# **Microservices Communications**

One of the biggest challenge when moving to microservices-based application is changing the communication mechanism. Because microservices are distributed and microservices communicate with each other by inter-service communication on network level. Each microservice has its own instance and process.Therefore, services must interact using an inter-service communication protocols like HTTP, gRPC or message brokers AMQP protocol.

Since microservices are complex structure into independently developed and deployed services, we should be careful when considering communication types and manage them into design phases.

## **Microservices Communication Design Patterns — API Gateway Pattern**

The API gateway pattern is recommended if you want to design and build complex large microservices-based applications with multiple client applications.

The pattern provides a reverse proxy to redirect or route requests to your internal microservices endpoints. An API gateway provides a single endpoint for the client applications, and it internally maps the requests to internal microservices. We should use API Gateways between client and internal microservices.

API Gateways can handle that Cross-cutting concerns like authorizationso instead of writing every microservices, authorization can handle in centralized api gateways and sent to internal microservices. Also api gateway manage routing to internal microservices and able to aggregate several microservice request in 1 response.

In summary, the API gateway locate between the client apps and the internal microservices. It is working as a reverse proxy and routing requests from clients to backend services. It is also provide cross-cutting concerns like authentication, SSL termination, and cache.

## **Design API Gateway — Microservices Communications Design Patterns**

We are going to iterate our e-commerce architecture with adding API Gateway pattern.

![https://miro.medium.com/max/1400/1*ZVCSFEMJ47RfHT6d6Q-EjQ.png](https://miro.medium.com/max/1400/1*ZVCSFEMJ47RfHT6d6Q-EjQ.png)

You can see the image that is collect client request in single entry-point and route request to internal microservices.

This will handle the client requests and route the internal microservices,also aggregate multiple internal microservices into a single client requestand performs cross-cutting concerns like Authentication and authorization, Rate limiting and throttling and so on..

## **Evolve the Architecture**

We will continue to evolve our architecture, but please look at the current design and think how we can improve design ?

There are several client applications connect to single API Gateway in here.We should careful about this situation, because if we put here a single api gateway, that means its possible to single-point-of-failure risk in here.If these client applications increase, or adding more logic to business complexity in API Gateway, it would be anti-pattern.

So we should solve this problem with BFF-backends-for-frontends pattern.

## **Backends for Frontends pattern BFF — Microservices Communications Design patterns**

Backends for Frontends pattern basically separate api gateways as per the specific frontend applications. So we have several backend services whichs are consumed by frontend applications and between them we put API Gateway for handling to routing and aggregate operations.But this makes a single-point-of failure So In order to solve this problem BFF offers to create several API Gateways and grouping the client applications according to their boundaries and split them different API Gateways.

![https://miro.medium.com/max/1400/1*ROjXU_pBaeYbvncW3d5DKg.png](https://miro.medium.com/max/1400/1*ROjXU_pBaeYbvncW3d5DKg.png)

A single and complex api gateway ca be risky and becoming a bottleneck into your architecture. Larger systems often expose multiple API Gateways by grouping client type like mobile, web and desktop functionality. BFF pattern is useful when you want to avoid customizing a single backend for multiple interfaces.

So we should create several api gateways as per user interfaces.These api gateways provide to best match the needs of the frontend environment, without worrying about affecting other frontend applications.The Backend for Frontends pattern provides direction for implementing multiple gateways.

## **Design Backends for Frontends pattern BFF — Microservices Communications Design Patterns**

We are going to iterate our e-commerce architecture with adding more API Gateway pattern according to Backends for Frontends pattern BFF.

![https://miro.medium.com/max/1400/1*Ph5v5cn1MnWCNsZFoXOZyQ.png](https://miro.medium.com/max/1400/1*Ph5v5cn1MnWCNsZFoXOZyQ.png)

As you can see that we have added to several API Gateways in our application. These api gateways provide to best match the needs of the frontend environment, without worrying about affecting other frontend applications. The Backend for Frontends pattern provides direction for implementing multiple gateways.

## **Service-to-Service Communications between Backend Internal Microservices — Microservices Communications Design patterns**

OK we have created API Gws in our microservices architecture. And said that all these sync request comes from the clients and goes to internal microservices over the api gws.But what if the client requests are required to visit more than one internal microservices ? How we can manage internal microservice communications ?

![https://miro.medium.com/max/1400/1*Y_nuTgTT-NTMYr9jYz_Jeg.png](https://miro.medium.com/max/1400/1*Y_nuTgTT-NTMYr9jYz_Jeg.png)

When designing microservices applications, we should careful about that how back-end internal microservices communicate with each other. The best practice is reducing inter-service communication as much as possible.However, In some cases, we can’t reduce these internal communications due to customer requirement or the requested operation need to visit several internal services.

For example, look at the image and think about the use case like;

- user wants checkout shopping cart and create an order

So how we can implement this request ?So these internal calls makes coupling each microservices, in our case sc — Product and Pricing microservices are dependent and coupling each other.And if one of the microservices is down, it can’t return data to the client so its not any fault-tolerance. If dependency and coupling of microservices are increase, then it makes lots of problems and loose the microservices architecture power.

If the client checkout shopping cart, this will start a set of operations.So if we try to perform this place order use case with Request/Response sync Messaging pattern, than it will seems like as this image.

AS you can see that there is 6 sync http request for one client http request.So it is obvious that increase latency and negatively impact the performance, scalability, and availability of our system.

If we have this of use case, what if the step 5 or 6 is failed, or what if some middle service are down ?Even if there is no down, it could be busy of some services that can’t response in a time manner and that caused not acceptable high latencies.

So what could be the solution of this kind of requirements ?

We can apply 2 way to solve this issues,1- Change microservices communications to async way with message broker systems, we will see this in the next section.2- using Service Aggregator Pattern to aggregate some query operations in 1 api gw.

## **Service Aggregator Pattern — Microservices Communications Design patterns**

In order to minimize service-to-service communications, we can apply Service Aggregator Pattern. Basically, The Service aggregator design pattern is receives a request from the client or api gw, and than dispatches requests of multiple internal backend microservices, and than combines the results and responds back to the initiating request in 1 response structure.

![https://miro.medium.com/max/1400/1*4DrpaYWVI0GuUUpdeAMhhw.png](https://miro.medium.com/max/1400/1*4DrpaYWVI0GuUUpdeAMhhw.png)

By Service Aggregator Pattern implementation, we can Reduces chattiness and communication overhead between the client and microservices

## **DESIGN — Service Aggregator Pattern — Service Registry Pattern — Microservices Communications Design patterns**

In this section we are going to iterate our e-commerce architecture with adding Service Aggregator Pattern — Service Registry Pattern — Microservices Communications Design patterns.

![https://miro.medium.com/max/1400/1*dvSuAPg_l-m5vsXoBY_ccg.png](https://miro.medium.com/max/1400/1*dvSuAPg_l-m5vsXoBY_ccg.png)

As you can see that we have applied Service Aggregator Pattern — Service Registry Pattern for our e-commerce architecture.

# **Microservices Asynchronous Message-Based Communication**

Synchronous communication is good if your communication is only between a few microservices. But when it comes to several microservices need to call each other and wait some long operations until finished, then we should use async communication.

![https://miro.medium.com/max/1400/1*vY7H16I3QPKbcRHGs1sYCg.png](https://miro.medium.com/max/1400/1*vY7H16I3QPKbcRHGs1sYCg.png)

Otherwise that dependency and coupling of microservices will create bottleneck and create serious problems of the architecture.

If you have multiple microservices are required to interact each otherand if you want to interact them without any dependecy or make loosely coupled, than we should use Asynchronous message-based communication in Microservices Architecture.

Because Asynchronous message-based communication is providing works with events. So events can place the communication between microservices.We called this communication is a event-driven communication.

## **Publish–Subscribe Design Pattern**

Publish–subscribe is a messaging pattern, that has sender of messages whichs are called publishers, and has specific receivers whichs are called subscribers.

![https://miro.medium.com/max/1400/1*ayf9Gtr0DCxVzFtR1bc-0w.png](https://miro.medium.com/max/1400/1*ayf9Gtr0DCxVzFtR1bc-0w.png)

So publishers don’t send the messages directly to the subscribers.Instead categorize published messages and send them into message broker systems without knowledge of which subscribers are there.

Similarly, subscribers express interest and only receive messages that are of interest, without knowledge of which publishers send to them.

## **DESIGN — Pub/Sub Message Broker — Microservices Asynchronous Communications Design patterns**

In this section, we are going to iterate our e-commerce architecture with adding Pub/Sub Message Broker for providing Microservices Asynchronous Communications Design.

![https://miro.medium.com/max/1400/1*JOKQIgxIh5qr5XSyFJYnhg.png](https://miro.medium.com/max/1400/1*JOKQIgxIh5qr5XSyFJYnhg.png)

As you can see that we have applied Pub/Sub Message Broker — Microservices Asynchronous Communications Design patterns.

If we Adapting Technology Stack, we basically start with what options can be for Pub/Sub Message Brokers. There 2 good alternatives that you can pick;

1- Kafka2- RabbitMQ

# **Microservices Data Management**

In monolithic architectures, its very good to query different entities because single database keeps data management is also simple. Querying data across multiple tables is straightforward. Any Changes into data update together or they all rollback. Relational databases with strict consistency has ACID transactions guarantee so its easy to manage and query data.

But in microservices architectures when we use “polyglot persistence”which means every microservices has different databases both relational and no-sql databases we should set a strategy to manage this data when performing user interactions.

So that means we have several patterns and practices when handling data interactions between microservices, we will learn this patterns and principles in this section.

Microservices are independent and perform only specific functional requirements, For our case in e-commerce application we have product, basket, discount, ordering microservices need to interact each other to perform customer use cases. So that means they need to integrate frequently with each others. And mostly these integrations are querying each services data for aggregation or perform logics.

## **CQRS Design Pattern**

CQRS is one of the important pattern when querying between microservices. We can use CQRS design pattern in order to avoid complex queries to get rid of inefficient joins. CQRS stands for Command and Query Responsibility Segregation. Basically this pattern separates read and update operations for a database.

In order isolate Commands and Queries, its best practices to separate read and write database with 2 database physically. By this way, if our application is read-intensive that means reading more than writing, we can define custom data schema to optimized for queries.

![https://miro.medium.com/max/1400/1*XbV_TVf0gr3Ee0cxggeO7Q.png](https://miro.medium.com/max/1400/1*XbV_TVf0gr3Ee0cxggeO7Q.png)

Materialized view pattern is good example to implement reading databases.Because by this way we can avoid complex joins and mappings with pre-defined fine-grained data for query operations.

By this isolation, we can even use different database for reading and writing database types like using no-sql document database for reading and using relational database for crud operations.

## **Event Sourcing Pattern**

we have learned the CQRS pattern and the CQRS pattern is mostly using with the Event Sourcing pattern. When using CQRS with the Event Sourcing pattern, the main idea is store events into the write database, and this will be the source-of-truth events database.

After that the read database of CQRS design pattern provides materialized views of the data with denormalized tables. Of course this materialized views read database consumes events from write database and convert them into denormalized views.

![https://miro.medium.com/max/1400/1*4EtxJ0KtiJRt-qoBt3IUiA.png](https://miro.medium.com/max/1400/1*4EtxJ0KtiJRt-qoBt3IUiA.png)

With applying Event Sourcing pattern, it is changing to data save operations into database. Instead of saving latest status of data into database, Event Sourcing pattern offers to save all events into database with sequential ordered of data events. This events database called event store.

Instead of updating the status of a data record, it append each change to a sequential list of events. So The Event Store becomes the source-of-truth for the data. After that, these event store convert to read database with following the materialized views pattern. This convert operation can handle by publish/subscribe pattern with publish event with message broker systems.

## **Design the Architecture — CQRS, Event Sourcing, Eventual Consistency, Materialized View**

We are going to Design our e-commerce Architecture with applying CQRS, Event Sourcing, Eventual Consistency, Materialized View.

![https://miro.medium.com/max/1400/1*BaogPG12HVO6pnzVMZeouw.png](https://miro.medium.com/max/1400/1*BaogPG12HVO6pnzVMZeouw.png)

So when user create or update an order, I am going to use relational write database, and when user query order or order history, I am going to use no-sql read database and make consistent them when syncing 2 databases with using message broker system with applying publish/subscribe pattern.Now we can consider tech stack of these databases, I am going to use SQL Server for relational writing database and using Cassandra for no-sql read database. Of course we will use Kafka for syncing these 2 database with pub/sub Kafka topic exchanges.As you can see that we have finished to design with microservices database patterns. Lets deep dive into these event-driven architecture in microservices.

# **Event-Driven Microservices Architecture**

Basically event-driven microservice architecture is means communicating with microservices via event messages. And we saw that in publish/subscriber pattern and Kafka message broker systems at microservices async communication sections.

We said that, with the event-driven architectures we can do asynchronous behavior and loosely coupled structures. In example, instead of sending request when data needed, services consume them via events. This will provide to performance increases.

![https://miro.medium.com/max/1400/1*yjiVMTJvmOjjzr7m_haXVg.png](https://miro.medium.com/max/1400/1*yjiVMTJvmOjjzr7m_haXVg.png)

But also there are huge Innovations on the Event-Driven Microservices Architectures like using real-time messaging platforms, stream-processing, event hubs, real-time processing, batch processing, data intelligence and so on.

So we can make this event-driven approach is more generic and real-time event processing features with evolving this architecture.

According to this new event-driven microservices architecture, every thing is communication via Event-Hubs. We can think Event-Hubs is huge event store database that can make real-time processing.

## **Design the Architecture — Event-Driven Microservices Architecture**

We are going to design our e-commerce application with the Event-Driven Microservices Architecture.

![https://miro.medium.com/max/1400/1*MBlKALe1q_3N5uB0Ic7Fpw.png](https://miro.medium.com/max/1400/1*MBlKALe1q_3N5uB0Ic7Fpw.png)

Now lets decide to Technology stack in this architecture. Of course we should pick Apache Kafka — as a Event hub and Apache Spark for real-time and near-real-time streaming applications that transform or react to the streams of data.

As you can see that now we have reactive design with Event-Driven Microservices Architecture.

Now we can ask the same question;

- **How many concurrent request can accommodate our design ?**

![https://miro.medium.com/max/1400/1*0YRNe6B9k-m9kWrQY8tTyQ.png](https://miro.medium.com/max/1400/1*0YRNe6B9k-m9kWrQY8tTyQ.png)

And with this latest event-driven microservices architecture which Deployments with Containers and Orchestrators, can be accommodate target concurrent request in a low latency.Because this architecture is fully loosely coupled and design for high Scalability and high Availability.

As you can see that we have designed our e-commerce microservices architecture with all aspects of design principles and patterns. Now you can ready to design your own architectures with these learning and know how to use these patterns toolbox in your designs.