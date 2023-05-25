

----

**Author**: #AshanFernando

----

**Article Link**: https://enlear.academy/aws-dynamodb-for-serverless-microservices-2acbbbff1bca

----

**Tags**: #serverless #dynamoDB #microservice #aws #cloud

---



![](https://miro.medium.com/v2/resize:fit:700/1*xLCc8hXb0SvR6qgIWCuiyA.jpeg)

DynamoDB is the Serverless NoSQL Database offering by AWS. Being Serverless makes it easier to consider DynamoDB for Serverless Microservices since it aligns with the patterns and practices when designing serverless architectures in AWS.

If you are still confused, what is a Serverless NoSQL Database means? Let me give you a quick overview. We use Serverless when we don’t need to manage any servers (Software Updates, OS Patching, OS Security &, etc.).

> Instead, someone else manages them for us where we can focus on the usage.

When it comes to DynamoDB, AWS manages the underlying infrastructure and software and gives us an abstract view of Tables, Indexes (GSI, LSI), Throughput, Auto Scaling, and Security Policies, which consists of high-level constructs NoSQL database.

![](https://miro.medium.com/v2/resize:fit:700/0*NLzNYw0dPeSyTD7j.)

_AWS DynamoDB Configuration Patterns_

This article provides an overview of the principles, patterns, and best practices using AWS DynamoDB for Serverless Microservices.

## Principles in Using AWS DynamoDB

AWS DynamoDB is more suited for storing JSON documents and use as a storage for key-value pairs. In addition, having multiple types of indexes and various types of query possibilities makes it convenient to be used for different types of storage and query requirements.

> However, it is essential to understand that DynamoDB is a NoSQL database which is difficult to compare with a Relational Database, side by side.

It also makes it difficult for a person coming from a Relational Database background to design DynamoDB tables. Therefore it is essential to understand several underlying principles in using DynamoDB. The following list contains 12 principles I follow when creating DynamoDB tables and queries.

1.  Use GUIDs or Unique Attributes instead of incremental IDs.
2.  Don’t try to normalize your tables.
3.  Having duplicate attributes in multiple tables is fine as long as you have implemented ways to synchronize the changes.
4.  Keeping pre-computed data upon updates is efficient with DynamoDB if you need to query them often.
5.  Don’t try to keep many relationships across tables. It will end up needing to query multiple tables to retrieve the required attributes.
6.  Embrace eventual consistency.
7.  Design your transactions to work with conditional writes.
8.  Design your tables, attributes, and indexes thinking of the nature of queries.
9.  Use DynamoDB triggers and streams to propagate changes and event-driven design data flows.
10.  Think about item sizes and using indexes effectively when listing items to minimize throughput requirements.
11.  Think about the growth of attribute data to design whether to store them as a nested object or use a different table for it.
12.  Avoid using DynamoDB Scan operation whenever possible.

## Patterns for Serverless Microservices

AWS DynamoDB is used for Serverless Microservices with different configuration patterns for various use cases.

## Direct Access from RESTful API

![](https://miro.medium.com/v2/resize:fit:700/0*3VmKpu2Tp5iK_P0b.)

The most common pattern for Serverless Microservices is to connect DynamoDB to an API Endpoint Code (Inside AWS Lambda), which is invoked through AWS API Gateway. However, it is also possible to directly connect DynamoDB to API Gateway if the Microservice offers direct DynamoDB queries.

**Note**: It is also possible to invoke AWS Lambda as a RESTful endpoint if the client has AWS IAM credentials or AWS STS temporary credentials.

## Event-Driven Updates

![](https://miro.medium.com/v2/resize:fit:700/0*CEgp4yl0htHJKVHk.)

DynamoDB also can be updated based on events other than Direct Access from RESTful API. For example, we can use DynamoDB to store metadata of files uploaded to Amazon S3. Using S3 Upload Trigger, the Lambda function can be invoked upon file upload, updating the DynamoDB table. We can use a similar approach to perform DynamoDB updates in response to Amazon SNS.

## Data Synchronization Between Microservices

![](https://miro.medium.com/v2/resize:fit:700/0*RUCK1QDUYibIyeZF.)

If the same attributes are stored in multiple Microservices DynamoDB tables, you can use Amazon Simple Notification Service (SNS) Topics. Using Amazon SNS, it is possible to inform attribute changes from one service to another without knowing each other.

For example, Service #1 Company Profile Table and Service #2 Company Statistics Table shares the company name attribute. If the company name is modified in Service #1, change must be propagated to Service #2 Company Statistics Table. Knowing these requirements, Service #1 can publish the attribute change using DynamoDB Streams and a Lambda function to the SNS topic. When the change happens, the Lambda function in Service #2 subscribed to the topic will update the Company Statistics Table.

## Conclusion

If you are new to AWS DynamoDB, it is essential to understand its capabilities and limitations before moving into the database design. It is equally important to have a proper mindset to design the data model using NoSQL principles and configuration patterns. This will include unlearning some of the concepts learned from Relational Database Design.

In addition, using DynamoDB can be challenging for some use cases. For example, suppose you are struggling to think of how to update multiple tables concurrently, querying various tables, or limitations of indexes for your use case. In that case, these can be hints to revisit the original decision to use DynamoDB in the first place. However, AWS DynamoDB is an integral part of the AWS Serverless Technology Stack, which remains the leading Serverless NoSQL database in AWS.

## Learn More