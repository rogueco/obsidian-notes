# Scaling a Monolith — Vertical Scaling & Horizontal Scaling simply defined

Article Link: https://colin-but.medium.com/scaling-a-monolith-vertical-scaling-horizontal-scaling-simply-defined-4337c8a07326
Date Added: March 18, 2021 10:42 AM
Tag: DevOps

![https://miro.medium.com/max/993/1*iCi0aorKWbI6fEy2LEz8kw.png](https://miro.medium.com/max/993/1*iCi0aorKWbI6fEy2LEz8kw.png)

When developing a traditional large enterprise application as a single codebase (a monolith) typically involves 2 types when it comes to scaling.

# **Vertical Scaling**

A.K.A Scaling Up

**Vertical Scaling** is simply as adding more server resources to your existing server. For example, adding more disk space, adding more RAM, adding additional CPU even.

![https://miro.medium.com/max/619/1*kzBKXvnoQZx_Pn-pk5XyCw.jpeg](https://miro.medium.com/max/619/1*kzBKXvnoQZx_Pn-pk5XyCw.jpeg)

This scaling technique is no longer that popular anymore simply because there is a limit to the amount of resources you can add to a server in terms of efficiency.

This is also commonly refer to scaling on the ‘Y’ axis.

# **Horizontal Scaling**

A.K.A Scaling Out

**Horizontal Scaling** is more common these days. So rather than adding more resources to a server, you add extra server(s) instead.

![https://miro.medium.com/max/960/1*AOeSRmy_herYSAgdRqimQQ.png](https://miro.medium.com/max/960/1*AOeSRmy_herYSAgdRqimQQ.png)

Say, your application runs on one server and that it no longer sustain the amount of load it requires, you add the extra server or servers you need to be able to handle the require amount of throughput for your application.

This is what is referred to as Horizontal Scaling. You scale your application in a horizontal way.

This is also commonly refer to scaling on the ‘X’ axis.

This is possible for both stateful and stateless applications. It is just that for stateful apps it is much harder but can be achieved using **sticky sessions** (yuck) ****to ensure the load balancer always picks/routes user/client request to the same server machine because the app requires state.