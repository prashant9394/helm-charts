
Trusted-workload-placement-cloud-service-provider
===========

A Helm chart for Deploying ISecL-DC Trusted Workload Placement - Cloud Service Provider Use case


## Configuration

The following table lists the configurable parameters of the Trusted-workload-placement-cloud-service-provider chart and their default values.

| Parameter                | Description             | Default        |
| ------------------------ | ----------------------- | -------------- |
| `trustagent.image.name` | Trust Agent image name<br> (**REQUIRED**) | `"<user input>"` |
| `trustagent.nodeLabel.txt` | The node label for TXT-ENABLED hosts<br> (**REQUIRED IF NODE IS TXT ENABLED**) | `"TXT-ENABLED"` |
| `trustagent.nodeLabel.suefi` | The node label for SUEFI-ENABLED hosts (**REQUIRED IF NODE IS SUEFI ENABLED**) | `""` |
| `trustagent.config.tpmOwnerSecret` | The TPM owner secret if TPM is already owned | `null` |
| `trustagent.secret.installAdminUsername` | Install Admin Username for TA | `null` |
| `trustagent.secret.installAdminPassword` | Install Admin Password for TA | `null` |
| `isecl-controller.image.name` | ISecL Controller Service image name<br> (**REQUIRED**) | `"<user input>"` |
| `isecl-controller.nodeTainting.taintRegisteredNodes` | If set to true, taints the node which are joined to the k8s cluster. (Allowed values: `true`\`false`) | `true` |
| `isecl-controller.nodeTainting.taintRebootedNodes` | If set to true, taints the node which are rebooted in the k8s cluster. (Allowed values: `true`\`false`) | `false` |
| `isecl-controller.nodeTainting.taintUntrustedNode` | If set to true, taints the node which has trust tag set to false in node labels. (Allowed values: `true`\`false`) | `true` |
| `ihub.image.name` | Integration Hub Service image name<br> (**REQUIRED**) | `"<user input>"` |
| `ihub.k8sApiServerPort` |  | `6443` |
| `ihub.dependentServices.hvs` |  | `"hvs"` |
| `ihub.secret.installAdminUsername` | Install Admin Username for IHub | `null` |
| `ihub.secret.installAdminPassword` | Install Admin Password for IHub | `null` |
| `ihub.secret.serviceUsername` | Service Username for IHub | `null` |
| `ihub.secret.servicePassword` | Service Password for IHub | `null` |
| `isecl-scheduler.image.name` | ISecL Scheduler image name<br> (**REQUIRED**) | `"<user input>"` |
| `admission-controller.image.name` |  | `"<user input>"` |
| `admission-controller.caBundle` |  | `"<user input>"` |
| `global-admin-generator.enable` | Set this to true for generating global admin user account | `false` |
| `global-admin-generator.secret.globalAdminUsername` |  | `null` |
| `global-admin-generator.secret.globalAdminPassword` |  | `null` |
| `global-admin-generator.services_list` | Services list for global admin token generation. Accepted values HVS, WLS, KBS, APS, FDS, TA, QVS, TCS | `["TA"]` |
| `global.controlPlaneHostname` | K8s control plane IP/Hostname<br> (**REQUIRED**) | `"<user input>"` |
| `global.controlPlaneLabel` | K8s control plane label<br> (**REQUIRED**)<br> Example: `node-role.kubernetes.io/master` in case of `kubeadm`/`microk8s.io/cluster` in case of `microk8s` | `"node-role.kubernetes.io/master"` |
| `global.versionUpgrade` | Set this true when performing upgrading to next minor/major version | `false` |
| `global.currentVersion` | Set the currently deployed version | `null` |
| `global.hostAliasEnabled` | Set this to true for using host aliases and also add entries accordingly in ip, hostname entries. hostalias is required when ingress is deployed and pods are not able to resolve the domain names | `false` |
| `global.aliases.hostAliases` |  | `[{"ip": "", "hostnames": ["", ""]}]` |
| `global.image.pullPolicy` | The pull policy for pulling from container registry<br> (Allowed values: `Always`/`IfNotPresent`) | `"Always"` |
| `global.image.imagePullSecret` | The image pull secret for authenticating with image registry, can be left empty if image registry does not require authentication | `null` |
| `global.image.initName` | The image name of init container | `"<user input>"` |
| `global.image.aasManagerName` | The image name of aas-manager image name | `"<user input>"` |
| `global.config.dbhostSSLPodRange` | PostgreSQL DB Host Address(IP address/subnet-mask). IP range varies for different k8s network plugins(Ex: Flannel - 10.1.0.0/8 (default), Calico - 192.168.0.0/16). | `"10.1.0.0/8"` |
| `global.config.nats.enabled` | Enable/Disable NATS mode<br> (Allowed values: `true`\`false`) | `true` |
| `global.config.nats.servers` | NATS Server IP/Hostname<br> (**REQUIRED IF ENABLED**) ie "nats://<hostname>:30222" | `"<user input>"` |
| `global.config.nats.serviceMode` | The model for TA<br> (Allowed values: `outbound`)<br> (**REQUIRED IF ENABLED**) | `"outbound"` |
| `global.hvsUrl` | Hvs Base Url, Do not include "/" at the end. e.g for ingress https://hvs.isecl.com/hvs/v2 , for nodeport  https://<control-plane-hostname/control-plane-IP>:30443/hvs/v2 | `"<user input>"` |
| `global.cmsUrl` | CMS Base Url, Do not include "/" at the end. e.g for ingress https://cms.isecl.com/cms/v2 , for nodeport https://<control-plane-hostname/control-plane-IP>:30445/cms/v1 | `"<user input>"` |
| `global.aasUrl` | Authservice Base Url, Do not include "/" at the end. e.g for ingress https://aas.isecl.com/aas/v1 , for nodeport https://<control-plane-hostname/control-plane-IP>:30444/aas/v1 | `"<user input>"` |
| `global.cmsTlsSha384` |  | `"<user input>"` |
| `global.storage.nfs.server` | The NFS Server IP/Hostname<br> (**REQUIRED**) | `"<user input>"` |
| `global.storage.nfs.path` | The path for storing persistent data on NFS | `"/mnt/nfs_share"` |
| `global.service.ta` | The service port for Trust Agent | `31443` |
| `global.aas.secret.adminUsername` | Admin Username for AAS | `null` |
| `global.aas.secret.adminPassword` | Admin Password for AAS | `null` |
| `global.proxyEnabled` | Set to true when running deploying behind corporate proxy | `false` |
| `global.httpProxy` | Set http_proxy url | `"<user input>"` |
| `global.httpsProxy` | Set https_proxy url | `"<user input>"` |
| `global.allProxy` | Set all_proxy url | `"<user input>"` |
| `global.noProxy` | Set no_proxy | `"<user input>"` |



---
_Documentation generated by [Frigate](https://frigate.readthedocs.io)._

