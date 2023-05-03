# Kubernetes Ingress — AWS EKS Cluster with AWS Load Balancer Controller

Article Link: https://gtsopour.medium.com/kubernetes-ingress-aws-eks-cluster-with-aws-load-balancer-controller-cf49126f8221
Author: George Tsopouridis
Date Added: August 26, 2021 2:43 PM
Tag: AWS, Kubernetes

Kubernetes Ingress is an API object that manages external access to the Services in a Kubernetes Cluster. Ingress exposes HTTP and HTTPS routes from outside the Cluster to Services within the Cluster. Traffic routing is controlled by rules defined on the Ingress resource.

Here is a simple example where an Ingress sends all its traffic to one Service:

![https://miro.medium.com/max/1400/1*MAUWGPtKFFpyttwjCOC9UQ.png](https://miro.medium.com/max/1400/1*MAUWGPtKFFpyttwjCOC9UQ.png)

An Ingress may be configured to give Services externally-reachable URLs, load balance traffic, terminate SSL / TLS, and offer name-based virtual hosting. An Ingress controller is responsible for fulfilling the Ingress, usually with a Load Balancer, though it may also configure your edge router or additional frontends to help handle the traffic.

# **Options for exposing applications deployed in Kubernetes**

Kubernetes Service is an abstract way to expose an application running on a set of Pods as a network service. For some parts of the application (for example Frontends, public API interfaces) you may need to expose a Service onto an external IP address, that’s outside of the Kubernetes Cluster.

Kubernetes **ServiceTypes** allow you to specify what kind of Service you want. The default is **ClusterIP**.

Type values and their behaviours are:

- **ClusterIP**: Exposes the Service on a cluster-internal IP. Choosing this value makes the Service only reachable from within the Cluster. This is the default ServiceType.
- **NodePort**: Exposes the Service on each Node’s IP at a static port (the NodePort). A ClusterIP Service, to which the NodePort Service routes, is automatically created. You’ll be able to contact the NodePort Service, from outside the Cluster, by requesting <NodeIP>:<NodePort>.
- **LoadBalancer**: Exposes the Service externally using a Cloud provider’s Load Balancer. NodePort and ClusterIP Services, to which the external load balancer routes, are automatically created.
- **ExternalName**: Maps the Service to the contents of the externalName field (e.g. foo.bar.example.com), by returning a CNAME record with its value. No proxying of any kind is set up.

ClusterIP, NodePort, LoadBalancer and ExternalName are all ways to get external traffic into the Cluster. **Ingress** is also used to expose a Service but it is not a Service type itself. It acts as the entry point for the Cluster. It lets you consolidate the routing rules into a single resource as it can expose multiple Services under the same IP address.

**ClusterIP** is the preferred option for internal Service access and uses an internal IP address to access the Service. Some examples of where ClusterIP might be the best option include Service debugging during development and testing, internal traffic and dashboards.

**NodePort** is a virtual machine (VM) used to expose a Service on a Static Port number. It’s primarily used for exposing Services in a non-production environment and it is not recommended for production.

**LoadBalancer** uses an external Load Balancer to expose Services to the Internet. You can use LoadBalancer in a production environment but Ingress is often preferred.

**Ingress** enables you to consolidate the traffic-routing rules into a single resource and runs as part of the Kubernetes Cluster. Some reasons Kubernetes Ingress is the preferred option for exposing a service in a production environment include the following:

- Traffic routing is controlled by rules defined on the Ingress Resource.
- Ingress is part of the Kubernetes Cluster.
- An external Load Balancer is expensive and you need to manage this outside the Kubernetes Cluster. Kubernetes Ingress is managed from inside the Cluster.

# **Ingress Controller**

In order for the Ingress resource to work, the Cluster must have an Ingress Controller running. If Kubernetes Ingress is the API object that provides routing rules to manage external access to the Services, Ingress Controller is the actual implementation of the Ingress API. The Ingress Controller is responsible for reading the Ingress Resource information and processing that data accordingly. The following is a sample Ingress Resource:

```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
 name: {NAME}
 namespace: {NAMESPACE}
spec:
 rules:
   - host: {host}
     http:
       paths:
         - path: /*
           pathType: Prefix
           backend:
             service:
               name: {SERVICE}
               port:
                 number: 8080
```

Looking deeper, the Ingress Controller is an application that runs in a Kubernetes Cluster and configures an HTTP Load Balancer according to the Ingress Resources. The Load Balancer can be a software Load Balancer running in the Cluster or a hardware or Cloud Load Balancer running externally. Different Load Balancers require different Ingress Controller implementations.

# **AWS Ingress Controller**

Ingress controllers in AWS use ALB to expose the Ingress Controller to outside traffic. They have added benefits such as advanced routing rules (e.g. path-based routing /service2) and consolidating Services to a single entry point for lower cost and centralized configuration.

The **AWS Load Balancer Controller** manages AWS Load Balancers for a Kubernetes Cluster. Please note that this controller was formerly named as **AWS ALB Ingress Controller**. The controller provisions:

- An AWS Application Load Balancer (ALB) when you create a Kubernetes Ingress.
- An AWS Network Load Balancer (NLB) when you create a Kubernetes Service of type LoadBalancer using IP targets on 1.18 or later Amazon EKS clusters.

The AWS Load Balancer Controller is a popular way to expose Kubernetes Services using Kubernetes ingress rules to create an ALB. The following diagram is from the original ALB Ingress Controller announcement to show benefits such as ingress path-based routing and the ability to route directly to pods in Kubernetes instead of relying on internal service IPs and kube-proxy.

[https://miro.medium.com/max/1400/0*NebjwCkmO05N-38H](https://miro.medium.com/max/1400/0*NebjwCkmO05N-38H)

# **Share an ALB with multiple Kubernetes Ingress rules**

In the AWS ALB Ingress Controller, prior to version 2.0, each Ingress object created in Kubernetes would get its own ALB. Customers wanted a way to lower their cost and duplicate configuration by sharing the same ALB for multiple Services and Namespaces and this feature is available with the **AWS Load Balancer Controller** [https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html](https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html)

By sharing an ALB, you can still use annotations for advanced routing but share a single load balancer for a team, or any combination of apps by specifying the alb.ingress.kubernetes.io/group.name annotation. All Services within the same group.name will use the same Load Balancer.

```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
 name: {NAME}
 namespace: {NAMESPACE}
  annotations:
    kubernetes.io/ingress.class: alb
    #Share a single ALB with all Ingress rules with a specific group name
    alb.ingress.kubernetes.io/group.name: {GROUP_NAME}
    alb.ingress.kubernetes.io/target-type: instance
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/certificate-arn: {CERTIFICATE}
    alb.ingress.kubernetes.io/listen-ports: '[{"HTTPS":443}]'
    alb.ingress.kubernetes.io/actions.ssl-redirect: '{"Type": "redirect", "RedirectConfig": { "Protocol": "HTTPS", "Port": "443", "StatusCode": "HTTP_301"}}'
spec:
 rules:
   - host: {host}
     http:
       paths:
         - path: /*
           pathType: Prefix
           backend:
             service:
               name: {SERVICE}
               port:
                 number: 8080
```

# **Summary**

The Kubernetes Ingress API lets you expose your applications deployed in a Kubernetes Cluster to the Internet with routing rules into a single source. To implement Ingress, you need to configure an Ingress Controller in your Cluster as this is responsible for processing Ingress Resource information and allowing traffic based on the Ingress rules. In case of an AWS EKS Cluster, you can share an ALB with multiple Kubernetes Ingress rules by installing the latest AWS Load Balancer Controller and configuring the alb.ingress.kubernetes.io/group.name annotation.