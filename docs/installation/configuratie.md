# Configuratie: Environment Variabelen

Hieronder staan de benodigde environment variabelen per onderdeel van KISS.

## Authenticatie

| Variabele                                | Uitleg                                                    |
| ---------------------------------------- | --------------------------------------------------------- |
| `OIDC_AUTHORITY`                          | URL van de OpenID Connect Identity Provider                 |
| `OIDC_CLIENT_ID`                           | Voor toegang tot de OpenID Connect Identity Provider      |
| `OIDC_CLIENT_SECRET`                       | Secret voor de OpenID Connect Identity Provider           |
| `OIDC_MEDEWERKER_IDENTIFICATIE_CLAIM`    | Identificatie van de medewerker in registers <br/> (default waarde is `email`) <details> <summary>Meer informatie </summary> Bij het wegschrijven van gegevens naar bv. Open Klant of Open Zaak is een `medewerkerIdentificatie.identificatie` verplicht. Verschillende gemeenten gebruiken hier verschillende waardes voor. Bij een koppeling met bv. de e-Suite is het van belang dat hier de e-Suite gebruikersnaam in staat van de ingelogde KCM. </details>|
| `OIDC_MEDEWERKER_IDENTIFICATIE_TRUNCATE` | Optioneel afkappen van de claim <br/> (bijv. `24`) <details> <summary>Meer informatie </summary> Binnen ZGW mag een `medewerkerIdentificatie.identificatie` niet langer zijn dan 24 karakters. Met deze variabele kun je ervoor zorgen dat de uiteindelijk waarde wordt afgekapt na 24 tekens. </details>       |
| `MANAGEMENTINFORMATIE_API_KEY` | Secret dat KISS gebruikt om het JWT Token <br/>te valideren bij het opvragen van <br/>contactmomentdetails <details> <summary>Meer informatie </summary>Zie de [Handleiding beheer KISS, hoofdstuk <br/> managementinformatie](../manual/managementinformatie.md) voor informatie over <br/>het gebruik van deze API.</details> |
|  |  |

## Database

| Variabele          | Uitleg                                |
| ------------------ | ------------------------------------- |
| `POSTGRES_DB`       | Naam van de database bij KISS         |
| `POSTGRES_USER`     | Gebruikersnaam voor toegang van KISS tot de DB |
| `POSTGRES_PASSWORD` | Wachtwoord van de postgresUser        |
|  |  |

## Organisatie RSIN

| Variabele         | Uitleg                                                           |
| ----------------- | ---------------------------------------------------------------- |
| `ORGANISATIE_IDS` | RSIN van de organisatie die de <br/> Contactmomenten registreert <details> <summary>Meer informatie </summary>Verschillende ZGW APIs, waaronder de Klant en Contactmoment APIs, vragen om een identificatienummer, RSIN, van de eigen organisatie. Dit RSIN moet worden meegegeven bij registratie van specifieke objecten. </details>|
|  |  |

## Feedback op Kennisartikelen
<details> <summary>Meer informatie </summary>Vanuit KISS kan een KCM feedback geven op een kennisartikel. Deze informatie wordt gemaild naar één centraal e-mailadres. Dit configureer je met onderstaande variabelen. </details>

| Variabele             | Uitleg                                  |
| --------------------- | --------------------------------------- |
| `FEEDBACK_EMAIL_FROM` | Afzenderadres van de feedbackmail       |
| `FEEDBACK_EMAIL_TO`   | Adres waar de feedbackmail naartoe moet |
| `EMAIL_ENABLE_SSL`    | Gebruik van SSL (true/false)            |
| `EMAIL_HOST`          | Adres van de mailserver                 |
| `EMAIL_PORT`          | Poortnummer van de mailverbinding       |
| `EMAIL_USERNAME`      | Gebruikersnaam voor de mailserver       |
| `EMAIL_PASSWORD`      | Wachtwoord voor de mailserver           |
|  |  |

## Gekoppelde Bronnen

