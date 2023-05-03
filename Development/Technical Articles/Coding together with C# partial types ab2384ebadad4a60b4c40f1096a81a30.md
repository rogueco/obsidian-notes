# Coding together with C# partial types

Article Link: https://minapecheux.com/website/2021/07/11/coding-together-with-c-partial-types/
Author: Mina Pêcheux
Date Added: October 28, 2021 9:42 AM
Tag: C#

Partial types at the rescue for code splitting!

*This article is also available [on Medium](https://mina-pecheux.medium.com/coding-together-with-c-partial-types-8d684d0235d4).*

As your project starts to grow in size, so will probably your team of developers. And while there are plenty of useful tools for **collaborative development** ([git](https://git-scm.com/) being the most famous one), C# itself actually provides an interesting feature for this: **partial types**.

# **What are partial types?**

As usual, let’s first take a look at [the Microsoft docs](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/language-specification/classes#partial-types) on this topic:

> A type declaration can be split across multiple partial type declarations. The type declaration is constructed from its parts by following the rules in this section, whereupon it is treated as a single declaration during the remainder of the compile-time and run-time processing of the program.
> 

It sounds fancy, but it’s a bit convoluted. What does it mean exactly, to “construct a type from its parts”? Well, in short, partial classes, methods, structs or interfaces are about **splitting up your code in multiple files** and **defining your objects “multiple” times**… while letting the compiler eventually re-stitch everything together!

The idea is to use the **`partial` modifier** on your type declaration so that the compiler is aware there is more to this object than just what’s written in this file. Said **compiler** is then able to find all the various places in your code where you defined your `partial X` type, and **glue it into a single `X` type**.

For classes, structs or interfaces, partial declarations allow you to patch fields or methods together from all the various files (but still in the **namespace**, though).

For methods, it’s a bit more tricky:

- first of all, partial methods can only be defined in partial types (i.e. partial classes, structs or interfaces)
- also, you defined the **prototype** on one side and the **implementation** on the other: the two have to be in the same partial object (but they can be in different parts of this partial object)
- the **implementation *can be* optional** (we’ll see later when); in which case, if you don’t actually provide an implementation for the partial method prototype, this function will simply be **“ignored”** by your program

Meaning that the compiler will truly flush out the prototype and any call you might have made to this function, as if it had never existed at all. This might look strange but it’s actually useful for us as developers because it means we won’t get compiling or runtime errors because the method is not defined.

Conversely, it’s also a real **dangerous thing** because you can forget to implement your partial method and no will tell you… it will simply not be run by your program, which may make for some **nasty bugs**!

Note that:

- as soon as one part of your object is declared as `partial`, all the others have to be too (so you can’t declare a `public partial class A {}` somewhere, and then another `public class A {}` elsewhere in the same namespace)
- you can make **nested partial types** (for example a partial class inside of another)
- all the parts of the same partial must be consistent in terms of keywords – for example, if one part is declared `public`, `sealed` or `abstract` then all the others have to be too
- all the parts of a partial type have to be defined in the same [module](https://stackoverflow.com/questions/645728/what-is-a-module-in-net) (.exe or .dll)
- (for more info, check [the Microsoft docs](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/partial-classes-and-methods#restrictions))

# **A little example: coding up a basic fighting game in the console**

Let’s say you and your teammates are working on a basic fighting game. In this simple combat simulator, you have two or more heroes stuck in an arena that have to battle each other to death!

You’re working in a small team with another dev – both of you have been tasked with preparing the main `Hero` class for this project. The two of you decide to proceed in 3 steps:

1. your colleague and you prepare the `Hero` class: this means defining the fields, the prototype of the important functions and the constructor for this entity
2. then you split up the remaining work: you’ll take care of the combat system while your partner handles the display
3. finally, you go back behind your screens and start coding up!

Now, this is all fine and pretty but step 3 does come with some hassle. How can you guys work on the same object at the same time, each behind one computer, without everything getting cluttered?

Thanks to partial classes and methods, it’s possible… and actually not that complicated! 😉

### **Prelude: the main program**

The senior programmers have already come up with the main game loop. This is the code that should compile and execute by the time you and your colleague are done with the `Hero` class.

```csharp
class Program
{
    static void Main(string[] args)
    {
        // initialise some heroes
        List<Hero> heroes = new List<Hero>() {
            new Hero("John", 20, 4, 4),
            new Hero("Betty", 12, 6, 1),
        };
        int nHeroes = heroes.Count;
        List<int> heroIndices = Enumerable.Range(0, nHeroes).ToList();

        // initial debug
        Console.WriteLine("Initial arena state:");
        foreach (Hero h in heroes) h.Display();
        Console.WriteLine("\n");

        // main game loop: run until there is
        // one or less hero alive in the field
        int turn = 1;
        Random r = new Random();
        while (heroes.Where((h) => h.Alive).Count() > 1) {
            Console.WriteLine("------");
            Console.WriteLine($"Turn #{turn++}:");

            // each hero picks a random adversary in the arena
            // and attacks her/him
            for (int heroIndex = 0; heroIndex < nHeroes; heroIndex++) {
                if (heroes[heroIndex].Alive) {
                    int otherHeroIndex = GetRandomItem<int>(
                        Shuffle(heroIndices.Where(i => i != heroIndex))
                    );
                    heroes[heroIndex].Attack(heroes[otherHeroIndex]);
                }
            }

            // in-game debug
            foreach (Hero h in heroes) h.Display();
        }

        // final debug
        Console.WriteLine("\nFinal result:");
        try {
            Hero winner = heroes.Where(h => h.Alive).First();
            Console.WriteLine($"{winner.Name} won!");
        } catch (ArgumentNullException e) {
            Console.WriteLine("Everybody's dead!");
        }
    }
}
```

As you can see, it’s pretty straight-forward:

- first, we initialise some `Hero` instances and we store in a list to easily add or remove new heroes in the arena
- then, we loop again and again while there are more than one hero alive in the field: at each turn, every (alive) hero picks another hero at random to attack and when all fights are finished we print the state of the arena
- we eventually exit the loop and print the name of the winner (or a specific message if all there is no hero left alive)

### **Step 1: Defining the basic data in the `Hero` class**

In this game, heroes are defined by only a handful of characteristics: their name, their healthpoints, their attack score and their defence score. Apart from the name that should be accessible from the outside, and therefore needs a **public getter**, the rest of the variables can just be **private fields** in the class.

Also, you have to implement a little constructor to assign the max and current healthpoints variables upon instance creation.

So here is the basic class you and your teammate came out with after your initial session – it’s all written in the `HeroMain.cs` file:

```csharp
public partial class Hero
{
  public string Name { get; }
  private int _maxHP, _currentHP;
  private int _attackScore, _defenceScore;

  public Hero(string name, int maxHP, int attackScore, int defenceScore) {
    Name = name;
    _maxHP = _currentHP = maxHP;
    _attackScore = attackScore;
    _defenceScore = defenceScore;
  }
}
```

Of course, you use the **`partial` modifier** on the class to insure it can defined in multiple files.

### **Step 2: Splitting up the work!**

So – the two systems you have to code up with your colleague are the **combat system** and the **display system**:

- the combat system allows heroes to attack each other and take damage
- the display system is used to keep the player updated on the current state of the game

You can see in the main game loop that each mainly relies on one function: the `Attack(Hero other)` method for the combat system and the `Display()` method for the display system.

To insure that you don’t miss any implementation and prepare all the necessary functions, your teammate and you decide to create an interface for the `Hero` class, `IHero`. As I explained in [another article on C# interfaces](https://medium.com/c-sharp-progarmming/how-c-interfaces-can-help-you-structure-your-codebase-7ec435e34747), this C# tool is an amazing way of structuring your codebase and enforcing some constraints on your classes so you’re sure they behave as expected. Interfaces are about declaring and not defining: they allow to set up a “contract” with the devs (and the compiler!) and insure that a given object implements a set of predefined fields or methods.

Here, you want to make sure that the `Hero` class provides the two public methods that are called in the main game loop: `Display()` and `Attack(Hero other)`:

```csharp
public interface IHero {
  void Attack(Hero other);
  void Display();
}

public partial class Hero : IHero
{ ... }
```

After you set the `Hero` class to derive from this interface, the compiler will immediately warn you about the missing implementation. No chance of forgetting these methods now! 🙂

![https://minapecheux.com/website/wp-content/uploads/2021/07/csharp-partial-missing-interface.jpg](https://minapecheux.com/website/wp-content/uploads/2021/07/csharp-partial-missing-interface.jpg)

Alright: time to start coding that logic!

### **Step 3: Just wrapping things up, basically**

At that point, you can see that most of the design is already done. You two “just” need to execute the plan and code up the body of the functions. Thanks to the interface constraints, you both can’t “forget” to write anything that’s absolutely necessary – you will necessary implement the `Attack()` method, and your friend will necessary implement the `Display()` one, or the code will simply not compile. This insures that the main program will run smoothly.

On the one hand, your colleague should be done quite quickly with the display system since it only requires her to code up a little `Display()` method. She works in her own `HeroDisplay.cs` file:

```csharp
using System;

public partial class Hero
{
    public void Display() {
        Console.WriteLine($"{Name}: {_currentHP}/{_maxHP} (atk: {_attackScore}, def: {_defenceScore})");
    }
}
```

You, on the other hand, have to do a bit more work. You’re going to work in a different file: `HeroCombat.cs`. First, you need to add the “alive” flag to the `Hero` class. This allows the main game loop to check whether a hero is still alive (i.e. it has more than 0 healthpoints). Thus you need a private variable (that can be modified by your logic) and a public getter for external access:

```csharp
public partial class Hero
{
    private bool _alive = true;
    public bool Alive { get => _alive; }
}
```

Then, you also need to implement the `Attack(Hero other)` method, as enforced by the `IHero` interface. And it would be better to separate the `Die()` logic in case it becomes more complex some day:

```csharp
public partial class Hero
{
    private bool _alive = true;
    public bool Alive { get => _alive; }

    public void Attack(Hero other) {
      other.TakeDamage(_attackScore);
    }

    private void TakeDamage(int damage) {
      _currentHP -= (damage - _defenceScore);
      if (_currentHP <= 0) {
        Die();
        _currentHP = 0;
      }
    }

    private void Die() {
      _alive = false;
    }
}
```

That’s nice! You now have a working `Hero` class that will allow the given main game loop to run properly:

```
Initial arena state:
John: 20/20 (atk: 4, def: 4)
Betty: 12/12 (atk: 6, def: 1)

------
Turn #1:
John: 18/20 (atk: 4, def: 4)
Betty: 9/12 (atk: 6, def: 1)
------
Turn #2:
John: 16/20 (atk: 4, def: 4)
Betty: 6/12 (atk: 6, def: 1)
------
Turn #3:
John: 14/20 (atk: 4, def: 4)
Betty: 3/12 (atk: 6, def: 1)
------
Turn #4:
John: 14/20 (atk: 4, def: 4)
Betty: 0/12 (atk: 6, def: 1)

Final result:
John won!
```

Well done! You’ve successfully implemented the main `Hero` class, and you did it as a collaborative dev with your partner without anyone treading on another’s toes 🙂

### **Bonus step: adding some optional debugs**

Something that is quite cool with **partial methods** is that you’re **not always forced to implement** it – and leaving a prototype without a body **doesn’t even cause an error**! Instead, the prototype and all the calls to the function will simply be removed when the code is compiled.

This allows you to optionally call some logic in your functions “if it happens to be there”. For example, you could want some additional debug in your attack system, when a hero attacks another or when a hero dies.

```csharp
public partial class Hero
{
    // ...

    partial void DisplayDieMessage();
    partial void DisplayAttackMessage(Hero other);

    public void Attack(Hero other) {
      DisplayAttackMessage(other);
      other.TakeDamage(_attackScore);
    }

    private void Die() {
      DisplayDieMessage();
      _alive = false;
    }
}
```

So you’ll tell your colleague that she has to implement two new functions in the display system: `DisplayAttackMessage(Hero other)` and `DisplayDieMessage()`. The first one displays that “Hero X attacks Hero Y”, and the second one says that “Hero X is dead”. But because she’s working on some other crazy bug at the time, your teammate can’t code it up right that minute.

No worries! Even if you add the calls to these new methods, because they’re partial, nothing will happen until there is actually a body to go along with the prototype. The situation will remain unchanged for now (no debug *and* no error or warning about you calling undefined logic); but a soon as your partner will have implemented the logic, the output will directly get “boosted” with those new messages:

```csharp
using System;

public partial class Hero
{
    public void Display() {
      Console.WriteLine($"{Name}: {_currentHP}/{_maxHP} (atk: {_attackScore}, def: {_defenceScore})");
    }

    partial void DisplayAttackMessage(Hero other) {
      Console.WriteLine($"{Name}: attacking {other.Name}");
    }

    partial void DisplayDieMessage() {
      Console.WriteLine($"{Name}: Aaarg! I'm dead!");
    }
}
```

```
Initial arena state:
John: 20/20 (atk: 4, def: 4)
Betty: 12/12 (atk: 6, def: 1)

------
Turn #1:
John: attacking Betty
Betty: attacking John
John: 18/20 (atk: 4, def: 4)
Betty: 9/12 (atk: 6, def: 1)
------
Turn #2:
John: attacking Betty
Betty: attacking John
John: 16/20 (atk: 4, def: 4)
Betty: 6/12 (atk: 6, def: 1)
------
Turn #3:
John: attacking Betty
Betty: attacking John
John: 14/20 (atk: 4, def: 4)
Betty: 3/12 (atk: 6, def: 1)
------
Turn #4:
John: attacking Betty
Betty: Aaarg! I'm dead!
John: 14/20 (atk: 4, def: 4)
Betty: 0/12 (atk: 6, def: 1)

Final result:
John won!
```

And remember that those functions are called from *your* code, the one you wrote prior to the logic implementation! Pretty neat, right? 🙂

Be careful, however – partial methods are only **optional under some conditions** (this is taken directly from [the Microsoft docs](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/partial-classes-and-methods#partial-methods)):

- It doesn’t have any accessibility modifiers (including the default private).
- It returns void.
- It doesn’t have any out parameters.
- It doesn’t have any of the following modifiers virtual, override, sealed, new, or extern.

# **Conclusion**

As we saw with this little fighting game example, **partial classes and methods** are an interesting tool for **code splitting** and therefore **collaborative development**.

They let you define the various characteristics and behaviours of your objects in separate files instead of mixing all the logic together, which is great for **separation of concerns**. Also, partial methods can sometimes be used for making the implementations of function bodies optional.

What about you: do you use partial types a lot? Have you ever benefited from them for teamwork dev? Let me know in the comments! 😉