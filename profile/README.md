
# Welkom! 👋

## 🙋‍♀️ Wat is Klantinteractie Servicesysteem (KISS)

Het Klantinteractie Servicesysteem (KISS) is een applicatie waarmee Klantcontactmedewerkers (KCM) optimaal worden ondersteund in hun werk: het informeren en helpen van burgers en ondernemers die contact opnemen met de Gemeente. Doel van KISS is om alle informatie die een KCM nodig heeft voor die taak, zoveel mogelijk binnen KISS zelf te ontstluiten. Het is ontwikkeld als een Common Ground component in opdracht van [Dimpact en de gemeente Utrecht](https://www.dimpact.nl/klantinteractie-servicesysteem) en andere samenwerkende gemeenten.


## Roadmap en doorontwikkeling

De doorontwikkeling van KISS ligt bij Dimpact. 


## Documentatie

- [Installatie handleiding](/docs/INSTALLATION.md)
- [Configuratie](/docs/CONFIGURATIE.md)
- [Architectuur](/docs/Architectuur.md)
- [Definition of Done](/docs/DEFINITIONOFDONE.md)
- [Security](/docs/SECURITY.md)
- [API-documentatie](https://redocly.github.io/redoc/?nocors&url=https://kissdevelopment-dimpact.commonground.nu/openapi.json)
- [Openpub WordPress plugin](https://github.com/Klantinteractie-Servicesysteem/Openpub#readme)
  - [Managing users](https://github.com/Klantinteractie-Servicesysteem/Openpub/blob/master/README.md#managing-users)
  - [Managing publications](https://github.com/Klantinteractie-Servicesysteem/Openpub/blob/master/README.md#managing-publications)
  - [Gateway proxy calls](https://github.com/Klantinteractie-Servicesysteem/Openpub/blob/master/README.md#proxy-communication-via-gateway) (**not available in ReDoc**)

## Interne Componenten

De KISS-applicatie bestaat uit de volgende componenten:

- [MUST]  User Interface (Vue)
- [MUST]  Backend for frontend (Common Gateway)
- [MUST]  Gebruikers Authenticatie (DEX of andere OAuth provider)
- [MUST] OpenWeb Concept: Pub   (WordPress)
- [MUST]  Search Index (Elastic Search)
- [MUST]  Database (PostgreSQL / MySQL)

Daarnaast maakt de KISS-applicatie gebruik van een groot aantal VNG Registraties. De benodigde registraties, en (voorbeeld)producten die hier invulling aan kunnen geven, staan genoemd onder API’s. Hierbij merken we op dat geen van deze API’s noodzakelijk is voor het beproeven van KISS. De Common Gateway spint per default mock’s op voor de benodigde registers.

## API's (externe Componenten)

De KISS-applicatie maakt onder water gebruik van een groot aantal door de VNG gestandaardiseerde API's. Het is daarmee noodzakelijk dat uw organisatie over deze API's beschikt als u KISS wil gebruiken.

- [Haal Centraal KvK](https://github.com/VNG-Realisatie/Haal-Centraal-HR-bevragen) (API sleutel verkrijgen via [Kamer van Koophandel](https://www.kvk.nl/producten-bestellen/koppeling-handelsregister/kvk-api/))
- [Haal Centraal BRP](https://vng-realisatie.github.io/Haal-Centraal-BRP-bevragen/) (API sleutel verkrijgen via [RVIG](https://www.rvig.nl/brp/gebruikers-van-de-basisregistratie-personen-brp))
- [Haal Centraal BAG](https://github.com/VNG-Realisatie/Haal-Centraal-BAG-bevragen) (API sleutel verkrijgen via [Kadaster](https://www.kadaster.nl/zakelijk/producten/adressen-en-gebouwen/bag-api-huidige-bevragingen)
- [ZGW Zaken](https://vng-realisatie.github.io/gemma-zaken/standaard/zaken/) (zelf installeren via bijvoorbeeld [Open Zaak](https://openzaak.org/))
- [ZGW Catalogi](https://vng-realisatie.github.io/gemma-zaken/standaard/catalogi/) (zelf installeren via bijvoorbeeld [Open Zaak](https://openzaak.org/))
- [ZGW Documenten](https://vng-realisatie.github.io/gemma-zaken/standaard/documenten/) (zelf installeren via bijvoorbeeld [Open Zaak](https://openzaak.org/))
- [ZGW Beslutien](https://vng-realisatie.github.io/gemma-zaken/standaard/besluiten/) (zelf installeren via bijvoorbeeld [Open Zaak](https://openzaak.org/))
- [ZGW Authorisaties](https://vng-realisatie.github.io/gemma-zaken/standaard/autorisaties/) (zelf installeren via bijvoorbeeld [Open Zaak](https://openzaak.org/))
- [ZGW Notificaties](https://vng-realisatie.github.io/gemma-zaken/standaard/notificaties/) (zelf installeren via bijvoorbeeld [Open Zaak](https://openzaak.org/))
- [ZGW Zaken](https://vng-realisatie.github.io/gemma-zaken/standaard/zaken/) (zelf installeren via bijvoorbeeld [Open Zaak](https://openzaak.org/))
- [ZGW Contactmomenten](https://vng-realisatie.github.io/gemma-zaken/standaard/contactmomenten/) (zelf installeren via bijvoorbeeld [Open Zaak](https://openzaak.org/))
- [ZGW Klanten](https://vng-realisatie.github.io/gemma-zaken/standaard/klanten/) (zelf installeren via bijvoorbeeld [Open Zaak](https://openzaak.org/))
- [Open PUB](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/ConductionNL/PUB_publiccode/main/PUB_OAS.json&nocors) (zelf installeren via bijvoorbeeld [Open Webconcept](https://github.com/OpenWebconcept/open-government-publications))
- [Medewerkers](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/ConductionNL/medewerkercatalogus/master/api/public/schema/openapi.yaml&nocors) (Zelf installeren, nog geen open soruce oplossing beschikbaar)
- [Logging verwerking read](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/VNG-Realisatie/gemma-verwerkingenlogging/master/docs/api-read/oas-specification/logging-verwerkingen-api/openapi.yaml&nocors) (Zelf installeren, nog geen open source oplossing beschikbaar)
- [Logging verwerking write](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/VNG-Realisatie/gemma-verwerkingenlogging/master/docs/api-write/oas-specification/logging-verwerkingen-api/openapi.yaml&nocors) (Zelf installeren, nog geen open source oplossing beschikbaar)

Voor alle bovenstaande API's geldt dat de KISS-applicatie tijdens installatie zelf mocks levert. Het niet beschikken over een of meerdere van bovenstaande API's is dus geen belemmering voor het testen of experimenteren met KISS. **Het is wel een belemmering voor in productie name**.

Mocht uw organisatie nu en/of in de toekomst niet beschikken over een of meerdere van bovenstaande API's dan levert de KISS applicatie de mogelijkheid om aan de hand van adapters andere bronnen te koppelen. Meer informatie over het vinden en of zelfstandig ontwikkelen van adapters vind u [hier](). Op dit moment zijn er adapters beschikbaar voor:

- ZDS
- Stuf
- SimForm
- Excellence zaaksysteem (v1 en v2 API)
- VrijBRP
