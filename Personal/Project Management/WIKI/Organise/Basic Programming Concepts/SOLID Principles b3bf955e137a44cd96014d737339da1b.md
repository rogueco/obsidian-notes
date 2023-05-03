# SOLID Principles

Created: July 6, 2020 1:14 PM

## Single Responsibility Principle

The Single Responsibility Principle improves modularity by increasing cohesion; better modularity leads to improved testability, usability, and reusability.

Don't mix concerns in classes.

For example you could have services which call aspects of your code . Think about your portfolio site → when adding photo to a project or a blog they call a PhotoService. The `AddImageToProjectHandler` doesn't need to know how it's done it just needs to call **`PhotoAccessor.AddPhoto();` and pass in the file.**

> Don't put functions (methods) which change for different reasons in the same classes
> 

## Open/Close Principle

The Open/Closed Principle enables asynchronous deployment by decoupling implementations from each other.

> A software module/class is open for extension and closed for modification
> 

To to achieve this, you could create abstract classes of interfaces which can override methods which have been defined on the base class.

```csharp
public abstract class Shape  
{  
   public abstract double Area();  
}

public class Rectangle: Shape  
{  
   public double Height {get;set;}  
   public double Width {get;set;}  
   public override double Area()  
   {  
      return Height * Width;  
   }  
}  
public class Circle: Shape  
{  
   public double Radius {get;set;}  
   public override double Area()  
   {  
      return Radius * Radus * Math.PI;  
   }

public class AreaCalculator  
{  
   public double TotalArea(Shape[] arrShapes)  
   {  
      double area=0;  
      foreach(var objShape in arrShapes)  
      {  
         area += objShape.Area();  
      }  
      return area;  
   }  
}

//Whenever you introduce a new shape by deriving from the "Shape" 
// abstract class, you need not change the "AreaCalculator" class.
// This is because each derivied class has it's own 
// implementation of "AreaCalculator"
```

## Liskov Substitution Principle

The Liskov Substitution Principle promotes modularity and reuse of modules by ensuring the compatibility of their interfaces.

The Liskov Substitution Principle (LSP) states that "you should be able to use any derived class instead of a parent class and have it behave in the same manner without modification". It ensures that a derived class does not affect the behaviour of the parent class, in other words,, that a derived class must be substitutable for its base class.

## Interface Segregation Principle

The Interface Segregation Principle reduces coupling between unrelated consumers of the interface, while increasing readability and understandability.

The Interface Segregation Principle states "that clients should not be forced to implement interfaces they don't use. Instead of one fat interface, many small interfaces are preferred based on groups of methods, each one serving one submodule.

Essentially, it's better to have many smaller interfaces than one larger interface. 

## Dependency Inversion Principle

Dependency Inversion is the principle, Dependency Injection is how you make it work.

The Dependency Inversion Principle reduces coupling, and it strongly enables testability.

High level modules should not depend on low level modules, but rather both should depend on  abstractions.

The basics of it is that high level classes (classes that make calls to other classes i.e. with the new operator) should not depend on other classes, but should instead rely on abstractions, mainly interfaces

High level module is anything that is calling anything else.

Essentially, you couldn't change out anything in the lower level modules, because that would break the higher level modules.

That both the high and low level modules should rely on abstractions, and those abstractions should **NOT** depend on details. Meaning those abstractions shouldn't have to know how those things get done.

Anytime you use the `new object()` keyword, you are creating tightly coupled dependances on lower level modules.