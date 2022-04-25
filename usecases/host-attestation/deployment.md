# Helm Chart Deployment steps for Host Attestation Usecase

A collection of helm charts for Host-Attestation Usecase

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

  - [Getting Started](#getting-started)
    - [Pre-requisites](#pre-requisites)
    - [Support Details](#support-details)
    - [Use Case Helm Charts](#use-case-helm-charts)
    - [Setting up for Helm deployment](#setting-up-for-helm-deployment)
        - [Create Secrets for Database of Services](#create-secrets-for-database-of-services)
    - [Installing isecl-helm charts](#installing-isecl-helm-charts)
      - [Update `values.yaml` for Use Case chart deployments](#update-valuesyaml-for-use-case-chart-deployments)
      - [Use Case charts Deployment](#usecase-based-chart-deployment-using-umbrella-charts)
      - [Individual Service/Agent Charts Deployment](#individual-helm-chart-deployment-using-servicejob-charts)
      - [Setup task workflow](#setup-task-workflow)

<!-- /code_chunk_output -->

# Deployment diagram
![K8s Deployment-fsws](../../images/fs.jpg)

## Getting Started
Below steps guide in the process for installing isecl-helm charts on a kubernetes cluster.

### Pre-requisites
* Non Managed Kubernetes Cluster up and running
* Helm 3 installed
  ```shell
  curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
  chmod 700 get_helm.sh
  ./get_helm.sh
  ```

* For building container images Refer here for [instructions](https://github.com/intel-secl/docs/blob/v4.2/develop/docs/quick-start-guides/Foundational%20%26%20Workload%20Security%20-%20Containerization/5Build.md)  

* Setup NFS, Refer [instructions](../../docs/NFS-Setup.md) for setting up and configuring NFS Server

### Support Details

| Kubernetes        | Details                                                      |
| ----------------- | ------------------------------------------------------------ |
| Cluster OS        | *RedHat Enterprise Linux 8.x* <br/>*Ubuntu 20.04*            |
| Distributions     | Any non-managed K8s cluster                                  |
| Versions          | v1.23                                                        |
| Storage           | NFS                                                          |
| Container Runtime | *docker*,*CRI-O*<br/> |

### Use Case Helm Charts 

| Use case                                | Helm Charts                                        |
| --------------------------------------- | -------------------------------------------------- |
| Host Attestation - Containers | *cms*<br />*aas*<br />*hvs*<br />*ta*<br />*nats(optional)* |


### Setting up for Helm deployment

### Installing isecl-helm charts

* Add the isecl-helm charts in helm chart repository
```shell script
helm repo add isecl-helm https://intel-secl.github.io/helm-charts
helm repo update
```

* To find list of avaliable charts
```shell script
helm search repo
```

### Individual helm chart deployment (using service/job charts)

The helm chart support Nodeports for services, to support ingress model. 

#### Update `values.yaml` for Use Case chart deployments
* The images are built on the build machine and images are pushed to a registry tagged with `release_version`(e.g:v5.0.0) as version for each image
* The NFS server and setup either using sample script or by the user itself
* The K8s non-managed cluster is up and running
* Helm 3 is installed

The `values.yaml` file in each of the charts is used for defining all the values required for an individual chart deployment. Most of the values are already defined
and yet there are few values needs to be defined by the user, these are marked by placeholder with the name \<user input\>.  
e.g 
```yaml
image:
  name: <user input> # The image name with which AAS-MANAGER image is pushed to registry

controlPlaneHostname: <user input> # K8s control plane IP/Hostname<br> (**REQUIRED**)

storage:
  nfs:
    server: <user input> # The NFS Server IP/Hostname
```

By default Nodeport is supported for all ISecl services deployed on K8s, ingress can be enabled by setting the *enable* to true under ingress in values.yaml of
individual services

Note: The values.yaml file can be left as is for jobs mentioned below:

cleanup-secrets

aasdb-cert-generator

hvsdb-cert-generator



#### Individual chart deployment and along with sequence to be followed

Services which has database deployment associated with it needs db ssl certificates to be generated as secrets, this is done by deploying \<service\>db-cert-generator job.

Download the values.yaml for each of the services.

```shell script
curl -fsSL -o cleanup-secrets.yaml https://raw.githubusercontent.com/intel-secl/helm-charts/v5.0.0-Beta/jobs/cleanup-secrets/values.yaml
curl -fsSL -o cms.yaml https://raw.githubusercontent.com/intel-secl/helm-charts/v5.0.0-Beta/services/cms/values.yaml
curl -fsSL -o aasdb-cert-generator.yaml https://raw.githubusercontent.com/intel-secl/helm-charts/v5.0.0-Beta/jobs/aasdb-cert-generator/values.yaml
curl -fsSL -o aas.yaml https://raw.githubusercontent.com/intel-secl/helm-charts/v5.0.0-Beta/services/aas/values.yaml
curl -fsSL -o hvsdb-cert-generator.yaml https://raw.githubusercontent.com/intel-secl/helm-charts/v5.0.0-Beta/jobs/hvsdb-cert-generator/values.yaml
curl -fsSL -o hvs.yaml https://raw.githubusercontent.com/intel-secl/helm-charts/v5.0.0-Beta/services/hvs/values.yaml
curl -fsSL -o trustagent.yaml https://raw.githubusercontent.com/intel-secl/helm-charts/v5.0.0-Beta/services/ta/values.yaml
```

Update all the downloaded values.yaml with appropriate values.
 
Following are the steps need to be run for deploying individual charts.
```shell script
helm pull isecl-helm/cleanup-secrets
helm install cleanup-secrets -f cleanup-secrets.yaml isecl-helm/cleanup-secrets -n isecl --create-namespace
helm pull isecl-helm/cms
helm install cms isecl-helm/cms -n isecl -f cms.yaml
helm pull isecl-helm/aasdb-cert-generator
helm install aasdb-cert-generator isecl-helm/aasdb-cert-generator -f aasdb-cert-generator.yaml  -n isecl
helm pull isecl-helm/aas
helm install aas services/aas -n isecl -f aas.yaml
helm pull isecl-helm/hvsdb-cert-generator
helm install hvsdb-cert-generator isecl-helm/hvsdb-cert-generator -f hvsdb-cert-generator.yaml -n isecl
helm pull isecl-helm/hvs
helm install hvs isecl-helm/hvs -n isecl -f hvs.yaml
helm pull isecl-helm/trustagent 
helm install trustagent isecl-helm/trustagent -n isecl -f trustagent.yaml
```

To uninstall a chart
```shell script
helm uninstall <release-name> -n isecl
```

To list all the helm chart deployments 
```shell script
helm list -A
```

Cleanup steps that needs to be done for a fresh deployment
* Uninstall all the chart deployments.
* Cleanup the data at NFS mount and trustagent data mount on each nodes (/opt/trustagent)
* Remove all objects(secrets, rbac, clusterrole, service account) related namespace related to deployment ```kubectl delete ns <namespace>```. 

**Note**: 
    
    Before redeploying any of the chart please check the pv and pvc of corresponding deployments are removed. Suppose
    if you want to redeploy aas, make sure that aas-logs-pv, aas-logs-pvc, aas-config-pv, aas-config-pvc, aas-db-pv, aas-db-pvc, aas-base-pvc are removed successfully.
    Command: ```kubectl get pvc -A``` && ```kubectl get pv -A```
    
    helm uninstall command wont remove secrets by itself, one has to manually delete secrets or use cleanup-secrets to cleanup all the secrets. 

### Usecase based chart deployment (using umbrella charts)

Download the values.yaml file for host-attestation usecase chart

```shell script
curl -fsSL -o values.yaml https://raw.githubusercontent.com/intel-secl/helm-charts/v5.0.0-Beta/usecases/host-attestation/values.yaml
```

#### Update `values.yaml` for Use Case chart deployments

Some assumptions before updating the `values.yaml` are as follows:
* The images are built on the build machine and images are pushed to a registry tagged with `release_version`(e.g:v5.0.0) as version for each image
* The NFS server and setup either using sample script or by the user itself
* The K8s non-managed cluster is up and running
* Helm 3 is installed

The helm chart support Nodeports for services, to support ingress model. 
Enable the ingress by setting the value ingress enabled to true in values.yaml file

Update the ```hvsUrl, cmsUrl and aasUrl``` under global section according to the conifgured model.
e.g For ingress. hvsUrl: https://hvs.isecl.com/hvs/v2
    For Nodeport, hvsUrl: https://<controlplane-hosntam/IP>:30443/hvs/v2

#### Use Case charts Deployment

```shell
helm pull isecl-helm/Host-Attestation
helm install host-attastation isecl-helm/Host-Attestation -f values.yaml --create-namespace -n <namespace>
```
> **Note:** If using a seprarate .kubeconfig file, ensure to provide the path using `--kubeconfig <.kubeconfig path>`


## Setup task workflow.
* Setup NFS, Refer [instructions](../../docs/setup-task-workflow.md) for running service specific setup tasks