Er zijn diverse API's die vanuit KISS bevraagd worden. Hieronder staan de environment variabelen per gekoppelde bron. 
**Let op**: 
1. Sommige API-keys en Secrets die KISS nodig heeft om externe registers te bevragen moeten **minimaal 32 karakters** lang zijn. 
2. Voor variabelen met `__0__` als tussenvoegsel geldt dat er een lijst opgebouwd kan worden. Het eerste item van de lijst heeft `__0__` als tussenvoegsel, het tweede item `__1__`, en zo verder.

<details> <summary>Meer informatie </summary>Er zijn diverse bronnen die vanuit KISS via API's bevraagd worden. Sommige worden alleen geraadpleegd, zoals de KvK-API en de API voor Haal Centraal BRP Personen bevragen, en de Objecten API voor het ophalen van Afdelingen, Groepen en Medewerkers. Andere registraties worden niet alleen geraadpleegd, maar er worden ook gegevens in weggeschreven. Dit zijn in ieder geval een Klanten- en Contactmomentenregister, zoals Open Klant, het Objecten Register zoals Open Objecten, en een Zaaksysteem (m.b.v. ZGW API's) zoals Open Zaak.

Daarnaast zijn er bronnen die binnen KISS doorzocht moeten worden.

- KISS gebruikt de Objecten API om Kennisartikelen (PDC-producten) mee op te halen, en naar Elastic te pushen.
- KISS gebruikt op dit moment de Objecten API om de Medewerkers in het Smoelenboek op te halen en naar Elastic te pushen.
- KISS gebruikt op dit moment de Objecten API om de Vraag Antwoord Combinaties (VAC) op te halen en naar Elastic te pushen.</details>


### KISS-frontend, klanten, contactmomenten en zaken

**Let op, voorheen waren er losse opzichzelf staande variabelelen voor verschillende registers. Nu moeten er setjes van klantregister + contactmomentregister + contactverzoekregister (interne taak) + zaaksysteem worden gemaakt.
Er is bijvoorbeeld niet meer sprake van een enkele opzichzelfstaande `KLANTINTERACTIES_BASE_URL` variabele, maar in plaats daarvan is er een `REGISTERS__0__KLANTINTERACTIES_BASE_URL` en eventueel een `REGISTERS__1__KLANTINTERACTIES_BASE_URL`, een `REGISTERS__2__KLANTINTERACTIES_BASE_URL`, etc. <mark>Lees de releasenotes van KISS voor een verdere toelichting tav de gewijzigde variabelen!</mark>**


