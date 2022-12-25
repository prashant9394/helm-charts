
Shvs
===========

A Helm chart for Installing ISecL-DC SGX Host Verification Service


## Configuration

The following table lists the configurable parameters of the Shvs chart and their default values.

| Parameter                | Description             | Default        |
| ------------------------ | ----------------------- | -------------- |
| `nameOverride` | The name for SHVS chart<br> (Default: `.Chart.Name`) | `""` |
| `controlPlaneHostname` | K8s control plane IP/Hostname<br> (**REQUIRED**) | `"<user input>"` |
| `dependentServices.cms` |  | `"cms"` |
| `dependentServices.aas` |  | `"aas"` |
| `dependentServices.scs` |  | `"scs"` |
| `config.envVarPrefix` |  | `"SHVS"` |
| `config.dbPort` | PostgreSQL DB port | `5432` |
| `config.dbSSL` | PostgreSQL DB SSL<br> (Allowed Values: `on`/`off`) | `"on"` |
| `config.dbSSLCert` | PostgreSQL DB SSL Cert | `"/etc/postgresql/secrets/server.crt"` |
| `config.dbSSLKey` | PostgreSQL DB SSL Key | `"/etc/postgresql/secrets/server.key"` |
| `config.dbSSLCiphers` | PostgreSQL DB SSL Ciphers | `"ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256"` |
| `config.dbListenAddresses` | PostgreSQL DB Listen Address | `"*"` |
| `config.dbName` | SHVS DB Name | `"shvsdb"` |
| `config.dbMaxConnections` | Determines the maximum number of concurrent connections to the database server. Default is 200 | `200` |
| `config.dbSharedBuffers` | Determines how much memory is dedicated to PostgreSQL to use for caching data. Default is 2GB | `"2GB"` |
| `config.dbSSLMode` | PostgreSQL DB SSL Mode | `"verify-full"` |
| `config.dbhostSSLPodRange` | PostgreSQL DB Host Address(IP address/subnet-mask). IP range varies for different k8s network plugins(Ex: Flannel - 10.1.0.0/8 (default), Calico - 192.168.0.0/16). | `"10.1.0.0/8"` |
| `secret.adminUsername` | Install Admin Username for SHVS | `null` |
| `secret.adminPassword` | Install Admin Password for SHVS | `null` |
| `secret.dbUsername` | DB Username for SHVS DB | `null` |
| `secret.dbPassword` | DB Password for SHVS DB | `null` |
| `secret.serviceUsername` | Service Username for SHVS | `null` |
| `secret.servicePassword` | Service Username for SHVS | `null` |
| `aas.url` | Please update the url section if shvs is exposed via ingress | `"<user input>"` |
| `aas.secret.adminUsername` | Admin Username for AAS | `null` |
| `aas.secret.adminPassword` | Admin Password for AAS | `null` |
| `image.db.registry` | The image registry where PostgreSQL image is pulled from | `"dockerhub.io"` |
| `image.db.name` | The image name of PostgreSQL | `"postgres:14.2"` |
| `image.db.pullPolicy` | The pull policy for pulling from container registry for PostgreSQL image | `"Always"` |
| `image.svc.name` | The image name with which SHVS image is pushed to registry<br> (**REQUIRED**) | `"<user input>"` |
| `image.svc.pullPolicy` | The pull policy for pulling from container registry for SHVS<br> (Allowed values: `Always`/`IfNotPresent`) | `"Always"` |
| `image.svc.imagePullSecret` | The image pull secret for authenticating with image registry, can be left empty if image registry does not require authentication | `"<user input>"` |
| `image.svc.initName` | The image name of init container | `"<user input>"` |
| `image.aasManager.name` | The image name with which AAS-Manager image is pushed to registry<br> (**REQUIRED**) | `"<user input>"` |
| `image.aasManager.pullPolicy` | The pull policy for pulling from container registry for AAS-Manager<br> (Allowed values: `Always`/`IfNotPresent`) | `"Always"` |
| `image.aasManager.imagePullSecret` | The image pull secret for authenticating with image registry, can be left empty if image registry does not require authentication | `"<user input>"` |
| `storage.nfs.server` | The NFS Server IP/Hostname<br> (**REQUIRED**) | `"<user input>"` |
| `storage.nfs.reclaimPolicy` | The reclaim policy for NFS<br> (Allowed values: `Retain`/) | `"Retain"` |
| `storage.nfs.accessModes` | The access modes for NFS<br> (Allowed values: `ReadWriteMany`) | `"ReadWriteMany"` |
| `storage.nfs.path` | The path for storing persistent data on NFS | `"/mnt/nfs_share"` |
| `storage.nfs.dbSize` | The DB size for storing DB data for SHVS in NFS path | `"5Gi"` |
| `storage.nfs.configSize` | The configuration size for storing config for SHVS in NFS path | `"10Mi"` |
| `storage.nfs.logsSize` | The logs size for storing logs for SHVS in NFS path | `"1Gi"` |
| `storage.nfs.baseSize` | The base volume size (configSize + logSize + dbSize) | `"6.1Gi"` |
| `securityContext.shvsdbInit.fsGroup` |  | `2000` |
| `securityContext.shvsdb.runAsUser` |  | `1001` |
| `securityContext.shvsdb.runAsGroup` |  | `1001` |
| `securityContext.shvsInit.fsGroup` |  | `1001` |
| `securityContext.shvs.runAsUser` |  | `1001` |
| `securityContext.shvs.runAsGroup` |  | `1001` |
| `securityContext.shvs.capabilities.drop` |  | `["all"]` |
| `securityContext.shvs.allowPrivilegeEscalation` |  | `false` |
| `service.directoryName` |  | `"shvs"` |
| `service.cms.containerPort` | The containerPort on which CMS can listen | `8445` |
| `service.aas.containerPort` | The containerPort on which AAS can listen | `8444` |
| `service.aas.port` | The externally exposed NodePort on which AAS can listen to external traffic | `30444` |
| `service.scs.containerPort` | The containerPort on which SCS can listen | `9000` |
| `service.scs.port` | The externally exposed NodePort on which SCS can listen to external traffic | `30502` |
| `service.shvsdb.containerPort` | The containerPort on which SHVS DB can listen | `5432` |
| `service.shvs.containerPort` | The containerPort on which SHVS can listen | `13000` |
| `service.shvs.port` | The externally exposed NodePort on which SHVS can listen to external traffic | `30500` |
| `service.ingress.enable` | Accept true or false to notify ingress rules are enable or disabled | `false` |
| `log.loglevel` |  | `"info"` |
| `factory.nameOverride` |  | `""` |



---
_Documentation generated by [Frigate](https://frigate.readthedocs.io)._

