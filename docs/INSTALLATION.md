## Klantinteractie Servicesysteem (KISS)
### Installatie handleiding
#### Inleiding
KISS draait in een kubernetes cluster. Deze handleiding is gebaseerd op Azure Kubernetes.
Andere kubernetes providers worden ook ondersteund mits ze haven-compliant zijn.
Deze handleiding is bedoeld voor kubernetes beheerders en biedt een stappenplan om KISS handmatig op een nieuw cluster te installeren.

### Voorbereidingen
#### Domein
Zorg voor een domeinnaam met wildcard-certificaat. Losse certificaten per endpoint worden op dit moment niet in deze handleiding ondersteund.
Dit certificaat moet als .crt bestand tijdens de handleiding gebruikt worden.
De opbouw van dit certificaat is als volgt:

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


#### Tools
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm](https://helm.sh/docs/intro/install/)
- [Haven](https://haven.commonground.nl/techniek/compliancy-checker)
- [Powershell](https://learn.microsoft.com/en-us/powershell/)

#### Haven
Er dient een haven-compliant cluster ingericht te worden.
Hiervoor zijn referentie-implementaties te vinden op de [haven](https://haven.commonground.nl/techniek/aan-de-slag) site.

#### Azure
Bij het volgen van de [Azure](https://haven.commonground.nl/techniek/aan-de-slag/azure) referentie dient met de volgende extra zaken rekening gehouden te worden.

- minimaal 3 nodes
- high availability aan zetten
- local logins met RBAC gebruiken, GEEN Azure Active Directory!
- Kubernetes version 1.25.4 gebruiken

Per servertype is er een quota aan het maximale aantal cores dat gebruikt mag worden in de regio.
Als dit overschreden wordt, dan kan dit in het quota scherm aangepast worden:
[https://portal.azure.com/#view/Microsoft_Azure_Capacity/QuotaMenuBlade/~/myQuotas](https://portal.azure.com/#view/Microsoft_Azure_Capacity/QuotaMenuBlade/~/myQuotas).

#### Authenticatie
De authenticatie van KISS gebeurt m.b.v. Azure Active Directory.

### Configuratie: environment variabelen
Voor elke installatie zijn een aantal environment variabelen nodig. Per onderdeel van KISS geven we aan welke variabelen gevuld moeten worden. In  het hieronder genoemde installatiescript, en in values.yaml zijn in sommige gevallen al default waarden ingevuld.

#### Authenticatie
Voor Authenticatie maakt KISS gebruik van een OpenIDConnect Identity Provider. 

| Variabele | Uitleg |  
|---|---|
| oidcAuthority | URL van de OpenID Connect Identity Provider |
| oidcClientId | Voor toegang tot de OpenID Connect Identity Provider |
| oidcClientSecret | OpenID Connect Identity Provider | 

#### Database
Er zijn verschillende gegevens die binnen KISS zelf worden opgeslagen, zoals Nieuws en Werkinstructies, Links, en managementinformatie. 

| Variabele | Uitleg | 
|---|---|
| postgresDb | Naam van de database bij KISS |
| postgresUser | Gebruikersnaam waarmee KISS toegang krijgt tot de DB |
| postgresPassword | Wachtwoord van de postgresUser |


#### Organisatie RSIN
Verschillende ZGW APIs, waaronder de Klant en Contactmoment APIs, vragen om een identificatienummer van de organisatie.

| Variabele | Uitleg |  
|---|---|
| ORGANISATIE_IDS | RSIN van de organisatie die de Contactmomenten registreert |

#### Feedback op Kennisartikelen
Vanuit KISS kan een KCM feedback geven op een kennisartikel. Deze informatie wordt gemaild naar één centraal mailadres

| Variabele | Uitleg |
|---|---|
| FEEDBACK_EMAIL_FROM | Het afzenderadres van de mail met feedback erin | 
| FEEDBACK_EMAIL_TO | Het adres waar de mail met feedback naar toe moet | 
| EMAIL_ENABLE_SSL | Gaat de mail via SSL true/false |
| EMAIL_HOST | Adres van de mailserver die de mail moet versturen | 
| EMAIL_PORT | poortnummer van de mailverbinding | 
| EMAIL_USERNAME | Username van het account dat zich aanmeldt bij de mailserver | 
| EMAIL_PASSWORD | Wachtwoord bij de username | 


#### Gekoppelde bronnen
Er zijn diverse bronnen die vanuit KISS via API's bevraagd worden. Sommige worden alleen geraadpleegd, zoals de KvK-API en de API voor Haal Centraal BRP Personen bevragen. Andere registraties worden niet alleen geraadpleegd, maar er worden ook gegevens in weggeschreven. Dit zijn in ieder geval een Klanten- en Contactmomentenregister, zoals Open Klant, en een Zaaksysteem (m.b.v. ZGW API's) zoals Open Zaak. 

Daarnaast zijn er bronnen die binnen KISS doorzocht moeten worden. 
- KISS gebruikt de SDG-api  om Kennisartikelen (PDC-producten) mee op te halen, en naar Elastic te pushen.
- KISS gebruikt op dit moment de Objecten API om de Medewerkers in het Smoelenboek op te halen en naar Elastic te pushen.
- KISS gebruikt op dit moment de Objecten API om de Vraag Antwoord Combinaties (VAC) op te halen en naar Elastic te pushen. 

**Let op**: Sommige  API-keys en Secretes die KISS nodig heeft om externe registers te bevragen moeten **minimaal 16 karakters** lang zijn. 

**_Gekoppelde bronnen: KISS-frontend_**

Onderstaande environment variabelen gaan over de bronnen die gekoppeld zijn aan de KISS-frontend.

| Variabele | Uitleg |  
|---|---|
| imageTag | Dit is de verwijzing naar de Build-versie van de <br />KISS-frontend repository |
| haalCentraalBaseUrl | URL van de Haal Centraal API om de BRP te bevragen |
| haalCentraalApiKey | Key om de Haal Centraal API te bevragen |
| kvkBaseUrl | URL van de KvK-API om het Handelsregister te bevragen | 
| kvkApiKey | Key om de Kvk-API te bevragen |
| enterprise_search_url | URL van de API waarop KISS de elastic instantie <br />kan bevragen | 
| elasticPassword | Nodig om de Elastic API te bevragen |
| enterprise_search_private_api | Nodig om de Elastic API te bevragen |
| enterprise_search_public_api | Nodig om de Elastic API te bevragen |
| klanten_base_url | URL van de Klanten API voor het gebruikte klantenregister |
| klanten_client_id | clientId voor het gebruikte klantenregister |
| klanten_client_secret | secret voor het gebruikte klantenregister, deze <br />moet **minimaal 16 karakters** lang zijn |
| CONTACTMOMENTEN_BASE_URL  | URL van de Contactmomenten API voor het gebruikte <br />Contactmomentenregister  |
| CONTACTMOMENTEN_API_CLIENT_ID | clientId voor het gebruikte Contactmomentenregister |
| CONTACTMOMENTEN_API_KEY  | API key te gebruiken door KISS voor het gebruikte <br />Contactmomentenregister, deze moet **minimaal <br />16 karakters** lang zijn. |
| ZAKEN_BASE_URL  |  URL waar de verschillende ZGW API's te benaderen zijn |
| ZAKEN_API_CLIENT_ID  | clientId van de ZGW API's |
| ZAKEN_API_KEY  | API Key van de ZGW API's, deze moet <br />**minimaal 16 karakters** lang zijn |

**_Gekoppelde bronnen: KISS-Elastic-Sync_**

KISS-Elastic-Sync is het component dat zorgt dat de gekoppelde bronnen die via Elasticsearch ontsloten worden in KISS, naar de juiste Indexen worde gepushed, met de benodigde gegevens hieraan toegevoegd. Onderstaande environment variabelen gaan over de bronnen die gekoppeld zijn aan de KISS-Elastic-Sync.

| Variabele | Uitleg |  
|---|---|
| enterprise_search_url | URL van de API waarop KISS de elastic instantie <br />kan bevragen | 
| enterprise_search_private_api | Nodig om de Elastic API te vullen |
| MEDEWERKER_OBJECTEN_BASE_URL | URL van de Objecten API waar de medewerkers gevonden <br />kunnen worden |
| MEDEWERKER_OBJECTEN_TOKEN |  Token van de Objecten API waar de medewerkers gevonden <br />kunnen worden |
| MEDEWERKER_OBJECTTYPES_BASE_URL | URL van de Objecttype API waar het objecttype <br />'Medewerker' gevonden kan worden |
| MEDEWERKER_OBJECTTYPES_TOKEN | Token van de Objecttype API waar het objecttype <br />'Medewerker' gevonden kan worden |
| VAC_OBJECTEN_BASE_URL | URL van de Objecten API waar de VAC's gevonden <br />kunnen worden |
| VAC_OBJECTEN_TOKEN |  Token van de Objecten API waar de VAC's gevonden <br />kunnen worden |
| VAC_OBJECTTYPES_BASE_URL | URL van de Objecttype API waar het objecttype 'VAC' <br />gevonden kan worden |
| VAC_OBJECTTYPES_TOKEN | Token van de Objecttype API waar het objecttype 'VAC' <br />gevonden kan worden |
| SDG_BASE_URL  | URL van de API waarmee Kennisartikelen <br />(PDC-producten) kunnen worden opgehaald door KISS |
| SDG_API_KEY  | URL van de API voor Kennisartikelen  |


### Installatie
Als het kubernetes cluster is ingericht, kunnen we de onderdelen van KISS gaan installeren.

#### Placeholders
De yaml-voorbeeldbestanden staan in [https://github.com/Klantinteractie-Servicesysteem/KISS-frontend/blob/main/helm/kiss-frontend/kiss.template.yaml](https://github.com/Klantinteractie-Servicesysteem/KISS-frontend/blob/main/helm/kiss-frontend/kiss.template.yaml)

#### Uitvoeren
De installatie kan worden uitgevoerd middels onderstaande powershell script. Ook zonder powershell zijn de commands in het script handmatig uit te voeren.

[install_kiss.ps1](https://github.com/Klantinteractie-Servicesysteem/.github/blob/main/docs/scripts/install_kiss.ps1)

#### Aanpassingen
Hoe een config en/of secrets moeten worden aangepast staat beschreven in MAINTENANCE.md
