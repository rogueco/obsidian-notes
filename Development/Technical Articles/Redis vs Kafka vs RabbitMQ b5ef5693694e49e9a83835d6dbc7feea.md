# Redis vs Kafka vs RabbitMQ

Article Link: https://medium.com/@mertcanarguc/redis-vs-kafka-vs-rabbitmq-e935ebbc7ec
Author: Mertcan Arguç
Date Added: February 24, 2022 8:40 PM
Tag: Microservices

# **Redis vs Kafka vs RabbitMQ**

![https://miro.medium.com/max/1256/0*nlEE0yC6csVnKdha.jpg](https://miro.medium.com/max/1256/0*nlEE0yC6csVnKdha.jpg)

When using asynchronous communication for Microservices, it is common to use a message broker. A broker ensures communication between different microservices is reliable and stable, that the messages are managed and monitored within the system and that messages don’t get lost. There are a few message brokers you can choose from, varying in scale and data capabilities. This blog post will compare the three most popular brokers: RabbitMQ, Kafka and Redis.

# **Microservices Communication: Synchronous and Asynchronous**

There are two common ways Microservices communicate with each other: Synchronous and Asynchronous. In a Synchronous communication, the caller waits for a response before sending the next message, and it operates as a REST protocol on top of HTTP. On the contrary, in Asynchronous communication, the messages are sent without waiting for a response. This is suited for distributed systems and usually requires a message broker to manage the messages.

The type of communication you choose should consider different parameters, such as how you structure your Microservices, what infrastructure you have in place, latency, scale, dependencies and the purpose of the communication. Asynchronous communication may be more complicated to establish and requires adding more components to the stack, but the advantages of using Asynchronous communication for Microservices outweigh the cons.

# **Asynchronous Communication Advantages**

First and foremost, asynchronous communication is non-blocking by definition. It also supports better scaling than Synchronous operations. Third, in the event of Microservice crashes, Asynchronous communication mechanisms provide various recovery techniques and are generally better at handling errors pertaining to the crash. In addition, when using brokers instead of a REST protocol, the services receiving communication don’t really need to know each other. A new service can even be introduced after an old one has been running for a long time, i.e better decoupling services.

Finally, when choosing Asynchronous operations, you increase your capability of creating a central discovery, monitoring, load balancing, or even policy enforcer in the future. This will provide you with abilities for flexibility, scalability and more capabilities in your code and system building.

# **Choosing the Right Message Broker**

Asynchronous communication is usually managed through a message broker. There are other ways as well, such as aysncio, but they’re more scarce and limited.

When choosing a broker for executing your asynchronous operations, you should consider a few things:

1. Broker Scale — The number of messages sent per second in the system.
2. Data Persistency — The ability to recover messages.
3. Consumer Capability — Whether the broker is capable of managing one-to-one and/or one-to-many consumers.

**One-to-One**

![https://miro.medium.com/max/1400/0*8LLaj9CYvOgBNdTj.png](https://miro.medium.com/max/1400/0*8LLaj9CYvOgBNdTj.png)

**One-to-Many**

![https://miro.medium.com/max/1400/0*1FrAF7ZFP3vOFHUE.png](https://miro.medium.com/max/1400/0*1FrAF7ZFP3vOFHUE.png)

We checked the latest and greatest services out there in order to find out which provider is the strongest within these three categories.

# **Comparing Different Message Brokers**

# **RabbitMQ (AMQP)**

**Scale**: based on configuration and resources, the ballpark here is around 50K msg per second.

**Persistency**: both persistent and transient messages are supported.

**One-to-one** vs **one-to-many consumers**: both.RabbitMQ was released in 2007 and is one of the first common message brokers to be created. It’s an open-source that delivers messages through both point-to-point and pub-sub methods by implementing Advanced Message Queuing Protocols (AMQP). It’s designed to support complex routing logic.

There are some managed services that allow you to use it as a SaaS but it’s not part of the native major cloud provider stack. RabbitMQ supports all major languages, including Python, Java, .NET, PHP, Ruby, JavaScript, Go, Swift, and more.

Expect some performance issues when in persistent mode.

# **Kafka**

**Scale**: can send up to a million messages per second.

**Persistency**: yes.

**One-to-one** vs **one-to-many consumers**: only one-to-many (seems strange at first glance, right?!).

Kafka was created by Linkedin in 2011 to handle high throughput, low latency processing. As a distributed streaming platform, Kafka replicates a publish-subscribe service. It provides data persistency and stores streams of records that render it capable of exchanging quality messages.

Kafka has managed SaaS on Azure, AWS, and Confluent. They are all the creators and main contributors of the Kafka project. Kafka supports all major languages, including Python, Java, C/C++, Clojure, .NET, PHP, Ruby, JavaScript, Go, Swift and more.

# **Redis**

**Scale**: can send up to a million messages per second.

**Persistency**: basically, no — it’s an in-memory datastore.

**One-to-one** vs **one-to-many consumers**: both.

Redis is a bit different from the other message brokers. At its core, Redis is an in-memory data store that can be used as either a high-performance key-value store or as a message broker. Another difference is that Redis has no persistency but rather dumps its memory into a Disk/DB. It’s also perfect for real-time data processing.

Originally, Redis was not one-to-one and one-to-many. However, since Redis 5.0 introduced the pub-sub, capabilities boosted and one-to-many became a real option.

# **Message Brokers per Use Case**

We covered some characteristics of RabbitMQ, Kafka, and Redis. All three are beasts in their category, but as described, they operate quite differently. Here is our recommendation for the right message broker to use according to different use cases.

# **Short-lived Messages: Redis**

Redis’s in-memory database is an almost perfect fit for use-cases with short-lived messages where persistence isn’t required. Because it provides extremely fast service and in-memory capabilities, Redis is the perfect candidate for short retention messages where persistence isn’t so important and you can tolerate some loss. With the release of Redis streams in 5.0, it’s also a candidate for one-to-many use cases, which was definitely needed due to limitations and old pub-sub capabilities.

# **Large Amounts of Data: Kafka**

Kafka is a high throughput distributed queue that’s built for storing a large amount of data for long periods of time. Kafka is ideal for one to many use cases where persistency is required.

# **Complex Routing: RabbitMQ**

RabbitMQ is an older, yet mature broker with a lot of features and capabilities that support complex routing. It will even support complex routing communication when the required rate is not high (more than a few tens of thousands msg/sec).

# **Consider Your Software Stack**

The final consideration, of course, is your current software stack. If you’re looking for a relatively easy integration process and you don’t want to maintain different brokers in a stack, you might be more inclined to work with a broker that is already supported by your stack.

For example, if you’re using Celery for Task Queue in your system on top of RabbitMQ, you’ll have an incentive to work with RabbitMQ or Redis as opposed to Kafka who is not supported and would require some rewriting.

We at Otonomo have used all the above through our platform evolution and growth and then some! It’s important to remember that each tool has its own pro & cons and it’s about understanding them and choosing the right tool for the job and that specific moment, situation and requirements.

*Buy me a coffee [https://www.buymeacoffee.com/argucmertcan](https://www.buymeacoffee.com/argucmertcan) 🧋*