# Repository Pattern with AutoMapper in .Net Core

Article Link: https://amrelsher07.medium.com/repository-pattern-with-automapper-in-net-core-213918e2e36b
Author: Amrelsher
Date Added: October 4, 2021 9:06 AM
Tag: Design-Patterns

First Base Entity

![https://miro.medium.com/max/1400/1*gPu-cy9IHktRviCkzIq_kw.png](https://miro.medium.com/max/1400/1*gPu-cy9IHktRviCkzIq_kw.png)

entity

![https://miro.medium.com/max/1400/1*LqHBDkHPDHEsV0lXKBg6Ig.png](https://miro.medium.com/max/1400/1*LqHBDkHPDHEsV0lXKBg6Ig.png)

second generic IRepository

![https://miro.medium.com/max/1400/1*TJM0XQZxszCHzRsfgijwBg.png](https://miro.medium.com/max/1400/1*TJM0XQZxszCHzRsfgijwBg.png)

implementation of IRepository

![https://miro.medium.com/max/1400/1*nITUQUSEqiDYaZ1BSoaexA.png](https://miro.medium.com/max/1400/1*nITUQUSEqiDYaZ1BSoaexA.png)

and inject IRepository in ConfigureServices

![https://miro.medium.com/max/1400/1*HhmdtPKMp2yiQtwrMzGMkg.png](https://miro.medium.com/max/1400/1*HhmdtPKMp2yiQtwrMzGMkg.png)

in-service layer

install AutoMapper

install AutoMapper.Extensions.ExpressionMapping

install AutoMapper.Extensions.Microsoft.DependencyInjection

install all this package from Nuget Package Manager

The first thing is to add base entity DTO

![https://miro.medium.com/max/1400/1*PXUqdisHa4259TytmGlwtw.png](https://miro.medium.com/max/1400/1*PXUqdisHa4259TytmGlwtw.png)

![https://miro.medium.com/max/1400/1*bSeooi1up-t9F1dmxMdN0w.png](https://miro.medium.com/max/1400/1*bSeooi1up-t9F1dmxMdN0w.png)

This interface will help us in AutoMapper.

GroupDto

![https://miro.medium.com/max/1400/1*CZmXNMl_IaUbQPjKgPnF0Q.png](https://miro.medium.com/max/1400/1*CZmXNMl_IaUbQPjKgPnF0Q.png)

IService Async

![https://miro.medium.com/max/1400/1*3l4RiZQNj-OtJ_C8jrkCBg.png](https://miro.medium.com/max/1400/1*3l4RiZQNj-OtJ_C8jrkCBg.png)

Implement IService

![https://miro.medium.com/max/1400/1*IRDb0cuUUZBNlQwEGzYmJA.png](https://miro.medium.com/max/1400/1*IRDb0cuUUZBNlQwEGzYmJA.png)

Third, you can make Services for each entity I will make IGroupService and

GroupService that will consume services and repository

![https://miro.medium.com/max/1400/1*pOh3PqfmsU47U6Hfv6156w.png](https://miro.medium.com/max/1400/1*pOh3PqfmsU47U6Hfv6156w.png)

and implement IGroupService

![https://miro.medium.com/max/1400/1*elL9IAfdGznTPEHXJHEGmQ.png](https://miro.medium.com/max/1400/1*elL9IAfdGznTPEHXJHEGmQ.png)

Inject services in ConfigureServcies Method

you can write some reflection code to get all services from the current assembly and inject it instead of add each time services

![https://miro.medium.com/max/1400/1*u5XoyfT2DdbkqNsA3seo4w.png](https://miro.medium.com/max/1400/1*u5XoyfT2DdbkqNsA3seo4w.png)

and add this line in ConfigureServices Method

![https://miro.medium.com/max/1400/1*0L72RrBPjuULOJKTgG6sQA.png](https://miro.medium.com/max/1400/1*0L72RrBPjuULOJKTgG6sQA.png)

don’t forget to add automapper configuration

First is Profile I write some reflection code to get all Dto and call the Mapping method this instead of writing all creatMap in profile so code is automatic.

![https://miro.medium.com/max/1400/1*aKzXLNi14vNEXIQ_WQBrxQ.png](https://miro.medium.com/max/1400/1*aKzXLNi14vNEXIQ_WQBrxQ.png)

and add call code in profile

![https://miro.medium.com/max/1400/1*fv2nSOaxpJjztMlxu3vJ-w.png](https://miro.medium.com/max/1400/1*fv2nSOaxpJjztMlxu3vJ-w.png)

AddExpressionMapping this method to map Expression<Func<>>

Add UniteOfWork

![https://miro.medium.com/max/1400/1*oCgVIclJTaF1Bt31o3K_vw.png](https://miro.medium.com/max/1400/1*oCgVIclJTaF1Bt31o3K_vw.png)

![https://miro.medium.com/max/1400/1*tVMftebKAVC3c9NohAEoDQ.png](https://miro.medium.com/max/1400/1*tVMftebKAVC3c9NohAEoDQ.png)

UI Layer

![https://miro.medium.com/max/1400/1*EvFH6xd5flWCA_uBOpeJwQ.png](https://miro.medium.com/max/1400/1*EvFH6xd5flWCA_uBOpeJwQ.png)

All code will find in [GitHub](https://github.com/AmrElshaer/BigRoom)