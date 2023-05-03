# 3: Algorithm to PsuedoCode

Course Title: Algorithms and Data Structures in C#
Created: June 22, 2020 12:08 PM
Language: C#
Medium: EdX

## Algorithm to Pseudocode

Your ultimate goal in programming is to code your algorithms for the tasks you want to perform in the application. One of the biggest mistakes that you can make is to consider a problem and then immediately sit in the front of the keyboard and start trying to write code to create the algorithm. The best approach is to:

- take time to consider the problem
- define the problem
- document the steps to solve the problem
- create pseudocode instructions
- convert pseudocode to real code
- test your algorithm

Wikipedia uses a clear and concise definition for pseudocode - "Pseudocode[1] is an informal high-level description of the operating principle of a computer program or other algorithm."

Some examples of pseudocode are written in plain English while other examples attempt to closely model a programming language. Two examples follow in relation to determining the value of 2 raised to a certain power, such as 2 raised to the 8th power (28).

```
// Plain English
Get base number
Get exponent
Set result = 1
While exponent is greater than 0
    set result = to result multiplied by base number
    subtract one from exponent value
Write out result

```

In this version we are writing out the steps for calculating a number (base) raised to a power (exponent). We don't specify the values because we want to be generic across all instances of values for base and exponent. So we get the base number, then we get the exponent, and finally set a result value to 1 (important for starting value). Now we are ready to do the calculation. If we have 2 raised to the 8th power, we need to multiply 2 (the base) and our running total (result). For example, 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 which is the same as saying 28

In order to do this in an automated fashion, we use a repeating loop where we look at the value of exponent and as long as it greater than 0, we perform the multiplication but we also subtract one from the exponent. We start at 8 and eventually we want to get to 0 so that our multiplication routine stops and produces the correct result.

Once we finish this, we output the value somewhere. In this example, the result would be 256.

```
// programming language style
SET base to number provided
SET exponent to number provided
SET result = 1

WHILE exponent > 0
    result = result * base
    exponent = exponent - 1

OUTPUT result

```

This version states precisely the same thing as the more English like version but is closer to a programming language and uses keywords that might be used in code such as SET, WHILE, OUTPUT. It is still somewhat generic but what it does is allow the pseudocode to be converted to any programming language with ease. Here is the result in C#.

```
int numBase = 2;
int exp = 16;
int result = 1;

    while (exp > 0)
    {
        result = result * numBase;
        exp--;
    }

Console.WriteLine($"Result is {result}");

```

Create a simple C# console application and input the code to test the algorithm. You can use a calculator to verify the results. Enter different values for the base or the exponent to test possible inputs from users and ensure they all work correctly.

**Challenge:** see if you can create an algorithm, pseudocode, and C# code for calculating the volume of a cylinder.