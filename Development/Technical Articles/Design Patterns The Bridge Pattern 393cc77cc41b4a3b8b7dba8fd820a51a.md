# Design Patterns: The Bridge Pattern

Article Link: https://obarguti.medium.com/design-patterns-the-bridge-pattern-38be13df9f71
Author: Omar Barguti
Date Added: October 4, 2021 10:03 AM
Tag: Design-Patterns

The bridge pattern is a very popular patterns that is used often in object-oriented architectures. It is a pattern that is difficult to grasp initially and can often be difficult to identify. It appeared in the famous Gang of Four book “Design Patterns: Elements of Reusable OO Software”, and it was designed as the following:

> Decouple abstraction from it’s implementation so the two can vary independently
> 

. This statement can be a little vague and somewhat difficult to understand. However, it can be broken down into smaller pieces so that it is better understood.

An abstraction is classified as a concept or a group of concepts that exists in the business domain. In other words, it can be a base class or an interface. When an abstraction is defined in the domain, an implementation or a number of implementations is created to define this abstraction. This would be in the form of classes that implement the abstract class of the interface. Typically, these two are tightly couple, and any changes in the interface will affect the implementations and vice versa. The idea behind the bridge pattern is to “abstract out the abstraction” so that the implementation is no longer tightly coupled. In other words, an abstract “bridge” is constructed between the implementation and the abstraction so that the two can vary. The bridge pattern is best explained through a thorough example.

**Example: Shape Area Calculator**

In the example below, a number of objects is created to represent various shapes such as circles and polygons. Each shape will need to support a method called “CalculateArea()” that returns the area of the shape. For simplicity, all the units of measurement used for these shapes is in centimeters (cm). A simple and naive approach to this design entails creating a class for each shape, where each class contains the CalculateArea() method:

**Circle.cs**

```
public class Circle
{
     public int Radius { get; set; }     public Circle(int radius)
     {
          Radius = radius;
      }      public double CalculateArea()
      {
           return Radius*Radius*Math.PI;
      }
}
```

**Square.cs**

```
public class Square
{
     public int Side { get; set; }     public Square(int side)
     {
          Side = side;
     }     public double CalculateArea()
     {
          return Side*Side;
     }
}
```

**Program.cs and Main**

```
public class Program
{
     public static void Main(string[] args)
     {
          Square square = new Square(4);
          Console.WriteLine(square.CalculateArea());          Circle circle = new Circle(3);
          Console.WriteLine(circle.CalculateArea());
      }
}
```

When the above program is executed on the command line, the area of a square with an edge length of 4cm and a circle with a radius of 3cm is printed on the screen:

**> 16> 28.2743338823081**

While the above results are correct, the program contains major flaws and limitations. There is nothing in the design to enforce that various shapes implement the CalculateArea() method. This prevents the ability of operating on various shapes generically. For example, it will not be possible to create an IEnumerable that operates on a collection of shapes and calculates their areas. This can be accomplished easily by implementing a common interface that guarantees various shapes to implement the CalculateArea() method.

**IShape.cs**

```
public interface IShape
{
     double CalculateArea();
}
```

**Circle.cs**

```
public class Circle : IShape
{
     public int Radius { get; set; }     public Circle(int radius)
     {
          Radius = radius;
     }     public double CalculateArea()
     {
          return Radius*Radius*Math.PI;
     }
}
```

**Square.cs**

```
public class Square : IShape
{
     public int Side { get; set; }     public Square(int side)
     {
          Side = side;
     }     public double CalculateArea()
     {
          return Side*Side;
     }
}
```

**Program.cs and Main**

```
public class Program
{
     public static void Main(string[] args)
     {
          IShape square = new Square(4);
          Console.WriteLine(square.CalculateArea());          IShape circle = new Circle(3);
          Console.WriteLine(circle.CalculateArea());
      }
}
```

The IShape interface above ensures that all the implementations (Circle and Square in this case) implement the CalculateArea() method. Additionally, it allows the Main method to create generic instances of Circles and Squares that are references generically as IShapes. While these changes improve the design tremendously, they do not necessarily satisfy the Bridge Pattern. However, they get the design one step closer to implementing the Bridge Pattern. In other words, the introduction of the IShape interface is a change that is recommended whether or not one is seeking to implement the bridge pattern.

**The unit Conversion Problem**In the design above, it is assumed that all the units used for the shape metrics are in centimeters. However, what the the design is to be enhanced to support other metric units, such as inches and meters. With this new requirement, the CalculateArea() method will need to be enhanced to support various metrics. There are multiple approaches to solve this problem, some of which are better than others. However, the first intuition might be to create a new implementations of each shape/metric. For example, a class is created for the area of circles in square inches, and another class is implemented for the area of the square in square feet. This would look like the following:

**Circle.cs**

