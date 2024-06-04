
# Ontwerpbeslissingen.
KISS is ontwikkeld met een eindgebruikersgroep van Klantcontactmedewerkers (KCMs) van verschillende gemeenten. Uitgangspunt bij de ontwikkeling van KISS was om de beschikbare standaarden uit de Common Ground te gebruiken. Daar waar er vanuit de gebruikersgroep een informatiebehoefte was, maar waar nog geen (plek binnen de) standaard voor was, is een ontwerpbeslissing genomen wat hiermee te doen (zie ook [20230616-PodiumD-flow-afwijkingen-standaarden.pdf](https://github.com/Klantinteractie-Servicesysteem/.github/blob/main/docs/files/20230616-PodiumD-flow-afwijkingen-standaarden.pdf)). Op het moment dat er een gegevensbehoefte is binnen de applicatie, waarvoor nog geen (volledige) gegevensstandaard beschikbaar is, is de eerste vervolgvraag of deze gegevens ook beschikaar moeten zijn voor ándere applicaties binnen het landschap. Als dat niet het geval is, dan kunnen de gegevens binnen de applicatie zelf worden opgeslagen. Moeten de gegevens ook beschikbaar zijn voor andere applicaties, dan kiezen we ervoor om op basis van een gegevensontwerp een Objecttype aan te maken in de Objectenregistratie.  

## Contactmomenten
### Contactmomentdetails
Voor de onderstaande gegevens is tijdens fase 1C deze afweging gemaakt, en besloten de gegevens op te slaan binnen KISS zelf. Het gaat om gegevens van een contactoment die niet in het Contactmomentenregister passen. Deze gegevens leveren managementinformatie over de werkzaamheden van het KCC. Zie ook de issues  [#21](https://github.com/Klantinteractie-Servicesysteem/KISS-frontend/issues/21),  [#111](https://github.com/Klantinteractie-Servicesysteem/KISS-frontend/issues/111),  [#610](https://github.com/Klantinteractie-Servicesysteem/KISS-frontend/issues/610), [#611](https://github.com/Klantinteractie-Servicesysteem/KISS-frontend/issues/611).
Ze worden opgeslagen binnen KISS, en zijn op te vragen via de Contactmomentdetails API. Deze API is in eerste insantie zeer rudimentair van opzet: 
- de toegang is gebaseerd op de rol `redacteur` binnen KISS (zie ook: [CONFIGURATIE.md](https://raw.githubusercontent.com/Klantinteractie-Servicesysteem/.github/main/docs/CONFIGURATIE.md));
- de API geeft altijd de laatste 1000 records terug. 

| Property  | Type | Toelichting |
|--------|--------|--------|
| `vraag` | string (uri) | De URL's van geraadpleegde bronnen <br/>(Kennisbankartikelen / productpagina's, Vraag-<br/>Antwoord Combinaties (VAC) en <br />nieuws/werkinstructies) slaan we op in het property <br />`onderwerpLinks`. Voor Managementinformatie is dit <br />niet specifiek genoeg. Daarom kan een KCM één van de <br />bronnen selecteren bij "Vraag". De titel van deze <br />bron wordt opgeslagen in `vraag`. <br />Bij VAC's is dit de vraag. Bij Kennisartikelen / <br />productpagina's is dit de titel van het artikel plus <br />één van de geraadpleegde subonderdelen binnen het <br />artikel. Deze wordt in KISS ook gebruikt in de weergave <br />van Contactmomenten: hiermee kan een KCM zien wat <br />de vraag van de klant was. |
| `specifiekeVraag` | string | In het afhandelscherm kan een KCM de eigenlijke <br/>klantvraag invullen. Bijvoorbeeld omdat de `vraag` de eigenlijke vraag niet echt dekt. Of omdat het een nieuwe vraag is, die nog niet in de bron is verwerkt (sticker in je paspoort). Ook deze informatie is in te zien door de KCM bij het bekijken van Contactmomenten. | 
| `gespreksresultaat` | string  | Hierin slaan we het  gespreksresultaat van het contactmoment op, bijvoorbeeld 'Doorverbonden' of 'Zelfstandig afgehandeld'.  | 
| `startdatum` | string (date-time) | De tijd waar op het Contactmoment is gestart. Samen met `einddatum` bepaaalt dit de gespreksduur. | 
| `einddatum` | string (date-time) | De tijd waarop het Contactmoment is beëindigd. Samen met `startdatum` bepaaalt dit de gespreksduur. | 
| `verantwoordelijkeAfdeling` | string | Dit is de afdeling voor wie het contactmoment is afgehandeld. Deze moet de KCM kiezen in het afhandelscherm. Waar mogelijk wordt deze vooringevuld vanuit de gekozen bron bij `vraag`. | 
| `gespreksId` | string (uuid) | Een klant kan meerdere vragen stellen binnen één interactie met een Klantcontactmedewerker (KCM). Voor iedere vraag wordt een contactmoment aangemaakt. We hebben het property `gespreksId` toegevoegd. In het geval van 2 of meer vragen binnen één interactie, worden de vragen aan elkaar verbonden, doordat al deze contactmomenten hetzelfde `gespreksId` krijgen. | 

## Contactverzoeken 

### Contactverzoek als interneTaak
Voor Contactverzoeken is nog niet een éénduidige standaard. Sommige gemeenten zien een contactverzoek (terugbelverzoek) als een Zaak. Voor meerdere gemeenten binnen de projectgroep van KISS is dat geen optie. Binnen de [nieuwe standaard Klantinteracties](https://vng-realisatie.github.io/klantinteracties/) is het concept Interne taak geintroduceerd dat ingezet kan worden voor het Contactverzoek (zie bv. [C9167 - Klant belt KCC met een vraag die niet direct beantwoord kan worden en maakt een terugbelverzoek](https://vng-realisatie.github.io/klantinteracties/achtergronddocumentatie/artefacten/9167.html). 

Vooruitlopend op deze standaard is voor KISS een nieuw objecttype voor de interne taak ingericht. Omdat een contactverzoek in zijn geheel afhankelijk is van meerdere nieuwe objecten (betrokkene, actor) die nog niet uitgewerkt zijn als standaard (op moment van ontwikkelen, mei-juni 2023) is er voor gekozen om deze objecten als subobject op te nemen in het objecttype interne taak. Dit objecttype is als community concept beschikbaar bij [de Community concepts binnen Objecttypes, bij Open Objecten](https://github.com/open-objecten/objecttypes/tree/main/community-concepts). 

### Afdelingen en groepen
Een Contactverzoek moet binnen de eigen organisatie worden opgepakt. Binnen Klantinteracties is hiervoor het Actor-object beschikbaar, die van het soort `medewerker`, `organisatorische eenheid` of `geautomatiseerde actor` kan zijn (zie [Gegevenswoordenbek Klantinteracties, 2023-10-19T10:33:57.000+02:00](https://vng-realisatie.github.io/klantinteracties/informatiemodel/gegevenswoordenboek). KISS maakt gebruik van de eerste twee soorten. Binnen de gebruikersgroep was de behoefte om bij organisatorische eenheid onderscheid te kunnen maken tussen Afdeling of Groep. Daarom zijn er ook twee objecttypen hiervoor gemaakt: afdeling en groep. Ook deze objecttypen staan bij [de Community concepts](https://github.com/open-objecten/objecttypes/tree/main/community-concepts).

Bij de opzet van deze objecten zijn we uitgegaan van een hierarchische relatie tussen AFdeling, Groep en Medewerker. Bij de integratie van KISS met de e-Suite (in gebruikt bij Dimpact-gemeenten), in januari-februari 2024, blijkt dat de hierarchische relatie tussen afdelingen en groepen niet altijd bestaat. Groepen zijn daar een ander soort verzameling van medewerkers. Daarom is er een aanpassing gedaan in het groep-object, om te zorgen dat het `afdelingId` niet verplicht is (zie [PR 13](https://github.com/open-objecten/objecttypes/pull/13)).

Op plekken waar we naar afdelingen zoeken (bv. afdeling bij kennisartikelen, of bij medewerker) is de afdeling/groepsnaam gekozen als zoeksleutel. Dit is gedaan op basis van de toen beschikbare (test)data. Daarin was alleen naam altijd aanwezig, identificatie niet altijd. 


### Medewerkers en smoelenboek
Een KCM wil kunnen zoeken in bronnen met informatie, maar ook kunnen zoeken naar informatie over collega’s [#96](https://github.com/Klantinteractie-Servicesysteem/KISS-frontend/issues/96). Ook hier is nog geen standaard voor. In KISS Fase 1B is een voorzet gedaan voor een Medewerker API (gebaseerd op  de [HR-JSON-standaarden van HR Open Standards](https://www.hropenstandards.org/)). In KISS Fase 1C is deze verplaatst naar de Objecten API ( zie [de Community concepts](https://github.com/open-objecten/objecttypes/tree/main/community-concepts).) De objecten van het smoelenboek zijn geindexeerd in Elastic. Bij het doorzetten van een contactverzoek naar een medewerker, gebruiken we de gegevens uit Elastic.

Bij de integratie van KISS met de e-Suite (in gebruikt bij Dimpact-gemeenten), blijkt dat de naam van een medewerker niet altijd beschikbaar is in de onderdelen `voornaam`, `voorvoegselAchternaam` en `achternaam`. Daarom zijn de properties `voornaam` en `achternaam` niet langer verplicht, en is het property `volledigeNaam` toegevoegd. (zie [PR 13](https://github.com/open-objecten/objecttypes/pull/13))

## Zoeken in bronnen 
### Kennisartikelen / productpagina's (PDC) en VAC's
Een KCM wil kunnen zoeken in bronnen om de vraag van een klant te kunnen beantwoorden (zie [#22](https://github.com/Klantinteractie-Servicesysteem/KISS-frontend/issues/22)). Voor Kennisartikelen / productpagina's en VAC's zijn ook nog geen defintieve standaarden. Binnen KISS Fase 1C hebben we voor deze twee bronnen objectdefinties gemaakt, gebsaseerd op standaarden in wording in overleg met architecten van Dimpact.  

- Het object PDC - Kennisartikel is gebaseerd op de API voor [de SDG-invoervoorziening](https://github.com/maykinmedia/sdg-invoervoorziening)  ([versie 1.7.2](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/maykinmedia/sdg-invoervoorziening/1.7.2/src/openapi.yaml&nocors)). Daar zijn properties aan toegevoegd t.b.v. de behoeften van een KCM (interne informatie, informatie over contact opnemen, informatie over bijzonderheden, trefwoorden en verantwoordelijke afdeling). 
- Het object VAC is gebaseerd op een vergelijking van PDC - Kennisartikel, met de structuur van VAC's in SDU-catalogus. 

Beide objecten staan bij [de Community concepts](https://github.com/open-objecten/objecttypes/tree/main/community-concepts). 


## Contactmoment: de uitgebreide POST
KISS schrijft Contactmomenten weg m.b.v de VNG Contactmomenten API zoals deze is geïmplementeerd in Open Klant v0.5-pre. In een eerdere versie van KISS waren de gegevens die nu in Contactmomentdetails zitten, onderdeel van het uitgebreide Contactmoment. Omdat in KISS 1C de weg is gekozen om bestaande standaarden niet uit te breiden, zijn deze gegevens verplaatst naar Contactmomentdetails. Maar: ze zijn nog steeds onderdeel van de POST die KISS doet op de Contactmomenten API.  het ontvangende register negeeert deze onderdelen, en registreert alleen het object zoals gedefinieerde in de Contactmomenten API. 

Bij de integratie met de e-Suite (in gebruikt bij Dimpact-gemeenten), in januari-februari 2024, is een additionele [uitbreiding gedaan van de POST-data in contactmoment](POST-contactmoment.md). 

## Zaken: het zaakdetailscherm
In onderstaande afbeelding is gedocumenteerd welke gegevens uit de verschillen ZGW-objecten worden gebruikt in het Zaak-detailscherm. 

![image](https://raw.githubusercontent.com/Klantinteractie-Servicesysteem/.github/add-decision-record/docs/images/MappingZaakDetail.png)

## Logging voor verwerking
Omdat er nog geen definitieve standaard voor logging voor verwerking was in KISS Fase 1c, is er een voorbereiding gedaan t.b.v. een API voor verwerkingslogging, om de algemene werking alvast op te zetten totdat er een standaard beschikbaar is. Elke keer dat er een api call wordt gedaan naar externe systemen loggen we UserID, datum/tijd, het api-endpoint dat werd aangeroepen, en de methode waarmee het endpoint werd aangeroepen. Deze logging staat los van de errorlogging. Er is een zeer basaal API-endpoint voor ingericht. 

## Autorisatie
KISS is ontwikkeld met het oog op gebruik van een aantal api's (Klanten API, Contactmomenten, ZGW API's, Objecten API en Objecttypen API ). Deze API's e gaan ervan uit dat autorisatie door de aanroepende applicatie wordt gefaciliteert en niet door het register zelf. Daarom  gebeurt het inrichten van de autorisatie op applicatieniveau en niet op gebruikersniveau. En daarom worden er géén user tokens meegestuurd vanuit KISS naar de onderliggende registers, tenzij dat vereist wordt om specifieke redenen zoals bv. logging. 

Bij de eerste implementatie van KISS binnen een gemeente, moet KISS koppelen met een ouder register, de e-Suite. Deze kan de autorisatie (wat een gebruiker mag zien en doen) op gebruikerniveau. Als KISS op de e-Suite koppelt met gebruikmaking van de bestaande 'autorisatie-op-applicatieniveau', dan kan een KISS-gebruiker zaken en contacten zien, die deze gebruiker in de e-Suite niet mag zien. Om dat te voorkomen moet KISS dus een fijnmaziger autorisatie op gebruikersniveau mogelijk kunnen maken bij aansluiting op een onderliggen register. Hierdoor is de noodzaak onstaan om wél bij elk request userid mee te kunnen sturen in een JWT-token. 

Hierop is de koppeling met Overige Objecten aangepast: met moet namelijk, afhankelijk van configuratie per objecttype, mogelijk zijn om de calls naar het onderliggende register ófwel te voorzien van een token, ófwel van een token met user-id. 






