
Tee-orchestration
===========

A Helm chart for Deploying TEE Orchestration Use case


## Configuration

The following table lists the configurable parameters of the Tee-orchestration chart and their default values.

| Parameter                | Description             | Default        |
| ------------------------ | ----------------------- | -------------- |
| `cms.image.name` | Certificate Management Service image name<br> (**REQUIRED**) | `"<user input>"` |
| `aas.image.name` | Authentication & Authorization Service image name<br> (**REQUIRED**) | `"<user input>"` |
| `aas.secret.dbUsername` | DB Username for AAS DB | `null` |
| `aas.secret.dbPassword` | DB Password for AAS DB | `null` |
| `aas.config.dbMaxConnections` | Determines the maximum number of concurrent connections to the database server. Default is 200 | `200` |
| `aas.config.dbSharedBuffers` | Determines how much memory is dedicated to PostgreSQL to use for caching data. Default is 2GB | `"2GB"` |
| `tcs.image.name` | TEE caching service image name<br> (**REQUIRED**) | `"<user input>"` |
| `tcs.secret.dbUsername` | DB Username for TCS DB | `null` |
| `tcs.secret.dbPassword` | DB Password for TCS DB | `null` |
| `tcs.secret.intelPcsApiKey` | Intel PCS API Subscription Key | `"<user input>"` |
| `tcs.secret.installAdminUsername` | Admin Username for TCS | `null` |
| `tcs.secret.installAdminPassword` | Admin Password for TCS | `null` |
| `tcs.config.intelPcsUrl` | Intel PCS URL | `"<user input>"` |
| `tcs.config.retryCount` | Retries attempted in case PCS is not responding. Retry count should be in range of 1 to 3. | `"<user input>"` |
| `tcs.config.waitTime` | Time interval between each retry in seconds. Wait time should be less than or equal to 2 seconds. | `"<user input>"` |
| `tcs.config.refreshInterval` | Automatic refresh time of platform collateral. RefreshInterval should be in range of 24 to 720 hours. | `"<user input>"` |
| `tcs.config.dbMaxConnections` | Determines the maximum number of concurrent connections to the database server. Default is 200 | `200` |
| `tcs.config.dbSharedBuffers` | Determines how much memory is dedicated to PostgreSQL to use for caching data. Default is 2GB | `"2GB"` |
| `tcs.config.proxy.proxyEnabled` | checking if proxy is enabled | `false` |
| `tcs.config.proxy.httpProxy` | http proxy url | `null` |
| `tcs.config.proxy.httpsProxy` | https proxy url | `null` |
| `tcs.config.proxy.noProxy` | https proxy url | `null` |
| `tcs.config.proxy.allProxy` | https proxy url | `null` |
| `fds.image.name` | Feature Discovery Service image name<br> (**REQUIRED**) | `"<user input>"` |
| `fds.secret.dbUsername` | DB Username for FDS DB | `null` |
| `fds.secret.dbPassword` | DB Password for FDS DB | `null` |
| `fds.secret.installAdminUsername` | Admin Username for FDS | `null` |
| `fds.secret.installAdminPassword` | Admin Password for FDS | `null` |
| `fds.config.dbMaxConnections` | Determines the maximum number of concurrent connections to the database server. Default is 200 | `200` |
| `fds.config.dbSharedBuffers` | Determines how much memory is dedicated to PostgreSQL to use for caching data. Default is 2GB | `"2GB"` |
| `fda.image.name` | Feature Discovery Agent image name<br> (**REQUIRED**) | `"<user input>"` |
| `fda.config.refreshInterval` | Refresh Interval should be in range of 60 to 240 | `"<user input>"` |
| `fda.config.retryCount` | Retry count should be in range of 1 to 3 | `"<user input>"` |
| `fda.config.validitySeconds` | Validity of custom token in seconds (Note: Value needs to be provided in quotes) | `"<user input>"` |
| `fda.secret.cccAdminUsername` | ccc admin token username | `null` |
| `fda.secret.cccAdminPassword` | ccc admin token password | `null` |
| `fda.nodeLabel.sgxTxtEnabled` | The node label for SGX-ENABLED and TXT-ENABLED hosts<br> (**REQUIRED IF NODE IS SGX or TXT ENABLED**) | `"<user input>"` |
| `isecl-controller.image.name` | ISecL Controller Service image name<br> (**REQUIRED**) | `"<user input>"` |
| `isecl-controller.nodeTainting.taintRegisteredNodes` | If set to true, taints the node which are joined to the k8s cluster. (Allowed values: `true`\`false`) | `false` |
| `isecl-controller.nodeTainting.taintRebootedNodes` | If set to true, taints the node which are rebooted in the k8s cluster. (Allowed values: `true`\`false`) | `false` |
| `isecl-controller.nodeTainting.taintUntrustedNode` | If set to true, taints the node which has trust tag set to false in node labels. (Allowed values: `true`\`false`) | `false` |
| `ihub.image.name` | Integration Hub Service image name<br> (**REQUIRED**) | `"<user input>"` |
| `ihub.k8sApiServerPort` |  | `6443` |
| `ihub.dependentServices.fds` |  | `"fds"` |
| `ihub.secret.installAdminUsername` | Install Admin Username for IHub | `null` |
| `ihub.secret.installAdminPassword` | Install Admin Password for IHub | `null` |
| `ihub.secret.serviceUsername` | Service Username for IHub | `null` |
| `ihub.secret.servicePassword` | Service Password for IHub | `null` |
| `isecl-scheduler.image.name` | ISecL Scheduler image name<br> (**REQUIRED**) | `"<user input>"` |
| `global-admin-generator.enable` | Set this to true for generating global admin user account | `false` |
| `global-admin-generator.secret.globalAdminUsername` | Global admin user | `null` |
| `global-admin-generator.secret.globalAdminPassword` | Global admin password | `null` |
| `global-admin-generator.services_list` | Services list for global admin token generation. Accepted values HVS, WLS, WLA, KBS, APS, FDS, TA, QVS, TCS | `["APS", "FDS", "TCS"]` |
| `global.config.dbhostSSLPodRange` | PostgreSQL DB Host Address(IP address/subnet-mask). IP range varies for different k8s network plugins(Ex: Flannel - 10.1.0.0/8 (default), Calico - 192.168.0.0/16). | `"10.1.0.0/8"` |
| `global.controlPlaneHostname` | K8s control plane IP/Hostname<br> (**REQUIRED**) | `"<user input>"` |
| `global.controlPlaneLabel` | K8s control plane label<br> (**REQUIRED**)<br> Example: `node-role.kubernetes.io/master` in case of `kubeadm`/`microk8s.io/cluster` in case of `microk8s` | `"<user input>"` |
| `global.image.pullPolicy` | The pull policy for pulling from container registry (Allowed values: `Always`/`IfNotPresent`) | `"Always"` |
| `global.image.imagePullSecret` | The image pull secret for authenticating with image registry, can be left empty if image registry does not require authentication | `null` |
| `global.image.initName` | The image name of init container | `"<user input>"` |
| `global.image.aasManagerName` | The image name of aas-manager image name | `"<user input>"` |
| `global.storage.nfs.server` | The NFS Server IP/Hostname<br> (**REQUIRED**) | `"<user input>"` |
| `global.storage.nfs.path` | The path for storing persistent data on NFS | `"/mnt/nfs_share/"` |
| `global.fdsUrl` | Fds Base Url, Do not include "/" at the end. e.g for ingress https://fds.isecl.com/fds/v1 , for nodeport  https://<control-plane-hostname/control-plane-IP>:30500/fds/v1 | `"<user input>"` |
| `global.cmsUrl` | CMS Base Url, Do not include "/" at the end. e.g for ingress https://cms.isecl.com/cms/v1 , for nodeport https://<control-plane-hostname/control-plane-IP>:30445/cms/v1 | `"<user input>"` |
| `global.aasUrl` | Authservice Base Url, Do not include "/" at the end. e.g for ingress https://aas.isecl.com/aas/v1 , for nodeport https://<control-plane-hostname/control-plane-IP>:30444/aas/v1 | `"<user input>"` |
| `global.service.aas` | The service port for Authentication Authorization Service | `30444` |
| `global.service.cms` | The service port for Certificate Management Service | `30445` |
| `global.service.fds` | The service port for Feature Discovery Service | `30500` |
| `global.service.qvs` | The service port for Authentication Authorization Service | `30501` |
| `global.service.tcs` | The service port for TCS Service | `30502` |
| `global.service.isecl-scheduler` | The service port for Isecl scheduler | `30888` |
| `global.aas.secret.adminUsername` | Service Username for AAS | `null` |
| `global.aas.secret.adminPassword` | Service Password for AAS | `null` |
| `global.qvs.isSandBoxEnv` | If SGX node which runs client (SKC client/ SGX Agent) is production grade then mark it "no", else mark it "yes". | `"no"` |
| `global.ingress.enable` | Accept true or false to notify ingress rules are enable or disabled | `false` |
| `global.proxyEnabled` | If proxy is enabled, then set to true | `false` |
| `global.httpProxy` | set HTTP Proxy value | `null` |
| `global.httpsProxy` | set HTTP Proxy value | `null` |
| `global.noProxy` | Append .svc,.svc.cluster.local, to no_proxy | `null` |
| `global.allProxy` | set all proxy value | `null` |



---
_Documentation generated by [Frigate](https://frigate.readthedocs.io)._

