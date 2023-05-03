# Developing Web API’s — Microservices Architecture, SOLID, DDD, Onion Architecture, Clean Architecture, CQRS

Article Link: https://medium.com/geekculture/developing-web-apis-microservices-architecture-solid-ddd-onion-architecture-clean-55f46052c41b
Author: Nazlican Kurt
Date Added: October 4, 2021 10:17 AM
Tag: .NET, Event-Driven, Microservices

[https://miro.medium.com/max/1400/0*IJJzvAxD9mO_6EYZ](https://miro.medium.com/max/1400/0*IJJzvAxD9mO_6EYZ)

Photo by [Sharon McCutcheon](https://unsplash.com/@sharonmccutcheon?utm_source=medium&utm_medium=referral) on [Unsplash](https://unsplash.com/?utm_source=medium&utm_medium=referral)

Hello, today I will talk about a subject that took some time while learning. In this field, I try to improve my competencies and gain more and more information every day. While learning, it is very helpful to ask too many questions, reflect on the answers received, and even write an article. Feel free to ask questions related to the subject.

## **How will I go about it?**

I will talk about what we need to know before writing a middle-level Web API that is compatible with SOLID principles. In my next article, I will develop a suitable Web API. The aim is to make a good start and after creating an entity, follow a path suitable for the titles I have stated below.

## **What am I going to talk about?**

- Microservice Architecture
- .Net Core Dependency Injection
- SOLID
- Onion Architecture
- Clean Architecture
- DDD (Domain Driven Design)

## **What will I talk about in the coding part?**

Here I will use onion architecture with a microservice.

- .Net Core 3.1
- Repositories
- CQRS and MediatR
- Entity Framework | Code First
- MySQL

# **Microservices Architecture**

In the book called .NET Microservices: Architecture for Containerized .NET Applications, which is Microsoft’s own source and which [you can download from here](https://dotnet.microsoft.com/download/e-book/microservices-architecture/pdf), microservices are explained as follows:

As the name implies, a microservices architecture is an approach to building a server application as a set of small services. That means a microservices architecture is mainly oriented to the back-end, although the approach is also being used for the front end. Each service runs in its own process and communicates with other processes using protocols such as HTTP/HTTPS, WebSockets, or AMQP.

Each microservice implements a specific end-to-end domain or business capability within a certain context boundary, and each must be developed autonomously and be deployable independently. Finally, each microservice should own its related domain data model and domain logic and could be based on different data storage technologies (SQL, NoSQL) and different programming languages.

## **What size should a microservice be?**

When developing a microservice, size shouldn’t be the important point. Instead, the important point should be to create loosely coupled services so you have autonomy of development, deployment, and scale, for each service. Of course, when identifying and designing microservices, you should try to make them as small as possible as long as you don’t have too many direct dependencies with other microservices.

More important than the size of the microservice is the internal cohesion it must have and its independence from other services.

## **Why a microservices architecture?**

In short, it provides long-term agility. Microservices enable better maintainability in complex, large, and highly scalable systems by letting you create applications based on many independently deployable services that each have granular and autonomous lifecycles. As an additional benefit, microservices can scale-out independently.

Instead of having a single monolithic application that you must scale out as a unit, you can instead scale-out specific microservices. That way, you can scale just the functional area that needs more processing power or network bandwidth to support demand, rather than scaling out other areas of the application that don’t need to be scaled. That means cost savings because you need less hardware.

# **Use SOLID Principles and Dependency Injection**

SOLID principles are critical techniques to be used in any modern and mission-critical application, such as developing a microservice with DDD patterns.

SOLID is an acronym that groups five fundamental principles:

- Single Responsibility principle
- Open/closed principle
- Liskov substitution principle
- Interface Segregation principle
- Dependency Inversion principle

SOLID is more about how you design your application or microservice internal layers and about decoupling dependencies between them. It is not related to the domain, but to the application’s technical design.

The final principle, the Dependency Inversion principle, allows you to decouple the infrastructure layer from the rest of the layers, which allows a better-decoupled implementation of the DDD layers.

**Dependency Injection (DI)** is one way to implement the Dependency Inversion principle. It is a technique for achieving loose coupling between objects and their dependencies. Rather than directly instantiating collaborators, or using static references, the objects that a class needs in order to perform its actions are provided to the class.

Most often, classes will declare their dependencies via their constructor, allowing them to follow the Explicit Dependencies Principle. Dependency Injection is usually based on specific Inversion of Control (IoC) containers. ASP.NET Core provides a simple built-in IoC container, but you can also use your favorite IoC container, like Autofac or Ninject.

By following the SOLID principles, your classes will tend naturally to be small, well-factored, and easily tested. But how can you know if too many dependencies are being injected into your classes?

If you use DI through the constructor, it will be easy to detect that by just looking at the number of parameters for your constructor. If there are too many dependencies, this is generally a sign that your class is trying to do too much, and is probably violating the Single Responsibility Principle.

# **Domain-Driven Design (DDD)**

DDD is not an advanced technology or specific method. DDD is an approach that tries to find solutions to the basic problems frequently encountered in the development of complex software systems and after these complex projects are implemented.

Introduced and made popular by programmer Eric Evans in his 2004 book, Domain-Driven Design: Tackling Complexity in the Heart of Software, domain-driven design is the expansion upon and application of the domain concept, as it applies to the development of software. DDD focuses on three core principles:

> Focus on the core domain and domain logic.Base complex designs on models of the domain.Constantly collaborate with domain experts, in order to improve the application model and resolve any emerging domain-related issues.
> 

Layered ArchitectureOne of the most basic concepts of DDD is its 4-layer architecture.

- Domain Layer
- Application Layer
- Presentation Layer
- Infrastructure LayerThis topic will be better understood with onion architecture.

# **Onion Architecture**

![https://miro.medium.com/max/862/1*gcNSuTL8PTi2N3RKkxjyYw.png](https://miro.medium.com/max/862/1*gcNSuTL8PTi2N3RKkxjyYw.png)

As in the diagram, the traditional layered architecture has a hierarchy of ‘UI’ -> ‘Business Logic’ -> ‘Data’. I think it is useful to talk about the difficulties of this architecture and the cost that these difficulties impose on us, rather than the advantageous returns.

As can be seen, in traditional layered architecture, there is a strict adherence between the layers that make up the application, and each layer is hierarchically connected to the layer under it. In addition, the user interface is plain and only communicates with the ‘Business Logic’ layer, and direct communication with the ‘Data’ layer is not allowed. Thus, even if a design is arranged and security is ensured, this design is insufficient for large and complex applications. This is because the ‘Data’ layer has a central role.

![https://miro.medium.com/max/1000/1*aeG3SMDz7oRZjLKuoRxNqw.png](https://miro.medium.com/max/1000/1*aeG3SMDz7oRZjLKuoRxNqw.png)

As can be seen, in Onion Architecture, the layers are in a circular manner, one within the other. It got this name because it looks like Onion. In fact, we can say that the dependence of each layer on only one inner layer in terms of functionality rather than the image is attributed this way because it animates the onion anatomy.

**Domain Layer** usually contains enterprise logic and entities. Responsible for representing concepts of the business, information about the business situation, and business rules. State that reflects the business situation is controlled and used here, even though the technical details of storing it are delegated to the infrastructure. This layer is the heart of business software.The domain layer is where the business is expressed.

**Application Layer,** Defines the jobs the software is supposed to do and directs the expressive domain objects to work out problems. The tasks this layer is responsible for are meaningful to the business or necessary for interaction with the application layers of other systems. This layer is kept thin. It does not contain business rules or knowledge, but only coordinates tasks and delegates work to collaborations of domain objects in the next layer down. It does not have a state reflecting the business situation, but it can have a state that reflects the progress of a task for the user or the program.

Application Layer would have Interfaces and types. The main difference is that The Domain Layer will have the types that are common to the entire enterprise, hence can be shared across other solutions as well. But the Application Layer has Application-specific types and interfaces.

**Presentation Layer** is where you would Ideally want to put the Project that the User can Access. This can be a WebApi, Mvc Project, etc.

**Infrastructure Layer** is a bit more tricky. It is where you would want to add your Infrastructure. Infrastructure can be anything. Maybe an Entity Framework Core Layer for Accessing the DB, or a Layer specifically made to generate JWT Tokens for Authentication or even a Hangfire Layer. You will understand more when we start Implementing Onion Architecture in ASP.NET Core WebApi Project.

**Persistence Layer**DbContext, migration, and database configuration operations are performed in this layer. In addition, interfaces in the Application layer are implemented here.

## **Advantages of Onion Architecture**

- Onion Architecture eliminates Tightly Coupling and provides Loosely Coupled thanks to the architectural dependence of the application layers only on the inner layer.
- It also complies with the Separation of Concerns principle, as it divides the project into layers according to its responsibilities.
- Layers are relationally inward dependent. Therefore, this makes it easier for him to maintain.
- Unit tests provide better testability as they can be created for separate layers without the influence of other modules of the application.

# **Clean Architecture**

![https://miro.medium.com/max/1400/1*5Ab9Jh1dBSQyC-SHibUzKw.png](https://miro.medium.com/max/1400/1*5Ab9Jh1dBSQyC-SHibUzKw.png)

Each of clean architectures produces systems that are:

- Independent of Frameworks. The architecture does not depend on the existence of some library of feature-laden software. This allows you to use such frameworks as tools, rather than having to cram your system into their limited constraints.
- Testable. The business rules can be tested without the UI, Database, Web Server, or any other external element.
- Independent of UI. The UI can change easily, without changing the rest of the system. A Web UI could be replaced with a console UI, for example, without changing the business rules.
- Independent of Database. You can swap out Oracle or SQL Server, for Mongo, BigTable, CouchDB, or something else. Your business rules are not bound to the database.
- Independent of any external agency. In fact, your business rules simply don’t know anything at all about the outside world.

By separating the software into layers, and conforming to The Dependency Rule, you will create a system that is intrinsically testable, with all the benefits that imply. When any of the external parts of the system become obsolete, like the database, or the web framework, you can replace those obsolete elements with a minimum of fuss.

# **CQRS and MediatR**

Command and Query Responsibility Segregation (CQRS) was introduced by Greg Young and strongly promoted by Udi Dahan and others. It is based on the CQS principle, although it is more detailed. It can be considered a pattern based on commands and events plus optionally on asynchronous messages.

![https://miro.medium.com/max/1400/1*oUf7n1HpJ-OHASbkQHOZDg.png](https://miro.medium.com/max/1400/1*oUf7n1HpJ-OHASbkQHOZDg.png)

In many cases, CQRS is related to more advanced scenarios, like having a different physical database for reads (queries) than for writes (updates). Moreover, a more evolved CQRS system might implement Event-Sourcing (ES) for your updates database, so you would only store events in the domain model instead of storing the current-state data.

However, this approach is not used in this guide. This guide uses the simplest CQRS approach, which consists of just separating the queries from the commands. The separation aspect of CQRS is achieved by grouping query operations in one layer and commands in another layer.

Each layer has its own data model and is built using its own combination of patterns and technologies. More importantly, the two layers can be within the same tier or microservice, as in the example (ordering microservice) used for this guide. Or they could be implemented on different microservices or processes so they can be optimized and scaled out separately without affecting one another.

CQRS means having two objects for a read/write operation wherein in other contexts there is one. There are reasons to have a denormalized reads database, which you can learn about in more advanced CQRS literature.

But we are not using that approach here, where the goal is to have more flexibility in the queries instead of limiting the queries with constraints from DDD patterns like aggregates.

# **Conclusion**

The microservices architecture is becoming the preferred approach for distributed and large or complex mission-critical applications based on many independent subsystems in the form of autonomous services. In a microservice-based architecture, the application is built as a collection of services that are developed, tested, versioned, deployed, and scaled independently. Each service can include any related autonomous database.

For a project to be a good project, it must have a good code architecture. The biggest factor here is to create independent services. One function must not reach another and accessibility must be in layers.

# **Resources:**

**Microservices, SOLID, Dependency Injection**

**[.NET mikro hizmetleri. Kapsayıcılı .NET Uygulamaları MimarisiKapsayıcılı .NET uygulamaları için .NET mikro hizmetleri mimarisi | Mikro hizmetler modüler ve bağımsız olarak…**
docs.microsoft.com](https://docs.microsoft.com/tr-tr/dotnet/architecture/microservices/)

**Clean Architecture**

[Clean Coder Blog](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

**Onion Architecture**

[The Onion Architecture: part 1 | Programming with Palermo (jeffreypalermo.com)](https://jeffreypalermo.com/2008/07/the-onion-architecture-part-1/)

[https://www.gencayyildiz.com/blog/nedir-bu-onion-architecture-tam-teferruatli-inceleyelim/](https://www.gencayyildiz.com/blog/nedir-bu-onion-architecture-tam-teferruatli-inceleyelim/)

**CQRS**

[CQRS (martinfowler.com)](https://martinfowler.com/bliki/CQRS.html)

In my first article that will continue from now on, I will develop a Web API with the structure I mentioned.

Thank you for reading!