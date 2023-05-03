# Why is loose coupling between services so important?

Article Link: https://www.ben-morris.com/why-is-loose-coupling-between-services-so-important/
Date Added: May 7, 2021 9:53 AM
Tag: Coding Standards, Microservices

14 April 2019

*Loose coupling implies that services are independent so that changes in one service will not affect any other. The more dependencies you have between services, the more likely it is that changes will have wider, unpredictable consequences.*

You cannot *completely* isolate services. Any collaboration between services inevitably gives rise to *some* level of mutual dependency. Services will need some common characteristics in terms of protocols, behaviour or language. This inevitably gives rise to a degree of dependency, though this coupling can come in many different forms.

## **What causes coupling between services?**

It’s important to recognise where coupling comes from so you are in a better place to manage dependencies and mitigate any negative effects they may have.

**Behavioural coupling** occurs when services share responsibilities for business processes. For example, you may have multiple services that need to be involved in producing an invoice. If a service needs the direct support of another to fulfil its responsibilities the implication is that service boundaries have not been drawn correctly.

This is the most common form of coupling and it can be dealt with by redrawing boundaries between services to eliminate “chatty” relationships. The style of integration can also be relevant, as event-based interactions via messaging tend to encourage more loosely-coupled communication than direct commands or RPC-style interactions.

**Knowledge coupling** is a similar idea and it implies that services are too familiar with each other’s internal implementations. The sender of a request knows something about how the receiver will respond to the message. This may even go so far as providing instructions. It’s this *expectation* that creates coupling as services become dependent on the internal mechanics of external services.

**Schema coupling** describes services that are bound to a common set of interfaces or schemas. Services should be able to make changes to their *internal* data without breaking anything. Making changes to external data interfaces is a little trickier, as it will have an impact on collaborating services.

There are techniques that can help to mitigate this coupling. Clients should seek to act as *tolerant readers* where they only consume those parts of an API contract that they *really need*. This reduces their vulnerability to breaking changes in APIs.

**Temporal, or time-based coupling** occurs when a service expects an immediate response from another before it can continue processing. This is particularly prevalent in systems that use a lot of request\response style interactions, e.g. microservices based on REST or gRPC. You can address this by reconsidering service boundaries, so they don’t need to wait on external services. Alternatively, if you have bet the farm on smaller services then you will need a very strong story around failure, so services can cope with the inevitable timeouts and transient errors.

In re-drawing service boundaries, there can be a trade-off between different types of coupling.  **Process coupling** happens when services start to take on too many distinct responsibilities. This gives rise to bloated service implementations that become difficult to scale or change. The more extreme form of this is found in CRM or ERP platforms such as Salesforce or SAP that tend to become “monster” platforms carrying our multiple responsibilities in your architecture.

**Implementation coupling** describes services that share implementation detail as opposed to contracts or schemas. A good example here is where one service uses the client library of another to communicate with it. This binds services to a specific language or framework if they want to collaborate. APIs that leak implementation detail in terms of platform-specific constructs can also cause implementation coupling as any collaborating service will need to implement the underlying technology.

Finally, there is **location-based coupling**, where a service expects a resource to exist in specific location. This is normally addressed by some form of broker or service locator that maps a series of logical destinations to their physical locations.

## **Why do we need loose coupling?**

Loose coupling is often associated with stable development, though it tends to have a wider impact over time.

### **Performance, scalability and elasticity**

In a tightly coupled system, your performance is largely dictated by your slowest component. For example, microservice architectures with services that collaborate via HTTP-based APIs can be vulnerable to cascading performance problems where one component slows down. If your services are decoupled, you will have more freedom to optimise them individually for specific workloads.

Your ability to scale is also determined by your least elastic component. A shared database is often the cause of elasticity limitations either because they are difficult or expensive to scale in response to changing demand.

### **Productivity and automation**

