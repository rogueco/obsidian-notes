# Software Architecture Patterns: 5 minute read

Article Link: https://orkhanscience.medium.com/software-architecture-patterns-5-mins-read-e9e3c8eb47d2
Author: Orkhan Huseynli
Date Added: October 27, 2021 9:39 AM
Tag: Architecture, Coding Standards, Design-Patterns

When someones dives into the world of Software Engineering, one day he will need to learn the basics of **Software Architecture Patterns**. When I was new to coding, I didn’t know where to get a resource for a brief introduction to the existing architecture patterns so that it would not be too detailed & confusing but rather very abstract and simple to understand.

It had been a problem until I found a book **[Software Architecture Patterns**](https://www.goodreads.com/en/book/show/25091671-software-architecture-patterns) by *[Mark Richards](https://www.developertoarchitect.com/mark-richards.html)*. Here I want to share with you some of the most important parts of the book and architecture patterns. (For more information I strongly advise you to read the book or [his report](https://www.oreilly.com/content/software-architecture-patterns/)).

**Why should you learn at least the basic Architecture Patterns as Software Engineer?**

I believe there are many articles answering to this question, but I will give you a few reasons to consider. First of all, if you know the basics of architecture patterns, then it is easier for you to follow the requirements of your architect. Secondly, knowing those patterns will help you to make decisions in your code: for example, if your application design is based on event-driven microservices, as a software engineer you must decouple your code into a separate service should you notice the increasing complexity and responsibility of logic in the existing service. (If you didn’t get this part, just follow the text, where this pattern is briefly explained).

There are 5 patterns described in the book by Mark Richards:

- **Layered architecture**
- **Event-driven architecture**
- **Microkernel architecture** (or **Plugin architecture**)
- **Microservices architecture**
- **Space-based architecture** (or **Cloud architecture pattern**)

# **1. Layered architecture**

It is the most common architecture for monolithic applications. The basic idea behind the pattern is to divide the app logic into several layers each encapsulating specific role. For example, the **Persistence layer** would be responsible for the communication of your app with the database engine.

![https://miro.medium.com/max/700/0*A7O_q3LjFeMoyZUJ.png](https://miro.medium.com/max/700/0*A7O_q3LjFeMoyZUJ.png)

*Figure 1. Layered architecture pattern ([link](https://www.oreilly.com/content/software-architecture-patterns/) to the original source of the picture)*

# **2. Event-driven architecture**

The idea behind this pattern is to decouple the application logic into **single-purpose event processing components that asynchronously receive and process events.** This pattern is one of the popular distributed asynchronous architecture patterns known for high scalability and adaptability.

![https://miro.medium.com/max/700/0*S5x3if-_wD4nyeIB.png](https://miro.medium.com/max/700/0*S5x3if-_wD4nyeIB.png)

*Figure 2. Event-driven architecture broker topology ([link](https://www.oreilly.com/content/software-architecture-patterns/) to the original source of the picture)*

# **3. Microkernel Architecture**

Mikrokernel Architecture, also known as Plugin architecture, is the design pattern with two main components: **a core system** and **plug-in modules** (or extensions). A great example would be a **Web browser** (core system) where you can install endless extensions (or **plugins**).

![https://miro.medium.com/max/700/0*gtpsajLc78449AwB.png](https://miro.medium.com/max/700/0*gtpsajLc78449AwB.png)

*Figure 3. Mikrokernel architecture ([link](https://www.oreilly.com/content/software-architecture-patterns/) to the original source of the picture)*

# **4. Microservices Architecture**

Microservices architecture consists of **separately deployed services, where each service would have ideally single responsibility.** Those services are independent of each other and if one service fails others will not stop running.

![https://miro.medium.com/max/700/0*ZTArqwaUeQyjrvfn.png](https://miro.medium.com/max/700/0*ZTArqwaUeQyjrvfn.png)

*Figure 4. Microservices architecture ([link](https://www.oreilly.com/content/software-architecture-patterns/) to the original source of the picture)*

# **5. Space-Based Architecture**

The main idea behind the space-based pattern is the **distributed shared memory to mitigate issues that frequently occur at the database level. The assumption is that by processing most of operations using in-memory data we can avoid extra operations in the database, thus any future problems that may evolve from there (for example, if your user activity data entity has changed, you don’t need to change a bunch of code persisting to & retrieving that data from the DB).**

The basic approach is to separate the application into **processing units** (that can automatically scale up and down based on demand), where the data will be replicated and processed between those units without any persistence to the central database (though there will be local storages for the occasion of system failures).

![https://miro.medium.com/max/700/0*Q0VJyMBJX5OHpE_k.png](https://miro.medium.com/max/700/0*Q0VJyMBJX5OHpE_k.png)

*Figure 5.* Space-Based *architecture ([link](https://www.oreilly.com/content/software-architecture-patterns/) to the original source of the picture)*

*The simplest examples to some of those architecture patterns you can find in my GitHub account. Here the links:*

1. [Layered pattern](https://github.com/OrkhanHuseynli/recording-job) (in Java)
2. [Mikrokernel or Plugin pattern](https://github.com/OrkhanHuseynli/plugins_design_in_go) (in Go or Golang)
3. [Microservices pattern](https://github.com/OrkhanHuseynli/microservices_template_golang) (in Go)

If you want quickly get into the basics of how applications are scaled, then read my next story **[How to Scale Your Applications: 5 min read](https://enlear.academy/how-to-scale-your-web-and-mobile-applications-5be74bf99226).**Also, if you are interested in more advanced topics:**[Remote Procedure Call chains: 5 min read](https://orkhanscience.medium.com/rpc-chains-5-min-read-2b5c0f3886ba)**