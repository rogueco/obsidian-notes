# How to create a Selenium web scraper in Azure Functions

Article Link: https://towardsdatascience.com/how-to-create-a-selenium-web-scraper-in-azure-functions-f156fd074503
Date Added: June 23, 2021 12:46 PM
Tag: Azure, Azure Function, Python, Serverless

# **How to create a Selenium web scraper in Azure Functions**

## *Learn to create an Azure Function using a custom docker image to run a Selenium web scraper in Python*

# **A. Introduction**

Selenium is the standard tool for automated web browser testing. On top of that, Selenium is a popular tool for [web scraping](https://medium.com/the-andela-way/introduction-to-web-scraping-using-selenium-7ec377a8cf72). When creating a web scraper in Azure, Azure Functions is a logical candidate to run your code in. However, the default Azure Functions image does not contain the dependencies that Selenium requires. In this blog, a web scraper in Azure Functions is created as follows:

- Create and deploy docker image as Azure Function with Selenium
- Scrape websites periodically and store results

The architecture of web scraper is depicted below.

![https://miro.medium.com/max/1729/1*rSrrOfr8i7LdsxR2kfzXOQ.png](https://miro.medium.com/max/1729/1*rSrrOfr8i7LdsxR2kfzXOQ.png)

A. Architecture to build a Selenium web scaper (image by Author)

In the remaining the steps are discussed to deploy and run your web scraper in Azure Functions. For details how to secure your Azure Functions, see [this](https://towardsdatascience.com/how-to-secure-your-azure-function-data-processing-c9947bf724fb) blog. For details how to create a custom docker image with OpenCV in Azure Functions, see [here](https://towardsdatascience.com/intelligent-realtime-and-scalable-video-processing-in-azure-201f87104f03) and DockerFile [here](https://github.com/rebremer/realtime_video_processing/blob/master/AzureFunction/afpdqueue_rtv/Dockerfile).

# **B0. Deploy Azure function with Selenium as Azure Function**

The base Azure Function image does not contain the necessary chromium packages to run selenium webdriver. This project creates a custom docker image with the required libraries such that it can be run as Azure Function. The following steps are executed:

- B01. Install prerequisites
- B02. Clone project from GIT
- B03. Create docker image using docker desktop
- B04. Create Azure Function and deploy docker image

See also architecture below.

![https://miro.medium.com/max/1696/1*RpZRTnzpoamCPriiudIBsg.png](https://miro.medium.com/max/1696/1*RpZRTnzpoamCPriiudIBsg.png)

B0. Azure Function running Selenium (image by Author)

## **B01. Install dependencies**

The following prerequisites need to be installed:

- [Docker desktop](https://docs.docker.com/get-docker/)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
- [Azure Core Tools version 2.x](https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local?tabs=windows%2Ccsharp%2Cbash#v2)
- [(optional) Visual Studio Code](https://code.visualstudio.com/)
- (optional) [Azure Container Registry](https://docs.microsoft.com/nl-nl/azure/container-registry/container-registry-get-started-portal) (docker hub can also be used)

## **B02. Create docker image using docker desktop**

Run the command below to clone the project from git. In case you did not install git, the zip file can also be downloaded and extracted.

```
git clonehttps://github.com/rebremer/azure-function-selenium.git
```

In this project, the following files can be found:

- TimeTrigger/__init__.py: Python file that contains all code to scrape websites. This Azure Function is time triggered
- HttpTrigger/__init__.py: Same as previous bullet, however, this is function HTTP triggered and can be run from a browser..
- DockerFile: File that contains all commands to create Docker image that will be used in the next step

## **B03. Create docker image using docker desktop**

Run the following commands that installs chromium, chrome driver and selenium on top of the Azure Function base image:

```
# Variables
$acr_id = "<<your acr>>.azurecr.io"# Create docker image using docker desktop
docker login $acr_id -u <<your username>> -p <<your password>>
docker build --tag $acr_id/selenium .# Push docker image to Azure Container Registry
docker push $acr_id/selenium:latest
```

## **B04. Create Azure Function and deploy docker image**

Run the following commands to create an Azure Function and deploy the docker image from Azure Container Registry.

```
# Variables
$rg = "<<your resource group name>>"
$loc = "<<your location>>"
$plan = "<<your azure function plan P1v2>>"
$stor = "<<your storage account adhering to function>>"
$fun = "<<your azure function name>>"
$acr_id = "<<your acr>>.azurecr.io"# Create resource group, storage account and app service planaz group create -n $rg -l $loc
az storage account create -n $stor -g $rg --sku Standard_LRS
az appservice plan create --name $plan --resource-group $rg --sku P1v2 --is-linux# Create Azure Function using docker image
az functionapp create --resource-group $rg --os-type Linux --plan  $plan --deployment-container-image-name $acr_id/selenium:latest --name  $fun --storage-account $stor
```

# **B1. Scrape websites and store results**

The Azure Function that was deployed in the previous step contains a time triggered function and an HTTP trigger function. In this part, the function will be triggered, scrape websites and store results to a data lake account. The following steps are executed:

- B11. Create data lake account
- B12. Run HTTP trigger Functions

See also architecture below.

![https://miro.medium.com/max/1713/1*K7dgzZJe8CMcGexZJpi2CA.png](https://miro.medium.com/max/1713/1*K7dgzZJe8CMcGexZJpi2CA.png)

B1_1. Scrape websites (image by Author)

## **B11. Create data lake account and update function**

Execute the following commands to create a data lake account in Azure and update the settings of the functions.

```
# Variables
$rg = "<<your resource group name>>"
$fun = "<<your azure function name>>"
$adls = "<<your storage account>>"
$sub_id = "<<your subscription id>>"
$container_name = "scraperesults"# Create adlsgen2
az storage account create --name $adls --resource-group $rg --location $loc --sku Standard_RAGRS --kind StorageV2 --enable-hierarchical-namespace true
az storage container create --account-name $adls -n $container_name# Assign identity to function and set params
az webapp identity assign --name $fun --resource-group $rg
az functionapp config appsettings set --name $fun --resource-group $rg --settings par_storage_account_name=$adls par_storage_container_name=$container_name# Give fun MI RBAC role to ADLS gen 2 account
$fun_object_id = az functionapp identity show --name $fun --resource-group $rg --query 'principalId' -o tsv
New-AzRoleAssignment -ObjectId $fun_object_id -RoleDefinitionName "Storage Blob Data Contributor" -Scope  "/subscriptions/$sub_id/resourceGroups/$rg/providers/Microsoft.Storage/storageAccounts/$adls/blobServices/default"
```

## **B12. Run Function**

The time triggered function will run periodically to scrape website. However, there is also a HTTP triggered function. When the URL is taken, it can be copied in the browser and run, see also below.

![https://miro.medium.com/max/2356/1*UuzRcJ-nnBPg0sdxYZKSEg.png](https://miro.medium.com/max/2356/1*UuzRcJ-nnBPg0sdxYZKSEg.png)

B12_1. Run HTTP triggered Function (image by Author)

Once the function is run, the results are stored in the data lake account, see also below.

![https://miro.medium.com/max/2356/1*ODqg7xIrInQojhOE6SlUkQ.png](https://miro.medium.com/max/2356/1*ODqg7xIrInQojhOE6SlUkQ.png)

B12_2. Scraping results stored in ADLSgen2 account (image by Author)

# **C. Conclusion**

Selenium is a popular tool for web scraping. However, the default Azure Functions image does not contain the depencencies that Selenium requires. In this blog, a web scraper in Azure Functions is created that installs these dependencies as follows:

- Create and deploy docker image as Azure Function with Selenium
- Scrape websites periodically and store results

Architecture of web scraper is depicted below.

![https://miro.medium.com/max/1729/1*rSrrOfr8i7LdsxR2kfzXOQ.png](https://miro.medium.com/max/1729/1*rSrrOfr8i7LdsxR2kfzXOQ.png)

C. Architecture to build a Selenium web scaper (image by Author)