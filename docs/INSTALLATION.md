## Klantinteractie Servicesysteem (KISS)
### Installatie handleiding
#### Inleiding
KISS draait in een kubernetes cluster. Deze handleiding is gebaseerd op Azure Kubernetes.
Andere kubernetes providers worden ook ondersteund mits ze haven-compliant zijn.
Deze handleiding is bedoeld voor kubernetes beheerders en biedt een stappenplan om KISS handmatig op een nieuw cluster te installeren.

### Stap 0 - Voorbereidingen
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
- [SqlCmdLets](https://www.cdata.com/drivers/postgresql/powershell/) (trial)

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
https://portal.azure.com/#view/Microsoft_Azure_Capacity/QuotaMenuBlade/~/myQuotas.

#### Authenticatie
De authenticatie van KISS gebeurt m.b.v. Dex. Er bestaan voor Dex vele [connectoren](https://dexidp.io/docs/connectors/), ook voor bijvoorbeeld Active Directory. In deze installatiehandleiding koppelen we OpenLDAP aan Dex. 


### Installatie
#### Placeholders
In de installatiescripts die u hieronder vindt, en in bijbehorende yaml-configuratiebestanden staan "[!ChangeMe!]" placeholders.
Op deze plekken vult u de wachtwoorden, keys en domeininstellingen in, die horen bij uw eigen installatie-omgeving. 

De yaml-voorbeeldbestanden staan in de map [/yaml](https://github.com/Klantinteractie-Servicesysteem/.github/tree/main/docs/yaml)

#### Uitvoeren
Ook zonder powershell zijn de commands in deze scripts handmatig uit te voeren.

Met het eerste script stellen we een aantal waarden in, waaronder het domein (in dit geval kiss-demo.nl) en de omgeving (in dit geval de accept-omgeving). Daarna doorloopt u met de scripts de volgende vier stappen:

1. Eerst installeren we alle onderdelen van KISS, zoals de CommonGateway, de Kiss-frontend, WordPress en Elastic. 
2. Vervolgens configureren we elastic, zodat er een admin-account wordt aangemaakt op de Kibana-interface. Ook maken we een een kiss-engine aan (noodzakelijk voor communicatie met de frontend). Binnen die engine maken we een crawler aan voor de gemeentelijke website die we ook starten. 
3. Vervolgens configureren we de gateway door de benodigde schema's en endpoints in te regelen. Ook richten we het endpoint naar Elastic in, en zorgen we dat de sync-actions worden gestart naar Elastic en vanuit WordPress.
4. Tenslotte configureren we de relevance tuning binnen Elastic.

> [0_prechecks.ps1](https://github.com/Klantinteractie-Servicesysteem/.github/blob/main/docs/scripts/0_prechecks.ps1)
>
> [1_install_kiss.ps1](https://github.com/Klantinteractie-Servicesysteem/.github/blob/main/docs/scripts/1_install_kiss.ps1)
> 
> [2_update-elastic.ps1](https://github.com/Klantinteractie-Servicesysteem/.github/blob/main/docs/scripts/2_update-elastic.ps1)
> 
> [3_updateGateway.ps1](https://github.com/Klantinteractie-Servicesysteem/.github/blob/main/docs/scripts/3_updateGateway.ps1)
> 
> [4_update-elastic-relevance.ps1](https://github.com/Klantinteractie-Servicesysteem/.github/blob/main/docs/scripts/4_update-elastic-relevance.ps1)

#### Installatie WordPress plugin voor Openpub

Om nieuws en werkinstructies te beheren, maken we in deze installatie gebruik van een WordPress omgeving, uitgebreid met de Openpub WordPress plugin. In de installatiescripts is er een WordPress-installatie neergezet, en is er een admin-account aangemaakt. Als laatste stap moeten we de OpenPub plugin installeren en configureren.

_Nog niet eerder met WordPress plugins gewerkt? Lees hier de [officiële documentatie](https://wordpress.org/support/article/managing-plugins/)._

1. [Download hier](./openPub/) de Openpub plugin bestanden. 
2. Volg vervolgens de [Openpub plugin installatie stappen](https://kiss-klantinteractie-servicesysteem.readthedocs.io/en/latest/openpub/)
