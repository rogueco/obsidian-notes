# A few util snippets using reflection in C#

Article Link: https://minapecheux.com/website/2021/10/05/a-few-util-snippets-using-reflection-in-c/
Author: Mina Pêcheux
Date Added: October 28, 2021 9:13 AM
Tag: .NET, C#, Reflection, Runtime

Did you know that C# is actually quite good at manipulating types at runtime, too? That’s thanks to reflection! 🙂

*This article is also available [on Medium](https://mina-pecheux.medium.com/a-few-util-snippets-using-reflection-in-c-85e489dda647).*

**Reflection** is an incredible tool that allows you to **dynamically interact with your object types**. Be it to create an object with a dynamically computed type, or to get the type of variable that is not knowable beforehand by the programmer, as is the case here, it is a very powerful feature that lets you write highly abstract code.

It’s a way of working with types that are **not known at compile-time but at runtime**.

I’ve had the chance to show various use cases for C# reflection in my on-going series of tutorials on **how to make a RTS game in Unity/C#**, so if you want “real-life” scenarios of using this tool in dev, [make sure to check it out](https://medium.com/c-sharp-progarmming/making-an-rts-game-in-unity-91a8a0720edc)! 🙂 (For example, in episodes [17](https://medium.com/codex/making-a-rts-game-17-introducing-a-sound-system-2-2-unity-c-bb72a51c56c1), [18](https://medium.com/c-sharp-progarmming/making-a-rts-game-18-preparing-our-game-parameters-unity-c-96d3f598ecd5) or [30](https://mina-pecheux.medium.com/making-a-rts-game-30-refactoring-our-save-load-system-with-binary-serialisation-1-2-unity-c-a388083cfbae))

And in the meantime, here are some util snippets using reflection in C# – I hope you’ll find them useful! 🙂

# **Snippet #1: Listing all the fields or properties of a class type**

When you want to learn more about a class, reflection can tell you very useful like the set of fields or properties that it contains. This can be really cool for [automating handmade serialisation](https://medium.com/p/making-a-rts-game-30-refactoring-our-save-load-system-with-binary-serialisation-1-2-unity-c-a388083cfbae) or [displaying basic info in an agnostic way](https://medium.com/c-sharp-progarmming/making-a-rts-game-19-displaying-our-in-game-settings-unity-c-f551e5a93032), for example.

Suppose you have a very simple class like this one:

```csharp
public class TestClass
{
    // fields
    private int _myPrivateInt;
    private string _myPrivateString;
    public bool myPublicBool;
    public static float myStaticFloat;

    // properties
    public int DoubleMyPrivateInt => _myPrivateInt * 2;
    public string MyPrivateString
    {
        get => _myPrivateString;
        set {
            _myPrivateString = value;
        }
    }
}
```

To list all the fields of this class type, you just need to get a reference to the type and then call the **`GetFields()` method** on it:

```csharp
using System;
using System.Reflection;

public static class Program
{
    static void PrintTypeFields(Type t)
    {
        FieldInfo[] fields = t.GetFields();
        foreach (FieldInfo f in fields)
        {
            Console.WriteLine(
                $"{f.Name} (of type {f.FieldType}): " +
                $"private? {f.IsPrivate} / static? {f.IsStatic}");
        }
    }

    static void Main(string[] args)
    {
        Type t = typeof(TestClass);
        PrintTypeFields(t);
    }
    
    // output:
    //
    // myPublicBool (of type System.Boolean): private? False / static? False
    // myStaticFloat (of type System.Single): private? False / static? True
}
```

But you’ll see that, by default, `GetFields()` **only searches for the public fields** (here, I only get results for my two public variables). To also get the private ones, you have to pass in an additional parameter to your call: the **[binding flags](https://docs.microsoft.com/en-us/dotnet/api/system.reflection.bindingflags?view=net-5.0)**.

This specific enumeration tells the reflection system how it should perform the search, and which types of members, properties, classes or fields should be included. The nice thing is that you can easily **combine multiple flags** using the “or bitwise operator” `|`:

```csharp
// instance members
BindingFlags.Instance

// instance and static members
BindingFlags.Instance |  BindingFlags.Static

// instance and private members
BindingFlags.Instance |  BindingFlags.NonPublic
```

Here is an example that lists all of the fields in our `TestClass` (public, private and instance or static ones):

```csharp
using System;
using System.Reflection;

public static class Program
{
    static void PrintTypeFields(Type t)
    {
        FieldInfo[] fields = t.GetFields(
            BindingFlags.Public | BindingFlags.NonPublic |
            BindingFlags.Instance | BindingFlags.Static);
        foreach (FieldInfo f in fields)
        {
            Console.WriteLine(
                $"{f.Name} (of type {f.FieldType}): " +
                $"private? {f.IsPrivate} / static? {f.IsStatic}");
        }
    }

    static void Main(string[] args)
    {
        Type t = typeof(TestClass);
        PrintTypeFields(t);
    }
    
    // output:
    //
    // _myPrivateInt (of type System.Int32): private? True / static? False
    // _myPrivateString (of type System.String): private? True / static? False
    // myPublicBool (of type System.Boolean): private? False / static? False
    // myStaticFloat (of type System.Single): private? False / static? True
}
```

Similarly, `GetProperties()` allows you to browse the properties of the class:

```csharp
using System;
using System.Reflection;

public static class Program
{
    static void PrintTypeProperties(Type t)
    {
        PropertyInfo[] properties = t.GetProperties();
        foreach (PropertyInfo p in properties)
        {
            Console.WriteLine(
                $"{p.Name} (of type {p.PropertyType}): " +
                $"getter? {p.CanRead} / setter? {p.CanWrite}");
        }
    }

    static void Main(string[] args)
    {
        Type t = typeof(TestClass);
        PrintTypeProperties(t);
    }
    
    // output:
    //
    // DoubleMyPrivateInt (of type System.Int32): getter? True / setter? False
    // MyPrivateString (of type System.String): getter? True / setter? True
}
```

# **Snippet #2: Getting or setting a field value by field name**

Sometimes, you want to access the field of an object by name instead of directly writing `.myField`, either to get its current value or update it.

Let’s say we want to make a custom data save/load system that writes our objects in text files, with one field on each line. So, taking our `TestClass` again as example, we could have something like this for a basic instance:

```
_myPrivateInt:5
_myPrivateString:hello world
myPublicBool:true
```

*Note: I’m ignoring the static float field because it does not depend on the instance but on the class 😉*

Of course, in our case, we could implement this system with simple reads and assignments:

```csharp
using System;
using System.IO;

public class TestClass
{
    // fields...
    // properties...
    
    public void Save(string filepath)
    {
        string[] lines =
        { $"_myPrivateInt:{_myPrivateInt}",
          $"_myPrivateString:{_myPrivateString}",
          $"myPublicBool:{myPublicBool}" };
        File.WriteAllLines(filepath, lines);
    }

    public void Load(string filepath)
    {
        string[] lines = File.ReadAllLines(filepath);
        foreach (string line in lines)
        {
            string[] tmp = line.Split(':');
            string field = tmp[0];
            string value = tmp[1];
            if (field == "_myPrivateInt")
                _myPrivateInt = int.Parse(value);
            else if (field == "_myPrivateString")
                _myPrivateString = value;
            else if (field == "myPublicBool")
                myPublicBool = bool.Parse(value);
            else
                Console.WriteLine($"Unknown field! '{field}'");
        }
    }
    
    public void Print()
    {
        Console.WriteLine($"_myPrivateInt = {_myPrivateInt}");
        Console.WriteLine($"_myPrivateString = {_myPrivateString}");
        Console.WriteLine($"myPublicBool = {myPublicBool}");
    }
}
```

I’ve also added a `Print()` method to easily get the current value of my fields and I can now test this: you see that I do retrieve my data properly! 🙂

```csharp
using System;

public static class Program
{
    static void Main(string[] args)
    {
        TestClass instance = new TestClass(5, "hello world", true);
        instance.Save("my_file.txt");

        TestClass instance2 = new TestClass();
        Console.WriteLine("Before load:");
        instance2.Print();

        instance2.Load("my_file.txt");
        Console.WriteLine("\nAfter load:");
        instance2.Print();
    }
    
    // output:
    //
    // Before load:
    // _myPrivateInt = 0
    // _myPrivateString = 
    // myPublicBool = False

    // After load:
    // _myPrivateInt = 5
    // _myPrivateString = hello world
    // myPublicBool = True
}
```

But this is **not very generic**, and we are using a really **ugly if-else block** for loading back the data! If we change the fields in our class, this will crash unless we change both the save and load functions… and if we ever derive a new class from this `TestClass`, we won’t have any way of saving and loading its specific fields!

To avoid these issues, we can use reflection to **automatically list and save or retrieve the values**, field per field.

The save function is straight-forward to write:

```csharp
public class TestClass
{
    // ...
    
    public void Save(string filepath)
    {
        FieldInfo[] fields = GetType().GetFields(
            BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Instance);
        string[] lines = new string[fields.Length];
        for (int i = 0; i < fields.Length; i++)
            lines[i] = $"{fields[i].Name}:{fields[i].GetValue(this)}";
        File.WriteAllLines(filepath, lines);
    }
    
}
```

For the load, it’s a bit more tricky. That’s because we are reading strings from our file, so we have to implement a **generic converter** (that transforms a string into the corresponding value of the given type).

Here is an example of such a converter (from [this Stack Overflow answer](https://stackoverflow.com/a/2961702)):

```csharp
public class TestClass
{
    // ...
    
    public static object ConvertFromString<T>(string input)
    {
        try
        {
            TypeConverter converter = TypeDescriptor.GetConverter(typeof(T));
            if (converter != null)
            {
                // Cast ConvertFromString(string text) : object to (T)
                return (T)converter.ConvertFromString(input);
            }
            return default(T);
        }
        catch (NotSupportedException)
        {
            return default(T);
        }
    }
    
}
```

We can now call this converter in our `Load()` function like this (the `MakeGenericMethod()` is yet another reflection utility that allows you to call a generic function and pass in the generic type from a variable):

```csharp
public class TestClass
{
    // ...
    
    public void Load(string filepath)
    {
        string[] lines = File.ReadAllLines(filepath);
        Type t = GetType();
        foreach (string line in lines)
        {
            string[] tmp = line.Split(':');
            string fieldName = tmp[0];
            string value = tmp[1];

            FieldInfo field = t.GetField(
                fieldName,
                BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Instance
            );

            MethodInfo convertFromStringMethod =
                t.GetMethod("ConvertFromString", BindingFlags.Static | BindingFlags.Public)
                .MakeGenericMethod(new Type[] { field.FieldType });

            object convertedValue = convertFromStringMethod.Invoke(null, new object[] { value });
            field.SetValue(this, convertedValue);
        }
    }
    
}
```

The nice thing is that I don’t have to change anything in my main routine because the interfaces haven’t changed, but the functions are now able to **dynamically adapt if I change my fields**, and I could even call the `Save()` and `Load()` methods on derived-types without any issue!

# **Snippet #3: Calling a method by name**

Just like, sometimes, you want to get a field value by name, it can also be interesting to get a reference to a method and call it using its string name as access key.

I’ve touched upon this in the previous section when I called the string converter – to get a method by name, you create a `MethodInfo` variable using the `GetMethod()` function.

Suppose I have another simple class with some functions:

```csharp
public class ExampleMethods
{
    public int myInt;
    
    public static void ExampleFunction()
    {
        Console.WriteLine("Hello world!");
    }

    public static void ExampleFunctionWithParams(string name)
    {
        Console.WriteLine($"Hello {name}!");
    }

    public void ExampleFunctionInstance()
    {
        Console.WriteLine($"myInt = {myInt}");
    }
}
```

If I create an instance from this class, I can then use `GetMethod()` to access its functions by name:

```csharp
using System;
using System.Reflection;

public static class Program
{
    static void Main(string[] args)
    {
        ExampleMethods instance = new ExampleMethods();
        instance.myInt = 12;

        Type t = instance.GetType();
        MethodInfo exampleFunction = t.GetMethod(
            "ExampleFunction", BindingFlags.Public | BindingFlags.Static);
        MethodInfo exampleFunctionWithParams = t.GetMethod(
            "ExampleFunctionWithParams", BindingFlags.Public | BindingFlags.Static);
        MethodInfo exampleFunctionInstance = t.GetMethod("ExampleFunctionInstance");

        Console.WriteLine($"exampleFunction = {exampleFunction}");
        Console.WriteLine($"exampleFunctionWithParams = {exampleFunctionWithParams}");
        Console.WriteLine($"exampleFunctionInstance = {exampleFunctionInstance}");
    }
    
    // output:
    //
    // exampleFunction = Void ExampleFunction()
    // exampleFunctionWithParams = Void ExampleFunctionWithParams(System.String)
    // exampleFunctionInstance = Void ExampleFunctionInstance()
}
```

Once again, **binding flags** are important: by default, you only get public instance methods. To get a private or a static function you have to add flags to your `GetMethod()` call.

If I try and get a method that doesn’t exist, or that I use the wrong binding flags, I just get a null result:

```csharp
using System;
using System.Reflection;

public static class Program
{
    static void Main(string[] args)
    {
        // ...
        MethodInfo wrongFunctionName = t.GetMethod("AFunction");
        MethodInfo wrongFunctionBindings = t.GetMethod(
            "ExampleFunctionWithParams", BindingFlags.NonPublic);

        Console.WriteLine($"wrongFunctionName = {wrongFunctionName}");
        Console.WriteLine($"wrongFunctionBindings = {wrongFunctionBindings}");
    }
    
    // output:
    //
    // wrongFunctionName =
    // wrongFunctionBindings =
}
```

Once you have accessed your `MethodInfo`, to actually call the method, you need to use its `Invoke()` function. It’s used differently for instance and static methods:

- for instance methods, you naturally have to pass in the instance to run the method on
- for static methods, on the other hand, you don’t need any instance so you can just pass in a `null` value for the instance

```csharp
using System;
using System.Reflection;

public static class Program
{
    static void Main(string[] args)
    {
        ExampleMethods instance = new ExampleMethods();
        instance.myInt = 12;

        Type t = instance.GetType();
        MethodInfo exampleFunction = t.GetMethod(
            "ExampleFunction", BindingFlags.Public | BindingFlags.Static);
        MethodInfo exampleFunctionInstance = t.GetMethod("ExampleFunctionInstance");

        // calling a static function: no need for an instance
        exampleFunction.Invoke(null, null);
        // calling an instance function: passing in an instance
        exampleFunctionInstance.Invoke(instance, null);
    }
    
    // output:
    //
    // Hello world!
    // myInt = 12
}
```

The second parameter is for input parameters, in case your method requires any. When you pass `null`, you’re not sending any parameters; if you need to pass some, you’ll have to wrap them in an array of `object`s:

```csharp
using System;
using System.Reflection;

public static class Program
{
    static void Main(string[] args)
    {
        ExampleMethods instance = new ExampleMethods();

        Type t = instance.GetType();
        MethodInfo exampleFunctionWithParams = t.GetMethod(
            "ExampleFunctionWithParams", BindingFlags.Public | BindingFlags.Static);

        // calling a function with input parameters (wrapped
        // as an array of objects)
        exampleFunctionWithParams.Invoke(null, new object[] { "Mina" });
    }
    
    // output:
    //
    // Hello Mina!
}
```

*Additional notes:*

- *if you try to invoke a method that requires parameters without any, or vice-versa, you’ll get an error at runtime*
- *you can pass in an instance to `Invoke()` for a static method if you want: it won’t be used but it won’t cause any error*

# **Snippets #4/5: Listing classes in an assembly (+ filtering with Linq)**

At a higher-level, it can be useful to know what classes are currently defined in your project. When searching for classes, you have to scope the search to a given **assembly**.

As explained [in the Microsoft docs](https://docs.microsoft.com/en-us/dotnet/standard/assembly/):

> Assemblies form the fundamental units of deployment, version control, reuse, activation scoping, and security permissions for .NET-based applications. An assembly is a collection of types and resources that are built to work together and form a logical unit of functionality.
> 

To list all the available classes in your assembly (meaning the assembly that the class you are calling this from resides in), you can use the **`Assembly` class** from the reflection package. You usually combine it with a bit of **[Linq queries](https://medium.com/c-sharp-progarmming/taking-a-quick-look-at-the-c-linq-technology-8bf2dd71a962)** to isolate just the classes:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;

public static class Program
{
    public class TestClass { ... }
    public class ExampleMethods { ... }

    static void Main(string[] args)
    {
        IEnumerable<Type> availableClasses =
            from t in Assembly.GetExecutingAssembly().GetTypes()
            where t.IsClass
            select t;
        foreach (Type t in availableClasses)
            Console.WriteLine(t.Name);
    }
    
    // output:
    //
    // Program
    // TestClass
    // ExampleMethods
}
```

Of course, you can also look for **a specific namespace** or the **classes derived from a type** by adding more conditions to your Linq query:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;

namespace MyNamespace
{

  public static class Program
  {
      public class TestClass { ... }
      public class ExampleMethods { ... }

      public class TestClassSubA : TestClass {}
      public class TestClassSubB : TestClass {}

      static void Main(string[] args)
      {
          // listing classes in a namespace
          IEnumerable<Type> namespaceClasses =
              from t in Assembly.GetExecutingAssembly().GetTypes()
              where t.IsClass && t.Namespace == "MyNamespace"
              select t;
          foreach (Type t in namespaceClasses)
                Console.WriteLine(t.Name);

          Console.WriteLine("");

          // listing classes that are derived from a type
          IEnumerable<Type> derivedClasses =
              from t in Assembly.GetExecutingAssembly().GetTypes()
              where t.IsClass && t.IsSubclassOf(typeof(TestClass))
              select t;
          foreach (Type t in derivedClasses)
                Console.WriteLine(t.Name);
      }

      // output:
      //
      // Program
      // TestClass
      // ExampleMethods
      // TestClassSubA
      // TestClassSubB
      //
      // TestClassSubA
      // TestClassSubB
  }

}
```

# **Conclusion**

I’ve only recently really dived into reflection in C# but I find that this tool is amazing: it allows me to get **a deeper understanding of the relationships between my objects** and it lets me write very **abstract and generic code** that is completely agnostic of the specifics 🙂

What about you – do you use reflection a lot in your C# projects? Have you had nice use cases for it? Don’t hesitate to react in the comments!