# How to Use a MongoDB Database in an ASP NET Core Web API Application

Created: June 15, 2021 9:44 PM
Ref: https://medium.com/swlh/how-to-use-a-mongodb-database-in-a-asp-net-core-web-api-application-b0451ae314f5

# How to Use a MongoDB Database in an ASP NET Core Web API Application

![https://miro.medium.com/max/2188/1*Jh_I3SEtwzBsfiaxwG-L2g.png](https://miro.medium.com/max/2188/1*Jh_I3SEtwzBsfiaxwG-L2g.png)

When you think about database providers for ASP NET Core apps, you probably think about Entity Framework Core (EF Core), which handles interacting with SQL databases. But what about the NoSQL options? A popular option for NoSQL is MongoDB. So in this article we’re going to learn how to create a simple ASP NET Core CRUD API using MongoDB as the database provider.

I have created a [GitHub repo](https://github.com/walpoles93/AspNetCoreMongoDb) for this project, so please feel free to clone it [here](https://github.com/walpoles93/AspNetCoreMongoDb).

Start by creating an ASP NET Core Web API project and then install the MongoDb C# Driver NuGet package:

```
MongoDB.Driver
```

Actually creating the MongoDB database is outside of the scope of this tutorial, so I will assume that you already have a MongoDB database, either locally or hosted on some provider. I personally used Docker to host my database locally, so you can see how I did that by seeing my `docker-compose.dcproj` and `mongo-init.js` files in my [GitHub repo](https://github.com/walpoles93/AspNetCoreMongoDb).

Next we need to enter the connection string for the MongoDB database in our `appsettings.json`:

```
"ConnectionStrings": {
  "MongoDb": "mongodb://MyUser:MyPassword@mongodb:27017/MyDb"
}
```

And then use this connection string to set up the dependency injection (DI) of `IMongoClient` from the `MongoDB.Driver` package. In the `ConfigureServices` method of `Startup.cs`, add the following line to create `IMongoClient` as a [singleton service](https://refactoring.guru/design-patterns/singleton/csharp/example):

```
services.AddSingleton<IMongoClient, MongoClient>(sp => new MongoClient(Configuration.GetConnectionString("MongoDb")));
```

We’re going to create a basic CRUD application with a database containing the details of different cars. So let’s get started by creating a `Models/Car.cs` class:

```
public class Car
{
    public ObjectId Id { get; set; }
    public string Make { get; set; }
    public string Model { get; set; }
    public int TopSpeed { get; set; }
}
```

The `ObjectId` is a data type from the MongoDB driver that stores the unique identifier of the object within the database.

In this project, we’ll be using the [Respository pattern](https://codewithshadman.com/repository-pattern-csharp/) to access and modify our data. So we’ll start by creating the interface for our repository, in `Repositories/ICarRepository.cs`:

```
public interface ICarRepository
{
    // Create
    Task<ObjectId> Create(Car car);    // Read
    Task<Car> Get(ObjectId objectId);
    Task<IEnumerable<Car>> Get();
    Task<IEnumerable<Car>> GetByMake(string make);    // Update
    Task<bool> Update(ObjectId objectId, Car car);    // Delete
    Task<bool> Delete(ObjectId objectId);
}
```

We’ll then go through creating the `Repositories/CarRepository.cs` class step by step, starting with the constructor and private fields:

```
public class CarRepository : ICarRepository
{
    private readonly IMongoCollection<Car> _cars;    public CarRepository(IMongoClient client)
    {
        var database = client.GetDatabase("MyDb");
        var collection = database.GetCollection<Car>(nameof(Car));        _cars = collection;
    }
}
```

Here we are passing an instance of `IMongoClient` (which we set up for DI earlier) to our repository. From that, we are getting the database and the specific collection we want - in this case the Cars collection - and assigning that collection to the field `_cars` to use later.

Note that, if the collection doesn’t already exist, the client will automatically create it when we first try to access it, so we don’t need to worry about manually setting up collections.

Next we move on to the Create method:

```
public async Task<ObjectId> Create(Car car)
{
    await _cars.InsertOneAsync(car);    return car.Id;
}
```

This one is fairly self explanatory — we simply insert the car object into the collection and return the `ObjectId` that is created when the object is inserted into the database.

Next are the 3 read methods:

```
public Task<Car> Get(ObjectId objectId)
{
    var filter = Builders<Car>.Filter.Eq(c => c.Id, objectId);
    var car = _cars.Find(filter).FirstOrDefaultAsync();    return car;
}public async Task<IEnumerable<Car>> Get()
{
    var cars = await _cars.Find(_ => true).ToListAsync();    return cars;
}public async Task<IEnumerable<Car>> GetByMake(string make)
{
    var filter = Builders<Car>.Filter.Eq(c => c.Make, make);
    var cars = await _cars.Find(filter).ToListAsync();    return cars;
}
```

These all follow a similar pattern. First we create a filter object by which to filter the collection and then we ask the client to return either a single object or a list of objects based on our filter. In the case of the `Get()` method that returns all car objects, we created a simple filter that will always return true.

The update method is perhaps the most fiddly of the CRUD operations, mostly because the client insists that each field that needs to be updated must be manually set:

```
public async Task<bool> Update(ObjectId objectId, Car car)
{
    var filter = Builders<Car>.Filter.Eq(c => c.Id, objectId);
    var update = Builders<Car>.Update
        .Set(c => c.Make, car.Make)
        .Set(c => c.Model, car.Model)
        .Set(c => c.TopSpeed, car.TopSpeed);
    var result = await _cars.UpdateOneAsync(filter, update);    return result.ModifiedCount == 1;
}
```

Here we must first create a filter object to only select the object that we wish to update. Note that it is possible to update several objects at once if your filter selects multiple objects and you use the `UpdateMany` method. We then creating an update object, which sets each of the fields in the database to those that we have passed in to the method. We then tell the client to actually perform the update operation with the `UpdateOneAsync` method;

Finally, we have the delete method. It should start to look somewhat familiar by now — we create a filter to select only the record that we want, then use the `DeleteOneAsync` method to actually delete it.

```
public async Task<bool> Delete(ObjectId objectId)
{
    var filter = Builders<Car>.Filter.Eq(c => c.Id, objectId);
    var result = await _cars.DeleteOneAsync(filter);    return result.DeletedCount == 1;
}
```

And that’s it for our repository. We also need to add this to the `ConfigureServices` method of `Startup.cs` in order to configure the DI:

```
services.AddTransient<ICarRepository, CarRepository>();
```

The last thing that we need to do is wire it up to a Controller class so that we can access it as an API. Since this will be very boilerplate ASP NET Core controller code, I’ll simply present the whole controller class ( `Controllers/CarsController.cs`):

```
[ApiController]
[Route("[controller]")]
public class CarsController : ControllerBase
{
    private readonly ICarRepository _carRepository;    public CarsController(ICarRepository carRepository)
    {
        _carRepository = carRepository;
    }    [HttpPost]
    public async Task<IActionResult> Create(Car car)
    {
        var id = await _carRepository.Create(car);        return new JsonResult(id.ToString());
    }    [HttpGet("{id}")]
    public async Task<IActionResult> Get(string id)
    {
        var car = await _carRepository.Get(ObjectId.Parse(id));        return new JsonResult(car);
    }    [HttpGet]
    public async Task<IActionResult> Get()
    {
        var cars = await _carRepository.Get();        return new JsonResult(cars);
    }    [HttpGet("ByMake/{make}")]
    public async Task<IActionResult> GetByMake(string make)
    {
        var cars = await _carRepository.GetByMake(make);        return new JsonResult(cars);
    }    [HttpPut("{id}")]
    public async Task<IActionResult> Update(string id, Car car)
    {
        var result = await _carRepository.Update(ObjectId.Parse(id), car);        return new JsonResult(result);
    }    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(string id)
    {
        var result = await _carRepository.Delete(ObjectId.Parse(id));        return new JsonResult(result);
    }
}
```

And that’s it! You can now run the application and calls the standard CRUD API endpoints to Create, Read, Update and Delete Car records using MongoDB as the database.

[https://miro.medium.com/max/60/0*E4GjGRqR99ANkg-p?q=20](https://miro.medium.com/max/60/0*E4GjGRqR99ANkg-p?q=20)

[https://miro.medium.com/max/2645/0*E4GjGRqR99ANkg-p](https://miro.medium.com/max/2645/0*E4GjGRqR99ANkg-p)

[https://miro.medium.com/max/60/0*9kHJFgTdG6uujzI9?q=20](https://miro.medium.com/max/60/0*9kHJFgTdG6uujzI9?q=20)

[https://miro.medium.com/max/2627/0*9kHJFgTdG6uujzI9](https://miro.medium.com/max/2627/0*9kHJFgTdG6uujzI9)

# **Conclusion**

In this article we have learnt how to use the MongoDB C# Driver to create ASP NET Core API powered by a MongoDB database. Don’t forget to check out the [Github repo](https://github.com/walpoles93/AspNetCoreMongoDb) for this project [here](https://github.com/walpoles93/AspNetCoreMongoDb).

Since it’s almost Christmas, you could also check out my [Top Christmas Gifts To Buy A Developer](https://samwalpole.com/top-christmas-gifts-to-buy-a-developer) post that was featured on Hashnode recently.

I post mostly about full stack .NET and Vue web development. To make sure that you don’t miss out on any posts, please follow this blog and [subscribe to my newsletter](https://samwalpole.com/). If you found this post helpful, please like it and share it. You can also find me on [Twitter](https://twitter.com/dr_sam_walpole).