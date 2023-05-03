# Abstract Class vs Interface

Created: July 6, 2020 9:32 PM

The short answer: An abstract class allows you to create functionality that subclasses can implement or override. An interface only allows you to define functionality, not implement it. And whereas a class can extend only one abstract class, it can take advantage of multiple interfaces.

## Abstract Class

An abstract class is a special type of class that cannot be instantiated. An abstract class is designed to be inherited by subclasses that either implement or override its methods. In other words, abstract classes are either partially implemented or not implemented at all.

## Interfaces

An interface is basically a contract—it doesn’t have any implementation. An interface can contain only method declarations; it cannot contain method definitions.

Methods declared in an interface must be implemented by the classes that implement the interface. Note that a class can implement more than one interface but extend only one class. The class that implements the interface should implement all its members.