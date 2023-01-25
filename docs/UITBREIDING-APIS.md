# Uitbreidingen op de API's

Uitgangspunt bij de ontwikkeling van KISS was om de beschikbare standaarden uit de Common Ground te gebruiken, maar deze ook uit te breiden. Binnen het project hebben we de onderstaande  uitbreidingen gedaan.

### ZGW Contactmomenten
**Property `gespreksId`**

Een klant kan meerdere vragen stellen binnen één interactie met een KCM. Voor iedere vraag wordt een contactmoment aangemaakt. We hebben het property `gespreksId` toegevoegd. In het geval van 2 of meer vragen binnen één interactie, worden de vragen aan elkaar verbonden, doordat al deze contactmomenten hetzelfde `gespreksId` krijgen.

**primaireVraag en primairevraagWeergave**

De geraadpleegde bronnen (kennisartikelen en PUB-berichten) slaan we op in het property “onderwerpLinks” Voor Managementinformatie is dit niet specifiek genoeg. Daarom kan een KCM één van de bronnen aangeven als Primairevraag. Het id van deze bron wordt opgeslagen in primaireVraag. De titel van deze bron slaan we op in primairevraagWeergave. Deze wordt in KISS ook gebruikt in de weergave van Contactmomenten.

todo
Klantcontact medewerkers willen contactverzoeken voor anderen kunnen aanmaken. De contactmomenten standaard is uitgebreid met een property “to do”.  Dit is een subobject analoog aan de todo uit de Calendar API specificatie [VAN WIE].  
ZGW Klanten
Telefoonnummers en emails
Klant contact medewerkers willen bij een klant meerdere telefoonnummers en e-mails kunnen vastleggen. De klanten API ondersteund dit niet: het property telefoonnummer is van het type string. Hetzelfde geldt van emailadres. Daarom hebben we de klant uitgebreid met twee aanvullende properties, “telefoonnummers” en “emails”. Dit zijn arrays waarin meerdere telefoonnummers en e-mailadressen kunnen worden opgeslagen.
Website
In de klanten-api van de VNG is het property ‘website’ verplicht. Binnen KISS is het niet mogelijk om hier eenvoudig een zinvolle waarde aan toe te voegen. Daarom hebben we deze niet-verplicht gemaakt. 
SDG Plus
Klantcontact medewerkers zoeken gericht in de producten- en dienstencatalogus en willen de vastlegging van het contactmoment zo specifiek en snel mogelijk afronden, en relateren aan de interne informatievoorziening. Specifiek betekent in dit geval dat niet alleen de naam van het product maar ook het onderdeel van product kan worden geregistreerd (bv parkeergunning - tarieven). Er is geen VNG-gegevensstandaard voor producten en diensten. Binnen KISS maken we gebruik van de api die is ontwikkeld voor de SDG Invoervoorziening. Deze is uitgebreid  “conditions” (voorwaarden), “notice” (bijzonderheden), “contact”,  “synonyms”, en  “deskmemo” (interne informatie) om aan te sluiten bij de producten en dienstenscatalogi  die veel Klantcontact medewerkers van Dimpact nu gebruiken:  De PDC van SDU. We gebruiken deze properties uit SDG op dit moment niet: “bewijs”, “vereisten”, “wat te doen bij geen reactie”.
Medewerkers
Klant contact medewerkers willen collega’s uit de eigen organisatie kunnen opzoeken om te raadplegen, door te verwijzen of een contactverzoek voor klaar te zetten. Er is geen VNG gegevensstandaard voor smoelenboek. Binnen KISS is een opzet gemaakt voor het Smoelenboek. Deze is gebaseerd op de HR-XML van HR-XML Consortium, voor de properties “department” “description”, “function”, “replacement”. In overleg met de Ontwerpgroep is hieraan toegevoegd: “skills”, dit is een string-type, waarin beschreven is: wat doe je, wat kun je; “availabilities”, dit is een array met daarin voor de vijf weekdagen per dagdelen aangegeven of iemand aanwezig is (true) of niet (false). Voor contactgegevens is een subobject “contact” toegevoegd, dat qua structuur erg lijkt op de naam en contactgegevens uit de Klanten-api
