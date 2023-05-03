# How to Learn SOLID Design Principles in ≈5 Minutes

Article Link: https://hackernoon.com/how-to-learn-solid-design-principles-in-5-minutes-952x33rm
Date Added: March 18, 2021 10:48 AM
Tag: Coding Standards, SOLID

![https://hackernoon.com/images/vVxAGkkRh2RcagPc0OYMILKCG0x2-gveq33ms.png](https://hackernoon.com/images/vVxAGkkRh2RcagPc0OYMILKCG0x2-gveq33ms.png)

### [@shvetavasisht](https://hackernoon.com/u/shvetavasisht)Shveta Vasisht

Tech learner.

SOLID design principles are a subset of design principles promoted by Robert C Martin in the essay “[Design Principles and Design Patterns](https://web.archive.org/web/20150906155800/http:/www.objectmentor.com/resources/articles/Principles_and_Patterns.pdf?ref=hackernoon.com)”. SOLID is the acronym that was introduced by Michael Feathers.

A good design aims to preserve the basic characteristics of a software solution while making it agile. The ultimate goal is always to provide a product that provides a solid foundation on which newer ideas can be placed. The design principles help to make a system that is always ready to evolve, change and embrace a new system.

New extensions to the system never result in an entangled mass of code. The system is flexible and maintainable. The need to redesign is not felt. Further modifications can thus be achieved with ease and on time. It is easy to determine the scope of modifications and extensions. The code becomes an easy-to-read book that can be understood by anyone.

These design principles help to make software flexible, readable, and maintainable.

The emphasis is on tackling problems like rigidity, fragility, immobility, and viscosity.

- The software should not be rigid and difficult to change. Changes to multiple parts of the code should not be required if the aim is to make a small change.
- Moreover, a change to a part of the software should not cause the code to break and lead to the introduction of errors in other parts.
- The software should be reusable. It should not carry so much baggage that it appears immobile and a programmer finds it better to rewrite duplicate code rather than reusing what is already available.
- The viscosity of a design should be such that it should not be hard to preserve the design and the development environment should not be slow.

Let’s take a quick look at the SOLID principles.

## **Single Responsibility Principle**

*A class should have one, and only one, reason to change.*

This implies that a class should have only one responsibility and should solve only one problem. This principle prevents tight coupling between classes. The need to change multiple classes is reduced. It is easier for you to make changes and the risk of introducing unanticipated errors is lowered. Such classes are easier to understand and implement.

You can apply this principle to classes, software components,and microservices.

## **Open-Closed Principle**

*A module should be open for extension but closed for modification.*

Bertrand Meyer is the originator of this principle and as per Robert C. Martin, this is the most important principle of object-oriented programming. This principle says that a class should be written such thatit can be extended but you should not modify it for introducing newfunctionality.

You can easily comply with this principle by using inheritance and polymorphism. The use of abstractions makes your class extendable without the need for modifications.

This principle helps to keep the code maintainable and readable by using segregation. The resulting code is also easy to review and test.

You should implement new functionalities by adding new classes, methods, and attributes instead of changing the existing ones.

## **Liskov Substitution Principle**

Coined by Barbar Liskov this principle states that *Subclasses should be substitutable for their base classes*

This implies that the user of the base class should continue to function without errors if a derivative of the base class is passed to it. Overridden methods of a subclass need to have the same input parameters and return values as the superclass. The subclass should not apply stricter validations to the input parameters than the superclass.

This principle, which is an extension of the Open-closed principle, can be difficult to implement. You need extensive code reviews and test cases to ensure compliance with this principle.

## **Interface Segregation Principle**

Martin advises that clients should not be forced to implement interfaces that they do not use.

*Many client-specific interfaces are better than one general purpose-interface*

As a programmer, you must avoid the temptation to add new methods to existing interfaces. This will help you to create client-specific interfaces instead of a single bulky interface. Also, any new class which you create will not be forced to implement extra methods which it will not use.Instead, a class can inherit multiple interfaces on a need basis.

The aim to divide the software into multiple parts such that it is easier to implement, change and maintain.

## **Dependency Inversion Principle**

*Depend upon Abstractions. Do not depend upon concretions*

Martin states that ‘ Dependency Inversion is the strategy of depending upon interfaces or abstract functions and classes, rather than upon concrete functions and classes’. This principle drives the strategy behindcomponent design, CORBA, EJB, etc. Martin emphasis that high-level modules should not depend upon low-level module and both these modules should depend on abstraction rather than on concrete classes.

## **Conclusion**

SOLID design principles are not a set of rules but guidelines that help you create better software. Software and technology aim to make the world better and these principles help create better software.

## References

1. [https://web.archive.org/web/20150906155800/http:/www.objectmentor.com/resources/articles/Principles_and_Patterns.pdf](https://web.archive.org/web/20150906155800/http:/www.objectmentor.com/resources/articles/Principles_and_Patterns.pdf?ref=hackernoon.com)
2. [https://www.bmc.com/blogs/solid-design-principles/](https://www.bmc.com/blogs/solid-design-principles/?ref=hackernoon.com)