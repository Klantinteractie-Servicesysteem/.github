# Installatie handleiding
De installatie van KISS bestaad uit twee primaire stappen
1. Het installeren van de software
2. Een basis configuratie van de ssoftware

Er Met betrekking tot het installeren van de software zijn er twee manieren om KISS te installeren.

## Kubernetes (haven)
Voor installatie op een haven omgeving zijn helm installatie bestanden beschikbaar op Artifacthub. 

## Linux (LAMP)
Het installeren van KISS op een  Linux omgeving vereist enig handwerk
- a.	Randvoorwaarden: Een LAMP machine met daarop:
  - Linux: [min versie]
  - Apache: [min versie]
  - MySQL: [min versie]
  - PHP: [min versie] + extensies
  - Composer: [{min versie] installatie handleiding()
- [Elastic serach](https://www.elastic.co/) locaal of als saas
- Een OAuth2 compatable identity provider, bijvoorbeeld [DEX](https://dexidp.io/), [KeyCloack](https://www.keycloak.org/) of ADFS

## Basis configuratie
KISS vereist minimaal een aantal configuraite handelingen na de installatie om te kunnen werken

1. Er moet een proxy worden ingesteld naar de Elastic installatie