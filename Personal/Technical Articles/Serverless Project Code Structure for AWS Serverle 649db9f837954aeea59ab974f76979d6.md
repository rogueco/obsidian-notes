# Serverless Project Code Structure for AWS Serverless E-Commerce Architecture

Article Link: https://medium.com/aws-serverless-microservices-with-patterns-best/serverless-project-code-structure-for-aws-serverless-e-commerce-architecture-e5015a0d6778
Author: Mehmet Özkaya
Date Added: April 19, 2022 10:42 AM
Tag: .NET, AWS, Architecture, Lambda, Microservices, Serverless

# **Serverless Project Code Structure for AWS Serverless E-Commerce Architecture**

In this article, we are going to see **Project Code Structure** for AWS **Serverless E-Commerce Microservices** Architecture. I will give introduction and an overview information about code structure.

![https://miro.medium.com/max/1400/1*WK_-gPDoCp29u8_MfStF7g.png](https://miro.medium.com/max/1400/1*WK_-gPDoCp29u8_MfStF7g.png)

We will be following the **Reference Architecture** above which is a **Real-world** **serverless e-commerce application** and it includes;

- **REST API** and **CRUD** endpoints with using **AWS Lambda, API Gateway**
- **Data persistence** with using **AWS DynamoDB**
- **Decouple microservices** with **events** using **AWS EventBridge**
- **Message Queues** for cross-service communication using **AWS SQS**
- **Cloud stack development** with **IaC** using **AWS CloudFormation CDK.**

Before we start to see our Project Code Structure, I would like to explain **Monorepo** that we follow **Monorepo** approaches in our project.

# **Step by Step Design AWS Architectures w/ Course**

![https://miro.medium.com/max/1400/0*0kKIzzJfY5E9eQOE.png](https://miro.medium.com/max/1400/0*0kKIzzJfY5E9eQOE.png)

**[I have just published a new course — AWS Serverless Microservices with Patterns & Best Practices.](https://www.udemy.com/course/aws-serverless-microservices-lambda-eventbridge-sqs-apigateway/?couponCode=APRIL22)**

In this course, we’re going to learn **how to Design and Develop AWS Serverless Event-driven Microservices** with using **AWS Lambda**, **AWS DynamoDB**, **AWS API Gateway**, **AWS EventBridge**, **AWS SQS**, **AWS CDK** for **IaC** — **Infrastructure as Code** tool and **AWS CloudWatch** for **monitoring**.

# **Source Code**

**[Get the Source Code from Serverless Microservices GitHub](https://github.com/awsrun/aws-microservices)** — Clone or fork this repository, if you like don’t forget the star. If you find or ask anything you can directly open issue on repository.

# **What is Monorepo?**

**Monorepo** is a software development strategy where many project codes are **stored** in the **same repository.** **Single repository** that stores all of your **code** and **assets** for every project.

![https://miro.medium.com/max/1400/1*L5UcH8ObqxyLLojMTGQ-rg.png](https://miro.medium.com/max/1400/1*L5UcH8ObqxyLLojMTGQ-rg.png)

[https://medium.com/@jvr572/how-deploy-from-a-git-monorepo-1a9a55b23d44](https://medium.com/@jvr572/how-deploy-from-a-git-monorepo-1a9a55b23d44)

This **software engineering practice** has been in use for over a decade, but as of 2017, it has become widespread by large companies such as Google, Facebook, Microsoft, Uber, Airbnb, and Twitter use **Monorepo**, one of their various strategies to scale their build systems and version control software in their daily code changes.

Using a **Monorepo** is important for many reasons.

- It creates a **single source of truth.**
- It makes it easier to **share code**.
- It even makes it easier to **refactor code**.

## **Why we are using Monorepo ?**

We said that Monorepo is a single repository that stores all of our code and assets for every project.

So in our Serverless E-commerce application,We have 2 main parts

- Microservices Part
- Infrastructure Part

So our main motivation to use Monorepo is storing **Microservices Code** and **Infrastructure Code** at the **same repository**.

## **Project Folder Structure**

So we have 1 repository that exists all components of our Serverless e-commerce application. So we have 2 main parts into our Monorepo:

![https://miro.medium.com/max/1400/1*IMO3QGwKMJpNdtl5d0cldQ.png](https://miro.medium.com/max/1400/1*IMO3QGwKMJpNdtl5d0cldQ.png)

- **Serverless Infrastructure Development** — [**AWS CDK** Typescript IaC]
- **Microservices Lambda Function Development** — [Nodejs Lambda Functions using **AWS SDK for JavaScript v3**]

First of all, we are going to develop **Serverless Infrastructure** with **AWS CDK** project which written **typescript** code. After that we will develop our microservices with Nodejs Lambda Functions using **AWS SDK for JavaScript v3.**

I will explain every step of developments of our serverless e-commerce application. I just want to give high level of introduction about our serverless application.

## **Serverless Project Folder Structure**

For that purpose we have 3 main folders about our Project Folder Structure;

![https://miro.medium.com/max/866/1*NMDZnDkVsNrV2fMEjTONNQ.png](https://miro.medium.com/max/866/1*NMDZnDkVsNrV2fMEjTONNQ.png)

**bin — lib — src**

**bin/lib** folders generate by AWS CDK project template. So **bin/lib** folder comes from AWS CDK initial project template and we follow the template for our project.

**bin folder** — includes starting point of our application.**lib folder** — includes infrastructure codes. IaC Serverless Stacks with CDK.**src folder** — includes microservices development codes with nodejs.

# **Review Project Folder Structure into Visual Studio Code**

In this part we will see real codes from our Project Folder Structure into Visual Studio Code.

**bin folder** — includes starting point of our application.

```
#!/usr/bin/env nodeimport ‘source-map-support/register’;
import * as cdk from ‘aws-cdk-lib’;
import { AwsMicroservicesStack } from ‘../lib/aws-microservices-stack’;const app = new cdk.App();
new AwsMicroservicesStack(app, ‘AwsMicroservicesStack’, {/* If you don’t specify ‘env’, this stack will be environment-agnostic.
* Account/Region-dependent features and context lookups will not work,
* but a single synthesized template can be deployed anywhere. */
/* Uncomment the next line to specialize this stack for the AWS Account
* and Region that are implied by the current CLI configuration. */
// env: { account: process.env.CDK_DEFAULT_ACCOUNT, region: process.env.CDK_DEFAULT_REGION },
/* Uncomment the next line if you know exactly what Account and Region you
* want to deploy the stack to. */
// env: { account: ‘123456789012’, region: ‘us-east-1’ },
/* For more information, seehttps://docs.aws.amazon.com/cdk/latest/guide/environments.html */
});
```

**lib folder** — includes infrastructure codes. IaC Serverless Stacks with CDK.

![https://miro.medium.com/max/874/1*D4W1p9imXwV8WJYHfYYM7g.png](https://miro.medium.com/max/874/1*D4W1p9imXwV8WJYHfYYM7g.png)

SwnDatabaseSwnMicroservicesSwnApiGatewaySwnQueueSwnEventBus

These are custom Constructs that we can develop using AWS CDK with typescript language.

```
import { Stack, StackProps } from ‘aws-cdk-lib’;
import { Construct } from ‘constructs’;
import { SwnApiGateway } from ‘./apigateway’;
import { SwnDatabase } from ‘./database’;
import { SwnEventBus } from ‘./eventbus’;
import { SwnMicroservices } from ‘./microservice’;
import { SwnQueue } from ‘./queue’;export class AwsMicroservicesStack extends Stack {
constructor(scope: Construct, id: string, props?: StackProps) {
super(scope, id, props);const database = new SwnDatabase(this, ‘Database’);const microservices = new SwnMicroservices(this, ‘Microservices’, {
productTable: database.productTable,
basketTable: database.basketTable,
orderTable: database.orderTable
});const apigateway = new SwnApiGateway(this, ‘ApiGateway’, {
productMicroservice: microservices.productMicroservice,
basketMicroservice: microservices.basketMicroservice,
orderingMicroservices: microservices.orderingMicroservice
});const queue = new SwnQueue(this, ‘Queue’, {
consumer: microservices.orderingMicroservice
});const eventbus = new SwnEventBus(this, ‘EventBus’, {
publisherFuntion: microservices.basketMicroservice,
targetQueue: queue.orderQueue
});}
}
```

**src folder** — includes microservices development codes using aws sdk with nodejs lambda functions.

![https://miro.medium.com/max/870/1*SikpTFx0d66p_zU--mtwXA.png](https://miro.medium.com/max/870/1*SikpTFx0d66p_zU--mtwXA.png)

- product
- basket
- ordering has index.js lambda function codes.

These are typical NodeJS applications that we developed with JS ECMA scripts 6+ version.And use AWS SDK libraries in order to interact with existing infrastructure, for example basket microservice get and post basket to DynamoDB and publish event to EventBridge.We basically use these AWS SDK libraries. You can find example product index.js file as below;

```
import { DeleteItemCommand, GetItemCommand, PutItemCommand, QueryCommand, ScanCommand, UpdateItemCommand } from "@aws-sdk/client-dynamodb";
import { marshall, unmarshall } from "@aws-sdk/util-dynamodb";
import { ddbClient } from "./ddbClient";
import { v4 as uuidv4 } from 'uuid';exports.handler = async function(event) {
console.log("request:", JSON.stringify(event, undefined, 2));
let body;
try {
switch (event.httpMethod) {
case "GET":
if (event.queryStringParameters != null) {
body = await getProductsByCategory(event);
}
else if (event.pathParameters != null) {
body = await getProduct(event.pathParameters.id);
}
else {
body = await getAllProducts();
}
break;
case "POST":
body = await createProduct(event);
break;
case "DELETE":
body = await deleteProduct(event.pathParameters.id);
break;
case "PUT":
body = await updateProduct(event);
break;
default:
throw new Error(`Unsupported route: "${event.httpMethod}"`);
}
console.log(body);return {
statusCode: 200,
body: JSON.stringify({
message: `Successfully finished operation: "${event.httpMethod}"`,
body: body
})
};
} catch (e) {
console.error(e);
return {
statusCode: 500,
body: JSON.stringify({
message: "Failed to perform operation.",
errorMsg: e.message,
errorStack: e.stack,
})
};
}
};const getProduct = async (productId) => {
console.log("getProduct");
try {
const params = {
TableName: process.env.DYNAMODB_TABLE_NAME,
Key: marshall({ id: productId })
};const { Item } = await ddbClient.send(new GetItemCommand(params));
console.log(Item);
return (Item) ? unmarshall(Item) : {};
} catch(e) {
console.error(e);
throw e;
}
}
```

As you can see that we have overview the code structure of final application. You can find the final application in GitHub at the repository below.

# **Step by Step Design AWS Architectures w/ Course**

![https://miro.medium.com/max/1400/0*p6GXWlVjtYUMLMNx.png](https://miro.medium.com/max/1400/0*p6GXWlVjtYUMLMNx.png)

**[I have just published a new course — AWS Serverless Microservices with Patterns & Best Practices.](https://www.udemy.com/course/aws-serverless-microservices-lambda-eventbridge-sqs-apigateway/?couponCode=APRIL22)**

In this course, we’re going to learn **how to Design and Develop AWS Serverless Event-driven Microservices** with using **AWS Lambda**, **AWS DynamoDB**, **AWS API Gateway**, **AWS EventBridge**, **AWS SQS**, **AWS CDK** for **IaC** — **Infrastructure as Code** tool and **AWS CloudWatch** for **monitoring**.

# **Source Code**

**[Get the Source Code from Serverless Microservices GitHub](https://github.com/awsrun/aws-microservices)** — Clone or fork this repository, if you like don’t forget the star. If you find or ask anything you can directly open issue on repository.