Loose coupling is generally associated with easier deployment. In their [excellent] book “[Accelerate](https://www.amazon.co.uk/Accelerate-Software-Performing-Technology-Organizations/dp/1942788339)”, Nicole Forsgren et. al. looked at the associations between high performing teams and specific engineering practices. They found that loose coupling tends to be associated with better productivity in terms of the frequency and stability of deployments. They also found that loose coupling made it possible to grow teams without reducing this productivity.

Why should this be so? Loose coupling enables *isolation*. Components to be deployed independently of one another, giving you much more freedom over when and what you deploy. Cross-functional delivery teams are able get their work done without having to manage any dependencies on other teams. Testing is easier to organise as components can be validated independently of each other.

### **Flexibility and cost of change**

Coupling also affects your ability to make changes safely. The more coupling you have in a system the more likely it is that change will have unexpected effects. Limiting any dependencies means there’s less complexity to deal with so changes are easier and safer to make. This is another side effect of isolation that serves to lower the cost of change.

## **How do I know if my services are loosely coupled?**

Although you can’t eliminate coupling, you can ensure that it does not prevent you from enjoying the main benefits associated with autonomous services. Some coupling is perfectly fine so long as it does not undermine the desired outcome. There are several litmus tests that determine whether this is the case, i.e.

- Can you deploy a service independently regardless of any other service?
- Can you test and verify your services without using an integrated environment?
- Can you make large scale changes to the internals of a service without referencing any other service?
- If a service stops will it prevent any other services from running?

If your services fail any one of these tests, then your coupling is becoming a problem.

Filed under [Architecture](https://www.ben-morris.com/category/architecture), [Microservices](https://www.ben-morris.com/category/microservices) and [SOA](https://www.ben-morris.com/category/soa).

## Related

### [When should you write your own message endpoint library?](https://www.ben-morris.com/when-should-you-write-your-own-message-endpoint-library/)

### [Messaging anti-patterns in event-driven architecture](https://www.ben-morris.com/event-driven-architecture-and-message-design-anti-patterns-and-pitfalls/)

### [Events, sagas and workflows: managing long-running processes between services](https://www.ben-morris.com/events-sagas-and-workflows-managing-long-running-processes-between-services/)

## Recent

### [Why the developer experience matters to architecture](https://www.ben-morris.com/why-the-developer-experience-matters-to-architecture/)

### [Setting an appetite instead of making an estimate for epic-level work](https://www.ben-morris.com/setting-an-appetite-instead-of-making-an-estimate-for-epic-level-work/)

### [Data Vault 2.0: the good, the bad and the downright confusing](https://www.ben-morris.com/data-vault-2-modelling-the-good-the-bad-and-the-downright-confusing/)

**About me**
I am a London-based technical architect who has spent more than twenty five years leading development across start-ups, digital agencies, software houses and corporates. Over the years I have built a lot of stuff including web sites and services, systems integrations, data platforms and middleware. My current focus is on providing architectural leadership in agile environments.
I currently work as Chief Architect for the global market intelligence agency **[Mintel](https://www.mintel.com/)**. Opinions are my own and not the views of my employer, etc.
You can **[follow me](http://www.twitter.com/benmorrisuk/)** on Twitter or **[check me out](http://uk.linkedin.com/in/benmorrisuk)** on LinkedIn.**Categories**
• **[.Net Core](https://www.ben-morris.com/category/.net-core/)** (10)
• **[Agile](https://www.ben-morris.com/category/agile/)** (25)
• **[API Design](https://www.ben-morris.com/category/api-design/)** (16)
• **[Architecture](https://www.ben-morris.com/category/architecture/)** (73)
• **[ASP.NET](https://www.ben-morris.com/category/asp.net/)** (4)
• **[Azure](https://www.ben-morris.com/category/azure/)** (11)
• **[CMS](https://www.ben-morris.com/category/cms/)** (1)
• **[Design patterns](https://www.ben-morris.com/category/design-patterns/)** (37)
• **[Development process](https://www.ben-morris.com/category/development-process/)** (36)
• **[Docker](https://www.ben-morris.com/category/docker/)** (5)
• **[Domain Driven Design](https://www.ben-morris.com/category/domain-driven-design/)** (6)
• **[Favourite posts](https://www.ben-morris.com/category/favourite-posts/)** (22)
• **[Integration](https://www.ben-morris.com/category/integration/)** (24)
• **[Messaging](https://www.ben-morris.com/category/messaging/)** (14)
• **[Microservices](https://www.ben-morris.com/category/microservices/)** (35)
• **[Net Framework](https://www.ben-morris.com/category/net-framework/)** (10)
• **[Rants](https://www.ben-morris.com/category/rants/)** (30)
• **[REST](https://www.ben-morris.com/category/rest/)** (15)
• **[Serverless](https://www.ben-morris.com/category/serverless/)** (6)
• **[SOA](https://www.ben-morris.com/category/soa/)** (35)
• **[SQL Server](https://www.ben-morris.com/category/sql-server/)** (5)
• **[Strategy](https://www.ben-morris.com/category/strategy/)** (27)
• **[UI Development](https://www.ben-morris.com/category/ui-development/)** (1)
• **[Web services](https://www.ben-morris.com/category/web-services/)** (14)
This site also contains a list of all published **[articles](https://www.ben-morris.com/posts/)** and an **[archive](https://www.ben-morris.com/archive/)** of older stuff.
© 2021 Ben Morris.