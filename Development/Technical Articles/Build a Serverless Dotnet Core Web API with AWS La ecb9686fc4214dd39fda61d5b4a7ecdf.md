# Build a Serverless Dotnet Core Web API with AWS Lambda and API Gateway

Article Link: https://dev.to/sunilkumarmedium/build-a-serverless-dotnet-core-web-api-with-aws-lambda-and-api-gateway-22dd
Date Added: March 21, 2021 9:40 PM
Tag: .NET, AWS, Lambda, Serverless, Tutorial

**Introduction**In this article, we are going to deploy the ASP.NET Core Web API in AWS Lambda and AWS API Gateway.

**AWS Lambda**AWS Lambda lets you run code without managing servers. you pay only for the compute time you consume.

With Lambda, you can run code for virtually any type of application or backend service - all with zero administration. Just upload your code and Lambda takes care of everything required to run and scale your code with high availability.You can set up your code to automatically trigger from other AWS services or call it directly from any web or mobile app.

**API Gateway**Amazon API Gateway is a fully managed service that makes it easy for developers to create, publish, maintain, monitor, and secure APIs at any scale. APIs act as the "front door" for applications to access data, business logic, or functionality from your backend services.

Using API Gateway, you can create RESTful APIs and WebSocket APIs that enable real-time two-way communication applications. API Gateway supports containerized and serverless workloads, as well as web applications.

**AWS Architecture:**Below is the AWS services we are going to use for the deployment of Web API.

