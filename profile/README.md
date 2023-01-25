
# Klantinteractie Servicesysteem (KISS)

Het Klantinteractie Servicesysteem (KISS) is een applicatie waarmee Klantcontactmedewerkers (KCM) optimaal worden ondersteund in hun werk: het informeren en helpen van burgers en ondernemers die contact opnemen met de gemeente. Doel van KISS is om alle informatie die een KCM nodig heeft voor die taak, zoveel mogelijk binnen KISS zelf te ontsluiten. Het is ontwikkeld als een Common Ground component in opdracht van [in opdracht van gemeente Utrecht en Dimpact](https://www.dimpact.nl/klantinteractie-servicesysteem).


## Roadmap en doorontwikkeling

KISS Fase 1 wordt in januari afgerond. De doorontwikkeling van KISS ligt bij Dimpact. 


## Documentatie

- [Documentatie](https://kiss-klantinteractie-servicesysteem.readthedocs.io/):
  - [Installatie handleiding](https://kiss-klantinteractie-servicesysteem.readthedocs.io/en/latest/INSTALLATION/)
  - [Configuratie](https://kiss-klantinteractie-servicesysteem.readthedocs.io/en/latest/CONFIGURATIE/)
  - [Architectuur](https://kiss-klantinteractie-servicesysteem.readthedocs.io/en/latest/Architectuur/)
  - [Definition of Done](https://kiss-klantinteractie-servicesysteem.readthedocs.io/en/latest/DEFINITIONOFDONE/)
  - [Security](https://kiss-klantinteractie-servicesysteem.readthedocs.io/en/latest/SECURITY/)
  - [OpenPub WordPress-plugin](https://kiss-klantinteractie-servicesysteem.readthedocs.io/en/latest/openpub/)
  - [Uitbreidingen op de API's](https://kiss-klantinteractie-servicesysteem.readthedocs.io/en/latest/UITBREIDING-APIS/)
  - [OpenAPI-specificatie voor KISS (openapi.json)](https://redocly.github.io/redoc/?nocors&url=https://kissdevelopment-dimpact.commonground.nu/openapi.json)

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

- [KvK apis](https://developers.kvk.nl/documentation/zoeken-api)
- [Haal Centraal BRP](https://vng-realisatie.github.io/Haal-Centraal-BRP-bevragen/) 
- [ZGW Zaken](https://vng-realisatie.github.io/gemma-zaken/standaard/zaken/) 
- [ZGW Catalogi](https://vng-realisatie.github.io/gemma-zaken/standaard/catalogi/) 
- [ZGW Documenten](https://vng-realisatie.github.io/gemma-zaken/standaard/documenten/)

Een aantal API's zijn onderdeel van de aansluiting op gemeentelijke bronnen, en leveren geen data aan de frontend: 
- [ZGW Autorisaties](https://vng-realisatie.github.io/gemma-zaken/standaard/autorisaties/redoc-1.0.0)
- [ZGW Notificaties](https://vng-realisatie.github.io/gemma-zaken/standaard/notificaties/redoc-1.0.1) en [ZGW Notificaties voor consumers](https://vng-realisatie.github.io/gemma-zaken/standaard/notificaties-consumer/redoc-1.0.0-rc1) 
- [Inzage API voor logging van verwerkingen](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/VNG-Realisatie/gemma-verwerkingenlogging/master/docs/api-read/oas-specification/logging-verwerkingen-api/openapi.yaml&nocors)  
- [Bewerking API voor logging van verwerkingen](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/VNG-Realisatie/gemma-verwerkingenlogging/master/docs/api-write/oas-specification/logging-verwerkingen-api/openapi.yaml&nocors) 


Enkele van de standaard API's hebben we uitgebreid ([meer informatie hierover in de documentatie](https://kiss-klantinteractie-servicesysteem.readthedocs.io/en/latest/UITBREIDING-APIS/)):
- [Contactmomenten](https://redocly.github.io/redoc/?nocors&url=https://kissdevelopment-dimpact.commonground.nu/openapi.json#tag/ContactMomentcontactmomenten-collection), uitbreiding van [ZGW Contactmomenten](https://vng-realisatie.github.io/gemma-zaken/standaard/contactmomenten/)
- [Klanten](https://redocly.github.io/redoc/?nocors&url=https://kissdevelopment-dimpact.commonground.nu/openapi.json#tag/KlantKlanten-collection), uitbreiding van [ZGW Klanten](https://vng-realisatie.github.io/gemma-zaken/standaard/klanten/)
- [SDG Plus](https://redocly.github.io/redoc/?nocors&url=https://kissdevelopment-dimpact.commonground.nu/openapi.json#tag/SDGoverigeObjectenSDG-collection) gebaseerd op [SDG Invoervoorziening](https://petstore.swagger.io/?url=https://raw.githubusercontent.com/maykinmedia/sdg-invoervoorziening/master/src/openapi.yaml)
- [KISS_openpub_pub](https://redocly.github.io/redoc/?nocors&url=https://kissdevelopment-dimpact.commonground.nu/openapi.json#tag/Kiss_openpub_pubPub-collection) gebaseerd op de [bouwblokken van OpenWeb](https://openwebconcept.nl/bouwblokken/) 
- [Medewerkers](https://redocly.github.io/redoc/?nocors&url=https://kissdevelopment-dimpact.commonground.nu/openapi.json), ontwikkeld voor KISS.

De volledige implementatie van alle API's vindt u [in ReDoc](https://redocly.github.io/redoc/?nocors&url=https://kissdevelopment-dimpact.commonground.nu/openapi.json).

## Bouw
KISS wordt ontwikkeld door ICATT en Conduction, in opdracht van Utrecht en Dimpact. Utrecht en de Dimpactleden Deventer, Zwolle, Enschede, Kampen, Haarlemmermeer, Emmen en Oost Gelre zijn deelnemers.

## Licentie
[European Union Public License](https://opensource.org/licenses/EUPL-1.1)
