
Trusted-workload-placement-control-plane
===========

A Helm chart for Deploying ISecL-DC Trusted Workload Placement - Control Plane Use case


## Configuration

The following table lists the configurable parameters of the Trusted-workload-placement-control-plane chart and their default values.

| Parameter                | Description             | Default        |
| ------------------------ | ----------------------- | -------------- |
| `cms.image.name` | Certificate Management Service image name<br> (**REQUIRED**) | `"<user input>"` |
| `aas.image.name` | Authentication & Authorization Service image name<br> (**REQUIRED**) | `"<user input>"` |
| `aas.secret.dbUsername` | DB Username for AAS DB | `null` |
| `aas.secret.dbPassword` | DB Password for AAS DB | `null` |
| `aas.config.dbMaxConnections` | Determines the maximum number of concurrent connections to the database server. Default is 200 | `200` |
| `aas.config.dbSharedBuffers` | Determines how much memory is dedicated to PostgreSQL to use for caching data. Default is 2GB | `"2GB"` |
| `hvs.image.name` | Host Verification Service image name<br> (**REQUIRED**) | `"<user input>"` |
| `hvs.config.requireEKCertForHostProvision` | If set to true enforce ta hardening <br> (Allowed values: `true`\`false`) | `false` |
| `hvs.config.verifyQuoteForHostRegistration` | If set to true enforce ta hardening <br> (Allowed values: `true`\`false`) | `false` |
| `hvs.config.dbMaxConnections` | Determines the maximum number of concurrent connections to the database server. Default is 200 | `200` |
| `hvs.config.dbSharedBuffers` | Determines how much memory is dedicated to PostgreSQL to use for caching data. Default is 2GB Default is 2GB | `"2GB"` |
| `hvs.secret.dbUsername` | DB Username for HVS DB | `null` |
| `hvs.secret.dbPassword` | DB Password for HVS DB | `null` |
| `hvs.secret.installAdminUsername` | Install Admin Username for HVS | `null` |
| `hvs.secret.installAdminPassword` | Install Admin Password for HVS | `null` |
| `hvs.secret.serviceUsername` | Service Username for HVS | `null` |
| `hvs.secret.servicePassword` | Service Password for HVS | `null` |
| `nats.clientPort` |  | `30222` |
| `nats-init.image.name` | The image name of nats-init container | `"<user input>"` |
| `nats-init.secret.installAdminUsername` | Install Admin Username for Nats init | `null` |
| `nats-init.secret.installAdminPassword` | Install Admin Password for Nats init | `null` |
| `global-admin-generator.enable` | Set this to true for generating global admin user account | `false` |
| `global-admin-generator.secret.globalAdminUsername` |  | `null` |
| `global-admin-generator.secret.globalAdminPassword` |  | `null` |
| `global-admin-generator.services_list` | Services list for global admin token generation. Accepted values HVS, WLS, KBS, APS, FDS, TA, QVS, TCS | `["HVS"]` |
| `global.controlPlaneHostname` | K8s control plane IP/Hostname<br> (**REQUIRED**) | `"<user input>"` |
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
| `global.config.nats.servers` | NATS Server IP/Hostname<br> (**REQUIRED IF ENABLED**) e.g nats://192.1.2.4:30222 | `"nats://<DNS>:<Node-Port>"` |
| `global.storage.nfs.server` | The NFS Server IP/Hostname<br> (**REQUIRED**) | `"<user input>"` |
| `global.storage.nfs.path` | The path for storing persistent data on NFS | `"/mnt/nfs_share"` |
| `global.service.cms` | The service port for Certificate Management Service | `30445` |
| `global.service.aas` | The service port for Authentication Authorization Service | `30444` |
| `global.service.hvs` | The service port for SGX Host Verification Service | `30443` |
| `global.ingress.enable` | Accept true or false to notify ingress rules are enable or disabled, Default value: false | `false` |
| `global.aas.secret.adminUsername` | Admin Username for AAS | `null` |
| `global.aas.secret.adminPassword` | Admin Password for AAS | `null` |
| `global.proxyEnabled` | Set to true when running deploying behind corporate proxy | `false` |
| `global.httpProxy` | Set http_proxy url | `"<user input>"` |
| `global.httpsProxy` | Set https_proxy url | `"<user input>"` |
| `global.allProxy` | Set all_proxy url | `"<user input>"` |
| `global.noProxy` | Set no_proxy | `"<user input>"` |



---
_Documentation generated by [Frigate](https://frigate.readthedocs.io)._

