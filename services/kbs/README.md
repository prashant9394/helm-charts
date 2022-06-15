
Kbs
===========

A Helm chart for Installing ISecL-DC Key Broker Service


## Configuration

The following table lists the configurable parameters of the Kbs chart and their default values.

| Parameter                | Description             | Default        |
| ------------------------ | ----------------------- | -------------- |
| `nameOverride` | The name for KBS chart<br> (Default: `.Chart.Name`) | `""` |
| `controlPlaneHostname` | K8s control plane IP/Hostname<br> (**REQUIRED**) | `"<user input>"` |
| `dependentServices.cms` |  | `"cms"` |
| `dependentServices.aas` |  | `"aas"` |
| `dependentServices.aps` |  | `"aps"` |
| `image.svc.name` | The image name with which KBS image is pushed to registry<br> (**REQUIRED**) | `"<user input>"` |
| `image.svc.pullPolicy` | The pull policy for pulling from container registry for KBS<br> (Allowed values: `Always`/`IfNotPresent`) | `"Always"` |
| `image.svc.imagePullSecret` | The image pull secret for authenticating with image registry, can be left empty if image registry does not require authentication | `null` |
| `image.svc.initName` | The image name of init container | `"<user input>"` |
| `image.aasManager.name` | The image name with which AAS-Manager image is pushed to registry<br> (**REQUIRED**) | `"<user input>"` |
| `image.aasManager.pullPolicy` | The pull policy for pulling from container registry for AAS-Manager<br> (Allowed values: `Always`/`IfNotPresent`) | `"Always"` |
| `image.aasManager.imagePullSecret` | The image pull secret for authenticating with image registry, can be left empty if image registry does not require authentication | `null` |
| `config.keyManager` | The Key manager for KBS (Allowed values: `kmip`) | `"kmip"` |
| `config.kmip.serverIp` | The KMIP server IP | `"<user input>"` |
| `config.kmip.serverHostname` | The KMIP server IP/hostname. Provide same value which is provided during KMIP certificate generation. | `"<user input>"` |
| `config.kmip.serverPort` | The KMIP server port | `"<user input>"` |
| `config.kmip.clientCertPath` | The KMIP server client certificate absolute path | `"/etc/pykmip/certs/client_certificate.pem"` |
| `config.kmip.clientKeyPath` | The KMIP server client key absolute path | `"/etc/pykmip/certs/client_key.pem"` |
| `config.kmip.rootCertPath` | The KMIP server root certificate absolute path | `"/etc/pykmip/certs/root_certificate.pem"` |
| `config.tee` | mark this true if its for TEE use cases else by default set to false | `false` |
| `aas.url` | Please update the url section if kbs is exposed via ingress | `null` |
| `aas.secret.adminUsername` | Admin Username for AAS | `null` |
| `aas.secret.adminPassword` | Admin Password for AAS | `null` |
| `secret.installAdminUsername` | Install Admin Username for KBS | `null` |
| `secret.installAdminPassword` | Install Admin Password for KBS | `null` |
| `secret.cccUsername` | Custom Claims Creator Username. Set only if tee is set to "true" | `null` |
| `secret.cccPassword` | Custom Claims Creator Password. Set only if tee is set to "true" | `null` |
| `customToken.subject` | The username for KBS | `"kbs"` |
| `customToken.validitySeconds` | Custom Token validity in seconds (Default: "31536000") | `"31536000"` |
| `storage.nfs.server` | The NFS Server IP/Hostname<br> (**REQUIRED**) | `"<user input>"` |
| `storage.nfs.reclaimPolicy` | The reclaim policy for NFS<br> (Allowed values: `Retain`/) | `"Retain"` |
| `storage.nfs.accessModes` | The access modes for NFS<br> (Allowed values: `ReadWriteMany`) | `"ReadWriteMany"` |
| `storage.nfs.path` | The path for storing persistent data on NFS | `"/mnt/nfs_share"` |
| `storage.nfs.configSize` | The configuration size for storing config for KBS in NFS path | `"10Mi"` |
| `storage.nfs.logsSize` | The logs size for storing logs for KBS in NFS path | `"1Gi"` |
| `storage.nfs.baseSize` | The base volume size (configSize + logSize) | `"1.1Gi"` |
| `storage.nfs.homeDirSize` | The home dir size for storing keys and key-transfer-policy for KBS in NFS path | `"10Mi"` |
| `securityContext.kbsInit.fsGroup` |  | `1001` |
| `securityContext.kbs.runAsUser` |  | `1001` |
| `securityContext.kbs.runAsGroup` |  | `1001` |
| `securityContext.kbs.capabilities.drop` |  | `["all"]` |
| `securityContext.kbs.allowPrivilegeEscalation` |  | `false` |
| `securityContext.aasManager.runAsUser` |  | `1001` |
| `securityContext.aasManager.runAsGroup` |  | `1001` |
| `securityContext.aasManager.capabilities.drop` |  | `["all"]` |
| `securityContext.aasManager.allowPrivilegeEscalation` |  | `false` |
| `securityContext.customToken.runAsUser` |  | `1001` |
| `securityContext.customToken.runAsGroup` |  | `1001` |
| `securityContext.customToken.capabilities.drop` |  | `["all"]` |
| `securityContext.customToken.allowPrivilegeEscalation` |  | `false` |
| `securityContext.aasManagerInit.fsGroup` |  | `1001` |
| `securityContext.customTokenInit.fsGroup` |  | `1001` |
| `service.directoryName` |  | `"kbs"` |
| `service.cms.containerPort` | The containerPort on which CMS can listen to traffic | `8445` |
| `service.aas.containerPort` | The containerPort on which AAS can listen to traffic | `8444` |
| `service.aps.containerPort` | The containerPort on which APS can listen to traffic | `5443` |
| `service.kbs.containerPort` | The containerPort on which KBS can listen to traffic | `9443` |
| `service.kbs.port` | The externally exposed NodePort on which KBS can listen to external traffic | `30448` |
| `service.ingress.enable` | Accept true or false to notify ingress rules are enable or disabled | `false` |



---
_Documentation generated by [Frigate](https://frigate.readthedocs.io)._

