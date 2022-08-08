# Intel<sup>®</sup> Security Libraries for Data Center (Intel<sup>®</sup> SecL-DC) Helm Charts


A collection of helm charts for ISecL-DC usecases


<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [isecl-helm](#isecl-helm)
    - [Support Details](#support-details)
    - [Use Case Helm Charts](#use-case-helm-charts)

<!-- /code_chunk_output -->


### Support Details

| Kubernetes        | Details                                                      |
| ----------------- | ------------------------------------------------------------ |
| Cluster OS        | *RedHat Enterprise Linux 8.x* <br/>*Ubuntu 20.04*            |
| Distributions     | Any non-managed K8s cluster                                  |
| Versions          | v1.23                                                        |
| Storage           | NFS                                                          |
| Container Runtime | Foundational Security: *CRI-O*<br/>                          |

### Use Case Helm Charts 

#### Foundational Security Usecases

| Use case                                                     | Description                                                  | Helm Charts                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| [Host Attestation](usecases/host-attestation/deployment.md)  | Host Attestation(Platform attestation) is cornerstone use case for Intel SecL It involves taking measurements of system components during system boot, and then cryptographically verifying that the actual measurements taken matched a set of expected or approved values, ensuring that the measured components were in an acceptable or "trusted" state at the time of the last system boot. | *Certificate Management Service (CMS)*<br/> <br/>*Authentication and Authorization Service (AAS)*<br/> <br/>*Host Verification Service(HVS)* <br/> <br/>*Trustagent (TA)* |
| [Trusted Workload Placement(TWP) - Containers](usecases/trusted-workload-placement/deployment.md) | Trusted Workload Placement(Data Sovereignty) builds on the Host Attestation use case to allow physical TPMs to be written with Asset Tags containing any number of key/value pairs. This use case is typically used to identify the geographic location of the physical server, but can also be used to identify other attributes. For example, the Asset Tags provided by this use case could be used to identify hosts that meet specific compliance requirements and can run controlled workloads. | *Certificate Management Service (CMS)*<br/><br/>*Authentication and Authorization Service (AAS)*<br/><br/>*Host Verification Service(HVS)*     <br/><br/>*admission-controller*         <br/><br/>*isecl-controller*  <br/><br/>*isecl-scheduler* <br/><br/>*Integration Hub (IHub)*           <br/><br/>*Trustagent (TA)* |
| [Trusted Workload Placement - Control Plane](usecases/twp-control-plane/deployment.md) | Trusted Workload Placement - Control Plane is a subset of trusted workload placement usecase. This usecase helm chart can be deployed on any existing non managed k8s cluster on cloud platform and performs platform attestation of nodes at CSPs or edge nodes. | *Certificate Management Service (CMS)*<br/><br/>*Authentication and Authorization Service (AAS)*<br/><br/>*Host Verification Service(HVS)*<br/><br /> |
| [Trusted Workload Placement - CSP](usecases/twp-cloud-service-provider/deployment.md) | Trusted Workload Placement - CSP is a subset of trusted workload placement usecase. This usecase helm chart can be deployed on any non managed k8s cluster at CSPs or edge nodes for getting the cluster nodes attested by deployed twp-control-plane services running in cloud | *Trustagent (TA)*<br/><br/>*Integration Hub*<br/><br/>*Admission-controller*<br/><br/>*ISecl-Controller*<br/><br/>*ISecl-Scheduler*<br /> |
| [Workload Security](usecases/workload-security/deployment.md) | Workload Confidentiality allows virtual machine and container images to be encrypted at rest, with key access tied to platform integrity attestation. Because security attributes contained in the platform integrity attestation report are used to control access to the decryption keys, this feature provides both protection for at-rest data, IP, code, etc in container or virtual machine images, and also enforcement of image-owner-controlled placement policies. | *Certificate Management Service (CMS)*<br/><br/>*Authentication and Authorization Service (AAS)*<br/><br/>*Trustagent (TA)*<br/><br/>*Integration Hub*<br/><br/>*ISecl-Controller*<br/><br/>*ISecl-Scheduler*<br/><br/>*Key Broker Service(KBS)*<br/><br/>*Host Verification Service(HVS)*<br/><br/>*Workload Service(WLS)*<br/><br/>*Workload Agent(WLA)* |

### Product Guide

For more details on the product, installation and deployment strategies, please go through following, (Refer to latest and use case wise guide)

[https://intel-secl.github.io/docs](https://intel-secl.github.io/docs)

### Release Notes

[https://intel-secl.github.io/docs/4.2/ReleaseNotes/ReleaseNotes](https://intel-secl.github.io/docs/4.2/ReleaseNotes/ReleaseNotes)

### Issues

Feel free to raise deployment issues here,

[https://github.com/intel-secl/helm-charts/issues](https://github.com/intel-secl/helm-charts/issues)