| Variabele                               | Uitleg                                                |
| ---------------------------------       | --------------------------------------------------------------------------------------------                                     |
|REGISTERS__N__IS_DEFAULT                 |true of false <details> <summary>Meer informatie </summary>Er moet exact 1 default register-set zijn. Klanten, contactmomenten en contactverzoeken worden in dit defaultregister aangemaakt, tenzij uit de context blijkt dat de gegevens in een specifiek register thuis horen. Bijvoorbeeld, als een contactmoment bij een zaak uit een bepaald zaaksysteem hoort, dan wordt het contactmoment opgeslagen in het contactmomentregister dat hoort bij dat Zaaksysteem. Dit is het het zaaksysteem dat deel uitmaakt van dezelfde REGISTERS__X__...-set waar ook het zaaksysteem inzit. <br /> </details>                     |
|REGISTERS__N__ZAAKSYSTEEM_BASE_URL       |URL van de ZGW API's   <details> <summary>Meer informatie </summary> Bijvoorbeeld: `https://zaaksysteem.mijngemeente.nl`  </details>|
|REGISTERS__N__ZAAKSYSTEEM_API_KEY        |API Key voor de ZGW API's <br /> **(min. 32 karakters)**                                                                            |
|REGISTERS__N__ZAAKSYSTEEM_API_CLIENT_ID  |ClientId voor de ZGW API's                                                                                                          |
|REGISTERS__N__ZAAKSYSTEEM_DEEPLINK_URL   |Basisurl om te deeplinken naar een Zaak in het zaaksysteem (optioneel) <details> <summary>Meer informatie </summary> Bijvoorbeeld: `https://zaaksysteem.mijngemeente.nl/mp/zaak/` <br /> Deze variabele **moet** altijd gebruikt worden **in combinatie met** `ZAAKSYSTEEM__N__DEEPLINK_PROPERTY`. Als deze variabelen beiden worden ingevuld, zal er in KISS een link in het zaakdetailscherm staan, waarmee de KCM de betreffende zaak direct in het zaaksysteem opent.  LET OP: dit kan alleen bij zaaksystemen die een vaste url hebben voor zaakdetails, waarbij alleen één property van de zaak, bijv. het zaaknummer, áchter die URL geplaatst hoeft te worden.  </details>                                                                             |
|REGISTERS__N__ZAAKSYSTEEM_DEEPLINK_PROPERTY   |Property om naar een zaak te kunnen deeplinken (optioneel) <details> <summary>Meer informatie </summary> Deze variabele **moet** altijd gebruikt worden **in combinatie met** `ZAAKSYSTEEM__N__DEEPLINK_URL`. De waarde uit dit property van een specifieke zaak wordt achter `ZAAKSYSTEEM_DEEPLINK_URL` geplaatst om de link te laten werken. Bijvoorbeeld: `identificatie` </details>  |
|REGISTERS__N__REGISTRY_VERSION           |OpenKlant2 of OpenKlant1 <details> <summary>Meer informatie </summary> Gebruikt OpenKlant1 alléén als je wilt koppelen met de e-Suite. KISS ondersteunt de Klanten API, de Contactmomenten API en het objecttype Interne Taak. In andere gevallen vul hier OpenKlant2 in. </details>                                  | 
|    **-------------------------**    |  **De volgende variabelen gebruik je alleen bij het gebruik van een Open Klant 2 omgeving. Je hebt dan dus bij REGISTERS__N__REGISTRY_VERSION 'OpenKlant2' ingevuld!**       | 
|REGISTERS__N__KLANTINTERACTIES_BASE_URL   |URL van de Klantinteractie API van het gebruikte OpenKlant2 klantinteractieregister <details> <summary>Meer informatie </summary>Bijvoorbeeld `https://klantinteractieregister.mijngemeente.nl/klantinteracties` </details>  |
|REGISTERS__N__KLANTINTERACTIES_TOKEN      |Token voor de Klantinteractie API van het gebruikte klantinteractieregister                                                         | 
|     **-------------------------**                       |**De volgende variabelen gebruik je alleen bij het gebruik van de e-Suite. Je hebt dan dus bij REGISTERS__N__REGISTRY_VERSION 'OpenKlant1' ingevuld!**          | 
|REGISTERS__N__CONTACTMOMENTEN_BASE_URL   |URL van de Contactmomenten API van het gebruikte Contactmomentenregister. <details> <summary>Meer informatie </summary>Bijvoorbeeld: `https://contactmomentenregister.mijngemeente.nl` </details>        |
|REGISTERS__N__CONTACTMOMENTEN_API_CLIENT_ID  |ClientId voor de Contactmomenten API van het gebruikte Contactmomentenregister.                                                   |
|REGISTERS__N__CONTACTMOMENTEN_API_KEY    | Key voor de Contactmomenten API  <br /> **(min. 32 karakters)**                                                                  |
|REGISTERS__N__INTERNE_TAAK_BASE_URL      | URL van de Objecten API voor Interne Taken  <details> <summary>Meer informatie </summary> Bijvoorbeeld: `https://objectenregister.mijngemeente.nl` </details>            |
|REGISTERS__N__INTERNE_TAAK_CLIENT_ID      | Client ID voor de Interne Taken API <br/> **(Als deze variabele een waarde heeft, moet `REGISTERS__N__INTERNE_TAAK_TOKEN` leeg blijven)**  <details> <summary>Meer informatie </summary>In de meeste gevallen identificeert KISS zich bij een Objectenregistratie m.b.v. een `TOKEN`. In sommige gevallen is het nodig om de authenticatie in de Objecten API, voor Afdelingen, Groepen en Interne Taken, Medewerkers in te regelen m.b.v. een `client secret` en een `client id`. Dit is bv. het geval als je KISS gebruikt i.c.m. de e-Suite. Afhankelijk van de situatie moet je dus een Token inregelen, en in andere gevallen een id+secret. **NOOIT ALLEBEI!** let op: alle 3 de variabelen moeten wel aanwezig zijn, je kunt ze niet weglaten. </details>                        |
|REGISTERS__N__INTERNE_TAAK_CLIENT_SECRET  | Client Secret voor de Interne Taken API <br/> **(Als deze variabele een waarde heeft, moet `REGISTERS__N__INTERNE_TAAK_TOKEN` leeg blijven)** <details> <summary>Meer informatie </summary>In de meeste gevallen identificeert KISS zich bij een Objectenregistratie m.b.v. een `TOKEN`. In sommige gevallen is het nodig om de authenticatie in de Objecten API, voor Afdelingen, Groepen en Interne Taken, Medewerkers in te regelen m.b.v. een `client secret` en een `client id`. Dit is bv. het geval als je KISS gebruikt i.c.m. de e-Suite. Afhankelijk van de situatie moet je dus een Token inregelen, en in andere gevallen een id+secret. **NOOIT ALLEBEI!** Let op: alle 3 de variabelen moeten wel aanwezig zijn, je kunt ze niet weglaten. </details>                     |
|REGISTERS__N__INTERNE_TAAK_TOKEN  | Token voor de Objecten API voor Interne Taken <br/> **(Als deze variabele een waarde heeft, moet `REGISTERS__N__INTERNE_TAAK_CLIENT_SECRET` en `REGISTERS__N__INTERNE_TAAK_CLIENT_ID` leeg blijven)** <details> <summary>Meer informatie </summary>In de meeste gevallen identificeert KISS zich bij een Objectenregistratie m.b.v. een `TOKEN`. In sommige gevallen is het nodig om de authenticatie in de Objecten API, voor Afdelingen, Groepen en Interne Taken, Medewerkers in te regelen m.b.v. een `client secret` en een `client id`. Dit is bv. het geval als je KISS gebruikt i.c.m. de e-Suite. Afhankelijk van de situatie moet je dus een Token inregelen, en in andere gevallen een id+secret. **NOOIT ALLEBEI!** Let op: alle 3 de variabelen moeten wel aanwezig zijn, je kunt ze niet weglaten. </details>                     |
|REGISTERS__N__INTERNE_TAAK_OBJECT_TYPE_URL  | URL van het Objecttype Interne Taak         <details> <summary>Meer informatie </summary> Bijvoorbeeld `https://objecttypenregister.mijngemeente.nl/api/v2/objecttypes/f83fdc48-5ddb-4b1a-a347-e20092031399` </details> |
|REGISTERS__N__INTERNE_TAAK_TYPE_VERSION    |Versienummer van het Objecttype Interne Taak   <details> <summary>Meer informatie </summary> Bijvoorbeeld `2` <br /> KISS schrijft InterneTaken in het Objectenregister. Hierbij moet je altijd de versie van het objecttype meegeven. Omdat het per gemeente kan verschillen welke versie de meest recente is, moet je hier invullen welk versienummer KISS moet meegeven. </details>                                                          |
|REGISTERS__N__KLANTEN_BASE_URL            |URL van de Klanten API van het gebruikte Klantenregister <details> <summary>Meer informatie </summary>Bijvoorbeeld `https://klantenregister.mijngemeente.nl/klanten` </details>  |
|REGISTERS__N__KLANTEN_CLIENT_ID            |ClientId voor de Klanten API van het gebruikte Klantenregister.                                                                |
|REGISTERS__N__KLANTEN_CLIENT_SECRET      |Secret voor de Klanten API van het gebruikte Klantenregister. <br /> **(min. 32 karakters)**                                   |





