# Klantinteracties en OpenKlant
Bij het koppelen van KISS aan de Klanteracties-API's zoals die in Open Klant 2 zijn geimplementeerd, hebben we een aantal keuzes gemaakt bij de inrichting van de gegevens, die in Klantinteracties door de VNG zijn beschreven als items op een Referentielijst. 

## Klantcontact
De volgende properties uit het Klantcontact vullen we hard in met de volgende waarden: 
- `indicatieContactGelukt`: altijd  true
- `taal`: altijd nld 
- `vertrouwelijk`: altijd false
- `plaatsgevondenOp`: altijd de datum van registratie van het klantcontact.


## Partij-identificatorn

Sinds de aansluiting op Open Klant 2.6 maakt KISS gebruik van partij-identificatoren op de manier zoals dit vanaf deze versie van Open Klant noodzakelijk is. Zie [#944](https://github.com/Klantinteractie-Servicesysteem/KISS-frontend/issues/944)


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

### Actor interne taak
Van de Actor die we opslaan bij een interne taak hebben we geen gegevens uit EntraID / OIDC maar alleen uit Objectenregister. Dus voorlopig slaan we bij deze Actoren ook vast in de code de Actor-identificator properties op, die verwijzen naar het Objectenregister. Bij zowel Afdelingen, Groepen als Medewerkers gebruikt KISS als SoortObjectId de waarde van het property `identificatie`

**Actor identificator als medewerker**
```
"actoridentificator": {
    "objectId": "hassel006",
    "codeObjecttype": "mdw",
    "codeRegister": "obj",
    "codeSoortObjectId": "idf"
    }
```

**Actor identificator als AFDELING**
```
"actoridentificator": {
    "objectId": "PaBH",
    "codeObjecttype": "afd",
    "codeRegister": "obj",
    "codeSoortObjectId": "idf"
    }
```
**Actor identificator als GROEP**
```
"actoridentificator": {
    "objectId": "VTH_OVG_ZV",
    "codeObjecttype": "grp",
    "codeRegister": "obj",
    "codeSoortObjectId": "idf"
    }
```



