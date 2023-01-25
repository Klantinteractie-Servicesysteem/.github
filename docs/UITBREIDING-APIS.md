# Uitbreidingen op de API's

Uitgangspunt bij de ontwikkeling van KISS was om de beschikbare standaarden uit de Common Ground te gebruiken, maar deze ook uit te breiden. Binnen het project hebben we de onderstaande  uitbreidingen gedaan. 

### ZGW Contactmomenten
**gespreksId**

Een klant kan meerdere vragen stellen binnen één interactie met een Klantcontactmedewerker (KCM). Voor iedere vraag wordt een contactmoment aangemaakt. We hebben het property `gespreksId` toegevoegd. In het geval van 2 of meer vragen binnen één interactie, worden de vragen aan elkaar verbonden, doordat al deze contactmomenten hetzelfde `gespreksId` krijgen.

**Primaire vraag**

De geraadpleegde bronnen (kennisartikelen en PUB-berichten) slaan we op in het property 'onderwerpLinks'. Voor Managementinformatie is dit niet specifiek genoeg. Daarom kan een KCM één van de bronnen selecteren bij "Vraag". Het id van deze bron wordt opgeslagen in `primaireVraag`. De titel van deze bron slaan we op in `primairevraagWeergave`. Deze wordt in KISS ook gebruikt in de weergave van Contactmomenten.

**Property `todo`**

Een KCM wil contactverzoeken voor collega's kunnen aanmaken. De standaard voor contactmomenten is uitgebreid met een property `todo`.  Dit is een subobject analoog aan de `todo` uit [iCal-specificatie](https://en.wikipedia.org/wiki/ICalendar). De collega voor wie het Contactverzoek is, 

### ZGW Klanten
**Telefoonnummers en e-mailadressen**

Een KCM wil bij een klant meerdere telefoonnummers en e-mails kunnen vastleggen. De klanten-API ondersteund dit niet: het property `telefoonnummer` is van het type string. Hetzelfde geldt voor `emailadres`. Daarom hebben we de Klanten-api uitgebreid met twee aanvullende properties, `telefoonnummers` en `emails`. Dit zijn arrays waarin meerdere telefoonnummers en e-mailadressen kunnen worden opgeslagen.

**Website**

In de Klanten-api van de VNG is het property `website` verplicht. Binnen KISS is het niet mogelijk om hier eenvoudig een zinvolle waarde aan toe te voegen. Daarom hebben we deze niet-verplicht gemaakt. NB: dit is in feite geen uitbreiding maar een _aanpassing_ van de huidige standaard. 

## SDG Plus
Een KCM zoekt gericht in de producten- en dienstencatalogus en willen de vastlegging van het contactmoment zo specifiek en snel mogelijk afronden. Specifiek betekent in dit geval dat niet alleen de naam van het product maar ook het onderdeel binnen de inforamtie over het product kan worden geregistreerd (bv parkeergunning - tarieven). Er is geen VNG-gegevensstandaard voor producten en diensten. De SDG Plus api die we gebruiken binnen KISS, is gebaseerd op de api die is ontwikkeld voor de SDG Invoervoorziening. Deze hebben we, binnen het subobject `vertalingen`, uitgebreid met  `conditions` (voorwaarden), `notice` (bijzonderheden), `contact`,  `synonyms`, en  `deskmemo` (interne informatie). Hiermee sluiten we aan bij de producten- en dienstenscatalogi  die veel Klantcontact medewerkers van Dimpact nu gebruiken: de PDC van SDU. We gebruiken deze properties uit SDG op dit moment niet: `bewijs`, `vereisten` en `wat te doen bij geen reactie`.

### Medewerkers

Een KCM wil collega’s uit de eigen organisatie kunnen opzoeken om te raadplegen, door te verwijzen of een contactverzoek voor klaar te zetten. Er is geen VNG gegevensstandaard voor deze bron. Binnen KISS is een opzet gemaakt voor het Smoelenboek. Deze is gebaseerd op de HR-JSON-standaarden van [HR Open Standards](https://www.hropenstandards.org/). De properties `department` `description`, `function` en  `replacement` zijn in overleg met Dimpact aangevuld met een aantal meer Smoelenboek-achtige gegevens. `skills` een string-type waarin beschreven is: wat doe je, wat kun je. `availabilities`, een array met daarin voor de vijf weekdagen per dagdelen aangegeven of iemand aanwezig is (true) of niet (false). Voor contactgegevens is een subobject `contact` toegevoegd, qua structuur analoog aan naam en contactgegevens uit de Klanten-api.

### OpenAPI specificatie
De volledige implementatie van alle API's vindt u [in ReDoc](https://redocly.github.io/redoc/?nocors&url=https://kissdevelopment-dimpact.commonground.nu/openapi.json).