### KISS-frontend, feature switches

| Variabele                               | Uitleg                                                                                                                           |
| ---------------------------------       | --------------------------------------------------------------------------------------------                                     |
| `USE_VACS` | Deze variabele bepaalt of het navigatie-item voor het beheren van VAC's aanwezig is in de beheernavigatie. <details><summary>Meer informatie</summary> Als deze variabele op `true` staat, is het Vacs-item zichtbaar en kunnen beheerders gebruikmaken van de functionaliteit. Als de variabele niet op true staat, of niet is ingesteld, zal het item niet aanwezig zijn in de beheernavigatie.</details> |
| `USE_MEDEWERKEREMAIL` | Deze variabele bepaalt of een contactverzoek voor een medewerker alléén op e-mailadres kan. <details><summary>Meer informatie</summary> Als deze variabele op `true` staat, zal in het contactverzoek-formulier, onder de geselecteerde afdeling of groep, een veld staan om het emailadres van een medewerker in te voeren. Direct een contactverzoek voor een medewerker maken kan in deze situatie niet. Het veld e-mailadres is niet verplicht. Als de variabele niet op `true` staat, geen waarde heeft of afwezig is, heb je in KISS wel de mogelijkheid om een Contactverzoek voor een medewerker te maken, en kun je in KISS de medewerker uit een lijst kiezen op naam. </details> |




