# AWS Serverless API - Lambda w/MediatR

Created: March 28, 2021 10:11 PM

# Project Basics

Ok, this project will be deployed as part of a AWS stack which includes

- Api Gateway
- Lambda Function
- DynamoDB
- MySQL

Packages that will be used in here will be

- MediatR

## Pre- Requisites

Install AWS Cli 

Linux - For the latest version of the AWS CLI, use the following command block:

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

Check installation

```bash
aws --version
```

Install AWS Toolkit

```bash
dotnet tool install -g Amazon.Lambda.Tools
```

Install .NET AWS Templates

```bash
dotnet new -i Amazon.Lambda.Templates
```

For Help on each available function

```bash
dotnet new lambda.EmptyFunction --help
```

## Project Init

- `-name` – The name of the function
- `-profile` – The name of a profile in your [AWS SDK for .NET credentials file](https://docs.aws.amazon.com/sdk-for-net/v3/developer-guide/net-dg-config-creds.html)
- `-region` – The AWS Region to create the function in

```bash
dotnet new serverless-application -n projectName
```

This will serve as the basic project structure

Application

```bash
dotnet new classlib -n Application
```

Domain

```bash
dotnet new classlib -n Domain
```

Persistence

```bash
dotnet new classlib -n Persistence
```

# Add References

Add References to the solution

```bash
dotnet sln add Domain/
dotnet sln add Persistence/
dotnet sln add API/
dotnet sln add Application/
```

Application References

```bash
cd Application/
dotnet add reference ../Domain/
dotnet add reference ../Persistence/
```

API References

```bash
cd API/
dotnet add reference ../Application/
```

Persistence References

```bash
cd Persistence/
dotnet add reference ../Domain/
```