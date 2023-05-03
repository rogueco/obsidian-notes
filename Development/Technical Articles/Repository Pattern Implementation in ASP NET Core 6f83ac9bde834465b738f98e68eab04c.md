# Repository Pattern Implementation in ASP.NET Core

Article Link: https://medium.com/net-core/repository-pattern-implementation-in-asp-net-core-21e01c6664d7
Author: Sena Kılıçarslan
Date Added: August 26, 2021 2:47 PM
Tag: .NET, Design-Patterns, Tutorial

In this post, I will show how to implement a generic repository pattern with asynchronous methods in an ASP.NET Core Web API. If you are not familiar with ASP.NET Core Web API, I recommend you read my [How To Build a RESTful API with ASP.NET Core](https://medium.com/net-core/how-to-build-a-restful-api-with-asp-net-core-fb7dd8d3e5e3) post first.

![https://miro.medium.com/max/1400/1*JJ36TcnKKgJZd7VlaLLHLA.jpeg](https://miro.medium.com/max/1400/1*JJ36TcnKKgJZd7VlaLLHLA.jpeg)

The API — MyMDB (My Movie Database) — will provide endpoints that perform CRUD operations on a database of movies and stars and it will be easy to extend for other types of features that can exist in a movie database.

I will use the following tools for the development:

- [Visual Studio 2019 Community Edition (free)](https://visualstudio.microsoft.com/downloads/)
- [.Net Core SDK 2.2 (free)](https://dotnet.microsoft.com/download/dotnet-core)
- [Microsoft SQL Server Express (free)](https://www.microsoft.com/en-us/sql-server/sql-server-editions-express)

The sections of this post will be as follows:

- What is a Repository?
- Creating a Web API Project
- Adding a Model
- Adding a Controller (Movies)
- Implementing the Repository
- Adding a Base Controller
- Registering the Repository with the Dependency Injection System
- Creating Database using Migrations
- Testing
- Adding a New Model and a Controller (Stars)

## **What is a Repository?**

Martin Fowler defines a repository [here](https://martinfowler.com/eaaCatalog/repository.html) as below:

> A Repository mediates between the domain and data mapping layers, acting like an in-memory domain object collection. Client objects construct query specifications declaratively and submit them to Repository for satisfaction. Objects can be added to and removed from the Repository, as they can from a simple collection of objects, and the mapping code encapsulated by the Repository will carry out the appropriate operations behind the scenes. Conceptually, a Repository encapsulates the set of objects persisted in a data store and the operations performed over them, providing a more object-oriented view of the persistence layer. Repository also supports the objective of achieving a clean separation and one-way dependency between the domain and data mapping layers.
> 

## **Creating a Web API Project**

Open Visual Studio and select ***Create a new project -> ASP.NET Core Web Application***. Then, name the solution and the project.

In the next dialog, select the ***API*** template and ***ASP.NET Core version*** and then click Create.

![https://miro.medium.com/max/1400/1*byAZfj6vBD1WGGIBxaEYgg.png](https://miro.medium.com/max/1400/1*byAZfj6vBD1WGGIBxaEYgg.png)

The project structure at the beginning is as follows:

![https://miro.medium.com/max/496/1*xHlKrqc9IuZSLc0zr6dj4g.png](https://miro.medium.com/max/496/1*xHlKrqc9IuZSLc0zr6dj4g.png)

## **Adding a Model**

In this section, we will add our first model class.

Add a new folder called ***Data*** to the project.

Then add ***IEntity*** interface to this folder as below:

Next, add ***Models*** folder to the project and add ***Movie*** class to this folder:

At this point, we need to build the project.

## **Adding a Controller**

Right-click on the *Controllers* folder and select ***Add Controller -> API Conroller with actions, using Entity Framework.***

Make the selections as following in the next dialog:

![https://miro.medium.com/max/1174/1*cW3le6LkBbBjLos3GNijBQ.png](https://miro.medium.com/max/1174/1*cW3le6LkBbBjLos3GNijBQ.png)

After scaffolding,

- ***MyMDBContext*** class is added into *Data* folder.

![https://miro.medium.com/max/990/1*yL3aDrBbSW2X9Ersq_Ovnw.png](https://miro.medium.com/max/990/1*yL3aDrBbSW2X9Ersq_Ovnw.png)

MyMDBContext.cs

- Connection string for *MyMDBContext* is added to ***appsetting.json***.
- ***MoviesController*** is created.

![https://miro.medium.com/max/1052/1*B72IYe-TUOJX3ww97_FL0A.png](https://miro.medium.com/max/1052/1*B72IYe-TUOJX3ww97_FL0A.png)

MoviesController.cs

As you see, there is direct access to ***Entity Framework Core*** in *MoviesController*.

The relationship is as follows:

```
Controller -> EF Core -> SQL Server
```

Now, we will add a ***repository*** between the controller and EF Core as an abstraction layer and will turn the relation into:

```
Controller ->Repository -> EF Core -> SQL Server
```

Since the default behavior of the methods is asynchronous in the scaffolded API controller, we will create our methods in the *repository* as asynchronous too.

## **Implementing the Repository**

Create ***IRepository*** interface under the *Data* folder with the following code:

*This interface is planned to be an abstraction layer over different ORMs.*

Now, we will create an abstract class for EF Core which implements this interface.

Create ***EFCore*** folder in the *Data* folder and add ***EfCoreRepository*** class here with the following code:

As you see, we moved the EF Core related code in the *MoviesController* to this class.

*We should move MyMDBContext to the EFCore folder as it is specific to EF Core.*

Next, we will create a concrete class which inherits *EfCoreRepository*.

Create a class called ***EfCoreMovieRepository*** in the *EFCore* folder with the following code:

Now, we can use this repository in *MoviesController*. To make things better, let’s add a base controller to the project and inherit *MoviesController* from this base class.

## **Adding a Base Controller**

Add ***MyMDBController*** as an abstract class to *Controllers* folder with the following code:

Update *MoviesController* with the following code:

## **Registering the Repository with the Dependency Injection System**

*MoviesController* needs an object of type *EfCoreMovieRepository* in the constructor. We will register this repository to the dependency injection system and then DI system will provide this service to the *MoviesController*. Add the following highlighted line to the ***Startup.cs***:

![https://miro.medium.com/max/1400/1*ncU90dA7O1GZyshQu5CMxQ.png](https://miro.medium.com/max/1400/1*ncU90dA7O1GZyshQu5CMxQ.png)

## **Creating Database using Migrations**

Now, we will create the database using the EF Core [Migrations](https://docs.microsoft.com/en-us/aspnet/core/data/ef-mvc/migrations?view=aspnetcore-2.2) feature.

> Migrations lets us create a database that matches our data model and update the database schema when our data model changes.
> 

Open ***Tools -> NuGet Package Manager > Package Manager Console(PMC)*** and run the following commands in the PMC:

```
Add-Migration Initial
Update-Database
```

Now, we will check the database created. Open ***View -> SQL Server Object Explorer:***

![https://miro.medium.com/max/698/1*s-eWLkzZ1mprvq4gUU9v0g.png](https://miro.medium.com/max/698/1*s-eWLkzZ1mprvq4gUU9v0g.png)

## **Testing**

At this point, we should test our API endpoints. We can use [Postman](https://www.getpostman.com/downloads/) to test all methods and the browser to test the GET methods.

*If you need help with testing, you can refer to the [post](https://medium.com/net-core/how-to-build-a-restful-api-with-asp-net-core-fb7dd8d3e5e3) that I mentioned above.*

Here is a screenshot of one of my tests:

![https://miro.medium.com/max/1048/1*0I08niKMaivudMj0NIjc3Q.png](https://miro.medium.com/max/1048/1*0I08niKMaivudMj0NIjc3Q.png)

## **Adding a New Model and Controller**

In this section, we will implement API endpoints which perform CRUD operations on a database of **Stars**. We will use the base repository and the controller that we implemented in the previous sections.

The steps will be as follows:

- Add ***Star*** model in the *Models* folder with the following code:
- Add ***EfCoreStarRepository*** class in the *Data -> EFCore* folder:
- Add ***StarsController*** in the *Controllers* folder with the following code:
- Add the following highlighted line to ***Startup.cs :***

![https://miro.medium.com/max/1400/1*w_BCz6hZNEyOtmkBJw6fEw.png](https://miro.medium.com/max/1400/1*w_BCz6hZNEyOtmkBJw6fEw.png)

- Add the following highlighted line to ***MyMDBContext.cs***:

![https://miro.medium.com/max/1016/1*ylxXRLvHgPrw6ibKHY3zYA.png](https://miro.medium.com/max/1016/1*ylxXRLvHgPrw6ibKHY3zYA.png)

- Run the following commands in the PMC:

```
Add-Migration StarUpdate-Database
```

You can check the newly created table (***Star***) from *SQL Server Object Explorer* in Visual Studio.

Our final project structure is as follows:

![https://miro.medium.com/max/566/1*NSHvi56oWiIgdWrpwBKefA.png](https://miro.medium.com/max/566/1*NSHvi56oWiIgdWrpwBKefA.png)

Now, you should test every endpoint to check if everything is OK. Below is a screenshot of one of my tests:

![https://miro.medium.com/max/1068/1*NXxCqCTkSUPppHBOJaCH9g.png](https://miro.medium.com/max/1068/1*NXxCqCTkSUPppHBOJaCH9g.png)

*My intention on writing this last section was to show you how easy it is to extend this model to add new API endpoints for new features (TV Shows, video games… etc.) once we have the base repository and the controller.*

You can find the full project in this [GitHub repository](https://github.com/kilicars/AspNetCoreRepositoryPattern).

I hope you found this post useful and easy to follow. Please let me know if you have any improvements and/or questions in the comments below.

And if you liked this post, please clap your hands 👏👏👏

Bye!