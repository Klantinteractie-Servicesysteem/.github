# Voorbereidingen

## Domein

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

## Tools

Installeer de volgende tools:

- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm](https://helm.sh/docs/intro/install/)
- [Haven](https://haven.commonground.nl/techniek/compliancy-checker)
- [Powershell](https://learn.microsoft.com/en-us/powershell/)

## Haven

KISS kan op een haven-compliant cluster geïnstallleerd worden. Referentie-implementaties van haven-compliant clusters zijn te vinden op de [Haven](https://haven.commonground.nl/techniek/aan-de-slag) site.

Bij het volgen van de [Azure](https://haven.commonground.nl/techniek/aan-de-slag/azure) referentie moet men rekening houden met de volgende extra zaken:

- Minimaal 3 nodes
- High availability aanzetten
- Local logins met RBAC gebruiken, GEEN Azure Active Directory!


## Authenticatie

De authenticatie van gebruikers binnen KISS gebeurt m.b.v. een OIDC koppeling met bijvoorbeeld Azure Active Directory.