![https://res.cloudinary.com/practicaldev/image/fetch/s--WsCKy9g4--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/ztorwwev6qm76koiy4b9.png](https://res.cloudinary.com/practicaldev/image/fetch/s--WsCKy9g4--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/ztorwwev6qm76koiy4b9.png)

**Pre-requisites**To complete this learning path, you will need:✓ An AWS Account✓ An IAM user with access key credentials✓ Visual Studio Code or Visual Studio 2019+ for Windows

If you don't have an account visit [https://aws.amazon.com](https://aws.amazon.com/) and click Sign Up.You must have a set of valid AWS credentials, consisting of an access key and a secret key, which are used to sign programmatic requests to AWS. You can obtain a set of account credentials when you create your account, although we recommend you do not use these credentials and instead create an IAM user and use those credentials.

**Installing the AWS CLI:**Install the `AWS CLI` for Windows, Mac, or Linux: [https://aws.amazon.com/cli/](https://aws.amazon.com/cli/)

Once installed, you can configure the CLI by running the `aws configure` command in a terminal or command-line window.

When prompted, enter your `AWS Access Key ID` and press Enter.

Enter your `AWS Secret Access Key` when prompted and then press Enter.

For the `default region name` you should enter your chosen region code (e.g. eu-west-1)

Finally, for the `default output` format you can just press Enter.

**Installing the AWS Lambda Tools:**

`dotnet tool install -g Amazon.Lambda.Toolsdotnet tool install --global Amazon.Lambda.TestTool-3.1`

Read the below articles for creating the postgres RDS instance and managing the connection string using Systems Manager[Creating the AWS RDS Instance for PostgreSQL](https://dev.to/sunilkumarmedium/postgresql-database-instance-creation-and-configuration-in-aws-rds-4p60)[AWS Systems Manager Parameter Store and retrieving using C#](https://dev.to/sunilkumarmedium/aws-systems-manager-parameter-store-for-managing-configuration-and-retrieve-at-runtime-using-c-58of)

**[sunilkumarmedium](https://github.com/sunilkumarmedium) / [CleanArchitectureApp](https://github.com/sunilkumarmedium/CleanArchitectureApp)
Clean Architecture Application Design from Scratch using Dotnet Core 3.1 WebApi and Angular 11 FrontEnd**

![https://res.cloudinary.com/practicaldev/image/fetch/s--vJ70wriM--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://practicaldev-herokuapp-com.freetls.fastly.net/assets/github-logo-ba8488d21cd8ee1fee097b8410db9deaa41d0ca30b004c0c63de0a479114156f.svg](https://res.cloudinary.com/practicaldev/image/fetch/s--vJ70wriM--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://practicaldev-herokuapp-com.freetls.fastly.net/assets/github-logo-ba8488d21cd8ee1fee097b8410db9deaa41d0ca30b004c0c63de0a479114156f.svg)

# CleanArchitectureApp

Clean Architecture Application Design from Scratch using Dotnet Core 3.1 WebApi and Angular 11 FrontEnd

[https://camo.githubusercontent.com/9f6b5dca9fd95975898fb95c2cc5b995351004a6c4443ccb13e1916a97bb122a/687474703a2f2f696d672e736869656c64732e696f2f62616467652f6c6963656e73652d4d49542d627269676874677265656e2e737667](https://camo.githubusercontent.com/9f6b5dca9fd95975898fb95c2cc5b995351004a6c4443ccb13e1916a97bb122a/687474703a2f2f696d672e736869656c64732e696f2f62616467652f6c6963656e73652d4d49542d627269676874677265656e2e737667)

## Technologies

- [ASP.NET Core 3.1](https://dotnet.microsoft.com/)
- [NHibernate](https://nhibernate.info/)
- [Angular 11](https://angular.io/)
- [Angular CLI 11](https://cli.angular.io/)
- [Clean Architecture](https://raw.githubusercontent.com/sunilkumarmedium/CleanArchitectureApp/main/)
- [Swashbuckle.AspNetCore.Swagger](https://github.com/domaindrivendev/Swashbuckle.AspNetCore)
- Design Pattern: Command Query Responsibility Segregation (CQRS)
- [Fluent Validation](https://fluentvalidation.net/)
- WebAPI Global Exception Middleware
- Login, Logout and Forgot Password using JWT tokens
- Microsoft Sql Server and Postgresql supported.

## Pre-requisites

1. [.Net core 3.1 SDK](https://www.microsoft.com/net/core#windows)
2. [Visual studio 2019](https://www.visualstudio.com/) OR [VSCode](https://code.visualstudio.com/) with [C#](https://marketplace.visualstudio.com/items?itemName=ms-vscode.csharp) extension
3. [NodeJs](https://nodejs.org/en/) (Latest LTS)
4. [Microsoft SQL Server](https://www.microsoft.com/en-us/sql-server/sql-server-2017) (Optional: If MS SQL server required instead of Sqlite during development)
5. [POSTGRESQL](https://www.postgresql.org/download/)

## Configuration

1. Clone the repo: git clone [https://github.com/sunilkumarmedium/CleanArchitectureApp.git](https://github.com/sunilkumarmedium/CleanArchitectureApp.git)
2. Execute the sql scripts available in the folder `/sql/`
    - MSSQL use CleanArchitectureDB.sql
    - POSTGRES use CleanArchitectureDB-Postgres
3. Change the database connectionstring in appsettings.json
    - Path : CleanArchitectureApp.WebApi/appsettings.Development.json or appsettings.json
    - `"DBProvider": "MSSQL" ,` Use `MSSQL` to connect to Microsoft SqlServer Or `POSTGRES` to connect to PostgreSQL database
    - `"ConnectionStrings": { "MSSQLConnection": "Data Source=DESKTOP-SUNILBO;Initial Catalog=CleanArchitectureDB;User ID=sa;Password=xxx;MultipleActiveResultSets=True", "PostgresConnection": "Server=127.0.0.1;Port=5432;Database=CleanArchitectureDB;User Id=postgres;Password=xxx;Timeout=30;TimeZone=UTC" }'`
4. cd to…

[View on GitHub](https://github.com/sunilkumarmedium/CleanArchitectureApp)

**Creating the AWS Lambda Web Api Project using command line**

`dotnet new --help` will display the installed AWS project templates

![https://res.cloudinary.com/practicaldev/image/fetch/s--9PqD5wDB--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/skp2w30nuqsgjzcegoxc.png](https://res.cloudinary.com/practicaldev/image/fetch/s--9PqD5wDB--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/skp2w30nuqsgjzcegoxc.png)

To create a serverless project run the below command`dotnet new serverless.AspNetCoreWebAPI -n CleanArchitectureApp`

**Adding Lambda Support to existing ASP.NET Core Web API Project**

Below are the steps to add AWS Lambda support for existing projects

**Step 1:** In csproj file add the below tag`<AWSProjectType>Lambda</AWSProjectType>`

Include the below AWS package references to the projects

```
<PackageReference Include="AWSSDK.Extensions.NETCore.Setup" Version="3.3.101" />
<PackageReference Include="Amazon.Lambda.AspNetCoreServer" Version="5.2.0" />

```

**Step 2:** Create a c# file with name "LambdaEntryPoint.cs" and inherit the appropriate class based on your requirement. Below are some details

- API Gateway REST API -> Amazon.Lambda.AspNetCoreServer.APIGatewayProxyFunction
- API Gateway HTTP API payload version 1.0 -> Amazon.Lambda.AspNetCoreServer.APIGatewayProxyFunction
- API Gateway HTTP API payload version 2.0 -> Amazon.Lambda.AspNetCoreServer.APIGatewayHttpApiV2ProxyFunction
- Application Load Balancer -> Amazon.Lambda.AspNetCoreServer.ApplicationLoadBalancerFunction

Call the Startup.cs in the override method.

```
 protected override void Init(IWebHostBuilder builder)
        {
            builder
                .UseStartup<Startup>();
        }

```

**Step 3:** Create a json file "aws-lambda-tools-defaults.json" to read the default lambda configuration.

**Step 4:** create a serverless declarative template "serverless.template" and this will be used by the AWS Cloud Formation for creating the required resources during the Lambda deployment.

Specify the dotnet core runtime, lambda handler, memory and policies

```
 "Resources": {
    "AspNetCoreFunction": {
      "Type": "AWS::Serverless::Function",
      "Properties": {
        "Handler": "CleanArchitectureApp.WebApi::CleanArchitectureApp.WebApi.LambdaEntryPoint::FunctionHandlerAsync",
        "Runtime": "dotnetcore3.1",
        "CodeUri": "",
        "MemorySize": 256,
        "Timeout": 30,
        "Role": null,
        "Policies": [
          "AWSLambdaFullAccess", "AmazonSSMFullAccess","AWSLambdaVPCAccessExecutionRole"
        ],

```

Below is the full implementation

### aws-lambda-tools.json

```json
{
  "Information": [
    "This file provides default values for the deployment wizard inside Visual Studio and the AWS Lambda commands added to the .NET Core CLI.",
    "To learn more about the Lambda commands with the .NET Core CLI execute the following command at the command line in the project root directory.",
    "dotnet lambda help",
    "All the command line options for the Lambda command can be specified in this file."
  ],
  "profile": "default",
  "region": "ap-south-1",
  "configuration": "Release",
  "framework": "netcoreapp3.1",
  "stack-name": "CleanArchitectureAppWebApi",
  "s3-bucket": "mytestbucketsunil",
  "s3-prefix": "CleanArchitectureAppWebApi/",
  "template": "serverless.template",
  "template-parameters": "ShouldCreateBucket=false;BucketName="
}
```

### LambdaEntryPoint

```csharp
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Hosting;

namespace CleanArchitectureApp.WebApi
{
    /// <summary>
    /// This class extends from APIGatewayProxyFunction which contains the method FunctionHandlerAsync which is the
    /// actual Lambda function entry point. The Lambda handler field should be set to
    ///
    /// CleanArchitectureApp.WebApi::CleanArchitectureApp.WebApi.LambdaEntryPoint::FunctionHandlerAsync
    /// </summary>
    public class LambdaEntryPoint :

        // The base class must be set to match the AWS service invoking the Lambda function. If not Amazon.Lambda.AspNetCoreServer
        // will fail to convert the incoming request correctly into a valid ASP.NET Core request.
        //
        // API Gateway REST API                         -> Amazon.Lambda.AspNetCoreServer.APIGatewayProxyFunction
        // API Gateway HTTP API payload version 1.0     -> Amazon.Lambda.AspNetCoreServer.APIGatewayProxyFunction
        // API Gateway HTTP API payload version 2.0     -> Amazon.Lambda.AspNetCoreServer.APIGatewayHttpApiV2ProxyFunction
        // Application Load Balancer                    -> Amazon.Lambda.AspNetCoreServer.ApplicationLoadBalancerFunction
        //
        // Note: When using the AWS::Serverless::Function resource with an event type of "HttpApi" then payload version 2.0
        // will be the default and you must make Amazon.Lambda.AspNetCoreServer.APIGatewayHttpApiV2ProxyFunction the base class.

        Amazon.Lambda.AspNetCoreServer.APIGatewayProxyFunction
    {
        /// <summary>
        /// The builder has configuration, logging and Amazon API Gateway already configured. The startup class
        /// needs to be configured in this method using the UseStartup<>() method.
        /// </summary>
        /// <param name="builder"></param>
        protected override void Init(IWebHostBuilder builder)
        {
            builder
                .UseStartup<Startup>();
        }

        /// <summary>
        /// Use this override to customize the services registered with the IHostBuilder.
        ///
        /// It is recommended not to call ConfigureWebHostDefaults to configure the IWebHostBuilder inside this method.
        /// Instead customize the IWebHostBuilder in the Init(IWebHostBuilder) overload.
        /// </summary>
        /// <param name="builder"></param>
        protected override void Init(IHostBuilder builder)
        {
        }
    }
}
```

### serverless.template

```csharp
{
  "AWSTemplateFormatVersion": "2010-09-09",
  "Transform": "AWS::Serverless-2016-10-31",
  "Description": "An AWS Serverless Application that uses the ASP.NET Core framework running in Amazon Lambda.",
  "Parameters": {
    "ShouldCreateBucket": {
      "Type": "String",
      "AllowedValues": [
        "true",
        "false"
      ],
      "Description": "If true then the S3 bucket that will be proxied will be created with the CloudFormation stack."
    },
    "BucketName": {
      "Type": "String",
      "Description": "Name of S3 bucket that will be proxied. If left blank a name will be generated.",
      "MinLength": "0"
    }
  },
  "Conditions": {
    "CreateS3Bucket": {
      "Fn::Equals": [
        {
          "Ref": "ShouldCreateBucket"
        },
        "true"
      ]
    },
    "BucketNameGenerated": {
      "Fn::Equals": [
        {
          "Ref": "BucketName"
        },
        ""
      ]
    }
  },
  "Resources": {
    "AspNetCoreFunction": {
      "Type": "AWS::Serverless::Function",
      "Properties": {
        "Handler": "CleanArchitectureApp.WebApi::CleanArchitectureApp.WebApi.LambdaEntryPoint::FunctionHandlerAsync",
        "Runtime": "dotnetcore3.1",
        "CodeUri": "",
        "MemorySize": 256,
        "Timeout": 30,
        "Role": null,
        "Policies": [
          "AWSLambdaFullAccess", "AmazonSSMFullAccess","AWSLambdaVPCAccessExecutionRole"
        ],
        "Environment": {
          "Variables": {
            "AppS3Bucket": {
              "Fn::If": [
                "CreateS3Bucket",
                {
                  "Ref": "Bucket"
                },
                {
                  "Ref": "BucketName"
                }
              ]
            }
          }
        },
        "Events": {
          "ProxyResource": {
            "Type": "Api",
            "Properties": {
              "Path": "/{proxy+}",
              "Method": "ANY"
            }
          },
          "RootResource": {
            "Type": "Api",
            "Properties": {
              "Path": "/",
              "Method": "ANY"
            }
          }
        }
      }
    },
    "Bucket": {
      "Type": "AWS::S3::Bucket",
      "Condition": "CreateS3Bucket",
      "Properties": {
        "BucketName": {
          "Fn::If": [
            "BucketNameGenerated",
            {
              "Ref": "AWS::NoValue"
            },
            {
              "Ref": "BucketName"
            }
          ]
        }
      }
    }
  },
  "Outputs": {
    "ApiURL": {
      "Description": "API endpoint URL for Prod environment",
      "Value": {
        "Fn::Sub": "https://${ServerlessRestApi}.execute-api.${AWS::Region}.amazonaws.com/Prod/"
      }
    },
    "S3ProxyBucket": {
      "Value": {
        "Fn::If": [
          "CreateS3Bucket",
          {
            "Ref": "Bucket"
          },
          {
            "Ref": "BucketName"
          }
        ]
      }
    }
  }
}
```

**Deploying the WebApi to AWS Lambda**

Open the command line on Windows and change the repository working directory to:`cd D:\GitHub_Projects\CleanArchitectureApp\CleanArchitectureApp.WebApi`

Enter the below command and hit enter`dotnet lambda deploy-serverless --template serverless.template`

![https://res.cloudinary.com/practicaldev/image/fetch/s--rkiKZ1Es--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/t6yxw9x123ltq15z9pla.png](https://res.cloudinary.com/practicaldev/image/fetch/s--rkiKZ1Es--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/t6yxw9x123ltq15z9pla.png)

**Cloud Formation Stack Creation In Progress**

![https://res.cloudinary.com/practicaldev/image/fetch/s--gHNkU-Bd--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/wwp7hovgrcedmdqam591.png](https://res.cloudinary.com/practicaldev/image/fetch/s--gHNkU-Bd--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/wwp7hovgrcedmdqam591.png)

**Lambda Function Deployed**

![https://res.cloudinary.com/practicaldev/image/fetch/s--hYRW6qtG--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/lt2nrek9yglg7w1nbdox.png](https://res.cloudinary.com/practicaldev/image/fetch/s--hYRW6qtG--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/lt2nrek9yglg7w1nbdox.png)

**Lambda function permissions for connecting to RDS instance**

![https://res.cloudinary.com/practicaldev/image/fetch/s--W_oMBn3a--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/gav9kimlhkezgncicnz9.png](https://res.cloudinary.com/practicaldev/image/fetch/s--W_oMBn3a--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/gav9kimlhkezgncicnz9.png)

**API Gateway Resource Creation**

![https://res.cloudinary.com/practicaldev/image/fetch/s--x3hyoHBW--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/nn17nhax6w9pef3fdq62.png](https://res.cloudinary.com/practicaldev/image/fetch/s--x3hyoHBW--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/nn17nhax6w9pef3fdq62.png)

Hit the API gateway endpoint`https://xxxx.execute-api.ap-south-1.amazonaws.com/Prod/swagger`

![https://res.cloudinary.com/practicaldev/image/fetch/s--XfgBI9m8--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/zh9xnrqeahoq6nsoan9z.png](https://res.cloudinary.com/practicaldev/image/fetch/s--XfgBI9m8--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/zh9xnrqeahoq6nsoan9z.png)

**Cloud Watch Logs:**

![https://res.cloudinary.com/practicaldev/image/fetch/s--GCXn4h6---/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/jcagmdsvkm5dienw7h64.png](https://res.cloudinary.com/practicaldev/image/fetch/s--GCXn4h6---/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/jcagmdsvkm5dienw7h64.png)

**Summary**You can implement the Warmer function for faster ColdStart(startup) of Lambda Function.