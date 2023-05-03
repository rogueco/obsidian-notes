These are a few of the architecture references that we were talking about the other day. All of these are variations of of the original concept introduced by Robert C.Martin [Link to article](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html). All layers point inwards.

The design is very similar to Onion Architecture.


![[CleanArchitecture.jpg]]


#### Jason Taylor
[Clean Architecture - Git Repo](https://github.com/jasontaylordev/CleanArchitecture)

[Conference Talk -  Youtube](https://www.youtube.com/watch?v=dK4Yb6-LxAk)

Jason has used the Medatior pattern, via the use of [MediatR by Jimmy Bogard](https://github.com/jbogard/MediatR) 
The web UI would be swapped out for an API layer.

_API -> Application -> Infrastructure -> Domain_


#### Steve smith
Pluralsight author, Podcast & also runs betterdev.com

[Clean Architecture - Git Repo](https://github.com/microsoft/dotnet-podcasts)
[Conference Talk - Long Version](https://www.youtube.com/watch?v=joNTQy-KXiU)
[Conference Talk - Short Version](https://www.youtube.com/watch?v=lkmvnjypENw)

Steve is very opiniated with his design & pushes alot of his own preferences in here.


#### Other Pretty cool repos
[Microsoft Microservices Clean Architecture](https://github.com/dotnet-architecture/eShopOnContainers)
- _Mono-repo_ with the API as _Services_
- Loads of different technologies
	- EF Core
	- Dapper
	- [MediatR](https://github.com/jbogard/MediatR)
	- Docker
	- GRPC (Bloody awful to implement, but bloody fast)

I think they've also got Ocelot API Gateway & RabbitMQ

#### My personal repo
My personal repo is based off an amalgamation of pretty much the above repos - combined with my experiences of working at my first company _Barbon_ and where I've just come from _Sytner_. It's needs tidying up a little bit, but I'll get it tidied up & I can share it on Monday (your Tuesday).

The only other thing that I use in my which isn't in the above is [Azure Client Generator](https://github.com/Azure/autorest) 
