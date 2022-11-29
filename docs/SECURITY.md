# SECURITY

We onderscheiden binnen ons security beleid de volgende punten

## Pentest

We gebruiken [pentest-tools](https://pentest-tools.com/) tool om bij iedere release een penetratietest uit te voeren, de release wordt alleen uitgeleverd als hier een positief resultaat uit komt. De resultaten van de pen test vindt u [hier]().

## Workflow

Als onderdeel van de CI/CD-straat maken we gebruik van tooling die de veiligheid in integriteit van de release controleert. Daarbij maken we onderscheid tussen brekende en niet brekende controles.
Op dit moment maken we gebruik van de volgende tools en aspecten:

- Vulnarability scanning
  - [Snyk](https://github.com/marketplace/actions/snyk)
  - [Trivy](https://github.com/marketplace/actions/aqua-security-trivy)
  - [Gryphe](https://github.com/marketplace/actions/github-action-morphkgc)
- Dependencies
  - [Composer](https://getcomposer.org/doc/03-cli.md#audit)
- Database integriteit
  - [Doctrine Validate](https://symfony.com/doc/3.3/doctrine.html)
- Intellectueel eigendom / licenties
  - [Fossa](https://fossa.com/product/open-source-license-compliance)
- Integratie/contracting
  - [Postman](https://github.com/marketplace/actions/newman-action)
- Unit Testing
  - [PHP Unit](https://github.com/marketplace/actions/phpunit-php-actions)
- Code Coverage (nu nog handmatig)
  - [CodeCov](https://about.codecov.io/)
- Maintainability (nu nog handmatig)
  - [Bettercodehub](https://bettercodehub.com/)

De resultaten van deze controles worden (indien mogelijk), we streven hierbij naar een code coverage van 80% en een Better Code Hub score van 9 of hoger.

## Container hardening

### OSWAP Docker top 10

#### D01 - Secure User Mapping

All containers are run with non-root users. Instead, the containers run with the least privileged user group possible for the containers.

#### D02 - Patch Management Strategy

Once security bugs have been identified, it is up to the product owner to prioritize them. The product owner also decides on security updates being regular patches or emergency patches.

#### D03 - Network Segmentation and Firewalling

The Kubernetes Container Orchestration Engine manages the network segmentation. In the default configuration, we ensure that only the frontend, the gateway, Open web concept and Elastic management dashboard (Kibana) are exposed. All other traffic remains within the Kubernetes cluster. The default network layout is drawn below (todo). It is left up to the discretion of the installing party only to expose other services if needed or to unexpose services that will be made of the containers that do not need to be exposed for their use.

#### D04 - Secure Defaults and Hardening

All containers are built upon the Alpine operating system, ensuring that the containers contain a minimum of dependencies. Also, the dependencies of the containers are kept to a minimum. Only dependencies that are needed for the proper operation of the containers are installed.

All containers also run with the minimum capabilities for the container used, nor can de users request new security privileges.

#### D05 - Maintain Security Contexts

Although the containers for production and other environments have the same default security hardening, we do not mix containers that are used for production with other containers on the same host (note: at the moment of writing we do mix accept and development on the same host, but these will be separated).

#### D06 - Protect Secrets

We do not store production passwords, private keys, certificates, or other credentials unencrypted in our repositories or in other locations. All passwords that are mentioned in the repositories are testing defaults that really should not be used in production.

All secrets that are stored in the databases are only reachable after logging in. (todo: iets met secrets die nog zwaarder beveiligd moeten worden)

#### D07 - Resource Protection

All containers have default resource limits in their deployment files. However, these can be overridden by the installing party to allow for higher or lower resource limits.

#### D08 - Container Image Integrity and Origin

All images are stored in the GitHub Container Registry managed by the Klantinteractie Servicesysteem organization. Others cannot overwrite these images than GitHub users that have permission to write images to this organization. This also means that usually only code changes, dependency updates, and other changes can only end up in published images when checked by an organization administrator.

#### D09 - Follow Immutable Paradigm

The containers run in read-only filesystems as much as possible. However, Nginx images are notoriously hard to run in read-only filesystems. Therefore we have the PHP images of the gateway hardened with a read-only file system. However, for Nginx images (frontend, DMZ) we are still working on a solution to use read-only filesystems.

#### D10 - Logging

The Common Gateway logs all requests to the Common Gateway in UTC. All logs are read-only and contain information on the requesting party. On top of that, we strongly advise installing Loki on the Kubernetes clusters of the installing party, where all these logs can also be stored. Loki also stores the Kubernetes logs of the containers.

Additional logging is left up to the installing party and the hosting party on which they install their KISS application.
