
Tcs
===========

A Helm chart for Installing ISecL-DC TEE Caching Service


## Configuration

The following table lists the configurable parameters of the Tcs chart and their default values.

| Parameter                | Description             | Default        |
| ------------------------ | ----------------------- | -------------- |
| `nameOverride` | The name for TCS chart<br> (Default: `.Chart.Name`) | `""` |
| `controlPlaneHostname` | K8s control plane IP/Hostname<br> (**REQUIRED**) | `"<user input>"` |
| `dependentServices.cms` |  | `"cms"` |
| `dependentServices.aas` |  | `"aas"` |
| `config.envVarPrefix` |  | `"TCS"` |
| `config.dbPort` | PostgreSQL DB port | `5432` |
| `config.dbSSL` | PostgreSQL DB SSL<br> (Allowed: `on`/`off`) | `"on"` |
| `config.dbSSLCert` | PostgreSQL DB SSL Cert | `"/etc/postgresql/secrets/server.crt"` |
| `config.dbSSLKey` | PostgreSQL DB SSL Key | `"/etc/postgresql/secrets/server.key"` |
| `config.dbSSLCiphers` | PostgreSQL DB SSL Ciphers | `"ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256"` |
| `config.dbListenAddresses` | PostgreSQL DB Listen Address | `"*"` |
| `config.dbName` | TCS DB Name | `"tcsdb"` |
| `config.dbSSLMode` | PostgreSQL DB SSL Mode | `"verify-full"` |
| `config.intelPcsUrl` | Intel PCS URL | `"https://api.trustedservices.intel.com/sgx/certification/v4"` |
| `config.dbhostSSLPodRange` | PostgreSQL DB Host Address(IP address/subnet-mask). IP range varies for different k8s network plugins(Ex: Flannel - 10.1.0.0/8 (default), Calico - 192.168.0.0/16). | `"10.1.0.0/8"` |
| `config.retryCount` | Retries attempted in case PCS is not responding | `3` |
| `config.waitTime` | Time interval between each retry in seconds | `1` |
| `config.refreshInterval` | Automatic refresh time of platform collateral | `6` |
| `config.proxy.proxyEnabled` | checking if proxy is enabled | `false` |
| `config.proxy.httpProxy` | http proxy url | `null` |
| `config.proxy.httpsProxy` | https proxy url | `null` |
| `config.proxy.noProxy` | https proxy url | `null` |
| `config.proxy.allProxy` | https proxy url | `null` |
| `aas.url` |  | `null` |
| `aas.secret.adminUsername` | Admin Username for AAS | `null` |
| `aas.secret.adminPassword` | Admin Password for AAS | `null` |
| `secret.dbUsername` | DB Username for TCS DB | `null` |
| `secret.dbPassword` | DB Password for TCS DB | `null` |
| `secret.intelPcsApiKey` | Intel PCS API Subscription Key | `"<user input>"` |
| `secret.installAdminUsername` | Admin Username for HVS | `null` |
| `secret.installAdminPassword` | Admin Password for HVS | `null` |
| `image.db.registry` | The image registry where PostgreSQL image is pulled from | `"dockerhub.io"` |
| `image.db.name` | The image name of PostgreSQL | `"postgres:11.7"` |
| `image.db.pullPolicy` | The pull policy for pulling from container registry for PostgreSQL image<br> (Allowed values: `Always`/`IfNotPresent`) | `"Always"` |
| `image.svc.name` | The image registry where TCS image is pushed<br> (**REQUIRED**) | `"<user input>"` |
| `image.svc.pullPolicy` | The pull policy for pulling from container registry for TCS <br> (Allowed values: `Always`/`IfNotPresent`) | `"Always"` |
| `image.svc.imagePullSecret` | The image pull secret for authenticating with image registry, can be left empty if image registry does not require authentication | `null` |
| `image.svc.initName` |  | `"<user input>"` |
| `image.aasManager.name` | The image registry where AAS Manager image is pushed<br> (**REQUIRED**) | `"<user input>"` |
| `image.aasManager.pullPolicy` | The pull policy for pulling from container registry for AAS Manager <br> (Allowed values: `Always`/`IfNotPresent`) | `"Always"` |
| `image.aasManager.imagePullSecret` | The image pull secret for authenticating with image registry, can be left empty if image registry does not require authentication | `null` |
| `storage.nfs.server` | The NFS Server IP/Hostname | `"<user input>"` |
| `storage.nfs.reclaimPolicy` | The reclaim policy for NFS<br> (Allowed values: `Retain`/) | `"Retain"` |
| `storage.nfs.accessModes` | The access modes for NFS<br> (Allowed values: `ReadWriteMany`) | `"ReadWriteMany"` |
| `storage.nfs.path` | The path for storing persistent data on NFS | `"/mnt/nfs_share"` |
| `storage.nfs.dbSize` | The DB size for storing DB data for TCS in NFS path | `"1Gi"` |
| `storage.nfs.configSize` | The configuration size for storing config for TCS in NFS path | `"10Mi"` |
| `storage.nfs.logsSize` | The logs size for storing logs for TCS in NFS path | `"1Gi"` |
| `storage.nfs.baseSize` | The base volume size (configSize + logSize + dbSize) | `"2.1Gi"` |
| `securityContext.tcsdbInit.fsGroup` |  | `1001` |
| `securityContext.tcsdb.runAsUser` |  | `1001` |
| `securityContext.tcsdb.runAsGroup` |  | `1001` |
| `securityContext.tcsInit.fsGroup` |  | `1001` |
| `securityContext.tcs.runAsUser` |  | `1001` |
| `securityContext.tcs.runAsGroup` |  | `1001` |
| `securityContext.tcs.capabilities.drop` |  | `["all"]` |
| `securityContext.tcs.allowPrivilegeEscalation` |  | `false` |
| `securityContext.aasManager.runAsUser` |  | `1001` |
| `securityContext.aasManager.runAsGroup` |  | `1001` |
| `securityContext.aasManager.capabilities.drop` |  | `["all"]` |
| `securityContext.aasManager.allowPrivilegeEscalation` |  | `false` |
| `securityContext.aasManagerInit.fsGroup` |  | `1001` |
| `service.directoryName` |  | `"tcs"` |
| `service.cms.containerPort` | The containerPort on which CMS can listen | `8445` |
| `service.cms.port` | The externally exposed NodePort on which CMS can listen to external traffic | `30445` |
| `service.aas.containerPort` | The containerPort on which AAS can listen | `8444` |
| `service.aas.port` | The externally exposed NodePort on which AAS can listen to external traffic | `30444` |
| `service.tcsdb.containerPort` | The containerPort on which TCS DB can listen | `5432` |
| `service.tcs.containerPort` | The containerPort on which TCS can listen | `9000` |
| `service.tcs.port` | The externally exposed NodePort on which TCS can listen to external traffic | `30502` |
| `service.ingress.enable` | Accept true or false to notify ingress rules are enable or disabled | `false` |
| `factory.nameOverride` |  | `""` |



---
_Documentation generated by [Frigate](https://frigate.readthedocs.io)._