```
public class CircleInches : IShape
{
     public int Radius { get; set; }
     private const double Inch = 2.54;     public CircleInches(int radius)
     {
          Radius = radius;
     }     public double CalculateArea()
     {
          return Radius * Radius *Math.PI * Inch * Inch;
     }
}
```

Issues with the approach above are clear. It is difficult to scale this design as a new class is required for each new metric or shape that are introduced. In addition, this will result in a lot of duplicate code and redundancies, especially when the classes grow and become more complex. This will lead to more issues in the future, such as having to fix any new bugs in multiple areas of the code.

**The Bridge Pattern to the Rescue**The bridge pattern is the best approach to address the scenario above. Since the majority of the code is the same in classes of the same shapes with different metrics, it is best to extract out the differences into a separate common class that can be utilized by all shapes. In this case, the conversion between centimeters and other units can be moved into a separate abstraction that serves all shapes. In order to accomplish this, a new interface is introduce for unit conversion. It will require the only method “Convert”:

**IUnitConverter.cs**

```
public interface IUnitConverter
{
     double Convert(double value);
}
```

The interface above is simple and it only requires the only method ‘Convert’. It takes the target value and it performs the appropriate operations on it. In this example, two implementations of this interface are created. One will be the ‘default’ implementation that returns the original value unaltered. This is the implementation that will be used if not unit conversion is desired. The second implementation will convert all the units within the shape class from centimeters to inches:

**DefaultUnitConverer.cs**

```
public class DefaultUnitConverter : IUnitConverter
{
     public double Convert(double value)
     {
          return value;
      }
}
```

**InchesUnitConverter.cs**

```
public class InchesUnitConverter : IUnitConverter
{
     public double Convert(double value)
     {
          return value/2.54;
     }
}
```

The next step is to enhance the IShape interface to hold a mandatory instance of IUnitConverter. However, an interface can only guarantee the existence of an IUnitConverter in the implementing class, but it cannot enforce the initialization of it. For this reason, the IShape interface will need to be converted to an abstract base class that contains a single constructor that takes in an IUnitConverter. In addition, the CalculateArea() method will need to be converted to an abstract method:

**Shape.cs**

```
public abstract class Shape
{
     public IUnitConverter UnitConverter { get; set; }     protected Shape(IUnitConverter unitConverter)
     {
          UnitConverter = unitConverter;
     }     public abstract double CalculateArea();
}
```

Once the interface is refactored into an abstract class, the Circle.cs and the Square.cs classes need to extend this new class. The new implementation of the abstract CalculateArea() must utilize the instance of the IUnitConverter in order to perform the conversion. That is accomplished by passing every parameter in the shape into the IUnitConverter.Convert() method. Also, the constructors of the new shape implementation must take in an instance of IUnitConverter in order to properly initialize the base class. For clarity, all the shape parameters are postfixed with the letters ‘Cm’ to indicate that they are always stored in centimeters:

**Circle.cs**

```
public class Circle : Shape
{
     public int RadiusCm { get; set; }

     public Circle(int radius, IUnitConverter unitConverter) : base(unitConverter)
     {
          RadiusCm = radius;
     }     public override double CalculateArea()
     {
          return UnitConverter.Convert(RadiusCm) * UnitConverter.Convert(RadiusCm) * Math.PI;
     }
}
```

**Square.cs**

```
public class Square : Shape
{
     public int SideCm { get; set; }     public Square(int side, IUnitConverter unitConverter) : base(unitConverter)
     {
          SideCm = side;
     }     public override double CalculateArea()
     {
          return UnitConverter.Convert(SideCm) * UnitConverter.Convert(SideCm);
     }
}
```

Once all shape classes extend the base class properly, any instance of the shape class can be created and initialized with a mandatory unit converter that is specific to the desired unit of conversion. The fact that the instance of shape can hold various converter classes provides the scalability and the code re-usability provided by the Bridge Pattern. Multiple instances of the same shape can be generated with different unit converters without any need to modify the implementation of the ClaculateArea() method:

**Program.cs and Main**

```
public class Program
{
     public static void Main(string[] args)
     {
          IUnitConverter defaultUnitConverter = new DefaultUnitConverter();          Shape squareCm = new Square(4, defaultUnitConverter);
          Console.WriteLine(squareCm.CalculateArea() + "cm squared");          Shape circleCm = new Circle(3, defaultUnitConverter);
          Console.WriteLine(circleCm.CalculateArea() + "cm squared");          IUnitConverter InchesUnitConverter = new InchesUnitConverter();          Shape squareInc = new Square(4, InchesUnitConverter);
          Console.WriteLine(squareInc.CalculateArea() + "cm squared");          Shape circleInc = new Circle(3, InchesUnitConverter);
          Console.WriteLine(circleInc.CalculateArea() + "cm squared");
     }
}
```

The program above prints the following results:**> 16 cm squared> 28.2743338823081 cm squared> 2.48000496000992 cm squared> 4.38253051681879 cm squared**