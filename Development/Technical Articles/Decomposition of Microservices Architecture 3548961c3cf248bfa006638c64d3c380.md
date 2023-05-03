# Decomposition of Microservices Architecture

Article Link: https://medium.com/design-microservices-architecture-with-patterns/decomposition-of-microservices-architecture-c8e8cec453e
Author: Mehmet Özkaya
Date Added: November 25, 2021 12:30 PM
Tag: .NET, Decomposition, Design-Patterns, Microservices, Microservices Pattern

In this article, we’re going to learn how to **Decompose Microservices** into **Microservices Architecture**. We will focus on **Identifying** and **Decomposing** Microservices for **E-Commerce Domain** with different **patterns** and **practices**.

![https://miro.medium.com/max/1400/1*HqJyReUxBOnbhtUqZuw6ag.png](https://miro.medium.com/max/1400/1*HqJyReUxBOnbhtUqZuw6ag.png)

By the end of the article, you will learn how to **Decompose Microservices** with apply various **Microservices Decomposition Patterns** like **Decompose by Business Capability, Decompose by Subdomain** and **Bounded Context Pattern** with designing e-commerce microservices application.

# **Step by Step Design Architectures w/ Course**

![https://miro.medium.com/max/700/0*ec-pObsreU2BbWu_.png](https://miro.medium.com/max/700/0*ec-pObsreU2BbWu_.png)

**[I have just published a new course — Design Microservices Architecture with Patterns & Principles.](https://www.udemy.com/course/design-microservices-architecture-with-patterns-principles/?couponCode=OCTOBER2021)**

In this course, we’re going to learn **how to Design Microservices Architecture** with using **Design Patterns, Principles** and the **Best Practices.** We will start with designing **Monolithic** to **Event-Driven Microservices** step by step and together using the right architecture design patterns and techniques.

# **Decomposition of Microservices Architecture**

we are going to Understand **E-Commerce Domain** and **Decomposition Microservices Architecture**.

So we are going to follow 2 main topics in this section**1- Understand E-Commerce Domain2- Decomposition Microservices Architecture and Identify Microservices**

![https://miro.medium.com/max/700/1*p3ToxSUnzWu8GDdAoUgN8Q.png](https://miro.medium.com/max/700/1*p3ToxSUnzWu8GDdAoUgN8Q.png)

After that we will continue to design our microservices architecture with adding new decomposed microservices.

# **Decomposition Microservices Architecture Path**

Let me explain our **Decomposition Path**, we will follow sort of steps;

![https://miro.medium.com/max/700/1*XFdh6thrNr8dxCa6b_GX-w.png](https://miro.medium.com/max/700/1*XFdh6thrNr8dxCa6b_GX-w.png)

- We will make E-Commerce **Domain** **analysis** in order to define your **microservice boundaries**.
- After that, we will use **DDD**, **Bounded Contexts**, and other **Decompose** stra**t**egies like decompose by **business capability**, Decompose by **subdomains** microservices patterns
- Lastly, we will **Identify microservice boundaries** and refactor our current design.

In order to follow these steps, first of all we need to fill our design toolset,that means understand design principles and patterns of Microservices Decomposition topics.

# **Microservices Decomposition Pattern — Decompose by Business Capability**

Think about that our monolithic application is large and complex application and want to use the microservice architecture. With the microservice architecture, we are going to **split the application** as a set of **loosely coupled** services in order to **accelerate** software development processes.

**How to decompose an application into services?**

There are some Prerequisite of decomposition of microservices.

- Services must be **cohesive**. A service should implement a small set of strongly related functions.
- Services must be **loosely coupled** — each service as an API that encapsulates its implementation.

“**Decompose by Business Capability**” pattern offers that;

- Define services corresponding to **business capabilities**.
- A business capability is a concept from **business architecture modeling**.
- A business service should **generate value**.

For example; Order Management is responsible for orders, Customer Management is responsible for customers.

![https://miro.medium.com/max/700/1*oXfkd1jNoRh3-m1Os-bJeQ.png](https://miro.medium.com/max/700/1*oXfkd1jNoRh3-m1Os-bJeQ.png)

If we look at our **domain** which is **e-commerce application**, The business capabilities can be like on the image included:

- **Product catalog** management
- **Inventory** management
- **Order** management
- **Delivery** managementand so on.

So we can decompose our microservices as per their business capabilities.

# **Microservices Decomposition Pattern — Decompose by Subdomain**

In this pattern, we will use **Decompose by Subdomain** model when decompose an application into microservices. As the same way we have 2 Prerequisite of decomposition of microservices; Services must be **cohesive** and Services must be l**oosely coupled.**

In order to apply **Decompose by Subdomain** model, we should define services corresponding to **Domain-Driven Design (DDD) subdomains**. DDD refers to the application’s problem space **the business** as the **domain**.A **domain** is consists of **multiple subdomains**. Each **subdomain** corresponds to a different part of the business.

![https://miro.medium.com/max/700/1*8XqP2SAksgYGzWXYI8YHqg.png](https://miro.medium.com/max/700/1*8XqP2SAksgYGzWXYI8YHqg.png)

If we look at our domain which is e-commerce application, The subdomains of an online store include:

- **Product** catalog
- **Inventory** management
- **Order** management
- **Delivery** management

But to **identify** these **domains** and **subdomains**, we should understand the **DDD** and **Bounded Context** **patterns** properly.

# **Bounded Context Pattern (Domain-Driven Design — DDD)**

We are going to see **DDD** — **Bounded Context Pattern** which is one of the main pattern that we mainly use when **decomposing microservices**. One of the best way of design microservices is using the **DDD**-**Bounded Context** pattern. So we should understand **Bounded Context** properly.

Before we start lets clarify that What is DDD ?

## **What is DDD ?**

We can say that **Domains** are require **high cooperation** and have a certain complexity by nature are called collaborative domains. In general, there is a good option that **DDD** is a more suitable solution for domains with this characteristic.

DDD has **two phases,** strategic and tactical DDD.

## **Strategic DDD**

In strategic DDD, we define the large-scale model of the system, defining to the **business rules**. Strategic DDD **identifies disciplines** that allow designing loosely coupling units and the context map between them.

## **Tactical DDD**

Tactical DDD focuses on **implementation** and provides **design pattern**s that we can use to build the **software implementation**. These design patterns include concepts such as **entity, aggregate, value object, repository**, and **domain service**. We are not going to detail in here. Because we are focus on the DDD and microservices.

DDD is **increase collaboration** between large technology teams by creating a common language on **changing business rules**. DDD domain defines an approach that has its own common language and divides boundaries into specific, **independent components**.

This common language is called ubiquitous language, and independent units are called **Bounded Context.**

![https://miro.medium.com/max/700/1*nFkfWZ_p5eaMtPLW7QXXCQ.png](https://miro.medium.com/max/700/1*nFkfWZ_p5eaMtPLW7QXXCQ.png)

So we can say that **DDD** is a recommended approach for use in complex systems.

**DDD** is solving a complex problem is usually to break the problem into smaller parts and focus on those **smaller problems** that are relatively easy. A complex domain may contain **sub domains.** And some of sub domains can combine and **grouping** with each other for **common rules** and **responsibilities**.

So we can say that **groups of sub domains** are **Bounded Contexts.** Bounded Context is the grouping of **closely related scopes** that we can say logical boundaries. So that **logical boundaries** can have common business rules and expressing the responsibility limits through a cluster.

We can say that the **bounded context** is the logical boundary that represents the smaller problem particles of the complex domain that are **self-consistent** and as **independent** as possible.

![https://miro.medium.com/max/700/1*0H0IDcIYv3PdqwW9A1sAPg.png](https://miro.medium.com/max/700/1*0H0IDcIYv3PdqwW9A1sAPg.png)

You can see in the image, there are **2 bounded context** **sales** and **support** context. These are the logical boundaries that potential microservices separated by this way.

# **Identify Bounded Context Boundaries for Each Microservices**

So how we can **identify Bounded Contexts ?**

In order to **identify bounded contexts**, we should use **DDD**. And in DDD, we should use the **Context Mapping pattern** for identification of bounded contexts.

With **Context Mapping Pattern,** we can identify the whole bounded contexts in the application and with their **logical** **boundaries**. So the answer is **Context Mapping** and **The Context Map** is a way to define logical boundaries between domains.

![https://miro.medium.com/max/700/1*qPssjE4r_EKXxfckVlBHgA.png](https://miro.medium.com/max/700/1*qPssjE4r_EKXxfckVlBHgA.png)

We can check the image for example identification.

First of all, We should identify the **Bounded Contexts** by talking to the **domain experts** and using some clues. Once I’ve defined the Bounded Contexts, we shouldn’t think that they are immutable anymore.

We will need to make changes to the boundaries you have drawnand **reshape** your **Bounded Contexts** by talking to the **domain** **experts**and consider refactorings with the changing conditions.

So When we designing a large application, its crucial to discuss with **domain experts** to defining **domains** and **sub domains** and evaluate **bounded context** with the domain experts will help you identify to microservices.

![https://miro.medium.com/max/700/1*Wf2S3JydAKhniz64t0ZESg.png](https://miro.medium.com/max/700/1*Wf2S3JydAKhniz64t0ZESg.png)

For example in this image there are several **Bounded Context** like**Customers**,**OrdersPayment** and so on.

And there is **sub domains** inside of the **Bounded Context** that some sub domains are representing same data but naming differently due to domain experts areas. That means we should discuss several **domain experts** for their **expertise areas**.

Now here is the question.

# **A Bounded Context == A Microservice ?**

We can say that there is **no right answer** to this question under all circumstances.

A **Microservice** can represent a **Bounded Context** or part of it. In other words, a **Bounded Context can create more than one Microservice.** This is entirely a decision to be made based on the microservice’s need for **scalability** and **independence**.

While a **Bounded Context** defines the **boundaries** of the **domain**, a **Microservice** determines the **technical** and **organizational boundaries** as the same way of BC domains.

But nevertheless, this approach can be use when defining microservices from bounded contexts. Because this is similar to the definition of a microservice: it’s **autonomous** and responsible by **certain domain capability.**

So this is why **Context Mapping** and the **Bounded Context pattern** are good approaches for **identifying microservices**. We will also follow this pattern when decomposing microservices.

# **Using Domain Analysis to Model Microservices**

We are going to use **domain analysis** to model microservices. That means we will combine our newly learning items and decompose our e-commerce application microservices with together. But before that lets make a plan.

We said that, Microservices should be designed by **business capabilities**, and we should have **loose coupling** and **autonomous services**. Microservices are loosely coupled that means we can change a particular microservices **without affecting** other services. Each service can be change **independently**.

![https://miro.medium.com/max/700/1*1qClLswekJuFY4IqKfi3Eg.png](https://miro.medium.com/max/700/1*1qClLswekJuFY4IqKfi3Eg.png)

[https://docs.microsoft.com/en-us/azure/architecture/microservices/model/domain-analysis](https://docs.microsoft.com/en-us/azure/architecture/microservices/model/domain-analysis)

**Domain-driven design (DDD)** provides a set of **methodology** that we can follow the principles and create a **well-designed microservices.** We should follow **DDD-Bounded Context** which following **Context Mapping** **Pattern** and **decompose by sub domain models** patterns.

So, we’ll walk through the following steps, applying them to our e-commerce application:

![https://miro.medium.com/max/1400/1*Rlm4rrGuki-5_lE9aQzcmQ.png](https://miro.medium.com/max/1400/1*Rlm4rrGuki-5_lE9aQzcmQ.png)

- We are going to Start by **analyzing the business domain** to understand the application’s functional requirements.
- Next, we will define the **bounded contexts** of the domain with following best practices. Each bounded context contains a domain model that include subdomains of the larger application.
- With the bounded contexts, we will **apply tactical DDD** patterns to define entities, aggregates, and domain services.

By the end of the these steps, we can identify the microservices in our application.

# **Analysis E-Commerce Domain — Use Cases**

Now we are going to talk about our project domain. So we will understand **E-Commerce Domain** with all **Use Cases.**

It doesn’t matter which architecture we are going to apply when **analyzing our domain**. So the first step always should be the understanding your domain and decomposing it into small pieces.

We will follow **DDD-Bounded Context** which following **Context Mapping** Pattern and decompose by sub domain models patterns.

## **Starting Our Project**

This project will be the **e-commerce web application**. So we should define our basic use case analysis. Its really important to understand what you will develop and its crucial that defining your use cases.

![https://miro.medium.com/max/700/1*2T3BTTE4Gyj1gxnUKqRC8g.png](https://miro.medium.com/max/700/1*2T3BTTE4Gyj1gxnUKqRC8g.png)

There are several way to analysis the e-commerce domain;

We can follow several steps, like;

- **Requirements** and **Modelling**
- Identify **User Stories**
- Identify the **Nouns** in the user stories
- Identify the **Verbs** in the user stories

So after that we can Put all together into object **interaction diagram.** And these diagram would be our potential microservices if we choose the microservices architecture.

But now we will start a **small e-commerce** application. That’s why its good to start a minimum requirements;

## **Functional Requirements**

- List products
- Filter products as per brand and categories
- Put products into the shopping cart
- Apply coupon for discounts and see the total cost all for all of the items in shopping cart
- Checkout the shopping cart and create an order
- List my old orders and order items history

Another way to define these FRs is converting them to Use Case items;

## **User Stories**

- As a user I want to list products
- As a user I want to filter products as per brand and categories
- As a user I want to put products into the shopping cart so that I can check out quickly later on
- As a user I want to apply coupon for discounts and see the total cost all for all of the items that are in my cart
- As a user I want to checkout the shopping cart and create an order
- As a user I want to list my old orders and order items history
- As a user I want to login the system as a user and the system should remember my shopping cart items

As you can see that we have understood our E-Commerce Domain, write down our Functional Requirement and Use Cases.

# **Analysis E-Commerce Domain — Nouns and Verbs**

We are going to Analysis E-Commerce Domain — Nouns and Verbs. In the previous caption, we have **created user stories.** So now we can pick the **Nouns** and **Verbs** on the user stories and create diagrams.

If we expand the user stories and extract **nouns** and **verbs** from the stories, then we will see below picture.

![https://miro.medium.com/max/700/1*3IVFeg3VLvlrahmi8_3zrw.png](https://miro.medium.com/max/700/1*3IVFeg3VLvlrahmi8_3zrw.png)

I am looking for the nouns that will become my main objects and not the attributes.

## **Nouns:**

- Customer
- Order
- Order Details
- Product
- Shopping Cart
- Shopping Cart Items
- Supplier
- User
- Address
- Brand
- Category

These nouns will help us to find **sub domains** and **bounded contexts.** We have also verbs also here for understanding the communication between domains.

## **Verbs:**

- List products applying to paging
- Filter products by brand, category and supplier
- See product all information in the details screen
- Put products in to the shopping cart
- See total cost for all of the items
- See total cost for each item
- Checkout order with purchase steps
- Specify delivery address
- Specify delivery note for delivery address
- Specify credit card information
- Pay for the items
- Tell me how many items are in stock
- Receive order confirmation email
- List the order and details history
- Login the system and remember the shopping cart items

By using above nouns and verbs we can put together a **diagram** such as this:

![https://miro.medium.com/max/641/1*Wv34x37kAQyUX9H11wjGCA.png](https://miro.medium.com/max/641/1*Wv34x37kAQyUX9H11wjGCA.png)

[https://medium.com/aspnetrun/build](https://medium.com/aspnetrun/build)

As you can see that we have domain diagrams now and next we can define potential microservices.

# **Identifying and Decomposing Microservices for E-Commerce Domain**

We are going to **Identifying** and **Decomposing Microservices** for **e-commerce domain**. So if you follow the same steps that we applied in previous captions, we will see this new **microservices**;

![https://miro.medium.com/max/700/1*8CWsYb8LDCTlp8hDrCnDWQ.png](https://miro.medium.com/max/700/1*8CWsYb8LDCTlp8hDrCnDWQ.png)

So these are the **potential microservices** that we can apply our design afterwards.

As you can see that we have understand how to **Identifying** and **Decomposing Microservices** for e-commerce domain, now we should **focus on Microservices Architecture !!**

So we should **evolve our architecture** to **microservices architecture** in order to **accommodate business adaptations** faster time-to-market and handle larger requests.

# **Step by Step Design Architectures w/ Course**

![https://miro.medium.com/max/700/0*ftm0YwdDc1QcTLCk.png](https://miro.medium.com/max/700/0*ftm0YwdDc1QcTLCk.png)

**[I have just published a new course — Design Microservices Architecture with Patterns & Principles.](https://www.udemy.com/course/design-microservices-architecture-with-patterns-principles/?couponCode=OCTOBER2021)**

In this course, we’re going to learn **how to Design Microservices Architecture** with using **Design Patterns, Principles** and the **Best Practices.** We will start with designing **Monolithic** to **Event-Driven Microservices** step by step and together using the right architecture design patterns and techniques.

# **References :**

[https://docs.microsoft.com/en-us/azure/architecture/microservices/model/domain-analysis](https://docs.microsoft.com/en-us/azure/architecture/microservices/model/domain-analysis)[https://docs.microsoft.com/en-us/azure/architecture/microservices/model/tactical-ddd](https://docs.microsoft.com/en-us/azure/architecture/microservices/model/tactical-ddd)

[https://medium.com/aspnetrun/build-layered-architecture-with-asp-net-core-entity-framework-core-in-a-real-word-example-aa54a7ed7bef](https://medium.com/aspnetrun/build-layered-architecture-with-asp-net-core-entity-framework-core-in-a-real-word-example-aa54a7ed7bef)

[https://medium.com/trendyol-tech/ddd-ve-mikroservis-kavramlar%C4%B1-%C3%BCzerine-bounded-context-629bcf62ea90](https://medium.com/trendyol-tech/ddd-ve-mikroservis-kavramlar%C4%B1-%C3%BCzerine-bounded-context-629bcf62ea90)[https://yigitoguz.com/2019/06/20/modeling-microservices-bounded-contexts/](https://yigitoguz.com/2019/06/20/modeling-microservices-bounded-contexts/)[http://cagataykiziltan.net/tr/domain-centric-architecture-ve-domain-driven-design/](http://cagataykiziltan.net/tr/domain-centric-architecture-ve-domain-driven-design/)[https://medium.com/devopsturkiye/microservice-mimari-ve-dddnin-bounded-context-kavram%C4%B1-%C3%BCzerine-c5d2ce6f25d8](https://medium.com/devopsturkiye/microservice-mimari-ve-dddnin-bounded-context-kavram%C4%B1-%C3%BCzerine-c5d2ce6f25d8)