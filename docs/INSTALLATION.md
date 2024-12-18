# Klantinteractie Servicesysteem (KISS) Installatie Handleiding

## Inhoudsopgave

- [Klantinteractie Servicesysteem (KISS) Installatie Handleiding](#klantinteractie-servicesysteem-kiss-installatie-handleiding)
  - [Inhoudsopgave](#inhoudsopgave)
  - [Inleiding](#inleiding)
  - [Voorbereidingen](#voorbereidingen)
    - [Domein](#domein)
    - [Tools](#tools)
    - [Haven](#haven)
    - [Authenticatie](#authenticatie)
  - [Configuratie: Environment Variabelen](#configuratie-environment-variabelen)
    - [Authenticatie](#authenticatie-1)
    - [Database](#database)
    - [Organisatie RSIN](#organisatie-rsin)
    - [Feedback op Kennisartikelen](#feedback-op-kennisartikelen)
    - [Gekoppelde Bronnen](#gekoppelde-bronnen)
      - [KISS-frontend](#kiss-frontend)
      - [KISS-Elastic-Sync](#kiss-elastic-sync)
  - [Installatie](#installatie)
    - [Placeholders](#placeholders)
    - [Uitvoeren](#uitvoeren)
      - [KISS-Elastic-Sync](#kiss-elastic-sync-1)
      - [KISS-Elastic-Sync-Cronjobs](#cronjobs)

---

## Inleiding

KISS draait in een Kubernetes cluster. Deze handleiding is gebaseerd op Azure Kubernetes, maar ondersteunt ook andere haven-compliant providers. De handleiding is bedoeld voor Kubernetes beheerders om KISS handmatig op een nieuw cluster te installeren.

## Voorbereidingen

### Domein

Bij gebruik van Helm-Charts: zorg voor een domeinnaam met wild-card certificaat. Gebruik `.crt` en `.key` bestanden zoals hieronder:

> `-----BEGIN CERTIFICATE-----`<br/>
> inhoud public certificate<br/>
> `-----END CERTIFICATE-----`<br/>
> <br/>
> `-----BEGIN CERTIFICATE-----`<br/>
> inhoud intermediate certificaten mits aanwezig<br/>
> `-----END CERTIFICATE-----`<br/>
> <br/>
> `-----BEGIN CERTIFICATE-----`<br/>
> inhoud certificate authority certificate<br/>
> `-----END CERTIFICATE-----`

Het private certificate dient los als .key bestand opgeslagen te worden.

### Tools

Installeer de volgende tools:

- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm](https://helm.sh/docs/intro/install/)
- [Haven](https://haven.commonground.nl/techniek/compliancy-checker)
- [Powershell](https://learn.microsoft.com/en-us/powershell/)

### Haven

KISS kan op een haven-compliant cluster geïnstallleerd worden. Referentie-implementaties van haven-compliant clusters zijn te vinden op de [Haven](https://haven.commonground.nl/techniek/aan-de-slag) site.

Bij het volgen van de [Azure](https://haven.commonground.nl/techniek/aan-de-slag/azure) referentie moet men rekening houden met de volgende extra zaken:

- Minimaal 3 nodes
- High availability aanzetten
- Local logins met RBAC gebruiken, GEEN Azure Active Directory!


### Authenticatie

De authenticatie van gebruikers binnen KISS gebeurt m.b.v. een OIDC koppeling met bijvoorbeeld Azure Active Directory.

## Configuratie: Environment Variabelen

Hieronder staan de benodigde environment variabelen per onderdeel van KISS.

### Authenticatie

| Variabele                                | Uitleg                                                    |
| ---------------------------------------- | --------------------------------------------------------- |
| `OIDC_AUTHORITY`                          | URL van de OpenID Connect Identity Provider                 |
| `OIDC_CLIENT_ID`                           | Voor toegang tot de OpenID Connect Identity Provider      |
| `OIDC_CLIENT_SECRET`                       | Secret voor de OpenID Connect Identity Provider           |
| `OIDC_MEDEWERKER_IDENTIFICATIE_CLAIM`    | Identificatie van de medewerker in registers <br/> (default waarde is `email`) <details> <summary>Meer informatie </summary> Bij het wegschrijven van gegevens naar bv. Open Klant of Open Zaak is een `medewerkerIdentificatie.identificatie` verplicht. Verschillende gemeenten gebruiken hier verschillende waardes voor. Bij een koppeling met bv. de e-Suite is het van belang dat hier de e-Suite gebruikersnaam in staat van de ingelogde KCM. </details>|
| `OIDC_MEDEWERKER_IDENTIFICATIE_TRUNCATE` | Optioneel afkappen van de claim <br/> (bijv. `24`) <details> <summary>Meer informatie </summary> Binnen ZGW mag een `medewerkerIdentificatie.identificatie` niet langer zijn dan 24 karakters. Met deze variabele kun je ervoor zorgen dat de uiteindelijk waarde wordt afgekapt na 24 tekens. </details>       |
| `MANAGEMENTINFORMATIE_API_KEY` | Secret dat KISS gebruikt om het JWT Token <br/>te valideren bij het opvragen van <br/>contactmomentdetails <details> <summary>Meer informatie </summary>Zie de [Handleiding beheer KISS, hoofdstuk <br/> managementinformatie](https://github.com/Klantinteractie-Servicesysteem/.github/blob/main/docs/MANUAL.md#management-informatie) voor informatie over <br/>het gebruik van deze API.</details> |
|  |  |

### Database

| Variabele          | Uitleg                                |
| ------------------ | ------------------------------------- |
| `POSTGRES_DB`       | Naam van de database bij KISS         |
| `POSTGRES_USER`     | Gebruikersnaam voor toegang van KISS tot de DB |
| `POSTGRES_PASSWORD` | Wachtwoord van de postgresUser        |
|  |  |

### Organisatie RSIN

| Variabele         | Uitleg                                                           |
| ----------------- | ---------------------------------------------------------------- |
| `ORGANISATIE_IDS` | RSIN van de organisatie die de <br/> Contactmomenten registreert <details> <summary>Meer informatie </summary>Verschillende ZGW APIs, waaronder de Klant en Contactmoment APIs, vragen om een identificatienummer, RSIN, van de eigen organisatie. Dit RSIN moet worden meegegeven bij registratie van specifieke objecten. </details>|
|  |  |

### Feedback op Kennisartikelen
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

### Gekoppelde Bronnen

Er zijn diverse API's die vanuit KISS bevraagd worden. Hieronder staan de environment variabelen per gekoppelde bron. 
**Let op**: 
1. Sommige API-keys en Secrets die KISS nodig heeft om externe registers te bevragen moeten **minimaal 32 karakters** lang zijn. 
2. Voor variabelen met `__0__` als tussenvoegsel geldt dat er een lijst opgebouwd kan worden. Het eerste item van de lijst heeft `__0__` als tussenvoegsel, het tweede item `__1__`, en zo verder.

<details> <summary>Meer informatie </summary>Er zijn diverse bronnen die vanuit KISS via API's bevraagd worden. Sommige worden alleen geraadpleegd, zoals de KvK-API en de API voor Haal Centraal BRP Personen bevragen, en de Objecten API voor het ophalen van Afdelingen, Groepen en Medewerkers. Andere registraties worden niet alleen geraadpleegd, maar er worden ook gegevens in weggeschreven. Dit zijn in ieder geval een Klanten- en Contactmomentenregister, zoals Open Klant, het Objecten Register zoals Open Objecten, en een Zaaksysteem (m.b.v. ZGW API's) zoals Open Zaak.

Daarnaast zijn er bronnen die binnen KISS doorzocht moeten worden.

- KISS gebruikt de Objecten API om Kennisartikelen (PDC-producten) mee op te halen, en naar Elastic te pushen.
- KISS gebruikt op dit moment de Objecten API om de Medewerkers in het Smoelenboek op te halen en naar Elastic te pushen.
- KISS gebruikt op dit moment de Objecten API om de Vraag Antwoord Combinaties (VAC) op te halen en naar Elastic te pushen.</details>


#### KISS-frontend

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
| `USE_KLANTINTERACTIES` | Deze variabele bepaalt of er gebruik wordt gemaakt van OpenKlant 2.0 (klantinteractieregister).<details> <summary>Meer informatie </summary>Als deze variabele op `true` staat, wordt OpenKlant 2.0 gebruikt. Hiervoor zijn de variabelen `KLANTINTERACTIES_BASE_URL` en `KLANTINTERACTIES_TOKEN` nodig. Standaard is deze waarde `false`, in dat geval worden de oude Contactmomenten API en Klanten API gebruikt, voor communicatie met de e-Suite. In dat geval zijn de variabelen `KLANTEN_BASE_URL`,  `KLANTEN_CLIENT_ID` en `KLANTEN_CLIENT_SECRET` nodig.  </details>|
| `KLANTINTERACTIES_BASE_URL`                      | URL van de Klantinteractie API van het gebruikte klantinteractieregister (bijvoorbeeld Open Klant 2) <details> <summary>Meer informatie </summary>Bijvoorbeeld `https://klantinteractieregister.mijngemeente.nl/klantinteracties` </details>  |
| `KLANTINTERACTIES_TOKEN`                     | Token voor de Klantinteractie API van het gebruikte klantinteractieregister                                                                   |
| `KLANTEN_BASE_URL`                      | URL van de Klanten API van het gebruikte klantenregister, noodzakelijk als `USE_KLANTINTERACTIES` op false staat of niet gedefinieerd is. <details> <summary>Meer informatie </summary>Bijvoorbeeld `https://klantenregister.mijngemeente.nl/klanten` </details>  |
| `KLANTEN_CLIENT_ID`                     | ClientId voor de Klanten API van het gebruikte klantenregister, , noodzakelijk als `USE_KLANTINTERACTIES` op false staat of niet gedefinieerd is.                                                                |
| `KLANTEN_CLIENT_SECRET`                 | Secret voor de Klanten API <br /> **(min. 32 karakters)**                                                                        |
| `CONTACTMOMENTEN_BASE_URL`              | URL van de Contactmomenten API  <details> <summary>Meer informatie </summary>Bijvoorbeeld: `https://contactmomentenregister.mijngemeente.nl` </details>                  |
| `CONTACTMOMENTEN_API_CLIENT_ID`         | ClientId voor de Contactmomenten API van het gebruikte Contactmomentenregister                                                   |
| `CONTACTMOMENTEN_API_KEY`               | Key voor de Contactmomenten API  <br /> **(min. 32 karakters)**                                                                  |
| `ZAAKSYSTEEM__0__BASE_URL`              | URL van de ZGW API's      <details> <summary>Meer informatie </summary> Bijvoorbeeld: `https://zaaksysteem.mijngemeente.nl`  </details>                                  |
| `ZAAKSYSTEEM__0__API_KEY`               | API Key voor de ZGW API's <br /> **(min. 32 karakters)**                                                                         |
| `ZAAKSYSTEEM__0__API_CLIENT_ID`         | ClientId voor de ZGW API's                                                                                                       |
| `ZAAKSYSTEEM__0__DEEPLINK_URL`              | Basisurl om te deeplinken naar een Zaak in het zaaksysteem (optioneel) <details> <summary>Meer informatie </summary> Bijvoorbeeld: `https://zaaksysteem.mijngemeente.nl/mp/zaak/` <br /> Deze variabele **moet** altijd gebruikt worden **in combinatie met** `ZAAKSYSTEEM__0__DEEPLINK_PROPERTY`. Als deze variabelen beiden worden ingevuld, zal er in KISS een link in het zaakdetailscherm staan, waarmee de KCM de betreffende zaak direct in het zaaksysteem opent.  LET OP: dit kan alleen bij zaaksystemen die een vaste url hebben voor zaakdetails, waarbij alleen één property van de zaak, bijv. het zaaknummer, áchter die URL geplaatst hoeft te worden.  </details>                                                                             |
| `ZAAKSYSTEEM__0__DEEPLINK_PROPERTY`         | Property om naar een zaak te kunnen deeplinken (optioneel) <details> <summary>Meer informatie </summary> Deze variabele **moet** altijd gebruikt worden **in combinatie met** `ZAAKSYSTEEM__0__DEEPLINK_URL`. De waarde uit dit property van een specifieke zaak wordt achter `ZAAKSYSTEEM_DEEPLINK_URL` geplaatst om de link te laten werken. Bijvoorbeeld: `identificatie` </details>  |
| `ZAAKSYSTEEM__0__NIETNATUURLIJKPERSOONIDENTIFIER`       | Identifier voor 'niet natuurlijke personen' <br/> (`rsin` of `kvkNummer`) voor dit zaaksysteem<details> <summary>Meer informatie </summary> Afhankelijk van de gebruikte bron (bijvoorbeeld Open Zaak of de e-Suite) kan je hiermee aangeven welk gegeven gebruikt wordt om zaken van een `niet natuurlijke persoon` op te zoeken in een zaaksysteem. Op dit moment kan je hiervoor het RSIN (`rsin`) of het KvK-nummer (`kvkNummer`) gebruiken. RSIN is de default: als deze variable leeg gelaten wordt of ontbreekt bij de installatie, zal `rsin` gebruikt worden. Als je de e-Suite als register gebruikt, moet je hier `kvkNummer` invullen. Let op, de spelling moet exact overeen komen.</details>                     |
| `AFDELINGEN_BASE_URL`                   | URL van de Objecten API voor afdelingen.  <details> <summary>Meer informatie </summary> Bijvoorbeeld: `https://objectenregister.mijngemeente.nl` </details>                     |
| `AFDELINGEN_OBJECT_TYPE_URL`            | URL van het Objecttype Afdeling   <details> <summary>Meer informatie </summary> Bijvoorbeeld: `https://objecttypenregister.mijngemeente.nl/api/v2/objecttypes/f83fdc48-5ddb-4b1a-a347-e20092031399` </details>      |
| `AFDELINGEN_TOKEN`                      | Token voor Objecten API voor afdelingen                                                                                           |
| `GROEPEN_BASE_URL`                      | URL van de Objecten API voor groepen.    <details> <summary>Meer informatie </summary> Bijvoorbeeld: `https://objectenregister.mijngemeente.nl` </details>                          |
| `GROEPEN_OBJECT_TYPE_URL`               | URL van het Objecttype Groep             <details> <summary>Meer informatie </summary> Bijvoorbeeld: `https://objecttypenregister.mijngemeente.nl/api/v2/objecttypes/f83fdc48-5ddb-4b1a-a347-e20092031399` </details>    |
| `GROEPEN_TOKEN`                         | Token van de Objecten API voor groepen                                                                                            |
| `INTERNE_TAAK_BASE_URL`                 | URL van de Objecten API voor Interne Taken  <details> <summary>Meer informatie </summary> Bijvoorbeeld: `https://objectenregister.mijngemeente.nl` </details>            |
| `INTERNE_TAAK_OBJECT_TYPE_URL`          | URL van het Objecttype Interne Taak         <details> <summary>Meer informatie </summary> Bijvoorbeeld `https://objecttypenregister.mijngemeente.nl/api/v2/objecttypes/f83fdc48-5ddb-4b1a-a347-e20092031399` </details> |
| `INTERNE_TAAK_TYPE_VERSION`             | Versienummer van het Objecttype Interne Taak   <details> <summary>Meer informatie </summary> Bijvoorbeeld `2` <br /> KISS schrijft InterneTaken in het Objectenregister. Hierbij moet je altijd de versie van het objecttype meegeven. Omdat het per gemeente kan verschillen welke versie de meest recente is, moet je hier invullen welk versienummer KISS moet meegeven. </details>                                                          |
| `INTERNE_TAAK_TOKEN`                    | Token voor de Objecten API voor Interne Taken  <br/> **(niet te gebruiken met `INTERNE_TAAK_CLIENT_SECRET` en `INTERNE_TAAK_CLIENT_ID`)** <details> <summary>Meer informatie </summary>In de meeste gevallen identificeert KISS zich bij een Objectenregistratie m.b.v. een `TOKEN`. In sommige gevallen is het nodig om de authenticatie in de Objecten API, voor Afdelingen, Groepen en Interne Taken, Medewerkers in te regelen m.b.v. een `client secret` en een `client id`. Dit is bv. het geval als je KISS gebruikt i.c.m. de e-Suite. Afhankelijk van de situatie moet je dus een Token inregelen, en in andere gevallen een id+secret. **NOOIT ALLEBEI!** </details> |
| `INTERNE_TAAK_CLIENT_SECRET`            | Client Secret voor de Interne Taken API <br/> **(niet te gebruiken in combinatie met `INTERNE_TAAK_TOKEN`, dan deze leeg laten)**                      |
| `INTERNE_TAAK_CLIENT_ID`                | Client ID voor de Interne Taken API <br/> **(niet te gebruiken in combinatie met `INTERNE_TAAK_TOKEN`, dan deze leeg laten)**                          |

#### KISS-Elastic-Sync
<details> <summary>Meer informatie </summary>KISS-Elastic-Sync is het component dat zorgt dat de gekoppelde bronnen die via Elasticsearch ontsloten worden in KISS, naar de juiste Indexen worden gepushed, met de benodigde gegevens hieraan toegevoegd. Onderstaande environment variabelen gaan over de bronnen die gekoppeld zijn aan de KISS-Elastic-Sync. </details>


| Variabele                            | Uitleg                                                                                                    |
| -------------------------------------| --------------------------------------------------------------------------------------------------------  |
| `ENTERPRISE_SEARCH_BASE_URL`         | URL van de API voor de elastic instantie                                                                  |
| `ENTERPRISE_SEARCH_PRIVATE_API_KEY`  | Private API key voor Elastic                                                                              |
| `MEDEWERKER_OBJECTEN_BASE_URL`       | URL van de Objecten API voor medewerkers   <details> <summary>Meer informatie </summary> Bijvoorbeeld: `https://objectenregister.mijngemeente.nl` </details>                                                               |
| `MEDEWERKER_OBJECTEN_TOKEN`          | Token voor de Objecten API voor medewerkers <br/> **(niet te gebruiken i.c.m. MEDEWERKER_OBJECTEN_CLIENT_SECRET en MEDEWERKER_OBJECTEN_CLIENT_ID)** <details> <summary>Meer informatie </summary>In de meeste gevallen identificeert KISS zich bij een Objectenregistratie m.b.v. een `TOKEN`. In sommige gevallen is het nodig om de authenticatie in de Objecten API, voor Afdelingen, Groepen en Interne Taken, Medewerkers in te regelen m.b.v. een `client secret` en een `client id`. Dit is bv. het geval als je KISS gebruikt i.c.m. de e-Suite. Afhankelijk van de situatie moet je dus een Token inregelen, en in andere gevallen een id+secret. **NOOIT ALLEBEI!** </details> | 
| `MEDEWERKER_OBJECTEN_CLIENT_ID`      | Client ID voor de Objecten API voor medewerkers <br/> **(niet te gebruiken i.c.m. MEDEWERKER_OBJECTEN_TOKEN, dan deze leeg laten)**                |
| `MEDEWERKER_OBJECTEN_CLIENT_SECRET`  | Client Secret voor de Objecten API voor medewerkers <br/> **(niet te gebruiken i.c.m. MEDEWERKER_OBJECTEN_TOKEN, dan deze leeg laten)**            |
| `MEDEWERKER_OBJECT_TYPE_URL`         | URL van het Objecttype Medewerker  <details> <summary>Meer informatie </summary> Bijvoorbeeld `https://objecttypenregister.mijngemeente.nl/api/v2/objecttypes/f83fdc48-5ddb-4b1a-a347-e20092031399` </details>  |
| `VAC_OBJECTEN_BASE_URL`              | URL van de Objecten API voor VAC's  <details> <summary>Meer informatie </summary> Bijvoorbeeld: `https://objectenregister.mijngemeente.nl` </details>                                                                     |
| `VAC_OBJECTEN_TOKEN`                 | Token voor de Objecten API voor VAC's                                                                     |
| `VAC_OBJECT_TYPE_URL`                | URL van het  Objecttype VAC    <details> <summary>Meer informatie </summary> Bijvoorbeeld `https://objecttypenregister.mijngemeente.nl/api/v2/objecttypes/f83fdc48-5ddb-4b1a-a347-e20092031399` </details>                                                                 |
| `SDG_BASE_URL`                       | URL van de API voor Kennisartikelen  <details> <summary>Meer informatie </summary> Bijvoorbeeld: `https://objectenregister.mijngemeente.nl` </details>  |
| `SDG_OBJECTEN_TOKEN`                 | Key voor de API voor Kennisartikelen                                                                      |
| `SDG_OBJECT_TYPE_URL`                | URL van het Objecttype Kennisartikel <details> <summary>Meer informatie </summary> Bijvoorbeeld `https://objecttypenregister.mijngemeente.nl/api/v2/objecttypes/f83fdc48-5ddb-4b1a-a347-e20092031399` </details>      |

## Installatie

### Placeholders

De yaml-voorbeeldbestanden staan [hier](https://github.com/Klantinteractie-Servicesysteem/KISS-frontend/blob/main/helm/kiss-frontend/kiss.template.yaml).

### Uitvoeren

De installatie kan uitgevoerd worden middels het PowerShell script. Handmatig uitvoeren kan ook.

[install_kiss.ps1](https://github.com/Klantinteractie-Servicesysteem/.github/blob/main/docs/scripts/install_kiss.ps1)

**LET OP** 
- Voordat een ingelogde gebruiker kan werken met KISS, moet deze gebruiker de juiste rol hebben in de gekoppelde Identity provider. Zie voor meer informatie het onderdeel [Configuratie van uw Identity Provider in de configuratie-handleiding](CONFIGURATIE.md#configuratie-van-uw-identity-provider).
- Om een betere indruk te krijgen van hoe KISS werkt, is het mogelijk om **voorbeeldata (demodata)** te laden. Zie hiervoor [de uitleg bij de Beheerhandleiding](MANUAL.md#kiss-beheer-vullen-met-voorbeelddata).

#### KISS-Elastic-Sync
KISS-Elastic-Sync is het component dat zorgt voor het creëren van de benodigde engines in een Elasticsearch-installatie, zodat gekoppelde bronnen eenvoudig door KISS doorzoekbaar zijn. Het ondersteunt zowel websites als gestructureerde bronnen door respectievelijk een crawler en een index te gebruiken.

Meer informatie over de KISS-Elastic-Sync tool en hoe deze te installeren, is te vinden op de volgende URL:
[KISS-Elastic-Sync](https://github.com/Klantinteractie-Servicesysteem/KISS-Elastic-Sync/blob/main/README.md)

##### Cronjobs
Naast de sync tool zijn er ook cronjobs die ingesteld moeten worden voor het regelmatig synchroniseren van data.

Meer informatie over de benodigde cronjobs en hoe deze in te stellen, is te vinden op de volgende URL:
[KISS-Elastic-Sync Cronjobs](https://github.com/Klantinteractie-Servicesysteem/KISS-Elastic-Sync/blob/main/deploy/README.md)
