
Host-attestation
===========

A Helm chart for Deploying ISecL-DC Platform Attestation Use case


## Configuration

The following table lists the configurable parameters of the Host-attestation chart and their default values.

| Parameter                | Description             | Default        |
| ------------------------ | ----------------------- | -------------- |
| `cms.image.name` | Certificate Management Service image name<br> (**REQUIRED**) | `"<user input>"` |
| `aas.image.name` | Authentication & Authorization Service image name<br> (**REQUIRED**) | `"<user input>"` |
| `aas-manager.image.name` | Authentication & Authorization Manager image name<br> (**REQUIRED**) | `"<user input>"` |
| `hvs.image.name` | Host Verification Service image name<br> (**REQUIRED**) | `"<user input>"` |
| `ta.image.name` | Trust Agent image name<br> (**REQUIRED**) | `"<user input>"` |
| `global.controlPlaneHostname` | K8s control plane IP/Hostname<br> (**REQUIRED**) | `"<user input>"` |
| `global.hardwareFeature` | The enabled hardware feature on the host<br> (**REQUIRED**)<br> (Allowed Values: `TXT`/`SUEFI`) | `"<user input>"` |
| `global.image.registry` | The image registry where isecl images are pushed<br> (**REQUIRED**) | `"<user input>"` |
| `global.image.pullPolicy` | The pull policy for pulling from container registry (Allowed values: `Always`/`IfNotPresent`) | `"Always"` |
| `global.config.nats.enabled` | Enable/Disable NATS mode<br> (Allowed values: `true`\`false`) | `false` |
| `global.config.nats.servers` | NATS Server IP/Hostname<br> (**REQUIRED IF ENABLED**) | `"<user input>"` |
| `global.config.nats.serviceMode` | The model for TA<br> (Allowed values: `outbound`)<br> (**REQUIRED IF ENABLED**) | `"<user input>"` |
| `global.storage.nfs.server` | The NFS Server IP/Hostname<br> (**REQUIRED**) | `"<user input>"` |
| `global.storage.nfs.path` | The path for storing persistent data on NFS | `"/mnt/nfs_share/"` |
| `global.service.cms` | The service port for Certificate Management Service | `30445` |
| `global.service.aas` | The service port for Authentication Authorization Service | `30444` |
| `global.service.hvs` | The service port for Host Verification Service | `30443` |
| `global.service.ta` | The service port for Trust Agent | `31443` |
| `cms.nameOverride` | The name for CMS chart<br> (Default: `.Chart.Name`) | `""` |
| `cms.controlPlaneHostname` | K8s control plane IP/Hostname<br> (**REQUIRED**) | `"<user input>"` |
| `cms.dependentServices.aas` |  | `"aas"` |
| `cms.image.registry` | The image registry where CMS image is pushed<br> (**REQUIRED**) | `"<user input>"` |
| `cms.image.pullPolicy` | The pull policy for pulling from container registry for CMS<br> (Allowed values: `Always`/`IfNotPresent`) | `"Always"` |
| `cms.storage.nfs.server` | The NFS Server IP/Hostname<br> (**REQUIRED**) | `"<user input>"` |
| `cms.storage.nfs.reclaimPolicy` | The reclaim policy for NFS<br> (Allowed values: `Retain`/) | `"Retain"` |
| `cms.storage.nfs.accessModes` | The access modes for NFS<br> (Allowed values: `ReadWriteMany`) | `"ReadWriteMany"` |
| `cms.storage.nfs.path` | The path for storing persistent data on NFS | `"/mnt/nfs_share"` |
| `cms.storage.nfs.configSize` | The configuration size for storing config for CMS in NFS path | `"10Mi"` |
| `cms.storage.nfs.logsSize` | The logs size for storing logs for CMS in NFS path | `"1Gi"` |
| `cms.securityContext.init.fsGroup` |  | `1001` |
| `cms.securityContext.cms.runAsUser` |  | `1001` |
| `cms.securityContext.cms.runAsGroup` |  | `1001` |
| `cms.securityContext.cms.capabilities.drop` |  | `["all"]` |
| `cms.securityContext.cms.allowPrivilegeEscalation` |  | `false` |
| `cms.service.cms.containerPort` | The containerPort on which CMS can listen to traffic | `8445` |
| `cms.service.cms.port` | The externally exposed NodePort on which CMS can listen to external traffic | `30445` |
| `cms.service.aas.containerPort` | The containerPort on which CMS can listen to traffic | `8444` |
| `aas.nameOverride` | The name for AAS chart<br> (Default: `.Chart.Name`) | `""` |
| `aas.controlPlaneHostname` | K8s control plane IP/Hostname<br> (**REQUIRED**) | `"<user input>"` |
| `aas.dependentServices.cms` |  | `"cms"` |
| `aas.config.dbPort` | PostgreSQL DB port | `5432` |
| `aas.config.dbSSL` | PostgreSQL DB SSL<br> (Allowed: `on`/`off`) | `"on"` |
| `aas.config.dbSSLCert` | PostgreSQL DB SSL Cert | `"/etc/postgresql/secrets/server.crt"` |
| `aas.config.dbSSLKey` | PostgreSQL DB SSL Key | `"/etc/postgresql/secrets/server.key"` |
| `aas.config.dbSSLCiphers` | PostgreSQL DB SSL Ciphers | `"ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256"` |
| `aas.config.dbListenAddresses` | PostgreSQL DB Listen Address | `"*"` |
| `aas.config.dbName` | AAS DB Name | `"aasdb"` |
| `aas.config.dbSSLMode` | PostgreSQL DB SSL Mode | `"verify-full"` |
| `aas.secret.dbUsername` | DB Username for AAS DB | `"aasdbuser"` |
| `aas.secret.dbPassword` | DB Password for AAS DB | `"aasdbpassword"` |
| `aas.secret.adminUsername` | Admin Username for AAS | `"aasAdminUser"` |
| `aas.secret.adminPassword` | Admin Password for AAS | `"aasAdminPass"` |
| `aas.image.aasdb.registry` | The image registry where PostgreSQL image is pulled from | `"dockerhub.io"` |
| `aas.image.aasdb.name` | The image name of PostgreSQL | `"postgres:11.7"` |
| `aas.image.aasdb.pullPolicy` | The pull policy for pulling from container registry for PostgreSQL image<br> (Allowed values: `Always`/`IfNotPresent`) | `"Always"` |
| `aas.image.aas.registry` | The image registry where AAS image is pushed<br> (**REQUIRED**) | `"<user input>"` |
| `aas.image.aas.name` | The image name with which CMS image is pushed to registry | `"<user input>"` |
| `aas.image.aas.pullPolicy` | The pull policy for pulling from container registry for AAS<br> (Allowed values: `Always`/`IfNotPresent`) | `"Always"` |
| `aas.storage.nfs.server` | The NFS Server IP/Hostname | `"<user input>"` |
| `aas.storage.nfs.reclaimPolicy` | The reclaim policy for NFS<br> (Allowed values: `Retain`/) | `"Retain"` |
| `aas.storage.nfs.accessModes` | The access modes for NFS<br> (Allowed values: `ReadWriteMany`) | `"ReadWriteMany"` |
| `aas.storage.nfs.path` | The path for storing persistent data on NFS | `"/mnt/nfs_share"` |
| `aas.storage.nfs.dbSize` | The DB size for storing DB data for AAS in NFS path | `"1Gi"` |
| `aas.storage.nfs.configSize` | The configuration size for storing config for AAS in NFS path | `"10Mi"` |
| `aas.storage.nfs.logsSize` | The logs size for storing logs for AAS in NFS path | `"1Gi"` |
| `aas.securityContext.aasdbInit.fsGroup` |  | `1001` |
| `aas.securityContext.aasdb.runAsUser` |  | `1001` |
| `aas.securityContext.aasdb.runAsGroup` |  | `1001` |
| `aas.securityContext.aasInit.fsGroup` |  | `1001` |
| `aas.securityContext.aas.runAsUser` |  | `1001` |
| `aas.securityContext.aas.runAsGroup` |  | `1001` |
| `aas.securityContext.aas.capabilities.drop` |  | `["all"]` |
| `aas.securityContext.aas.allowPrivilegeEscalation` |  | `false` |
| `aas.service.cms.containerPort` | The containerPort on which CMS can listen | `8445` |
| `aas.service.cms.port` | The externally exposed NodePort on which CMS can listen to external traffic | `30445` |
| `aas.service.aasdb.containerPort` | The containerPort on which AAS DB can listen | `5432` |
| `aas.service.aas.containerPort` | The containerPort on which AAS can listen | `8444` |
| `aas.service.aas.port` | The externally exposed NodePort on which AAS can listen to external traffic | `30444` |
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
| `hvs.nameOverride` | The name for HVS chart<br> (Default: `.Chart.Name`) | `""` |
| `hvs.controlPlaneHostname` | K8s control plane IP/Hostname<br> (**REQUIRED**) | `"<user input>"` |
| `hvs.dependentServices.cms` |  | `"cms"` |
| `hvs.dependentServices.aas` |  | `"aas"` |
| `hvs.config.dbPort` | PostgreSQL DB port | `5432` |
| `hvs.config.dbSSL` | PostgreSQL DB SSL<br> (Allowed Values: `on`/`off`) | `"on"` |
| `hvs.config.dbSSLCert` | PostgreSQL DB SSL Cert | `"/etc/postgresql/secrets/server.crt"` |
| `hvs.config.dbSSLKey` | PostgreSQL DB SSL Key | `"/etc/postgresql/secrets/server.key"` |
| `hvs.config.dbSSLCiphers` | PostgreSQL DB SSL Ciphers | `"ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256"` |
| `hvs.config.dbListenAddresses` | PostgreSQL DB Listen Address | `"*"` |
| `hvs.config.dbName` | HVS DB Name | `"hvsdb"` |
| `hvs.config.dbSSLMode` | PostgreSQL DB SSL Mode | `"verify-full"` |
| `hvs.secret.dbUsername` | DB Username for HVS DB | `"hvsdbuser"` |
| `hvs.secret.dbPassword` | DB Password for HVS DB | `"hvsdbpassword"` |
| `hvs.secret.adminUsername` | Admin Username for HVS | `"hvsAdminUser"` |
| `hvs.secret.adminPassword` | Admin Password for HVS | `"hvsAdminPass"` |
| `hvs.image.hvsdb.registry` | The image registry where PostgreSQL image is pulled from | `"dockerhub.io"` |
| `hvs.image.hvsdb.name` | The image name of PostgreSQL | `"postgres:11.7"` |
| `hvs.image.hvsdb.pullPolicy` | The pull policy for pulling from container registry for PostgreSQL image | `"Always"` |
| `hvs.image.hvs.registry` | The image registry where HVS image is pushed<br> (**REQUIRED**) | `"<user input>"` |
| `hvs.image.hvs.name` | The image name with which CMS image is pushed to registry<br> (**REQUIRED**) | `"<user input>"` |
| `hvs.image.hvs.pullPolicy` | The pull policy for pulling from container registry for HVS<br> (Allowed values: `Always`/`IfNotPresent`) | `"Always"` |
| `hvs.storage.nfs.server` | The NFS Server IP/Hostname<br> (**REQUIRED**) | `"<user input>"` |
| `hvs.storage.nfs.reclaimPolicy` | The reclaim policy for NFS<br> (Allowed values: `Retain`/) | `"Retain"` |
| `hvs.storage.nfs.accessModes` | The access modes for NFS<br> (Allowed values: `ReadWriteMany`) | `"ReadWriteMany"` |
| `hvs.storage.nfs.path` | The path for storing persistent data on NFS | `"/mnt/nfs_share"` |
| `hvs.storage.nfs.dbSize` | The DB size for storing DB data for HVS in NFS path | `"5Gi"` |
| `hvs.storage.nfs.configSize` | The configuration size for storing config for HVS in NFS path | `"10Mi"` |
| `hvs.storage.nfs.logsSize` | The logs size for storing logs for HVS in NFS path | `"1Gi"` |
| `hvs.securityContext.hvsdbInit.fsGroup` |  | `2000` |
| `hvs.securityContext.hvsdb.runAsUser` |  | `1001` |
| `hvs.securityContext.hvsdb.runAsGroup` |  | `1001` |
| `hvs.securityContext.hvsInit.fsGroup` |  | `1001` |
| `hvs.securityContext.hvs.runAsUser` |  | `1001` |
| `hvs.securityContext.hvs.runAsGroup` |  | `1001` |
| `hvs.securityContext.hvs.capabilities.drop` |  | `["all"]` |
| `hvs.securityContext.hvs.allowPrivilegeEscalation` |  | `false` |
| `hvs.service.cms.containerPort` | The containerPort on which CMS can listen | `8445` |
| `hvs.service.aas.containerPort` | The containerPort on which AAS can listen | `8444` |
| `hvs.service.hvsdb.containerPort` | The containerPort on which HVS DB can listen | `5432` |
| `hvs.service.hvs.containerPort` | The containerPort on which HVS can listen | `8443` |
| `hvs.service.hvs.port` | The externally exposed NodePort on which HVS can listen to external traffic | `30443` |



---
_Documentation generated by [Frigate](https://frigate.readthedocs.io)._

