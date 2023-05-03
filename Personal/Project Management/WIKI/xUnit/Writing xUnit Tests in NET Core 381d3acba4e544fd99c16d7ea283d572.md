# Writing xUnit Tests in .NET Core

Created: September 7, 2020 9:23 AM

<aside>
💡 Article from: https://visualstudiomagazine.com/articles/2018/11/01/xunit-tests-in-net-core.aspx

</aside>

**First Steps**

As with the other testing frameworks that are part of Visual Studio, your first step in creating xUnit tests is to use Add > New Project to add a testing project (you can do that either from Visual Studio's File menu or from the popup menu you get from clicking on your Solution in Solution Explorer). In the Add New Project dialog in Visual Studio 2017, under the Test node on the left, you'll find four choices. You want the xUnit project -- cleverly called xUnit Test Project (.NET Core).

That choice will give you a project with a default class (UnitTest1), which you'll want to rename. As usual, you'll need to add a reference to your test project that points to the project with the code you want to test. Also as usual, you should right-click on your test project, select Manage NuGet Packages and check for any upgrades to NuGet packages that make up your project. Just to make my point, all three of the test-related packages for my sample project had pending upgrades.

Currently, there is no template for test classes so, to add a new test class to your test project, you'll need to add a new class, make the class public and then insert this using statement at the top of the class:

```csharp
using Xunit;
```

**Your First Test**

To write a test you simply create a public method that returns nothing and then decorate it with the Fact attribute. Inside that method you can put whatever code you want but, typically, you'll create some object, do something with it and then check to see if you got the right result using a method on the Assert class. In other words, pretty much what you did with Visual Studio Test.

This example instantiates a class called Customer, calls its ChangeName method and then checks to see if the related property was correctly changed:

```csharp
[Fact]
public void ChangesCustomerName()
{
  Customer cust = new BlazorViewModel();
  cust.ChangeName("Peter");
  Assert.Equal("Peter", cust.Name);
}

```

In addition to the Fact attribute, you can also use the Theory attribute on test methods. Theory runs a test method multiple times, passing different data values each time. You have a variety of tools for setting the data values to be passed to your test method. For example, by combining Theory with the InlineData attribute, you can pass an array of values to the test method. xUnit will run the test once for each InlineData attribute.

This code, for example, passes in three invalid customer names and checks that the ChangeName method throws an InvalidNameException for each value:

```csharp
[Theory]
[InlineData("p")]
[InlineData("O;Malley")]
[InlineData("O,Malley")]
public void CatchInvalidCustomerName(string name)
{
  BlazorViewModel bvm = new BlazorViewModel();
  Assert.Throws(() => bvm.ChangeName(name));
}

```

InlineData works great if your test values will be used in only one test method. If you have multiple methods in the same class that can use your values, the MemberData attribute lets you use a static method on your test class to provide test values to multiples methods in the test class. If you have test values that can be used in multiple test classes, the ClassData attribute allows you to specify a class that will pass a "collection of collections" to your test method.

**Additional Options**

xUnit provides several customization tools. By default in the Test Explorer window, all your tests will be listed by the method name. If you want, you can override that by setting the Name property on your Fact attribute -- often a good idea to improve readability. This example changes the name of the test in Test Explorer to "Customer Name Update":

```csharp
[Fact(Name = "Customer Name Update"]
public void ChangesCustomerName()
{

```

There are also times when you'll want to turn off a test (typically because the test is always failing for some reason you can't address right now and the resulting red lights in Test Explorer keep scaring you). To turn off a test method, set the Skip property on the Fact attribute to the reason that you've turned the test off (unfortunately the reason isn't currently displayed in Test Explorer).

This example notes that the test is turned off until the test data is cleaned up:

```css
[Fact(Skip ="Test data not available")]
public void ChangesCustomerName()
{
```

InlineData and Theory also support the Skip option.

As the number of your tests increases you may want to organize them into groups so you can run tests together. The Trait attribute lets you organize tests into groups by creating category names and assigning values to them.

This example creates a category called Customer with the value "Update":

```csharp
[Fact(DisplayName = "Change Name2")]
[Trait("Customer", "Update")]
public void ChangesCustomerName()
{
```

In Test Explorer this test will appear under the heading Customer [Update] (each Name/Value combination appears as a separate heading in Test Explorer). Unfortunately, there's no way to run all the tests in a category (for example, all the "Customer" tests).

**Running Your Tests**

All the mechanisms you have for running tests using the other Visual Studio test frameworks are available in xUnit ... but they run with one significant difference. By default, xUnit runs tests in different test classes in parallel, which can significantly shorten the time to run all your tests. It also means that xUnit effectively ignores the Run Tests in Parallel setting at the top of the Test Explorer window.

You can, however, override this default behavior where you need tests in different classes to run sequentially by assigning test classes to the same collection. You assign tests to a collection using the Collection attribute, passing a name for the collection.

This code assigns both the PremiumCustomerTests and the CashOnlyCustomerTests test classes to a collection called Customer Updates, ensuring that the tests in the two classes aren't run in parallel:

```csharp
[Collection("Customer Updates")]
public class PremiumCustomerTests
{
   ... //test methods ... 
}

```

```csharp
[Collection("Customer Updates")]
public class CashOnlyCustomerTests
{
 ... //test methods ... 
}

```

And that's everything you need to know to start using xUnit. You've probably noticed that, at the code level, writing xUnit tests isn't that much different from what you do with the testing tools you're using right now. Well, except for one thing: initializing your test environment. That's very different from the way it's handled in Visual Studio Test, so I'll cover that in my next column.