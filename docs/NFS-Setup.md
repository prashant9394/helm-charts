# NFS setup

The helm charts uses persistent storage mechanism for storing the data such as configuration, logs and db, each deployment uses persistent volume claim as volume being mounted to pod.
each persistent volume claim is bound to persistent volume which has NFS as a storage class. 
For this reason the usecase/individual chart deployment requires NFS to be setup and configured prior to deployment.

## NFS server setup
setup-nfs.sh script can be run to setup nfs server and create directory structure with appropriate file permissions.

```shell script 
   curl -fsSL -o setup-nfs.sh -H "Authorization: token <github personal access token>" https://raw.githubusercontent.com/intel-innersource/applications.security.isecl.engineering.helm-charts/v5.0/develop/setup-nfs.sh
   chmod +x setup-nfs.sh
  ./setup-nfs.sh <mount_path> <user_id> <ip/subnet range>
```

In the script argument ```mount_path``` is where the directory structure needs to be created. <user_id> should be same as the one in
security context of deployment. Currently 1001 is set as default.

    
Either each node IPs/Hostnames or node subnet range in k8s cluster should be added in /etc/exports file in NFS server, for granting permission to access nfs mount
for each of the nodes. After adding the all the node IPs/ subnet range run ```exportfs -arv```
    
All nodes in cluster needs nfs-client to be installed

    - For ubuntu ```apt install nfs-common```
    
    - For rhel ```dnf install nfs-utils```
