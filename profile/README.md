
# Klantinteractie Servicesysteem (KISS)

Het Klantinteractie Servicesysteem (KISS) is een applicatie waarmee Klantcontactmedewerkers (KCM) optimaal worden ondersteund in hun werk: het informeren en helpen van burgers en ondernemers die contact opnemen met de gemeente. Het doel van KISS is om alle informatie die een KCM nodig heeft voor die taak, zoveel mogelijk binnen KISS zelf te ontsluiten. Het is ontwikkeld als een [Common Ground component](https://commonground.nl/groups/view/07b18e2c-471b-4874-80b5-020dfe4ad52e/team-kiss) met een actieve community.


## Roadmap en doorontwikkeling

KISS is in september 2023 opgeleverd en sindsdien flink doorontwikkeld. De doorontwikkeling van KISS ligt bij de KISS community, een actieve gemeentelijke samenwerking. Meer informatie over KISS, de roadmap en doorontwikkeling van de applicatie? Kijk op https://www.kiss-klantcontact.nl/

## Documentatie 

- [Documentatie](https://kiss-klantinteractie-servicesysteem.readthedocs.io/):
  - [Installatie handleiding](https://kiss-klantinteractie-servicesysteem.readthedocs.io/nl/stable/installation/installation.html)  
  - [Configuratie](https://kiss-klantinteractie-servicesysteem.readthedocs.io/nl/stable/configuration/configuration.html)
  - [Handleiding beheer](https://kiss-klantinteractie-servicesysteem.readthedocs.io/nl/stable/manual/manual.html)
  - [Ontwerpbeslissingen](https://kiss-klantinteractie-servicesysteem.readthedocs.io/nl/stable/decision-record/decision-record.html)


## Waaruit bestaat KISS-frontend

De KISS-applicatie bestaat uit een User Interface (Vue) op een Backend for frontend (.Net + PostgreSQL).  Kennisbronnen worden ontsloten m.b.v, een Search Index (Elastic Search). 


## API's 
De KISS-applicatie maakt gebruik van enkele landelijke basisregistraties. Daarnaast implementeert KISS verschillende standaarden uit het domein van Common Ground, die zijn ontwikkeld onder de vlag van VNG, en waarvan sommige inmiddels ook [door VNG gestandaardiseerd zijn](https://www.gemmaonline.nl/index.php/Ontwikkelagenda_API-standaarden).  

- [KvK apis](https://developers.kvk.nl/documentation/zoeken-api)
- [Haal Centraal BRP Personen bevragen](https://brp-api.github.io/Haal-Centraal-BRP-bevragen/) 
- [ZGW Zaken](https://openzaak.prod.kiss-demo.nl/zaken/api/v1/schema/) 
- [ZGW Catalogi](https://openzaak.prod.kiss-demo.nl/catalogi/api/v1/schema/) 
- [ZGW Documenten](https://openzaak.prod.kiss-demo.nl/documenten/api/v1/schema/)
- [Objecttype API](https://github.com/maykinmedia/objecttypes-api/) voor Afdeling, Groep, Medewerker, VAC, PDC en Contactverzoek als interne taak ([deze worden momenteel gereviewed, zie ook de Community concepts binnen Objecttypes, bij Open Objecten](https://github.com/open-objecten/objecttypes/tree/main/community-concepts)
  - Het PDC-object is gebaseerd op de API van [de SDG-invoervoorziening (versie 1.3.0)](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/maykinmedia/sdg-invoervoorziening/1.3.0/src/openapi.yaml&nocors)
- [Objecten API](https://github.com/maykinmedia/objects-api)
- [Klanten API](https://open-klant.prod.kiss-demo.nl/klanten/api/v1/schema/), zoals geïmplementeerd in v0.1 van [Open Klant](https://github.com/maykinmedia/open-klant); waarbij we zijn uitgegaan van de standaard (dus niet de afwijkingen op de standaard, die zijn gemarkeerd is de specificatie)
- [Contactmomenten API](https://open-klant.prod.kiss-demo.nl/contactmomenten/api/v1/schema/), zoals geïmplementeerd in v0.1 van [Open Klant](https://github.com/maykinmedia/open-klant); waarbij we zijn uitgegaan van de standaard (dus niet de afwijkingen op de standaard, die zijn gemarkeerd is de specificatie)

Daar waar de API-standaarden ontoereikend zijn of ontbreken breiden we de API's uit volgens het vastgesteld ontwerpprincipe "afwijking van de standaard" VNG/Dimpact 16 juni 2023 ([zie: 20230616-PodiumD-flow-afwijkingen-standaarden.pdf](https://github.com/Klantinteractie-Servicesysteem/.github/blob/main/docs/files/20230616-PodiumD-flow-afwijkingen-standaarden.pdf)).


## Bouw
KISS wordt ontwikkeld door ICATT menselijk digitaal in opdracht van de KISS community.

## Licentie
[European Union Public License](https://opensource.org/licenses/EUPL-1.2)
