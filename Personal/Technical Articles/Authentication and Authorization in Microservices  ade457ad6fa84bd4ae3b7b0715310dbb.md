# Authentication and Authorization in Microservices: How to Implement It?

Article Link: https://medium.com/swlh/authentication-and-authorization-in-microservices-how-to-implement-it-5d01ed683d6f
Author: Mattias te Wierik
Date Added: July 1, 2022 11:32 PM
Tag: Authentication, Authorization, Microservices, Microservices Pattern

## Why authentication deserves a centralized place in your architecture

![https://miro.medium.com/max/700/1*vV8i8u9H8zz8X6cCHgKwaw.png](https://miro.medium.com/max/700/1*vV8i8u9H8zz8X6cCHgKwaw.png)

When moving to microservices, you will come to the conclusion that securing the microservices needs to be tackled in a different way compared to a monolithic application.

While designing the solution, questions like “*Where and how do I implement authentication and authorization?*” and “*How do I authorize users to specific actions?*” can popup. In this article, a solution will be introduced to these questions.

First, the differences between authentication and authorization will be explained. Secondly, OpenID Connect and OAuth2 will be introduced as solutions for centralized authentication and authorization for microservice architectures. Lastly, there will be two implementation choices explained for authorization.

# **What are the differences between authentication and authorization?**

When talking about securing applications, the terms authentication and authorization will pop up. While the terms are used interchangeably, they represent different purposes in the spectrum of securing applications.

When talking about **authentication**, it is the process of verifying the identity of the entity he/she/it claims to be. When talking about **authorization**, it is the process of verifying if the entity is authorized to access specific information or is allowed to execute certain actions.

In regards to the total security flow, both principles fit in and the combination could still make a request fail. In the rule, authentication comes first, authorization second. When a user is authenticated but not authorized, the request will still fail.

# **OpenID Connect and OAuth**

In a distributed system architecture like microservices, implementing authentication and authorization on the traditional way are not possible. With the monolithic architecture approach, often signing sessions are stored in-memory or a distributed session storage to share sessions between instances of the monolithic application.

In-Memory storage of different applications can not be shared since microservices are separate isolated applications. Centralizing and sharing the distributed session storage is as well discouraged. This creates tight coupling between the microservices and opens the door to leak logic between microservices.

With keeping the microservice architecture in mind, each microservice should be solely responsible for its single piece of business logic, whether that is a small piece of logic or a bounded context. Authentication is in this case a cross-cutting concern and shouldn’t be part of the microservice itself.

A widely used solution for this problem is to implement a separate identity server. This service is responsible hosting centralized authentication and authorization. There are several solutions for this, like [WSO2 Identity Server](https://github.com/wso2/product-is/tree/master) (Java), [IdentityServer4](https://github.com/IdentityServer/IdentityServer4) (.NET) and [OAuth2orize](https://github.com/jaredhanson/oauth2orize) (Node.js). All of these frameworks support authentication and authorization by using OpenID Connect and OAuth2.

## **What is OpenID Connect?**

[OpenID Connect](https://openid.net/connect/) is an **authentication protocol** that is a simple identity layer on top of OAuth2. It allows clients to identify clients to verify the identity of a user by an external authorization server like Google, Facebook or a embedded login system in the identity server.

How would the flow look like? A user requests access to an application. The application determines that the user is not authenticated yet and redirects the user to the identity server. The user authenticates with the identity server. The identity server sends on successful authentication an access token/ID token to the user. This token is signed by cryptographic keys. The user can authenticate with this token at the application. The application validates the signed key by checking if it is signed by the identity server by checking the public cryptographic key. If this is the case, the user is successfully authenticated!

For the token, [JSON Web Token (JWT)](https://jwt.io/) is used. A JWT consists of a header, payload, and signature. The header contains the algorithm used to sign the token. A payload is essentially a JSON object where additional properties about the user can be added. Since the token is signed by the identity server, the information can be trusted by the consuming application. The application can validate the token against the public key of the certificate used by the identity server for signing the token.

![https://miro.medium.com/max/700/1*dLjfZP9O5v9wma4WIcO2Pw@2x.jpeg](https://miro.medium.com/max/700/1*dLjfZP9O5v9wma4WIcO2Pw@2x.jpeg)

High-level flow between user, application and identity server

## **What is OAuth2?**

During the explanation of OpenID Connect, the term OAuth2 already fell. [OAuth2](https://oauth.net/2/) is an industry-standard **authorization protocol**. It offers specific authorization flows (described as grants inside the specification) for web applications, desktop applications, mobile phones and living room devices.

The flow described in the OpenID Connect explanation makes actually use of one of the supported grant types, the [Authorization Code grant type](https://developer.okta.com/blog/2018/04/10/oauth-authorization-code-grant-type) to be exact.

With this flow, the user is redirected to the Identity Server where authentication and authorization are handled. The client (the application that requests the user information) gets authorization by the user to the needed information. This is done by configuring the right scopes. Scopes resemble the type of data that a specific client has access to. Examples of scopes are email and address, which resemble respectively the user’s email address and address.

The scopes are requested by the application during the authentication process. When the user authenticates himself on the identity server, the user as well gets the possibility to give the application authorization for the requested data. When given authorization, the data will be added to the payload of the token and passed to the application.

In the identity server, there is the possibility to persist the roles that are connected to the user. An identity server could be set up for all employees in a company. These employees have different roles depending on their role in the company. The identity server could share the assigned roles to a specific user in the token. In this way, this can be shared with consuming applications.

# **Where should application-specific authorization logic be built in?**

The choice to build authentication in a separate centralized responsible service has been advocated in the previous section. This becomes harder for application-specific authorization logic. In a microservice architecture, the services itself should not be exposed directly to the consuming application. Managing connections to all your microservices becomes unmanageable.

Implementing an [API gateway](https://microservices.io/patterns/apigateway.html) creates a single entry point for consumers to communicate with. The API gateway routes the requests to the upstream microservices.

![https://miro.medium.com/max/700/1*25GtM7zEsuP8uYSNH-wQ-A@2x.jpeg](https://miro.medium.com/max/700/1*25GtM7zEsuP8uYSNH-wQ-A@2x.jpeg)

API gateway in relation to other components

When multiple consumers are in play, creating specific API gateways could be a solution to create separate specific endpoints for each consumer. This variation is called the Backends for Frontends pattern. This way only the endpoints are specifically implemented for each consumer. The drawback of this is that it adds another separate service per consumer that needs to be maintained.

## **Handling application-specific authorization in the gateway**

One solution to handle application-specific authorization is by implementing this in the API gateway. Restricting requests to specific endpoints become in this way possible. The drawback of implementing authorization in the API gateway is that it can be only role-based access to endpoints. Implementing additional checks on access to specific domain objects would need to create specific domain logic inside the API gateway and therefore will create leakage of domain logic. Furthermore when introducing multiple backends for frontends/API gateways, managing the authorization becomes harder and harder.

## **Handling application-specific authorization in the microservices**

A better solution would be to make the microservices responsible for handling authorization. The API gateway should pass the JWT along with the request towards the microservice. As explained before, the JWT will contain the roles assigned to the user. Since the API gateway is still responsible for authentication, validating the token has already been done when the microservice receives the request. With the assigned roles to the user executing the request, the microservice can now determine whether the user is authorized for the desired request. In this way, the application-specific only needs to be implemented in one place. A drawback of this is that authorization will be more scattered around in multiple services. When having a lot of roles that change very often, this becomes more tedious to manage.

# **Conclusion**

When implementing authentication and authorization into microservices, the process becomes much more complex than in a traditional monolithic architecture.

While authentication and authorization are both terms used in the spectrum of securing an application, they don’t cover the same thing. Authentication is about verifying the identity of an entity it claims to be. Authorization is the process about determining whether the entity is allowed to do a specific action or access specific data.

Authentication and authorization to applications inside a microservice architecture are usually implemented in a centralized service that is responsible for this. There are several solutions for this, like WSO2 Identity Server (Java), IdentityServer4 (.NET) and OAuth2orize (Node.js). These services support OAuth2 and OpenID Connect, which are underlying, industry-standard protocols for authorization and authentication.

Implementing authentication checks should terminate inside the API gateway. Implementing authorization can be done either in the API gateway or in the microservices. To be able to do extensive application-specific authorization checks, authorization should be handled in the specific microservices. This can be done by passing along the JWT with the request. In this way, application-specific authorization for domain objects won’t be leaked to the API gateway.