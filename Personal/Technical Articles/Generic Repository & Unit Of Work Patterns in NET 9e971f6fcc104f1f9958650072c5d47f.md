# Generic Repository & Unit Of Work Patterns in .NET

Article Link: https://medium.com/codex/generic-repository-unit-of-work-patterns-in-net-b830b7fb5668
Author: Tomasz Nowok
Date Added: October 4, 2021 10:13 AM
Tag: .NET, Coding Standards, Design-Patterns

Practical guide to implement generic repository and unit of work patterns in .NET Core C# application

## **About Repository & Unit Of Work patterns**

As I suppose, repository pattern is being implemented in almost every modern database application — especially used in many web API online courses. The purpose of this approach is to abstract persistence (in our case EF Core) layer and querying database using these implementations. Another pattern, we are talking about, is Unit Of Work one which performs the function of “wrapper” for our repositories and commits changes to the database. In this article, I would like to implement these two patterns together.

## **Prerequisites**

- created .NET C# project in one of your favorite IDEs (VS, VS Code, Rider etc.)
- a little knowledge about Entity Framework ORM (DataContext class which will be used in the future is casual implementation of EF DbContext and contains all DbSets and entities configurations)

## **Let’s implement Repository pattern in a generic way**

Repository is a class which performs database operations for a specified entity object (table). Most of them are simple enough to be implemented generically and referring to DRY principle (don’t repeat yourself) is redundant to write method which finds entity by primary key so many times.

To simplify this, we’re going to code our repository in a generic way with abilities to extend it!

So here we are, firstly we will start from creating two files in our C# project:

- **IRepository<T>** — generic interface for our Repository. As we could see, current abstraction is being implemented asynchronously because we want to have our database queries to work this way. Such operations can block some threads and we don’t like this.

![https://miro.medium.com/max/994/1*A31f0xW52E-5t44W3-EgIQ.png](https://miro.medium.com/max/994/1*A31f0xW52E-5t44W3-EgIQ.png)

Generic repository interface

- **Repository<T>** — here we create a class implementing our interface. Now we have to more code than in the previous file. To make long story short, constructor of this class has injected DataContext object which we use in all methods to perform CRUD database operations.Method context.Set<T>() finds corresponding DbSet (table) in DataContext class by generic T type — it means that if repository is type of Notification entity, the Notifications table will be queried in our database.

![https://miro.medium.com/max/1154/1*ng_R51hKWV84GjdleFDnsw.png](https://miro.medium.com/max/1154/1*ng_R51hKWV84GjdleFDnsw.png)

Generic repository class

Now I describe every methods in our Repository:

- **Get(string id) —** finds an entity by their primary key
- **Find(Expression<Func<T, bool>> predicate) —** finds an entity using a predicate. Declaration of this method could be complicated but usage is pretty straightforward — we use it exactly the same as FirstOrDefault LINQ method
- **GetAll() —** fetches all entities from a specified table
- **GetWhere(Expression<Func<T, bool>> predicate) —** fetches entities from a specified table using a predicate (exactly the same as Where LINQ method)
- All remaining methods add, update or delete entities from the database. They also have ability to perform these actions on a range of entities.**Very important fact is that operations would be committed to the database only when our UnitOfWork class called Complete() method!**

## **Okay, so what about Unit Of Work pattern?**

As I say above, this pattern is a kind of wrapper for our repositories. Our business logic classes would inject IUnitOfWork which gives access to all registered repositories in our application. Abstraction for this is really simple:

![https://miro.medium.com/max/714/1*_E8GZRVFuwdP0uU0dxllqA.png](https://miro.medium.com/max/714/1*_E8GZRVFuwdP0uU0dxllqA.png)

Unit of work interface

UnitOfWork should inject DataContext object through its constructor and then pass this object to all repositories registered in this class.

All repositories are being implemented in the same way — private field and read-only property which returns its suitable existing repository or if fields was not initialized (?? operator) — instantiates new one.

Under repositories region we could see **Complete()** method implementation — **it is responsible for committing changes to our database**. If any changes were made, it would return true.

The last method to write is Dispose() which simply disposing our context field.

![https://miro.medium.com/max/1400/1*mlpgSZfoQjAUrIFDlgnIZA.png](https://miro.medium.com/max/1400/1*mlpgSZfoQjAUrIFDlgnIZA.png)

Unit of work class

## **What if I need more complex query than we’ve implemented in the generic repository class?**

Answer is really obvious — we must provide a custom repository class.I’d like to show how such class is being implemented and how flexible approach it is.

First thing we have to do, is to create new custom interface which implements our generic IRepository abstraction but instead of T parameter, we simply use specified entity object — in this case Notification class.

![https://miro.medium.com/max/1066/1*V8rE8fweoKxn9EQTbQMPrg.png](https://miro.medium.com/max/1066/1*V8rE8fweoKxn9EQTbQMPrg.png)

Custom INotificationRepository interface

NotificationRepository class should inherit from generic Repository class and implements its custom interface.

![https://miro.medium.com/max/1284/1*FOMkkqItZWYI8azcPnqPwg.png](https://miro.medium.com/max/1284/1*FOMkkqItZWYI8azcPnqPwg.png)

Custom NotificationRepository class

Now, using this custom repository implementation, you are able to call all generic methods for Notifications table and additionally — two specified methods: GetOrderedNotifications and CountUnreadNotifications.

In order to register this repository in our UnitOfWork class — simply instead of using IRepository<Notification> and Repository<Notification> we are going to type: INotificationRepository and NotificationRepository.

![https://miro.medium.com/max/796/1*1ihPedTVdQWK2cBCDtuk0g.png](https://miro.medium.com/max/796/1*1ihPedTVdQWK2cBCDtuk0g.png)

![https://miro.medium.com/max/968/1*lKxFytg87gflqWNixp1DFA.png](https://miro.medium.com/max/968/1*lKxFytg87gflqWNixp1DFA.png)

## **Injecting IUnitOfWork in our application**

Firstly, we need to register IUnitOfWork and IRepository<T> to our Dependency Injection container — I use default DI Microsoft container for ASP NET Core apps.

In Startup.cs class:

![https://miro.medium.com/max/902/1*IBx2Xzee9T_CCgakC4Fm5Q.png](https://miro.medium.com/max/902/1*IBx2Xzee9T_CCgakC4Fm5Q.png)

Now, we are allowed to inject IUnitOfWork wherever we want.😎

**Example of injecting IUnitOfWork to the service and querying database:**

![https://miro.medium.com/max/1400/1*Xre6PupNjCzHixDH_zqDqQ.png](https://miro.medium.com/max/1400/1*Xre6PupNjCzHixDH_zqDqQ.png)

Example of Notifier class which uses IUnitOfWork

The first Notifier method is GetNotifications() which performs query to the database implemented by us in the NotificationRepository class.

Another one is a Push() method which creates Notification entity instance, adds its locally to the Notifications table and then commits to the database.If Complete() succeeded — new notification would be persisted in our database.

# **Finish!**

Okay, we completed our work! I suppose this approach is really flexible and SOLID. We are able to extend our generic repository if it’s needed but also could use basic one if its provided functionality is enough for us. 😀

Additionally, we don’t need to inject all repositories we use in a business logic service because IUnitOfWork gives us access to all of them! Is it not convenient?😎

Thank you for reading, have a nice day and let the code be with you!💻 ⌨️ 🖥