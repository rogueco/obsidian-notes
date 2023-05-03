# The Database-per-Service Pattern

Article Link: https://medium.com/design-microservices-architecture-with-patterns/the-database-per-service-pattern-9d511b882425
Author: Mehmet Özkaya
Date Added: October 8, 2021 10:26 AM
Tag: .NET, Microservices

In this article, we are going to talk about **Design Patterns** of Microservices architecture which is **The Database-per-Service pattern**. As you know that we learned **practices** and **patterns** and add them into our **design toolbox**. And we will use these **pattern** and **practices** when **designing microservice architecture**.

![https://miro.medium.com/max/1400/1*5CUirR-FYRC2nN4dA8dCjg.png](https://miro.medium.com/max/1400/1*5CUirR-FYRC2nN4dA8dCjg.png)

By the end of the article, you will learn where and when to **apply Database-per-Service pattern** into **Microservices Architecture** with designing **e-commerce application** system with following **KISS, YAGNI, SoC** and **SOLID principles**.

# **Step by Step Design Architectures w/ Course**

![https://miro.medium.com/max/1400/0*-xZlSEv3hLpfD29p.png](https://miro.medium.com/max/1400/0*-xZlSEv3hLpfD29p.png)

**[I have just published a new course — Design Microservices Architecture with Patterns & Principles.](https://www.udemy.com/course/design-microservices-architecture-with-patterns-principles/?couponCode=OCTOBER2021)**

In this course, we’re going to learn **how to Design Microservices Architecture** with using **Design Patterns, Principles** and the **Best Practices.** We will start with designing **Monolithic** to **Event-Driven Microservices** step by step and together using the right architecture design patterns and techniques.

# **The Database-per-Service pattern**

One of the **core characteristic** of the microservices architecture is the **loose coupling** of **services**. For that reason every service must have its own databases, it can be **polyglot persistence** among to microservices.

Let’s think about our **e-commerce** application. We will have **Product** — **Ordering** and **SC microservices** that each services data in their own databases. Any changes to one database don’t impact other microservices.

The service’s database **can’t be accessed directly** by other microservices. Each service’s persistent data can only be accessed via **Rest APIs**. So database per microservice provides many benefits, especially for **evolve rapidly** and support **massive scale systems**.

![https://miro.medium.com/max/1400/1*5CUirR-FYRC2nN4dA8dCjg.png](https://miro.medium.com/max/1400/1*5CUirR-FYRC2nN4dA8dCjg.png)

Data schema changes made easy without impacting other microservices

- Each database can scale **independently**
- **Microservices Domain** data is **encapsulated** within the service
- If one of the database server is **down**, this will **not affect** to other services

Also **Polyglot data persistence** gives ability to select the best optimized storage needs per microservices.

![https://miro.medium.com/max/1400/1*yftphSLwxoI4aSrpeoT7pw.png](https://miro.medium.com/max/1400/1*yftphSLwxoI4aSrpeoT7pw.png)

So if we see the image that **example** of **microservice architecture** of e-commerce application;

- The **product microservice** using **NoSQL document database** for storing catalog related data which is storing JSON objects to accommodate high-volumes of read operations.
- The **shopping cart microservice** using a **distributed cache** that supports its simple, key-value data store.
- The **ordering microservice** using a **relational database** to accommodate the rich relational structure of its underlying data.

Because of the ability of massive scale and **high availability**, **NoSQL databases** are getting high popularity and becoming widely use in enterprise application. Also their **schema-less structure** give flexibility to developments on microservices. We cover NoSQL databases later in upcoming articles.

As you can see that we have understand the **Design Patterns — The Database-per-Service pattern.**

So we should **evolve our architecture** with applying new **microservices patterns** in order to **accommodate business adaptations** faster time-to-market and handle larger requests.

See image that UI and MS communication are direct, and it seems hard to manage communications. We now we should focus on microservices communications with applying **API GW pattern** and evolving these architecture step by step.

# **Step by Step Design Architectures w/ Course**

![https://miro.medium.com/max/1400/0*hfyI0hXgjo6Lf6c5.png](https://miro.medium.com/max/1400/0*hfyI0hXgjo6Lf6c5.png)

**[I have just published a new course — Design Microservices Architecture with Patterns & Principles.](https://www.udemy.com/course/design-microservices-architecture-with-patterns-principles/?couponCode=OCTOBER2021)**

In this course, we’re going to learn **how to Design Microservices Architecture** with using **Design Patterns, Principles** and the **Best Practices.** We will start with designing **Monolithic** to **Event-Driven Microservices** step by step and together using the right architecture design patterns and techniques.