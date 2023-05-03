# Layered Architecture with ASP.NET Core, Entity Framework Core and Razor Pages

Article Link: https://medium.com/aspnetrun/layered-architecture-with-asp-net-core-entity-framework-core-and-razor-pages-53a54c4028e3
Author: Mehmet Özkaya
Date Added: October 26, 2021 8:00 AM
Tag: .NET, Architecture

*This article explains **[aspnetrun core repository of github](https://github.com/aspnetrun/run-aspnetcore)**. This series of articles continues as per difficulty levels. This article intended for the **intermediate** of asp.net core. You can follow the other articles at the end of the page.*

# **Introduction**

In this article we will show how to **Create Layered Application** with performing CRUD operations on ASP.NET Core Web application using Entity Framework and Razor Pages.

By the end of the article, we will have an web application which implemented NLayer **Hexagonal architecture** (Core, Application, Infrastructure and Presentation Layers) and **Domain Driven Design** (Entities, Repositories, Domain/Application Services, DTO’s…) over the CRUD operations.

Take a look at the final application.

![https://miro.medium.com/max/700/1*D1_QV9o5m7ZHds0_C-OUzw.png](https://miro.medium.com/max/700/1*D1_QV9o5m7ZHds0_C-OUzw.png)

You’ll learn how to:

- Create Layered Application with ASP.NET Core Web Application Project
- N-Layer **Hexagonal architecture** (Core, Application, Infrastructure and Presentation Layers)
- **Domain Driven Design** (Entities, Repositories, Domain/Application Services, DTO’s…)
- **Clean Architecture**, with applying **SOLID principles**
- **Best practices** like **loosely-coupled, dependency-inverted** architecture and using **design patterns** such as **Dependency Injection**, logging, validation, exception handling, localization and so on.
- **Repository** and **Specification** Design Pattern
- Test Driven Development (TDD) technics

# **Source Code**

**Get the [Source Code from AspnetRun Github](https://github.com/aspnetrun/run-aspnetcore)** — Clone or fork this repository, if you like don’t forget the star :) If you find or ask anything you can directly open issue on repository.

# **Prerequisites**

- Install the .NET Core 3.1 or above SDK
- Install Visual Studio 2019 v16.x or above
- Microsoft Sql Server Express (its comes with Visual Studio)

# **Background**

Most of the web applications following common steps when you start a new web application. Based on that we will create an extendable base infrastructure which implemented best practices on layered architecture. So lets create our crud operations on asp.net core web application with layered architecture.

# **Design Principles**

First of all, we are going to start with remembering the core concepts, principles of layered architecture design. We are going to start with small principles and continue to design patterns which all of these items are used our ASP.NET Core Layered Architecture project.

## **Dependency Inversion Principles (DIP)**

To summarize the term dependency briefly, we can explain that a class is dependent on another class, that is, a class needs another class to work. As we see in the figure below, **the upper-level layer uses the lower-level layer** (classes, interfaces, etc.). we can say that the level is dependent on the layer. As for the term **re-usability**; Firstly, we think that a class can be written and used in various parts of the project, but we can define a code that we use as a real reuse and a higher level library can be used in other projects without touching the code. We cannot do this because of the interdependence of classes in well-designed software. At this point, **Dependency Inversion Principle (DIP)**, which is an important software principle that needs to be implemented in order to develop more flexible and reusable modules, comes into play. Briefly explain this method;

> Upper-level modules, classes, etc., lower-level classes must not be dependent on modules. Lower-level modules must be dependent on higher-level modules (interfaces of modules). For short, we call it Dependency Inversion.
> 

Let’s see how I applied this principle in the next example:

![https://miro.medium.com/max/700/0*geE-7KHB3wCCcL3h.png](https://miro.medium.com/max/700/0*geE-7KHB3wCCcL3h.png)

On the left side we found an Layered Application where the **Business Logic** **depends on** the **SqlDatabase** implementation. It is a coupled way to write code. On the right side, by adding an **IRepository** and applying DIP then the SqlDatabase has its dependency pointing inwards.

## **Separation of Concerns (SoC)**

SoC says that the elements in the software should be unique to them, not to share their responsibilities with other staff members. The necessity of separate responsibilities is the basic point that this principle underlines. While developing the software, the concepts we can call an **boundaries** “may be the clearest words that distinguish these responsibilities from one another. From the simplest, we **distinguish between the concepts of layer** and tier and certain **responsibilities**. If we enter a little more, the namespaces of our software components can also be used as limits to allocate responsibilities. The degree of adherence to the components within the software and the cohesion within the components are two important concepts for the **SoC principle**. It should always be preferred that the degree of commitment of the components is low and that the relationship of responsibility in a component is high. So **low-coupling, high-cohesion** is indispensable. If the degree of commitment is low, then the control of the software will be easier in our hand, since the liability will be distributed per component. Being close to each other in their responsibilities within the components will reveal re-usability.

We can give an example of SoC that development of Web UI. As you can see that UI element i.e. button needs to configure by 3 structure; HTML— CSS — JS.

![https://miro.medium.com/max/700/0*2iNDjtrp3YKK-B22.jpg](https://miro.medium.com/max/700/0*2iNDjtrp3YKK-B22.jpg)

# **Don’t Repeat Yourself (DRY)**

In the software we develop, the solutions we create as a solution must be one in the software. If we cannot prevent this, for a problem, **more than one version** of the same solution will find itself in the code. It develops, develops, grows and makes the code more **difficult to maintain**. The fact that the same validation is done with a different string operation leads to **inconsistency** in the software. When you write code, it is best to re-use the solution if you think that it is similar to a similar solution before. **To** **implement the DRY principle**, it will be encapsulate common solutions into unique places in your code.

## **Persistence Ignorance (PI)**

**Persistence Ignorance (PI)** principle maintains that in a software application classes that model the field of work should not be affected by how they are persisted. Therefore, their design should reflect as closely as possible the ideal design required to solve the **operational problem** and should not be emphasized as to how the status of the objects are recorded and then taken. Some **common Persistence Ignorance violations** include domain objects that need to inherit from a given base class or must show specific properties. Sometimes insight information takes the form of properties that must be applied to the class, or it only supports certain collection types or property visibility levels. There are perspectives of ignorance, the oldest **CLR Objects (POCOs)** in .NET.

## **Bounded Context**

Although the Entities represent an object in their own right, there will be situations in real life that are often required to be done in a collaborative manner. The combination of more than one Entity related to each other to perform the rule is defined as **Aggregate**. When all **AR (Aggregate Roots)** are examined within the framework of business rules, logically the most closely related ones start to form a more clearly defined group. This grouped ARs are called “**Bounded Context**“. Each AR and Entity have a meaning in this cluster and have a clear responsibility.

# **Design Patterns**

Now, we are going to examine some of design patterns which implemented in our [aspnetrun-core project](https://github.com/aspnetrun/run-aspnetcore).

## **Repository Pattern**

**Repository** is a concept that is used in order to write the information of all entity and value objects in an aggregate to the database. For each AR itself, we will perform the DB operations over the Repository as a whole in the transactinal structure. Repository basically prevents database work from being moved from the workstation to a database, thus preventing query and code repetition. In other words, the main purpose is to process data and interrogations into a central structure avoiding repetitions. In this way, we stay away from writing our database operations again and again in the business layer. The Repository Design Pattern has brought the logic of the sections that make the actual work in your program and the sections that access the data from each other. That is, it acts as an interface between the data layer and the business layer that uses this layer, and it also acts as an abstraction between these two layers. AspnetRun Repository and Specification implementation. This class responsible to create queries, includes, where conditions etc..

![https://miro.medium.com/max/320/0*nXv2nUJUbqmGZoIO.png](https://miro.medium.com/max/320/0*nXv2nUJUbqmGZoIO.png)

## **Specification Pattern**

**Specification Design Pattern** is created to ensure that the **logical rules** in an object are received from the outside. The rules of business are in a chain of successive chains, which may also reveal a more complex business rule.

I want to continue with a code example to understand the pattern. In repository Specification Pattern implemented by interface definition ;

```
public interface ISpecification<T>
    {
        Expression<Func<T, bool>> Criteria { get; }
        List<Expression<Func<T, object>>> Includes { get; }
        List<string> IncludeStrings { get; }
        Expression<Func<T, object>> OrderBy { get; }
        Expression<Func<T, object>> OrderByDescending { get; }        int Take { get; }
        int Skip { get; }
        bool isPagingEnabled { get; }
    }
```

These definition and below implementation located in **Core Layer.** Because these classes not included Entity Framework Core related dependencies.

```
public abstract class BaseSpecification<T> : ISpecification<T>
    {
        protected BaseSpecification(Expression<Func<T, bool>> criteria)
        {
            Criteria = criteria;
        }
        public Expression<Func<T, bool>> Criteria { get; }
        public List<Expression<Func<T, object>>> Includes { get; } = new List<Expression<Func<T, object>>>();
        public List<string> IncludeStrings { get; } = new List<string>();
        public Expression<Func<T, object>> OrderBy { get; private set; }
        public Expression<Func<T, object>> OrderByDescending { get; private set; }        public int Take { get; private set; }
        public int Skip { get; private set; }
        public bool isPagingEnabled { get; private set; } = false;        protected virtual void AddInclude(Expression<Func<T, object>> includeExpression)
        {
            Includes.Add(includeExpression);
        }
        protected virtual void AddInclude(string includeString)
        {
            IncludeStrings.Add(includeString);
        }
        protected virtual void ApplyPaging(int skip, int take)
        {
            Skip = skip;
            Take = take;
            isPagingEnabled = true;
        }
        protected virtual void ApplyOrderBy(Expression<Func<T, object>> orderByExpression)
        {
            OrderBy = orderByExpression;
        }
        protected virtual void ApplyOrderByDescending(Expression<Func<T, object>> orderByDescendingExpression)
        {
            OrderByDescending = orderByDescendingExpression;
        }
    }
```

Specification Pattern implemented from [Microsoft article.](https://docs.microsoft.com/en-us/dotnet/standard/microservices-architecture/microservice-ddd-cqrs-patterns/infrastructure-persistence-layer-implemenation-entity-framework-core)

# **Architecture Approaches**

Hexagonal Architecture (aka Ports and Adapters) is one strategy to decouple the use cases from the external details. It was coined by Alistar Cockburn more than 13 years ago, and this received improvements with the **Onion** and **Clean Architectures**.

![https://miro.medium.com/max/700/0*42M0KbgU3P2EiP5N.jpg](https://miro.medium.com/max/700/0*42M0KbgU3P2EiP5N.jpg)

**This project ([AspnetRun-Core](https://github.com/aspnetrun/run-aspnetcore)),** implements **NLayer Hexagonal** architecture (**Core**, **Application**, **Infrastructure** and **Presentation** Layers) and **Domain Driven Design** (Entities, Repositories, Domain/Application Services, DTO’s…). Also implements and provides a good **infrastructure** to implement **best practices** such as Dependency Injection, logging, validation, exception handling, localization and so on. Aimed to be a **Clean Architecture** also called **Onion Architecture**, with applying **SOLID principles** in order to use for a project template. The below image represents aspnetrun-core approach of development architecture of run repository series;

![https://miro.medium.com/max/484/0*fyoZ2dspRvkECMMY.png](https://miro.medium.com/max/484/0*fyoZ2dspRvkECMMY.png)

According to this diagram, we applied these layers and detail components in our project. So the result of the project structure occurred as below;

# **Project Structure**

## **Core**

- Entities
- Interfaces
- Specifications
- ValueObjects
- Exceptions

## **Application**

- Interfaces
- Services
- Dtos
- Mapper
- Exceptions

## **Infrastructure**

- Data
- Repository
- Services
- Migrations
- Logging
- Exceptions

## **Web**

- Interfaces
- Services
- Pages
- ViewModels
- Extensions
- Mapper

# **Starting Our Project**

In this article we will show how to **Create Layered Application** with performing CRUD operations. Before we start, we have to understand our domain even there is no much required analysis its good habit to start with domain examination. We should define our basic use case analysis.

We should define our basic use case analysis. In this post we will create **Product — Category entities** and create its relation. Our main use case is Listing Products into Product Page and able to search products. Also performed CRUD operations on Product entity. In our example Product has only 1 category.

As per previous headings you saw clean architecture and we are going to create 4 layer;

- Core
- Application
- Infrastructure
- Web

# **Core Layer**

Development of **Domain Logic** with **abstraction**. Interfaces drives business requirements with **light implementation**. The Core project is the center of the Clean Architecture design, and all other project dependencies should point toward it.

Lets see which folders included in this Core Layer;

## **Entities**

Includes Entity Framework Core Entities which creates sql table with Entity Framework **Core Code First Approach**. Some Aggregate folders holds entity and aggregates. You can see example of code-first Entity definition in Product.cs. Applying domain driven approach, Product class responsible to create Product instance.

The first point of implementation is definition of Entity. Because we are choosing code-first approach of Entity Framework Core and this separate this entities to Core layer in order to write only one place.

```
public class Product : BaseEntity
    {
        public string ProductName { get; set; }
        public string QuantityPerUnit { get; set; }
        public decimal? UnitPrice { get; set; }
        public short? UnitsInStock { get; set; }
        public short? UnitsOnOrder { get; set; }
        public short? ReorderLevel { get; set; }
        public bool Discontinued { get; set; }
        public int CategoryId { get; set; }
        public Category Category { get; set; }    public static Product Create(int productId, int categoryId, string name, decimal? unitPrice = null, short? unitsInStock = null, short? unitsOnOrder = null, short? reorderLevel = null, bool discontinued = false)
    {
      var product = new Product
      {
      Id = productId,
      CategoryId = categoryId,
      ProductName = name,
      UnitPrice = unitPrice,
      UnitsInStock = unitsInStock,
      UnitsOnOrder = unitsOnOrder,
      ReorderLevel = reorderLevel,
      Discontinued = discontinued
    };
    return product;
    }
  }
```

As you can see that, any entity class should inherit from BaseEntity.cs. This class include Id field with int type. If you want to change Id field type, you should change only BaseEntity.cs.

Also Category entity should be created;

```
public class Category : BaseEntity
    {
        public Category()
        {
            Products = new HashSet<Product>();
        }        public string CategoryName { get; set; }
        public string Description { get; set; }
        public ICollection<Product> Products { get; private set; }
    }
```

## **Interfaces**

Abstraction of Repository — Domain repositories (IAsyncRepository — IProductRepository) — Specifications etc.. This interfaces include database operations without any application and UI responsibilities.

Core layer has Interfaces folder which basically include abstraction of dependencies. So when we create new 2 entity if we need to operate some custom database operation we should create repository classes ;

```
public interface IProductRepository : IAsyncRepository<Product>
    {
        Task<IEnumerable<Product>> GetProductListAsync();
        Task<IEnumerable<Product>> GetProductByNameAsync(string productName);
        Task<IEnumerable<Product>> GetProductByCategoryAsync(int categoryId);
    }  public interface ICategoryRepository : IAsyncRepository<Category>
    {
        Task<Category> GetCategoryWithProductsAsync(int categoryId);
    }
```

## **Specifications**

This folder is implementation of [specification pattern](https://en.wikipedia.org/wiki/Specification_pattern). Creates custom scripts with using **ISpecification** interface. Using BaseSpecification managing Criteria, Includes, OrderBy, Paging. This specs runs when EF commands working with passing spec. This specs implemented SpecificationEvaluator.cs and creates query to AspnetRunRepository.cs in ApplySpecification method.This helps create custom queries.

# **Infrastructure Layer**

Implementation of Core interfaces in this project with **Entity Framework Core** and other dependencies. Most of your application’s dependence on external resources should be implemented in classes defined in the Infrastructure project. These classes must implement the interfaces defined in Core. If you have a very large project with many dependencies, it may make sense to have more than one Infrastructure project (eg Infrastructure.Data), but in most projects one Infrastructure project that contains folders works well.

This could be includes, for example, **e-mail providers, file access, web api clients**, etc. For now this repository only dependent sample data access and basic domain actions, by this way there will be no direct links to your Core or UI projects.

Lets see which folders included in this Core Layer;

## **Data**

Includes Entity Framework Core **Context** and **tables** in this folder. When new entity created, it should add to context and configure in context. The Infrastructure project depends on **Microsoft.EntityFrameworkCore.SqlServer** and EF.Core related nuget packages, you can check nuget packages of Infrastructure layer. If you want to change your data access layer, it can **easily be replaced** with a lighter-weight ORM like Dapper.

We were choosing code-first approach of Entity Framework Core so we should add entities into Entity Framework Core Context object in order to reflect database.

```
public class AspnetRunContext : DbContext
{
        public DbSet<Product> Products { get; set; }
        public DbSet<Category> Categories { get; set; }
}
```

At above, we added database sets of entity objects into our Entity Framework Core context. By this way we can navigate this entities with InMemory and Read Sql Server databases.

## **Migrations**

This folder includes Entity Framework Core generated migration classes which scaffolding from add-migration and update-database commands.

## **Repository**

Repository implementations of Infrastructure layer has Entity Framework Core context, wrapper class and Repositories which perform db operations via EF Context object.

> Its not mandatory to create and implement repository classes, IAsyncRepository and its implementation class AspnetRunRepository.cs is cover all crud operations. So if you have custom database requirements than you should choose this way.
> 

```
public class ProductRepository : Repository<Product>, IProductRepository
    {
        public ProductRepository(AspnetRunContext dbContext) : base(dbContext)
        {
        }

        public async Task<IEnumerable<Product>> GetProductListAsync()
        {
            // return await GetAllAsync();

            var spec = new ProductWithCategorySpecification();
            return await GetAsync(spec);
        }

        public async Task<IEnumerable<Product>> GetProductByNameAsync(string productName)
        {
            var spec = new ProductWithCategorySpecification(productName);
            return await GetAsync(spec);
        }

        public async Task<IEnumerable<Product>> GetProductByCategoryAsync(int categoryId)
        {
            return await _dbContext.Products
                .Where(x => x.CategoryId==categoryId)
                .ToListAsync();
        }
    }

public class CategoryRepository : Repository<Category>, ICategoryRepository
    {
        public CategoryRepository(AspnetRunContext dbContext) : base(dbContext)
        {
        }

        public async Task<Category> GetCategoryWithProductsAsync(int categoryId)
        {
            var spec = new CategoryWithProductsSpecification(categoryId);
            var category = (await GetAsync(spec)).FirstOrDefault();
            return category;
        }
    }
```

As you can see that these implementation classes inherit from base Repository.cs in order to use Entity Framework Core dbContext object and use benefits from db abstractions.

## **Services**

This folder includes custom services implementation, like email, cron jobs etc.

# **Application Layer**

This layer for Development of Domain Logic with implementation. Interfaces drives business requirements and implementations in this layer. Application Layer in order to implement our business logics, use case operations. The first point of implementation is definition of Model classes.

> Its not mandatory to create and implement Model classes, You can use direct Core entities but its good to separate entity and application required objects.
> 

```
public class ProductModel: BaseModel
    {
        public string ProductName { get; set; }
        public string QuantityPerUnit { get; set; }
        public decimal? UnitPrice { get; set; }
        public short? UnitsInStock { get; set; }
        public short? UnitsOnOrder { get; set; }
        public short? ReorderLevel { get; set; }
        public bool Discontinued { get; set; }
        public int? CategoryId { get; set; }
        public CategoryModel Category { get; set; }
    }
public class CategoryModel: BaseModel
    {
        public string CategoryName { get; set; }
        public string Description { get; set; }
    }
```

As you can see that these Model classes inherit BaseModel.cs.

## **Application Interfaces and Implementations**

The use case of projects should be handled by Application layer. So we are creating Interface and Implementation classes as below way.

```
public interface IProductAppService
{
    Task<IEnumerable<ProductDto>> GetProductList();
    Task<ProductDto> GetProductById(int productId);
    Task<IEnumerable<ProductDto>> GetProductByName(string productName);
    Task<IEnumerable<ProductDto>> GetProductByCategory(int categoryId);
    Task<ProductDto> Create(ProductDto entityDto);
    Task Update(ProductDto entityDto);
    Task Delete(ProductDto entityDto);
}
```

Also implementation located same places in order to choose different implementation at runtime when DI bootstrapped.

```
public class ProductAppService : IProductAppService
{
    private readonly IProductRepository _productRepository;
    private readonly IAppLogger<ProductAppService> _logger;

    public ProductAppService(IProductRepository productRepository, IAppLogger<ProductAppService> logger)
    {
        _productRepository = productRepository ?? throw new ArgumentNullException(nameof(productRepository));
        _logger = logger ?? throw new ArgumentNullException(nameof(logger));
    }

    public async Task<IEnumerable<ProductDto>> GetProductList()
    {
        var productList = await _productRepository.GetProductListAsync();
        var mapped = ObjectMapper.Mapper.Map<IEnumerable<ProductDto>>(productList);
        return mapped;
    }
}
```

In this layer we can add validation , authorization, logging, exception handling etc. — cross cutting activities should be handled in here.

## **Application Layer Components**

Beyond this developments, also there are main components should be handled in Application layer;

- Authorization Management
- Validation Management
- Session Management
- Notification Management
- Exception Management

So in this layer we have these **cross-cutting activities** which provide to manage your application. You will authorize your application in this layer, you should apply your validations in here, you should manage application session and publish notifications from application layer with exception management.

All validation , authorization, logging, exception handling etc. — this kind of cross cutting activities should be handled by these classes.

# **Web Layer**

Development of **UI Logic** with implementation. Interfaces drives business requirements and implementations in this layer. The application’s main **starting point** is the ASP.NET Core web project. This is a **classical console application**, with a public static void **Main** method in **Program.cs**. It currently uses the **default** ASP.NET Core project template which based on **Razor Pages** templates. This includes appsettings.json file plus environment variables in order to stored configuration parameters, and is configured in Startup.cs.

The last layer is UI layer, so in this layer we consumed all other layers. Lets start with the **ViewModel classes**. This classes you can think that imagine of Page components and what is the required data of page.

```
public class ProductViewModel : BaseViewModel
    {
        public string ProductName { get; set; }
        public string QuantityPerUnit { get; set; }
        public decimal? UnitPrice { get; set; }
        public short? UnitsInStock { get; set; }
        public short? UnitsOnOrder { get; set; }
        public short? ReorderLevel { get; set; }
        public bool Discontinued { get; set; }
        public int? CategoryId { get; set; }
        public CategoryViewModel Category { get; set; }
    }
 public class CategoryViewModel : BaseViewModel
    {
        public string CategoryName { get; set; }
        public string Description { get; set; }
    }
```

## **Developing Page Services**

Page Services provide to support Razor pages in order to implement screen logics. Its the same way we create interface and also implementation classes.

Web layer defines that user required actions in page services classes as below way;

```
public interface IProductPageService
    {
        Task<IEnumerable<ProductViewModel>> GetProducts(string productName);
        Task<ProductViewModel> GetProductById(int productId);
        Task<IEnumerable<ProductViewModel>> GetProductByCategory(int categoryId);
        Task<IEnumerable<CategoryViewModel>> GetCategories();
        Task<ProductViewModel> CreateProduct(ProductViewModel productViewModel);
        Task UpdateProduct(ProductViewModel productViewModel);
        Task DeleteProduct(ProductViewModel productViewModel);
    }
public interface ICategoryPageService
    {
        Task<IEnumerable<CategoryViewModel>> GetCategories();
    }
```

Also implementation located same places in order to choose different implementation at runtime when DI bootstrapped.

```
public class ProductPageService : IProductPageService
{
    private readonly IProductAppService _productAppService;
    private readonly ICategoryAppService _categoryAppService;
    private readonly IMapper _mapper;
    private readonly ILogger<ProductPageService> _logger;    public ProductPageService(IProductAppService productAppService, ICategoryAppService categoryAppService, IMapper mapper, ILogger<ProductPageService> logger)
    {
        _productAppService = productAppService ?? throw new ArgumentNullException(nameof(productAppService));
        _categoryAppService = categoryAppService ?? throw new ArgumentNullException(nameof(categoryAppService));
        _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        _logger = logger ?? throw new ArgumentNullException(nameof(logger));
    }    public async Task<IEnumerable<ProductViewModel>> GetProducts(string productName)
    {
        if (string.IsNullOrWhiteSpace(productName))
        {
            var list = await _productAppService.GetProductList();
            var mapped = _mapper.Map<IEnumerable<ProductViewModel>>(list);
            return mapped;
        }        var listByName = await _productAppService.GetProductByName(productName);
        var mappedByName = _mapper.Map<IEnumerable<ProductViewModel>>(listByName);
        return mappedByName;
    }
}
```

## **Developing Razor Pages**

The final part of UI implementation is Razor Pages. So we should create a Product and Category folder into Pages folder. And in these folder, create cshtml razor pages with Index-Create-Edit-Delete pages in order to building web pages.

Lets create with Index page;

Html Part;

```
@page
@model AspnetRun.Web.Pages.Product.IndexModel

@{
    ViewData["Title"] = "Index";
}

<h1>Product List</h1>

<form method="get">
    <div class="form-group">
        <div class="input-group">
            <input type="search" class="form-control" asp-for="SearchTerm" />
            <span class="input-group-btn">
                <button class="btn btn-default">
                    Search
                </button>
            </span>
        </div>
    </div>
</form>

<p>
    <a asp-page="Create">Create New</a>
</p>

<table class="table table-hover">
    <thead>
        <tr>
            <th scope="col">Id</th>
            <th scope="col">Name</th>
            <th scope="col">UnitPrice</th>
            <th scope="col">Category</th>
            <th scope="col">Action</th>
        </tr>
    </thead>
    <tbody>
        @foreach (var product in Model.ProductList)
        {
            <tr>
                <th scope="row">@product.Id</th>
                <td>@product.ProductName</td>
                <td>@product.UnitPrice</td>
                <td>@product.Category.CategoryName</td>
                <td>
                    <a class="btn"
                       asp-page="./Details"
                       asp-route-productId="@product.Id">
                        Details
                    </a>
                    <a class="btn"
                       asp-page="./Edit"
                       asp-route-productId="@product.Id">
                        Edit
                    </a>
                    <a class="btn"
                       asp-page="./Delete"
                       asp-route-productId="@product.Id">
                        Delete
                    </a>
                </td>
            </tr>
        }
    </tbody>
</table>
```

IndexModel.cs ;

```
public class IndexModel : PageModel
    {
        private readonly IProductPageService _productPageService;

        public IndexModel(IProductPageService productPageService)
        {
            _productPageService = productPageService ?? throw new ArgumentNullException(nameof(productPageService));
        }

        public IEnumerable<ProductViewModel> ProductList { get; set; } = new List<ProductViewModel>();

        [BindProperty(SupportsGet = true)]
        public string SearchTerm { get; set; }

        public async Task<IActionResult> OnGetAsync()
        {
            ProductList = await _productPageService.GetProducts(SearchTerm);
            return Page();
        }
    }
```

## **Add Depency Injections into Startup.cs**

In order to use all implementations properly, we should add dependecies with using ASP.NET Core Default DI classes. So for this implementation we should write all dependencies in Startup.cs ConfigureAspnetRunServices method;

```
private void ConfigureAspnetRunServices(IServiceCollection services)
        {
            // Add Core Layer
            services.Configure<AspnetRunSettings>(Configuration);

            // Add Infrastructure Layer
            ConfigureDatabases(services);
            services.AddScoped(typeof(IAsyncRepository<>), typeof(AspnetRunRepository<>));
            services.AddScoped<IProductRepository, ProductRepository>();
            services.AddScoped<ICategoryRepository, CategoryRepository>();
            services.AddScoped(typeof(IAppLogger<>), typeof(LoggerAdapter<>));

            // Add Application Layer
            services.AddScoped<IProductAppService, ProductAppService>();
            services.AddScoped<ICategoryAppService, CategoryAppService>();

            // Add Web Layer
            services.AddAutoMapper(); // Add AutoMapper
            services.AddScoped<IIndexPageService, IndexPageService>();
            services.AddScoped<IProductPageService, ProductPageService>();
            services.AddScoped<ICategoryPageService, CategoryPageService>();

            // Add Miscellaneous
            services.AddHttpContextAccessor();
            services.AddHealthChecks()
                .AddCheck<IndexPageHealthCheck>("home_page_health_check");
        }
```

> This step is very important in order to run application. Without giving implementations Asp.Net Core can not find implemented class and will raised the error.
> 

**F**inally we finished all layers for Product-Category use cases. You can continue the application with create-update-delete actions. We were follow listing functions in order to show layered architecture.

# **Test Layer**

For each layer, there is a test project which includes intended layer dependencies and mock classes. So that means Core-Application-Infrastructure and Web layer has their own test layer. By this way this test projects also divided by **unit, functional and integration tests** defined by in which layer it is implemented. Test projects using **xunit and Mock libraries**. xunit, because that’s what ASP.NET Core uses internally to test the product. Moq, because perform to create fake objects clearly and its very modular.

The test project consists of **4 different projects** as in the main structure. These projects form separate test projects **for each of the projects (Core-Infrastructure-Application-Web)** in the existing architecture. All these projects are **XUnit Project Template** of Visual Studio 2019.

As the same way, the development of the test projects should be Core -> Infrastructure -> Application -> Web layer in respectively.

So lets start to build test projects.

## **AspnetRun.Core.Tests**

This project for testing project of AspnetRun.Core class library project. So it should be test includings of this AspnetRun.Core class library classes.

The main folder structure of AspnetRun.Core.Tests project are should have below folders;

- Builder
- Entities
- Specifications

So in example of Entities test **ProductTests.cs** class includes some of use case of Product entity.

```
[Fact]
public void Create_Product()
{
	var product = Product.Create(_testProductId, _testCategoryId, _testProductName, _testUnitPrice, _testQuantity, null, null, false);

	Assert.Equal(_testProductId, product.Id);
	Assert.Equal(_testCategoryId, product.CategoryId);
	Assert.Equal(_testProductName, product.ProductName);
	Assert.Equal(_testUnitPrice, product.UnitPrice);
	Assert.Equal(_testQuantity, product.UnitsInStock);
}
```

As you can see that this test classes only test for Core Project in order to ensure Product entity class Create method is working properly.

As the same way another test could be for Specification classes. As per the Core layer has not any dependency of database providers, we should apply Specification tests with Mock Product list provided from **ProductBuilder.cs**. Check the **ProductSpecificationTests.cs**.

```
[Fact]
public void Matches_Product_With_Category_Spec()
{
	var spec = new ProductWithCategorySpecification(ProductBuilder.ProductName1);

	var result = ProductBuilder.GetProductCollection()
		.AsQueryable()
		.FirstOrDefault(spec.Criteria);

	Assert.NotNull(result);
	Assert.Equal(ProductBuilder.ProductId1, result.Id);
}
```

## **AspnetRun.Infrastructure.Tests**

This project for testing project of AspnetRun.Infrastructure class library project. So it should be test includings of this AspnetRun.Infrastructure class library classes.

The main folder structure of AspnetRun.Infrastructure.Tests project are should have below folders;

- Builder
- Repositories

So in example of Entities test **ProductTests.cs** class includes some of use case of Product repository.

```
[Fact]
public async Task Get_Existing_Product()
{
	var existingProduct = ProductBuilder.WithDefaultValues();
	_aspnetRunContext.Products.Add(existingProduct);
	_aspnetRunContext.SaveChanges();	var productId = existingProduct.Id;
	_output.WriteLine($"ProductId: {productId}");	var productFromRepo = await _productRepository.GetByIdAsync(productId);
	Assert.Equal(ProductBuilder.TestProductId, productFromRepo.Id);
	Assert.Equal(ProductBuilder.TestCategoryId, productFromRepo.CategoryId);
}
```

As you can see that, in this layer of tests directly use repository without **mocking** this objects. That means we should create the EF.Core database providers. So before tests run in constructor of this class we **bootstrapped** EF.Core database provider as below code;

```
[Fact]
private readonly AspnetRunContext _aspnetRunContext;
private readonly ProductRepository _productRepository;
private readonly ITestOutputHelper _output;public ProductTests(ITestOutputHelper output)
{
	_output = output;
	var dbOptions = new DbContextOptionsBuilder<AspnetRunContext>()
		.UseInMemoryDatabase(databaseName: "AspnetRun")
		.Options;
	_aspnetRunContext = new AspnetRunContext(dbOptions);
	_productRepository = new ProductRepository(_aspnetRunContext);
}
```

We used **InMemoryDatabase** mode in EF.Core for creating context object for testing purpose. You can check other test methods in **ProductTests.cs** class in AspnetRun.Infrastructure.Tests assembly like Get_Product_By_Name, Get_Product_By_Category.

Asp.net core is very powerful framework when it comes to test it functional way. So you can test every options of your web application.

# As the same way you can check the Application and Web Test layers in the project structure.

# **Execution Demo**

**Get the [Source Code from AspnetRun Github](https://github.com/aspnetrun/run-aspnetcore)** — Clone or fork this repository.

Press Ctrl+F5 to launch the application. It will launch because default configuration is In-Memory database option.

A web page will open as shown in the image below. The navigation menu on the top is showing the navigation link for the Products data page.

![https://miro.medium.com/max/1400/1*D1_QV9o5m7ZHds0_C-OUzw.png](https://miro.medium.com/max/1400/1*D1_QV9o5m7ZHds0_C-OUzw.png)

**Finally** we can see the **list page of products** after seeding database. The search button also worked fine, you can debug code putting breakpoint on **Index.cshtml.cs — OnGetAsync** method**.**

You can continue with CRUD operations to develop **Detail — Edit — Delete** actions. To follow same steps for that actions and create pages under the Product folder.

# **Conclusion**

This article demonstrate that implements **clean architecture** on project with **ASP.NET Core & Entity Framework Core** which gives a base template infrastructure of your next enterprise web application with **layered application**. Using **Domain Driven Design Layers** and every layer has **own test project** and **built-in test methods** which you can continue to provide your custom use cases.

# **Whats Next ?**

You can follow this article series with implementation of this Core repository in a real-world example.

**[Continue with next article which explained implementation of this repository](https://medium.com/aspnetrun/build-layered-architecture-with-asp-net-core-entity-framework-core-in-a-real-word-example-aa54a7ed7bef).**

# **BONUS : Udemy Course — Microservices Architecture and Step by Step Implementation on .NET with Clean Architecture**

If you would like to see **how to write quality code with hands-on,** you should check this course.

**[Get Udemy Course with discounted — Microservices Architecture and Implementation on .NET.](https://www.udemy.com/course/microservices-architecture-and-implementation-on-dotnet/?couponCode=OCTOBER2021)**

In this course you will see the demonstrating a **layered application architecture** with **DDD** best practices. Implements NLayer **Hexagonal architecture** (Core, Application, Infrastructure and Presentation Layers) and **Domain Driven Design** (Entities, Repositories, Domain/Application Services, DTO’s…) and aimed to be a **Clean Architecture**, with applying **SOLID principles** in order to use for a project template. Also implements **best practices** like **loosely-coupled, dependency-inverted** architecture and using **design patterns** such as **Dependency Injection**, logging, validation, exception handling and so on.

![https://miro.medium.com/max/700/1*h74-IymBKCOrL3xJ0oi5nA.png](https://miro.medium.com/max/700/1*h74-IymBKCOrL3xJ0oi5nA.png)

**[Get Udemy Course with discounted — Microservices Architecture and Implementation on .NET.](https://www.udemy.com/course/microservices-architecture-and-implementation-on-dotnet/?couponCode=OCTOBER2021)**

*What is **AspnetRun** ?*
*A **starter kit** for your next **ASP.NET Core web application**. Boilerplate for ASP.NET Core reference application with Entity Framework Core, demonstrating a **layered application architecture** with DDD best practices.*
*There are several asp.net core repositories from **beginner to senior level** in order to **leverage your asp.net core skills** and **demonstrate real-world** implementations.*
***[Check all AspnetRun repositories on Github](https://github.com/aspnetrun)***