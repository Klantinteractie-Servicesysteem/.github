
# Klantinteractie Servicesysteem (KISS)

Het Klantinteractie Servicesysteem (KISS) is een applicatie waarmee Klantcontactmedewerkers (KCM) optimaal worden ondersteund in hun werk: het informeren en helpen van burgers en ondernemers die contact opnemen met de gemeente. Doel van KISS is om alle informatie die een KCM nodig heeft voor die taak, zoveel mogelijk binnen KISS zelf te ontsluiten. Het is ontwikkeld als een Common Ground component in opdracht van [de gemeente Utrecht en Dimpact](https://www.dimpact.nl/klantinteractie-servicesysteem).


## Roadmap en doorontwikkeling

KISS Fase 1 is momenteel verder in ontwikkeling. Fase 1 wordt in september 2023 afgerond. De doorontwikkeling van KISS ligt bij Dimpact. 


## Documentatie

- [Documentatie](https://kiss-klantinteractie-servicesysteem.readthedocs.io/):
  - [Installatie handleiding](https://kiss-klantinteractie-servicesysteem.readthedocs.io/en/latest/INSTALLATION/)
  - [Configuratie](https://kiss-klantinteractie-servicesysteem.readthedocs.io/en/latest/CONFIGURATIE/)
  - [Definition of Done](https://kiss-klantinteractie-servicesysteem.readthedocs.io/en/latest/DEFINITIONOFDONE/)
  - [Security](https://kiss-klantinteractie-servicesysteem.readthedocs.io/en/latest/SECURITY/)
  - [Documentatie-archief](https://kiss-oldDocs.readthedocs.io/)


## Waaruit bestaat KISS-frontend

De KISS-applicatie bestaat uit een User Interface (Vue) op een Backend for frontend (.Net + PostgreSQL).  Kennisbronnen worden ontsloten m.b.v, een Search Index (Elastic Search). 


## API's 
De KISS-applicatie maakt gebruik van een groot aantal door de VNG gestandaardiseerde API's om te communiceren met onderliggende registraties in het eigen gemeentelijke landschap en met enkele landelijke basisregistraties:

- [KvK apis](https://developers.kvk.nl/documentation/zoeken-api)
- [Haal Centraal BRP Personen bevragen](https://brp-api.github.io/Haal-Centraal-BRP-bevragen/) 
- [ZGW Zaken](https://vng-realisatie.github.io/gemma-zaken/standaard/zaken/) 
- [ZGW Catalogi](https://vng-realisatie.github.io/gemma-zaken/standaard/catalogi/) 
- [ZGW Documenten](https://vng-realisatie.github.io/gemma-zaken/standaard/documenten/)
- [Objecttype API](https://github.com/maykinmedia/objecttypes-api)
- [Objecten API](https://github.com/maykinmedia/objects-api)


## Bouw
KISS wordt ontwikkeld door ICATT, in opdracht van Utrecht en Dimpact. 

## Licentie
[European Union Public License](https://opensource.org/licenses/EUPL-1.1)
