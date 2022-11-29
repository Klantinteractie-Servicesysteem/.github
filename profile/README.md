
# Welkom! 👋

## 🙋‍♀️ Wat is Klantinteractie Servicesysteem (kiss)
Het Klantinteractie Servicesysteem (KISS) is  een applicatie waarmee Klantcontactmedewerkers (KCM) optimaal worden ondersteund in hun werk: het informeren en helpen van burgers en ondernemers die contact opnemen met de Gemeente. Doel van KISS is om alle informatie die een KCM nodig heeft voor die taak, zoveel mogelijk binnen KISS zelf te ontstluiten. Het is ontwikkeld als een Common Ground component in opdracht van [Dimpact](https://www.dimpact.nl/klantinteractie-servicesysteem) en andere samenwerkende gemeenten.

## 👩‍💻 Development omgevingen
- Demo: [Frontend](https://kiss-dev.commonground.nu/)
- Beheer: [Common Gateway](https://gateway.kiss-dev.commonground.nu) 
- Pub: [OpenWeb Concept](https://openweb.kiss-dev.commonground.nu/wp-admin)

## Open Source
Als project geloven wij in open source en open community. We kiezen er daarom bewust voor ons project open en eerlijk te draaien. Naast de code zijn ook alle user stories en de roadmap publiek toegankelijk. Overheden en leveranciers wordt gevraagd hier kennis van te nemen en actief bij te dragen.

## Bijdragen
Overheden en leveranciers kunnen op een aantal manieren bijdragen aan dit project

- *Actief bijdragen aan discussies*.  Alle discussies van dit project worden gevoerd in de [Discussiepagina](https://github.com/orgs/Klantinteractie-Servicesysteem). Het staat iedereen vrij om discussie op te starten of hierin te participeren, maar de Product Owner neemt samen met de Product Steering Group het eindbesluit. Eindbesluiten die niet tot user stories leiden worden vastgelegd in de [DESIGN.md](https://github.com/Klantinteractie-Servicesysteem/KISS-frontend/blob/main/DESIGN.md).
- *Participeren in de Product Steering Group*. De Product Steering Group overlegt tweewekelijks en stelt de [roadmap](https://github.com/orgs/Klantinteractie-Servicesysteem/projects/1/views/1) van het project vast.  Het is in principe voor alle overheden en leveranciers mogelijk om deel te nemen aan de Product Steering Group, het eindoordeel over deelname ligt echter bij de Product Owner.  Als je het interessant vindt om deel te nemen aan de Product Steering Group kan je contact opnemen met ……
- *Indienen van feature requests*. Iedereen kan feature requests indienen, je hoeft hiervoor geen lid te zijn van de Product Steering Group of te beschikken over ontwikkelcapaciteit.  Feature requests worden besproken door de Product Steering Group. Die bepaalt of en waar ze op de [roadmap](https://github.com/orgs/Klantinteractie-Servicesysteem/projects/1/views/1) komen. Hierbij kan de Product Steering Group vragen om een toelichting of een ureninschatting door leveranciers.
- *Bijdrage van code*. Het staat iedere partij vrij om code voor te dragen aan het project door middel van een pull request. Let er wel op dat het voordragen van code niet automatisch leidt tot het accepteren hiervan. Lees de [contributing.md](https://github.com/Klantinteractie-Servicesysteem/KISS-frontend/blob/main/CONTRIBUTING.md) voor een beschrijving van het aanleverproces en de eigen die daaraan verbonden zijn.

## Roadmap
Dit project volgt een openbare [roadmap](https://github.com/orgs/Klantinteractie-Servicesysteem/projects/1/views/1), je kunt deze terug vinden onder het bijbehorende board. De roadmap heeft een indicatief karakter en er kunnen geen rechten aan worden ontleend. De Product Owner stelt in overleg met de Product Steering Group de roadmap vast. Partijen die goede ideeën hebben voor de roadmap wordt gevraagd deze aan te dragen. Zie daarvoor hierboven bij het onderdeel [“Bijdragen”](#bijdragen).

## Documentatie
- [Installatie handleiding](/docs/INSTALLATION.md)
- [Configuratie](/docs/CONFIGURATIE.md)
- [Architectuur](/docs/Architectuur.md)
- [Definition of Done](/docs/DEFINITIONOFDONE.md)
- [Security](/docs/SECURITY.md)
- [Openpub WordPress plugin](https://github.com/Klantinteractie-Servicesysteem/Openpub#readme)
  - [Managing users](https://github.com/Klantinteractie-Servicesysteem/Openpub/blob/master/README.md#managing-users)
  - [Managing publications](https://github.com/Klantinteractie-Servicesysteem/Openpub/blob/master/README.md#managing-publications)
  - [Gateway proxy calls](https://github.com/Klantinteractie-Servicesysteem/Openpub/blob/master/README.md#proxy-communication-via-gateway) (**not available in ReDoc**)

## Interne Componenten

De KISS-applicatie bestaat uit de volgende componenten:
-	[MUST]  User Interface (vue)
-	[MUST]  Backend for frontend (Common Gateway)
-	[MUST]  Gebruikers Authenticatie (DEX of andere OAuth provider)
-	[MUST]  Search Index (Elastic search)
-	[MUST]  Database (Postgress / MySQL)
-	[COULD] Caching (Redis)

Daarnaast maakt de KISS-applicatie gebruik van een groot aantal VNG Registraties. De benodigde registraties, en (voorbeeld)producten die hier invulling aan kunnen geven, staan genoemd onder API’s. Hierbij merken we op dat geen van deze API’s noodzakelijk is voor het beproeven van KISS. De Common Gateway spint per default mock’s op voor de benodigde registers. 

## API's (externe Componenten)
De KISS-applicatie maakt onder water gebruik van een groot aantal door de VNG gestandaardiseerde API's. Het is daarmee noodzakelijk dat uw organisatie over deze API's beschikt als u KISS wil gebruiken.

- [Haal Centraal KvK](https://github.com/VNG-Realisatie/Haal-Centraal-HR-bevragen) (api sleutel verkrijgen via [Kamer van Koophandel](https://www.kvk.nl/producten-bestellen/koppeling-handelsregister/kvk-api/))
- [Haal Centraal BRP](https://vng-realisatie.github.io/Haal-Centraal-BRP-bevragen/) (api sleutel verkrijgen via [RVIG](https://www.rvig.nl/brp/gebruikers-van-de-basisregistratie-personen-brp))
- [Haal Centraal BAG](https://github.com/VNG-Realisatie/Haal-Centraal-BAG-bevragen) (api sleutel verkrijgen via [Kadaster](https://www.kadaster.nl/zakelijk/producten/adressen-en-gebouwen/bag-api-huidige-bevragingen)
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

Voor alle bovenstaande API's geldt dat de KISS-applicatie tijdens installatie zelf mock's levert. Het niet beschikken over een of meerdere van bovenstaande API's is dus geen belemmering voor het testen of experimenteren met KISS. **Het is wel een belemmering voor in productie name**.

Mocht uw organisatie nu en/of in de toekomst niet beschikken over een of meerdere van bovenstaande API's dan levert de KISS applicatie de mogelijkheid om aan de hand van adapters andere bronnen te koppelen. Meer informatie over het vinden en of zelfstandig ontwikkelen van adapters vind u [hier](). Op dit moment zijn er adapters beschikbaar voor:

- ZDS
- Stuf
- SimForm
- Excellence zaaksysteem (v1 en v2 api)
- VrijBRP
