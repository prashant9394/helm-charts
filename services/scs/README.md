
Scs
===========

A Helm chart for Installing ISecL-DC scs Service


## Configuration

The following table lists the configurable parameters of the Scs chart and their default values.

| Parameter                | Description             | Default        |
| ------------------------ | ----------------------- | -------------- |
| `nameOverride` | The name for SCS chart<br> (Default: `.Chart.Name`) | `""` |
| `controlPlaneHostname` | K8s control plane IP/Hostname<br> (**REQUIRED**) | `"<user input>"` |
| `versionUpgrade` | Set this true when performing upgrading to next minor/major version | `false` |
| `currentVersion` | Set the currently deployed version | `null` |
| `dbVersionUpgrade` | Set this to true when there is db version upgrade, say when postgres:11 needs upgrade to postgres:14 | `false` |
| `dependentServices.cms` |  | `"cms"` |
| `dependentServices.aas` |  | `"aas"` |
| `config.envVarPrefix` |  | `"SCS"` |
| `config.dbPort` | PostgreSQL DB port | `5432` |
| `config.dbSSL` | PostgreSQL DB SSL<br> (Allowed Values: `on`/`off`) | `"on"` |
| `config.dbSSLCert` | PostgreSQL DB SSL Cert | `"/etc/postgresql/secrets/server.crt"` |
| `config.dbSSLKey` | PostgreSQL DB SSL Key | `"/etc/postgresql/secrets/server.key"` |
| `config.dbSSLCiphers` | PostgreSQL DB SSL Ciphers | `"ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256"` |
| `config.dbListenAddresses` | PostgreSQL DB Listen Address | `"*"` |
| `config.dbName` | SCS DB Name | `"scsdb"` |
| `config.dbSSLMode` | PostgreSQL DB SSL Mode | `"verify-full"` |
| `config.dbhostSSLPodRange` | PostgreSQL DB Host Address(IP address/subnet-mask). IP range varies for different k8s network plugins(Ex: Flannel - 10.1.0.0/8 (default), Calico - 192.168.0.0/16). | `"10.1.0.0/8"` |
| `config.dbMaxConnections` | Determines the maximum number of concurrent connections to the database server. Default is 200 | `200` |
| `config.dbSharedBuffers` | Determines how much memory is dedicated to PostgreSQL to use for caching data. Default is 2GB | `"2GB"` |
| `config.intelProvisioningServer` | Provide Intel provisioning server Url | `"<user input>"` |
| `config.intelProvisioningServerApiKey` | Provide actual Intel Provisioning Server Api Key | `"<user input>"` |
| `aas.url` |  | `null` |
| `aas.secret.adminUsername` | Admin Username for AAS | `null` |
| `aas.secret.adminPassword` | Admin Password for AAS | `null` |
| `secret.dbUsername` | DB Username for SCS DB | `null` |
| `secret.dbPassword` | DB Password for SCS DB | `null` |
| `secret.serviceUsername` | Admin Username for SCS | `null` |
| `secret.servicePassword` | Admin Password for SCS | `null` |
| `secret.installAdminUsername` | Admin Username for SCS | `null` |
| `secret.installAdminPassword` | Admin Password for SCS | `null` |
| `image.db.registry` | The image registry where PostgreSQL image is pulled from | `"dockerhub.io"` |
| `image.db.name` | The image name of PostgreSQL | `"postgres:14.2"` |
| `image.db.pullPolicy` | The pull policy for pulling from container registry for PostgreSQL image | `"Always"` |
| `image.db.dbVersionUpgradeImage` | The image name of PostgresDB version upgrade | `null` |
| `image.svc.name` | The image name with which SCS image is pushed to registry<br> (**REQUIRED**) | `"<user input>"` |
| `image.svc.pullPolicy` | The pull policy for pulling from container registry for SCS<br> (Allowed values: `Always`/`IfNotPresent`) | `"Always"` |
| `image.svc.imagePullSecret` | The image pull secret for authenticating with image registry, can be left empty if image registry does not require authentication | `null` |
| `image.svc.initName` |  | `"<user input>"` |
| `image.aasManager.name` | The image registry where AAS Manager image is pushed<br> (**REQUIRED**) | `"<user input>"` |
| `image.aasManager.pullPolicy` | The pull policy for pulling from container registry for AAS Manager <br> (Allowed values: `Always`/`IfNotPresent`) | `"Always"` |
| `image.aasManager.imagePullSecret` | The image pull secret for authenticating with image registry, can be left empty if image registry does not require authentication | `null` |
| `storage.nfs.server` | The NFS Server IP/Hostname<br> (**REQUIRED**) | `"<user input>"` |
| `storage.nfs.reclaimPolicy` | The reclaim policy for NFS<br> (Allowed values: `Retain`/) | `"Retain"` |
| `storage.nfs.accessModes` | The access modes for NFS<br> (Allowed values: `ReadWriteMany`) | `"ReadWriteMany"` |
| `storage.nfs.path` | The path for storing persistent data on NFS | `"/mnt/nfs_share"` |
| `storage.nfs.dbSize` | The DB size for storing DB data for SCS in NFS path | `"5Gi"` |
| `storage.nfs.configSize` | The configuration size for storing config for SCS in NFS path | `"10Mi"` |
| `storage.nfs.logsSize` | The logs size for storing logs for SCS in NFS path | `"1Gi"` |
| `storage.nfs.baseSize` | The base volume size (configSize + logSize + dbSize) | `"6.1Gi"` |
| `securityContext.scsdbInit.fsGroup` |  | `2000` |
| `securityContext.scsdb.runAsUser` |  | `1001` |
| `securityContext.scsdb.runAsGroup` |  | `1001` |
| `securityContext.scsInit.fsGroup` |  | `1001` |
| `securityContext.scs.runAsUser` |  | `1001` |
| `securityContext.scs.runAsGroup` |  | `1001` |
| `securityContext.scs.capabilities.drop` |  | `["all"]` |
| `securityContext.scs.allowPrivilegeEscalation` |  | `false` |
| `securityContext.aasManager.runAsUser` |  | `1001` |
| `securityContext.aasManager.runAsGroup` |  | `1001` |
| `securityContext.aasManager.capabilities.drop` |  | `["all"]` |
| `securityContext.aasManager.allowPrivilegeEscalation` |  | `false` |
| `securityContext.aasManagerInit.fsGroup` |  | `1001` |
| `service.directoryName` |  | `"scs"` |
| `service.cms.containerPort` | The containerPort on which CMS can listen | `8445` |
| `service.cms.port` |  | `30445` |
| `service.aas.containerPort` | The containerPort on which AAS can listen | `8444` |
| `service.aas.port` | The externally exposed NodePort on which AAS can listen to external traffic | `30444` |
| `service.scsdb.containerPort` | The containerPort on which SCS DB can listen | `5432` |
| `service.scs.containerPort` | The containerPort on which SCS can listen | `9000` |
| `service.scs.port` | The externally exposed NodePort on which SCS can listen to external traffic | `30502` |
| `service.ingress.enable` | Accept true or false to notify ingress rules are enable or disabled | `false` |
| `log.loglevel` |  | `"info"` |
| `factory.nameOverride` |  | `""` |



---
_Documentation generated by [Frigate](https://frigate.readthedocs.io)._
