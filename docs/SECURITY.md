# Security considerations

## Snyk
Snyk is configured to automatically check every Pull Request on new vulnerabilities<a href="https://github.com/Klantinteractie-Servicesysteem/.github/blob/main/docs/SECURITY.md" target="_blank">.</a>

### Vulnerabilities
#### Anti-forgery token validation disabled 
Details: https://app.snyk.io/org/klantinteractie-servicesysteem/project/9d7a9bac-d697-48c5-b542-03de24e608d1</br > Addendum: In razor these tokens are part of the framework, we use VueJs3</br >
Impact: Very low, we use Same-Site strict policy and this site is not exposed to the internet</br >


## OWASP Docker Top 10
### Introduction
The 10 most common and exploited docker vulnerabilities are maintained by the OWASP Docker Top 10. The overview shows a quick summary of these including the title, description and how / if we have implemented this.

Details need to be fleshed out in seperate md's in /security/docker/1-10

### Overview
| Title | Description | Implementation
| -- | -- | -- |
| D01 - Secure User Mapping | [Source](https://github.com/OWASP/Docker-Security/blob/main/D01%20-%20Secure%20User%20Mapping.md) Most often the application within the container runs with the default administrative privileges: root. This violates the least privilege principle and gives an attacker better chances further extending his activities if he manages to break out of the application into the container. From the host perspective the application should never run as root.</br> | [Details](\security\docker\D01 - Secure User Mapping.md) Check if dockerfile contains a user</br>  Check if --privileged is not used. </br> Following documentation from .Net Core we make sure the application does not run as root user
| D02 - Patch Management Strategy | [Source](https://github.com/OWASP/Docker-Security/blob/main/D02%20-%20Patch%20Management%20Strategy.md) The host, the containment technology, the orchestration solution and the minimal operating system images in the container will have security bugs. Once publicly known it is vital for your security posture to address those bugs in a timely fashion. For all those components mentioned you need to decide when you apply regular and emergency patches before you put those into production. | We use Snyk with automated PR's for docker images, containers, Kubernetes and Host OS. </br> </br>  - Critical vulnerabilities need to be fixed within X days. </br>  - High vulnerabilities need to be fixed within X days. </br> - Medium/low vulnerabilities need to be fixed within X days. </br> - Library package updates are updated automatically by Snyk and deployed and tested after: <br /> 1: During development of next new story. Or <br /> 2: Periodically every X months/weeks
| D03 - Network Segmentation and Firewalling |  [Source](https://github.com/OWASP/Docker-Security/blob/main/D03%20-%20Network%20Segmentation%20and%20Firewalling.md) You properly need to design your network upfront. Management interfaces from the orchestration tool and especially network services from the host are crucial and need to be protected on a network level. Also make sure that all other network based microservices are only exposed to the legitimate consumer of this microservice and not to the whole network. | We use Azure kubernetes, we need to check how we can comply with this demand in our environment > Not relevant for the current project phase
| D04 - Secure Defaults and Hardening | [Source](https://github.com/OWASP/Docker-Security/blob/main/D04%20-%20Secure%20Defaults%20and%20Hardening.md) Depending on your choice of host and container operating system and orchestration tool you have to take care that no unneeded components are installed or started. Also all needed components need to be properly configured and locked down. | We have made list of the project OS, platform and libraries and there respective End-of-life-dates. See table beneath this page   |
| D05 - Maintain Security Contexts | [Source](https://github.com/OWASP/Docker-Security/blob/main/D05%20-%20Maintain%20Security%20Contexts.md) Mixing production containers on one host with other stages of undefined or less secure containers may open a backdoor to your production. Also mixing e.g. frontend with backend services on one host may have negative security impacts. | We don't have multiple environments in 1 cluster, they are always seperated.
| D06 - Protect Secrets | [Source](https://github.com/OWASP/Docker-Security/blob/main/D06%20-%20Protect%20Secrets.md) Authentication and authorization of a microservice against a peer or a third party requires secrets to be provided. For an attacker those secrets potentially enable him to access more of your data or services. Thus any passwords, tokens, private keys or certificates need to be protected as good as possible. | Local variables at the moment, our production story contains a special section about implementing k8s secrets 
| D07 - Resource Protection | [Source](https://github.com/OWASP/Docker-Security/blob/main/D07%20-%20Resource%20Protection.md) As all containers share the same physical CPU, disks, memory and networks. Those physical resources need to be protected so that a single container running out of control -- deliberately or not -- doesn't affect any other container's resources. | Resources are limited through the Helm configuration |
| D08 - Container Image Integrity and Origin | The minimal operating system in the container runs your code and needs to be trustworthy, starting from the origin up until the deployment. You need to make sure that all transfers and images at rest haven't been tampered with.  | We use Snyk for scanning and also for base images checks. Depending on those results we will update this section.
| D09 - Follow Immutable Paradigm | Often container images don't need to write into their filesystem or a mounted filesystem, once set up and deployed. In those cases you have an extra security benefit if you start the containers in read-only mode. | Our BF front- and backend are stateless and can be considered to be marked readonly because we do not process any files at the moment.
| D10 - Logging | For your container image, orchestration tool and host you need to log all security relevant events on a system and API level. All logs should be remote, they should contain a common timestamp and they should be tamper proof. Your application should also provide remote logging. | We will be using Prometheus and Loki as our own logging stack.

## D04
| Product | Version | End-of-life | Link |
| -- | -- | -- | -- |
| Alpine Linux | 3.18 | May 9, 2025 | https://alpinelinux.org/releases/ |
| NodeJS | 18.16 | April 30, 2025 | https://nodejs.dev/en/about/releases/ |
| .Net Core | 6 | November 12, 2024 | https://learn.microsoft.com/en-us/lifecycle/products/microsoft-net-and-net-core |
| Kubernetes | 1.27 | July, 2024 | https://learn.microsoft.com/en-us/azure/aks/supported-kubernetes-versions?tabs=azure-cli#aks-kubernetes-release-calendar |
