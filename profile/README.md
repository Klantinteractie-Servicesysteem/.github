
# Welkom! 👋

## 🙋‍♀️ Wat is Klantinteractie Servicesysteem (kiss)

## 👩‍💻 Development omgevingen
- Demo: [Frontend](https://kiss-dev.commonground.nu/)
- Beheer: [Common Gateway](https://gateway.kiss-dev.commonground.nu) 
- Pub: [OpenWeb Concept](https://openweb.kiss-dev.commonground.nu/wp-admin)

## Open Source
Als project geloven wij in open source en open community. We kiezen er daarom bewust voor ons project open en eerlijk te draaien. Naast de code zijn ook alle user stories en de roadmap publiek toegankelijk. Overheden en leveranciers wordt gevraagd hier kennis van te nemen en actief bij te dragen.

## Bijdragen
Overheden en leveranciers kunnen op een aantal manieren bijdragen aan dit project

- *Actief bijdragen aan discussies*.  Alle discussies van dit project worden gevoerd in de [discussie pagina](https://github.com/orgs/Klantinteractie-Servicesysteem) het staat iedereen vrij om discussie op te starten of hierin te participeren, maar de product owner neemt samen met de product steering group het eindbesluit. Eindbesluiten die niet tot user stories leiden worden vastgelegd in de [DESIGN.md](https://github.com/Klantinteractie-Servicesysteem/KISS-frontend/blob/main/DESIGN.md).
- *Participeren in de product steering group*. De product steering group overlegt tweewekelijks en stelt de [roadmap](https://github.com/orgs/Klantinteractie-Servicesysteem/projects/1/views/1) van het project vast.  Het is in principe voor alle overheden en leveranciers mogelijk om deel te nemen aan de product steering group, het eindoordeel over deelname ligt echter bij de product owner.  Als je het interessant vind om deel te nemen aan de product steering group kan je contact opnemen met ……
- *Indienen van feature requests*. Iedereen kan feature request indienen, je hoeft hiervoor geen lid te zijn van de product steering group of te beschikken over ontwikkelcapaciteit.  Feature request worden besproken door de product steering group die bepaald of en waar ze op de [roadmap](https://github.com/orgs/Klantinteractie-Servicesysteem/projects/1/views/1) komen. Hierbij kan gevraagd worden om toelichting of een ureninschatting door leveranciers
- *Bijdrage van code*. Het staat iedere partij vrij om code voor te dragen aan het project door middel van een pull request. Let er wel op dat het voordragen van code niet automatisch leidt tot het accepteren hiervan. Lees de contributing.md voor een beschrijving van het aanleverproces en daaraan verbonden eisen.

## Roadmap
Dit project volgt een openbare [roadmap](https://github.com/orgs/Klantinteractie-Servicesysteem/projects/1/views/1), je kunt deze terug vinden onder het bijbehorende board. De roadmap heeft een indicatief karakter en er kunnen geen rechten aan worden ontleend. De product owner stelt in overleg met de product steering group de roadmap vast. Partijen die goede ideeën hebben over de roadmap wordt gevraagd deze aan te dragen. Zie daarvoor [“Bijdragen”](#bijdragen).

## Documentatie
- Installatie handleiding
- Architectuur

## API's (Componenten)
De KISS applicatie maakt onder water gebruik van een groot aantal door de VNG gestandaardiseerde API's. Het is daarmee noodzakelijk dat uw organisatie over deze API's beschikt als u van KISS gebruik wil maken.

- [Haalcentraal KVK](https://github.com/VNG-Realisatie/Haal-Centraal-HR-bevragen) (api sleutel verkrijgen via [Kamer van Koophandel](https://www.kvk.nl/producten-bestellen/koppeling-handelsregister/kvk-api/))
- [Haalcentraal BRP](https://vng-realisatie.github.io/Haal-Centraal-BRP-bevragen/) (api sleutel verkrijgen via [RVIG](https://www.rvig.nl/brp/gebruikers-van-de-basisregistratie-personen-brp))
- [Haalcentraal BAG](https://github.com/VNG-Realisatie/Haal-Centraal-BAG-bevragen) (api sleutel verkrijgen via [Kadaster](https://www.kadaster.nl/zakelijk/producten/adressen-en-gebouwen/bag-api-huidige-bevragingen)
- [ZGW Zaken](https://vng-realisatie.github.io/gemma-zaken/standaard/zaken/) (zelf installeren via bijvoorbeeld [Open Zaak]())
- [ZGW Catalogi](https://vng-realisatie.github.io/gemma-zaken/standaard/catalogi/) (zelf installeren via bijvoorbeeld [Open Zaak]())
- [ZGW Documenten](https://vng-realisatie.github.io/gemma-zaken/standaard/documenten/) (zelf installeren via bijvoorbeeld [Open Zaak]())
- [ZGW Beslutien](https://vng-realisatie.github.io/gemma-zaken/standaard/besluiten/) (zelf installeren via bijvoorbeeld [Open Zaak]())
- [ZGW Authorisaties](https://vng-realisatie.github.io/gemma-zaken/standaard/autorisaties/) (zelf installeren via bijvoorbeeld [Open Zaak]())
- [ZGW Notificaties](https://vng-realisatie.github.io/gemma-zaken/standaard/notificaties/) (zelf installeren via bijvoorbeeld [Open Zaak]())
- [ZGW Zaken](https://vng-realisatie.github.io/gemma-zaken/standaard/zaken/) (zelf installeren via bijvoorbeeld [Open Zaak]())
- [ZGW Contactmomenten](https://vng-realisatie.github.io/gemma-zaken/standaard/contactmomenten/) (zelf installeren via bijvoorbeeld [Open Zaak]())
- [ZGW Klanten](https://vng-realisatie.github.io/gemma-zaken/standaard/klanten/) (zelf installeren via bijvoorbeeld [Open Zaak]())

Voor alle bovenstaande API's geld dat KISS tijdens installatie zelf mock's levert, het niet beschikken over een of meerdere van bovenstaande APIS is dus geen belemmering voor het testen of experimenteren met KISS. **Het is wel een belemmering voor in productie name**.

Mocht uw organisatie nu en/of in de toekomst niet beschikken over een of meerdere van bovenstaande API's dan levert de KISS applicatie de mogelijkheid om aan de hand van adapters andere bronnen te koppelen. Meer informatie over het vinden en of zelfstandig ontwikkelen van adapters vind u [hier](). Op dit moment zijn er adapters beschikbaar voor:

- ZDS
- Stuf
- SimForm
- Excellence zaaksysteem (v1 en v2 api)
- VrijBRP