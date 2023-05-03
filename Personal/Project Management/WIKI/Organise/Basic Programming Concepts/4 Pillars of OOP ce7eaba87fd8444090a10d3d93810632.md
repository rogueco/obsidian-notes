# 4 Pillars of OOP

Created: July 6, 2020 11:54 AM

- **[Encapsulation](https://www.geeksforgeeks.org/c-encapsulation/)** is data hiding(information hiding) while Abstraction is detail hiding(implementation hiding).
- While encapsulation groups together data and methods that act upon the data, data abstraction deals with exposing to the user and hiding the details of implementation.

## Abstraction

Capturing the core idea of an object and ignoring the details or specifics.

Data **abstraction** is the process of hiding certain details and showing only essential information to the user. Abstraction can be achieved with either **abstract classes** or **interfaces**

```csharp
// Abstract class
abstract class Animal
{
  // Abstract method (does not have a body)
  public abstract void animalSound();
  // Regular method
  public void sleep()
  {
    Console.WriteLine("Zzz");
  }
}

// Derived class (inherit from Animal)
class Pig : Animal
{
  public override void animalSound()
  {
    // The body of animalSound() is provided here
    Console.WriteLine("The pig says: wee wee");
  }
}

class Program
{
  static void Main(string[] args)
  {
    Pig myPig = new Pig(); // Create a Pig object
    myPig.animalSound();  // Call the abstract method
    myPig.sleep();  // Call the regular method
  }
}
```

## Encapsulation

Binds together pieces of code and keep it obscure to prevent outside changes.

Basically, keeping your code safe from outside use. You only show what you want to in that class.

*Pragmatic Programmer* Use's the phrase **'Tell, don't ask'**.

The outside world doesn't need to know the implementation of your code.

```csharp
public void ApplyDiscount (Customer customer, int orderId, int discount)
{
	customer.orders.find(orderId).GetTotal().ApplyDiscount(discount);
}

// Should really look like

public void ApplyDiscount (Customer customer, int orderId, int discount)
{
	customer.findOrder(orderId).ApplyDiscount(discount)
}

// the outside world doesn't need to know how we calculate the discount
// just that they need to call 'ApplyDiscount()' with the parameters
```

## Inheritance

In c#, Inheritance is one of the primary concept of object-oriented programming (OOP) and it is used to inherit the properties from one class (base) to another (child) class.

The inheritance will enable us to create a new class by inheriting the properties from other classes to reuse, extend and modify the behaviour of other class members based on our requirements.

```csharp
using System;

 

namespace Tutlane

{

    public class User

    {

        public string Name;

        private string Location;

        public User()

        {

            Console.WriteLine("Base Class Constructor");

        }

        public void GetUserInfo(string loc)

        {

            Location = loc;

            Console.WriteLine("Name: {0}", Name);

            Console.WriteLine("Location: {0}", Location);

        }

    }

    public class Details : User

    {

        public int Age;

        public Details()

        {

            Console.WriteLine("Child Class Constructor");

        }

        public void GetAge()

        {

            Console.WriteLine("Age: {0}", Age);

        }

    }

    class Program

    {

        static void Main(string[] args)

        {

            Details d = new Details();

            d.Name = "Suresh Dasari";

            // Compile Time Error

            //d.Location = "Hyderabad";

            d.Age = 32;

            d.GetUserInfo("Hyderabad");

            d.GetAge();

            Console.WriteLine("\nPress Any Key to Exit..");

            Console.ReadLine();

        }

    }

}
```

## PolyMorphism

polymorphism can be achieved by using method overloading

```csharp
public class Calculate

{

    public void AddNumbers(int a, int b)

    {

        Console.WriteLine("a + b = {0}", a + b);

    }

    public void AddNumbers(int a, int b, int c)

    {

        Console.WriteLine("a + b + c = {0}", a + b + c);

    }

}
```

If you observe above “Calculate” class, we defined a two methods with same name (AddNumbers) but with different input parameters to achieve method overloading, this is called a compile time polymorphism in c#.

In c#, Run Time Polymorphism means overriding a base class method in the derived class by creating a similar function and this can be achieved by using override & virtual keywords along with inheritance principle.

By using run-time polymorphism, we can override a base class method in the derived class by creating a method with the same name and parameters to perform a different task.

```csharp
using System;

 

namespace Tutlane

{

    // Base Class

    public class BClass

    {

        public virtual void GetInfo()

        {

            Console.WriteLine("Learn C# Tutorial");

        }

    }

    // Derived Class

    public class DClass : BClass

    {

        public override void GetInfo()

        {

            Console.WriteLine("Welcome to Tutlane");

        }

    }

    class Program

    {

        static void Main(string[] args)

        {

            DClass d = new DClass();

            d.GetInfo();

            BClass b = new BClass();

            b.GetInfo();

            Console.WriteLine("\nPress Enter Key to Exit..");

            Console.ReadLine();

        }

    }

}
```