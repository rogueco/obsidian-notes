# ASP.NET Core Serverless Web API running in AWS Lambda, using API Gateway HTTP API, with a Lambda Warmer

Article Link: https://michaeldimoudis.medium.com/asp-net-core-serverless-web-api-running-in-aws-lambda-using-api-gateway-http-api-a-lambdawarmer-6d31cdd6d3f5
Date Added: March 21, 2021 9:44 PM
Tag: .NET, AWS, Lambda, Serverless, Tutorial

Back in April 2019 I [blogged](https://medium.com/@michaeldimoudis/asp-net-core-2-2-3-0-serverless-web-apis-in-aws-lambda-with-a-custom-runtime-and-lambda-warmer-ce19ce2e2c74) about running an ASP.NET Core 2.2/3.0 Serverless Web API in AWS Lambda with a Custom Runtime and Lambda Warmer.

Things have changed since then; [AWS Lambda now supports .NET Core 3.1](https://aws.amazon.com/blogs/compute/announcing-aws-lambda-supports-for-net-core-3-1/) (custom runtime no longer required) and AWS released [HTTP APIs for Amazon API Gateway](https://aws.amazon.com/blogs/compute/announcing-http-apis-for-amazon-api-gateway/) which GA’d in March 2020.

Both announcements are huge for .NET developers wanting to host an ASP.NET Core Web API in the cloud, serverless and cheap. HTTP APIs for Amazon API Gateway offer up to 71% cost savings and 60% latency reduction compared to REST APIs. If you do not need the more advanced features a REST API gives you, it makes a lot of sense to use the new HTTP APIs for API Gateway.

I will keep this blog very concise, all the code to deploy this serverless Web API with 1 line of code is in [this sample GitHub repo](https://github.com/michaeldimoudis/aspnetcore-lambda-httpapi-serverless).

The only code change required to support HTTP APIs for Amazon API Gateway is updating the base class in the `LambdaEntryPoint` to `APIGatewayHttpApiV2ProxyFunction`.

Regarding the CloudFormation template file, `serverless.template`, the change required there is to change the `Events` in `AWS::Serverless::Function` from `Api` to `HttpApi`. I have also extended the built in template to add an API Gateway Domain Name with a mapping, including updating Route53 with the A alias record for your API’s domain name. This will allow you to serve the API off your own domain name.

Simply specifying `DomainName`, `CertificateArn`, and Route53 `HostedZoneId` in `aws-lambda-tools-defaults.json`, and then running `dotnet lambda deploy-serverless` will spin up the entire infrastructure (HTTP API for Amazon API Gateway / Lambda) and an ASP.NET Core Web API in minutes, ready to serve requests in a serverless and scalable way.

As a bonus I updated the Lambda Warmer in my previous blog post to work with the new API Gateway HTTP APIs, doing an effective job in forgoing cold starts by specifying the number of instances you want to keep warm.

A CodeBuild `buildspec.yaml` file is also provided to deploy this out. I recommend choosing the `aws/codebuild/amazonlinux2-x86_64-standard:3.0` environment image, as `PublishReadyToRun` is set to `true` to further improve the performance of the API.

Once deployed just hit the API endpoint `https://api.mydomain.com/api/values` to make sure it’s all working. (remember to use your own domain name)

[https://github.com/michaeldimoudis/aspnetcore-lambda-httpapi-serverless](https://github.com/michaeldimoudis/aspnetcore-lambda-httpapi-serverless)

More in depth reading about .NET Core 3.1 in Lambda and API Gateway HTTP APIs can be found at:

- [One Month Update to .NET Core 3.1 Lambda](https://aws.amazon.com/blogs/developer/one-month-update-to-net-core-3-1-lambda/)
- [A Close Look At .NET Core 3.1 on AWS Lambda](https://medium.com/@zaccharles/a-close-look-at-net-core-3-1-on-aws-lambda-9ccec4dd96be)
- [Announcing HTTP APIs for Amazon API Gateway](https://aws.amazon.com/blogs/compute/announcing-http-apis-for-amazon-api-gateway/)
- [Review: API Gateway HTTP APIs — Cheaper and Faster REST APIs?](https://cloudonaut.io/review-api-gateway-http-apis/)