# Getting Started with IaC Tools: How to Set up & Use CFT, Terraform, CDK, and SAM

Article Link: https://awstip.com/from-development-to-deployment-setting-up-cft-terraform-cdk-sam-on-local-and-aws-c598da561b18
Author: Haimo Zhang
Date Added: April 18, 2023 4:16 PM
Tag: CDK, SAM, Serverless, Terraform

When working with cloud infrastructure, it is important to have a 
well-configured local environment and AWS setup to ensure efficient 
development, testing, and deployment of your code. In this blog, I will 
guide you through the steps required to set up your local environment 
and AWS for running CloudFormation (CFT), Terraform, AWS Cloud 
Development Kit (CDK) and Serverless Application Model (SAM).

- [AWS Cloudformation](https://aws.amazon.com/cloudformation) (CFT)
- [HashiCorp Terraform](https://cloud.hashicorp.com/)
- [AWS Cloud Development Kit](https://aws.amazon.com/cdk/) (CDK)
- [AWS Serverless Application Model](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html) (SAM)

![https://miro.medium.com/v2/resize:fit:700/1*iEBHvKy0TIVMq7pGRXJZFg.png](https://miro.medium.com/v2/resize:fit:700/1*iEBHvKy0TIVMq7pGRXJZFg.png)

All
 four tools have their unique features and capabilities, and the choice 
of tool depends on your specific use case, preferences, and 
requirements.

**[Get an email whenever Haimo Zhang publishes.Get an email whenever Haimo Zhang publishes. By signing up, you will create a Medium account if you don't already have…**
zhaimo.medium.com](https://zhaimo.medium.com/subscribe)

## AWS CloudFormation (CFT)

- CFT is a service that create and manage AWS resources by writing infrastructure as code templates in JSON or YAML format.
- CFT templates are declarative and define the desired state of the
infrastructure, and CFT handles the creation, update, and deletion of
resources based on the template.
- CFT supports a wide range of AWS services and can be used to manage complex infrastructures.
- CFT can be used through the AWS Management Console, AWS CLI, or API.

## Terraform

- Terraform is an open-source infrastructure as code tool that allows you to manage your infrastructure as code.
- Terraform uses a declarative language to describe the desired state of the
infrastructure, and Terraform handles the creation, update, and deletion of resources based on the configuration files.
- Terraform supports multiple cloud providers, including AWS, and can be used to
manage complex infrastructures across different clouds.
- Terraform can be used through the CLI or API.

## AWS Cloud Development Kit (CDK)

- CDK is an open-source software development framework to define cloud
infrastructure in code and provision it through AWS CloudFormation.
- CDK allows developers to use familiar programming languages such as
TypeScript, Python, Java, and C# to define their infrastructure in code.
- CDK generates AWS CloudFormation templates from the code, which can be used to create, update, and delete resources.

## AWS Serverless Application Model (SAM)

- SAM is an open-source framework that allows you to build, test, and deploy serverless applications on AWS.
- SAM is built on top of AWS CloudFormation and uses AWS CloudFormation templates to define and deploy serverless applications.
- SAM provides a simplified syntax for defining serverless resources such as
AWS Lambda functions, Amazon S3 buckets, and Amazon DynamoDB tables.
- SAM supports local testing and debugging of serverless applications using Docker.

Now let’s find out how to setup and use these tools.

# Prerequisites Setup

In this blog I use mac laptop, the setup on Windows PC will be different.

- **Install an IDE tool**

Choose an IDE that you are comfortable with. I use VS Code which can be download from [here](https://code.visualstudio.com/download).

- **Create an IAM User in AWS**

From your AWS account, create an IAM user and grand permission needed, follow the steps outlined in the [AWS IAM User Guide](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html). You need to get access key ID and secret assess key for next AWS CLI configuration.

- **Install AWS CLI**

The
 AWS CLI is a command-line tool that allows you to interact with AWS 
services. You can install the AWS CLI by running the following command 
in your terminal:

```
%brew install awscli
```

- **Configure AWS CLI**

Once you have created an IAM user, you need to configure AWS CLI to use the user’s credentials. **This** **is a requirement for running CFT, Terraform, CDK, and SAM**. To do this, follow these steps:

1. Open the command prompt or terminal on your local machine.
2. Run the **`aws configure`** command and enter the **access key ID** and **secret access key** for your IAM user when prompted.
3. Specify the default region and output format that you want to use.
4. You can verify if setup correctly by running this command on your IAM user just created.

```
% aws iam get-login-profile --user-name test
{
    "LoginProfile": {
        "UserName": "test",
        "CreateDate": "2017-01-23T15:07:24+00:00",
        "PasswordResetRequired": false
    }
}
```

**Now we can go ahead setup CFT, Terraform, CDK and SAM.**

# **(1). AWS Cloudformation Stack**

AWS
 CloudFormation (CFT) is a service that allows you to create and manage 
AWS resources by writing infrastructure as code templates in JSON or 
YAML format. Here are the steps required to set up and run CFT using the
 AWS CLI.

Step 1: Open VS Code to create CFT template.

Here’s an example of a simple CloudFormation template that creates an Amazon S3 bucket:

```
---
Resources:
  MyS3Bucket:
    Type: AWS::S3::Bucket
    Properties:
      BucketName: my-bucket-name
```

Step 2: Use the AWS CLI to run create a CloudFormation stack

First verify AWS CLI setup correctly.

Run the following command in local terminal to create a CloudFormation stack in your AWS account:

```
aws cloudformation create-stack \
    --stack-name my-stack \
    --template-body file://path/to/template.yml \
    --parameters ParameterKey=BucketName,ParameterValue=my-bucket-name \
    --region us-east-1
```

Once you run the command, You can verify in AWS console if all resources created successfully or debug if errors occurred.

Here’s what each parameter in the command means:

- `-stack-name`: The name you want to give to your CloudFormation stack.
- `-template-body`: The path to the CloudFormation template file you want to use to create the stack.
- `-parameters`: A list of parameters you want to pass to the CloudFormation template. In this example, we are passing a parameter named `BucketName` with a value of `my-bucket-name`.
- `-region`: The AWS region in which you want to create the stack.

**[Join Medium with my referral link - Haimo ZhangRead every story from Haimo Zhang (and thousands of other writers on Medium). Your membership fee directly supports…**
medium.com](https://medium.com/@zhaimo/membership)

# (2). Setting Up and Use Terraform

Terraform
 is an open-source tool that allows you to manage your infrastructure as
 code. Here are the steps required to set up Terraform:

**Step 1: Install Terraform**

First verify AWS CLI configured correctly.

Run this command to install terraform.

```
%brew tap hashicorp/tap
%brew install hashicorp/tap/terraform
```

**Step 2: Write a Terraform configuration file.**

1. Create a new directory for Terraform configuration files.
2. Create a new file named **main.tf** in the directory and add the code to describe the AWS resources you want to provision.

Here’s an example of a simple Terraform file that creates an Amazon S3 bucket:

```
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-bucket-name"
}
```

**Step 3: Initialize Terraform**

Before you can run Terraform, you need to initialize your Terraform working directory. To do this, follow these steps:

1. Change to the directory where you saved your Terraform configuration files.
2. Run the following command to initialize Terraform:

```
%terraform init
```

This command will download any necessary plugins and initialize the backend that Terraform will use to store state.

**Step 4: Preview Changes with Terraform Plan**

To preview the changes that Terraform will make to your infrastructure, run the following command:

```
%terraform plan
```

This
 will show you a preview of the changes that Terraform will make to your
 infrastructure based on the configuration files you have written. If 
there are any errors or warnings, Terraform will display them here.

**Step 5: Apply Changes with Terraform Apply**

Once you have previewed the changes and are ready to apply them to your infrastructure, run the following command:

```
%terraform apply
```

This
 will create or update the resources described in your Terraform 
configuration files. Terraform will prompt you to confirm the changes 
before applying them.

# (3). Setting Up AWS CDK

The
 AWS Cloud Development Kit (CDK) is an open-source software development 
framework to define cloud infrastructure in code and provision it 
through AWS CloudFormation. Here are the steps required to set up AWS 
CDK:

**Step 1: Install AWS CDK**

First verify AWS CLI configured correctly.

Run this command in terminal.

```
 %sudo npm install -g aws-cdk
```

**Step 2: Create an AWS CDK App**

To create an AWS CDK app, follow these steps:

1. Create a new directory for your AWS CDK app.
2. In the directory run the following command to initialize a new AWS CDK app:

```
%cdk init app --language typescript
```

This will create a new AWS CDK app. The `app.ts` file in the `lib` directory is where you will write the code to define your infrastructure.

**Step 3: Define Infrastructure**

To define your infrastructure using the AWS CDK, follow these steps:

1. Open the `app.ts` file in the `lib` directory of your AWS CDK app.
2. Write the code to define your infrastructure using the AWS CDK constructs.

Here’s an example of a simple AWS CDK app that creates an Amazon S3 bucket:

```
import * as cdk from 'aws-cdk-lib';
import { Stack, StackProps } from 'aws-cdk-lib';
import { Bucket } from 'aws-cdk-lib/aws-s3';

export class MyStack extends Stack {
  constructor(scope: cdk.Construct, id: string, props?: StackProps) {
    super(scope, id, props);

    new Bucket(this, 'MyBucket', {
      bucketName: 'my-bucket-name',
    });
  }
}

const app = new cdk.App();
new MyStack(app, 'MyStack');
```

**Step 4: Deploy Your Infrastructure**

Run the following command to deploy your infrastructure:

```
%cdk deploy
```

This will create the resources described in the AWS CDK app.

# (4). Setting Up AWS SAM

AWS
 Serverless Application Model (SAM) is an open-source framework that 
allows you to build, test, and deploy serverless applications on AWS. 
Here are the steps required to set up and run AWS SAM on a Mac:

**Step 1: Install AWS SAM CLI**

First verify AWS CLI configured correctly.

The
 AWS SAM CLI is a command-line tool that allows you to build, test, and 
deploy your serverless applications. You can install the AWS SAM CLI by 
running the following command in your terminal:

```
%brew install aws-sam-cli
```

Step 2: Create a New AWS SAM Application

1. Create a new directory
2. In the directory, run the following command to create a new AWS SAM application:

```
%sam init --runtime nodejs14.x --name my-sam-app --dependency-manager npm
```

This then prompt you with a menu of options, this is what I chose and the output.

```
% sam init --runtime nodejs14.x --name my-sam-app --dependency-manager npm

Which template source would you like to use?
 1 - AWS Quick Start Templates
 2 - Custom Template Location
Choice: 1

Choose an AWS Quick Start application template
 1 - Hello World Example
 2 - Multi-step workflow
 3 - Standalone function
 4 - Scheduled task
 5 - Data processing
 6 - Serverless API
 7 - Serverless Connector Hello World Example
 8 - Multi-step workflow with Connectors
Template: 1

Based on your selections, the only Package type available is Zip.
We will proceed to selecting the Package type as Zip.

Select your starter template
 1 - Hello World Example
 2 - Hello World Example TypeScript
 3 - Hello World Example TypeScript w/ Lambda Powertools
Template: 1

Would you like to enable X-Ray tracing on the function(s) in your application?  [y/N]: n

Would you like to enable monitoring using CloudWatch Application Insights?
For more info, please view https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch-application-insights.html [y/N]: n

Cloning from https://github.com/aws/aws-sam-cli-app-templates (process may take a moment)

    -----------------------
    Generating application:
    -----------------------
    Name: my-sam-app
    Runtime: nodejs14.x
    Architectures: x86_64
    Dependency Manager: npm
    Application Template: hello-world
    Output Directory: .
    Configuration file: my-sam-app/samconfig.toml

    Next steps can be found in the README file at my-sam-app/README.md

Commands you can use next
=========================
[*] Create pipeline: cd my-sam-app && sam pipeline init --bootstrap
[*] Validate SAM template: cd my-sam-app && sam validate
[*] Test Function in the Cloud: cd my-sam-app && sam sync --stack-name {stack-name} --watch
```

This will create a new AWS SAM application with a sample serverless function in the hello-world directory.

Step 3: Build and Test Your AWS SAM Application

To build and test your AWS SAM application, follow these steps:

1. Navigate to the directory of your AWS SAM application.
2. Run the following command to build your AWS SAM application:

```
%sam build
```

This will build your AWS SAM application and create an `.aws-sam` directory in your project directory.

Step 4: Deploy Your AWS SAM Application

To deploy your AWS SAM application, follow these steps:

1. Navigate to the directory of your AWS SAM application.
2. Run the following command to deploy your AWS SAM application:

```
%sam deploy --guided
```

This
 will deploy your AWS SAM application to AWS. The `— guided` option will
 guide you through the deployment process and prompt you to enter the 
necessary parameters, such as the AWS region and stack name.

Once
 the deployment is complete, you can access your serverless function on 
AWS using the API Gateway endpoint URL that is provided as output.

# Conclusion

In
 this blog, we have provided a step-by-step guide on how to set up your 
local environment and AWS for running CloudFormation, Terraform, AWS CDK
 and SAM. By following these steps, you will be able to efficiently 
develop, test, and deploy your code on AWS. Remember to always keep your
 infrastructure code under version control and follow best practices to 
ensure security and reliability.