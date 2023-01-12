# Openpub plugin.
Met de Openpub-plugin voor WordPress, breidt je WordPress uit voor het beheren en publiceren van nieuwsberichten en werkinstructies (PUB-publicaties) voor de KISS frontend.



## Installeren en configureren van de plugin
_Let op: we gaan er bij deze stappen van uit:_ 

- _dat er common-gateway installatie inclusief KissBundle aanwezig is_
- _dat je een actieve WordPress installatie (versie 6+) hebt draaien, met minimaal een Account met Administrator-rechten._
- _dat het een Nederlandstalige WordPress is. De Engelse termen staan tussen haakjes._ 

### installeer en activeer de Openpub-plugin en de Advanced Custom Fields-plugin
1. Ga naar de Openpub-repository binnen Klantinteractie-Servicesysteem, en download de zip van de plugin vanuit de map [Plugins](https://github.com/Klantinteractie-Servicesysteem/Openpub/tree/master/plugins)
2. Log in als Administrator op je WordPress-omgeving via /wp-admin 
4. Ga naar Plugins > Nieuwe toevoegen
5. Installeer de plugin via "Upload plugin", en gebruik de gedownloade openpub.zip
6. Activeer de plugin na installatie
7. Installeer vervolgens de ACF-plugin: ga naar Plugins > Nieuwe toevoegen, en zoek op "Advanced Custom Fields", en installeer de plugin. 
8. Download het bestand [publication-acf-group.json uit de map /plugins/OpenPub](https://github.com/Klantinteractie-Servicesysteem/Openpub/tree/master/plugins) van de Openpub-repository.

### Configureer de Openpup-plugin
10. Navigeer in WordPress naar "Aangepaste velden" ("Custom Fields") > "Gereedschap" ("Tools").
11. Upload het bestand publication-acf-group.json, bij het onderdeel "Veldgroepen Importeren" ("import field groups")
12. Controleer in de Gateway dat er twee objecten zijn, binnen het schema "kiss_openpub_type": Nieuws en Werkinstrcuties 
13. Navigeer naar "OpenPub" > "Configuration" en vul de gateway URI bij "API Domain" . Vul de  gateway API key bij "API KEY".
14. Maak minimmaal één gebruiker aan met de rol "Kiss Redacteur" (zie ook hieronder)
   _Let op: alleen gebruikers met de rol "KISS Redacteur" kunnen Publications aanmaken binnen de Openpub-plugin._


### Managing users

_Let op: Gebruikers met de rol "Administrator" kunnen nieuwe gebruikers aanmaken. Bij installatie van WordPress wordt er automatisch één administrator aangemaakt. Voor onderstaande stappen  moet je inloggen als Administrator._


#### Create a user

1. Navigate to "Users" and click on "Add new"
2. Fill the required fields (username and email), leave the other fields _as-is_
3. Change the (default) role of "Subscriber" to "KISS Redacteur"
4. Finally, click "Add New User"

_Note: if you want to create another Admin user, follow the above steps and choose the role "Administrator" instead of "KISS Redacteur"._

#### Remove a user

_Note: removing a user **can not** be reverted._

1. Navigate to "Users" and hover your mouse over the target user
2. Click "Delete"
3. Optionally, assign the user's content to another account
4. Finally, click "Confirm Deletion"

### Managing publications

_Note: Users with the role "KISS Redacteur" can manage publications, an account with this role should be created as stated within #Managing users._

#### Create a publication

1. Navigate to "Publications" and click "Add New"
2. Add the following fields
   - Title: the title of the publication (required)
   - Publicatie: the content of the publication (required)
   - Publicatitetype: the type of the publication ("Nieuws" or "Werkinstructie) (required)
   - Skills: the skills relevant to this publication (optional)
   - Einddatum: the date after which the publication is no longer visible (optional; the value must be in the future if you want your publication to be shown). This field is set to 100 years in the future by default.
   - Belangrijke publicatie: check this field to mark your publication as Important. 
3. Finally, click "Publish"

#### Editing a publication

1. Navigate to the publication you want to edit by clicking on "Publications" and then clicking on the target publication
2. Edit any field that needs editing (note: you cannot remove the required fields)
3. Finally, click "Publish"

#### Removing a publication

1. Navigate to the publication you want to remove by clicking on "Publications" and then clicking on the target publication
2. Click on "Move to Trash"

_Note: removed publications can be found and restored in the trash, once the trash is emptied they can no longer be restored._

## Proxy communication via Gateway
The KISS frontend loads the list of publication types and the list of skills from the wordpress installation. For this, it uses the following api-calls. 

_Optional parameter: `per_page`._

- `GET {gateway_environment_uri}/api/openpub/openpub_type`
  _Returns all openpub_type objects within the WordPress environment, via a gateway proxy._
- `GET {gateway_environment_uri}/api/openpub/openpub_skill`
  _Returns all openpub_skill objects within the WordPress environment, via a gateway proxy._



