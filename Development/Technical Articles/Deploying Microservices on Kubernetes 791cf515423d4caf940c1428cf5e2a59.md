# Deploying Microservices on Kubernetes

Article Link: https://medium.com/aspnetrun/deploying-microservices-on-kubernetes-35296d369fdb
Author: Mehmet Özkaya
Date Added: August 26, 2021 3:57 PM
Tag: .NET, DevOps, Microservices

In this article, we are going to Deploy our Shopping Microservices on Kubernetes. Kubernetes retrieve microservices images from DockerHub.

![https://miro.medium.com/max/1400/1*2WHIbwc-NX9uATWKmEaJGA.png](https://miro.medium.com/max/1400/1*2WHIbwc-NX9uATWKmEaJGA.png)

See the overall picture. As you can see that, we have created docker images for our microservices. Also we compose docker containers and tested them.So now, we are going to deploy these docker container images on **Kubernetes** clusters.We are going to deploy local Kubernetes so for that reason we will use **Docker Kubernetes cluster** in order to use Kubernetes features in docker.It is the easiest way to run Kubernetes on local environment.

We will develop Kubenernetes manifest yamls files for Shopping Client — API and mongoDb.We will create deployment and service yamls and also configMap and secret definitions for storing database related parameters.

# **Background**

This is the second article of the series. You can follow the series with below links.

- **[0- Deploying .Net Microservices](https://mehmetozkaya.medium.com/deploying-net-microservices-to-azure-kubernetes-services-aks-and-automating-with-azure-devops-c50bdd51b702)**
- **[1- Preparing Multi-Container Microservices Applications for Deployment](https://mehmetozkaya.medium.com/preparing-multi-container-microservices-applications-for-deployment-793d60f48d31)**
- **[2- Deploying Microservices on Kubernetes](https://mehmetozkaya.medium.com/deploying-microservices-on-kubernetes-35296d369fdb)**
- **[3- Deploy Microservices into Cloud Azure Kubernetes Service (AKS) with using Azure Container Registry (ACR)](https://mehmetozkaya.medium.com/deploy-microservices-into-cloud-azure-kubernetes-service-aks-with-using-azure-container-registry-b661698610b1)**
- **[4- Automate Deployments with CI/CD pipelines on Azure Devops](https://mehmetozkaya.medium.com/automate-deployments-with-ci-cd-pipelines-on-azure-devops-13a83d3dd67a)**

# **Source Code**

**[Get the Source Code from AspnetRun Microservices Github](https://github.com/mehmetozkaya/swnzen)** — Clone or fork this repository, if you like don’t forget the star :) If you find or ask anything you can directly open issue on repository.

# **Introduction to Kubernetes**

Before we start to deploy microservices on Kubernetes, we are going to give introduction about Kubernetes.We will talk about What Kubernetes is and why we should use Kubernetes for deploying microservices.

![https://miro.medium.com/max/1400/1*6vb9LwyU5PpbSCw2B_RD9A.png](https://miro.medium.com/max/1400/1*6vb9LwyU5PpbSCw2B_RD9A.png)

Also we will talk about kubernetes components and general architecture of operations. We will discuss minimum manifest definitions for deploying microservices, we will talk about **deployments, replicasets, pods, services** and so on. We will install kubernetes on our local machine. And see main kubectl commands that can create kubernetes resources. Give some information about K8s yaml configuration files.

## **What is Kubernetes ?**

Kubernetes (also known as k8s or “kube”) is an open source container orchestration platform that automates many of the manual processes involved in deploying, managing, and scaling containerized applications.

![https://miro.medium.com/max/1400/1*ACDQ0zG8Yo_bpw5zrS4W3Q.png](https://miro.medium.com/max/1400/1*ACDQ0zG8Yo_bpw5zrS4W3Q.png)

Kubernetes is a portable, extensible, open-source platform for managing containerized workloads and services, that facilitates both declarative configuration and automation. It has a large, rapidly growing ecosystem. Kubernetes services, support, and tools are widely available.

You can cluster together groups of hosts running Linux containers, and Kubernetes helps you easily and efficiently manage those clusters.

## **Kubernetes Components**

we are going to talk about Kubernetes Components like **deployment, replicaset, pod, service, configmap** and so on.We will explain most basics of components that we can use and deploy our microservice to the k8s.

**Pods**Pods are the smallest deployable units of computing that you can create and manage in Kubernetes.A Pod is a group of one or more containers, with shared storage/network resources, and a specification for how to run the containers.So we can say that pods stores and manage our docker containers.

**ReplicaSet**A ReplicaSet’s purpose is to maintain a stable set of replica Pods running at any given time. For example, it is often used to guarantee the availability of a specified number of identical Pods.

**Deployments**A Deployment provides declarative updates for Pods and ReplicaSets.

You describe a desired state in a Deployment, and the Deployment Controller changes the actual state to the desired state at a controlled rate.You can define Deployments to create new ReplicaSets, or to remove existing Deployments and adopt all their resources with new Deployments.

![https://miro.medium.com/max/1190/1*yp8HTZE99LM4p_7F-VzgHw.png](https://miro.medium.com/max/1190/1*yp8HTZE99LM4p_7F-VzgHw.png)

So we can say that Deployments are an abstraction of ReplicaSets, and ReplicaSets are an abstaction of Pods. So Pods should not created directly, if needed, Deployment objects should be created and the rest operation will handle by k8s with creating replicaset and pods automaticly.

**Service**An abstract way to expose an application running on a set of Pods as a network service. With Kubernetes you don’t need to modify your application to use an unfamiliar service discovery mechanism.Kubernetes gives Pods their own IP addresses and a single DNS name for a set of Pods, and can load-balance across them.**ConfigMaps**A ConfigMap is an API object used to store non-confidential data in key-value pairs. Pods can consume ConfigMaps as environment variables, command-line arguments, or as configuration files in a volume.

**Secrets**Kubernetes Secrets let you store and manage sensitive information, such as passwords, OAuth tokens, and ssh keys. Storing confidential information in a Secret is safer and more flexible than putting it verbatim in a Pod definition or in a container image.

## **Local Kubernetes Installment**

We are going to install and run Kubernetes on local environment.There are few options to run kubernetes on local like minikube, docker kubernetes and so on. We will follow the docker kubernetes installation.

We should go to Docker Settings

- Docker support of KubernetesGo to Docker SettingsKubernetes sectionEnable Kubernetes

## **Declarative vs Imperative**

We are going to talk about Declarative vs Imperative.

![https://miro.medium.com/max/1400/1*Hyx2Li8VgvHkEMwcpzo_1g.png](https://miro.medium.com/max/1400/1*Hyx2Li8VgvHkEMwcpzo_1g.png)

There are two basic ways to deploy to Kubernetes: imperatively, which is working on CLI with kubectl commands, or declaratively, by writing manifests and using kubectl apply.Kubernetes able to run both Declarative and Imperative way.

**Imperative Configuration**The shortest way to deploy to Kubernetes is to use the kubectl run command.It said that run myapp with some image with 2 replicas, now!

**kubectl run myapp — image myrepo:mytag — replicas 2**

**Declarative Configuration**The power of Kubernetes is in its declarative API and controllers.You can just tell Kubernetes what you want, and it will know what to do.

**kubectl apply –f app.yaml**

You’ll just use kubectl apply and YAML (or JSON) manifests of the state to be saved by Kubernetes in etcd.Impritive — DeclarativeImpritive Commands

**kubectl run [container_name] — image=[image_name]kubectl port-forward [pod] [ports]**

**kubectl create [resource]kubectl apply [resource] — create or modify resources**

So we will start with Imperative way of kubernetes commands. After that show how we can work with yaml files.

# **Create Mongo Db Deployment yaml File**

We are going to Create Mongo Db Deployment yaml File.

Before we start, lets Check Mongo DockerHub Page

Check Mongo DockerHub Page :[https://hub.docker.com/_/mongo](https://hub.docker.com/_/mongo)

- See Env Variablesmongo:image: mongorestart: alwaysenvironment:MONGO_INITDB_ROOT_USERNAME: rootMONGO_INITDB_ROOT_PASSWORD: example

We will use these environment variables for activate mongodb.**Add New file -> mongo.yaml**

```
mongo.yamlapiVersion: apps/v1
kind: Deployment
metadata:
 name: mongo-deployment
 labels:
 app: mongodb
spec:
 replicas: 1
 selector:
 matchLabels:
 app: mongodb
 template:
 metadata:
 labels:
 app: mongodb
 spec:
 containers:
 — name: mongodb
 image: mongo
 ports:
 — containerPort: 27017
 env:
 — name: MONGO_INITDB_ROOT_USERNAME
 value:
 — name: MONGO_INITDB_ROOT_PASSWORD
 value:
 —
 — For username — password environment variables, its good to create secret definition on k8s.
```

## **Use K8s Secret Values in Mongo Deployment yaml file**

We are going to Use kubernetes Secret Values in Mongo Deployment yaml file.As you know that we didnt finish the mongo deployment yaml. Now we can able to set mongo username and password.

— So now, our mongo deployment yaml referenced to secret;

```
apiVersion: apps/v1
kind: Deployment
metadata:
 name: mongo-deployment
 labels:
 app: mongodb
spec:
 replicas: 1
 selector:
 matchLabels:
 app: mongodb
 template:
 metadata:
 labels:
 app: mongodb
 spec:
 containers:
 — name: mongodb
 image: mongo
 ports:
 — containerPort: 27017
 resources:
 requests:
 memory: “64Mi”
 cpu: “250m”
 limits:
 memory: “128Mi”
 cpu: “500m”
 env:
 — name: MONGO_INITDB_ROOT_USERNAME
 valueFrom:
 secretKeyRef:
 name: mongo-secret
 key: mongo-root-username
 — name: MONGO_INITDB_ROOT_PASSWORD
 valueFrom:
 secretKeyRef:
 name: mongo-secret
 key: mongo-root-password
```

— As you can see that we have used valueFrom and secretKeyRef in order to access secret data.K8s manage our data with these definitions.

## **Run Kubernetes Manifest File**

We are ready to create

**kubectl apply -f .\mongo.yaml**

```
PS C:\Users\ezozkme\source\repos\swnzen\k8s> kubectl apply -f .\mongo.yaml
 deployment.apps/mongo-deployment created
 PS C:\Users\ezozkme\source\repos\swnzen\k8s> kubectl get all
```

Watch pods

**kubectl get pod — watchkubectl describe pod mongo-deployment-9c5b4dddb-lps5h**

SUCCESS !!

We finally created mongo db pods with username-password secret protection.

## **Build Shopping Docker Images , Tag and Push to Docker Hub**

We are going to Build Shopping Docker Images , Tag and Push to Docker Hub.As you know that in the last section we have finished mongodb k8s yaml definitions. For mongodb, k8s pull the official mongo docker hub image.But shopping images not exits on dockerhub yet.For that reason, before writing k8s yaml file for Shopping projects, we should create docker images, tag them and push to docker hub.By this way, k8s retrieves images from the docker hub.

run docker-compose

**run = docker-compose -f docker-compose.yml -f docker-compose.override.yml up -dstop = docker-compose -f docker-compose.yml -f docker-compose.override.yml down**

```
docker ps

PS C:\Users\ezozkme\source\repos\swnzen\swnzen> docker ps
CONTAINER ID IMAGE COMMAND CREATED STATUS PORTS NAMES
ed664082a27f shoppingclient “dotnet Shopping.Cli…” 7 seconds ago Up 5 seconds 443/tcp, 0.0.0.0:8001->80/tcp shoppingclient
f0a20a1e9467 shoppingapi “dotnet Shopping.API…” 7 seconds ago Up 6 seconds 443/tcp, 0.0.0.0:8000->80/tcp shoppingapi
507ece34b2f0 mongo “docker-entrypoint.s…” 8 seconds ago Up 6 seconds 0.0.0.0:27017->27017/tcp shoppingdb
```

TEST[http://localhost:8000/swagger/index.html](http://localhost:8000/swagger/index.html)[http://localhost:8001/](http://localhost:8001/)

- see imagesdocker images

```
shoppingclient latest 3fa4c59328fd 9 minutes ago 210MB
 shoppingapi latest 054137853823 10 minutes ago 215MB
```

latest tag images created.

We will Tag images and push to dockerhub.

Tag the lastest one with dockerhub repo name

**docker tag 3fa mehmetozkaya/shoppingclient**

**docker tag 054 mehmetozkaya/shoppingapi**docker images

```
 shoppingclient latest 3fa4c59328fd 12 minutes ago 210MB
 mehmetozkaya/shoppingclient latest 3fa4c59328fd 12 minutes ago 210MB
 shoppingapi latest 054137853823 12 minutes ago 215MB
 mehmetozkaya/shoppingapi latest 054137853823 12 minutes ago 215MB
```

see its tagged.

Push Docker Hub

```
docker push mehmetozkaya/shoppingclientdocker push mehmetozkaya/shoppingapiThe push refers to repository [docker.io/mehmetozkaya/shoppingclient]
 b57cdc9e8ec8: Pushed
 d066a90a6a65: Pushed
 024230939f4e: Pushed
 ea4124eb3c7e: Pushed
 8ed87ee178f4: Pushing [======================================> ] 58.3MB/75.66MB
 0916aa79e133: Pushing [==================================> ] 28.54MB/41.33MB
 87c8a1d8f54f: Pushing [====================> ] 28.68MB/69.23MB
```

See DockerHub

- mehmetozkaya/shoppingclientmehmetozkaya/shoppingapiLast pushed: 12 minutes ago

## **Create Shopping.API k8s Deployment and Service yaml File**

We are going to create Shopping.API k8s Deployment yaml File.

Create New File under k8s

```
shoppingapi.yamlWrite Deployment and ServiceapiVersion: apps/v1
kind: Deployment
metadata:
 name: shoppingapi-deployment
 labels:
 app: shoppingapi
spec:
 replicas: 1
 selector:
 matchLabels:
 app: shoppingapi
 template:
 metadata:
 labels:
 app: shoppingapi
 spec:
 containers:
 — name: shoppingapi
 image: mehmetozkaya/shoppingapi:latest
 imagePullPolicy: IfNotPresent
 ports:
 — containerPort: 80
 env:
 — name: ASPNETCORE_ENVIRONMENT
 value: Development
 — name: DatabaseSettings__ConnectionString
 value: mongo-service
 resources:
 requests:
 memory: “64Mi”
 cpu: “250m”
 limits:
 memory: “128Mi”
 cpu: “500m”
 — -
apiVersion: v1
kind: Service
metadata:
 name: shoppingapi-service
spec:
 type: NodePort — ADDED TESTING PURPOSE
 selector:
 app: shoppingapi
 ports:
 — protocol: TCP
 port: 8000
 targetPort: 80
 nodePort: 31000 — ADDED TESTING PURPOSE
```

In order to add test our API we set the service as a nodeport.So now we can run our shoppingapi yaml file on k8s.

## **Create Shopping.Client K8s Deployment and Service yaml File**

We are going to Create Shopping.Client K8s Deployment and Service yaml File.

Create New File under k8s

```
shoppingclient.yamlapiVersion: apps/v1
kind: Deployment
metadata:
 name: shoppingclient-deployment
 labels:
 app: shoppingclient
spec:
 replicas: 1
 selector:
 matchLabels:
 app: shoppingclient
 template:
 metadata:
 labels:
 app: shoppingclient
 spec:
 containers:
 — name: shoppingclient
 image: mehmetozkaya/shoppingclient:latest
 imagePullPolicy: IfNotPresent
 ports:
 — containerPort: 80
 env:
 — name: ASPNETCORE_ENVIRONMENT
 value: Development
 — name: ShoppingAPIUrl
 valueFrom:
 configMapKeyRef:
 name: shoppingapi-configmap
 key: shoppingapi_url
 resources:
 requests:
 memory: “64Mi”
 cpu: “250m”
 limits:
 memory: “128Mi”
 cpu: “500m”
 — -
apiVersion: v1
kind: Service
metadata:
 name: shoppingclient-service
spec:
 type: LoadBalancer
 selector:
 app: shoppingclient
 ports:
 — protocol: TCP
 port: 8001
 targetPort: 80
 nodePort: 30000
```

As you can see we create LoadBalancer for external access.

Run apply k8s command;

**kubectl apply -f shoppingclient.yaml**

Check**kubectl get allkubectl get pod — watch**

created!

**kubectl get service**

```
NAME TYPE CLUSTER-IP EXTERNAL-IP PORT(S) AGE
kubernetes ClusterIP 10.96.0.1 <none> 443/TCP 29d
mongo-service ClusterIP 10.110.82.16 <none> 27017/TCP 5h12m
shoppingapi-service NodePort 10.104.209.228 <none> 8000:31000/TCP 113m
shoppingclient-service LoadBalancer 10.107.145.225 localhost 8001:30000/TCP 85s
```

TEST:

[http://localhost:30000](http://localhost:30000/)

As you can see that, we have finally deploy our microservices into local Kubernetes environment. Next article we are going to deploy microservices into Azure Kubernetes Services (AKS) with using Azure Container Registry (ACR).

For the next articles ->

- **[3- Deploy Microservices into Cloud Azure Kubernetes Service (AKS) with using Azure Container Registry (ACR)](https://mehmetozkaya.medium.com/deploy-microservices-into-cloud-azure-kubernetes-service-aks-with-using-azure-container-registry-b661698610b1)**