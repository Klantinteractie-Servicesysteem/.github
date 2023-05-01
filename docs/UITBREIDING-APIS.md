<link rel="stylesheet" type="text/css" href="style.css">

# Uitbreidingen op de API's

Uitgangspunt bij de ontwikkeling van KISS was om de beschikbare standaarden uit de Common Ground te gebruiken, maar deze ook uit te breiden. Binnen het project hebben we de onderstaande  uitbreidingen gedaan. 

### ZGW Contactmomenten

| Property  | Type | Toelichting |
|--------|--------|--------|
| `primaireVraag` | string (uri) | De geraadpleegde bronnen (kennisartikelen en PUB-berichten) slaan we op in het property `onderwerpLinks`. Voor Managementinformatie is dit niet specifiek genoeg. Daarom kan een KCM één van de bronnen selecteren bij "Vraag". De verwijzing naar deze bron wordt opgeslagen in `primaireVraag`. |
| `primairevraagWeergave` | string | De titel van de `primaireVraag` slaan we op in `primairevraagWeergave`. Deze wordt in KISS ook gebruikt in de weergave van Contactmomenten: hiermee kan een KCM zien wat de vraag van de klant was. |
| `afwijkendOnderwerp` | string | In het afhandelscherm kan een KCM de eigenlijke klantvraag invullen. Bijvoorbeeld omdat de `primaireVraagWeergave` de eigenlijke vraag niet echt dekt. Of omdat het een nieuwe vraag is, die nog niet in de bron is verwerkt (sticker in je paspoort). Ook deze informatie is in te zien door de KCM bij het bekijken van Contactmomenten. | 
| `resultaat` | string  | Hierin slaan we het  gespreksresultaat van het contactmoment op, bijvoorbeeld 'Doorverbonden' of 'zelfstandig afgehandeld'.  | 
| `startdatum` | string (date-time) | De tijd waar op het Contactmoment is gestart. Samen met `einddatum` bepaaalt dit de gespreksduur. | 
| `einddatum` | string (date-time) | De tijd waarop het Contactmoment is beëindigd. Samen met `startdatum` bepaaalt dit de gespreksduur. | 
| `gespreksId` | string (uuid) | Een klant kan meerdere vragen stellen binnen één interactie met een Klantcontactmedewerker (KCM). Voor iedere vraag wordt een contactmoment aangemaakt. We hebben het property `gespreksId` toegevoegd. In het geval van 2 of meer vragen binnen één interactie, worden de vragen aan elkaar verbonden, doordat al deze contactmomenten hetzelfde `gespreksId` krijgen | 
| `toDo` | string (date-time) | Een KCM wil contactverzoeken voor collega's kunnen aanmaken. De standaard voor contactmomenten is uitgebreid met een property `todo`.  Dit is een subobject analoog aan de `todo` uit [iCal-specificatie](https://en.wikipedia.org/wiki/ICalendar). Het e-mailadres van de collega voor wie het Contactverzoek is, komt te staan in `toDo.attendees`. Als er een afdeling gekozen wordt, komt die ook in `toDo.attendees` te staan. | 


 

### ZGW Klanten

| Property  | Type | Toelichting |
|--------|--------|--------|
| `telefoonnummers` | Array | Een KCM wil bij een klant meerdere telefoonnummers kunnen vastleggen. De klanten-API ondersteund dit niet: het property `telefoonnummer` is van het type string. Daarom is hier de array toegevoegd, waarin meerdere telefoonnummers kunnen. Elk telefoonnummer bestaat uit `telefoonnummers.telefoonnummer` en `telefoonnummers.naam`.  |
| `emails` | Array | Een KCM wil bij een klant meerdere e-mailadressen en e-mails kunnen vastleggen. De klanten-API ondersteund dit niet: het property `emailadres` is van het type string. Daarom is hier de array toegevoegd, waarin meerdere e-mailadressen in kunnen. Elk e-mailadres bestaat uit `emails.email` en `emails.naam`.  |
| `websiteUrl` | string (uri)  |   In de Klanten-api van de VNG is het property websiteUrl verplicht. In het schema staat dit property alsvolgt omschreven: "Het label of etiket dat aan de specifieke informatiebron, zoals een webpagina, een bestand of een plaatje op internet is toegewezen waar de KLANT in de regel op het internet vindbaar is." Binnen KISS is het niet mogelijk om hier eenvoudig een zinvolle waarde aan toe te voegen. Daarom hebben we deze niet-verplicht gemaakt. NB: dit is in feite geen uitbreiding maar een _aanpassing_ van de huidige standaard. |



## SDG Plus
Een KCM zoekt gericht in de producten- en dienstencatalogus en willen de vastlegging van het contactmoment zo specifiek en snel mogelijk afronden. Specifiek betekent in dit geval dat niet alleen de naam van het product maar ook het onderdeel binnen de inforamtie over het product kan worden geregistreerd (bv parkeergunning - tarieven). Er is geen VNG-gegevensstandaard voor producten en diensten. De SDG Plus API die we gebruiken binnen KISS, is gebaseerd op versie 1.3.0 van de API die is ontwikkeld voor de [SDG Invoervoorziening](https://github.com/maykinmedia/sdg-invoervoorziening). Deze hebben we, binnen het subobject `vertalingen`,  uitgebreid met de volgende properties: 

| Property  | Type | Toelichting |
|--------|--------|--------|
| `conditions` | string | Mapping op tab Voorwaarden in de SDU catalogus |
| `notice` | string | Mapping op tab BIjzonderheden in de SDU catalogus |
| `conditions` | string | Mapping op tab BIjzonderheden in de SDU catalogus |
| `contact` | string | Veld om informatie over contact ook minder gestructureerd te kunnen aanbieden |
| `synonyms` | array | Verzameling synoniemen van het product t.b.v. vindbaarheid. |
| `deskmemo` | string | Veld om interne informatie in op te slaan, die alleen voor de KCM (interne organisatie) bestemd is. |

NB: De API moet eigenlijk geüpgrade worden, om aan te sluiten bij SDG versie 1.7.2. Op dat moment zou eigenlijk ook de toevoeging van `conditions` herzien moeten worden: de informatie hierin past prima in het veld `vereisten` van de SDG. 


### Medewerkers

Een KCM wil collega’s uit de eigen organisatie kunnen opzoeken om te raadplegen, door te verwijzen of een contactverzoek voor klaar te zetten. Er is geen VNG gegevensstandaard voor deze bron. Binnen KISS is een opzet gemaakt voor het Smoelenboek. Deze is gebaseerd op de HR-JSON-standaarden van [HR Open Standards](https://www.hropenstandards.org/). De properties `department` `description`, `function` en  `replacement` zijn in overleg met Dimpact aangevuld met een aantal meer Smoelenboek-achtige gegevens:

| Property  | Type | Toelichting |
|--------|--------|--------|
| `skills` | string | Veld waarin een medewerker de vraag Wat doe je en wat kun je? kan beantwoorden. |
| `availabilities` | array | Array met daarin voor de vijf werkdagen in de week per dagdeel aangegeven of iemand aanwezig is (true) of niet (false) |
| `contact` | subobject | Subobject dat qua structuur analoog is aan naam en contactgegevens uit de Klanten-api |



### OpenAPI specificatie
De volledige implementatie van alle API's vindt u [in ReDoc](https://redocly.github.io/redoc/?nocors&url=https://kissdevelopment-dimpact.commonground.nu/openapi.json).
