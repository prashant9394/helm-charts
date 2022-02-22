

### Introduction ###

Ingress offer flexible way of routing traffic from beyond your cluster to internal Kubernetes Services.
Ingress Resources are objects in Kubernetes that define rules for routing HTTP and HTTPS traffic to Services

### Install MetaLLB load Balancer 

Perform the steps as shown in link for setting up metallb load balancer
https://metallb.universe.tf/installation/

Create a configmap

```shell script
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - <192.0.1.1-192.0.1.4> # IP range within worker nodes, MetalLB takes ownership of one of the IP addresses in the pool and updates the loadBalancer IP field of the ingress-nginx Service accordingly.
```
 
 Ref: https://kubernetes.github.io/ingress-nginx/deploy/baremetal/#a-pure-software-solution-metallb
      
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


3.	Create ingress tls certificate for ingress as shown below.


```
openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes   -keyout tls.key -out tls.crt -subj "/CN=ISecl Ingress TLS Certificate"   -addext "subjectAltName=DNS:*.isecl.com"
kubectl create secret tls tls-ingress --cert=tls.crt --key=tls.key -n isecl
```

### Setup Ingress Rule ###
Ingress rule needs to be applied within same name space where we are planning to installed all Isecl releated helm charts.

```
kubectl -n isecl apply -f ingress.yaml
```

```
Note: For ingress rule, please refer ingress.yaml in the repo.
```
