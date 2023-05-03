# Decorator Design Pattern in ASP.NET Core

Article Link: https://ankit68543.medium.com/decorator-design-pattern-in-asp-net-core-b6aaa45f3af2
Author: Ankit Kashyap
Date Added: October 4, 2021 10:06 AM
Tag: Design-Patterns

Decorator Design Pattern in [ASP.NET](http://asp.net/) Core

Imagine that you are working on an existing application that sends notifications to other programs. The initial version of that application was only sending notifications by email but now you are asked to add some additional features in that library so that it can start sending notifications by SMS, or can send notifications to Facebook, Twitter, etc., or a combination of many other apps. You don’t want to modify existing code, you don’t want to create a big hierarchy of child and grandchild classes and still, you want to enhance the existing application. This is where the Decorator Pattern will come to rescue you and will allow you to dynamically add or remove functionality to existing classes.

**Let’s get started**

**1.What is a Decorator Pattern?**

The decorator pattern (also known as Wrapper) is a structural design pattern and it allows developers to dynamically add new behaviors and features to existing classes without modifying them thus respecting the [open-closed principle](https://en.wikipedia.org/wiki/Open%E2%80%93closed_principle). This pattern lets you structure your business logic into layers (wrappers) in a way that each layer adds some additional behavior or functionality to an existing object, promoting [separation of concern](https://en.wikipedia.org/wiki/Separation_of_concerns). Furthermore, these layers can be added or removed at runtime and clients can also use the different combinations of decorators to be attached to an existing object.

[https://miro.medium.com/max/1370/0*6FPZdIPX6ZpKEO6J](https://miro.medium.com/max/1370/0*6FPZdIPX6ZpKEO6J)

**2. Pros Decorator Pattern**

1. We can extend an object’s behavior without creating a hierarchy of new child classes.
2. We can add or remove features from an object at runtime which gives developer flexibility not available in simple inheritance.
3. We can combine several features by wrapping an object into multiple decorators
4. We can divide a complex object into several smaller classes with specific behaviors which promotes the Single Responsibility Principle
5. It supports the Open-closed principle which states that the classes should be open for extension but closed for modification.

**3. Cons Decorator Pattern**

1. The object instantiation can be complex as we have to create an object by wrapping it in several decorators.
2. Sometimes, it’s hard to keep track of the full wrapper stack, and removing a specific wrapper from the stack is not something easy to achieve.
3. Decorators can cause issues if the client using them relies heavily on the object concrete type.

**Getting Started with Decorator Pattern in ASP.NET Core 5**

The decorator pattern can be used to attach cross-cutting concerns such as logging or caching to existing classes without changing their code. Let’s create a new ASP.NET Core 5 REST API to learn how to use the decorator pattern to dynamically add/remove logging and caching features.

First of all, create the following **Player** model class in the **Models** folder of the project.

[https://miro.medium.com/max/60/0*OP3ujVK4lKN0X7nC?q=20](https://miro.medium.com/max/60/0*OP3ujVK4lKN0X7nC?q=20)

[https://miro.medium.com/max/1400/0*OP3ujVK4lKN0X7nC](https://miro.medium.com/max/1400/0*OP3ujVK4lKN0X7nC)

Next, create the following **PlayerService** and return a fake list of players. Of course, in a live application, this type of service will fetch data from a backend database but I want to keep the example simple as the purpose of this post is to show you the usage of decorator patterns in real-world scenarios.

**IPlayerService.cs**

[https://miro.medium.com/max/60/0*jf95AqTMfbROwmkz?q=20](https://miro.medium.com/max/60/0*jf95AqTMfbROwmkz?q=20)

[https://miro.medium.com/max/1400/0*jf95AqTMfbROwmkz](https://miro.medium.com/max/1400/0*jf95AqTMfbROwmkz)

**PlayerService.cs**

[https://miro.medium.com/max/60/0*KepaUEyhzYUnvR-i?q=20](https://miro.medium.com/max/60/0*KepaUEyhzYUnvR-i?q=20)

[https://miro.medium.com/max/1400/0*KepaUEyhzYUnvR-i](https://miro.medium.com/max/1400/0*KepaUEyhzYUnvR-i)

Inject the above **PlayerService** in an ASP.NET Core API Controller and call the **GetPlayersList** method as shown below.

[https://miro.medium.com/max/60/0*hqrGKEG7lAVdAQJv?q=20](https://miro.medium.com/max/60/0*hqrGKEG7lAVdAQJv?q=20)

[https://miro.medium.com/max/1400/0*hqrGKEG7lAVdAQJv](https://miro.medium.com/max/1400/0*hqrGKEG7lAVdAQJv)

Run the project and make a get request to fetch the list of players. You should see the players list on the page as shown below.

[https://miro.medium.com/max/60/0*QopAzjHmRKwPfEip?q=20](https://miro.medium.com/max/60/0*QopAzjHmRKwPfEip?q=20)

[https://miro.medium.com/max/1400/0*QopAzjHmRKwPfEip](https://miro.medium.com/max/1400/0*QopAzjHmRKwPfEip)

Everything is pretty straightforward so far as we are using standard services and controllers in ASP.NET Core.

# **Implementing a Logging Decorator**

The first decorator I want to attach with the above **PlayerService** is a logging decorator. This decorator will allow our service to output the log messages at runtime. This can be very useful in a production environment where you want to see how your services are working internally by logging messages to different sources. Let’s create a class **PlayerServiceLoggingDecorator** and implement the same **IPlayerService** interface on it.

**PlayersServiceLoggingDecorator.cs**

[https://miro.medium.com/max/60/0*zRgNQPHWCP4P5T0W?q=20](https://miro.medium.com/max/60/0*zRgNQPHWCP4P5T0W?q=20)

[https://miro.medium.com/max/1400/0*zRgNQPHWCP4P5T0W](https://miro.medium.com/max/1400/0*zRgNQPHWCP4P5T0W)

We are injecting the instances of **IPlayerSerice** and **ILogger** in the decorator constructor using the dependency injection. The logging decorator is implementing the **IPlayersService** interface so it has to define the **GetPlayersList** method. Inside the **GetPlayersList** method, we are calling the **GetPlayersList** method implemented by **PlayerService** and once we have the players list available, we are simply iterating over them to log their Id and Name. There are also few other **LogInformation** method calls to log different types of messages. We are also using the **Stopwatch** object to log our method execution time.

# **Implementing a Caching Decorator**

The second decorator I want to attach is a caching decorator. This decorator will allow our service to cache the player’s list for a certain amount of time so that we don’t need to fetch the data from the backend service or database again. This can be useful in applications where you want to improve your application performance. Let’s create a class **PlayersServiceCachingDecorator** and implement the same **IPlayerService** interface on it.

**PlayersServiceCachingDecorator.cs**

[https://miro.medium.com/max/60/0*4dRWLhCU2TihIP-D?q=20](https://miro.medium.com/max/60/0*4dRWLhCU2TihIP-D?q=20)

[https://miro.medium.com/max/1400/0*4dRWLhCU2TihIP-D](https://miro.medium.com/max/1400/0*4dRWLhCU2TihIP-D)

This time, we are injecting the instances of **IPlayerSerice** and **IMemoryCache** in the decorator constructor. Inside the **GetPlayersList** method, we are first checking if the player’s list with a matching cache key is available in the memory cache and returning the same list from the cache. If we don’t have the player’s list in the cache, we are calling the **GetPlayersList** method of **PlayerService** class to get the list and then adding it to the memory cache for one minute.

# **Manually Registering the Decorators with DI Container**

We are now ready to register our service and decorators so that they can be injected using the .NET Core dependency injection framework. This is where you will also see how we are wrapping one decorator into another to attach a chain of decorators to an existing service.

**Startup.cs**

[https://miro.medium.com/max/60/0*Fp2Z78fbtLZ6hgid?q=20](https://miro.medium.com/max/60/0*Fp2Z78fbtLZ6hgid?q=20)

[https://miro.medium.com/max/1400/0*Fp2Z78fbtLZ6hgid](https://miro.medium.com/max/1400/0*Fp2Z78fbtLZ6hgid)

We first registered the **PlayerService** using the **AddScoped** method. Then we requested the instance of **PlayerService** using the **GetRequiredService** method to pass it into the constructor of our **PlayersServiceCachingDecorator** class. Finally, the instance of caching decorator is passed in the **PlayersServiceLoggingDecorator** constructor.

With everything in place, let’s run the application once again and this time check what messages are logged in the output window and how much time our methods took to execute.

[https://miro.medium.com/max/60/0*EL97idzGqmHDof5a?q=20](https://miro.medium.com/max/60/0*EL97idzGqmHDof5a?q=20)

[https://miro.medium.com/max/1400/0*EL97idzGqmHDof5a](https://miro.medium.com/max/1400/0*EL97idzGqmHDof5a)

You can see all the log messages in the output window as shown in the above screenshot. The first time, our memory cache was empty that’s why the method took 28 milliseconds to execute. Refresh the player’s list page again and this time you will see that method will take less time as compared with the previous request because now the data will be fetched from the memory cache.

# **Registering the Decorators using Scrutor library**

We now have a real-world example of using a decorator pattern in an ASP.NET Core application but some of you may not like the way we manually registered our decorators with dependency injection in **Startup. cs** file. We are instantiating the decorators ourselves and passing them to other decorators by calling their constructors. What if the decorator class has many more services injected into the constructor? You don’t want to instantiate a big list of services just to pass in the decorator constructor. We want an easy way to register our decorators and this is where [Scrutor](https://github.com/khellang/Scrutor) library comes to the rescue.

The [Scrutor](https://github.com/khellang/Scrutor) is a small library that includes some extension methods for registering decorators. The simplest and the most common method is **Decorate** which allows us to register decorators just like we register normal classes in .NET. We can install the [Scrutor](https://www.nuget.org/packages/Scrutor) library using the [NuGet Package Manager](https://www.nuget.org/packages/Scrutor).

With the help of the [Scrutor](https://github.com/khellang/Scrutor) library, the registration of our decorators can be as simple as the following code snippet.

**Startup.cs**

[https://miro.medium.com/max/60/0*0WjJ_3ra7mD1BKlv?q=20](https://miro.medium.com/max/60/0*0WjJ_3ra7mD1BKlv?q=20)

[https://miro.medium.com/max/1400/0*0WjJ_3ra7mD1BKlv](https://miro.medium.com/max/1400/0*0WjJ_3ra7mD1BKlv)

Now You will run the application it behaves as expected it was working previously.

# **Dynamically Add or Remove Decorators at Runtime**

In a real-world application, you may want to add or remove decorators dynamically at runtime based on different use cases such as:

1. You may want to add a logging decorator only in the production environment but don’t want to log anything in the development environment.
2. You may want to use some configuration settings to dynamically add/remove decorators in any environment.

We can add **EnableCaching** and **EnableLogging** settings in the **appsettings.json** file and caching and logging can be enabled/disabled using these settings.

[https://miro.medium.com/max/60/0*g65AVXBULnIGnzF-?q=20](https://miro.medium.com/max/60/0*g65AVXBULnIGnzF-?q=20)

[https://miro.medium.com/max/1400/0*g65AVXBULnIGnzF-](https://miro.medium.com/max/1400/0*g65AVXBULnIGnzF-)

Here is the code to register decorators based on the above configuration settings.

**Startup.cs**

[https://miro.medium.com/max/60/0*RYL7q2Is1h0d_Te1?q=20](https://miro.medium.com/max/60/0*RYL7q2Is1h0d_Te1?q=20)

[https://miro.medium.com/max/1400/0*RYL7q2Is1h0d_Te1](https://miro.medium.com/max/1400/0*RYL7q2Is1h0d_Te1)

# **Summary**

The decorator pattern can be used to extend classes or to add cross-cutting concerns without changing their code. In this post, we learned how to use the decorator pattern to add features such as logging and caching in ASP.NET Core APIs. We also learn how to register decorators manually and using the [Scrutor](https://www.nuget.org/packages/Scrutor) library. In the end, we learned how to dynamically enable/disable decorators based on configuration settings. I hope, you will keep the decorator pattern in mind for certain use cases while developing your applications.

You can download source code from my GitHub repository(https://github.com/ankit68543/decorator-pattern

). If you like this article! Don’t forget to give me a star. :p

#Happy #Learning