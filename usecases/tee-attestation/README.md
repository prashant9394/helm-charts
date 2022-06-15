
Tee-attestation
===========

A Helm chart for Deploying TEE Attestation Use case


## Configuration

The following table lists the configurable parameters of the Tee-attestation chart and their default values.

| Parameter                | Description             | Default        |
| ------------------------ | ----------------------- | -------------- |
| `cms.image.name` | Certificate Management Service image name<br> (**REQUIRED**) | `"<user input>"` |
| `aas.image.name` | Authentication & Authorization Service image name<br> (**REQUIRED**) | `"<user input>"` |
| `aas.config.dbMaxConnections` | Determines the maximum number of concurrent connections to the database server. Default is 200 | `200` |
| `aas.config.dbSharedBuffers` | Determines how much memory is dedicated to PostgreSQL to use for caching data. Default is 2GB | `"2GB"` |
| `aas.secret.dbUsername` | DB Username for AAS DB | `null` |
| `aas.secret.dbPassword` | DB Password for AAS DB | `null` |
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
| `qvs.image.name` | Quote Verification image name<br> (**REQUIRED**) | `"<user input>"` |
| `qvs.secret.installAdminUsername` | Admin user name for QVS | `null` |
| `qvs.secret.installAdminPassword` | Admin Password for QVS | `null` |
| `fda.image.name` | Feature Discovery Agent image name<br> (**REQUIRED**) | `"<user input>"` |
| `fda.config.refreshInterval` | Refresh Interval should be in range of 60 to 240 seconds | `"<user input>"` |
| `fda.config.retryCount` | Retry count should be in range of 1 to 3 | `"<user input>"` |
| `fda.config.validitySeconds` | Validity of custom token in seconds (Note: Value needs to be provided in quotes) | `"<user input>"` |
| `fda.secret.cccAdminUsername` | ccc admin token username | `null` |
| `fda.secret.cccAdminPassword` | ccc admin token password | `null` |
| `fda.nodeLabel.sgxTxtEnabled` | The node label for SGX-ENABLED and TXT-ENABLED hosts<br> (**REQUIRED IF NODE IS SGX or TXT ENABLED**) | `"<user input>"` |
| `aps.image.name` | Attestation policy service image name<br> (**REQUIRED**) | `"<user input>"` |
| `aps.secret.dbUsername` | DB Username for APS DB | `null` |
| `aps.secret.dbPassword` | DB Password for APS DB | `null` |
| `aps.secret.installAdminUsername` | Admin Username for APS | `null` |
| `aps.secret.installAdminPassword` | Admin Password for APS | `null` |
| `aps.secret.serviceUsername` |  | `null` |
| `aps.secret.servicePassword` |  | `null` |
| `aps.config.dbMaxConnections` | Determines the maximum number of concurrent connections to the database server. Default is 200 | `200` |
| `aps.config.dbSharedBuffers` | Determines how much memory is dedicated to PostgreSQL to use for caching data. Default is 2GB | `"2GB"` |
| `kbs.image.name` | Key Broker Service image name<br> (**REQUIRED**) | `"<user input>"` |
| `kbs.config.kmip.serverIp` | The KMIP server IP | `"<user input>"` |
| `kbs.config.kmip.serverHostname` | The KMIP server IP/hostname. Provide same value which is provided during KMIP certificate generation. | `"<user input>"` |
| `kbs.config.kmip.serverPort` | The KMIP server port | `"<user input>"` |
| `kbs.config.tee` |  | `true` |
| `kbs.secret.installAdminUsername` | Install Admin Username for KBS | `null` |
| `kbs.secret.installAdminPassword` | Install Admin Password for KBS | `null` |
| `kbs.secret.cccUsername` | Custom Claims Creator Username | `null` |
| `kbs.secret.cccPassword` | Custom Claims Creator Password | `null` |
| `kbs.customToken.validitySeconds` | Custom Token validity in seconds (Default: "31536000") | `"31536000"` |
| `global-admin-generator.enable` | Set this to true for generating global admin user account | `false` |
| `global-admin-generator.secret.globalAdminUsername` | Global admin user | `null` |
| `global-admin-generator.secret.globalAdminPassword` | Global admin password | `null` |
| `global-admin-generator.services_list` | Services list for global admin token generation. Accepted values HVS, WLS, KBS, APS, FDS, TA, QVS, TCS | `["APS", "TCS", "KBS", "QVS"]` |
| `global.controlPlaneHostname` | K8s control plane IP/Hostname<br> (**REQUIRED**) | `"<user input>"` |
| `global.controlPlaneLabel` | K8s control plane label<br> (**REQUIRED**)<br> Example: `node-role.kubernetes.io/master` in case of `kubeadm`/`microk8s.io/cluster` in case of `microk8s` | `"microk8s.io/cluster"` |
| `global.image.pullPolicy` | The pull policy for pulling from container registry (Allowed values: `Always`/`IfNotPresent`) | `"Always"` |
| `global.image.imagePullSecret` | The image pull secret for authenticating with image registry, can be left empty if image registry does not require authentication | `null` |
| `global.image.initName` | The image name of init container | `"<user input>"` |
| `global.image.aasManagerName` | The image name of aas-manager image name | `"<user input>"` |
| `global.config.dbhostSSLPodRange` | PostgreSQL DB Host Address(IP address/subnet-mask). IP range varies for different k8s network plugins(Ex: Flannel - 10.1.0.0/8 (default), Calico - 192.168.0.0/16). | `"10.1.0.0/8"` |
| `global.storage.nfs.server` | The NFS Server IP/Hostname<br> (**REQUIRED**) | `"<user input>"` |
| `global.storage.nfs.path` | The path for storing persistent data on NFS | `"/mnt/nfs_share/"` |
| `global.service.aas` | The service port for Authentication Authorization Service | `30444` |
| `global.service.cms` | The service port for Certificate Management Service | `30445` |
| `global.service.kbs` | The service port for Key broker service | `30448` |
| `global.service.tcs` | The service port for Authentication Authorization Service | `30502` |
| `global.service.qvs` | The service port for TCS Service | `30501` |
| `global.service.aps` | The service port for Attestation policy service | `30503` |
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

