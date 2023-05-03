# Extending C# objects with our own custom methods

Article Link: https://minapecheux.com/website/2021/07/05/extending-c-objects-with-our-own-custom-methods/
Author: Mina Pêcheux
Date Added: October 28, 2021 9:46 AM
Tag: C#, Inheritance, LinQ, OOP

Let’s see how we can use extension methods to boost the behaviour of our C# objects without creating new derived types!

*This article is also available [on Medium](https://mina-pecheux.medium.com/extending-c-objects-with-our-own-custom-methods-843fc15303fd).*

[In my latest C# article](https://medium.com/c-sharp-progarmming/taking-a-quick-look-at-the-c-linq-technology-8bf2dd71a962), I offered a (quick) intro to the **C# Linq implementation** and how so useful I think it is. One reason I find it particularly user-friendly is because as soon as you’ve added the `using System.Linq;` import statement at the top of your file, all your arrays, lists and other enumerables just “magically” have new methods available: `OrderBy()`, `Average()`, `GroupBy()`…

Hum – wait; *we* haven’t defined those methods. And we are calling regular lists and arrays, just like we always did. So how come adding this import suddenly **populated those common objects with new methods**? How is it possible to directly “improve” a C# type without actually creating a derived class?

If you’re used to working in [the OOP paradigm](https://en.wikipedia.org/wiki/Object-oriented_programming), then you’re used to creating child classes and adding inheritance to further specify the behaviour of your objects. If you’re instead a fan of the [composition over inheritance principle](https://en.wikipedia.org/wiki/Composition_over_inheritance), you probably prefer to code up small reusable blocks that are neatly juxtaposed on your objects to implement the full shebang.

Either way: this is not what’s happening here. Here, we don’t join components or derive types – there just are those new methods that **popped out of nowhere**.

This is all possible thanks to the **C# extension methods**.

# **What are extension methods?**

As usual, let’s start by taking a look at [the Microsoft docs on this topic](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/extension-methods):

> Extension methods enable you to “add” methods to existing types without creating a new derived type, recompiling, or otherwise modifying the original type. Extension methods are static methods, but they’re called as if they were instance methods on the extended type.
> 

This definition highlights the crucial properties of extension methods: they are **static** but they pose as **instance methods** in the eye of the developer; and they allow us to work on **types that already exist**.

So extension methods are not about creating brand new objects (classes, structs, types, etc.) but rather **improving the existing ones**. And they try to do this as seamlessly as possible so that the devs can **intuitively** find and use the new implementation when working in their familiar IDE.

My personal belief is that a well-thought and well-implemented extension method should feel as if it not being there in the first place was a mistake. That’s sort of my thoughts on Linq: whenever I start tinkering with data, I just have this little grunt at the very beginning when I haven’t yet imported Linq and I’m lacking those “obvious” functions. I’ve just integrated as part of my workflow and consider them to be built-in the enumerables.

But they’re not! They are extension methods that the `using Sytem.Linq` statement silently comes to slap onto all those objects.

### **Common use cases**

Linq is the most famous application of extension methods, but there are plenty of other use cases where they can be useful.

In general, adding functionalities to the collections (like Linq does) can be useful because lots of devs are used to working with enumerables; indeed, improving their lists and arrays is nice because it doesn’t force them to use new classes or structs. They’ll just **keep their usual workflow** and **have access to new features**.

You can also use extension methods to create **[layer-specific functionalities](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/extension-methods#layer-specific-functionality)**. Those are all the variables, getters, methods, classes and crazy objects you can think that aren’t needed in the low levels of your application and only make sense at the higher (more end user-oriented) levels. For example, computing “the full name and title of the employee” means something at the business level but not for the underlying database queries. Using extension methods can help you **cherry-pick the features** you need depending on the application layer you’re currently working on.

# **Some quick examples**

### **Example 1: Boosting our strings**

A very common application of extension methods is for basic built-in types like strings. Say you want to count the number of words in a string; or you want to know whether it contains at least one digit; or you want to check if the string matches some specific casing.

All of those are not readily available when you start up a new C# project, but they can be very easily implemented using extension methods. To define an extension method, you have to **create a static method and use the keyword `this`** before the type of the object you want to define the extension method for. The object you’re working on is therefore passed to your extension method as a parameter and can then be used normally inside it.

Here are those three functions implemented in C# (the first one is taken directly from the Microsoft docs example):

```csharp
using System;
using System.Linq;
using System.Text.RegularExpressions;

public static class MyStringExtensions
{
    public static int WordCount(this String str)
    {
        return str.Split(new char[] { ' ', '.', '?' },
                         StringSplitOptions.RemoveEmptyEntries).Length;
    }
    public static bool ContainsDigits(this String str)
    {
        return str.Any((char c) => Char.IsDigit(c));
    }
    public static bool IsCamelCased(this String str)
    {
        Regex rx = new Regex(@"/^[a-z][a-z0-9]+(?:[A-Z][a-z0-9]+)*$/");
        return rx.IsMatch(str);
    }
}
```

*Note: the last function uses a regular expression – for more details on those and their usage in C#, you can check out one [my recent blog posts about regex in C#](https://medium.com/c-sharp-progarmming/extracting-info-from-strings-using-regex-in-c-1ba0379f8abd) 😉*

And here is a test `Main()` function to show how easy they are to call once defined:

```csharp
using System;

class Program
{
    static void Main(string[] args)
    {
        string testStr = "Hello world! Greetings to all.";
        Console.WriteLine("\"{0}\" contains {1} word(s)", testStr, testStr.WordCount());
        Console.WriteLine("-----------");
        string[] tests = new string[] {
            "A string with no digits.",
            "A string with 1 digit."
        };
        foreach (string test in tests) {
            Console.WriteLine("\"{0}\" contains digits? {1}", test, test.ContainsDigits());
        }
        Console.WriteLine("-----------");
        tests = new string[] {
            "my var", "my_var", "myVar", "myVar23", "MyVar"
        };
        foreach (string test in tests) {
            Console.WriteLine("\"{0}\" matches camel case? {1}", test, test.IsCamelCased());
        }
    }
    
    // output:
    //
    // "Hello world! Greetings to all." contains 5 word(s)
    // -----------
    // "A string with no digits." contains digits? False
    // "A string with 1 digit." contains digits? True
    // -----------
    // "my var" matches camel case? False
    // "my_var" matches camel case? False
    // "myVar" matches camel case? False
    // "myVar23" matches camel case? False
    // "MyVar" matches camel case? False
}
```

As you can see, calling those new methods feels quite “natural” – they are where we expect them to be and most IDEs (here I’m using Visual Studio Code) even kindly tell us that they’re available:

![https://minapecheux.com/website/wp-content/uploads/2021/07/csharp-extension-methods_intellisense.jpg](https://minapecheux.com/website/wp-content/uploads/2021/07/csharp-extension-methods_intellisense.jpg)

### **Example 2: Passing in parameters to our extension methods**

Quite often, having only the object we’re calling the extension method on is not enough – you also want parameters that are specific to the task at hand and that the dev provides when he/she calls the method on the object.

To add parameters, you just write them as you would normally after the mandatory “this parameter” at the beginning:

```csharp
using System;

public static class MyIntExtensions
{
    public static void LoopToAMultiple(this int i, int multiple)
    {
        for (int c = 0; c < i * multiple; c++)
            Console.WriteLine(c);
    }
}

class Program
{
    static void Main(string[] args)
    {
        3.LoopToAMultiple(2)
        
        // output:
        // 0
        // 1
        // 2
        // 3
        // 4
        // 5
    }
}
```

This way, the program knows that it is an extension method for your int variables (by looking at the `this int i` at the head of the parameters list), but it can also extract the additional parameters and use them in the method.

### **Example 3: Extending a custom class**

And of course, extension methods can also be **applied to your own objects**. For example, you could publish a basic package that defines the core implementation of your API; and then provide some optional extension packages that add some behaviour to the core lib objects.

In a different programming context, this is typically the mindset of the Angular JS framework — after you’ve installed the main package, you can easily import the more advanced features you’re interested in from other packages!

*Note: however, let’s point out that the [general guidelines on extension methods](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/extension-methods#general-guidelines) recommend to avoid them when you have complete control over the original classes.*..

Suppose you have a basic `CustomClass` type with an integer field inside and a basic method that computes a value from this field:

```csharp
public class CustomClass
{
    public int IntField { get; init; }

    public int GetIntValue() => IntField * 3;
}
```

You can define an extension method to compute another value from the `IntField` variable:

```csharp
public static class MyCustomClassExtensions
{
    public static int GetExtendedIntValue(this CustomClass c) => c.IntField * 6;
}
```

And both are called similarly once you’ve instantiated your object:

```csharp
using System;

class Program
{
    static void Main(string[] args)
    {
        CustomClass c = new CustomClass { IntField = 2 };
        Console.WriteLine(c.GetIntValue());
        Console.WriteLine(c.GetExtendedIntValue());
        
        // output:
        // 6
        // 12
    }
}
```

# **Important notes**

### **Code organisation**

The big advantage of extension methods is that they can be **centralised** in classes to better organise your codebase, and then **very quickly imported** to automatically “boost” the objects when required. For example, you could create a namespace with various utilities defined as extension methods in a separate file:

```csharp
using System;
using System.Linq;
using System.Text.RegularExpressions;

namespace MyStringExtensions
{
    public static class MyExtensions
    {
        public static int WordCount(this String str)
        {
            return str.Split(new char[] { ' ', '.', '?' },
                             StringSplitOptions.RemoveEmptyEntries).Length;
        }
        public static bool ContainsDigits(this String str)
        {
            return str.Any((char c) => Char.IsDigit(c));
        }
        public static bool IsCamelCased(this String str)
        {
            Regex rx = new Regex(@"/^[a-z][a-z0-9]+(?:[A-Z][a-z0-9]+)*$/");
            return rx.IsMatch(str);
        }
    }
}
```

And now, whenever you need those extensions in one of your scripts, you just add the appropriate import at the top:

```
using MyStringExtensions;
```

Thanks to this tool, you don’t need to copy and paste the same util function across your project anymore – which is, as always, an excellent remedy against **inconsistencies and scalability** issues!

But remember that extension methods are imported at the **namespace level**. So here, importing the `MyStringExtensions` namespace only gets one class (the `MyExtensions` class) — but if we had multiple classes, they would all get imported at the same time. Thus it can be better to cut your extensions into multiple namespaces to help the devs choose the features they want added to their project.

### **Extension methods priority, *aka* why isn’t my method called?**

A super important thing to keep in mind is that extension methods have a **lower priority than the instance methods** for the compiler; this means that if you happen to define an extension method that has the exact name and prototype that an instance method already registered on your object, then your extension method will simply be ignored at compile time.

When you call a method on an object, the compiler first looks for a match in the instance methods and only then in the extension methods; so it will simply stop at its first match if there is one.

Here is an example where the names and prototypes of the instance method and the extension method are different – so everything will run smoothly and you will get the intended behaviour:

```csharp
using System;

public struct CustomStruct
{
    public int MyInt { get; init; }
    public void MyInstanceMethod(int a)
    {
        Console.WriteLine($"[Instance] MyInt = {MyInt} : a = {a} ({a.GetType()})");
    }
}

public static class MyCustomStructExtensions
{
    public static void MyExtensionMethod(this CustomStruct s, string a)
    {
        Console.WriteLine($"[Extension] MyInt = {s.MyInt} : a = {a} ({a.GetType()})");
    }
}

class Program
{
    static void Main(string[] args)
    {
        CustomStruct s = new CustomStruct { MyInt = 5 };
        s.MyInstanceMethod(1);
        s.MyExtensionMethod("hello");
        
        // output:
        // [Instance] MyInt = 5 : a = 1 (System.Int32)
        // [Extension] MyInt = 5 : a = hello (System.String)
    }
}
```

Now, here’s another example where the names are the same but the prototypes are different – since C# has to have appropriate input parameters to consider the function a match, it will still distinguish between the two:

```csharp
using System;

public struct CustomStruct
{
    public int MyInt { get; init; }
    public void MyMethod(int a)
    {
        Console.WriteLine($"[Instance] MyInt = {MyInt} : a = {a} ({a.GetType()})");
    }
}

public static class MyCustomStructExtensions
{
    public static void MyMethod(this CustomStruct s, string a)
    {
        Console.WriteLine($"[Extension] MyInt = {s.MyInt} : a = {a} ({a.GetType()})");
    }
}

class Program
{
    static void Main(string[] args)
    {
        CustomStruct s = new CustomStruct { MyInt = 5 };
        s.MyMethod(1);
        s.MyMethod("hello");
        
        // output:
        // [Instance] MyInt = 5 : a = 1 (System.Int32)
        // [Extension] MyInt = 5 : a = hello (System.String)
    }
}
```

But if everything’s identical, the compiler will just call the instance method and ignore your extension method entirely (you’ve basically lost access to it cause you can’t differentiate between the two anymore):

```csharp
using System;

public struct CustomStruct
{
    public int MyInt { get; init; }
    public void MyMethod(int a)
    {
        Console.WriteLine($"[Instance] MyInt = {MyInt} : a = {a} ({a.GetType()})");
    }
}

public static class MyCustomStructExtensions
{
    public static void MyMethod(this CustomStruct s, int a)
    {
        Console.WriteLine($"[Extension] MyInt = {s.MyInt} : a = {a} ({a.GetType()})");
    }
}

class Program
{
    static void Main(string[] args)
    {
        CustomStruct s = new CustomStruct { MyInt = 5 };
        s.MyMethod(1);
        
        // output:
        // [Instance] MyInt = 5 : a = 1 (System.Int32)
    }
}
```

### **Remember: you can’t access private data in extension methods!**

Something that is worth saying is that, because extension methods look like instance methods, lines can get blurry at times. I’m not very familiar of this particular tool, so perhaps my experience is biased; but I’ve more than once had issues with extension methods not being able to access my object’s private data. This is *perfectly normal* since those methods are static: they only know of the class itself, not its instances! In truth, this is good in terms of **data encapsulation**: your extension methods shouldn’t be a sneaky way to get access to the internals of an object and a backdoor to get it all messy. But, as a dev, don’t forget: those methods are usually here to implement **global behaviour** that **don’t necessarily depend on the specifics of an instance**!

Let’s look back at our previous example where we had extension methods for our `CustomClass` type. If we add some private field holding the `_uid` of the instance, you can see that only the public fields show up with the Visual Studio Code editor’s C# IntelliSense tool and we can’t use this field in our `GetExtendedIntValue()` static method:

```csharp
public class CustomClass
{
    private static int LastUid = 0;
    private int _uid = LastUid++;

    public int IntField { get; init; }

    public int GetIntValue() => IntField * 3;
}
```

![https://minapecheux.com/website/wp-content/uploads/2021/07/csharp-extension-methods_no-private.jpg](https://minapecheux.com/website/wp-content/uploads/2021/07/csharp-extension-methods_no-private.jpg)

So make sure that all the data you want to access is public, or think of another way to implement your logic 😉

# **Conclusion**

Extension methods are a powerful way of quickly boosting the capacities of a given C# type. Because you don’t have to create new classes or structs to define this extended behaviour, you avoid flooding the developer with hundreds of types to remember. The devs can simply rely on the basic types they know and see them provide even more features than before.

But you have to be careful: the changes can be subtle and go unnoticed, and you run the risk of having your extension methods overwritten by instance methods. Also, you only have access to the public data of the objects you’re working on.

What about you: are a fan of extension methods? Do you use them a lot in your C# projects? Don’t hesitate to react in the comments! 🙂