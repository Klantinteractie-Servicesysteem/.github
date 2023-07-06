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

### Configuratie: variabelen
Voor elke installatie zijn een aantal environment variabelen nodig. Per ondderdeel van KISS geven we aan welke variabelen gevuld moeten worden.  

#### Authenticatie
Voor Authenticatie maakt KISS gebruik van een OpenIDConnect Identity Provider. 

| Variabele  | Uitleg  |  In installatiescript  |
|---|---|---|
| oidcClientId  |   |  |
| oidcClientSecret  |   |  |

#### Database
Er zijn verschillende gegevens die binnen KISS zelf worden opgeslagen, zoals Nieuws en Werkinstructies, Links, en managementinformatie. 

| Variabele  | Uitleg  |  In installatiescript  |
|---|---|---|
| postgresDb  |   |  |
| postgresPassword  |   |  |
| postgresUser  |   |  |


#### Organisatie RSIN
Bij het opslaan van contactmomenten moet het RSIN van de organisatie worden meegestuurd. Deze stelt u in bij ORGANISATIE_IDS

| Variabele  | Uitleg  |  In installatiescript  |
|---|---|---|
| ORGANISATIE_IDS  |   |  |

#### Feedback op Kennisartikelen
Vanuit KISS kan een KCM feedback geven op een kennisartikel. Deze informatie wordt gemaild naar één centraal mailadres

| Variabele  | Uitleg  |  In installatiescript  |
|---|---|---|
| EMAIL_ENABLE_SSL  | Gaat de mail via SSL true/false  |  |
| EMAIL_HOST  |   |  |
| EMAIL_PASSWORD  |   |  |
| EMAIL_PORT  |   |  |
| EMAIL_USERNAME  |   |  |
| FEEDBACK_EMAIL_FROM  |   |  |
| FEEDBACK_EMAIL_TO  |   |  |


| imageTag  | Dit is de verwijzing naar de versie Build van KISS-frontend respository  |  |



| elasticPassword  |   |  |
| enterprise_search_private_api  |   |  |
| enterprise_search_public_api  |   |  |
| enterprise_search_url  |   |  |
| haalCentraalApiKey  |   |  |
| haalCentraalBaseUrl |   |  |
| kvkApiKey  |   |  |
| kvkBaseUrl  |   |  |

| klanten_base_url |   |  |
| klanten_client_id  |   |  |
| klanten_client_secret  |   |  |
| CONTACTMOMENTEN_API_CLIENT_ID  |   |  |
| CONTACTMOMENTEN_API_KEY  |   |  |
| CONTACTMOMENTEN_BASE_URL  |   |  |


| OBJECTEN_BASE_URL  |   |  |
| OBJECTEN_TOKEN  |   |  |
| OBJECTTYPES_BASE_URL  |   |  |
| OBJECTTYPES_TOKEN  |   |  |
| SDG_API_KEY  |   |  |
| SDG_BASE_URL  |   |  |
| ZAKEN_API_CLIENT_ID  |   |  |
| ZAKEN_API_KEY  |   |  |
| ZAKEN_BASE_URL  |   |  |







### Installatie
Als het kubernetes cluster is ingericht, kunnen we de onderdelen van KISS gaan installeren.

#### Placeholders
De yaml-voorbeeldbestanden staan in [https://github.com/Klantinteractie-Servicesysteem/KISS-frontend/blob/main/helm/kiss-frontend/kiss.template.yaml](https://github.com/Klantinteractie-Servicesysteem/KISS-frontend/blob/main/helm/kiss-frontend/kiss.template.yaml)

#### Uitvoeren
De installatie kan worden uitgevoerd middels onderstaande powershell scripts. Ook zonder powershell zijn de commands in deze scripts handmatig uit te voeren.

We doorlopen met de scripts de volgende drie stappen:

1. Eerst installeren we alle onderdelen van KISS, de Kiss-frontend, BFF en Elastic. 
2. Vervolgens configureren we elastic, zodat er een admin-account wordt aangemaakt op de Kibana-interface. Ook maken we een een kiss-engine aan (noodzakelijk voor communicatie met de frontend). Binnen die engine maken we een crawler aan voor de gemeentelijke website die we ook starten. 
3. (LET OP! Deze stap doen we pas nadat de medewerkers of kennisartikelen zijn geindexeerd) Tenslotte configureren we de relevance tuning binnen Elastic. 

> [1_install_kiss.ps1](https://github.com/Klantinteractie-Servicesysteem/.github/blob/main/docs/scripts/1_install_kiss.ps1)
> 
> [2_update-elastic.ps1](https://github.com/Klantinteractie-Servicesysteem/.github/blob/main/docs/scripts/2_update-elastic.ps1)
> 
> [3_update-elastic-relevance.ps1](https://github.com/Klantinteractie-Servicesysteem/.github/blob/main/docs/scripts/3_update-elastic-relevance.ps1)
