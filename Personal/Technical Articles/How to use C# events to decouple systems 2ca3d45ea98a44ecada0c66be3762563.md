# How to use C# events to decouple systems

Article Link: https://minapecheux.com/website/2021/06/30/how-to-use-c-events-to-decouple-systems/
Author: Mina Pêcheux
Date Added: October 28, 2021 11:32 AM
Tag: C#, Delegate, OOP

Events are key to reducing entanglement in your codebase – let’s see why!

*This is article is also available [on Medium](https://mina-pecheux.medium.com/how-to-use-c-events-to-decouple-systems-4d73e6c7ed71).*

# **What are events in C#?**

**[Events](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/events/)** are an interesting tool in C# whenever you want to reduce the **entanglement** between the **systems** in your app since they allow you to **notify** other classes and objects from anywhere in your project. On the one hand, you create *publishers* that send events; on the other hand, you also create *subscribers* to receive and react to them.

A publisher can have lots of subscribers and will **broadcast** to all of them when triggered.

*Note: by the way, events rely on the C# delegates – if you’re curious and want a little refresher on how those work, I’ve recently published [an article about C# delegates](https://medium.com/c-sharp-progarmming/quickie-dev-7-using-delegates-in-c-d4f8445e3338).*

Say you are programming a video game – then you’ll probably have to manage several coexistent but not directly related systems: the core game mechanics, the UI, the sounds… All of those will of course end up pretty complex by the end of the project. Ideally, you’d like each to work on its own so you can **focus on one system at a time**.

But! The problem is that you still need those systems to **work together**. They have to **communicate**. For example, the sound system doesn’t usually do things by itself: it plays specific sounds when specific actions are performed. So – if we’ve isolated our systems so neatly and we’ve made sure they are well-organised, how can we make them talk to each other?

That’s where events come in!

By using events, you can have systems send messages to a **central event bus** and/or consume them to run the appropriate **callback**(s). To get a better understanding of this topic, let’s take a look at a basic example.

We’ll start with a basic setup and then gradually add features to show the different possibilities events offer.

# **Discovering events through a basic arcade game example**

### **Step 1: Connecting the systems**

Suppose you have a very basic arcade game in which, whenever you reach a new score threshold, you “level up”. This is shown to the player in two ways: first, you have a flashy label on the screen; second, you have a little ringing sound to congratulate you on your progress. Ok so, here’s the setup:

- the points are handled in the main game manager
- aside from that, we have our UI and sound systems that are nicely separated
- we need all of these components to communicate to completely implement the level up feature

To do this, we can use the `System.EventHandler` built-in (along with `System.EventArgs`) to quickly setup an inter-systems discussion.

First, let’s define our 3 systems in code. The `GameManager` is the one that handles the core game mechanics (among which the current level); it has a `LevelUp()` function that we’ll call by hand in this small example but that would be triggered by the aforementioned logic in the real game. This function raises an event by calling the `EventHandler` typed-variable in the class, called `onLevelUp`.

```csharp
public class GameManager
{
    private int level;
    
    public GameManager() {
        level = 1;
    }
    
    public void LevelUp()
    {
        level += 1;
        Console.WriteLine("[Game] Current level: {0}", level);
        EventHandler handler = onLevelUp;
        if (handler != null)
        {
            handler(this, System.EventArgs.Empty);
        }
    }
    public event EventHandler onLevelUp;
}
```

This `onLevelUp` handler will then be used by the subscribers to know what to “listen to”.

*Note: we need to pass in args to the event handler, even if we don’t actually have any in this example. This is mandatory in order to comply with the `EventHandler` prototype which is necessary when using delegates.*

The `SoundManager` and `UIManager` classes are very similar and they both define a callback function: that’s the logic that should be run whenever they receive a “level up event” from the `GameManager`, i.e. when the `onLevelUp` handler is triggered.

```csharp
public class SoundManager
{
    public void OnLevelUp(object sender, System.EventArgs e)
    {
        Console.WriteLine("[SOUND] Levelling up");
    }
}

public class UIManager
{
    public void OnLevelUp(object sender, System.EventArgs e)
    {
        Console.WriteLine("[UI] Levelling up");
    }
}
```

It’s important to point out that these systems are of course way simpler than what we would have in a real game; also, you don’t need all callback functions to have the same name. You can name them whatever you want, as long as you reference them properly when setting up the subscriptions (see the following snippet of code).

Now, all that’s left to do is to setup a test session of our game by instantiating the 3 systems, having the subscribers handle the event, and then having the publisher raise it:

```csharp
class Program {

  static void Main(string[] args)
  {
      // 1. create our various game systems
      GameManager gameManager = new GameManager();
      SoundManager soundManager = new SoundManager();
      UIManager uiManager = new UIManager();

      // 2. register the event subscribers
      gameManager.onLevelUp += soundManager.OnLevelUp;
      gameManager.onLevelUp += uiManager.OnLevelUp;

      // 3. publish an event
      gameManager.LevelUp();
  }
  
}
```

When we run the `LevelUp()` function, we get the first print in the console directly from this function, then the event is raised and the two subscribers catch it; the moment they catch it, they run the callback function(s) they have associated with it, which in turn print the other two debugs in the console:

```
[Game] Current level: 2
[SOUND] Levelling up
[UI] Levelling up
```

### **Step 2: Hooking up multiple callbacks for one handler**

Another amazing feature of events in C# is the fact that you can have more than one callback functions for a subscriber. In other words, the event receivers may **trigger multiple actions** in a row.

*Note: this is a direct consequence of the fact that events work with delegates – once again, more info [here](https://medium.com/c-sharp-progarmming/quickie-dev-7-using-delegates-in-c-d4f8445e3338) if you’re interested 😉*

This is pretty useful to avoid cramming up everything in the same function and keeping a clean code. By separating the callbacks and chaining them in the event handling, you better **separate the concerns** as each callback only takes care of a little bit of logic.

Let’s say we want the `UIManager` to display several labels on the screen: one with the “Level up!” congrats banner, another with your new level, etc. Implementing this is as easy as changing our callbacks and assigning them in the `Main()` test function:

```csharp
class Program {

  static void Main(string[] args)
  {
      // ...

      // 2. register the event subscribers
      gameManager.onLevelUp += soundManager.OnLevelUp;
      gameManager.onLevelUp += uiManager.ShowLevelUpBanner;
      gameManager.onLevelUp += uiManager.ShowCurrentLevelLabel;

      // ...
  }
  
}

public class UIManager
{
    public void ShowLevelUpBanner(object sender, System.EventArgs e)
    { /* ... */ }
    public void ShowCurrentLevelLabel(object sender, System.EventArgs e)
    { /* ... */ }
}
```

### **Step 3: Sending data with the event**

Finally, it can be interesting to pass in some additional data along with the message. For now, we’re only saying that something happened, but we don’t give the other systems any info whatsoever on what really happened.

We’ve talked about showing up the current level… but how would the `UIManager` know what to print? At the moment, only the `GameManager` knows what the current level is!

To be able to send data along with the event, we have to define our own event args. This is done by creating a class that inherits from the `System.EventArgs` and contains the different fields we need – in our case, just the current level as an integer:

```csharp
public class OnLevelUpEventArgs : EventArgs
{
    public int Level { get; set; }
}
```

Then, we need to make sure that our event uses it, by saying that the `onLevelUp` variable is of `EventHandler<OnLevelUpEventArgs>` type. This is because `EventHandler` is a [generic class](https://medium.com/c-sharp-progarmming/quickie-dev-6-using-generics-in-c-1c8330eb3669) that can be further **specified** if need be. So, here are the changes in our `GameManager` class:

```csharp
public class GameManager
{
    // ...

    public void LevelUp()
    {
        level += 1;
        Console.WriteLine("[Game] Current level: {0}", level);
        EventHandler<OnLevelUpEventArgs> handler = onLevelUp;
        OnLevelUpEventArgs e = new OnLevelUpEventArgs();
        e.Level = level;
        if (handler != null)
        {
            handler(this, e);
        }
    }
    public event EventHandler<OnLevelUpEventArgs> onLevelUp;
}
```

And similarly, for the subscribers, they need to be expecting `OnLevelUpEventArgs` args in their callback functions; and they need to use them! Here’s how to modify the `SoundManager` and `UIManager` to make use of our new event args:

```csharp
public class SoundManager
{
    public void OnLevelUp(object sender, OnLevelUpEventArgs e)
    {
        Console.WriteLine("[SOUND] Levelling up");
    }
}

public class UIManager
{
    public void ShowLevelUpBaner(object sender, OnLevelUpEventArgs e)
    {
        Console.WriteLine("[UI] Levelling up");
    }
    public void ShowCurrentLevelLabel(object sender, OnLevelUpEventArgs e)
    {
        Console.WriteLine("[UI] Current level: {0}", e.Level);
    }
}
```

Now, without having to change anything in the test function, we’ll automatically get this new info on the subscribers side and we’ll get our new prints:

```
[Game] Current level: 2
[SOUND] Levelling up
[UI] Levelling up
[UI] Current level: 2
```

We have successfully transferred the event and the data from the `GameManager` to the two other systems, yay! 🙂

# **[Edited] Beware of the memory leaks!**

**Acknowledgment:** big thanks to [Xavier ElevationAPI](https://medium.com/u/e92aa0c65bcd?source=post_page-----4d73e6c7ed71--------------------------------) for pointing out that I’d forgotten to mention this 🙂

When you use events, you need to be carefully to release all the references to your publishers at the end of your program. This is called **[unsubscribing](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/events/how-to-subscribe-to-and-unsubscribe-from-events#unsubscribing)** and it can be done just as easily as subscribing, by using the `-=` operator:

```
publisher.RaiseCustomEvent -= HandleCustomEvent;
```

This is very important to avoid **memory leaks** and make sure that all the **allocated memory** is properly **disposed** of at the end of the execution of your program. Otherwise, the **C# garbage collector** will not be able to clean the reference when you dispose of a subscriber!

To avoid those memory leaks, you have to implement the unsubscribing phase when your subscribers are “dead”. In my simple example, I’ll simply do it at the end of the `Main()` function, but in more complex projects, you need to be careful where this “death” happens.

```csharp
class Program
{
    static void Main(string[] args)
    {
        // 1. create our various game systems
        // ...

        // 2. register the event subscribers
        // ...

        // 3. publish an event
        // ...

        // at the end of the program, unsubscribe from events
        gameManager.onLevelUp -= soundManager.OnLevelUp;
        gameManager.onLevelUp -= uiManager.ShowLevelUpBaner;
        gameManager.onLevelUp -= uiManager.ShowCurrentLevelLabel;
    }
}
```

# **Conclusion: why are C# events powerful?**

This was a small example but it already showed us that events are a versatile tool worth digging into. They have various properties that make them really interesting for C# programmers.

The nice thing with events is that they work on a “**fire-and-forget**” basis – when publishers raise an event, they don’t follow through and track down the possible subscribers to check they all received it. Rather, the event is sent floating into the air and can be caught by whichever object is interested.

Why is that valuable? Because it allows us to **better decouple our systems**. We’ve seen it with the above example and I’ve mentioned it a few times throughout my tutorial on [how to make a RTS in Unity](https://medium.com/c-sharp-progarmming/making-an-rts-game-in-unity-91a8a0720edc): thanks to events, you reduce the interconnections between the components of your codebase. And so you’re more at ease when working on your various systems because:

- you **avoid cluttering your code** with references to other parts of the project
- you **remove strong dependencies** which makes it easier to import a single system for testing purposes

If you know your OOP, you’re probably familiar with another design pattern called the [Singleton](https://en.wikipedia.org/wiki/Singleton_pattern), which is another way of easily referencing an instance in your codebase from anywhere to have it perform some action. However, it makes a tighter coupling between the classes: if the Singleton is not there, you’ll have errors all throughout your code asking about the missing guy.

With events, no worries! If one of the subscriber systems is not there, we will simply not have its callback – but the rest of the code won’t complain, because the publisher doesn’t check for the presence of all receivers. Take our `Main()` test function; if you were to comment out the two lines about the `SoundManager`, you could run it without any issue and you’d simply get one less print in the console.

All in all, I find events are a great way of **improving the structure of your codebase**. I’d also say they’re a **crucial tool for large dev teams** since they let each programmer tackle a part of the project without being overflooded with info and constraints from other systems.

What about you: do you use events often in C#? Do you think decoupling is the right way to go? Don’t hesitate to react in the comments! 🙂