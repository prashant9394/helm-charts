
Trusted-workload-placement
===========

A Helm chart for Deploying ISecL-DC Trusted Workload Placement for Cloud Service Provider Use case


## Configuration

The following table lists the configurable parameters of the Trusted-workload-placement chart and their default values.

| Parameter                | Description             | Default        |
| ------------------------ | ----------------------- | -------------- |
| `aas-manager.image.name` | Authentication & Authorization Manager image name<br> (**REQUIRED**) | `""` |
| `isecl-controller.image.name` | ISecL Controller Service image name<br> (**REQUIRED**) | `""` |
| `ihub.image.name` | Integration Hub Service image name<br> (**REQUIRED**) | `""` |
| `isecl-scheduler.image.name` | ISecL Scheduler image name<br> (**REQUIRED**) | `""` |
| `global.controlPlaneHostname` | K8s control plane IP/Hostname<br> (**REQUIRED**) | `""` |
| `global.controlPlaneLabel` | K8s control plane label<br> (**REQUIRED**)<br> Example: `node-role.kubernetes.io/master` in case of `kubeadm`/`microk8s.io/cluster` in case of `microk8s` | `""` |
| `global.image.registry` | The image registry where isecl images are pushed<br> (**REQUIRED**) | `""` |
| `global.image.pullPolicy` | The pull policy for pulling from container registry<br> (Allowed values: `Always`/`IfNotPresent`) | `"Always"` |
| `global.storage.nfs.server` | The NFS Server IP/Hostname<br> (**REQUIRED**) | `""` |
| `global.storage.nfs.path` | The path for storing persistent data on NFS | `"/mnt/nfs_share/"` |
| `global.service.cms` | The service port for Certificate Management Service | `30445` |
| `global.service.aas` | The service port for Authentication Authorization Service | `30444` |
| `global.service.hvs` | The service port for SGX Host Verification Service | `30443` |
| `aas-manager.nameOverride` | The name for AAS-MANAGER chart (Default: .Chart.Name) | `""` |
| `aas-manager.controlPlaneHostname` | K8s control plane IP/Hostname | `"<user input>"` |
| `aas-manager.image.registry` | The image registry where AAS-MANAGER image is pushed | `"<user input>"` |
| `aas-manager.image.pullPolicy` | The pull policy for pulling from container registry (Allowed values: Always/IfNotPresent) | `"Always"` |
| `aas-manager.securityContext.init.fsGroup` |  | `1001` |
| `aas-manager.securityContext.aasManager.runAsUser` |  | `1001` |
| `aas-manager.securityContext.aasManager.runAsGroup` |  | `1001` |
| `aas-manager.securityContext.aasManager.capabilities.drop` |  | `["all"]` |
| `aas-manager.securityContext.aasManager.allowPrivilegeEscalation` |  | `false` |
| `aas-manager.service.aas.port` | The externally exposed NodePort on which CMS can listen to external traffic | `30444` |
| `isecl-controller.nameOverride` | The name for ISECL-CONTROLLER chart (Default: .Chart.Name) | `""` |
| `isecl-controller.controlPlaneLabel` | K8s control plane label. User Populated.<br> Example: `node-role.kubernetes.io/master` in case of `kubeadm`/`microk8s.io/cluster` in case of `microk8s` | `"<user input>"` |
| `isecl-controller.image.registry` | The image registry where ISECL-CONTROLLER image is pushed | `"<user input>"` |
| `isecl-controller.image.pullPolicy` | The pull policy for pulling from container registry for ISECL-CONTROLLER (Allowed values: Always/IfNotPresent) | `"Always"` |
| `isecl-controller.securityContext.init.fsGroup` |  | `1001` |
| `isecl-controller.securityContext.isecl-controller.runAsUser` |  | `1001` |
| `isecl-controller.securityContext.isecl-controller.runAsGroup` |  | `1001` |
| `isecl-controller.securityContext.isecl-controller.capabilities.drop` |  | `["all"]` |
| `isecl-controller.securityContext.isecl-controller.allowPrivilegeEscalation` |  | `false` |
| `ihub.nameOverride` | The name for IHUB chart (Default: .Chart.Name) | `""` |
| `ihub.controlPlaneHostname` | K8s control plane IP/Hostname | `"<user input>"` |
| `ihub.k8sApiServerPort` |  | `6443` |
| `ihub.dependentServices.cms` |  | `"cms"` |
| `ihub.dependentServices.aas` |  | `"aas"` |
| `ihub.dependentServices.hvs` |  | `"hvs"` |
| `ihub.dependentServices.isecl-controller` |  | `"isecl-controller"` |
| `ihub.image.registry` | The image registry where IHUB image is pushed | `"<user input>"` |
| `ihub.image.pullPolicy` | The pull policy for pulling from container registry for IHUB (Allowed values: Always/IfNotPresent) | `"Always"` |
| `ihub.storage.nfs.server` | The NFS Server IP/Hostname | `"<user input>"` |
| `ihub.storage.nfs.reclaimPolicy` | The reclaim policy for NFS (Allowed values: Retain/) | `"Retain"` |
| `ihub.storage.nfs.accessModes` | The access modes for NFS (Allowed values: ReadWriteMany) | `"ReadWriteMany"` |
| `ihub.storage.nfs.path` | The path for storing persistent data on NFS (Default: /mnt/nfs_share/) | `"/mnt/nfs_share"` |
| `ihub.storage.nfs.configSize` | The configuration size for storing config for IHUB in NFS path | `"10Mi"` |
| `ihub.storage.nfs.logsSize` | The logs size for storing logs for IHUB in NFS path | `"1Gi"` |
| `ihub.securityContext.init.fsGroup` |  | `1001` |
| `ihub.securityContext.ihub.runAsUser` |  | `1001` |
| `ihub.securityContext.ihub.runAsGroup` |  | `1001` |
| `ihub.securityContext.ihub.capabilities.drop` |  | `["all"]` |
| `ihub.securityContext.ihub.allowPrivilegeEscalation` |  | `false` |
| `isecl-scheduler.nameOverride` | The name for ISECL-SCHEDULER chart (Default: .Chart.Name) | `""` |
| `isecl-scheduler.controlPlaneLabel` | K8s control plane label. User Populated.<br> Example: `node-role.kubernetes.io/master` in case of `kubeadm`/`microk8s.io/cluster` in case of `microk8s` | `"<user input>"` |
| `isecl-scheduler.image.registry` | The image registry where ISECL-SCHEDULER image is pushed | `"<user input>"` |
| `isecl-scheduler.image.pullPolicy` | The pull policy for pulling from container registry for ISECL-SCHEDULER (Allowed values: Always/IfNotPresent) | `"Always"` |
| `isecl-scheduler.securityContext.init.fsGroup` |  | `1001` |
| `isecl-scheduler.securityContext.isecl-scheduler.runAsUser` |  | `1001` |
| `isecl-scheduler.securityContext.isecl-scheduler.runAsGroup` |  | `1001` |
| `isecl-scheduler.securityContext.isecl-scheduler.capabilities.drop` |  | `["all"]` |
| `isecl-scheduler.securityContext.isecl-scheduler.allowPrivilegeEscalation` |  | `false` |
| `isecl-scheduler.service.containerPort` | The containerPort on which CMS can listen to traffic | `8888` |
| `isecl-scheduler.service.port` | The externally exposed NodePort on which CMS can listen to external traffic | `30888` |



---
_Documentation generated by [Frigate](https://frigate.readthedocs.io)._

