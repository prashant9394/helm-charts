
Fds
===========

A Helm chart for Installing ISecL-DC Feature Discovery Service


## Configuration

The following table lists the configurable parameters of the Fds chart and their default values.

| Parameter                | Description             | Default        |
| ------------------------ | ----------------------- | -------------- |
| `nameOverride` | The name for FDS chart<br> (Default: `.Chart.Name`) | `""` |
| `controlPlaneHostname` | K8s control plane IP/Hostname<br> (**REQUIRED**) | `"<user input>"` |
| `dependentServices.cms` |  | `"cms"` |
| `dependentServices.aas` |  | `"aas"` |
| `config.dbPort` | PostgreSQL DB port | `5432` |
| `config.dbSSL` | PostgreSQL DB SSL<br> (Allowed Values: `on`/`off`) | `"on"` |
| `config.dbSSLCert` | PostgreSQL DB SSL Cert | `"/etc/postgresql/secrets/server.crt"` |
| `config.dbSSLKey` | PostgreSQL DB SSL Key | `"/etc/postgresql/secrets/server.key"` |
| `config.dbSSLCiphers` | PostgreSQL DB SSL Ciphers | `"ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256"` |
| `config.dbListenAddresses` | PostgreSQL DB Listen Address | `"*"` |
| `config.dbName` | FDS DB Name | `"fdsdb"` |
| `config.dbhostSSLPodRange` | PostgreSQL DB Host Address(IP address/subnet-mask). IP range varies for different k8s network plugins(Ex: Flannel - 10.1.0.0/8 (default), Calico - 192.168.0.0/16). | `"10.1.0.0/8"` |
| `config.dbSSLMode` | PostgreSQL DB SSL Mode | `"verify-full"` |
| `aas.url` |  | `null` |
| `aas.secret.adminUsername` | Admin Username for AAS | `null` |
| `aas.secret.adminPassword` | Admin Password for AAS | `null` |
| `secret.dbUsername` | DB Username for FDS DB | `null` |
| `secret.dbPassword` | DB Password for FDS DB | `null` |
| `secret.installAdminUsername` | Admin Username for HVS | `null` |
| `secret.installAdminPassword` | Admin Password for HVS | `null` |
| `image.db.registry` | The image registry where PostgreSQL image is pulled from | `"dockerhub.io"` |
| `image.db.name` | The image name of PostgreSQL | `"postgres:14.2"` |
| `image.db.pullPolicy` | The pull policy for pulling from container registry for PostgreSQL image | `"Always"` |
| `image.svc.name` | The image registry where FDS image is pushed<br> (**REQUIRED**) | `"<user input>"` |
| `image.svc.pullPolicy` | The pull policy for pulling from container registry for FDS <br> (Allowed values: `Always`/`IfNotPresent`) | `"Always"` |
| `image.svc.imagePullSecret` | The image pull secret for authenticating with image registry, can be left empty if image registry does not require authentication | `null` |
| `image.svc.initName` |  | `"<user input>"` |
| `image.aasManager.name` | The image registry where AAS Manager image is pushed<br> (**REQUIRED**) | `"<user input>"` |
| `image.aasManager.pullPolicy` | The pull policy for pulling from container registry for AAS manager <br> (Allowed values: `Always`/`IfNotPresent`) | `"Always"` |
| `image.aasManager.imagePullSecret` | The image pull secret for authenticating with image registry, can be left empty if image registry does not require authentication | `null` |
| `storage.nfs.server` | The NFS Server IP/Hostname<br> (**REQUIRED**) | `"<user input>"` |
| `storage.nfs.reclaimPolicy` | The reclaim policy for NFS<br> (Allowed values: `Retain`/) | `"Retain"` |
| `storage.nfs.accessModes` | The access modes for NFS<br> (Allowed values: ReadWriteMany) | `"ReadWriteMany"` |
| `storage.nfs.path` | The path for storing persistent data on NFS | `"/mnt/nfs_share"` |
| `storage.nfs.dbSize` | The DB size for storing DB data for FDS in NFS path | `"5Gi"` |
| `storage.nfs.configSize` | The configuration size for storing config for FDS in NFS path | `"10Mi"` |
| `storage.nfs.logsSize` | The logs size for storing logs for FDS in NFS path | `"1Gi"` |
| `storage.nfs.baseSize` | The base volume size (configSize + logSize) | `"1.1Gi"` |
| `securityContext.fdsdbInit.fsGroup` |  | `2000` |
| `securityContext.fdsdb.runAsUser` |  | `1001` |
| `securityContext.fdsdb.runAsGroup` |  | `1001` |
| `securityContext.fdsInit.fsGroup` |  | `1001` |
| `securityContext.fds.runAsUser` |  | `1001` |
| `securityContext.fds.runAsGroup` |  | `1001` |
| `securityContext.fds.capabilities.drop` |  | `["all"]` |
| `securityContext.fds.allowPrivilegeEscalation` |  | `false` |
| `securityContext.aasManager.runAsUser` |  | `1001` |
| `securityContext.aasManager.runAsGroup` |  | `1001` |
| `securityContext.aasManager.capabilities.drop` |  | `["all"]` |
| `securityContext.aasManager.allowPrivilegeEscalation` |  | `false` |
| `securityContext.aasManagerInit.fsGroup` |  | `1001` |
| `service.directoryName` | The path name to be appended to all mount paths of the service | `"fds"` |
| `service.cms.containerPort` | The containerPort on which CMS can listen | `8445` |
| `service.aas.containerPort` | The containerPort on which AAS can listen | `8444` |
| `service.aas.port` | The externally exposed NodePort on which AAS can listen to external traffic | `30444` |
| `service.fdsdb.containerPort` | The containerPort on which FDS DB can listen | `5432` |
| `service.fds.containerPort` | The containerPort on which FDS can listen | `13000` |
| `service.fds.port` | The externally exposed NodePort on which FDS can listen to external traffic | `30500` |
| `service.ingress.enable` | Accept true or false to notify ingress rules are enable or disabled | `false` |
| `factory.nameOverride` |  | `""` |



---
_Documentation generated by [Frigate](https://frigate.readthedocs.io)._

