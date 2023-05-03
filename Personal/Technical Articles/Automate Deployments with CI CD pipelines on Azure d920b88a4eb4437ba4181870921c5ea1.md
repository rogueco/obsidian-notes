# Automate Deployments with CI/CD pipelines on Azure Devops

Article Link: https://medium.com/aspnetrun/automate-deployments-with-ci-cd-pipelines-on-azure-devops-13a83d3dd67a
Author: Mehmet Özkaya
Date Added: August 26, 2021 4:01 PM

In this article, we are going to Automate our Microservices Deployments with CI/CD pipelines on Azure Devops.

![https://miro.medium.com/max/1400/1*2WHIbwc-NX9uATWKmEaJGA.png](https://miro.medium.com/max/1400/1*2WHIbwc-NX9uATWKmEaJGA.png)

See the overall picture. As you can see that, we have

- Created docker images,
- Compose docker containers and tested them,
- Deploy these docker container images on local kubernetes clusters,
- Push our image to ACR,
- Shifting deployment to the cloud Azure kubernetes services (AKS),
- Update microservices with zero-downtime deployments.

That means we have finished to this box.

So in this article, we are focusing on automation deployments with creating **CI/CD pipelines** on **Azure Devops** tool.Before we start this actions, we should understand what is **Azure Devops** and how to use **pipelines** on Azure Devops.

# **Background**

This is the last article of the series. You can follow the series with below links.

- **[0- Deploying .Net Microservices](https://mehmetozkaya.medium.com/deploying-net-microservices-to-azure-kubernetes-services-aks-and-automating-with-azure-devops-c50bdd51b702)**
- **[1- Preparing Multi-Container Microservices Applications for Deployment](https://mehmetozkaya.medium.com/preparing-multi-container-microservices-applications-for-deployment-793d60f48d31)**
- **[2- Deploying Microservices on Kubernetes](https://mehmetozkaya.medium.com/deploying-microservices-on-kubernetes-35296d369fdb)**
- **[3- Deploy Microservices into Cloud Azure Kubernetes Service (AKS) with using Azure Container Registry (ACR)](https://mehmetozkaya.medium.com/deploy-microservices-into-cloud-azure-kubernetes-service-aks-with-using-azure-container-registry-b661698610b1)**
- **[4- Automate Deployments with CI/CD pipelines on Azure Devops](https://mehmetozkaya.medium.com/automate-deployments-with-ci-cd-pipelines-on-azure-devops-13a83d3dd67a)**

# **Source Code**

**[Get the Source Code from AspnetRun Microservices Github](https://github.com/mehmetozkaya/swnzen)** — Clone or fork this repository, if you like don’t forget the star :) If you find or ask anything you can directly open issue on repository.

# **What is Azure Devops ?**

Azure DevOps provides developer services for support teams to plan work, collaborate on code development, and build and deploy applications.Developers can work in the cloud using **Azure DevOps Services**.**Azure DevOps** provides integrated features that you can access through your web browser or IDE client. We will follow with using web browser.

![https://miro.medium.com/max/1400/1*T6DUwBR_60Eqwiizk_DaUg.png](https://miro.medium.com/max/1400/1*T6DUwBR_60Eqwiizk_DaUg.png)

You can use one or more of the following services based on your business needs:We are going to use Azure pipelines when automate deployment of microservices, but let me explain all services.

**Azure Boards** delivers a suite of Agile tools to support planning and tracking work, code defects, and issues using Kanban and Scrum methods**Azure Repos** provides Git repositories for source control of your code**Azure Pipelines** provides build and release services to support continuous integration and continuous delivery of your apps**Azure Test Plans** provides several tools to test your apps, including manual/exploratory testing and continuous testing**Azure Artifacts** allows teams to share packages such as Maven, npm, NuGet and more from public and private sources and integrate package sharing into your CI/CD pipelines

Also Azure DevOps supports adding extensions and integrating with other popular services,such as: Campfire, Slack, Trello, UserVoice, and more, and developing your own custom extensions.

# **What is Azure Pipelines ?**

Azure Pipeline is a **Continous Integration and Continous Deployment (CI/CD)** tool provided by Azure under Azure DevOps. With Azure Pipelines you can build, test, and deploy your applications across all languages.Azure Pipelines can pull your source code from various repositories and execute a build according to your specifications.

![https://miro.medium.com/max/1400/1*cDePDy4qS8wV514uvJGN7g.png](https://miro.medium.com/max/1400/1*cDePDy4qS8wV514uvJGN7g.png)

Let me give more detail about what is Continous Integration and Continous Deployment (CI/CD) flows;

This flow provide to Automate tests, builds, and delivery.

**Continuous integration** automates tests and builds for your project. CI helps to catch bugs or issues early in the development cycle, when they’re easier and faster to fix. Items known as artifacts are produced from CI systems. They’re used by the continuous delivery release pipelines to drive automatic deployments.

**Continuous delivery** automatically deploys and tests code in multiple stages to help drive quality. Continuous integration systems produce deployable artifacts, which include infrastructure and apps. Automated release pipelines consume these artifacts to release new versions.

![https://miro.medium.com/max/1400/1*gRaaQ-6Jo22DrK5DPM2e2Q.png](https://miro.medium.com/max/1400/1*gRaaQ-6Jo22DrK5DPM2e2Q.png)

We can provide this flows with creating a pipeline on azure pipelines.We will define our pipeline in a YAML file called **azure-pipelines.yml** with for the one application. But of course we will create pipelines as per microservices ci/cd flows.

**Pipelines** are stored with our code, so we will push and commit pipeline yaml files like our code structure on github. By this way, we get validation of your changes through code reviews in pull requests.

Any change to the build process might cause a break or result in an unexpected outcome. Because the change is in version control with the rest of our codebase, we can more easily identify the issue.

# **Deploy to AKS through Azure CI/CD Pipelines**

Our main target is automate deployments of Shopping Microservices into AKS with using **Azure CI/CD Pipelines**. So before we start let’s remember what steps we have done when manually deploying to AKS.

![https://miro.medium.com/max/1400/1*gN4Te3KEwmHqi7VGsOBE5A.png](https://miro.medium.com/max/1400/1*gN4Te3KEwmHqi7VGsOBE5A.png)

As you can see that, we have created docker images for our microservices. Also we compose docker containers and tested them. Deploy these docker container images on local Kubernetes clusters, push our image to **ACR**, shifting deployment to the cloud **Azure Kubernetes Services (AKS)**, update microservices with **zero-downtime** deployments.

So now it is time to check that What steps we are going to do when automate deployments into **AKS** with using **Azure CI/CD Pipelines.**

![https://miro.medium.com/max/1400/1*Rtyh_sEdhxcKBBP3swuf1A.png](https://miro.medium.com/max/1400/1*Rtyh_sEdhxcKBBP3swuf1A.png)

There are several steps we need to go through to set up Azure Pipelines.

- We will develop our project on visual studio.
- Storing our codes on Github Repository.
- Azure pipelines connect and triggering with Git repo changes.
- After that CI/CD pipeline will start according to azure pipeline yaml definitions.
- You can see the building and pushing images to ACR and deploy to AKS.

Here you can find example scenario that explains automation deployments into AKS with using Azure CI/CD Pipelines.

![https://miro.medium.com/max/1400/1*RScqJLabL17D2DjSo3kwVQ.png](https://miro.medium.com/max/1400/1*RScqJLabL17D2DjSo3kwVQ.png)

Whenever we pushed any new code or update any existing code on Github,Azure Pipeline will pull the changes and start the automation.

First, it builds a new version of docker image from docker file which means creating a container image of our application,After this step, pipeline will hit docker push command which will push to your docker image to an azure container registry with new version tag name of image,After that, Azure k8s cluster will pull the image of the application and it creates and run a container from this new image inside of the k8s pods,AKS will perform rollout deployment that pods replace one by one with the new version of image. So end user never effect to these zero-downtime deployments.By this way, we can deploy hundreds of deployment without affecting the system in a day. Also same as the rollback deployments with no effect.

We explained the basics. Now let’s get into action.

## **Sign up for Azure Pipelines**

In order to work with Azure Pipelines we need to create an organization first and then a project inside of the organization.You can Sign up for an Azure DevOps organization and Azure Pipelines to begin managing CI/CD to deploy your code with pipelines.

## **Create Our first pipeline with Azure Pipelines**

In your project, navigate to the Pipelines page. Then choose the action to create a new pipeline.

Give Repo of GitHub — swnzenWe will Walk through the steps of the wizard by first selecting GitHub as the location of your source code.It will redirected to GitHub to sign in. If so, enter your GitHub credentials.When the list of repositories appears, select our Shopping microservices repository.

## **Configure your pipeline**

Select Below template**DockerBuild and push an image to Azure Container Registry**

Basically this task cover our first part of deployment process.We will start with build task, which is docker build and push.also there is Kubernetes deployment which contains Docker Build and Push template, we will see it later when explain deployment stages.

Generating yaml file

See generated yaml file; Examine;

```
# Docker
# Build and push an image to Azure Container Registry
#https://docs.microsoft.com/azure/devops/pipelines/languages/docker — — This is for when start our pipeline definition, that means it starts any changes on main branch of our github repo.
trigger:
- main — — This is default definition of resources
resources:
- repo: self — — Variables are like normal development. You can think this yaml file as a normal code window, we can define variables on top of page and use these variables into task objects.
variables: — — This docker connection is created when we added to task. Let me show you settings — connected services = as you can see that azure pipelines save our connections in here and we use these connections during the pipelines.
 — — Also Azure pipelines created Environment for us, and it will said that these connections related with this environment and we can track deployments on environment seciton. This is very good feauture that you can split your environemnt pipelines like Dev, Staging, production environment.# Container registry service connection established during pipeline creation
 dockerRegistryServiceConnection: ‘b0f7d460–9890–4230–842e-4039178a0031’ — — These ares ACR required parameter in order to push docker images.
 imageRepository: ‘shoppingapi’
 containerRegistry: ‘swnzenacr.azurecr.io’ — — This is docker file path which using for building docker image
 dockerfilePath: ‘$(Build.SourcesDirectory)/swnzen/Shopping.API/Dockerfile’ — — This is for unique tag name. Build is predefined class that we can BuildId or BuildNumber in our pipelines.
 tag: ‘$(Build.BuildId)’

 — — Azure pipeline vm machine image, linux based.
 # Agent VM image name
 vmImageName: ‘ubuntu-latest’ — — Starting Stages, Stages mostly seperating Build and Deploy stages. Into Stages we have jobs, Into jobs we have tasks. It is a tree structure Stage -> Job -> Task
stages:
- stage: Build
 displayName: Build and push stage
 jobs:
 — job: Build
 displayName: Build
 pool:
 vmImage: $(vmImageName)
 steps: — — This is prebuild Azure pipeline task that provide to Build and push an image to container registry. We can examine task and input parameters from official documentation.- task: Docker@2
 displayName: Build and push an image to container registry
 inputs: — — As you can see that in input part, we used parameters which indicated to ACR and commadn is buildAndPush.command: buildAndPush
 repository: $(imageRepository)
 dockerfile: $(dockerfilePath)
 containerRegistry: $(dockerRegistryServiceConnection)
 tags: |
 $(tag)
```

Seems good.Save and Run. See portal watch build stages.

## **Create Pipeline for Continues Delivery with Deploy to AKS Task**

Create new pipeline

- Give Repo of Githubswnzen
- Configure your pipeline
- Select Below template**Deploy to Azure Kubernetes ServiceBuild and push image to Azure Container Registry; Deploy to Azure Kubernetes Service**

This time we select to “Deploy to Azure Kubernetes Service” task, this covers both Continues Integration and Continues Deployment stages.It means that pipeline has Build and deployment stage.

- Configure taskLogin the AzureSelect Cluster, Namespace, Container Registry and so on..
- Cluster — myAksClusterNamespace — defaultContainer Registry — swnzenacrImageName — shoppingapiServicePort — 80 — see from shoppingapi.yaml kube file.Ok

After that it is generating yaml file.

## **Review your pipeline YAML**

Examine yaml file;

```
# Deploy to Azure Kubernetes Service
# Build and push image to Azure Container Registry; Deploy to Azure Kubernetes Service
#https://docs.microsoft.com/azure/devops/pipelines/languages/dockertrigger:
- mainresources:
- repo: selfvariables:# Container registry service connection established during pipeline creation
 dockerRegistryServiceConnection: ‘040b72f3–53e8–478f-89a2-b6c75bb009a7’
 imageRepository: ‘shoppingapi’
 containerRegistry: ‘swnzenacr.azurecr.io’
 dockerfilePath: ‘**/Dockerfile’
 tag: ‘$(Build.BuildId)’
```

Above are already explained, imagePullSecret for pulling images from ACR, as your remember we have also created secret, it is mandatory for pulling images ACR from AKS.

```
# Agent VM image name
 vmImageName: ‘ubuntu-latest’ — — Build Stage is same, but we need to add buildcontext again.stages:
- stage: Build
 displayName: Build stage
 jobs:
 — job: Build
 displayName: Build
 pool:
 vmImage: $(vmImageName)
 steps:
 — task: Docker@2
 displayName: Build and push an image to container registry
 inputs:
 command: buildAndPush
 repository: $(imageRepository)
 dockerfile: $(dockerfilePath)
 containerRegistry: $(dockerRegistryServiceConnection)
 tags: |
 $(tag)

```

We seen newly, upload and artifacts. This is very important. Because this place is connection point of **Build and Deploy stages.** After build the docker images we upload some additional files in order to use from Deployment stage.You can think about these task running different machines on cloud and once build finished it upload items into one placethat deploy task read and use these files when deploying application.We will also can see and download these uploaded artifacts on azure pipelines, we will see details later.

```
upload: manifests
 artifact: manifests- stage: Deploy
 displayName: Deploy stage
 dependsOn: Build
```

This is deployment job, it is specific for deployments.It includes deployment strategy is **runOnce** but we can modify later blue-green, canary and rollout deployments.Basically it creates image pull secret for pulling images to ACR, after that running manifest files into AKS cluster.As you can see that these manifests looking for manifest folder which uploaded in build stage and looking deployment and service yaml file for k8s deployment.

```
jobs:
 — deployment: Deploy
 displayName: Deploy
 pool:
 vmImage: $(vmImageName)
 environment: ‘mehmetozkayaswnzen.default’
 strategy:
 runOnce:
 deploy:
 steps:
 — task: KubernetesManifest@0
 displayName: Create imagePullSecret
 inputs:
 action: createSecret
 secretName: $(imagePullSecret)
 dockerRegistryEndpoint: $(dockerRegistryServiceConnection)

 — task: KubernetesManifest@0
 displayName: Deploy to Kubernetes cluster
 inputs:
 action: deploy
 manifests: |
 $(Pipeline.Workspace)/manifests/deployment.yml
 $(Pipeline.Workspace)/manifests/service.yml
 imagePullSecrets: |
 $(imagePullSecret)
 containers: |
 $(containerRegistry)/$(imageRepository):$(tag)
```

BTW, we prepare this task for only 1 microservice which is Shopping.API, but we have more microservices, we will cover all of them in the next section.We should separate pipelines as per microservices.

## **Running Pipeline for Continues Delivery with Deploy to AKS**

If you click to “Save and Run” you saw that its trying to add new items.

Files to be added to your repository (3)

azure-pipelinesmanifest/deployment.yaml files

Open pipeline see Runs.[https://dev.azure.com/ezozkme/swnzen/_build?definitionId=4](https://dev.azure.com/ezozkme/swnzen/_build?definitionId=4)

See Build stagesSee ArtifactsSee Deployment logs— You can see that Build and Deployment Succeed !!

Check kubectl pods:

```
C:\Users\ezozkme>kubectl get pod
NAME READY STATUS RESTARTS AGE
mongo-deployment-754d654ff7–8n559 1/1 Running 0 2d4h
shoppingapi-deployment-97f75c5f8-chvh5 1/1 Running 0 24s
shoppingapi-deployment-97f75c5f8-n6sbp 1/1 Running 0 34s
shoppingclient-deployment-6bbd995854–5c5tq 1/1 Running 0 45h
shoppingclient-deployment-6bbd995854–77jnm 1/1 Running 0 45h
shoppingclient-deployment-6bbd995854-gnttk 1/1 Running 0 45h
```

Check details of image pulling log.

```
kubectl describe pod shoppingapi-deployment-97f75c5f8-chvh5Events:
 Type Reason Age From Message
 — — — — — — — — — — — — -
 Normal Scheduled 38s default-scheduler Successfully assigned default/shoppingapi-deployment-97f75c5f8-chvh5 to aks-nodepool1–30369730-vmss000000
 Normal Pulled 37s kubelet, aks-nodepool1–30369730-vmss000000 Container image “swnzenacr.azurecr.io/shoppingapi:24” already present on machine
 Normal Created 37s kubelet, aks-nodepool1–30369730-vmss000000 Created container shoppingapi
 Normal Started 37s kubelet, aks-nodepool1–30369730-vmss000000 Started container shoppingapi
```

You saw that -> Container image “swnzenacr.azurecr.io/shoppingapi:24” already present on machine.

As you can see that, we have successfully build and deploy our shopping.api microservices with full automation, with writing our pipeline yaml file.But we developed multi-container microservices application, so we should have separate pipelines for microservices. We should create a new pipeline for Shopping.Client application. You can follow the same steps for Shopping.Client application in order to Manage Pipelines for **Multi-Container Microservices with CI/CD flows in Azure Pipelines.**