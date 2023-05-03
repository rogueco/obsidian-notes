# Classes & Objects

Created: July 6, 2020 10:00 PM

`Console.WriteLine();` - Console is a class and write line is a static method

<aside>
💡 Side note - `Console` is actually a singleton. We only have one console so it only needs to be instanced once. (This is also the case with `DateTime.Now`)

</aside>

## Class

Is a building block of an application. They are essentially a blueprint.

An Application can have many classes, each class is typically responsible for a different behaviour of the application.

```csharp
public class Person
{
	public string Name;

	public void Introduce()
	{
			Console.WriteLine(`Hi, my name is ${Name}`)
	};

}
```

## Object

A object is how we model real life objects. It's how we group information.

A program may create many objects of the same class. Objects are also called instances, and they can be stored in either a named variable or in an array or collection.

An object is basically a block of memory that has been allocated and configured according to the blueprint. 

A program may create many objects of the same class. Objects are also called instances, and they can be stored in either a named variable or in an array or collection.

```csharp
Person person = new Person();

person.Name = "Jeff";

person.Introduce();

// Hi, my name is Jeff

```

Take a car for example the car can have the following:

- Wheels
- Manufacture
- Number of windows
- Colour
- Number Of Doors

```csharp
Car car = new Car()
{
	Name = "Meh",
	Brand = "BMW"
}
```

objects can be an instance of a class