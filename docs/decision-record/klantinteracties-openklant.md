# Klantinteracties en OpenKlant
Bij het koppelen van KISS aan de Klanteracties-API's zoals die in Open Klant 2 zijn geimplementeerd, hebben we een aantal keuzes gemaakt bij de inrichting van de gegevens, die in Klantinteracties door de VNG zijn beschreven als items op een Referentielijst. 

## Partij-identificatoren

We gebruiken de volgende codes in partij-identificatoren

**Natuurlijke persoon**<br />
- codeObjecttype: "inp" > natuurlijke persoon 
- codeSoortObjectId: "bsn" > BSN van de natuurlijke persoon


**Vestiging** <br/>
- codeObjecttype: "vst" > Vestiging uit het Handelsregister
- codeSoortObjectId: "vtn" > Vestigingsnummer van de vestiging in het Handelsregister

**Niet natuurlijke persoon (rechtspersoon zonder vestigingsnummer)**
- codeObjecttype: "nnp" > Niet-natuurlijke persoon uit het Handelsregister
- codeSoortObjectId: "rsin" > RSIN van de Niet-natuurlijke persoon in het Handelsregister

**KvK-nummer**<br />
Bij Partijen van het type Organisatie, die we uit het handelsregister ophalen slaan we altijd ook een tweede partij-identificator op, met daarin het KvKnummer: 
- codeObjecttype: "nnp" > Niet-natuurlijke persoon uit het Handelsregister
- codeSoortObjectId: "kvk" > Het KvK-nummer van de vestiging of Niet-natuurlijke persoon in het Handelsregister

**Registers**
- codeRegister: "brp" > register waar het BSN van de natuurlijke persoon te vinden is
- codeRegister: "hr" > verwijzing naar het handelsregister (voor vestigingsnummer,KvK-nummer en RSIN)
- codeRegister: "msei" > verwijzing naar Microsoft EntraId, waar gegevens van de ingelogde gebruiker in staan. 

### Digitale adressen
Bij het ophalen en opslaan van telefoonnummers en e-maiadressen, gebruiken we bij `soortDigitaalAdres`de waarde van de Code uit een voorzet van referentielijsten. Bij Omschrijving gebruiken we de waarde van Naam uit die referentielijst, tenzij een andere naam is ingegeven. Bijvoorbeeld:

```
{
"adres": "0622022020",
"soortDigitaalAdres": "telnr",
"omschrijving": "telefoonnummer"
},
{
"adres": "icatttest+rachid@gmail.com",
"soortDigitaalAdres": "email",
"omschrijving": "e-mailadres"
}
```


## Actor-identificator

De Actor die we opslaan bij het Klantcontact, vullen we op basis van de gegevens van de ingelogde gebruiker, waarbij we er in eerste instantie vanuit gaan dat dit altijd is o.b.v. e-mailadres: 

- codeObjecttype= mdw (Documenteren)
- codeRegister=msei (Documenteren)
- codeSoortObjectId=email (Documenteren)

Van de Actor die we opslaan bij een interne taak hebben we geen gegevens uit EntraID / OIDC maar alleen uit Objectenregister. Dus voorlopig slaan we bij deze Actoren ook vast in de code de Actor-identificator properties op, die verwijzen naar het Objectenregister: 

Actor identificator als medewerker
- codeObjecttype= mdw 
- codeRegister=obj 
- codeSoortObjectId=idf
- objectId=(waarde van identificatie uit het medewerkerobject)

Actor identificator als AFDELING of GROEP
- codeObjecttype= afd  OF: codeObjecttype= grp 
- codeRegister=obj 
- codeSoortObjectId=idf
- objectId=(waarde van identificatie uit het afdeling-object of het groep object)

## Klantcontact
De volgende properties uit het Klantcontact vullen we hard in met de volgende waarden: 
- `indicatieContactGelukt`: altijd  true
- `taal`: altijd nld 
- `vertrouwelijk`: altijd false
- `plaatsgevondenOp`: altijd de datum van registratie van het klantcontact.


