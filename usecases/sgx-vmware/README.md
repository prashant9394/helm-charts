
SGX-VMWare
===========

A Helm chart for Deploying ISecL-DC SGX Infrastructure use case for caching of platform data.


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
| `scs.secret.adminUsername` |  | `"<user input>"` |
| `scs.secret.adminPassword` |  | `"<user input>"` |
| `scs.secret.dbUsername` | DB Username for SCS DB | `"<user input>"` |
| `scs.secret.dbPassword` | DB Password for SCS DB | `"<user input>"` |
| `scs.secret.serviceUsername` |  | `"<user input>"` |
| `scs.secret.servicePassword` |  | `"<user input>"` |
| `sagent.image.name` | SGX agent image name<br> (**REQUIRED**) | `"<user input>"` |
| `sagent.config.isShvsRequired` | set this to false for this usecase | `"false"` |
| `sagent.secret.cccAdminUsername` | ccc admin token username | `"<user input>"` |
| `sagent.secret.cccAdminPassword` | ccc admin token password | `"<user input>"` |
| `sagent-aas-manager.createSagentServiceAccount` | Provide values for sagent-aas-manager if enabled, this is a job that creates service account for sagent | `null` |
| `sagent-aas-manager.cccAdminUsername` | ccc admin token username | `"<user input>"` |
| `sagent-aas-manager.cccAdminPassword` | ccc admin token password | `"<user input>"` |
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
| `global.ingress.enable` | Accept true or false to notify ingress rules are enable or disabled | `false` |
| `global.aas.secret.adminUsername` | Service Username for AAS | `null` |
| `global.aas.secret.adminPassword` | Service Password for AAS | `null` |



---
_Documentation generated by [Frigate](https://frigate.readthedocs.io)._

