# 2: Forming Algorithms

Course Title: Algorithms and Data Structures in C#
Created: June 22, 2020 11:57 AM
Medium: EdX

## Forming Algorithms

When we use the phrase "forming algorithms", we refer to the concept of considering a problem that we are trying to solve, and devising the steps necessary to solve that problem. Let's use an example to add clarity:

If you were told that you had 10 piles of stones and each pile contained 5 stones and then you were told you had to figure out how many stones there were altogether, you could apply some simple steps to solve this problem;

1. Multiply 10 by 5 to achieve 50
2. Perform simple addition 10 times adding 5 to the running total at each step

Both of the above options are valid and produce the desired result, correctly, every time, as long as the values don't change. Each item in the list is an algorithm and by writing it out and determining that it meets the needs, you have formed an algorithm.

Not all algorithms come about this easily. As an example of another formulation, let's revisit the morning routine we discussed in the opening topic. There are, what seems to be, a finite number of steps involved in that routine, reproduced here for your convenience.

1. Alarm clock wakes you (you decide to wake up and get ready for the day, or not)
2. You shower
3. You dress for the day
4. You potentially eat breakfast
5. You leave the house and head to work or school

While this seems logical and simple, and it is when performed by you each morning, there are some crucial aspects that are not taken into consideration here. We perform this routine so often that we fail to see the implicit decisions that we make without even thinking about them. This is what makes the formulation of algorithms for use in computer applications difficult at first. A computer is not able to "think" for itself. At least not yet but that is a whole set of courses on artificial intelligence and we're not quite there yet.

What is missing are the key decisions that you make in this routine. Let's consider those first.

1. Alarm clock wakes you. You can decide to: turn it off and get up, turn it off and go back to sleep, hit the snooze button
    
    Each one of these three options listed reverts to a single decision point that we can apply boolean logic to. Boolean logic deals with true or false results. For example, the alarm clock goes off, do I turn it off and get up? That is a yes/no (true/false) decision. Do I turn it off and go back to sleep? Another boolean logic question. Hit snooze? Yet another boolean logic application.
    
    Now, we need to get slightly more complex in that decision structure we are working on here. By this time, you should have taken the basic decision structure statements in the Introduction to C# course. You know that we can use an `if` decision in this case or we can use a `switch` statement. Ultimately, what we are looking at is known as a logical `OR` situation. You either turn it off and get up OR you turn it off and go back to sleep OR you hit snooze.
    
    So, how we decode this logic into instructions for the computer is the key aspect of forming algorithms and it is what trips up most new programmers. Trying to take a concept or process and breaking it down into logical and discrete steps to formulate a correct algorithm.
    
2. You shower
    
    This seems simple enough but is it? Before you read on, think about your shower activity. Are there any decisions that need to be made? Jot down your thoughts and then continue to read the remaining text here for some considerations.
    
    - Do I need to shampoo my hair?
        - Do I have enough shampoo?
    - Do I use conditioner?
        - Do I have enough conditioner?
    - How hot do I make the water?
    - Do I have a clean and dry towel?
    - Is there anybody else waiting to take a shower?
    - etc.
    
    As you can see, there are many smaller decisions that are part if a simple task of taking a shower. A computer is not able to discern all of these aspects but a computer program that is simulating this scenario, needs to be aware of all these facets.
    

We leave the remaining steps of this morning routine for you to evaluate and document the decisions and smaller discrete steps necessary to successfully complete them. In the next section, we will visit a common algorithm for calculating the result of a number raised to a certain power. We will evaluate the logic behind it and write what is known as pseudocode, an intermediate language for writing out an algorithm that is not dependent on code.