### KISS-frontend, overige bronnen

| Variabele                               | Uitleg                                                                                                                           |
| ---------------------------------       | --------------------------------------------------------------------------------------------                                     |
| `HAAL_CENTRAAL_BASE_URL`                | URL van de Haal Centraal API  <details> <summary>Meer informatie </summary>Bijvoorbeeld: `https://proefomgeving.haalcentraal.nl/haalcentraal/api` </details> |
| `HAAL_CENTRAAL_API_KEY`                 | Key voor de Haal Centraal API                                                                                                    |
| `KVK_BASE_URL`                          | URL van de KvK-API <details> <summary>Meer informatie </summary>URL van de KvK-API om het Handelsregister te bevragen. Dit is het pad voorafgaand aan het versienummer, bijvoorbeeld `https://api.kvk.nl/test/api` </details>   |
| `KVK_API_KEY`                           | Key voor de KvK-API                                                                                                              |
| `ELASTIC_BASE_URL`                      | De URL voor Elasticsearch <details><summary>Meer informatie </summary>Bijvoorbeeld: `https://kiss-es-http:9200` </details> |
| `ELASTIC_USERNAME`                      | Username om in te loggen op Elasticsearch <details> <summary>Meer informatie </summary> Dit kan de default root user `elastic` zijn, maar ook de username van een gebruiker die je zelf hebt aangemaakt.  </details>  |
| `ELASTIC_PASSWORD`                      | Wachtwoord voor de bovenstaande user <details><summary>Meer informatie </summary> Als je gebruik maakt van [ECK](https://www.elastic.co/guide/en/cloud-on-k8s/2.8/k8s-overview.html), dan kun je het wachtwoord van de default user vinden, m.b.v. het commando `kubectl get secret kiss-es-elastic-user -o go-template='{{.data.elastic | base64decode}}'`</details>   |
| `ENTERPRISE_SEARCH_BASE_URL`            |  URL van de API waarop KISS de elastic instantie kan bevragen <details> <summary>Meer informatie </summary>Bijvoorbeeld `https://kiss-ent-http:3002` </details> |
| `ENTERPRISE_SEARCH_PUBLIC_API_KEY`      | Public API key voor Elastic  API                                                                                                 |
| `ENTERPRISE_SEARCH_PRIVATE_API_KEY`     | Private API key voor Elastic API <details> <summary>Meer informatie </summary> De API key die nodig is om de `engine`s bij te werken </details> |
| `ENTERPRISE_SEARCH_ENGINE`              | De naam van de `meta-engine` engine die KISS gebruikt. Dit moet zijn: `KISS-engine`  <details> <summary>Meer informatie </summary> De KISS-Elastic-Sync maakt deze engine aan, als deze nog niet bestaat.  </details>   |
| `AFDELINGEN_BASE_URL`                   | URL van de Objecten API voor afdelingen.  <details> <summary>Meer informatie </summary> Bijvoorbeeld: `https://objectenregister.mijngemeente.nl` </details>                     |
| `AFDELINGEN_OBJECT_TYPE_URL`            | URL van het Objecttype Afdeling   <details> <summary>Meer informatie </summary> Bijvoorbeeld: `https://objecttypenregister.mijngemeente.nl/api/v2/objecttypes/f83fdc48-5ddb-4b1a-a347-e20092031399` </details>      |
| `AFDELINGEN_TOKEN`                      | Token voor Objecten API voor afdelingen                                                                                           |
| `GROEPEN_BASE_URL`                      | URL van de Objecten API voor groepen.    <details> <summary>Meer informatie </summary> Bijvoorbeeld: `https://objectenregister.mijngemeente.nl` </details>                          |
| `GROEPEN_OBJECT_TYPE_URL`               | URL van het Objecttype Groep             <details> <summary>Meer informatie </summary> Bijvoorbeeld: `https://objecttypenregister.mijngemeente.nl/api/v2/objecttypes/f83fdc48-5ddb-4b1a-a347-e20092031399` </details>    |
| `GROEPEN_TOKEN`                         | Token van de Objecten API voor groepen                                                                                            |
| `VAC_OBJECTEN_BASE_URL`                 | URL van de Objecten API voor VAC's <details> <summary>Meer informatie</summary> Bijvoorbeeld: `https://objectenregister.mijngemeente.nl` </details>            |
| `VAC_OBJECT_TYPE_URL`                   | URL van het Objecttype VAC <details> <summary>Meer informatie</summary> Bijvoorbeeld `https://objecttypenregister.mijngemeente.nl/api/v2/objecttypes/f83fdc48-5ddb-4b1a-a347-e20092031399` </details> |
| `VAC_OBJECT_TYPE_VERSION`             | Versienummer van het Objecttype VAC <details> <summary>Meer informatie</summary> Bijvoorbeeld `2` <br /> KISS schrijft Vacs in het Objectenregister. Hierbij moet je altijd de versie van het objecttype meegeven. Omdat het per gemeente kan verschillen welke versie de meest recente is, moet je hier invullen welk versienummer KISS moet meegeven. </details>                                                          |
| `VAC_OBJECTEN_TOKEN`                    | Token voor de Objecten API voor VAC's <details> <summary>Meer informatie</summary> In het geval van Vacs identificeert KISS zich bij een Objectenregistratie m.b.v. een `TOKEN`. </details> |






### KISS-Elastic-Sync
<details> <summary>Meer informatie </summary>KISS-Elastic-Sync is het component dat zorgt dat de gekoppelde bronnen die via Elasticsearch ontsloten worden in KISS, naar de juiste Indexen worden gepushed, met de benodigde gegevens hieraan toegevoegd. Onderstaande environment variabelen gaan over de bronnen die gekoppeld zijn aan de KISS-Elastic-Sync. </details>


| Variabele                            | Uitleg                                                                                                    |
| -------------------------------------| --------------------------------------------------------------------------------------------------------  |
| `ENTERPRISE_SEARCH_BASE_URL`         | URL van de API voor de elastic instantie                                                                  |
| `ENTERPRISE_SEARCH_PRIVATE_API_KEY`  | Private API key voor Elastic                                                                              |
| `MEDEWERKER_OBJECTEN_BASE_URL`       | URL van de Objecten API voor medewerkers   <details> <summary>Meer informatie </summary> Bijvoorbeeld: `https://objectenregister.mijngemeente.nl` </details>                                                               |
| `MEDEWERKER_OBJECTEN_TOKEN`          | Token voor de Objecten API voor medewerkers <br/> **(Als deze variabele een waarde heeft, moeten MEDEWERKER_OBJECTEN_CLIENT_SECRET en MEDEWERKER_OBJECTEN_CLIENT_ID leeg blijven)** <details> <summary>Meer informatie </summary>In de meeste gevallen identificeert KISS zich bij een Objectenregistratie m.b.v. een `TOKEN`. In sommige gevallen is het nodig om de authenticatie in de Objecten API, voor Afdelingen, Groepen en Interne Taken, Medewerkers in te regelen m.b.v. een `client secret` en een `client id`. Dit is bv. het geval als je KISS gebruikt i.c.m. de e-Suite. Afhankelijk van de situatie moet je dus een Token inregelen, en in andere gevallen een id+secret. **NOOIT ALLEBEI!** Let op: alle 3 de variabelen moeten wel aanwezig zijn.</details> | 
| `MEDEWERKER_OBJECTEN_CLIENT_ID`      | Client ID voor de Objecten API voor medewerkers <br/> **(Als deze variabele een waarde heeft, moet MEDEWERKER_OBJECTEN_TOKEN leeg blijven)** <details> <summary>Meer informatie </summary>In de meeste gevallen identificeert KISS zich bij een Objectenregistratie m.b.v. een `TOKEN`. In sommige gevallen is het nodig om de authenticatie in de Objecten API, voor Afdelingen, Groepen en Interne Taken, Medewerkers in te regelen m.b.v. een `client secret` en een `client id`. Dit is bv. het geval als je KISS gebruikt i.c.m. de e-Suite. Afhankelijk van de situatie moet je dus een Token inregelen, en in andere gevallen een id+secret. **NOOIT ALLEBEI!** Let op: alle 3 de variabelen moeten wel aanwezig zijn.</details>               |
| `MEDEWERKER_OBJECTEN_CLIENT_SECRET`  | Client Secret voor de Objecten API voor medewerkers <br/> **(Als deze een waarde heeft, deze variabele MEDEWERKER_OBJECTEN_TOKEN leeg blijven)** <details> <summary>Meer informatie </summary>In de meeste gevallen identificeert KISS zich bij een Objectenregistratie m.b.v. een `TOKEN`. In sommige gevallen is het nodig om de authenticatie in de Objecten API, voor Afdelingen, Groepen en Interne Taken, Medewerkers in te regelen m.b.v. een `client secret` en een `client id`. Dit is bv. het geval als je KISS gebruikt i.c.m. de e-Suite. Afhankelijk van de situatie moet je dus een Token inregelen, en in andere gevallen een id+secret. **NOOIT ALLEBEI!** Let op: alle 3 de variabelen moeten wel aanwezig zijn.</details>           |
| `MEDEWERKER_OBJECT_TYPE_URL`         | URL van het Objecttype Medewerker  <details> <summary>Meer informatie </summary> Bijvoorbeeld `https://objecttypenregister.mijngemeente.nl/api/v2/objecttypes/f83fdc48-5ddb-4b1a-a347-e20092031399` </details>  |
| `VAC_OBJECTEN_BASE_URL`              | URL van de Objecten API voor VAC's  <details> <summary>Meer informatie </summary> Bijvoorbeeld: `https://objectenregister.mijngemeente.nl` </details>                                                                     |
| `VAC_OBJECT_TYPE_URL`                | URL van het  Objecttype VAC   <details> <summary>Meer informatie </summary> Bijvoorbeeld `https://objecttypenregister.mijngemeente.nl/api/v2/objecttypes/f83fdc48-5ddb-4b1a-a347-e20092031399` </details>                                                                 |
| `VAC_OBJECTEN_TOKEN`                    | Token voor de Objecten API voor VAC's <details> <summary>Meer informatie</summary> In het geval van Vacs identificeert KISS zich bij een Objectenregistratie m.b.v. een `TOKEN`. </details> |
| `SDG_BASE_URL`                       | URL van de API voor Kennisartikelen  <details> <summary>Meer informatie </summary> Bijvoorbeeld: `https://objectenregister.mijngemeente.nl` </details>  |
| `SDG_OBJECTEN_TOKEN`                 | Key voor de API voor Kennisartikelen                                                                      |
| `SDG_OBJECT_TYPE_URL`                | URL van het Objecttype Kennisartikel <details> <summary>Meer informatie </summary> Bijvoorbeeld `https://objecttypenregister.mijngemeente.nl/api/v2/objecttypes/f83fdc48-5ddb-4b1a-a347-e20092031399` </details>      |

