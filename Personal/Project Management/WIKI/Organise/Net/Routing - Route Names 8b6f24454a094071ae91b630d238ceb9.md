# Routing - Route Names

Created: August 26, 2020 3:11 PM

Using the URL path `/products3`:

- The `MyProductsController.ListProducts` action runs when the [HTTP verb](https://docs.microsoft.com/en-us/aspnet/core/mvc/controllers/routing?view=aspnetcore-3.1#verb) is `GET`.
- The `MyProductsController.CreateProduct` action runs when the [HTTP verb](https://docs.microsoft.com/en-us/aspnet/core/mvc/controllers/routing?view=aspnetcore-3.1#verb) is `POST`.

When building a REST API, it's rare that you'll need to use `[Route(...)]` on an action method because the action accepts all HTTP methods. It's better to use the more specific [HTTP verb attribute](https://docs.microsoft.com/en-us/aspnet/core/mvc/controllers/routing?view=aspnetcore-3.1#verb) to be precise about what your API supports. Clients of REST APIs are expected to know what paths and HTTP verbs map to specific logical operations.

REST APIs should use attribute routing to model the app's functionality as a set of resources where operations are represented by HTTP verbs. This means that many operations, for example, GET and POST on the same logical resource use the same URL. Attribute routing provides a level of control that's needed to carefully design an API's public endpoint layout.

Since an attribute route applies to a specific action, it's easy to make parameters required as part of the route template definition. In the following example, `id` is required as part of the URL path:

C#Copy

```csharp
[ApiController]
public class Products2ApiController : ControllerBase
{
    [HttpGet("/products2/{id}", Name = "Products_List")]
    public IActionResult GetProduct(int id)
    {
        return ControllerContext.MyDisplayRouteInfo(id);
    }
}

```

The `Products2ApiController.GetProduct(int)` action:

- Is run with URL path like `/products2/3`
- Isn't run with the URL path `/products2`.

The [[Consumes]](https://docs.microsoft.com/en-us/dotnet/api/microsoft.aspnetcore.mvc.consumesattribute) attribute allows an action to limit the supported request content types. For more information, see [Define supported request content types with the Consumes attribute](https://docs.microsoft.com/en-us/aspnet/core/web-api/?view=aspnetcore-3.1#consumes).

See [Routing](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/routing?view=aspnetcore-3.1) for a full description of route templates and related options.

For more information on `[ApiController]`, see [ApiController attribute](https://docs.microsoft.com/en-us/aspnet/core/web-api/?view=aspnetcore-3.1##apicontroller-attribute).

## **Route name**

The following code defines a route name of `Products_List`:

C#Copy

```csharp
[ApiController]
public class Products2ApiController : ControllerBase
{
    [HttpGet("/products2/{id}", Name = "Products_List")]
    public IActionResult GetProduct(int id)
    {
        return ControllerContext.MyDisplayRouteInfo(id);
    }
}

```

Route names can be used to generate a URL based on a specific route. Route names:

- Have no impact on the URL matching behavior of routing.
- Are only used for URL generation.

Route names must be unique application-wide.

Contrast the preceding code with the conventional default route, which defines the `id` parameter as optional (`{id?}`). The ability to precisely specify APIs has advantages, such as allowing `/products` and `/products/5` to be dispatched to different actions.

### **Generate URLs by route**

The preceding code demonstrated generating a URL by passing in the controller and action name. `IUrlHelper` also provides the [Url.RouteUrl](https://docs.microsoft.com/en-us/dotnet/api/microsoft.aspnetcore.mvc.iurlhelper.routeurl) family of methods. These methods are similar to [Url.Action](https://docs.microsoft.com/en-us/dotnet/api/microsoft.aspnetcore.mvc.iurlhelper.action), but they don't copy the current values of `action` and `controller` to the route values. The most common usage of `Url.RouteUrl`:

- Specifies a route name to generate the URL.
- Generally doesn't specify a controller or action name.

C#Copy

```csharp
public class UrlGeneration2Controller : Controller
{
    [HttpGet("")]
    public IActionResult Source()
    {
        var url = Url.RouteUrl("Destination_Route");
        return ControllerContext.MyDisplayRouteInfo("", $" URL = {url}");
    }

    [HttpGet("custom/url/to/destination2", Name = "Destination_Route")]
    public IActionResult Destination()
    {
        return ControllerContext.MyDisplayRouteInfo();
    }

```

The following Razor file generates an HTML link to the `Destination_Route`:

CSHTMLCopy

```
<h1>Test Links</h1>

<ul>
    <li><a href="@Url.RouteUrl("Destination_Route")">Test Destination_Route</a></li>
</ul>
```