# How to Build an Event-Driven ASP.NET Core Microservice Architecture

Article Link: https://itnext.io/how-to-build-an-event-driven-asp-net-core-microservice-architecture-e0ef2976f33f
Author: Christian Zink
Date Added: October 4, 2021 9:18 AM
Tag: .NET, Event-Driven, Microservices

Use RabbitMQ, C#, REST-API and Entity Framework for asynchronous decoupled communication and eventually consistency with integration events and publish-subscribe

![https://miro.medium.com/max/1040/1*KjRCx2BzuGXCPQy-xIoC_Q.png](https://miro.medium.com/max/1040/1*KjRCx2BzuGXCPQy-xIoC_Q.png)

In this guide, you will **create two C# ASP.NET Core Microservices**. Both microservices have their **own bounded context and domain model**. Each microservice has its **own database and REST API**. One microservice publishes **integration events**, that the other microservice consumes.

# **Decoupled Microservices — A Real-World Example With Code**

The application uses a real-world example with **users that can write posts**. The user microservice allows creating and editing users. **In the user domain, the user entity has several properties** like name, mail, etc. In the post domain, there is also a user so **the post microservice can load posts and display the writers without accessing the user microservice**. The user entity in the post domain is much simpler:

![https://miro.medium.com/max/1400/1*CgPKfmHdDLfSbosnCcR33g.png](https://miro.medium.com/max/1400/1*CgPKfmHdDLfSbosnCcR33g.png)

The microservices are **decoupled** and the **asynchronous communication** leads to **eventual consistency**. This kind of architecture is the basis for **loosely coupled services** and **supports high scalability**. The microservices access their **example Sqlite databases** via **Entity Framework** and exchange messages via **RabbitMQ** (e.g. on Docker Desktop).

*Overview diagram of the workflow, components, and technologies:*

![https://miro.medium.com/max/1400/1*nBI724d-APCSGAYo5m3zcg.png](https://miro.medium.com/max/1400/1*nBI724d-APCSGAYo5m3zcg.png)

> The code and configurations in this article are not suitable for production use. This guide focuses on the concepts and how the components interact. For this purpose error handling, etc. is omitted.
> 

## **Steps of this Guide**

1. Create the .NET Core Microservices
2. Use RabbitMQ and Configure Exchanges and Pipelines
3. Publish and Consume Integration Events in the Microservices
4. Test the Workflow
5. Final Thoughts and Outlook

# **1. Create the .NET Core Microservices**

In the first part of this guide, you will **create the User and Post Microservice**. You will **add the Entities and basic Web APIs**. The entities will be **stored and retrieved via Entity Framework** from **Sqlite DBs**. Optionally you can test the User Microservice with the **Swagger UI** in the browser.

## **Let’s get started.**

**Install [Visual Studio Community](https://visualstudio.microsoft.com/en/vs/community/)** (it’s free) with the ASP.NET and web development workload.

**Create a solution** and add the two ASP.NET Core 5 Web API projects “UserService” and “PostService”. Disable HTTPS and activate OpenAPI Support.

For both projects **install the following NuGet packages**:

- Microsoft.EntityFrameworkCore.Tools
- Microsoft.EntityFrameworkCore.Sqlite
- Newtonsoft.Json
- RabbitMQ.Client

## **Implement the UserService**

Create the User Entity:

```sql
namespace UserService.Entities
{
    public class User
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Mail { get; set; }
        public string OtherData { get; set; }
    }
}
```

Create the UserServiceContext:

```sql
using Microsoft.EntityFrameworkCore;

namespace UserService.Data
{
    public class UserServiceContext : DbContext
    {
        public UserServiceContext (DbContextOptions<UserServiceContext> options)
            : base(options)
        {
        }

        public DbSet<UserService.Entities.User> User { get; set; }
    }
}
```

**Edit Startup.cs** to configure the UserServiceContext to use Sqlite and call *Database.EnsureCreated()* to make sure the database contains the entity schema:

```sql
public void ConfigureServices(IServiceCollection services)
{

    services.AddControllers();
    services.AddSwaggerGen(c =>
    {
        c.SwaggerDoc("v1", new OpenApiInfo { Title = "UserService", Version = "v1" });
    });

    services.AddDbContext<UserServiceContext>(options =>
         options.UseSqlite(@"Data Source=user.db"));
}

public void Configure(IApplicationBuilder app, IWebHostEnvironment env, UserServiceContext dbContext)
{
    if (env.IsDevelopment())
    {
        dbContext.Database.EnsureCreated();
        ...
```

**Create the UserController** (It implements only the methods necessary for this demo):

```sql
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;
using UserService.Data;
using UserService.Entities;

namespace UserService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsersController : ControllerBase
    {
        private readonly UserServiceContext _context;

        public UsersController(UserServiceContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<User>>> GetUser()
        {
            return await _context.User.ToListAsync();
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutUser(int id, User user)
        {
            _context.Entry(user).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            return NoContent();
        }

        [HttpPost]
        public async Task<ActionResult<User>> PostUser(User user)
        {
            _context.User.Add(user);
            await _context.SaveChangesAsync();
            return CreatedAtAction("GetUser", new { id = user.ID }, user);
        }
    }
}
```

Debug the UserService project and it will start your browser. You can use the swagger UI to test if creating and reading users is working:

![https://miro.medium.com/max/1400/1*TufSfAX0F9Gs2xlrRgsZ2Q.png](https://miro.medium.com/max/1400/1*TufSfAX0F9Gs2xlrRgsZ2Q.png)

## **Implement the PostService**

Create the User and Post entities:

```sql
namespace PostService.Entities
{
    public class User
    {
        public int ID { get; set; }
        public string Name { get; set; }
    }
}
```

```sql
namespace PostService.Entities
{
    public class Post
    {
        public int PostId { get; set; }
        public string Title { get; set; }
        public string Content { get; set; }

        public int UserId { get; set; }
        public User User { get; set; }
    }
}
```

Create the PostServiceContext:

```sql
using Microsoft.EntityFrameworkCore;

namespace PostService.Data
{
    public class PostServiceContext : DbContext
    {
        public PostServiceContext (DbContextOptions<PostServiceContext> options)
            : base(options)
        {
        }

        public DbSet<PostService.Entities.Post> Post { get; set; }
        public DbSet<PostService.Entities.User> User { get; set; }
    }
}
```

**Edit startup.cs** to configure the UserServiceContext to use Sqlite and call *Database.EnsureCreated()* to make sure the database contains the entity schema:

```sql
public void ConfigureServices(IServiceCollection services)
{

    services.AddControllers();
    services.AddSwaggerGen(c =>
    {
        c.SwaggerDoc("v1", new OpenApiInfo { Title = "PostService", Version = "v1" });
    });

    services.AddDbContext<PostServiceContext>(options =>
         options.UseSqlite(@"Data Source=post.db"));
}

public void Configure(IApplicationBuilder app, IWebHostEnvironment env, PostServiceContext dbContext)
{
    if (env.IsDevelopment())
    {
        dbContext.Database.EnsureCreated
        ...
```

Create the PostController:

```sql
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PostService.Data;
using PostService.Entities;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace PostService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PostController : ControllerBase
    {
        private readonly PostServiceContext _context;

        public PostController(PostServiceContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Post>>> GetPost()
        {
            return await _context.Post.Include(x => x.User).ToListAsync();
        }

        [HttpPost]
        public async Task<ActionResult<Post>> PostPost(Post post)
        {
            _context.Post.Add(post);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetPost", new { id = post.PostId }, post);
        }
    }
}
```

Currently, you can’t insert posts, because there are no users in the PostService database.

# **2. Use RabbitMQ and Configure Exchanges and Pipelines**

In the second part of this guide, you will **get RabbitMQ running**. Then you will **use the RabbitMQ admin web UI to configure the exchanges and pipelines** for the application. Optionally you can use the admin UI to send messages to RabbitMQ.

*This graphic shows how the UserService publishes messages to RabbitMQ and the PostService and a potential other service consume those messages:*

![https://miro.medium.com/max/1400/1*K8oytI-Z7gw1Sp26CxGEng.png](https://miro.medium.com/max/1400/1*K8oytI-Z7gw1Sp26CxGEng.png)

The easiest way to get RabbitMQ running is to **install [Docker Desktop](https://hub.docker.com/editions/community/docker-ce-desktop-windows)**. Then **issue the following command** (in one line in a console window) to start a RabbitMQ container with admin UI :

```
C:\dev>docker run -d  -p 15672:15672 -p 5672:5672 --hostname my-rabbit --name some-rabbit rabbitmq:3-management
```

**Open your browser** on port 15672 and log in with the username “guest” and the password “guest”. Use the web UI to **create an Exchange** with the name “user” of type “Fanout” and **two queues** “user.postservice” and “user.otherservice”.

> It is important to use the type “Fanout” so that the exchange copies the message to all connected queues.
> 

You can also use the web UI to publish messages to the exchange and see how they get queued:

![https://miro.medium.com/max/1386/1*YRD8fLl_NoNGRwLK7w6lww.png](https://miro.medium.com/max/1386/1*YRD8fLl_NoNGRwLK7w6lww.png)

# **3. Publish and Consume Integration Events in the Microservices**

In this part of the guide, you will **bring the .NET microservices and RabbitMQ together**. The **UserService publishes** events. The **PostService consumes** the events and **adds/updates the users in its database**.

**Modify UserService.UserController** to publish the integration events for user creation and update to RabbitMQ:

```sql
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using RabbitMQ.Client;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using UserService.Data;
using UserService.Entities;

namespace UserService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsersController : ControllerBase
    {
        private readonly UserServiceContext _context;

        public UsersController(UserServiceContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<User>>> GetUser()
        {
            return await _context.User.ToListAsync();
        }

        private void PublishToMessageQueue(string integrationEvent, string eventData)
        {
            // TOOO: Reuse and close connections and channel, etc, 
            var factory = new ConnectionFactory();
            var connection = factory.CreateConnection();
            var channel = connection.CreateModel();
            var body = Encoding.UTF8.GetBytes(eventData);
            channel.BasicPublish(exchange: "user",
                                             routingKey: integrationEvent,
                                             basicProperties: null,
                                             body: body);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutUser(int id, User user)
        {
            _context.Entry(user).State = EntityState.Modified;
            await _context.SaveChangesAsync();

            var integrationEventData = JsonConvert.SerializeObject(new
            {
                id = user.ID,
                newname = user.Name
            });
            PublishToMessageQueue("user.update", integrationEventData);

            return NoContent();
        }

        [HttpPost]
        public async Task<ActionResult<User>> PostUser(User user)
        {
            _context.User.Add(user);
            await _context.SaveChangesAsync();

            var integrationEventData = JsonConvert.SerializeObject(new
            {
                id = user.ID,
                name = user.Name
            });
            PublishToMessageQueue("user.add", integrationEventData);

            return CreatedAtAction("GetUser", new { id = user.ID }, user);
        }
    }
}
```

> The connection and other RabbitMQ objects are not correctly closed in these examples. They should also be reused. See the official RabbitMQ .NET tutorial and my follow-up article.
> 

**Modify (**and *misuse***) PostService.Program** to subscribe to the integration events and apply the changes to the PostService database:

```sql
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Hosting;
using Newtonsoft.Json.Linq;
using PostService.Data;
using PostService.Entities;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using System;
using System.Linq;
using System.Text;

namespace PostService
{
    public class Program
    {
        public static void Main(string[] args)
        {
            ListenForIntegrationEvents();
            CreateHostBuilder(args).Build().Run();
        }

        private static void ListenForIntegrationEvents()
        {
            var factory = new ConnectionFactory();
            var connection = factory.CreateConnection();
            var channel = connection.CreateModel();
            var consumer = new EventingBasicConsumer(channel);

            consumer.Received += (model, ea) =>
            {
                var contextOptions = new DbContextOptionsBuilder<PostServiceContext>()
                    .UseSqlite(@"Data Source=post.db")
                    .Options;
                var dbContext = new PostServiceContext(contextOptions);                
                
                var body = ea.Body.ToArray();
                var message = Encoding.UTF8.GetString(body);
                Console.WriteLine(" [x] Received {0}", message);

                var data = JObject.Parse(message);
                var type = ea.RoutingKey;
                if (type == "user.add")
                {
                    dbContext.User.Add(new User()
                    {
                        ID = data["id"].Value<int>(),
                        Name = data["name"].Value<string>()
                    });
                    dbContext.SaveChanges();
                }
                else if (type == "user.update")
                {
                    var user = dbContext.User.First(a => a.ID == data["id"].Value<int>());
                    user.Name = data["newname"].Value<string>();
                    dbContext.SaveChanges();
                }
            };
            channel.BasicConsume(queue: "user.postservice",
                                     autoAck: true,
                                     consumer: consumer);
        }

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.UseStartup<Startup>();
                });
    }
}
```

# **4. Test the Workflow**

In the final part of this guide you will test the whole workflow:

![https://miro.medium.com/max/1400/1*nBI724d-APCSGAYo5m3zcg.png](https://miro.medium.com/max/1400/1*nBI724d-APCSGAYo5m3zcg.png)

**Summary of the steps in the last part of this guide** (you can access the services with the Swagger UI):

- Call the UserService REST API and add a user to the user DB
- The UserService will create an event that the PostService consumes and adds the user to the post DB
- Access the PostService REST API and add a post for the user.
- Call the PostService REST API and load the post and user from the post DB
- Call the UserService REST API and rename the user
- The UserService will create an event that the PostService consumes and updates the user’s name in the post DB
- Call the PostService REST API and load the post and renamed user from the post DB

> The user DB must be empty. You can delete the user.db (in the Visual Studio explorer) if you created users in previous steps of this guide. The calls to Database.EnsureCreated() will recreate the DBs on startup.
> 

**Configure both projects to run as service**:

![https://miro.medium.com/max/1400/1*SQTbsd6i8oaxZvPAJm076w.png](https://miro.medium.com/max/1400/1*SQTbsd6i8oaxZvPAJm076w.png)

**Change the App-URL of the PostService to another port** (e.g. [http://localhost:5001](http://localhost:5001/)) so that both projects can be run in parallel. Configure the solution to start both projects and start debugging:

![https://miro.medium.com/max/1400/1*xxKmZRU52XKvpRUZ_0q-Gg.png](https://miro.medium.com/max/1400/1*xxKmZRU52XKvpRUZ_0q-Gg.png)

Use the Swagger UI to create a user in the UserService:

```
{
 "name": "Chris",
 "mail": "chris@chris.com",
 "otherData": "Some other data"
}
```

The generated userId might be different in your environment:

![https://miro.medium.com/max/850/1*irm6bDO86SNAURShpWWT6w.png](https://miro.medium.com/max/850/1*irm6bDO86SNAURShpWWT6w.png)

The integration event replicates the user to the PostService:

![https://miro.medium.com/max/1222/1*K8qzwMngXwwR6PzhnFYaTQ.png](https://miro.medium.com/max/1222/1*K8qzwMngXwwR6PzhnFYaTQ.png)

Now you can create a post in the PostServive Swagger UI (use your userId):

```
{
  "title": "MyFirst Post",
  "content": "Some interesting text",
  "userId": 1
}
```

Read all posts. The username is included in the result:

![https://miro.medium.com/max/922/1*5Jmh4yzAnARKeQQp96wMCA.png](https://miro.medium.com/max/922/1*5Jmh4yzAnARKeQQp96wMCA.png)

Change the username in the UserService Swagger UI:

```
{
  "id": 1,
  "name": "My new name"
}
```

Then read the posts again and see the changed username:

![https://miro.medium.com/max/920/1*xNOsX0lltHO-nG9LaEbHQA.png](https://miro.medium.com/max/920/1*xNOsX0lltHO-nG9LaEbHQA.png)

# **5. Final Thoughts and Outlook**

You created the **working basis for an event-driven microservice architecture.** Besides data replication, you can also use it for classic producer-consumer workflows, SAGAs, etc.

Please make sure to **adjust the code to use it in a production environment**: **Clean up the code** and **apply security best practices.** Apply .NET Core design patterns, error handling, etc.

Currently messages could be lost in edge cases when RabbitMQ or the microservices crash. See my follow-up article on **[how to apply the transactional outbox pattern and make the application more resilient](https://itnext.io/the-outbox-pattern-in-event-driven-asp-net-core-microservice-architectures-10b8d9923885)**.

See my other articles on how to:

- **[Use Database Sharding and Scale your application](https://itnext.io/how-to-use-database-sharding-and-scale-an-asp-net-core-microservice-architecture-22c24916590f)**
- **[Deploy your ASP.NET Core application to Kubernetes, use Angular for the UI](https://levelup.gitconnected.com/kubernetes-angular-asp-net-core-microservice-architecture-c46fc66ede44)**
- **[Add MySql and MongoDB databases](https://itnext.io/databases-in-a-kubernetes-angular-net-core-microservice-arch-a0c0ae23dca9)**.

**Please contact me if you have any questions, ideas, or suggestions.**