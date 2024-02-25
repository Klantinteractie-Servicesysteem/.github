
# Aanvullende gegevens bij Contactmomenten. 

Uitgangspunt bij de ontwikkeling van KISS was om de beschikbare standaarden uit de Common Ground te gebruiken. Daar waar er vanuit het project een informatiebehoefte was, die nog geen plek heeft in de standaarden, maar waar nog geen (plek binnen de) standaard voor was, is een ontwerpbeslissing genomen wat hiermee te den. Op het moment dat er een gegevensbehoefte is binnen de applicatie, waarvoor nog geen (volledige) gegevensstandaard beschikbaar is, is de eerste vervolgvraag of deze gegevens ook beschikaar moeten zijn voor ándere applicaties binnen het landschap. Als dat niet het geval is, dan kunnen de gegevens binnen de applicatie zelf worden opgeslagen. 

Voor de onderstaande gegevens is tijdens fase 1C deze afweging gemaakt, en besloten de gegevens op te slaan binnen KISS zelf. De behoefte bij deze gegevens is die naar managementinformatie over de werkzaamheden van het KCC. 

## Contactmomentdetails
De gegevens van een contactoment die binnen KISS worden verzameld, en die niet in het Contactmomentenregister passen, worden opgeslagen binnen KISS, en zijn op te vragen via de Contactmomentdetails API. Deze API is in eerste insantie zeer rudimentair van opzet: 
- de toegang is gebaseerd op de rol `redacteur` binnen KISS (zie ook: [CONFIGURATIE.md](https://raw.githubusercontent.com/Klantinteractie-Servicesysteem/.github/main/docs/CONFIGURATIE.md)
- de API geeft altijd de laatste 1000 records terug. 

| Property  | Type | Toelichting |
|--------|--------|--------|
| `vraag` | string (uri) | De geraadpleegde bronnen (Kennisbankartikelen, VAC's en nieuws/werkinstructies) slaan we op in het property `onderwerpLinks`. Voor Managementinformatie is dit niet specifiek genoeg. Daarom kan een KCM één van de bronnen selecteren bij "Vraag". De titel van deze deze bron wordt opgeslagen in `vraag`.
Bij VAC's is dit de vraag. Bij Kennisartikelen is dit de titel van het artikel plus één van de geraadpleegde subonderdelen binnen het artikel. Deze wordt in KISS ook gebruikt in de weergave van Contactmomenten: hiermee kan een KCM zien wat de vraag van de klant was. |
| `specifiekeVraag` | string | In het afhandelscherm kan een KCM de eigenlijke klantvraag invullen. Bijvoorbeeld omdat de `vraag` de eigenlijke vraag niet echt dekt. Of omdat het een nieuwe vraag is, die nog niet in de bron is verwerkt (sticker in je paspoort). Ook deze informatie is in te zien door de KCM bij het bekijken van Contactmomenten. | 
| `gespreksresultaat` | string  | Hierin slaan we het  gespreksresultaat van het contactmoment op, bijvoorbeeld 'Doorverbonden' of 'zelfstandig afgehandeld'.  | 
| `startdatum` | string (date-time) | De tijd waar op het Contactmoment is gestart. Samen met `einddatum` bepaaalt dit de gespreksduur. | 
| `einddatum` | string (date-time) | De tijd waarop het Contactmoment is beëindigd. Samen met `startdatum` bepaaalt dit de gespreksduur. | 
| `verantwoordelijkeAfdeling` | string | Dit is de afdeling voor wie het contactmoment is afgehandeld. Deze moet de KCM kiezen in het afhandelscherm. Waar mogelijk wordt deze vooringevuld vanuit de gekozen bron bij `vraag` | 
| `gespreksId` | string (uuid) | Een klant kan meerdere vragen stellen binnen één interactie met een Klantcontactmedewerker (KCM). Voor iedere vraag wordt een contactmoment aangemaakt. We hebben het property `gespreksId` toegevoegd. In het geval van 2 of meer vragen binnen één interactie, worden de vragen aan elkaar verbonden, doordat al deze contactmomenten hetzelfde `gespreksId` krijgen | 



 
