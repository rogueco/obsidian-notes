# Boxing & Unboxing

Created: July 6, 2020 10:14 PM

All types derive from the `object` type.

So `string`, `int`, `double`, `float` are all of type `object`

If you wanted to cast an `string` to an `int.`

```csharp
string age = "28";
int intAge = (int)age;

// you would get an error. To get around this you need to 'box' the string baack
// to a object.

object ageObject = age;

// after this you are able to 'unbox' ageObject into an int by casting

int objectToAge = (int)ageObject;

// this will work without any issues.
```

<aside>
💡 https://www.geeksforgeeks.org/c-sharp-boxing-unboxing/

</aside>

```csharp
// C# implementation to demonstrate 
// the Unboxing 
using System; 
class GFG { 
  
    // Main Method 
    static public void Main() 
    { 
  
        // assigned int value 
        // 23 to num 
        int num = 23; 
  
        // boxing 
        object obj = num; 
  
        // unboxing 
        int i = (int)obj; 
  
        // Display result 
        Console.WriteLine("Value of ob object is : " + obj); 
        Console.WriteLine("Value of i is : " + i); 
    } 
}

// Value of ob object is : 23
// Value of i is : 23
```