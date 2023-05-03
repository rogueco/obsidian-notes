# Register Services using reflection in .NET

In this post I’m going to explain how using reflection and generics can simplify registering your services. We will go over two separate ways in how you can register your services using Interface Markers and custom attributes.

TLDR; Here is a working version of the code: [](https://github.com/rogueco/RegisterServicesWithReflection)[https://github.com/rogueco/RegisterServicesWithReflection](https://github.com/rogueco/RegisterServicesWithReflection) each method is in a different branch

### The Why?

If you’re reading this, I’m assuming that you’ve come to find an easier way to register all of your services without the need of manually typing each out. To be honest, it doesn’t matter the size of the solution that you’re working in - I’ve found that over time you and your team have added an extraordinary amount of services, all of which have been manually typed out. I found myself questioning, that surely there must be an easier way to register all services. That’s exactly what brought me down this path of reflection. I do not doubt in your stack you’ll be familiar with doing this:

<aside> 💡 I’m going to assume that we’re looking at .NET 6 as currently, it is the latest version of .NET

</aside>

```csharp
// Program.cs

// Add Services
builder.Services.AddScoped<ICustomerService, CustomerService>();
builder.Services.AddScoped<IInventoryService, InventoryService>();
builder.Services.AddSingleton<IPaymentService, PaymentService>();
builder.Services.AddTransient<IOrderService, OrderService>();

// Additional Services
```

You’re able to clean this up by moving the registration of services into a static class and adding the method to the `Program.cs` file.

```csharp
using RegisterServicesWithReflection.Services.Implementations;
using RegisterServicesWithReflection.Services.Interfaces;

namespace RegisterServicesWithReflection.Extensions;

public static class ServiceExtensions
{
    public static void RegisterServices(this IServiceCollection services, IConfiguration configuration)
    {
        services.AddScoped<ICustomerService, CustomerService>();
        services.AddScoped<IInventoryService, InventoryService>();
        services.AddSingleton<IPaymentService, PaymentService>();
        services.AddTransient<IOrderService, OrderService>();
    }
}
```

```csharp
//Program.cs

// Add Services
builder.Services.RegisterServices(builder.Configuration);
```

This doesn’t solve the problem that we have though, it makes the `Program.cs` look a lot cleaner and not bloated but we still have the same problem with having to manually type out each Service.

At this stage, we can introduce one of the anti-patterns that we can use to fix this issue. I’m going to talk about the Microsoft recommended approach and the overall more preferable method.

### Custom Attribute Method

We’re going to utilise attributes to access a types metadata, then register their attached classes. If you don’t already have an understanding of what an attribute is, Microsoft define an attribute as:

> “...*add keyword-like descriptive declarations, called attributes, to annotate programming elements such as types, fields, methods, and properties.”

“.NET uses attributes for a variety of reasons and to address a number of issues. Attributes describe how to serialize data, specify characteristics...”*

So, back to the question at hand, how do we register all the services without the need of manually typing each out? We’re going to define a set of custom attributes that will then be utilised to access the metadata of their class/interface that they are defined on.

```csharp
// Defining a set of attribute
public class ScopedRegistrationAttribute : Attribute { }

public class SingletonRegistrationAttribute : Attribute { }

public class TransientRegistrationAttribute : Attribute { }
```

The defined attributes, now need to be appended to their classes/interfaces that we wish to access via the use of reflection.

```csharp
[ScopedRegistration]
public interface ICustomerService 
{
	// Code...
}

[SingletonRegistration]
public interface IOrderService 
{
	// Code...
}

[TransientRegistration]
public interface IPaymentService 
{
	// Code...
}
```

Now that we’ve appended the attributes to the interfaces that we wish to access, we need to start building up our reflection method to grab all of the relevant types.

Firstly, we’re going to want to define all of the attributes that we want to target we’re going to use these as a filter to grab all of the types that have this attribute.

```csharp

using RegisterServicesWithReflection.Services.Base;

namespace RegisterServicesWithReflection.Extensions;

public static class ServiceExtensions
{
    public static void RegisterServices(this IServiceCollection services, IConfiguration configuration)
    {
        // Define types that need matching
        Type scopedRegistration = typeof(ScopedRegistrationAttribute);
        Type singletonRegistration = typeof(SingletonRegistrationAttribute);
        Type transientRegistration = typeof(TransientRegistrationAttribute); 
      
    }
}
```

By calling `AppDomain.CurrentDomain.GetAssemblies().SelectMany(s => s.GetTypes())` we return all of the types that have been included in our project. We only want the types that have our custom attribute appended to, we also want to make sure that we only grab either the `Interface` or the `Class`. Finally, we want to create an anonymous object that contains the Service (interface) and the Implementation (class)

```csharp

using RegisterServicesWithReflection.Services.Base;

namespace RegisterServicesWithReflection.Extensions;

public static class ServiceExtensions
{
    public static void RegisterServices(this IServiceCollection services, IConfiguration configuration)
    {
        // Define types that need matching
        Type scopedRegistration = typeof(ScopedRegistrationAttribute);
        Type singletonRegistration = typeof(SingletonRegistrationAttribute);
        Type transientRegistration = typeof(TransientRegistrationAttribute); 

        var types = AppDomain.CurrentDomain.GetAssemblies()
            .SelectMany(s => s.GetTypes())
            .Where(p =>  p.IsDefined(scopedRegistration, true) || p.IsDefined(transientRegistration, true) || p.IsDefined(singletonRegistration, true) && !p.IsInterface).Select(s => new
            {
                Service = s.GetInterface($"I{s.Name}"),
                Implementation = s 
            }).Where(x => x.Service != null);
    }
}
```

After getting all of the filter types, all that is left to do is iterate over our array and register the service, based on the defined attribute. All of your services that have the custom attribute defined will now be registered in the application.

```csharp

using RegisterServicesWithReflection.Services.Base;

namespace RegisterServicesWithReflection.Extensions;

public static class ServiceExtensions
{
    public static void RegisterServices(this IServiceCollection services, IConfiguration configuration)
    {
        // Define types that need matching
        Type scopedRegistration = typeof(ScopedRegistrationAttribute);
        Type singletonRegistration = typeof(SingletonRegistrationAttribute);
        Type transientRegistration = typeof(TransientRegistrationAttribute); 

        var types = AppDomain.CurrentDomain.GetAssemblies()
            .SelectMany(s => s.GetTypes())
            .Where(p =>  p.IsDefined(scopedRegistration, true) || p.IsDefined(transientRegistration, true) || p.IsDefined(singletonRegistration, true) && !p.IsInterface).Select(s => new
            {
                Service = s.GetInterface($"I{s.Name}"),
                Implementation = s 
            }).Where(x => x.Service != null);

        foreach (var type in types)
        {
            if (type.Service.IsDefined(scopedRegistration, true))
            {
                services.AddScoped(type.Service, type.Implementation);
            }
            
            if (type.Service.IsDefined(transientRegistration, true))
            {
                services.AddTransient(type.Service, type.Implementation);
            }
            
            if (type.Service.IsDefined(singletonRegistration, true))
            {
                services.AddSingleton(type.Service, type.Implementation);
            }
        }
    }
}
```

Then we just need to call in our `Startup.cs` or `Program.cs` file

```csharp
// Program.cs (.net6)
builder.Services.RegisterServices(builder.Configuration);
```

Heres a link to a working version of this method: [](https://github.com/rogueco/RegisterServicesWithReflection)[https://github.com/rogueco/RegisterServicesWithReflection](https://github.com/rogueco/RegisterServicesWithReflection)

There is an alternative way in how you can register your services and that is via the use of Interface Markers. I just want to iterate once again, that Microsoft does not recommend the use of Interface Markers - but like with most things, I do believe that have their place and can be very useful. It’s worth noting that the implementation of these two methods will be very similar.

### Interface Markers

The Interface Markers are something that I became familiar with at a previous position where I needed to stitch together data from multiple unrelated entities and display it in a table. This pattern allowed me to do this, it is considered an Anti-Pattern. It’s probably one of the simplest patterns to implement.

```csharp
public interface IMarkerPattern { }

public class Inventory : IMarkerPatten 
{
	public int Id {get; set;}
	public string Title {get; set;}
	public string Description {get; set;}
	public decimal Price {get; set;}
	
	// .... 
}
```

That’s it, that’s how you implement the pattern - if you can call it that? The purpose of the empty `IMarkerPattern` interface isn’t what you see above, its purpose is when trying to access its metadata via the use of reflection and generics, that’s when the power of this pattern shines.

Firstly we need to create some empty interfaces so we can identify if they need to be Scoped, Transient, Singleton etc:

```csharp
public interface IScopedService { }
public interface ITransientService { }
public interface ISingletonService { }
```

Let’s say we have one of each lifetime that we want to register - we’ll also use the repository pattern.

```csharp
// interfaces
public interface ICustomerService : IServiceScope { }

public interface IProductService : IServiceTransient { }

public interface IOrderService : IServiceSingleton { }
```

```csharp
// classes
public class Customer : ICustomerService { }

public class Product : IProductService { }

public class Order : IOrderService { }
```

In the `RegisterServices` method, we now need to utilise reflection to get the metadata. For brevity, I’ll break down each part of the method.

```csharp
// RegisterServices
	{
		// Define types that need matching
		Type scopedService = typeof(IScopedService);
		Type singletonService = typeof(ISingletonService);
		Type transientService = typeof(ITransientService); 

	// Rest of method
	}

```

Now we need to grab all of the types that have been registered in the application, then we’re filtering to ensure that each of the types we defined above is assignable to the type. This will give us all of the Interfaces and Classes needed. Then we’re creating a new anonymous object that contains the Service (interface) and the Implementation (class)

```csharp
// Code excluded
		var types = AppDomain.CurrentDomain.GetAssemblies()
                .SelectMany(s => s.GetTypes())
                .Where(p => scopedService.IsAssignableFrom(p) || transientService.IsAssignableFrom(p) || singletonService.IsAssignableFrom(p) && !p.IsInterface).Select(s => new
                {
                    Service = s.GetInterface($"I{s.Name}"),
                    Implementation = s 
                }).Where(x => x.Service != null);

// Rest of method
```

We need to iterate over all of the types and register the service based on the assignable type, the completed method will look like this.

```csharp
public static class ServiceExtensions
{
	public static void RegisterServices(this IServiceCollection services, IConfiguration configuration)
	{
		// Define types that need matching
		Type scopedService = typeof(IScopedService);
		Type singletonService = typeof(ISingletonService);
		Type transientService = typeof(ITransientService); 

		var types = AppDomain.CurrentDomain.GetAssemblies()
                .SelectMany(s => s.GetTypes())
                .Where(p => scopedService.IsAssignableFrom(p) || transientService.IsAssignableFrom(p) || singletonService.IsAssignableFrom(p) && !p.IsInterface).Select(s => new
                {
                    Service = s.GetInterface($"I{s.Name}"),
                    Implementation = s 
                }).Where(x => x.Service != null);

		foreach (var type in types)
		{
			if (scopedService.IsAssignableFrom(type.Service))
			{
				services.AddScoped(type.Service, type.Implementation);
      }

			if (transientService.IsAssignableFrom(type.Service))
			{
				services.AddTransient(type.Service, type.Implementation);
      }

			if (singletonService.IsAssignableFrom(type.Service))
			{
				services.AddSingleton(type.Service, type.Implementation);
      }
		}
	}
}
```

Once you call the `RegisterServices()` in your `program.cs` all of the services that you appended with the `I{Type}Service` will now be registered in the application. Your application will work as before, without the need to manually register each service.

Here is a link to this version of the code: [](https://github.com/rogueco/RegisterServicesWithReflection/tree/MarkerInterface)[https://github.com/rogueco/RegisterServicesWithReflection/tree/MarkerInterface](https://github.com/rogueco/RegisterServicesWithReflection/tree/MarkerInterface)

There you have it, a couple of different ways in how to register your services without the need to manually type them out.

As previously mentioned, Microsoft recommends that you don’t use empty interfaces (ref here: [](https://docs.microsoft.com/en-us/dotnet/standard/design-guidelines/interface?redirectedfrom=MSDN)[https://docs.microsoft.com/en-us/dotnet/standard/design-guidelines/interface?redirectedfrom=MSDN](https://docs.microsoft.com/en-us/dotnet/standard/design-guidelines/interface?redirectedfrom=MSDN)) but instead use Custom Attributes.

References:
[Accessing Attributes by Using Reflection (C#)](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/attributes/accessing-attributes-by-using-reflection)

[Dependency injection in ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/dependency-injection?view=aspnetcore-6.0)

[Interface Design - Framework Design Guidelines](https://docs.microsoft.com/en-us/dotnet/standard/design-guidelines/interface)

[Extending Metadata Using Attributes](https://docs.microsoft.com/en-us/dotnet/standard/attributes/)