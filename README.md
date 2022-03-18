# ISecl-DC Helm Charts

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
| Container Runtime | Foundational Security: *docker*,*CRI-O*<br/> |
    
### Use Case Helm Charts 

#### Foundational Security Usecases

| Use case                                | Helm Charts                                        | Deployment Steps |
| --------------------------------------- | ----------------------------------------------------------------- | ---------------- |
| Host Attestation                        | *Certificate Management Service (CMS)*<br />*Authentication and Authorization Service (AAS)*<br />*Host Verification Service(HVS)*<br />*Trustagent (TA)* | [Deployment Steps](usecases/host-attestation/deployment.md) |
| Trusted Workload Placement(TWP) - Containers | *Certificate Management Service (CMS)*<br />*Authentication and Authorization Service (AAS)*<br />*Host Verification Service(HVS)*<br />*admission-controller*<br />*isecl-controller*<br />*isecl-scheduler*<br />*Integration Hub (IHub)*<br />*Trustagent (TA)* | [Deployment Steps](usecases/trusted-workload-placement/deployment.md) |
| Trusted Workload Placement - Control Plane            | *Certificate Management Service (CMS)*<br />*Authentication and Authorization Service (AAS)*<br />*Host Verification Service(HVS)*<br />*NATS Cluster*<br /> | [Deployment Steps](usecases/twp-control-plane/deployment.md) |
| Trusted Workload Placement - CSP          | *Trustagent (TA)*<br />*Integration Hub*<br />*Admission-controller*<br />*ISecl-Controller*<br />*ISecl-Scheduler*<br /> | [Deployment Steps](usecases/twp-cloud-service-provider/deployment.md)|