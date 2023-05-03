# Install AWS Command Line Interface (CLI) on Ubuntu

Article Link: https://medium.com/codex/install-aws-command-line-interface-cli-on-ubuntu-491383f93813
Author: Bharathiraja
Date Added: April 13, 2023 2:31 PM
Tag: AWS, Terraform, Ubuntu

In this tutorial, we are going to see how to install the AWS CLI on Ubuntu. And how to configure credentials?. Configuring the AWS credentials is needed when we do some activity using AWS CLI. Especially if you want to launch the EKS instance or want to push the Docker image to ECR, then we must need AWS CLI credentials. Please pay more attention to this. Why because we are enabling some security permissions. So, enable only needed permissions. For the demonstration purpose, I enabled the Admin Access policy.

In this tutorial, we will do the following activity.

1. Install AWS CLI on Ubuntu.

2. Create IAM credentials

3. Configure IAM credentials on Ubuntu(Local machine).

Let’s see them one by one.

# **Install AWS CLI on Ubuntu:**

The latest AWS CLI version is 2. So download the AWS CLI.

```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
```

Unzip the file using the following command.

```
unzip awscliv2.zip
```

Install the AWS CLI using the following command.

```
sudo ./aws/install
```

That’s all. AWS CLI is installed successfully on Ubuntu.

We can get the AWS CLI version using the below command.

```
aws --version
```

The above command will return cli version 2 if the installation is successful.

# **Create IAM Credentials:**

To configure the AWS CLI, we need an access key and access secret. We will create a new IAM user and get the access key. If you had an existing user then create a new access key under the security credentials section.

![https://miro.medium.com/v2/resize:fit:700/1*goc9p62eKmK1aKhM7RL3nQ.png](https://miro.medium.com/v2/resize:fit:700/1*goc9p62eKmK1aKhM7RL3nQ.png)

AWS Security Credentials

If you don’t have any users, then log in to the AWS web console. And go to the IAM section.

![https://miro.medium.com/v2/resize:fit:700/1*iGywQLdprHZJwoMSNumw7A.png](https://miro.medium.com/v2/resize:fit:700/1*iGywQLdprHZJwoMSNumw7A.png)

Search AWS IAM

Click the users and click the Add User button on the next page.

![https://miro.medium.com/v2/resize:fit:700/1*O_k8X-S9HbZB9EQIMIUhog.png](https://miro.medium.com/v2/resize:fit:700/1*O_k8X-S9HbZB9EQIMIUhog.png)

List of IAM Users

![https://miro.medium.com/v2/resize:fit:576/1*VnCWVHFvEdPoTecmuIRtGA.png](https://miro.medium.com/v2/resize:fit:576/1*VnCWVHFvEdPoTecmuIRtGA.png)

Add IAM User

Give a username and tick the Programmatic Access checkbox. And click the Permissions button.

![https://miro.medium.com/v2/resize:fit:700/1*-7QqKunHFydK2eNEGKWRAg.png](https://miro.medium.com/v2/resize:fit:700/1*-7QqKunHFydK2eNEGKWRAg.png)

User Creation With Programmatic Access

Here you can attach policies directly to the user. Here I chose the admin access policy. If you already created any group, you can attach the group. Click the Tags button.

![https://miro.medium.com/v2/resize:fit:700/1*RTK37o2cU5v-zdSiGhK8Dg.png](https://miro.medium.com/v2/resize:fit:700/1*RTK37o2cU5v-zdSiGhK8Dg.png)

Give Security Permission

Add a tag if you want or skip to the next section by clicking the Preview button.

![https://miro.medium.com/v2/resize:fit:700/1*6SeSuGKXVhokVrk9e4ihXQ.png](https://miro.medium.com/v2/resize:fit:700/1*6SeSuGKXVhokVrk9e4ihXQ.png)

Add Tags

Review the given information and click the Create User button.

![https://miro.medium.com/v2/resize:fit:700/1*hcanfzegw7DXXfFkcfSycg.png](https://miro.medium.com/v2/resize:fit:700/1*hcanfzegw7DXXfFkcfSycg.png)

Create User

Now the user is created and it will show the access key and secret. Download the CSV file for later use.

![https://miro.medium.com/v2/resize:fit:700/1*l0e7LMX72Jg-IwZE_MhmCA.png](https://miro.medium.com/v2/resize:fit:700/1*l0e7LMX72Jg-IwZE_MhmCA.png)

Access Key and Secret Access of IAM User

# **Configure IAM Credentials:**

Go to the terminal on Ubuntu and type the below command to configure the access key and secret. Use the access key and secret access from the downloaded CSV file.

```
aws configure
```

1. Enter AWS Access Key ID.
2. Enter AWS Secret Access Key.
3. Enter Default region name( like eu-central, us-east etc.).
4. Enter Default output format. Allowed formats are ***json, yaml, text, and table***.

# **Check Credentials Working or Not:**

Use the below command to get the list of EC2 instances on your account.

```
aws ec2 describe-instances
```

Get the list of light sail server details.

```
aws lightsail get-bundles
```

Get the S3 bucket list.

```
aws s3 ls
```

If the credentials are configured correctly then the above commands will return corresponding details.

# **Delete Credentials:**

Use the following command to delete the credentials.

```
aws iam delete-access-key --access-key-id your_key --user-name your_username#Exampleaws iam delete-access-key --access-key-id AKI8900IN --user-name bob
```

# **Summary:**

In this tutorial, we learned how to install and configure AWS CLI. In the forthcoming article, I planned to write about how to create an EKS cluster on AWS. For that, we need AWS credentials. This article will help beginners to set up AWS CLI and configure credentials.

Stay tuned for more articles.

Thank you for reading.