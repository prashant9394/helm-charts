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
      - [Use Case charts Deployment](#use-case-charts-deployment)
      - [Individual Service/Agent Charts Deployment](#individual-serviceagent-charts-deployment)
      - [Setup task workflow](#setup-task-workflow)

<!-- /code_chunk_output -->


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
* NFS setup
  > **Note:** A sample script for setting up NFS with the right permissions is provided in the `NFS-Setup.md` file
    ```shell script 
    curl -fsSL -o setup-nfs.sh https://raw.githubusercontent.com/intel-secl/helm-charts/v4.2.0/setup-nfs.sh
    chmod +x setup-nfs.sh
    ./setup-nfs.sh /mnt/nfs_share 1001 <ip>
    ```
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
```shell
helm repo add isecl-helm https://github.com/intel-secl/helm-charts/charts/
helm repo update
```

* To find list of avaliable charts
```shell script
helm repo search
```

### Individual helm chart deployment (using service/job charts)

The helm chart support Nodeports for services, to support ingress model. 

#### Update `values.yaml` for Use Case chart deployments
* The images are built on the build machine and images are pushed to a registry tagged with `release_version`(e.g:v4.2.0) as version for each image
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

aas-manager


#### Individual chart deployment and along with sequence to be followed
Helm deployment commands: 

```shell script
helm repo update
helm repo pull isecl-helm/<use-case-chart/service-chart>
helm install <helm release name> isecl-helm/<use-case-chart/service-chart> --create-namespace -n isecl (--create-namespace for the 1st helm install command to be run)
```

CMS, AAS are common dependent services for any of the ISecl services/agents to be deployed except ISecl K8s Extensions(ISecl K8s Scheduler and ISecl K8s controller). Hence these two services 
needs to be up and running before deploying any individual services. AAS manager job needs to be run to generate bearer-token as a secret.

Services which has database deployment associated with it needs db ssl certificates to be generated as secrets, this is done by deploying \<service\>db-cert-generator job.

Below are the common/mandatory steps need to be performed for deploying individual charts except ISecl K8s Extensions.
```shell script
helm repo pull isecl-helm/cleanup-secrets
helm install cleanup-secrets isecl-helm/cleanup-secrets -n isecl --create-namespace
helm repo pull isecl-helm/cms
helm install cms isecl-helm/cms -n isecl -f values.yaml
helm repo pull isecl-helm/aasdb-cert-generator
helm install aasdb-cert-generator isecl-helm/aasdb-cert-generator -n isecl
helm repo pull isecl-helm/aas
helm install aas services/aas -n isecl -f values.yaml
helm repo pull isecl-helm/aas-manager
helm install aas-manager jobs/aas-manager -n isecl -f values.yaml
helm repo pull isecl-helm/hvsdb-cert-generator
helm install hvsdb-cert-generator isecl-helm/hvsdb-cert-generator -n isecl
helm repo pull isecl-helm/hvs
helm install hvs isecl-helm/hvs -n isecl -f values.yaml
helm repo pull isecl-helm/trustagent 
helm install trustagent isecl-helm/trustagent -n isecl -f values.yaml
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
* Cleanup the data at NFS mount and TA nodes.
* Remove all objects(secrets, rbac, clusterrole, service account) related namespace related to deployment ```kubectl delete ns <namespace>```. 

**Note**: 
    
    Before redeploying any of the chart please check the pv and pvc of corresponding deployments are removed. Suppose
    if you want to redeploy aas, make sure that aas-logs-pv, aas-logs-pvc, aas-config-pv, aas-config-pvc, aas-db-pv, aas-db-pvc, aas-base-pvc are removed successfully.
    Command: ```kubectl get pvc -A``` && ```kubectl get pv -A```
    
    helm uninstall command wont remove secrets by itself, one has to manually delete secrets or use cleanup-secrets to cleanup all the secrets. 

### Usecase based chart deployment (using umbrella charts)

#### Update `values.yaml` for Use Case chart deployments

The values.yaml can be found under usecase chart as usecases/host-attestation/values.yaml
Some assumptions before updating the `values.yaml` are as follows:
* The images are built on the build machine and images are pushed to a registry tagged with `release_version`(e.g:v4.2.0) as version for each image
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
helm repo pull isecl-helm/Host-Attestation
helm install host-attastation isecl-helm/Host-Attestation -f values.yaml --create-namespace -n <namespace>
```
> **Note:** If using a seprarate .kubeconfig file, ensure to provide the path using `--kubeconfig <.kubeconfig path>`


## Setup task workflow.

Check this document for available setup tasks for each of the services  [Setup tasks](../../setup-tasks.md) 
1. Edit the configmap of respective service where we want to run setup task. e.g ```kubectl edit cm cms -n isecl```
2. Add or Update all the variables required for setup tasks refer [here](../../setup-tasks.md)  for more details
3. Add *SETUP_TASK* variable in config map with one or more setup task names e.g ```SETUP_TASK: "download-ca-cert,download-tls-cert"```
4. Save the configmap
5. Some of the sensitive variables such as credentials, db credentials, tpm-owner-secret can be updated in secrets with the command 

    ```kubectl get secret -n <namespace> <secret-name> -o json | jq --arg val "$(echo <value> > | base64)" '.data["<variable-name>"]=$val' | kubectl apply -f -```
    
    e.g For updating the AAS_ADMIN_USERNAME in aas-credentials 
    
    ```kubectl get secret -n isecl aas-credentials -o json | jq --arg val "$(echo aaspassword | base64)" '.data["AAS_ADMIN_USERNAME"]=$val' | kubectl apply -f -``` 
   
6. Restart the pod by deleting it ```kubectl delete pod -n <namespace> <podname>```
7. Reset the configmap by removing SETUP_TASK variable 

      ```kubectl patch configmap -n <namespace> <configmap name> --type=json -p='[{"op": "remove", "path": "/data/SETUP_TASK"}]'```
        
        e.g For clearing SETUP_TASK variable in cms configmap
        
      ```kubectl patch configmap -n isecl cms --type=json -p='[{"op": "remove", "path": "/data/SETUP_TASK"}]'```
