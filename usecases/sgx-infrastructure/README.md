
SGX-Infrastructure
===========

A Helm chart for Deploying ISecL-DC SGX Infrastructure use case


## Configuration

The following table lists the configurable parameters of the Host-attestation chart and their default values.

| Parameter                | Description             | Default        |
| ------------------------ | ----------------------- | -------------- |
| `cms.image.name` | Certificate Management Service image name<br> (**REQUIRED**) | `"<user input>"` |
| `aas.image.name` | Authentication & Authorization Service image name<br> (**REQUIRED**) | `"<user input>"` |
| `aas.secret.dbUsername` | DB Username for AAS DB | `null` |
| `aas.secret.dbPassword` | DB Password for AAS DB | `null` |
| `aas.config.dbMaxConnections` | Determines the maximum number of concurrent connections to the database server. Default is 200 | `200` |
| `aas.config.dbSharedBuffers` | Determines how much memory is dedicated to PostgreSQL to use for caching data. Default is 2GB | `"2GB"` |
| `global-admin-generator.enable` | Set this to true for generating global admin user account | `false` |
| `global-admin-generator.secret.globalAdminUsername` |  | `null` |
| `global-admin-generator.secret.globalAdminPassword` |  | `null` |
| `global-admin-generator.services_list` | Services list for global admin token generation. Accepted values KBS | `["KBS"]` |
| `scs.image.name` | SGX Caching Service image name<br> (**REQUIRED**) | `"<user input>"` |
| `scs.secret.adminUsername` |  | `null` |
| `scs.secret.adminPassword` |  | `null` |
| `scs.secret.dbUsername` | DB Username for SCS DB | `null` |
| `scs.secret.dbPassword` | DB Password for SCS DB | `null` |
| `scs.secret.serviceUsername` |  | `null` |
| `scs.secret.servicePassword` |  | `null` |
| `sqvs.image.name` | SGX Verification service image name<br> (**REQUIRED**) | `"<user input>"` |
| `sqvs.secret.serviceUsername` |  | `null` |
| `sqvs.secret.servicePassword` |  | `null` |
| `sagent.image.name` | SGX agent image name<br> (**REQUIRED**) | `"<user input>"` |
| `sagent.config.isShvsRequired` | set this to false for this usecase | `"false"` |
| `sagent.secret.cccAdminUsername` | ccc admin token username | `null` |
| `sagent.secret.cccAdminPassword` | ccc admin token password | `null` |
| `sagent-aas-manager.createSagentServiceAccount` | Provide values for sagent-aas-manager if enabled, this is a job that creates service account for sagent | `"<user input>"` |
| `sagent-aas-manager.cccAdminUsername` | ccc admin token username | `null` |
| `sagent-aas-manager.cccAdminPassword` | ccc admin token password | `null` |
| `kbs.image.name` | KBS image name<br> (**REQUIRED**) | `"<user input>"` |
| `kbs.secret.installAdminUsername` | Install Admin Username for KBS | `null` |
| `kbs.secret.installAdminPassword` | Install Admin Password for KBS | `null` |
| `kbs.secret.serviceUsername` | Service Username for KBS | `null` |
| `kbs.secret.servicePassword` | Service Password for KBS | `null` |
| `kbs.config.keyManager` | The Key manager for KBS (Allowed values: `kmip`) | `"kmip"` |
| `kbs.config.kmip.serverIp` | The KMIP server IP | `"<user input>"` |
| `kbs.config.kmip.serverHostname` | The KMIP server IP/hostname. Provide same value which is provided during KMIP certificate generation. | `"<user input>"` |
| `kbs.config.kmip.serverPort` | The KMIP server port | `"<user input>"` |
| `global.controlPlaneHostname` | K8s control plane IP/Hostname<br> (**REQUIRED**) | `"<user input>"` |
| `global.versionUpgrade` | Set this true when performing upgrading to next minor/major version | `false` |
| `global.currentVersion` | Set the currently deployed version | `null` |
| `global.image.pullPolicy` | The pull policy for pulling from container registry (Allowed values: `Always`/`IfNotPresent`) | `"Always"` |
| `global.image.imagePullSecret` | The image pull secret for authenticating with image registry, can be left empty if image registry does not require authentication | `null` |
| `global.image.initName` | The image name of init container | `"<user input>"` |
| `global.image.aasManagerName` | The image name of aas-manager image name | `"<user input>"` |
| `global.config.dbhostSSLPodRange` | PostgreSQL DB Host Address(IP address/subnet-mask). IP range varies for different k8s network plugins(Ex: Flannel - 10.1.0.0/8 (default), Calico - 192.168.0.0/16). | `"10.1.0.0/8"` |
| `global.config.nats.enabled` | Enable/Disable NATS mode<br> (Allowed values: `true`\`false`) | `false` |
| `global.config.nats.servers` | NATS Server IP/Hostname<br> (**REQUIRED IF ENABLED**) | `"<user input>"` |
| `global.config.nats.serviceMode` | The model for TA<br> (Allowed values: `outbound`)<br> (**REQUIRED IF ENABLED**) | `"<user input>"` |
| `global.cmsUrl` | CMS Base Url, Do not include "/" at the end. e.g for ingress https://cms.isecl.com/cms/v2 , for nodeport https://<control-plane-hostname/control-plane-IP>:30445/cms/v1 | `"<user input>"` |
| `global.aasUrl` | Authservice Base Url, Do not include "/" at the end. e.g for ingress https://aas.isecl.com/aas/v1 , for nodeport https://<control-plane-hostname/control-plane-IP>:30444/aas/v1 | `"<user input>"` |
| `global.storage.nfs.server` | The NFS Server IP/Hostname<br> (**REQUIRED**) | `"<user input>"` |
| `global.storage.nfs.path` | The path for storing persistent data on NFS | `"/mnt/nfs_share"` |
| `global.service.cms` | The service port for Certificate Management Service | `30445` |
| `global.service.aas` | The service port for Authentication Authorization Service | `30444` |
| `global.service.scs` | The service port for SGX Caching Service | `30502` |
| `global.service.sqvs` | The service port for SGX verification Service | `30503` |
| `global.service.kbs` | The service port for Key Broker Service | `30448` |
| `global.ingress.enable` | Accept true or false to notify ingress rules are enable or disabled | `false` |
| `global.aas.secret.adminUsername` | Service Username for AAS | `null` |
| `global.aas.secret.adminPassword` | Service Password for AAS | `null` |



---
_Documentation generated by [Frigate](https://frigate.readthedocs.io)._

