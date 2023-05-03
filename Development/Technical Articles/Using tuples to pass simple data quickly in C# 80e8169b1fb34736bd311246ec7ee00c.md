# Using tuples to pass simple data quickly in C#

Article Link: https://medium.com/c-sharp-progarmming/using-tuples-for-passing-simple-data-quickly-in-c-6f4e2d465148
Author: Mina Pêcheux
Date Added: October 27, 2021 9:41 AM
Tag: .NET, C#, Tutorial

Starting from [C# 7.0](https://docs.microsoft.com/en-us/dotnet/csharp/whats-new/csharp-version-history#c-version-70) (released with Visual Studio 2017), the language has a great feature that I’ve only recently really dived into: **[tuples](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/value-tuples)**.

Tuples allow you to **group together loosely related data to create temporary (but mutable) lightweight data structures** that can be passed around to or from methods easily and overall **make your code more readable**.

They are pretty **straight-forward to implement** and they can be **used for various things**, such as anonymous types in queries, making a method return multiple values or, sometimes, advantageously replacing a `struct` or a `class`. They can even help with **[pattern matching](https://docs.microsoft.com/en-us/dotnet/csharp/fundamentals/functional/pattern-matching)** as explained in [this article by Changhui Xu](https://levelup.gitconnected.com/using-pattern-matching-to-avoid-massive-if-statements-ce286e2f0ea5) ;)

# **Creating and using tuples**

Tuples are a really nice way of **grouping some variables quickly**; they are **easy and intuitive to write**:

```csharp
class Program
{
    static void Main(string[] args)
    {
        (string, string) person = ("John", "Daveson");
    }
}
```

For example, this code snippet shows how to create a tuple of two strings that contain a firstname and a lastname. Note that, of course, you’re **not limited to 2 elements**, and **each element can have a different type**!

So, here, we could also integrate the age of the person inside our tuple:

```csharp
class Program
{
    static void Main(string[] args)
    {
        (string, string, int) person = ("John", "Daveson", 42);
    }
}
```

Once you’ve created your tuple, you can access its elements in various ways:

- using the `Item1`, `Item2`... **built-in references**: those give you back the different variables in your tuple via their index (starting from 1)
- using specific **user references** that you define yourself either when grouping the variables together in the tuple, or when retrieving them at the end with **deconstruction**
- using **inferred references** (only in C# 7.1+): in later versions, the name of a tuple field can be “guessed” by the program depending on the name of the variables you construct it from (but there are some limitations, and it can undermine the whole “created-on-the-spot” feature a bit, in my opinion)

Here’s an example that uses all of these techniques:

```csharp
using System;

class Program
{
    static void Main(string[] args)
    {
        // access via built-in index reference
        (string, string, int) person = ("John", "Daveson", 42);
        Console.WriteLine($"{person.Item1} {person.Item2} is {person.Item3}");

        // access via user-defined reference
        var person2 = (firstname: "Anna", lastname: "Laws", age: 36);
        Console.WriteLine($"{person2.firstname} {person2.lastname} is {person2.age}");

        (string firstname, string lastname, int age) person3 = ("Bill", "Potts", 24);
        Console.WriteLine($"{person3.firstname} {person3.lastname} is {person3.age}");

        // access via pre-existent variables
        string firstname = "Don";
        string lastname = "Rich";
        int age = 58;
        var person4 = (firstname, lastname, age);
        Console.WriteLine($"{person4.firstname} {person4.lastname} is {person4.age}");
    }

    // output:
    //
    // John Daveson is 42
    // Anna Laws is 36
    // Bill Potts is 24
    // Don Rich is 58
}
```

The second case here shows a crucial trick when working with tuples: using **deconstruction** to get back the different elements in the tuple as separate variables. This is a way of retrieving your data and **unpacking** it for further use.

As usual, because C# has its “**implicit** typer” **`[var` keyword](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/var)**, you can have it guess the type of objects in your tuple; but you can also provide them **explicitly**, or prepare them beforehand as "empty" variables and then fill them with the contents of your tuple:

```csharp
using System;

class Program
{
    static void Main(string[] args)
    {
        var t = ("Mercury", 46f, 2440);

        // use the 'var' keyword to get implicit types
        var (nameImplicit, distanceImplicit, radiusImplicit) = t;
        Console.WriteLine(
            $"Name: {nameImplicit}, " +
            $"Distance to Sun: {distanceImplicit} millions of km, " +
            $"Radius: {radiusImplicit} km");

        // specify the types explicitly
        (string nameExplicit, float distanceExplicit, int radiusExplicit) = t;
        Console.WriteLine(
            $"Name: {nameExplicit}, " +
            $"Distance to Sun: {distanceExplicit} millions of km, " +
            $"Radius: {radiusExplicit} km");

        // use variables defined beforehand
        string namePreexistent = string.Empty;
        var distancePreexistent = 0f;
        var radiusPreexistent = 0;
        (namePreexistent, distancePreexistent, radiusPreexistent) = t;
        Console.WriteLine(
            $"Name: {namePreexistent}, " +
            $"Distance to Sun: {distancePreexistent} millions of km, " +
            $"Radius: {radiusPreexistent} km");
    }

    // output:
    //
    // Name: Mercury, Distance to Sun: 46 millions of km, Radius: 2440 km
    // Name: Mercury, Distance to Sun: 46 millions of km, Radius: 2440 km
    // Name: Mercury, Distance to Sun: 46 millions of km, Radius: 2440 km
}
```

You can also create tuples from other tuples using basic **assignment**, as long as the number of elements and their types match (optionally with some implicit conversion):

```csharp
using System;

class Program
{
    static void Main(string[] args)
    {
        var t1 = (10, "hello");

        // exact type match
        var t2 = (4, "cool!");
        t2 = t1;
        Console.WriteLine($"t2 = ({t2.Item1}, {t2.Item2})");

        // implicit conversion of float to int
        var t3 = (-5.2f, "world");
        t3 = t1;
        Console.WriteLine($"t3 = ({t3.Item1}, {t3.Item2})");
    }

    // output:
    //
    // t2 = (10, hello)
    // t3 = (10, hello)
}
```

Ok — with all that said: what are good use cases for tuples? What are they relevant for?

# **Having a method return multiple values**

A very common usage is **when you want a method to return multiple values**. Instead of using the `[out` keyword](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/out-parameter-modifier), you can also **group all of the returns in one tuple**, return this tuple and then deconstruct it at the other end.

Let’s say you have a little function that computes the perimeter and the area of a rectangle. You want it to return both numbers in one go, rather than making two methods. So — you could use `out` to pass some variables by reference, and then you'd just have to prepare those variables and have them be filled by the method:

```csharp
using System;

class Program
{
    static void PerimeterAndAreaOut(
        float width, float height,
        out float perimeter, out float area
    )
    {
        perimeter = width * 2 + height * 2f;
        area = width * height;
    }

    static void Main(string[] args)
    {
        float width = 2f, height = 3f;

        float perimeter, area;
        PerimeterAndAreaOut(width, height, out perimeter, out area);
        Console.WriteLine($"Using 'out': perimeter = {perimeter}, area = {area}");
    }

    // output: Using 'out': perimeter = 10, area = 6
}
```

This works and it’s relatively readable. However, it requires you to take into account the fact that those **variables are now passed by reference**: they have to pre-exist the call, they can be modified in completely crazy ways without you knowing and they completely **break your chances of ever writing [functional code](https://hackr.io/blog/functional-programming)** with pure functions… (which in turn makes it harder to unit test, etc.).

Tuples avoid this issue: rather than passing in variables to modify, you can generate one inside your method that contains two parts, the perimeter and the area. And **this tuple can be returned** by the method just by setting its return type to match the types of the tuple elements:

```csharp
using System;

class Program
{
    static (float, float) PerimeterAndAreaTuple(float width, float height)
    {
        return (width * 2 + height * 2f, width * height);
    }

    static void Main(string[] args)
    {
        float width = 2f, height = 3f;

        (float perimeter, float area) = PerimeterAndAreaTuple(width, height);
        Console.WriteLine($"Using tuples: perimeter = {perimeter}, area = {area}");
    }

    // output: Using tuples: perimeter = 10, area = 6
}
```

When you call the function, you get a tuple with 2 float elements that can be deconstructed or read like we saw before. Pretty cool, right ? :)

# **Creating anonymous types**

Sometimes, your code might need to have some **short-lived very temporary value** to work on, and then have it cleaned up just as quickly. This is particularly frequent for **[LINQ queries](https://medium.com/c-sharp-progarmming/taking-a-quick-look-at-the-c-linq-technology-8bf2dd71a962)**: more often than not, you’ll want to compare, or sort, or group by a value that is not directly present in your data but computed from it.

Tuples are a way of having **[anonymous types](https://docs.microsoft.com/en-us/dotnet/csharp/fundamentals/types/anonymous-types)**: read-only values that are auto-typed by the compiler, usually made out of another piece of data and easy to iterate through or further inquire in your program.

Suppose you have a list of fruits that you can sell, and you know the unit price and the amount of each. What you want is to sort them according to their total price, meaning when multiplying the two values to get the value of all the apples, or oranges, or pears.

This would give you a simple LINQ query with an `OrderBy()`:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;

class Program
{
    struct FruitInfo
    {
        public string Name { get; init; }
        public float UnitPrice { get; init; }
        public int Amount { get; init; }
    }

    static void Main(string[] args)
    {
        FruitInfo[] fruits = new FruitInfo[]
        {
            new FruitInfo{ Name = "Apple", UnitPrice = 1.2f, Amount = 3 },
            new FruitInfo{ Name = "Orange", UnitPrice = 1.8f, Amount = 5 },
            new FruitInfo{ Name = "Pear", UnitPrice = 0.8f, Amount = 10 },
        };

        IEnumerable<FruitInfo> sortedFruits = fruits.OrderBy(f => f.UnitPrice * f.Amount);
        foreach (FruitInfo fi in sortedFruits)
            Console.WriteLine($"{fi.Name} ({fi.UnitPrice * fi.Amount})");
    }

    // output:
    //
    // Apple (3.6000001)
    // Pear (8)
    // Orange (9)
}
```

The thing is that if you want to print the total price, you have to recompute it a second time in the foreach-loop. No worries with only 3 items, but as the list keeps growing it might start to take a toll on your program!

A cool thing would be to compute it once, then use it for sorting, then for printing — we’d make an `IEnumerable` of floats with the total prices:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;

class Program
{
    struct FruitInfo { ... }

    static void Main(string[] args)
    {
        FruitInfo[] fruits = new FruitInfo[] { ... };

        IEnumerable<float> sortedFruits = fruits
            .Select(f => f.UnitPrice * f.Amount)
            .OrderBy(f => f);
        foreach (float fruitTotalPrice in sortedFruits)
            Console.WriteLine(fruitTotalPrice);
    }

    // output:
    //
    // 3.6000001
    // 8
    // 9
}
```

But, now, we’ve the lost the name of our fruits in the debug! So what if you want to keep it to print it, too? Do you really have to create a little `struct` with two fields just to hold this specific info?

Well, no! Tuples are a neat way of **shortening** all of this to fit in virtually the same size of code — instead of making an enumeration of `FruitInfo`, we can make an enumeration of `(string, float)` tuples:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;

class Program
{
    struct FruitInfo { ... }

    static void Main(string[] args)
    {
        FruitInfo[] fruits = new FruitInfo[] { ... };

        IEnumerable<(string, float)> sortedFruits = fruits
            .Select(f => (name: f.Name, price: f.UnitPrice * f.Amount))
            .OrderBy(t => t.price);
        foreach ((string name, float price) in sortedFruits)
            Console.WriteLine($"{name} ({price})");
    }

    // output:
    //
    // Apple (3.6000001)
    // Pear (8)
    // Orange (9)
}
```

Here, we’re simply keeping one value as is and computing the second one; then, we use some LINQ statements to sort the collection based on an item of our tuples and we get our final result!

# **Final notes**

## **Tuples VS `struct`s and `class`es**

As we’ve just seen, tuples can sometimes be seen as a more **“dev-friendly” alternative** to `struct`s or `class`es. They are a really nice option when ever you have **private or internal short-lived values**.

However, when you have public data that you’ll want to re-access or re-modify often, you should definitely go for a `struct` or a `class`.

## **Mutability**

Something worth noting when working with C# tuples is that they are **mutable**.

If a variable is **mutable**, then you can update its value once it’s been created; else, if it’s **immutable**, it sticks with the value it had upon creation for the rest of its life. For example, integers or strings are both immutable types because changing the value of a variable of this type means re-creating a new one. Arrays or lists, on the other hand, can be modified after their creation: they are mutable.

In C#, contrary to other programming languages like Python, you can update a tuple after it’s been created:

```csharp
sing System;

class Program
{
    static void Main(string[] args)
    {
        var t = (1, 3);
        t.Item1 = -2;
        Console.WriteLine($"t = ({t.Item1}, {t.Item2})");
    }

    // output: t = (-2, 3)
}
```

And even though the type is mutable, you can still access its **hash code** like you would for other C# objects. Notice how this hash code changes if you modify the tuple, but also that it is **deterministic**, meaning that reverting the changes brings back the original hash code:

```csharp
using System;

class Program
{
    static void Main(string[] args)
    {
        // a tuple has a hash code, like other C# objects
        var t = (1, 3);
        Console.WriteLine(t.GetHashCode());

        // changing an item changes the hash code...
        t.Item1 = 28;
        Console.WriteLine(t.GetHashCode());

        // ... but the hash code is unique and deterministic:
        // reverting the change brings back the original hash code!
        t.Item1 = 1;
        Console.WriteLine(t.GetHashCode());
    }

    // output:
    //
    // 1517290069
    // 1656406544
    // 1517290069
}
```

## **About tuples equality**

Finally, tuples can be compared and **checked for equality** just like other basic data types. The idea is basically to do a **“component-wise” comparison**: the program will check to see if each element of the tuple on the left equals the matching element of the tuple on the right and, if all do, then it returns “true” for equality.

Note that you can only check for equality between tuples of the same size: if they have **mismatching number of elements**, the code will not compile! Also, you have to make sure that every element on the left can be compared with `==` or `!=` to its right counterpart.

For example, these won’t work (they won’t compile):

```csharp
using System;

class Program
{
    static void Main(string[] args)
    {
        var t1 = (1, 2, 3);
        var t2 = (2, 4);
        if (t1 == t2) {} // does not compile because t1 has
                         // 3 elements and t2 has only 2

        var t3 = (1, 2);
        var t4 = ("hello", 4f);
        if (t3 == t4) {} // does not compile because strings
                         // cannot be compared with ints using '=='
    }
}
```

When checking if two tuples are equal, **only position counts**: the field names are not taken into account. So, for example, those tuples are *not* equal, because the values are reversed:

```csharp
using System;

class Program
{
    static void Main(string[] args)
    {
        var t1 = (width: 1, height: 2);
        var t2 = (height: 2, width: 1);
        Console.WriteLine($"t1 == t2 ? {t1 == t2}");
    }

    // output: t1 == t2 ? False
}
```

# **Conclusion**

**Tuples** are an amazing way of making **lightweight data structures**: they help with the flow of the code, avoid you writing `class` and `struct` initialisers and even **support functional programming**!

What about you: do you use tuples a lot in C#? Do you prefer passing your variables by reference and strolling on the object-oriented lane? Feel free to tell me in the comments! ;)