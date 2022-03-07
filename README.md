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

### Commands to fetch EK certicate and Issuer

The below obtained EK certificate can be used to upload to HVS DB, for allow registration of specific nodes use case.
If a specific host has to be allowed to register for HVS, then, that host EK certificate should be upload to HVS using /hvs/tpm-endorsements API

For RHEL OS
```
yum install tpm2-tools
tpm2_nvread -P hex:<owner secret> -x 0x1c00002 -a 0x40000001 -f ekcert.der or tpm2_nvread -P hex:<owner secret> -C 0x40000001 -o ekcert.der  0x1c00002
openssl x509 -inform der -in ekcert.der | base64

To get certificate Issuer
openssl x509 -inform der -in ekcert.der --text | grep -Po 'CN =\K.*'
```

### Use Case Helm Charts 

#### Foundational Security Usecases

| Use case                                | Helm Charts                                        | Deployment Steps |
| --------------------------------------- | ----------------------------------------------------------------- | ---------------- |
| Host Attestation                        | *Certificate Management Service (CMS)*<br />*Authentication and Authorization Service (AAS)*<br />*Host Verification Service(HVS)*<br />*Trustagent (TA)* | [Deployment Steps](usecases/host-attestation/depolyment.md) |
| Trusted Workload Placement(TWP) - Containers | *Certificate Management Service (CMS)*<br />*Authentication and Authorization Service (AAS)*<br />*Host Verification Service(HVS)*<br />*admission-controller*<br />*isecl-controller*<br />*isecl-scheduler*<br />*Integration Hub (IHub)*<br />*Trustagent (TA)* | [Deployment Steps](usecases/trusted-workload-placement/depolyment.md) |
| Trusted Workload Placement - Control Plane            | *Certificate Management Service (CMS)*<br />*Authentication and Authorization Service (AAS)*<br />*Host Verification Service(HVS)*<br />*NATS Cluster*<br /> | [Deployment Steps](usecases/twp-control-plane/depolyment.md) |
| Trusted Workload Placement - CSP          | *Trustagent (TA)*<br />*Integration Hub*<br />*Admission-controller*<br />*ISecl-Controller*<br />*ISecl-Scheduler*<br /> | [Deployment Steps](usecases/twp-cloud-service-provider/depolyment.md)|
