# .Net core Dependency Injection: Lifetimes and few best practices

Article Link: https://levelup.gitconnected.com/net-core-dependency-injection-lifetimes-and-few-best-practices-e194d2a39eff
Author: Madhavan Nagarajan
Date Added: October 8, 2021 10:00 AM
Tag: .NET, Best Practices, Dependency Injection

![https://miro.medium.com/max/2000/0*ftkCv0zF9KmQvSM7.png](https://miro.medium.com/max/2000/0*ftkCv0zF9KmQvSM7.png)

Before we delve into the ***Dependency Injection(DI)*** in ‘.Net core’, it is important to understand why do we need the sorcery **DI** at all.

Let's start by exploring what is ***Dependency Inversion Principle(DIP)*** is. DIP allows you to decouple two classes that otherwise are very tightly coupled which help improving reusability and more maintainability.

> DIP states,
> 
> 
> *1. High-level modules should not depend on low-level modules. Both should depend on abstractions.*
> 
> *2. Abstractions should not depend on details. Details should depend on abstractions.*
> 

For the sake of this discussion, let's ignore the latter and look deeper into the former with an example

```
class Foo {
  Foo(Car _car){
    // something
  }
}
```

In the above snippet of the code, the class `Foo` is having a direct dependency on the class `car`. This tight coupling between these classes will bring along two major problems

1. `Foo` cannot be instantiated with a different flavour of `car` i.e, if there is a new car class eg:`Sedan` comes the `Foo` cannot be reused for that
2. Any change of contract in the `car` will now affect the `Foo` directly increasing the overhead of maintenance.

To avoid both of these problems DIP suggest that higher-level module `Foo` should not have a direct dependency on the lower level module `Car` rather both should depend on an abstraction eg: interface.

```
class Foo {
  Foo(ICar _car){
    // something
  }
}class Car : ICar {

}class Sedan : ICar{}
```

Just by introducing a simple abstraction `ICar` the `Foo` becomes compatible to use to any class that adheres to the contract or abstraction `ICar` .

So now how this links to the Dependency Injection?

DIP improves the reusability of the code and limits the wave effect if you need to change lower-level classes. Even when DIP is perfectly implemented, the interface only decouples the usage of the lower-level class in the higher-level class but not its instantiation. At some place in the code, you need to instantiate an implementation of the interface. That prevents you from replacing the implementation of the interface with a different one on the fly.

Dependency Injection comes here in play helping to separate usage if the instance from the creation. Simply to say whenever the DI framework sees a dependency of any registered service in a class it will provide a concrete instantiation.

Assume `ICar` is registered in the DI framework to provide an instance of `Car` , then the constructor of `Foo` always receives a concrete instance of `car` for each `Foo` object instantiation.

## **DI in .Net core:**

Before the .Net core framework arrived we should configure a third party DI framework like [Castle Windsor](https://github.com/castleproject/Windsor), [Autofac](https://github.com/autofac/Autofac) and many others. However, in .Net core DI is available right out of the box. The “Startup” class provides a method called `configureServices` that is the place for the developer to register the services and classes to the container.

```
public class Startup {  // ...  public void ConfigureServices(IServiceCollection services) {
    services.AddTransient<ICar, Car>();
  }
  // ...
}
```

So for each request, the controller gets invoked with all the dependencies resolved from the container. All of this is available in .Net core without complex configurations. .Net also provides few flavours in the lifetime of the created instances that might come handy during specific motives. let’s take a look-see into those.

## **Dependency Lifetimes:**

At the time of registration, it is needed to specify the lifetime of the service. This lifetime definition gives an idea of when a new instance gets created. There are three different flavours.

1. Transient
2. Scoped
3. Singleton

**Transient:** This lifetime definition makes DI to create a new instance whenever requested

**Scoped:** This makes DI to create a new instance for each new scope. Here scope refers usually to a new web request.

**Singleton:** This creates a new instance only on the first request and the same instance is served to all the consumer class for the rest of the application lifetime.

## **Good Practices**

1. Scoped services should be normally used by a single web-request/thread. Therefore, you should not share service scopes across threads.
2. Services configured as a singleton might cause Memory Leaks in the application.
3. **Memory leaks** are generally caused by singleton services. This is because the instance created is not disposed of, it will stay in memory until the end of the application. So it is good to release them once they are not used.
4. With services registered as transient has a shorted lifespan so you might generally don’t care too much about the **multi-threading** and **memory leaks.**
5. **Do not depend** on a transient or scoped service in a singleton service. Because the transient service becomes a singleton instance when a singleton service injects it and that may cause problems if the transient service is not designed to support such a scenario. ASP.NET Core’s default DI container already throws **exceptions** in such cases.

## **Summary**

DIP insists on creating an abstraction (interface) between a higher-level class and its dependencies. This helps in decoupling the higher-level class from its dependencies so that any change to the lower-level class will not affect the higher-level class. The only piece of code that uses a dependency directly is the one that is responsible for the instantiation an object of the class that implements the interface.

The dependency injection technique enables you to improve this even further. It provides a way to separate the creation of an object from its usage. By doing that, you can replace a dependency without changing any code and it also reduces the boilerplate code in your business logic.