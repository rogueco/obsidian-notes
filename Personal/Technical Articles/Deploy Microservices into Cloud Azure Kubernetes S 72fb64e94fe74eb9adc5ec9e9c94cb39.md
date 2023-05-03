# Deploy Microservices into Cloud Azure Kubernetes Service (AKS) with using Azure Container Registry (ACR)

Article Link: https://medium.com/aspnetrun/deploy-microservices-into-cloud-azure-kubernetes-service-aks-with-using-azure-container-registry-b661698610b1
Author: Mehmet Özkaya
Date Added: August 26, 2021 3:58 PM
Tag: .NET, DevOps, Kubernetes, Microservices

In this article, we are going to Deploy Shopping Microservices into Cloud Azure Kubernetes Service (AKS) with using Azure Container Registry (ACR).

![https://miro.medium.com/max/1400/1*2WHIbwc-NX9uATWKmEaJGA.png](https://miro.medium.com/max/1400/1*2WHIbwc-NX9uATWKmEaJGA.png)

See the overall picture. As you can see that, we have finished to development and deployments of our microservices on local environment also test it.Both Docker and Kubernetes deployments were in our local environment.So now its time to move Kubernetes to the cloud one which is **Azure Kubernetes Service (AKS).**

But before that we will talk about what is **Azure Container Registry (ACR)** and **Azure Kubernetes Service (AKS)** and why we are using them. Let’s get some information about **ACR** and **AKS**.

# **Background**

This is the third article of the series. You can follow the series with below links.

- **[0- Deploying .Net Microservices](https://mehmetozkaya.medium.com/deploying-net-microservices-to-azure-kubernetes-services-aks-and-automating-with-azure-devops-c50bdd51b702)**
- **[1- Preparing Multi-Container Microservices Applications for Deployment](https://mehmetozkaya.medium.com/preparing-multi-container-microservices-applications-for-deployment-793d60f48d31)**
- **[2- Deploying Microservices on Kubernetes](https://mehmetozkaya.medium.com/deploying-microservices-on-kubernetes-35296d369fdb)**
- **[3- Deploy Microservices into Cloud Azure Kubernetes Service (AKS) with using Azure Container Registry (ACR)](https://mehmetozkaya.medium.com/deploy-microservices-into-cloud-azure-kubernetes-service-aks-with-using-azure-container-registry-b661698610b1)**
- **[4- Automate Deployments with CI/CD pipelines on Azure Devops](https://mehmetozkaya.medium.com/automate-deployments-with-ci-cd-pipelines-on-azure-devops-13a83d3dd67a)**

# **Source Code**

**[Get the Source Code from AspnetRun Microservices Github](https://github.com/mehmetozkaya/swnzen)** — Clone or fork this repository, if you like don’t forget the star :) If you find or ask anything you can directly open issue on repository.

# **Azure Container Registry (ACR)**

Azure Container Registry is a managed, private Docker registry service based on the open-source Docker Registry. Create and maintain Azure container registries to store and manage your private Docker container images and related artifacts.

![https://miro.medium.com/max/1400/1*BtYb1TAK1Wz4Sr62mq_HtQ.png](https://miro.medium.com/max/1400/1*BtYb1TAK1Wz4Sr62mq_HtQ.png)

If you look at the big picture, we have already finished our local development and dockerize all images.Also we push the docker hub, but this time we will start using ACR for pushing our docker images from dockerhub to ACR private registry.And **ACR** has organic communication with **AKS**, so that’s why we move our images ACR and when we deploy to AKS, Our main target is **deploy our microservices on Cloud kubernetes which is AKS.** AKS will get the images from ACR effectively.

![https://miro.medium.com/max/1400/1*ggU9ElC2z946YOfQOcaoUw.png](https://miro.medium.com/max/1400/1*ggU9ElC2z946YOfQOcaoUw.png)

Example use of ACR Devops Pipeline

You can use Azure container registries with your existing container development and deployment pipelines, or use **Azure Container Registry** Tasks to build container images in Azure. Build on demand, or fully automate builds with triggers such as source code commits and base image updates.

In the image above, you can find an example usage of ACR in a Devops pipeline, we will see this topic in the next article.

# **Azure Kubernetes Service (AKS)**

Azure Kubernetes Service (AKS) makes it simple to deploy a managed Kubernetes cluster in Azure. AKS reduces the complexity and operational overhead of managing Kubernetes by offloading much of that responsibility to Azure.

![https://miro.medium.com/max/1400/1*wxXW9g3tTFsO9R4pgH0v1w.png](https://miro.medium.com/max/1400/1*wxXW9g3tTFsO9R4pgH0v1w.png)

As a managed Kubernetes service, **Azure** handles critical tasks like health monitoring and maintenance for you. The Kubernetes masters are **managed by Azure**. You only manage and maintain the agent nodes. As a managed Kubernetes service, AKS is free plan also I am using free plan for all azure operations.

You can create an **AKS cluster** in the Azure portal, with the **Azure CLI**, or template driven deployment options such as Resource Manager templates and Terraform. We will use the Azure CLI.When you deploy an AKS cluster, the Kubernetes master and all nodes are deployed and configured for you. Additional features such as advanced networking, Azure Active Directory integration, and monitoring can also be configured during the deployment process.

![https://miro.medium.com/max/1400/1*Xd931N2z-r3Is7tLe9BZHA.png](https://miro.medium.com/max/1400/1*Xd931N2z-r3Is7tLe9BZHA.png)

Shifting Local to Cloud

If you look at the image above, In the left side, what we have done so far, we dockerize our images and deploy on local Kubernetes. In the right side is our target cloud deployment items which's are ACR and AKS.We will push image to ACR, and deploy our current Kubernetes configurations into the AKS with pull images from ACR.

# **Steps to the AKS Deployment**

These are the main steps what we are going to follow.

In the first steps we have already done for dockerize our images and deploy on local Kubernetes.So now our target cloud deployment items whichs are ACR and AKS.We will push image to ACR, and deploy our current kubernetes configurations into the AKS with pull images from ACR.

![https://miro.medium.com/max/1400/1*gN4Te3KEwmHqi7VGsOBE5A.png](https://miro.medium.com/max/1400/1*gN4Te3KEwmHqi7VGsOBE5A.png)

Direct Deployment to K8s cluster in ACR

If we expand the details of these steps, we can see this image.As you can see that there is several steps to deploy AKS cluster,1- Build your docker images2- Tag these images according to ACR login name3- Create your ACR in to Azure subscription and protect with admin user and get the loginname , username and password4- Connect to ACR and push your images to ACR5- Create your AKS service into Azure subscription, it will take some time.6- Build communication with AKS and ACR7- Update your k8s manifest files as per AKS deployment, for example change image names docker hub to ACR address.8- Run your k8s config files into AKS cluster.9- Create load balancer service and test your application from cloud AKS deployment.

So as you can see that we have lots of steps that we have to do, but no worries, we will do all steps with together and will verify that our application is running on AKS.

![https://miro.medium.com/max/1400/1*Q-MR7aGVscnijz_P4MrmYg.png](https://miro.medium.com/max/1400/1*Q-MR7aGVscnijz_P4MrmYg.png)

Advance Senario

In this image above, you can see one of the advance real-world example.In the advance scenarios, we can combine ci/cd azure pipelines for pushing images to ACR and deploying to AKS.I am not going details of this picture but We will see details on Azure Devops section.

## **Deploy and use Azure Container Registry**

Azure Container Registry (ACR) is a private registry for container images.A private container registry lets you securely build and deploy your applications and custom code.We are going to deploy an ACR instance and push a container image to it.

- Create an Azure Container Registry (ACR) instance
- Tag a container image for ACR
- Upload the image to ACR
- View images in your registry

After these operations, this ACR instance is integrated with a Kubernetes cluster in AKS, and an application is deployed from the image.

We should understand to how to create resource on Azure. You can use portal or you can use;

Install the Azure CLI[https://docs.microsoft.com/en-us/cli/azure/install-azure-cli](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)[https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli)

Download and Install Azure CLI

## **Create a resource group**

To create an Azure Container Registry, first need a resource group.An Azure resource group is a logical container into which Azure resources are deployed and managed.

Create a resource group with the az group create command.Location could be “westeurope” for us but you can choose your nearest data center for example “eastus”.

```
az group create — name myResourceGroup — location westeurope
```

## **Create an Azure Container Registry**

Create an Azure Container Registry instance with the az acr create command and provide your own registry name.The container registry name must be unique within Azure.Acr name should be global unique.

```
az acr create — resource-group myResourceGroup — name swnzenacr — sku Basic
```

## **Tag a container image**

Now we had a container registry and we can push our images, but first we need tag them.

In order to use shopping containers image with ACR, the image needs to be tagged with the login server address of your registry.This tag is used for routing when pushing container images to an image registry.

```
docker tag shoppingapi:latest swnzenacr.azurecr.io/shoppingapi:v1docker tag shoppingclient:latest swnzenacr.azurecr.io/shoppingclient:v1
```

Check docker images

```
REPOSITORY TAG IMAGE ID CREATED SIZE
<none> <none> b6a015a1206b 19 minutes ago 649MB
shoppingclient latest 384a53ce0484 19 minutes ago 210MB
swnzenacr.azurecr.io/shoppingclient v1 384a53ce0484 19 minutes ago 210MB
shoppingapi latest 61d5a390a952 19 minutes ago 215MB
swnzenacr.azurecr.io/shoppingapi v1
```

Push images to registry

```
docker push swnzenacr.azurecr.io/shoppingapi:v1docker push swnzenacr.azurecr.io/shoppingclient:v1
```

List images in registry

```
az acr repository list — name swnzenacr — output table
```

As you can see that, we have finished to create acr and push our shopping images to the acr.Next step we will create aks and provide to get our images from acr.

## **Deploy an Azure Kubernetes Service (AKS) cluster**

Kubernetes provides a distributed platform for containerized applications.With AKS, you can quickly create a production ready Kubernetes cluster.

We are going to :

- Deploy a Kubernetes AKS cluster that can authenticate to an Azure container registry
- Install the Kubernetes CLI (kubectl)
- Configure kubectl to connect to your AKS cluster

After these operations, our Shopping application is deployed to the cluster, scaled, and updated.

We are going to Create an AKS cluster using az aks create.

We will create a cluster named myAKSCluster in the resource group named myResourceGroup. This resource group was created in the previous section in the westeurope region. For now we don't specify a region so the AKS cluster is also created in the westeurope region.

To allow an AKS cluster to interact with other Azure resources, an Azure Active Directory service principal is automatically created, since you did not specify one.This service principal is granted the right to pull images from the Azure Container Registry (ACR) instance you created in the previous section.So by this way, we only need to specify acr name with — attach-acr command in order to give access to pull images from AKS.

```
az aks create — resource-group myResourceGroup — name myAKSCluster — node-count 1 — generate-ssh-keys — attach-acr swnzenacr
```

After a few minutes, the command completes and returns JSON-formatted information about the cluster.

## **Install the Kubernetes CLI**

In order to connect to the Kubernetes cluster from your local computer, we use kubectl, the Kubernetes command-line client.So we should install kube cli locally using the az aks install-cli command:

```
az aks install-cli
```

## **Connect to cluster using kubectl**

In order to configure kubectl to connect to your Kubernetes cluster, use the az aks get-credentials command.We are going to gets credentials for the AKS cluster named myAKSCluster in the myResourceGroup:

```
az aks get-credentials — resource-group myResourceGroup — name myAKSCluster
```

Now we can verify To verify the connection to your cluster, run the kubectl get nodes command to return a list of the cluster nodes:

Test kubectl

```
kubectl get nodesNAME STATUS ROLES AGE VERSION
aks-nodepool1–12345678–0 Ready agent 32m v1.14.8kubectl get allNAME TYPE CLUSTER-IP EXTERNAL-IP PORT(S) AGE
service/kubernetes ClusterIP 10.0.0.1 <none> 443/TCP 12m
```

As you can see that we have created AKS and connect kubernetes from our local computer with using kubectl commands.

# **Run applications in Azure Kubernetes Service (AKS)**

We have created AKS and now it is ready to run our Shopping microservices on cloud AKS. We are going to build and deploy Shopping applications and services into a AKS Kubernetes cluster.But before that we need to update existing k8s manifest yaml files.

So let me recap, We are going to;

- Update a Kubernetes manifest file
- Run an application in Kubernetes
- Test the application on AKS

After these tasks, we will scaled out and updated to Shopping microservices on AKS.

## **Edit K8s Manifest Yaml Files For Deploying AKS**

We are going to Edit existing K8s Manifest Yaml Files for Deploying AKS.We have created AKS now on Azure Cloud and have created pull secret for ACR.So for now we modify our k8s manifest files according to cloud AKS requirements.Let’s take an action.

First of all, we should replace exiting yaml file images to ACR ones.

```
Go to
shoppingapi.yamlspec:
 containers:
 — name: shoppingapi
 image: mehmetozkaya/shoppingapi:latest — CHANGE — swnzenacr.azurecr.io/shoppingapi:v1
 ..
 imagePullSecrets: — ADDED
 — name: acr-secret — ADDEDGo to
shoppingclient.yamlspec:
 containers:
 — name: shoppingclient
 image: swnzenacr.azurecr.io/shoppingclient:v1
 ..
 imagePullSecrets: — ADDED
 — name: acr-secret — ADDED
```

As you can see that, we have replaced images names as it ACR names.Also add imagePullSecrets configuration into deployment yaml container confugurations in order to allow to pull images.

Now we should also update service definitions

```
Go to
shoppingapi.yamlapiVersion: v1
kind: Service
metadata:
 name: shoppingapi-service
spec:
 type: NodePort — — DELETED
 selector:
 app: shoppingapi
 ports:
 — protocol: TCP
 port: 8000 — — CHANGED 80
 targetPort: 80 — — DELETED
 nodePort: 31000 — — DELETED
```

We are going to deploy AKS on live cloud so we dont need to port-forwarding , every pod take new ip from Cloud AKS.We did it before in order to see in our localhost.Thats why removed targetPort and set port = 80

## **Run K8s Manifest Yaml Files For Deploying AKS**

we are going to run configured K8s Manifest Yaml Files for Deploying AKS.As you know that we have configured k8s manifest files, now its time to run k8s yaml files on Azure AKS and Deploy the application.

Run command

```
kubectl apply -f .\aks
```

Check all resources on aks

```
kubectl get all
 NAME READY STATUS RESTARTS AGE
 pod/mongo-deployment-754d654ff7-s2mcf 1/1 Running 0 56s
 pod/shoppingapi-deployment-64964c4f6c-dxvzj 1/1 Running 0 56s
 pod/shoppingclient-deployment-66fdcffbcd-8gwhf 1/1 Running 0 55sNAME TYPE CLUSTER-IP EXTERNAL-IP PORT(S) AGE
 service/kubernetes ClusterIP 10.0.0.1 <none> 443/TCP 29m
 service/mongo-service ClusterIP 10.0.102.16 <none> 27017/TCP 56s
 service/shoppingapi-service ClusterIP 10.0.79.109 <none> 8000/TCP 56s
 service/shoppingclient-service LoadBalancer 10.0.78.220 20.71.9.224 8001:31498/TCP 55sNAME READY UP-TO-DATE AVAILABLE AGE
 deployment.apps/mongo-deployment 1/1 1 1 56s
 deployment.apps/shoppingapi-deployment 1/1 1 1 56s
 deployment.apps/shoppingclient-deployment 1/1 1 1 56sNAME DESIRED CURRENT READY AGE
 replicaset.apps/mongo-deployment-754d654ff7 1 1 1 56s
 replicaset.apps/shoppingapi-deployment-64964c4f6c 1 1 1 56s
 replicaset.apps/shoppingclient-deployment-66fdcffbcd 1 1 1 55s
 PS C:\Users\ezozkme\source\repos\swnzen>
```

As you can see that, all k8s resources created successfully on AKS.

Once external-ip created, we can test the application.

TEST

FAIL[http://20.71.9.224:80/](http://20.71.9.224/)

SUCCESS !!

Our application on live production now. So now we can scale and deploy new changes with zero-downtime on production. !!

## **Scale Shopping applications in Azure Kubernetes Service (AKS)**

We have a working Kubernetes cluster in AKS and we deployed the Shopping microservices.So now we are going to scale out the pods in the shopping app and try pod autoscaling.

We are going to;

- Scale the Kubernetes nodes
- Manually scale Kubernetes pods that run your application
- Configure autoscaling pods that run the app front-end

You can scale with running below command;

```
kubectl scale — replicas=3 deployment.apps/shoppingclient-deployment
```

Scale with Yaml

Go to aks/shoppingclient.yaml

```
Changespec:
 replicas: 3
```

Run kubectl apply -f ./aks

See pods;

```
kubectl get podmongo-deployment-754d654ff7-bpdp4 1/1 Running 0 81m
shoppingapi-deployment-56599b6f9f-llm6m 1/1 Running 0 81m
shoppingclient-deployment-774bc94c4-jdztz 1/1 Running 0 4m4s
shoppingclient-deployment-774bc94c4-khtxz 1/1 Running 0 81m
shoppingclient-deployment-774bc94c4-r5c2l 1/1 Running 0 13s
```

As you can see that we have scaled our application both manually and using yaml files. But we can go one more step which is auto-scaling with aks.

For the next articles ->

- **[4- Automate Deployments with CI/CD pipelines on Azure Devops](https://mehmetozkaya.medium.com/automate-deployments-with-ci-cd-pipelines-on-azure-devops-13a83d3dd67a)**