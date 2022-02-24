# isecl-helm

A collection of helm charts for ISecL-DC usecases


<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [isecl-helm](#isecl-helm)
  - [Getting Started](#getting-started)
    - [Pre-requisites](#pre-requisites)
    - [Support Details](#support-details)
    - [Use Case Helm Charts](#use-case-helm-charts)
      - [Foundational Security Usecases](#foundational-security-usecases)
      - [Workload Security Usecases](#workload-security-usecases)
      - [Confidential Computing Usecases](#confidential-computing-usecases)
    - [Setting up for Helm deployment](#setting-up-for-helm-deployment)
        - [Create Secrets for Database of Services](#create-secrets-for-database-of-services)
    - [Installing isecl-helm charts](#installing-isecl-helm-charts)
      - [Update `values.yaml` for Use Case chart deployments](#update-valuesyaml-for-use-case-chart-deployments)
      - [Use Case charts Deployment](#use-case-charts-deployment)
      - [Individual Service/Agent Charts Deployment](#individual-serviceagent-charts-deployment)

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
        ./setup-nfs.sh /mnt/nfs_share 1001 <ip>
    ```
### Support Details

| Kubernetes        | Details                                                      |
| ----------------- | ------------------------------------------------------------ |
| Cluster OS        | *RedHat Enterprise Linux 8.x* <br/>*Ubuntu 18.04*            |
| Distributions     | Any non-managed K8s cluster                                  |
| Versions          | v1.21                                                        |
| Storage           | NFS                                                          |
| Container Runtime | Foundational Security: *docker*,*CRI-O*<br/>Workload Security: *CRI-O*<br/>Secure Key Caching: *docker* |

### Use Case Helm Charts 

#### Foundational Security Usecases

| Use case                                | Helm Charts                                        |
| --------------------------------------- | -------------------------------------------------- |
| Host Attestation                        | *cms*<br />*aas*<br />*hvs*<br />*ta*          |
| Trusted Workload Placement - Containers | *cms*<br />*aas*<br />*hvs*<br />*k8s-extensions*<br />*ihub*<br />*ta* |
| Data Fencing with Asset Tags            | *cms*<br />*aas*<br />*hvs*<br />*k8s-extensions*<br />*ihub*<br />*ta*              |


### Setting up for Helm deployment

##### Create Secrets for ISecL Scheduler TLS Key-pair (Mandatory for Trusted workload placement usecase)
ISecl Scheduler runs as https service, therefore it needs TLS Keypair and tls certificate needs to be signed by K8s CA, inorder to have secure communication between K8s base scheduler and ISecl K8s Scheduler.
The creation of TLS keypair is a manual step, which has to be done prior deplolying the helm for Trusted Workload Placement usecase. 
Following are the steps involved in creating tls cert signed by K8s CA.
```shell
mkdir -p /tmp/k8s-certs/tls-certs && cd /tmp/k8s-certs/tls-certs
openssl req -new -days 365 -newkey rsa:4096 -addext "subjectAltName = DNS:<Controlplane hostname>" -nodes -text -out server.csr -keyout server.key -sha384 -subj "/CN=ISecl Scheduler TLS Certificate"

cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: isecl-scheduler.isecl
spec:
  request: $(cat server.csr | base64 | tr -d '\n')
  signerName: kubernetes.io/kube-apiserver-client
  usages:
  - client auth
EOF

kubectl certificate approve isecl-scheduler.isecl
kubectl get csr isecl-scheduler.isecl -o jsonpath='{.status.certificate}' \
    | base64 --decode > server.crt
kubectl create secret tls isecl-scheduler-certs --cert=/tmp/k8s-certs/tls-certs/server.crt --key=/tmp/k8s-certs/tls-certs/server.key -n isecl
```

##### Create Secrets for Admission controller TLS Key-pair (Mandatory for Trusted workload placement usecase with admission controller)
Create admission-controller-certs secrets for admission controller deployment
```shell
mkdir -p /tmp/adm-certs/tls-certs && cd /tmp/adm-certs/tls-certs
openssl req -new -days 365 -newkey rsa:4096 -addext "subjectAltName = DNS:admission-controller.isecl.svc" -nodes -text -out server.csr -keyout server.key -sha384 -subj "/CN=system:node:<nodename>;/O=system:nodes"

cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: admission-controller.isecl
spec:
  groups:
  - system:authenticated
  request: $(cat server.csr | base64 | tr -d '\n')
  signerName: kubernetes.io/kubelet-serving
  usages:
  - digital signature
  - key encipherment
  - server auth
EOF

kubectl certificate approve admission-controller.isecl
kubectl get csr admission-controller.isecl -o jsonpath='{.status.certificate}' \
    | base64 --decode > server.crt
kubectl create secret tls admission-controller-certs --cert=/tmp/adm-certs/tls-certs/server.crt --key=/tmp/adm-certs/tls-certs/server.key -n isecl

```

Generate CA Bundle
```shell script
kubectl config view --raw --minify --flatten -o jsonpath='{.clusters[].cluster.certificate-authority-data}'
```
Add the output base64 encoded string to value in caBundle sub field of admission-controller in usecase/trusted-workload-placement/values.yml in case of usecase deployment chart.

*Note*: CSR needs to be deleted if we want to regenerate admission-controller-certs secret with command `kubectl delete csr admission-controller.isecl` 
### Installing isecl-helm charts

* Clone the repo
```shell
<repo clone>
cd <repo path>
```

### Individual helm chart deployment (using service/job charts)

#### Update `values.yaml` for Use Case chart deployments
* The images are built on the build machine and images are pushed to a registry tagged with `release_version`(e.g:v4.0.0) as version for each image
* The NFS server and setup either using sample script or by the user itself
* The K8s non-managed cluster is up and running
* Helm 3 is installed

The `values.yaml` file in each of the charts is used for defining all the values required for an individual chart deployment. Most of the values are already defined
and yet there are few values needs to be defined by the user, these are marked by placeholder with the name \<user input\>.  
```yaml
image:
  registry: <user input> # The image registry where AAS-MANAGER image is pushed
  name: <user input> # The image name with which AAS-MANAGER image is pushed to registry

controlPlaneHostname: <user input> # K8s control plane IP/Hostname<br> (**REQUIRED**)

storage:
  nfs:
    server: <user input> # The NFS Server IP/Hostname
```

Note: The values.yaml file can be left as is for jobs mentioned below:

cleanup-secrets

aasdb-cert-generator

hvsdb-cert-generator


#### Individual chart deployment and along with sequence to be followed
Helm deployment commands: 

```shell script
helm dependency update <chart folder>/
helm install <helm release name> <chart folder>/ --create-namespace -n isecl (--create-namespace for the 1st helm install command to be run)
```

CMS, AAS are common dependent services for any of the ISecl services/agents to be deployed except ISecl K8s Extensions(ISecl K8s Scheduler and ISecl K8s controller). Hence these two services 
needs to be up and running before deploying any individual services. AAS manager job needs to be run to generate bearer-token as a secret.

Services which has database deployment associated with it needs db ssl certificates to be generated as secrets, this is done by deploying \<service\>db-cert-generator job.

Below are the common/mandatory steps need to be performed for deploying individual charts except ISecl K8s Extensions.
```shell script
helm dependency update jobs/cleanup-secrets/
helm install cleanup-secrets jobs/cleanup-secrets/ -n isecl --create-namespace
helm dependency update services/cms
helm install cms services/cms -n isecl
helm dependency update jobs/aasdb-cert-generator/
helm install aasdb-cert-generator jobs/aasdb-cert-generator/ -n isecl
helm dependency update services/aas
helm install aas services/aas -n isecl
helm dependency update jobs/aas-manager
helm install aas-manager jobs/aas-manager -n isecl
```

To deploy a service which has db associated with it. i.e HVS
```shell script
helm dependency update jobs/hvsdb-cert-generator/
helm install hvsdb-cert-generator jobs/hvsdb-cert-generator/ -n isecl

helm dependency update services/hvs/
helm install hvs services/hvs -n isecl
```

To deploy a service which has no db associated with it. i.e IHUB
```shell script
helm dependency update services/ihub/
helm install ihub services/ihub -n isecl
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
* Uninstall all the chart deployments
* Cleanup the data at NFS mount
* Remove all objects(secrets, rbac, clusterrole, service account) related namespace related to deployment ```kubectl delete ns <namespace>```. 

**Note**: 
    
    Before redeploying any of the chart please check the pv and pvc of corresponding deployments are removed. Suppose
    if you want to redeploy aas, make sure that aas-logs-pv, aas-logs-pvc, aas-config-pv, aas-config-pvc, aas-db-pv, aas-db-pvc, aas-base-pvc are removed successfully.
    Command: ```kubectl get pvc -A``` && ```kubectl get pv -A```
    
    helm uninstall command wont remove secrets by itself, one has to manually delete secrets or use cleanup-secrets to cleanup all the secrets.
    

To re-run aas-manager job for getting latest bearer-token as a secret.   
```shell script
       kubectl delete secret -n isecl bearer-token
       kubectl get job aas-manager -o json -n isecl | jq 'del(.spec.selector)' | jq 'del(.spec.template.metadata.labels)' > aas-manager.json
       kubectl apply -f aas-manager.json
```    

### Usecase based chart deployment (using umbrella charts)

#### Update `values.yaml` for Use Case chart deployments

Some assumptions before updating the `values.yaml` are as follows:
* The images are built on the build machine and images are pushed to a registry tagged with `release_version`(e.g:v4.0.0) as version for each image
* The NFS server and setup either using sample script or by the user itself
* The K8s non-managed cluster is up and running
* Helm 3 is installed

The `values.yaml` under use case charts needs to be updated for the following:
```yaml
# The below section can be used to override additional values defined under each of the dependent charts
cms:
  image:
    name: <user input> # Certificate Management Service image name

aas:
  image:
    name: <user input> # Authentication & Authorization Service image name

aas-manager:
  image:
    name: <user input> # Authentication & Authorization Manager image name

hvs:
  image:
    name: <user input> # Host Verification Service image name

ta: 
  image:
    name: <user input> # Trust Agent image name

global:
  controlPlaneHostname: <user input> # K8s control plane IP/Hostname
  
  config:
    globalAdminUsername: <user input> # Global Admin username for API access
    globalAdminPassword: <user input> # Global Admin password for API access
    installAdminUsername: <user input> # Install Admin username for installing services
    installAdminPassword: <user input> # Install Admin password for installing services

  image:
    registry: <user input> # The image registry where isecl images are pushed

  storage:
    nfs:
      server: <user input> # The NFS Server IP/Hostname
      path: /mnt/nfs_share/  # The path for storing persistent data on NFS (Default: /mnt/nfs_share/)
```

#### Use Case charts Deployment

```shell
cd usecases/
helm dependency update <use case chart folder>/
helm install <helm release name> <use case chart folder>/ --create-namespace -n isecl
```
> **Note:** If using a seprarate .kubeconfig file, ensure to provide the path using `--kubeconfig <.kubeconfig path>`

#### In case of Trusted workload placement usecase chart deployment, configure kube-scheduler to establish communication with isecl-scheduler after successful deployment.

* Create a file called kube-scheduler-configuration.yml
```yaml
---
apiVersion: kubescheduler.config.k8s.io/v1beta2
kind: KubeSchedulerConfiguration
clientConnection:
  kubeconfig: "/etc/kubernetes/scheduler.conf"
profiles:
  - plugins:
      filter:
        enabled:
          - name: "NodePorts"
          - name: "NodeResourcesFit"
          - name: "VolumeBinding"
          - name: "NodeAffinity"
          - name: "NodeName"
      score:
        enabled:
          - name: "NodeResourcesBalancedAllocation"
            weight: 1
extenders:
  - urlPrefix: "https://127.0.0.1:30888/"
    filterVerb: "filter"
    weight: 5
    enableHTTPS: true
```

* Make directory /opt/isecl-k8s-extensions and copy kube-scheduler-configuration.yaml file into this newly created directory

* Add kube-scheduler-configuration.yml under kube-scheduler section /etc/kubernetes/manifests/kube-scheduler.yaml as mentioned below
```console
	spec:
          containers:
	  - command:
            - kube-scheduler
              --config: "/opt/isecl-k8s-extensions/kube-scheduler-configuration.yml"
```

* Add mount path for isecl extended scheduler under container section /etc/kubernetes/manifests/kube-scheduler.yaml as mentioned below
```console
	containers:
		- mountPath: /opt/isecl-k8s-extensions
		name: extendedsched
		readOnly: true
```

* Add volume path for isecl extended scheduler under volumes section /etc/kubernetes/manifests/kube-scheduler.yaml as mentioned below
```console
	spec:
	volumes:
	- hostPath:
		path: /opt/isecl-k8s-extensions
		type: ""
		name: extendedsched
```

* Restart Kubelet which restart all the k8s services including kube base scheduler
```console
	systemctl restart kubelet
```
