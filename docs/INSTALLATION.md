# Klantinteractie Servicesysteem (KISS) Installatie Handleiding

## Inhoudsopgave

1. [Inleiding](#inleiding)
2. [Voorbereidingen](#voorbereidingen)
   - [Domein](#domein)
   - [Tools](#tools)
   - [Haven](#haven)
   - [Azure](#azure)
   - [Authenticatie](#authenticatie)
3. [Configuratie: Environment Variabelen](#configuratie-environment-variabelen)
   - [Authenticatie](#authenticatie)
   - [Database](#database)
   - [Organisatie RSIN](#organisatie-rsin)
   - [Feedback op Kennisartikelen](#feedback-op-kennisartikelen)
   - [Gekoppelde Bronnen](#gekoppelde-bronnen)
4. [Installatie](#installatie)
   - [Placeholders](#placeholders)
   - [Uitvoeren](#uitvoeren)
   - [Aanpassingen](#aanpassingen)

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

Zorg voor een haven-compliant cluster. Referentie-implementaties zijn te vinden op de [Haven](https://haven.commonground.nl/techniek/aan-de-slag) site.

### Azure

Bij het volgen van de [Azure](https://haven.commonground.nl/techniek/aan-de-slag/azure) referentie:

- Minimaal 3 nodes
- High availability aanzetten
- Local logins met RBAC gebruiken, GEEN Azure Active Directory!

Meer informatie over quota aanpassingen: [Azure Quota](https://portal.azure.com/#view/Microsoft_Azure_Capacity/QuotaMenuBlade/~/myQuotas).

### Authenticatie

De authenticatie van gebruikers binnen KISS gebeurt m.b.v. een OIDC koppeling met bijvoorbeeld Azure Active Directory.

## Configuratie: Environment Variabelen

Hieronder staan de benodigde environment variabelen per onderdeel van KISS.

### Authenticatie

| Variabele                                | Uitleg                                                    |
| ---------------------------------------- | --------------------------------------------------------- |
| `oidcAuthority`                          | URL van de OpenID Connect Identity Provider               |
| `oidcClientId`                           | Voor toegang tot de OpenID Connect Identity Provider      |
| `oidcClientSecret`                       | Secret voor de OpenID Connect Identity Provider           |
| `OIDC_MEDEWERKER_IDENTIFICATIE_CLAIM`    | Identificatie van de medewerker <br/> (`email` standaard) |
| `OIDC_MEDEWERKER_IDENTIFICATIE_TRUNCATE` | Optioneel afkappen van de claim <br/> (bijv. `24`)        |

### Database

| Variabele          | Uitleg                                |
| ------------------ | ------------------------------------- |
| `postgresDb`       | Naam van de database bij KISS         |
| `postgresUser`     | Gebruikersnaam voor toegang tot de DB |
| `postgresPassword` | Wachtwoord van de postgresUser        |

### Organisatie RSIN

| Variabele         | Uitleg                                                           |
| ----------------- | ---------------------------------------------------------------- |
| `ORGANISATIE_IDS` | RSIN van de organisatie die de <br/> Contactmomenten registreert |

### Feedback op Kennisartikelen

| Variabele             | Uitleg                                  |
| --------------------- | --------------------------------------- |
| `FEEDBACK_EMAIL_FROM` | Afzenderadres van de feedbackmail       |
| `FEEDBACK_EMAIL_TO`   | Adres waar de feedbackmail naartoe moet |
| `EMAIL_ENABLE_SSL`    | Gebruik van SSL (true/false)            |
| `EMAIL_HOST`          | Adres van de mailserver                 |
| `EMAIL_PORT`          | Poortnummer van de mailverbinding       |
| `EMAIL_USERNAME`      | Gebruikersnaam voor de mailserver       |
| `EMAIL_PASSWORD`      | Wachtwoord voor de mailserver           |

### Gekoppelde Bronnen

Er zijn diverse API's die vanuit KISS bevraagd worden. Hieronder staan de environment variabelen per gekoppelde bron.

#### KISS-frontend

| Variabele                         | Uitleg                                                                                       |
| --------------------------------- | -------------------------------------------------------------------------------------------- |
| `imageTag`                        | Verwijzing naar de Build-versie van de <br/> KISS-frontend                                   |
| `haalCentraalBaseUrl`             | URL van de Haal Centraal API                                                                 |
| `haalCentraalApiKey`              | Key voor de Haal Centraal API                                                                |
| `kvkBaseUrl`                      | URL van de KvK-API                                                                           |
| `kvkApiKey`                       | Key voor de KvK-API                                                                          |
| `enterprise_search_url`           | URL van de API voor de elastic instantie                                                     |
| `elasticPassword`                 | Wachtwoord voor de Elastic API                                                               |
| `enterprise_search_private_api`   | Private API key voor Elastic                                                                 |
| `enterprise_search_public_api`    | Public API key voor Elastic                                                                  |
| `klanten_base_url`                | URL van de Klanten API                                                                       |
| `klanten_client_id`               | ClientId voor de Klanten API                                                                 |
| `klanten_client_secret`           | Secret voor de Klanten API <br/> (min. 16 karakters)                                         |
| `NIETNATUURLIJKPERSOONIDENTIFIER` | Identifier voor 'niet natuurlijke personen' <br/> (`rsin` of `kvkNummer`)                    |
| `CONTACTMOMENTEN_BASE_URL`        | URL van de Contactmomenten API                                                               |
| `CONTACTMOMENTEN_API_CLIENT_ID`   | ClientId voor de Contactmomenten API                                                         |
| `CONTACTMOMENTEN_API_KEY`         | Key voor de Contactmomenten API <br/> (min. 16 karakters)                                    |
| `ZAKEN_BASE_URL`                  | URL van de ZGW API's                                                                         |
| `ZAKEN_API_CLIENT_ID`             | ClientId voor de ZGW API's                                                                   |
| `ZAKEN_API_KEY`                   | API Key voor de ZGW API's <br/> (min. 16 karakters)                                          |
| `AFDELINGEN_BASE_URL`             | URL van de Afdelingen API                                                                    |
| `AFDELINGEN_OBJECT_TYPE_URL`      | URL van het Objecttype Afdeling                                                              |
| `AFDELINGEN_TOKEN`                | Token voor de Afdelingen API                                                                 |
| `GROEPEN_BASE_URL`                | URL van de Groepen API                                                                       |
| `GROEPEN_OBJECT_TYPE_URL`         | URL van het Objecttype Groep                                                                 |
| `GROEPEN_TOKEN`                   | Token voor de Groepen API                                                                    |
| `INTERNE_TAAK_BASE_URL`           | URL van de Interne Taken API                                                                 |
| `INTERNE_TAAK_OBJECT_TYPE_URL`    | URL van het Objecttype Interne Taak                                                          |
| `INTERNE_TAAK_TYPE_VERSION`       | Versienummer van het Objecttype Interne Taak                                                 |
| `INTERNE_TAAK_TOKEN`              | Token voor de Interne Taken API <br/> **(niet te gebruiken met CLIENT_SECRET en CLIENT_ID)** |
| `INTERNE_TAAK_CLIENT_SECRET`      | Client Secret voor de Interne Taken API <br/> **(niet te gebruiken met TOKEN)**              |
| `INTERNE_TAAK_CLIENT_ID`          | Client ID voor de Interne Taken API <br/> **(niet te gebruiken met TOKEN)**                  |

#### KISS-Elastic-Sync

| Variabele                           | Uitleg                                                                                                   |
| ----------------------------------- | -------------------------------------------------------------------------------------------------------- |
| `enterprise_search_url`             | URL van de API voor de elastic instantie                                                                 |
| `enterprise_search_private_api`     | Private API key voor Elastic                                                                             |
| `MEDEWERKER_OBJECTEN_BASE_URL`      | URL van de Objecten API voor medewerkers                                                                 |
| `MEDEWERKER_OBJECTEN_TOKEN`         | Token voor de Objecten API voor medewerkers <br/> **(niet te gebruiken met CLIENT_SECRET en CLIENT_ID)** |
| `MEDEWERKER_OBJECTEN_CLIENT_ID`     | Client ID voor de Objecten API voor medewerkers <br/> **(niet te gebruiken met TOKEN)**                  |
| `MEDEWERKER_OBJECTEN_CLIENT_SECRET` | Client Secret voor de Objecten API voor medewerkers <br/> **(niet te gebruiken met TOKEN)**              |
| `MEDEWERKER_OBJECTTYPES_BASE_URL`   | URL van de Objecttype API voor 'Medewerker'                                                              |
| `MEDEWERKER_OBJECTTYPES_TOKEN`      | Token voor de Objecttype API voor 'Medewerker'                                                           |
| `VAC_OBJECTEN_BASE_URL`             | URL van de Objecten API voor VAC's                                                                       |
| `VAC_OBJECTEN_TOKEN`                | Token voor de Objecten API voor VAC's                                                                    |
| `VAC_OBJECTTYPES_BASE_URL`          | URL van de Objecttype API voor 'VAC'                                                                     |
| `VAC_OBJECTTYPES_TOKEN`             | Token voor de Objecttype API voor 'VAC'                                                                  |
| `SDG_BASE_URL`                      | URL van de API voor Kennisartikelen                                                                      |
| `SDG_API_KEY`                       | Key voor de API voor Kennisartikelen                                                                     |

## Installatie

### Placeholders

De yaml-voorbeeldbestanden staan [hier](https://github.com/Klantinteractie-Servicesysteem/KISS-frontend/blob/main/helm/kiss-frontend/kiss.template.yaml).

### Uitvoeren

De installatie kan uitgevoerd worden middels het PowerShell script. Handmatig uitvoeren kan ook.

[install_kiss.ps1](https://github.com/Klantinteractie-Servicesysteem/.github/blob/main/docs/scripts/install_kiss.ps1)

#### Aanpassingen
Hoe een config en/of secrets moeten worden aangepast staat beschreven in MAINTENANCE.md

#### KISS-Elastic-Sync
KISS-Elastic-Sync is het component dat zorgt voor het creëren van de benodigde engines in een Elasticsearch-installatie, zodat gekoppelde bronnen eenvoudig door KISS doorzoekbaar zijn. Het ondersteunt zowel websites als gestructureerde bronnen door respectievelijk een crawler en een index te gebruiken.

Meer informatie over de KISS-Elastic-Sync tool en hoe deze te installeren, is te vinden op de volgende URL:
[KISS-Elastic-Sync](https://github.com/Klantinteractie-Servicesysteem/KISS-Elastic-Sync/blob/main/README.md)

### Cronjobs
Naast de sync tool zijn er ook cronjobs die ingesteld moeten worden voor het regelmatig synchroniseren van data.

Meer informatie over de benodigde cronjobs en hoe deze in te stellen, is te vinden op de volgende URL:
[KISS-Elastic-Sync Cronjobs](https://github.com/Klantinteractie-Servicesysteem/KISS-Elastic-Sync/blob/main/deploy/README.md)
