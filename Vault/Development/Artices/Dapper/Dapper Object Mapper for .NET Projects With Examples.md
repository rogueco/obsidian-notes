#dotnet #dapper #entityFrameworkCore #softwareDevelopment 

[Medium Link](https://medium.com/@Dishan/dapper-object-mapper-for-net-projects-with-examples-e195aaad1f9)




**Dapper is a Micro-ORM** which helps to map plain query output to domain classes. It can run plain SQL queries with great performance. Dapper is a lightweight framework that supports all major databases like SQLite, Firebird, Oracle, MySQL, and SQL Server. It does not have database specific implementation. All you need is valid and open connection. Dapper is built by **StackOverflow** team and released as open source.

**What is ORM** (O/RM, O/R Mapping): ORM Is a layer/technique that lets you map your application code (Class) to your Relational database. In run-time, data will be retrieved from database and filled into the object model.

![](https://miro.medium.com/max/700/1*nEtgYP3UD8d5DOzJmTtgJg.png)

If your project prefers writing raw query or stored procedures instead of using a traditional ORM tools like EF or NHibernate then Dapper could be your best choice. Dapper makes it easy to work with the database and map your object models.

**Traditional ORM [Entity Framework] vs Micro ORM**

![](https://miro.medium.com/max/677/1*Cg9tn0WX1tulI9OTLKh40Q.png)

To use Dapper, you just need to install it through the Nuget package manager. [https://www.nuget.org/packages/Dapper/](https://www.nuget.org/packages/Dapper/)

Currently there are more than **8.7 M Dapper downloads** (More than **3000 downloads per day**).

Performance of SELECT mapping over 500 iterations — POCO serialization

![](https://miro.medium.com/max/650/1*U_Lupx_iqotNaHydgHEJAQ.png)

_Performance stats taken from_ [_https://github.com/StackExchange/Dapper_](https://github.com/StackExchange/Dapper)

**Few key features,**

-   Support both raw query and procedures.
-   Multiple query and multiple data-set support.
-   Map tables to Objects.
-   Speed and high performance.
-   Lightweight library.
-   Fewer lines of code.
-   Static and dynamic object binding.
-   Easy handling SQL query.

Dapper micro-ORM is good for basic and medium complexity tasks/projects. I still use Entity Framework/Core for more complex designs, and I use Dapper with EF for RAW SQL queries.

**Basic usage**

using (var connection = new SqlConnection($"Data Source=localhost;"$"Initial Catalog=TestDb;" +  
      $"Trusted_Connection=True"))  
{  
      _// Dapper Implementation_  
}

**Execute a query and map the results to a strongly typed object (Order)**

var orders =   
         await connection.QueryAsync<Order>(  
         @"select * from [dbo].[Orders]", new { });_//Assert.Equal(6, orders.Count());_  
_//Assert.Equal("VINET", orders.FirstOrDefault().CustomerID);_

**Map to dynamic object (without class)**

var productDynamic =   
                 await connection.QueryFirstOrDefaultAsync<dynamic>(  
                 @"select * from [dbo].[Products]", new { });_//Assert.Equal("Queso Cabrales", productDynamic.ProductName);_

_Note : QueryAsync() or Query() returns Enumerable List of objects._

**Multi-Mapping with SplitOn parameter**

var orderDetail =  
             await connection.QueryAsync<OrderDetail, Product, OrderDetail>(  
             @"select *   
               from [dbo].[OrderDetails] d  
               join [dbo].[Products] p on p.ProductID = d.ProductID  
               where d.OrderID = @OrderID",             (detail, product) =>  
             {  
                 detail.Product = product;  
                 return detail;  
             },  
             splitOn: "ProductID",  
             param: new { OrderId = 5 });_//Assert.Equal(3, orderDetail.Count());_  
_//Assert.Equal(6, orderDetail.FirstOrDefault().Quantity);_  
_//Assert.Equal(Decimal.Parse("21.00"),_   
_//    orderDetail.FirstOrDefault().Product.UnitPrice);_

**Multi-Mapping with SplitOn parameter**

var orderDetailWithTotal =  
           await connection.QueryAsync<OrderDetail, Product, decimal, OrderDetail>(  
           @"select   
             d.OrderID,   
             d.UnitPrice,  
             d.Quantity,   
             d.Discount,   
             p.ProductID,   
             p.ProductName,   
             p.UnitPrice,  
             (d.Quantity * d.UnitPrice * (1 - CAST(d.Discount AS decimal(6,4)))) Total  
             from [dbo].[OrderDetails] d  
             join [dbo].[Products] p on p.ProductID = d.ProductID  
             where d.OrderID = @OrderId",          (detail, product, total) =>  
          {  
               _//detail.TotalPrice = (detail.UnitPrice * detail.Quantity) * (1 - detail.Discount);_  
               detail.TotalPrice = total;  
               detail.Product = product;  
               return detail;  
          },  
          splitOn: "ProductID, Total", _//Columns Name_  
          param: new { OrderId = 5 });_//Assert.Equal(Decimal.Parse("95.76"),_   
_//    orderDetailWithTotal.FirstOrDefault().TotalPrice);_

_Note : If your primary key is ID/id and the reference table key is also ID/id dapper is going to split from that location. if your key’s are different, then you have to use SplitOn optional parameter._

**Process multiple results in a single query**

var orderWithDetails =  
    await connection.QueryMultipleAsync(  
    @"select *   
      from [dbo].[Orders]  
      where id = @OrderId;      select * from [dbo].[OrderDetails]   
      where OrderId = @OrderId",  
      param: new { OrderId = 6 });    using (orderWithDetails)  
    {  
       var order =  
                 await orderWithDetails.ReadFirstAsync<Order>();  
       order.OrderDetails = orderWithDetails.Read<OrderDetail>().ToList();  
       _//Assert.Equal("HANAR", order.CustomerID);_  
       _//Assert.Equal(40, order.OrderDetails.First().Quantity);_  
       _//Assert.Equal(5, order.OrderDetails.Count);_  
    }

_Note : Multiple Query’s or Procedure returns Multiple Data Sets._

**Stored Procedures**

var parameters = new DynamicParameters();  
parameters.Add("ProductID", 1);var product_ =  
    await connection.QueryFirstOrDefaultAsync<Product>(  
    "get_product",  
    param: parameters,  
    commandType: System.Data.CommandType.StoredProcedure);_//Assert.Equal("Queso Cabrales", product_.ProductName);_

**Insert Single and Multiple Records**

var insertProduct = await connection.ExecuteAsync(  
     @"insert into [dbo].[Products]([ProductName],[Discontinued])   
       values (@ProductName, @Discontinued)",  
       new { ProductName = "Filo Mix", Discontinued = 0 });//Assert.Equal(1, insertProduct);var insertMultipleProducts = await connection.ExecuteAsync(  
      @"insert into [dbo].[Products]([ProductName],[Discontinued])   
        values (@ProductName, @Discontinued)",  
        new[] {  
            new { ProductName = "Camembert Pierrot", Discontinued = 0 },  
            new { ProductName = "Perth Pasties", Discontinued = 0 }  
        });//Assert.Equal(2, insertMultipleProducts);

_Note : Same query allows you to add multiple records, Dapper execute same command multiple times e.g.: Bulk Data_

**Classes and Database Script for above Example**

public class Order {            public int ID { get; set; }            public string CustomerID { get; set; }            public string ShipAddress { get; set; }            public string Freight { get; set; }            public DateTime OrderDate { get; set; }            public List<OrderDetail> OrderDetails { get; set; }        }        public class OrderDetail {            public int OrderID { get; set; }            public Product Product { get; set; }            public int Quantity { get; set; }            public decimal UnitPrice { get; set; }            public decimal Discount { get; set; }            public decimal TotalPrice { get; set; }        }        public class Product {            public int ProductID { get; set; }            public string ProductName { get; set; }            public decimal UnitPrice { get; set; }        }

**Database Script**

CREATE TABLE [dbo].[Orders](  
	[ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,  
	[CustomerID] [nchar](5) NULL,  
	[OrderDate] [datetime] NULL,	  
	[Freight] [money] NULL,  
	[ShipAddress] [nvarchar](60) NULL,  
	[ShipCity] [nvarchar](15) NULL,  
	[ShipRegion] [nvarchar](15) NULL,  
	[ShipPostalCode] [nvarchar](10) NULL,  
	[ShipCountry] [nvarchar](15) NULL  
)  
GO  
CREATE TABLE [dbo].[OrderDetails](  
	[OrderID] [int] NOT NULL,  
	[ProductID] [int] NOT NULL,  
	[UnitPrice] [money] NOT NULL,  
	[Quantity] [smallint] NOT NULL,  
	[Discount] [real] NOT NULL  
	PRIMARY KEY ([OrderID],[ProductID])  
	FOREIGN KEY([OrderID]) REFERENCES [dbo].[Orders] ([ID])  
)  
GO  
CREATE TABLE [dbo].[Products](  
	[ProductID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,  
	[ProductName] [nvarchar](40) NOT NULL,  
	[SupplierID] [int] NULL,  
	[CategoryID] [int] NULL,  
	[QuantityPerUnit] [nvarchar](20) NULL,  
	[UnitPrice] [money] NULL,  
	[UnitsInStock] [smallint] NULL,  
	[ReorderLevel] [smallint] NULL,  
	[Discontinued] [bit] NOT NULL  
)  
GO