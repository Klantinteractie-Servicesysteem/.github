# Openpub plugin.
Met de Openpub-plugin voor WordPress, breidt je WordPress uit voor het beheren en publiceren van nieuwsberichten en werkinstructies (PUB-publicaties) voor de KISS frontend.

## Installeren en configureren van de plugin
_Let op: we gaan er bij deze stappen van uit:_ 

- _dat er een common-gateway installatie inclusief KissBundle aanwezig is_
- _dat je een actieve WordPress installatie (versie 6+) hebt draaien, met minimaal een Account met Administrator-rechten._
- _dat het een Nederlandstalige WordPress is. De Engelse termen staan tussen haakjes._ 

### Installeer en activeer de Openpub-plugin en de Advanced Custom Fields-plugin
1. Ga naar de Openpub-repository binnen Klantinteractie-Servicesysteem, en download de zip van de plugin vanuit de map [Plugins](https://github.com/Klantinteractie-Servicesysteem/Openpub/tree/master/plugins)
2. Log in als Administrator op je WordPress-omgeving via /wp-admin 
4. Ga naar Plugins > Nieuwe plugin
5. Installeer de plugin via "Plugin uploaden", en voeg de gedownloade openpub.zip toe.
6. Na installatie kun je de plugin activeren.
7. Installeer vervolgens de ACF-plugin: ga naar Plugins > Nieuwe plugin, en zoek op "Advanced Custom Fields", en installeer de plugin. Activeer deze na succesvolle installatie.


### Configureer de Openpup-plugin
8. Ga naar Github en download het bestand 'publication-acf-group.json' [uit de map /plugins/OpenPub](https://github.com/Klantinteractie-Servicesysteem/Openpub/tree/master/plugins/OpenPub) van de Openpub-repository
9. Ga naar WordPress en navigeer naar "Aangepaste velden" ("Custom Fields") > "Gereedschap" ("Tools").
11. Upload het bestand 'publication-acf-group.json', bij het onderdeel "Veldgroepen Importeren" ("Import field groups")
12. Log nu eerst in op de Gateway, ga daar naar het Schema "kiss_openpub_type", en controleer bij Objecten dat hier twee objecten staan: Nieuws en Werkinstructie. Als deze er niet staan, maak deze twee objecten dan aan. 
13. Ga terug naar WordPress, en navigeer in de linkerbalk naar "OpenPub" > "Configuration" en vul de gateway URI bij "API Domain". Vul de  gateway API key bij "API KEY", en sla op
14. Maak minimmaal één gebruiker aan met de rol "Kiss Redacteur" (zie ook hieronder)
   _Let op: alleen gebruikers met de rol "KISS Redacteur" kunnen Publications aanmaken binnen de Openpub-plugin._


### Gebruikers beheren

_Let op: Gebruikers met de rol "Administrator" kunnen nieuwe gebruikers aanmaken. Bij installatie van WordPress wordt er automatisch één administrator aangemaakt. Voor onderstaande stappen  moet je inloggen als Administrator._


#### Gebruiker aanmaken

1. Ga in het linkermenu naar "Gebruikers" ("Users") en kies "Nieuwe toevoegen" ("Add new")
2. Vul in ieder geval de verplichte velden in: gebruikersnaam en e-mail. De overige velden kun je leeg laten.
3. Wijzig de standaard rol "Abonnee" ("Subscriber") naar "KISS Redacteur"
4. Klik vervolgens op "Nieuwe gebruiker" ("Add New User")

_Let op: op deze manier kun je ook een tweede Admin-gebruiker aanmaken. Kies in dat geval voor de rol "Beheerder" ("Administrator") in plaats van "KISS Redacteur"._

#### Gebruiker verwijderen

_Let op: je kunt het verwijderen van een gebruiker **NIET** ongedaan maken._

1. Ga naar "Gebruikers" ("Users") and zweef met je muis over de gebruiker die je wilt verwijderen. Er verschijnen een aantal opties voor deze gebruiker:  "Bewerken", "Verwijderen" en "Bekijk
2. Klik op "Verwijderen" ("Delete")
3. Geef in het volgende scherm aan dat je de inhoud (content) van deze gebruiker aan een andere gebruiker wil koppelen. Kies hiervoor een andere KISS-redacteur. 
4. Klik tenslotte op "Verwijdering bevestigen" ("Confirm Deletion")

### Nieuws en werkinstructies (publications) beheren
_Let op: alléén gebruiker Users with the role "KISS Redacteur" kunnen Nieuws en werkinstructies (publications) aanmaken en beheren. Voor onderstaande stappen  moet je inloggen als Administrator. Zie ook onderdeel #Gebruikers beheren._

#### Een bericht aanmaken


1. Ga naar "Publications" in het linker menu en klik daarna op "Nieuw bericht"
2. Vul de volgende velden inAdd the following fields
   - Titel: de titel van het bericht (verplicht)
   - Publicatie: de inhoud van het bericht (verplicht)
   - Publicatitetype: geef aan of het om "Nieuws" gaat of om een "Werkinstructie" (verplicht)
   - Skills: selecteer eventueel één of meerdere skills die relevant zijn voor dit bericht.
   - Einddatum: Dit is de datum vanaf wanneer het bericht niet meer getoond wordt op de startpagina. Dit veld is verplicht. Standaard staat dit veld voroingevuld met een datum 100 jaar in de toekomst. 
   - Belangrijke publicatie: zet deze schuif om, als het om een belangrijk bericht gaat. 
3. Klik op "Publiceren" om het bericht meteen te publiceren. 
4. Wil je dat het bericht niet meteen verschijnt? klik dan op de link "Bewerken", achter "Onmiddelijk publiceren". Hier kun je de datum wijzigen naar bijvoorbeeld morgen. Zodra je dat opslaat, verandert de knop "Publiceren" naar een knop "Planning". Hiermee krijgt het bericht de status "Gepland". 

#### Een bericht bewerken.

1. Ga naar "Publications" in het linker menu en zoek het bericht op in de lijst met berichten. 
2. Klik op de titel van het bericht dat je wilt bewerken. 
3. Wijzig de benodigde velden. Verplichte velden kun je niet leeg laten.
4. Klik tenslotte op "Bijwerken". Het bericht zal bovenaan de lijst met berichten komen te staan: op de startpagina van KISS worden de berichten gesorteerd op Datum Gewijzigd. 

#### Een bericht verwijderen

1. Ga naar "Publications" in het linker menu en zoek het bericht op in de lijst met berichten. 
2. Klik op de titel van het bericht dat je wilt bewerken. 
3. Klik links van de knop "Bijwerken" op de link "Verplaats naar prullenbak"

_Let op: berichten die in de prullenbak staan, kunnen eventueel opnieuw gepubliceerd worden. Zodra je een bericht ook uit de  prullenbak is verwijderd, kan het bericht niet meer hersteld worden._

## Proxy communication via Gateway
The KISS frontend loads the list of publication types and the list of skills from the wordpress installation. For this, it uses the following api-calls. 

_Optional parameter: `per_page`._

- `GET {gateway_environment_uri}/api/openpub/openpub_type`
  _Returns all openpub_type objects within the WordPress environment, via a gateway proxy._
- `GET {gateway_environment_uri}/api/openpub/openpub_skill`
  _Returns all openpub_skill objects within the WordPress environment, via a gateway proxy._



