# Custom Distributed Transaction Management Between Microservices on .Net Core -CTAS

Article Link: https://borakasmer.medium.com/custom-transaction-management-between-microservices-on-net-core-ctas-1f0ecfa7e5e8
Author: Bora Kaşmer
Date Added: August 26, 2021 4:03 PM
Tag: .NET, Microservices

Today we will talk about how to manage distributed transactions between separated microservices. Commit and Rollback are the main two operations of the transaction. We will use .Net Core 3.1 and RabbitMQ for this application.

![https://miro.medium.com/max/1400/1*z2geyWeH9BMIpdQM0GGiTg.png](https://miro.medium.com/max/1400/1*z2geyWeH9BMIpdQM0GGiTg.png)

If our jobs take so long, we could prefer to put them in a Queue. We have to put every job in a new queue actually on a new channel. And if our tasks are sequential, they must have to wait for each other. If one of the tasks gives an error, we have to rollback every complete task.

# “It’s always the small pieces that make the big picture.”

This is not easy. In this article, I will suggest my own transaction management way. Actually, there is two common way to do it. Saga and 2PC, all of them have advantages and disadvantages. But in this scenario, I will prefer to do it in my way.

In this example, we will simulate online product donation records. One user donates a product. He or she could donate many times. And this product could be donated before by someone else.

**Step 1**: We will check User exists or not. If not, we will save him or her to the Users table.

**Step 2:** We will check Product exists or not. If not, we will save it to the Products table with price.

**Step 3:** We will save who, what donated, and when to the UserDetails table with inserted UserID and ProductID.

![https://miro.medium.com/max/1400/1*AM_EZdZlbxafCGD6epSdsw.jpeg](https://miro.medium.com/max/1400/1*AM_EZdZlbxafCGD6epSdsw.jpeg)

> As you can see, all the steps are sequential and waiting for each other. We call this Isolation, in Acid principles. If all the steps’ process takes so long, we could put each of them in a new queue. All levels are one. If even one of the level fails, all others need to be undone. We call this Atomicity, in Acid principles. We will save all data to MS SQL Server, and we will keep all queues on RabbitMQ with the true durable property so the queue will survive a broker restart. So there is no chance to Loss data. This is the Durability property of Acid principles. We will talk about Consistency later in this article.
> 

# “All for one and one for all, united we stand divided we fall.”―

# **Current knowen solutions for distirbuted transaction management:**

**SAGA**

This is the Saga solution of the Donation Microservice Process. The main disadvantage of this approach is there is no read isolation. This means, in the below example, the client could see the product was created, but in the next second, the product is removed due to User Detail transaction error. Also, when the number of microservices counts increases, it becomes harder to find bugs and also maintain.

![https://miro.medium.com/max/1400/1*_8Cz1deyFFRJ9y_3eH9jsw.png](https://miro.medium.com/max/1400/1*_8Cz1deyFFRJ9y_3eH9jsw.png)

**SAGA SOLUTION (Events/Choreography)**

**2PC Two-Phase Commits**:

This is 2PC solution of the Donation Microservices Process. Two-phase commits are very slow compared with a single microservice. And it is highly dependent on a coordinator. When traffic increases, a performance problem could be seen in the coordinator. And the most critical issue is the locking of database rows could be possible to have a **Deadlock,** where two transactions lock each other.

![https://miro.medium.com/max/1400/1*tmlsC6spzk0qpNSO2pjgrQ.png](https://miro.medium.com/max/1400/1*tmlsC6spzk0qpNSO2pjgrQ.png)

**2PC(Two-Phase Commit) SOLUTION**

# **MS SQL DB:**

We will start with Database First .Net Core Entity WebApp. So lets create the DB.

![https://miro.medium.com/max/1400/1*oZlHqF3bfqNPLAG3WKmBHA.png](https://miro.medium.com/max/1400/1*oZlHqF3bfqNPLAG3WKmBHA.png)

**Create Deno Database:**

We have three tables Users, Products, and UserDetails. You can see the table’s relations as above the picture.

![https://miro.medium.com/max/1304/1*UP6wb-aEHtHZP2TF2fdm0w.png](https://miro.medium.com/max/1304/1*UP6wb-aEHtHZP2TF2fdm0w.png)

# **Microtransaction WebApi Service:**

Now we will create .Net Core WebApi Microtransaction service.

![https://miro.medium.com/max/1400/1*RlcKrrDmSF7H3n9CNF-dZw.png](https://miro.medium.com/max/1400/1*RlcKrrDmSF7H3n9CNF-dZw.png)

For creating DBContext from existing DB, you need the download these below packages.

```
dotnet add package Microsoft.EntityFrameworkCore --version 3.1.5
dotnet add package Microsoft.EntityFrameworkCore.SqlServer
dotnet add package Microsoft.EntityFrameworkCore.Tools
```

After all, if you run Scaffold command as below, all Pocos and DbContext will be created under the DB folder.

```
dotnet ef dbcontext Scaffold "Server=tcp:192.168.1.7,1433;Database=Deno;User ID=****;Password=****;" Microsoft.EntityFrameworkCore.SqlServer --force -o DB -c DenoContext
```

![https://miro.medium.com/max/976/1*vFEPcoufixQYJXSdYwPgbQ.png](https://miro.medium.com/max/976/1*vFEPcoufixQYJXSdYwPgbQ.png)

**Models/UserShop:** This is the InsertUser service Data Model. This data comes from the 3rd party service.

![https://miro.medium.com/max/896/1*rgyUlNW8NNpzYoBWrvayPg.png](https://miro.medium.com/max/896/1*rgyUlNW8NNpzYoBWrvayPg.png)

```
public class UserShop
{
   public string name { get; set; }
   public string surname { get; set; }
   public int id { get; set; }
   public int no { get; set; }
   public string productName { get; set; }
   public decimal? productPrice { get; set; }
}
```

**Controller/UserController.cs:** This is a public service. It is used for getting donation data from third party services.

```
[Route("InsertUser")]
[HttpPost]
public string InsertUser([FromBody] UserShop data)
{
   return _userService.InsertUser(data);
}
```

**UserService.cs:** We will add this raw data to the “**User**” channel on RabbitMQ without touching anything. We will distribute all jobs to different consumers by using RabbitMQ. RabbitMQ’s “***durable”*** property is “***true.”*** So the queue could survive a broker restart. And with this, we obey the **Durability** property of Acid principles.

# **UserConsumer:**

This is **User consumer** microservice. We will get user data from the queue and save it to the MsSql server and put the product data to the “**Product**” channel. In this step, you can save the user data to different resources. This is up to your business logic and your choice. It could be MongoDB, PostgreSQL or Firebase, etc.

I have identified this saving resource with the Type property on the Transaction History basis.

```
Type = TransactionType.SqlDB
```

- We will get data from “**User**” channel.

![https://miro.medium.com/max/1400/1*S71f3g_m7t3r8aljRjlsTQ.png](https://miro.medium.com/max/1400/1*S71f3g_m7t3r8aljRjlsTQ.png)

- If there is no User data with the same name and surname, we will save new user data to the SQL DB.

# While saving the User data, we set the IsActive property false because of the obey the of Acid principles. In the next steps, if we met any errors, we don’t have to rollback inserted user data because new user data is saved as a soft delete.

In every step, all new data are saved as a soft delete. So all IsActive properties set false. And we keep the data consistency. If all the steps are completed without any error, we will set all related data to active at the end of this cycle. So we will set IsActive property true. To active all transaction data, all steps must work properly. If one of the steps gives an error, we won’t active the inserted data and keep them as a soft delete.

![https://miro.medium.com/max/1400/1*CtckIZZPOBKXU_XId1bbhA.png](https://miro.medium.com/max/1400/1*CtckIZZPOBKXU_XId1bbhA.png)

- After the save new User data, we will create Product data. And we will add inserted UserID(**@@IDENTITY**) to this model.

# **TransactionHistory List is the most important object in this application. We will add all DB Operations to this List. And we will carry it between all microservices. You can think of this List as a DB log files.**

We will add inserted User data info to this TransactionHistory list. Our main purpose is to record all transaction activities on DB to the TransactionHistory list and transfer it to the next step.

![https://miro.medium.com/max/1400/1*Em-J3daKNW--QEo_SshgPg.png](https://miro.medium.com/max/1400/1*Em-J3daKNW--QEo_SshgPg.png)

- If the user exists, we will not insert any data to the Users table. So the TransactionHistory List will be empty for the first step.

![https://miro.medium.com/max/60/1*mudPRE-71hkXkQFebpJKPg.png?q=20](https://miro.medium.com/max/60/1*mudPRE-71hkXkQFebpJKPg.png?q=20)

![https://miro.medium.com/max/1400/1*mudPRE-71hkXkQFebpJKPg.png](https://miro.medium.com/max/1400/1*mudPRE-71hkXkQFebpJKPg.png)

- We will add this product data to the “**Product**” channel. So we will distribute the product job to the new consumer. And We will set RabbitMQ “***durable”*** property to “***true,”*** with this***,*** we will obey the **Durability** property of Acid principles.

![https://miro.medium.com/max/1400/1*dZXXKuK5eQGxEZYUfuSQvA.png](https://miro.medium.com/max/1400/1*dZXXKuK5eQGxEZYUfuSQvA.png)

## **userConsumer/Program.cs:**

**TransactionHistoryList:** DB Action Log file. We will add all DB Transactions into this list. And we will transfer it to the next Consumer.

- ID: Inserted, Deleted, or Updated data ID.
- TableName: Inserted, Deleted, or Updated Table name.
- State: It is an Enum of Transaction status.
- Step: The name of the Consumer class. It shows the place of the transaction.
- ****Type: It shows the source of data save. It could be SQL, Oracle or Redis, etc.

```
public class TransactionHistory{
   public int ID { get; set; }
   public string TableName { get; set; }
   public TransactionState State { get; set; }
   public TransactionStep Step { get; set; }
   public TransactionType Type { get; set; }
}
```

These are TransactionStep, TransactionState and TransactionType Enums.

**Models/ProductConsumer.cs:** This class is implemented from Products class. We added UserId and TransactionHistoryList properties.

```
using System.Collections.Generic;
using userConsumer.DB;
public class ProductConsumer : Products
{
   public int UserId { get; set; }
   public List<TransactionHistory> TransactionList { get; set; }
}
```

**This is what we have done, until that point:**

- Get UserShop Data from WebApi service and add it to the User channel on RabbitMQ.
- Get UserShop data from the Queue. Insert user to MS SQL, if not exist. Prepare Product data with Transaction History. And add it to Product channel Queue on RabbitMQ.

![https://miro.medium.com/max/1400/1*4SWyU5FQRYEGWq9_8N4S9Q.png](https://miro.medium.com/max/1400/1*4SWyU5FQRYEGWq9_8N4S9Q.png)

**WorkFlow Until User Consumer**

# **ProductConsumer:**

This is a **Product consumer** microservice. We will get product data from the queue and save it to the MsSql server. In this step, you can save the product data to different resources. This is up to your business logic and your choice.

I have identified this saving resource with the Type property on the Transaction History basis.

```
Type = TransactionType.SqlDB
```

After all put the user detail data to the “**UserDetail**” channel.

- We will get data from “**Product**” channel.

![https://miro.medium.com/max/1400/1*4aRpjRYR51fSTgXl6MTMjg.png](https://miro.medium.com/max/1400/1*4aRpjRYR51fSTgXl6MTMjg.png)

- If there is no Product data with the same name and price, we will save new product data to the SQL DB. Again we set the IsActive property is false at the beginning. In the next steps, if we met any errors, we don’t have to rollback inserted product data because new product data is saved as a soft delete.
- After saving new Product data, we will create UserDetail data. And we will add inserted ProductID(**@@IDENTITY**) and UserID(**@@IDENTITY**) to this model.

> We will get TransactionHistoryList from the User Consumer. There is one Inserted User data in this list for this scenario. We will add inserted Product data info to this TransactionHistory list. And we will send it to the UserDetail Consumer with these two transaction data info.
> 

# We will carry this TransactionHistory List Between Consumers by Using RabbitMQ. Actually, we will log all DB activities on every step and carry it from beginning to end.

![https://miro.medium.com/max/60/1*GfctlMK255OqEzH3JIO7iA.png?q=20](https://miro.medium.com/max/60/1*GfctlMK255OqEzH3JIO7iA.png?q=20)

- If the product exists, we will not insert any data to the Products table. So there is only one User data record in TransactionHistory List. But there is no any product record in this TransactionHistory List.

![https://miro.medium.com/max/60/1*L20hQ85HohEogqkSpJMYYw.png?q=20](https://miro.medium.com/max/60/1*L20hQ85HohEogqkSpJMYYw.png?q=20)

- We will add this UserDetail data to the “**UserDetail**” channel. So we will distribute the UserDetail job to the new consumer.

![https://miro.medium.com/max/60/1*KA5MuNCT8HFBTcwfZ2XkcA.png?q=20](https://miro.medium.com/max/60/1*KA5MuNCT8HFBTcwfZ2XkcA.png?q=20)

**Models/UserDetailQueue.cs:** This class is implemented from UserDetail class. We added only TransactionHistoryList property.

```
using System.Collections.Generic;
using productConsumer.DB;
public class UserDetailQueue : UserDetails
{
   public List<TransactionHistory> TransactionList { get; set; }
}
```

**This is what we have done, until that point:**

- Get UserShop Data from WebApi service and add it to the User channel on RabbitMQ.
- Get UserShop data from the Queue. Insert user to MS SQL. Prepare Product data with Transaction History. Add it to the product channel on RabbitMQ.
- Get Product data from the Queue. Insert product to MS SQL. Prepare UserDetail data with Transaction History. Add it to the UserDetail channel on RabbitMQ.

**WorkFlow Until Product Consumer**

![https://miro.medium.com/max/2000/1*aVFJ4IS8_ORbZcyMUFRPEg.png](https://miro.medium.com/max/2000/1*aVFJ4IS8_ORbZcyMUFRPEg.png)

## **productConsumer/program.cs:**

# **UserDetailConsumer:**

This is **UserDetail consumer** microservice. We will get UserDetail data from the queue and save it to the MsSql server and commit all the transactions in the TransactionHistory List. In this step, you can save the user detail data to the different resources. This is up to your business logic and your choice.

- We will get data from “**UserDetail**” channel.

![https://miro.medium.com/max/60/1*nFhAU3WerSRP6x-kbUjGvg.png?q=20](https://miro.medium.com/max/60/1*nFhAU3WerSRP6x-kbUjGvg.png?q=20)

- We will save UserDetail to MsSql with “***IsActive”*** property true because this is the last step of this cycle. And also, we will add Inserted UserID, ProductID, and also Created Time.

![https://miro.medium.com/max/60/1*zNYUzagBy310wt2mdiVxrw.png?q=20](https://miro.medium.com/max/60/1*zNYUzagBy310wt2mdiVxrw.png?q=20)

This Loop is working for every transactional table and commits them. So we will update the “**IsActive**” property as a true property for every table. We transferred the same transaction history list between all consumers. And we added every transaction on the same list on every step. At the last UserDetail Step, we walked into this list and activated all table rows, which are on this list.

> As seen below, firstly, we checked is the user exists, if not, we inserted user data as a passive. After we checked is product exist, if not, we inserted the product as inactive too, and finally, we inserted UserDetail data. If everything’s ok, we updated user and product passive data to active.
> 

**SQL PROFILE**

![https://miro.medium.com/max/2000/1*B0r5JJTwEy0WH4i-dVGb3g.gif](https://miro.medium.com/max/2000/1*B0r5JJTwEy0WH4i-dVGb3g.gif)

Depending on **TransactionType** enum, the update process can be different for each step. It could be SqlDb update or MongoDb update etc. And every Step business could be different. For example, in the product step, we could have to send an e-mail to the warehouse. We will filter this step by TransactionStep enum.

![https://miro.medium.com/max/1400/1*UHqgobEs9HPxKVaDU02--w.png](https://miro.medium.com/max/1400/1*UHqgobEs9HPxKVaDU02--w.png)

## **userDetailConsumer/Program.cs:**

All steps must complete before to activate all transactions. If one of them fails, this means all the process is failed. As I said before, we call it **Atomicity**, in Acid principles.

**Models/UserDetailQueue.cs:** This class is implemented from UserDetail class. We added only TransactionHistoryList property.

```
using System.Collections.Generic;
using productConsumer.DB;
public class UserDetailQueue : UserDetails
{
   public List<TransactionHistory> TransactionList { get; set; }
}
```

## **This is the final work process schema of this application (CTAS):**

**WorkFlow Of CTAS**

![https://miro.medium.com/max/3392/1*pGjeUfYmUeWwsZXrFYSHfg.png](https://miro.medium.com/max/3392/1*pGjeUfYmUeWwsZXrFYSHfg.png)

# **Conclusion:**

For now, I don’t think the existing Distributed Transaction Management methods are very satisfying. So I tried to go to the solution with my custom management method. Now it has a name. “**CTAS**” **Chain Transaction Application Solution.** I decided to go to a less dependent, easier to manage, and above all, a more straightforward solution with **CTAS.** All microservices are stand-alone. They do not push any notification, not managed by a coordinator. They only get transaction list from the previous, add their transaction records, and transfer it to the next. All the data save to a Database as a passive. So you don’t have to Rollback if you meet any error. But at the last step, if everything goes well, you have to Commit all the inactive data rows, saved in this life cycle. And with this, we obey the **Consistency** property of Acid principles. All the transaction steps may have different logic. At the last stage on UserDetailConsumer, we can move the transaction commit process to the new consumer. All the different process logics work separately, and we can use a strategy design pattern for every process. It enables us to manage it more easily and comply with the single responsibility principle.

**THE END & GOOD BYE**

*“If you have read so far, first of all, thank you for your patience and support. I welcome all of you to [**my blog](http://www.borakasmer.com/)** for more!”*

**Source Code:**

****[borakasmer/TransactionManagementYou can't perform that action at this time. You signed in with another tab or window. You signed out in another tab or…**
github.com](https://github.com/borakasmer/TransactionManagement)

**Source**: **[Handling Distributed Transactions in the Microservice world](https://medium.com/swlh/handling-transactions-in-the-microservice-world-c77b275813e0), [DBContextExtensions](https://github.com/bayramucuncu/B3.Extensions.Data), [Wikipedia](https://en.wikipedia.org/wiki/ACID)**