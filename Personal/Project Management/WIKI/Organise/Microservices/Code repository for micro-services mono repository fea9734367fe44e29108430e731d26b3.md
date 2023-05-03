# Code repository for micro-services: mono repository or multiple repositories

Created: June 8, 2021 8:39 PM

In this post we are going to discuss about the two different style of maintaining code repository(s) while moving towards micro service architecture.

1. **Mono Repository**
2. **Multiple Repositories**

**So what is Microservice architecture?**

Microservices — also known as the microservice architecture — is an architectural style that structures an application as a collection of loosely coupled services, which implement business capabilities. The microservice architecture enables the continuous delivery/deployment of large, complex applications. It also enables an organization to evolve its technology stack.

For those who are relatively new to microservices, here are few good reads:

****[What are microservices?Microservices - also known as the microservice architecture - is an architectural style that structures an application…**
microservices.io](http://microservices.io/)

****[What is Microservices Architecture?While there is no standard, formal definition of microservices, there are certain characteristics that help us identify…**
smartbear.com](https://smartbear.com/learn/api-design/what-are-microservices/)

First of all let me give you an overview of what we were trying to achieve:

- We are working on an demo ECommerce application using microservice architecture.
- We used technologies like .NET core webapi and node js api for our microservices.
- We created DevOps pipeline for those services independently.

In order to achieve these one of the most important requirement was repository(s) for our code. In my case since I was using **VSTS** (Visual studio team service), I had the option of selecting between **git** and **TFVC**.

```
Note:To know more about git and TFVC in VSTS please visithere.
```

But the main problem was whether to keep all the services in the same repository in separate folders (**Mono repository**) or to keep separate repositories for each of the services (**Multiple repositories**).

Both had their pros and cons. But at first I went for the 2nd option i.e separate repository for each service but I will show you the Mono repository setup as well which is actually a good choice for the development environment. So what made me go in that direction?

One of the main reason behind micro-service architecture was to release software faster, and to create small teams to develop and deliver a single service. i.e managing the whole life cycle of the micro service was a team’s responsibility from development to delivery and maintenance. Thus creating separate repository for different service made sense because a team can then concentrate on a particular repository and we can maintain separate development and release for them. But things are not that simple in a real life business scenario right?

**Multiple Repository setup:**

![https://miro.medium.com/max/36/1*Gl30-QCc1RVkVYjf-F6SHA.png?q=20](https://miro.medium.com/max/36/1*Gl30-QCc1RVkVYjf-F6SHA.png?q=20)

![https://miro.medium.com/max/347/1*Gl30-QCc1RVkVYjf-F6SHA.png](https://miro.medium.com/max/347/1*Gl30-QCc1RVkVYjf-F6SHA.png)

multi repo

So in the above image we can see a multiple repository setup where we have maintained different microservices in different git repositories.

Using multiple repository setup help in several ways:

- **Clear ownership:** Having separate repository for a particular service is a definite microservice way of doing things because the team that owns that service is clearly responsible for independently develop and deploy the full stack of that microservice.
- **Smaller code base:** Separate repositories for a service leads to smaller code base and lesser complexity during code merge.
- **Narrow clones:** While doing DevOps and automated build and releases, smaller code base leads to considerably lesser code download/clone time, that leads to faster build and deployments.

This setup is ideal and works very well unless the number of microservices starts increasing considerably. The cons for this setup are:

- **Difficult development and debugging:** Multiple repositories setup surely causes difficulties while development, cross team communication and shared code are difficult to maintain and thus development and debugging becomes an issue initially.
- **Abstracts the knowledge of the platform:** Since each team is only responsible for a single service, integration becomes an issue and people with knowledge of the platform as a whole decreases considerably.
- **Sharing of common code:** Sharing of common code is bit tricky here. But since we were using .NET core webapi for most of our microservices, we used the native support of .NET core with nuget package manager. Thus using nuget packages for our common code, not only helped us to share our common code across teams but also helped us to maintain different version of the same package.

```
Note: If I get time I will surely write a blog on the steps to share your common code across teams using nuget package manager.
```

**Mono Repository setup:**

![https://miro.medium.com/max/60/1*8_j48kSbGewVrJAR-sgncQ.png?q=20](https://miro.medium.com/max/60/1*8_j48kSbGewVrJAR-sgncQ.png?q=20)

![https://miro.medium.com/max/1283/1*8_j48kSbGewVrJAR-sgncQ.png](https://miro.medium.com/max/1283/1*8_j48kSbGewVrJAR-sgncQ.png)

mono repo

Here we see a single repository setup. In my case I have used TFVC for a single repository setup, you can use git as well.

The reason why I selected TFVC in mono repository setup is to be able to clone/download source from particular folder.

This setup has few advantages lets discuss them first:

- **Better development and debugging:** Surely its evident that this setup will be best suitable for a developer because it running the whole platform and debugging complex cases will be much easy. Thus development time decreases.
- **Easy sharing of common code:** While sharing of common code was a bit of a problem in the multiple repository setup here its quite easy.
- **Easy refactoring and reviews:** Since code is in the same place, refactoring just got easier. Not only that code review process will also be more effective.

Now lets discuss few of the disadvantages:

- **Larger code base:** The problem that I faced in this approach is when we come to the size of the code base. Larger code base leads to higher maintenance cost and issues related to code merge.
- **Greater clone time:** Moreover in order to keep the build scripts simple cloning the whole repository from the root folder will lead to larger download time and subsequently time for build + release will increase considerably.

```
Note: Some popular repositories like git does not allow cloning part of the repository. Thus I think if you use TFVC for the mono repository style it will be able to solve that problem.
```

I hope this post will help you to make a better decision before choosing what kind of repository you would want for your microservices.

Moreover the best efficiency that I could think of is if we could some how take the best from both worlds. Like if we could use our mono repository setup for development, and our multiple repository setup for build + release. For this we will need some kind of mechanism to sync our repositories in a continuous basis i.e on every check in/ push, which I think is quite possible.

If you think this can work and be more effective than using any of the two, or if you have any other idea for setting up repository(s) for microservices do let me know in the comment section below.

If you like this post please share/recommend this to your friends and colleagues.