
# Klantinteractie Servicesysteem (KISS)

Het Klantinteractie Servicesysteem (KISS) is een applicatie waarmee Klantcontactmedewerkers (KCM) optimaal worden ondersteund in hun werk: het informeren en helpen van burgers en ondernemers die contact opnemen met de gemeente. Doel van KISS is om alle informatie die een KCM nodig heeft voor die taak, zoveel mogelijk binnen KISS zelf te ontsluiten. Het is ontwikkeld als een Common Ground component in opdracht van [in opdracht van gemeente Utrecht en Dimpact](https://www.dimpact.nl/klantinteractie-servicesysteem).


## Roadmap en doorontwikkeling

KISS Fase 1 wordt in januari afgerond. De doorontwikkeling van KISS ligt bij Dimpact. 


## Documentatie

- [Documentatie](https://kiss-klantinteractie-servicesysteem.readthedocs.io/):
- - [Installatie handleiding](https://kiss-klantinteractie-servicesysteem.readthedocs.io/en/latest/INSTALLATION/)
- [Configuratie](https://kiss-klantinteractie-servicesysteem.readthedocs.io/en/latest/CONFIGURATIE/)
- [Architectuur](https://kiss-klantinteractie-servicesysteem.readthedocs.io/en/latest/Architectuur/)
- [Definition of Done](https://kiss-klantinteractie-servicesysteem.readthedocs.io/en/latest/DEFINITIONOFDONE/)
- [Security](https://kiss-klantinteractie-servicesysteem.readthedocs.io/en/latest/SECURITY/)
- [OpenPub WordPress-plugin](https://kiss-klantinteractie-servicesysteem.readthedocs.io/en/latest/openpub/)
- [Overzicht API's (openapi.json)](https://redocly.github.io/redoc/?nocors&url=https://kissdevelopment-dimpact.commonground.nu/openapi.json)

## Interne Componenten

De KISS-applicatie bestaat uit de volgende componenten:

- [MUST]  User Interface (KISS Frontend, Vue)
- [MUST]  Backend for frontend (Common Gateway)
- [MUST]  Gebruikers Authenticatie (DEX of andere OAuth provider)
- [MUST] OpenWeb Concept: Pub   (WordPress)
- [MUST]  Search Index (Elastic Search)
- [MUST]  Database (PostgreSQL / MySQL)


## API's 
De KISS-applicatie maakt gebruik van een groot aantal door de VNG gestandaardiseerde API's om te communiceren met onderliggende registraties in het eigen gemeentelijke landschap en met enkele landelijke basisregistraties:

- [KvK apis](https://redocly.github.io/redoc/?nocors&url=https://kissdevelopment-dimpact.commonground.nu/openapi.json#tag/HandelsregisterPersoonHandelsRegisterBevragen-collection)
- [Haal Centraal BRP](https://vng-realisatie.github.io/Haal-Centraal-BRP-bevragen/) 
- [ZGW Zaken](https://vng-realisatie.github.io/gemma-zaken/standaard/zaken/) 
- [ZGW Catalogi](https://vng-realisatie.github.io/gemma-zaken/standaard/catalogi/) 
- [ZGW Documenten](https://vng-realisatie.github.io/gemma-zaken/standaard/documenten/)
- [ZGW Contactmomenten (uitgebreid voor KISS)](https://redocly.github.io/redoc/?nocors&url=https://kissdevelopment-dimpact.commonground.nu/openapi.json#tag/ContactMomentcontactmomenten-collection) 
- [ZGW Klanten (uitgebreid voor KISS)](https://redocly.github.io/redoc/?nocors&url=https://kissdevelopment-dimpact.commonground.nu/openapi.json#tag/KlantKlanten-collection) 
- [SDG Plus (uitbreiding op SDG voor KISS)](https://redocly.github.io/redoc/?nocors&url=https://kissdevelopment-dimpact.commonground.nu/openapi.json#tag/SDGoverigeObjectenSDG-collection)
- [KISS_openpub_pub](https://redocly.github.io/redoc/?nocors&url=https://kissdevelopment-dimpact.commonground.nu/openapi.json#tag/Kiss_openpub_pubPub-collection) 
- [Medewerkers (ontwikkeld voor KISS)](https://redocly.github.io/redoc/?nocors&url=https://kissdevelopment-dimpact.commonground.nu/openapi.json) 
- [ZGW Autorisaties](https://vng-realisatie.github.io/gemma-zaken/standaard/autorisaties/redoc-1.0.0) _(niet in KISS Frontend)_
- [ZGW Notificaties](https://vng-realisatie.github.io/gemma-zaken/standaard/notificaties/redoc-1.0.1) en [ZGW Notificaties voor consumers](https://vng-realisatie.github.io/gemma-zaken/standaard/notificaties-consumer/redoc-1.0.0-rc1) _(niet in KISS Frontend)_
- [Inzage API voor logging van verwerkingen](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/VNG-Realisatie/gemma-verwerkingenlogging/master/docs/api-read/oas-specification/logging-verwerkingen-api/openapi.yaml&nocors)  _(niet in KISS Frontend)_
- [Bewerking API voor logging van verwerkingen](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/VNG-Realisatie/gemma-verwerkingenlogging/master/docs/api-write/oas-specification/logging-verwerkingen-api/openapi.yaml&nocors)  _(niet in KISS Frontend)_

## Bouw
KISS wordt ontwikkeld door ICATT en Conduction, in opdracht van Utrecht en Dimpact. Utrecht en de Dimpactleden Deventer, Zwolle, Enschede, Kampen, Haarlemmermeer, Emmen en Oost Gelre zijn deelnemers.

## Licentie
[European Union Public License](https://opensource.org/licenses/EUPL-1.1)
