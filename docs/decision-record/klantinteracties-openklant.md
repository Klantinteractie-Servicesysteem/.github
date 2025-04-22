# Klantinteracties en OpenKlant
Bij het koppelen van KISS aan de Klanteracties-API's zoals die in Open Klant 2 zijn geimplementeerd, hebben we een aantal keuzes gemaakt bij de inrichting van de gegevens, die in Klantinteracties door de VNG zijn beschreven als items op een Referentielijst.

## Klantcontact
De volgende properties uit het Klantcontact vullen we hard in met de volgende waarden:
- `indicatieContactGelukt`: altijd  true
- `taal`: altijd nld
- `vertrouwelijk`: altijd false
- `plaatsgevondenOp`: altijd de datum van registratie van het klantcontact.


## Partij-identificatoren

Sinds de aansluiting op Open Klant 2.7.0 maakt KISS gebruik van partij-identificatoren op de manier zoals dit vanaf deze versie van Open Klant noodzakelijk is. Zie [#944](https://github.com/Klantinteractie-Servicesysteem/KISS-frontend/issues/944)

**Let op:** dit betekent dat KISS versies vóór 1.0.0 niet kunnen koppelen met Open Klant 2.6 of hoger.


### Digitale adressen
Sinds de aansluiting op Open KLant 2.2 gebruikt KISS de soorten digitaal adres zoals de API dit voorschrijft. Zie issue [#891](https://github.com/Klantinteractie-Servicesysteem/KISS-frontend/issues/891). De benodigde validatie die sinds Open Klant 2.4 noodzakelijk is, is middels validatie in de KISS-frontend ondersteund. Zie issue [#939](https://github.com/Klantinteractie-Servicesysteem/KISS-frontend/issues/939).


## Actor-identificator

### Actor klantcontact

De Actor die we opslaan bij het Klantcontact, vullen we op basis van de gegevens van de ingelogde gebruiker, waarbij we er in eerste instantie vanuit gaan dat dit altijd is o.b.v. e-mailadres:

```

"actoridentificator": {
    "objectId": "user@domein.nl",
    "codeObjecttype": "mdw",
    "codeRegister": "msei",
    "codeSoortObjectId": "email"
    }

```

### Actor Contactverzoek (interneTaak)
Van de Actor die we opslaan bij een interne taak hebben we geen gegevens uit EntraID / OIDC, maar alleen uit Objectenregister. Dus voorlopig slaan we bij deze Actoren ook vast in de code de Actor-identificator properties op, die verwijzen naar het Objectenregister. Bij zowel Afdelingen, Groepen als Medewerkers gebruikt KISS als SoortObjectId de waarde van het property `identificatie`.

**Actoridentificator als medewerker**
```
"actoridentificator": {
    "objectId": "hassel006",
    "codeObjecttype": "mdw",
    "codeRegister": "obj",
    "codeSoortObjectId": "idf"
    }
```

**_Actoridentificator medewerker bij handmatig opgevoerd e-mailadres_**

Op verzoek van de gemeente Utrecht is het mogelijk gemaakt om Contactverzoeken aan te maken voor medewerkers, zonder dat er een Smoelenboek is gekoppeld. Hiervoor is een feature-switch aanwezig (zie ook [Installatiehandleiding, onderdeel configuratie, bij Feature switches](../installation/configuratie.md#kiss-frontend-feature-switches))



In dat geval wordt de actoridentificator op een iets andere manier opgebouwd.

```
"actoridentificator": {
	"objectId": "surbhi.jha@info.nl",
	"codeObjecttype": "mdw",
	"codeRegister": "handmatig",
	"codeSoortObjectId": "email"
	}
```

**Actoridentificator als AFDELING**
```
"actoridentificator": {
    "objectId": "PaBH",
    "codeObjecttype": "afd",
    "codeRegister": "obj",
    "codeSoortObjectId": "idf"
    }
```
**Actoridentificator als GROEP**
```
"actoridentificator": {
    "objectId": "VTH_OVG_ZV",
    "codeObjecttype": "grp",
    "codeRegister": "obj",
    "codeSoortObjectId": "idf"
    }
```



