# Deploying NFS Server on a Virtual Machine	

## Pre-requisites

* Ubuntu/RHEL VM
* Export directory to use (Default: `/mnt/nfs_share/`)
* User ID for ISecL Services (Default: `1001`)
* Worker Node Subnet (Default: `*`)

## How to run
* Copy the sample script to the specific location on the machine (/root) to a file (e.g: setup-nfs.sh)
* Provide executable permissions
  ```shell
  chmod +x setup-nfs.sh
  ```
* Run the sample script as follows
  ```shell
  ./setup-nfs.sh /mnt/nfs_share 1001 <Subnet of worker node>
  ```
