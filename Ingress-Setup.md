

### Introduction ###

Ingress offer flexible way of routing traffic from beyond your cluster to internal Kubernetes Services.
Ingress Resources are objects in Kubernetes that define rules for routing HTTP and HTTPS traffic to Services

### Setup Ingress Controller ###
1. To install the Nginx Ingress Controller to your cluster, first need to add below repository to Helm by running below commands:

```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install nginx-ingress ingress-nginx/ingress-nginx --set controller.publishService.enabled=true
```

2. How to enable SSL Pass through option in Ingress controller

By default SSL pass through option for Ingress controller will disabled.
To enable it user has to include below rule to the deployment of ingress-nginx-controller under `spec.containers.args` of the deployment

```
- --enable-ssl-passthrough
```
Note: Ingress controller will be installed and running under ingress-nginx namespace.


2.	Securing the Ingress using cert-Manger

cert-manager adds certificates and certificate issuers as resource types in Kubernetes clusters, and simplifies the process of obtaining, renewing and using those certificates.

It can issue certificates from a variety of supported sources, including Let’s Encrypt, HashiCorp Vault, and Venafi as well as private PKI.

-   cert-manager installation steps:

```
kubectl create namespace cert-manager
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager jetstack/cert-manager --namespace cert-manager --version v1.2.0 --set installCRDs=true
```

### Setup Ingress Rule ###
Ingress rule needs to be applied within same name space where we are planning to installed all Isecl releated helm charts.

```
kubectl -n isecl apply -f ingress.yaml
```

```
Note: For ingress rule, please refer ingress.yaml in the repo.
```
