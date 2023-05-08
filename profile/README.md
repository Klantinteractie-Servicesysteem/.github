
# Klantinteractie Servicesysteem (KISS)

Het Klantinteractie Servicesysteem (KISS) is een applicatie waarmee Klantcontactmedewerkers (KCM) optimaal worden ondersteund in hun werk: het informeren en helpen van burgers en ondernemers die contact opnemen met de gemeente. Doel van KISS is om alle informatie die een KCM nodig heeft voor die taak, zoveel mogelijk binnen KISS zelf te ontsluiten. Het is ontwikkeld als een Common Ground component in opdracht van [de gemeente Utrecht en Dimpact](https://www.dimpact.nl/klantinteractie-servicesysteem).


## Roadmap en doorontwikkeling

KISS Fase 1 is momenteel verder in ontwikkeling. Fase 1 wordt in september 2023 afgerond. De doorontwikkeling van KISS ligt bij Dimpact. 


## Documentatie
Door gewijzigde inzichten klopt de documentatie zoals die in januari 2023 is opgeleverd niet meer. We werken momenteel aan een nieuwe release, met een bijgewerkte handleiding. De [documentatie van de vorige versie](https://kiss-klantinteractie-servicesysteem.readthedocs.io/) is nog wel beschikbaar, maar is niet meer actueel. 


## Interne Componenten

De KISS-applicatie bestaat uit de volgende componenten:

- [MUST]  User Interface (KISS Frontend, Vue)
- [MUST]  Backend for frontend (.Net)
- [MUST]  Search Index (Elastic Search)
- [MUST]  Database (PostgreSQL / MSSQL)


## API's 
De KISS-applicatie maakt gebruik van een groot aantal door de VNG gestandaardiseerde API's om te communiceren met onderliggende registraties in het eigen gemeentelijke landschap en met enkele landelijke basisregistraties:

- [KvK apis](https://developers.kvk.nl/documentation/zoeken-api)
- [Haal Centraal BRP](https://brp-api.github.io/Haal-Centraal-BRP-bevragen/) 
- [ZGW Zaken](https://vng-realisatie.github.io/gemma-zaken/standaard/zaken/) 
- [ZGW Catalogi](https://vng-realisatie.github.io/gemma-zaken/standaard/catalogi/) 
- [ZGW Documenten](https://vng-realisatie.github.io/gemma-zaken/standaard/documenten/)

Een aantal API's zijn onderdeel van de aansluiting op gemeentelijke bronnen, en leveren geen data aan de frontend: 
- [ZGW Autorisaties](https://vng-realisatie.github.io/gemma-zaken/standaard/autorisaties/redoc-1.0.0)
- [ZGW Notificaties](https://vng-realisatie.github.io/gemma-zaken/standaard/notificaties/redoc-1.0.1) en [ZGW Notificaties voor consumers](https://vng-realisatie.github.io/gemma-zaken/standaard/notificaties-consumer/redoc-1.0.0-rc1) 
- [Inzage API voor logging van verwerkingen](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/VNG-Realisatie/gemma-verwerkingenlogging/master/docs/api-read/oas-specification/logging-verwerkingen-api/openapi.yaml&nocors)  
- [Bewerking API voor logging van verwerkingen](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/VNG-Realisatie/gemma-verwerkingenlogging/master/docs/api-write/oas-specification/logging-verwerkingen-api/openapi.yaml&nocors) 


Enkele van de standaard API's zullen we uitbreiden ([meer informatie hierover in de documentatie](https://kiss-klantinteractie-servicesysteem.readthedocs.io/en/latest/UITBREIDING-APIS/)):
- [ZGW Contactmomenten](https://vng-realisatie.github.io/gemma-zaken/standaard/contactmomenten/)
- [ZGW Klanten](https://vng-realisatie.github.io/gemma-zaken/standaard/klanten/)
- [SDG Invoervoorziening](https://petstore.swagger.io/?url=https://raw.githubusercontent.com/maykinmedia/sdg-invoervoorziening/master/src/openapi.yaml)

## Bouw
KISS wordt ontwikkeld door ICATT, in opdracht van Utrecht en Dimpact. 

## Licentie
[European Union Public License](https://opensource.org/licenses/EUPL-1.1)
