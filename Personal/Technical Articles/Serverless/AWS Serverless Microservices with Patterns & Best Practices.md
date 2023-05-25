----

**Date**: 2023-05-25

----

**Author**: #mehmetOzkaya

----

**Article Link**: https://medium.com/aws-serverless-microservices-with-patterns-best/building-restful-microservices-with-aws-lambda-api-gateway-and-dynamodb-614209bcad7

----

**Tags**: #serverless #microservice #aws #lambda #javascript #dynamoDB #sqs #apiGateway 

----

## AWS Serverless Microservices with Patterns & Best Practices

AWS Event-driven Serverless Microservices using AWS Lambda, API Gateway, EventBridge, SQS, DynamoDB and CDK for IaC

[![AWS Serverless Microservices with Patterns & Best Practices](https://miro.medium.com/v2/resize:fill:75:75/1*99HDoHDJ-22XqqNdMVfxxw.png)](https://medium.com/aws-serverless-microservices-with-patterns-best?source=post_page-----614209bcad7--------------------------------)

In this article, we are going to build **RESTful Microservices with AWS Lambda, API Gateway and DynamoDB** when developing **Serverless E-Commerce** application.

![](https://miro.medium.com/v2/resize:fit:700/1*WK_-gPDoCp29u8_MfStF7g.png)

Serverless Event-driven E-commerce Microservices Architecture

At the end of the article we will be design the **Reference Architecture** above which is a **Real-world** **Serverless E-commerce application.**

## Step by Step Design AWS Architectures w/ Course

![](https://miro.medium.com/v2/resize:fit:700/0*eKTBNHJ-LgwqJewX.png)

[**I have just published a new course — AWS Serverless Microservices with Patterns & Best Practices.**](https://www.udemy.com/course/aws-serverless-microservices-lambda-eventbridge-sqs-apigateway/?couponCode=APRI23)

In this course, we’re going to learn **how to Design and Develop AWS Serverless Event-driven Microservices** with using **AWS Lambda**, **AWS DynamoDB**, **AWS API Gateway**, **AWS EventBridge**, **AWS SQS**, **AWS CDK** for **IaC** — **Infrastructure as Code** tool and **AWS CloudWatch** for **monitoring**.

## Source Code

[**Get the Source Code from Serverless Microservices GitHub**](https://github.com/awsrun/aws-microservices) — Clone or fork this repository, if you like don’t forget the star. If you find or ask anything you can directly open issue on repository.

## Introduction

I will give overview information about **RESTful Microservices** with **AWS Lambda, API Gateway and DynamoDB.**

When building a microservice, you’re thinking about how a business context can be delivered as a re-usable service for your consumers. The specific implementation will be tailored to individual use cases, but there are several common themes across microservices to ensure that your implementation is secure, resilient, and constructed to give the best experience for your customers.

So In this article, we are going to create a serverless API that creates, reads, updates, and deletes items from a DynamoDB table. DynamoDB is a fully managed NoSQL database service that provides fast and predictable performance with seamless scalability.  
This article takes approximately 20 minutes to complete, and you can do it within the AWS Free Tier.

First, we create a DynamoDB table using the DynamoDB console.  
Then we create a Lambda function using the AWS Lambda console.  
Next, we create an REST API using the API Gateway console. Lastly, we test your API.

![](https://miro.medium.com/v2/resize:fit:700/0*CmIVRSu4xBYjJBCS.png)

This is the Reference architecture for **RESTful microservices**.

**1-** Clients send request our microservices by making HTTP API calls.  
Ideally, our clients should have a tightly bounded service contract to our API  
in order to achieve consistent expectations of microservice responsibility.

**2-** Amazon API Gateway hosts RESTful HTTP requests and responses to customers. In this scenario, API Gateway provides built-in authorization, throttling, security, fault tolerance, request/response mapping, and performance optimizations.

**3-** AWS Lambda contains the business logic to process incoming API calls and leverage DynamoDB as a persistent storage.

**4-** Amazon DynamoDB persistently stores microservices data and scales based on demand. Since microservices are often designed to do one thing well, a schemaless NoSQL data store is regularly incorporated.

So When we invoke our API Gateway API, API Gateway routes the request to your Lambda function. The Lambda function interacts with DynamoDB, and returns a response to API Gateway. API Gateway then returns a response to us.

## Create a DynamoDB Table

We are going to Create a DynamoDB table. We use a DynamoDB table to store data for your API. Each item has a unique ID, which we use as the partition key for the table.

To create a DynamoDB table  
Open the DynamoDB console at [https://console.aws.amazon.com/dynamodb/](https://console.aws.amazon.com/dynamodb/).

Choose Create table.  
For Table name, product

For Primary key,  
PK — id.

Choose Create.

As you can see that we have created our DynamoDB table.

## Create a Lambda Function

We are going to Create a Lambda function. AWS Lambda is event-driven computing rather than an imperative model. Events-driven computing responds to events when the event source happens, it triggers the lambda function. The event source could be a request to an endpoint which we will go through later using API Gateway.

We create a Lambda function for the backend of your API. This Lambda function creates, reads, updates, and deletes items from DynamoDB. The function uses events from API Gateway to determine how to interact with DynamoDB.

## Create a Lambda function

Sign in to the Lambda console at [https://console.aws.amazon.com/lambda](https://console.aws.amazon.com/lambda).

Choose Create function.  
For Function name  
productFunction

Give Microservice Permission  
Under Permissions choose Change default execution role.  
Select Create a new role from AWS policy templates.

For Role name  
productRole

For Policy templates, choose “Simple microservice permissions”. This policy grants the Lambda function permission to interact with DynamoDB.

**Note**  
We uses a managed policy for simplicity. As a best practice, you should create your own IAM policy to grant the minimum permissions required.

Choose Create function.  
Open index.js in the console’s code editor, and replace its contents with the following code.

```
const AWS = require(“aws-sdk”);const dynamo = new AWS.DynamoDB.DocumentClient();exports.handler = async (event, context) => { let body; let statusCode = 200; const headers = { “Content-Type”: “application/json” };try { switch (event.httpMethod) { case “DELETE”: await dynamo .delete({ TableName: “product”, Key: { id: event.pathParameters.id } }) .promise(); body = `Deleted product ${event.pathParameters.id}`; break; case “GET”: if (event.pathParameters != null) { body = await dynamo .get({ TableName: “product”, Key: { id: event.pathParameters.id } }) .promise(); } else { body = await dynamo.scan({ TableName: “product” }).promise(); } break; case “POST”: let requestJSON = JSON.parse(event.body); await dynamo .put({ TableName: “product”, Item: { id: requestJSON.id, price: requestJSON.price, title: requestJSON.title, description: requestJSON.description, } }) .promise(); body = `Added/Updated product ${requestJSON.id}`; break; default: throw new Error(`Unsupported route: “${event.httpMethod}”`); } } catch (err) { statusCode = 400; body = err.message; } finally { body = JSON.stringify(body); }return { statusCode, body, headers };};
```

Choose Deploy to update your function.

The handler method is the method that will be executed when the lambda function is invoked. This function takes in two objects, event, and context. The event object contains all of the data sent from the event source and the context object provides several methods that allow you to interact with runtime information specific to that lambda function.

We have Copied the snippet code and paste it to the index.js. By using the event.httpMethod to differentiate the HTTP request, we can perform the create/update/delete and retrieve data from DynamoDB.

We will also develop these function when developing our serverless e-commerce microservices.

## Create an API Gateway

We are going to Create a REST API in API Gateway.

When your API method receives an HTTP request, API Gateway invokes your Lambda function.

## Create a REST API in API Gateway

Open AWS Console, type API Gateway in the search bar, and hit enter.  
Click on the Build button on REST API. Fill in the details:

Choose the protocol: REST  
Create new API: New API  
API name: productApi  
Endpoint Type: Regional

Click on the Create API button to complete.

Select the Actions drop-down list,  
choose to Create Resource.

Resource Name: product

Click on Create Resource button to complete.

## Create Method

Select the Actions drop-down list again, choose Create Method.  
Select POST to insert a new record.

Integration type: Lambda Function  
Use Lambda Proxy integration: Checked (remember to check so event details will be passed to Lambda) — DON’T FORGET THIS, OTHERWISE GET EXCEPTION !!  
Lambda Function: productFunction

Click the Save button, a message with Add Permission to Lambda Function will pop out, click OK to grant the permission.

Take note that, for API GET by id and DELETE by id, We need to create another resource to specify the path parameter.

So click on the /products, followed by Actions drop-down list.  
Select the Create Resources, under the Resource Path enter {id} then click on the Create Resource button to complete. Repeat the Create Method step to create GET and DELETE methods.

## Deploy the API

In the last step, we need to deploy the API so that we can access it thru the public. Click on the Actions drop-down list, select Deploy API.

Click the Deploy button and then the Save Changes button. Yo can see an Invoke URL will appear on top of this page.

We will Try accessing the URL from the browser or Postman.

## Test — RESTful Microservices with AWS Lambda, API Gateway and DynamoDB

We are going to TEST — RESTful Microservices with AWS Lambda, API Gateway and DynamoDB.

We will try accessing the URL from the browser or Postman.

## TEST Endpoint

[https://xxx.execute-api.ap-southeast-1.amazonaws.com/prod/product](https://xxx.execute-api.ap-southeast-1.amazonaws.com/prod/product)

We can send POST request from the API Gateway itself. You can use postman but I would like to show quickly on AWS Management Console.

Go to API Gateway  
go to post  
click TEST

Click Test to test POST the API in order to create item into DynamoDB table.

Paste the test data to Request Body and click Test.

```
{ “id”: “1”,  “title”: “IPhone”, “description”: “This is an IPhone”, “price”: 900}
```

Verify the data in the DynamoDB table.

So far we have tested the create product API and it works correctly.

Let’s test the GET by id API.

## Test GET method

[https://xxx.execute-api.ap-southeast-1.amazonaws.com/prod/product](https://xxx.execute-api.ap-southeast-1.amazonaws.com/prod/product)

You should see the IPhone product return on the browser.

In conclusion, we have learned about creating a serverless CRUD API using AWS services such as Lambda, DynamoDB, and API Gateway.

## Resource Cleanup

Before we go ahead, we should always clear our resources.

We will go through the steps to terminate all the resources you created throughout this section.

We will terminate Our an

-   AWS Lambda function,
-   an IAM role,
-   a DynamoDB table,
-   a REST API,
-   and a CloudWatch Log.

It is a best practice to delete resources you are no longer using to avoid unwanted charges. Please go and remove all created resources during the article.

So now, let’s develop our enterprise E-Commerce application with fully Serverless Event-driven Microservices Architecture.

## AWS Serverless Microservices for Ecommerce Application Architecture

Here you can find the main overall **Serverless Architecture** for our application. This is the **big picture** of what we are going to develop together for **AWS Serverless Event-driven E-commerce Microservices** application that is Step by Step Implementation together.

![](https://miro.medium.com/v2/resize:fit:700/1*_kdcw6XYskm6nUIydqn1Hw.png)

Serverless Event-driven E-commerce Microservices Architecture

We will be following the **Reference Architecture** above which is a **real-world** **Serverless E-commerce application** and it includes;

-   **REST API** and **CRUD** endpoints with using **AWS Lambda, API Gateway**
-   **Data persistence** with using **AWS DynamoDB**
-   **Decouple microservices** with **events** using **AWS EventBridge**
-   **Message Queues** for cross-service communication using **AWS SQS**
-   **Cloud stack development** with **IaC** using **AWS CloudFormation CDK**

## Step by Step Design AWS Architectures w/ Course

![](https://miro.medium.com/v2/resize:fit:700/0*f70qCvlnBGrOYi6H.png)

[**I have just published a new course — AWS Serverless Microservices with Patterns & Best Practices.**](https://www.udemy.com/course/aws-serverless-microservices-lambda-eventbridge-sqs-apigateway/?couponCode=APRI23)

In this course, we’re going to learn **how to Design and Develop AWS Serverless Event-driven Microservices** with using **AWS Lambda**, **AWS DynamoDB**, **AWS API Gateway**, **AWS EventBridge**, **AWS SQS**, **AWS CDK** for **IaC** — **Infrastructure as Code** tool and **AWS CloudWatch** for **monitoring**.

## Source Code

[**Get the Source Code from Serverless Microservices GitHub**](https://github.com/awsrun/aws-microservices) — Clone or fork this repository, if you like don’t forget the star. If you find or ask anything you can directly open issue on repository.