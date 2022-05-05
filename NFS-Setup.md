# Deploying NFS Server on a Virtual Machine	

## Pre-requisites

* Ubuntu/RHEL VM
* Export directory to use
* User ID for ISecL Services
* Worker Node Subnet

## How to run
* Copy the sample script to the specific location on the machine (/root) to a file (e.g: setup-nfs.sh)
* Provide executable permissions
  ```shell
  chmod +x setup-nfs.sh
  ```
* Run the sample script as follows
  ```shell
  ./setup-nfs.sh <export directory> <User Id for ISecL Services> <Subnet of worker node>
  ```
