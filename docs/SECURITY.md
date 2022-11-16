# SECURITY
We onderscheiden binnen ons security beleid de volgende punten

## Pentest
We gebruiken [pentest-tools](https://pentest-tools.com/) tool om bij iedere release een penetratietest uit te voeren, de release wordt alleen uitgeleverd als hier een positief resultaat uit komt. De resulaten van de pen test vind u [hier]().

## Workflow
Als onderdeel van de CI/CD straat maken we gebruik van tooling die de veiligheid in integriteit van de release controlleerd. Daarbij maken we onderscheid tussen brekende en niet brekende contolles. 
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
- Code Covarage (nu nog handmatig)
  - [CodeCov](https://about.codecov.io/)
- Maintainability (nu nog handmatig)
  - [Bettercodehub](https://bettercodehub.com/)

De resultaten van deze controlles worden (indien mogenlijk), we streven hierbij naar een code covaradge van 80% en een BetterCodehub score van 9 of hoger. 

## Container hardening
[Lijst pascal en robert]