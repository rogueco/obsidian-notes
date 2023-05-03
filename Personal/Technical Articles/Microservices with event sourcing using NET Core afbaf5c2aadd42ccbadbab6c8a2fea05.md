# Microservices with event sourcing using .NET Core

Article Link: https://medium.com/@madslundt/microservices-with-event-sourcing-using-net-core-33e3074171f5
Author: Mads Engel Lundt
Date Added: August 26, 2021 3:10 PM
Tag: .NET, Microservices

I spend some time last year implementing an example project on how to structure an API using microservices in .NET Core. In my summer vacation, I began looking into how I could improve and add event sourcing to the project

Before diving into the project details let’s get an overview of the project

The project’s main focus is implementing an API using a microservice structure. This means it can still be applied in a monolithic application but the theories from microservices can be applied to the application.The next step was to avoid boiler code and code duplication as much as possible and focus on clean code. To have this, it is important to split the logic in different modules to reuse logic in other places. This also gives the option to only include modules that are needed in the application.

Most of this was already introduced in the project last year.After some days of relaxing, I began to look into event sourcing. I looked at different libraries for implementing event sourcing into a .NET core application but I had a hard time finding a solution that could fit into my project.I decided to give it a try and implement my version on how to include event sourcing into the microservice example project.

Link to [Github repository](https://github.com/madslundt/NetCoreMicroservicesSample).Keep in mind that the repo is work in progress.

# **Event sourcing**

Let’s start by describing what event sourcing is:

# “The fundamental idea of Event Sourcing is that of ensuring every change to the state of an application is captured in an event object, and that these event objects are themselves stored in the sequence they were applied for the same lifetime as the application state itself.” —

This means that event sourcing never mutate states in the application but stores a sequence of events in an append-only event log called event store.

In this way, data is never lost and all changes persist.

# **Application**

The example application is a simple movie database with user reviews.To do so, the application needs to store entities such as movies, reviews, and users.The application is quite simple and only support create and delete entities.Authentication and authorization have not been added to the application.

Let’s start by getting an overview of how the application is structured.

![https://miro.medium.com/max/1400/1*4eklXPD5bgkzG0VMHL_M5w.png](https://miro.medium.com/max/1400/1*4eklXPD5bgkzG0VMHL_M5w.png)

Project showing the API gateway connected to 3 different services

Starting from the top of the overview we see that there is a request going into the API gateway.

The API gateway is the only public API and its job is to route traffic to the correct service.In this example, Ocelot has been used because it is easy to set up and configure.

Each microservice is focused to be as independent as possible.That means each microservice has its database, event handler, event store (if used), etc.

The only shared dependency between the micro services is the message broker.The micro services can run without the message broker because events are stored within the micro service before being published to the message broker. However, the events can not be published to other micro services before the message broker is up and running. The important thing here is that events are never lost due to connection error to the message broker.

## **User service**

User service is handling all users in the system.It is possible to create and delete users in the system.

The service is hosting a database where states are mutating. That means read and write operations happen to the same database.Event sourcing with an event store was left out of this service.

User service is still able to communicate with the other services through events even though it is not using event sourcing with an event store.The only difference is that this service does not make use of aggregates to publish events.Publishing events, however, happens every time the database changes because the database context requires an event before it can save changes to the database.

To commit events this service makes use of Outbox.Outbox is used as a landing zone for events before they are published to the message broker. The Outbox store is then hosted near or within the service to reduce the chance of connection errors and to reduce latency by waiting for the event being sent and received by the message broker.The message broker will later receive the event by the service having a background worker looping through all events that have not been published to the message broker. Once an event has been successfully published to the message broker the event in the Outbox database is either flagged or removed so it is not going to be processed later.

# The major difference between event sourcing with an event store and Outbox is that event sourcing is meant to be a permanent and immutable store of domain events, while the Outbox database is meant to be highly ephemeral and only be a landing zone for domain events to be captured inside change events and forwarded to downstream consumers.

Using the infrastructure of the project makes it easy to customize the service to only include what it needs

## **Movie service and review service**

Movie service is handling all movies in the system.It is possible to create and delete movies in the system.

Review service is handling all reviews added to movies.It is possible to create and delete reviews in the system.

The services make use of the same dependencies as the user service but also makes use of event sourcing with an event store to not mutate data but keep all changes.That means when a movie or review is removed the data is still kept but just not accessible to the outside.This data can then later be restored so it is accessible to the user if needed.

To do so, a read and a write database are used for this.

The write database is an immutable store and all events published from the service are appended to the write database as event streams.To do so concepts from DDD (Domain-Drive-Design) are applied to the services. With these concepts, it is possible to apply a command to an aggregate which then produces one or more events. An aggregate can populate (re-hydrate) its state by sequential application of an event stream.

The read database is mutable and may be updated when events are received by the service. This is done through update handlers who are subscribing to events.

The service becomes slightly more complex when adding event sourcing with an event store.It is also important to keep in mind that there will be some inconsistency between the write- and the read database in a smaller time slot. This is due to the read database needs to wait for the event to be published to the message broker and received by the service again before updating the read database.

Using the infrastructure makes it easy to add event sourcing with an event store to the service

## **Conclusion**

This project was created to adapt different technologies into a Web API in a very clean and structured way.

The focus of the whole project is to have each micro service as independent as possible but still able to communicate with other services without having to depend on them.

Event sourcing with an event store has a lot to offer but comes with a cost of complexity and inconsistency in smaller time slots.I believe that event sourcing has its purposes in some projects but you should be careful when and how to implement event sourcing into the project.

Link to [Github repository](https://github.com/madslundt/NetCoreMicroservicesSample).Keep in mind that the repo is work in progress