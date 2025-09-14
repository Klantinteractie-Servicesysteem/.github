# Zaken

## Het zaakdetailscherm

In onderstaande afbeelding is gedocumenteerd welke gegevens uit de verschillende ZGW-objecten worden gebruikt in het Zaak-detailscherm. 

![image](https://raw.githubusercontent.com/Klantinteractie-Servicesysteem/.github/refs/heads/main/docs/images/MappingZaakDetail.png)

## Koppeling van een zaak aan een Contactmoment

Binnen de Klantinteracties API wordt de koppeling van een Zaak aan een klantcontact gelegd m.b.v. een `onderwerpobjectidentificator`. Bij het leggen van de koppeling richt KISS het onderwerpobject als volgt in: 

```json
{
   "onderwerpobjectidentificator": {
       "objectId": "12345678-abcd-1234-efgh-1234567890ab", // het uuid van de gekoppelde zaak
       "codeObjecttype": "zgw-Zaak",
       "codeRegister": "openzaak",
       "codeSoortObjectId": "uuid"
   }
}
```

### Zaakinformatie in het Contactmoment

KISS toont het Zaaknummer van de zaak die is gekoppeld aan een Contactmoment. Hiervoor kijkt KISS naar de waarde `"codeObjecttype": "zgw-Zaak"` én `"codeRegister": "openzaak"`. Dit om te voorkomen dat een uuid wordt gezocht dat niet bestaat in de gekoppelde Open Zaak instantie.


## Zaken zoeken bij bedrijven zonder vestigingsnummer
Binnen de ZGW-API's kun je zaken ophalen bij bedrijven zonder vestigingsnummer door te kijken naar betrokkenen bij een zaak, en specifiek: `rol`len met `"betrokkeneType": "niet_natuurlijk_persoon"`. Het identificerende kenmerk van deze betrokkene staat in `betrokkeneIdentificatie.InnNnpId`. De Zaken API geeft als omschrijving: "Het door een kamer toegekend uniek nummer voor de INGESCHREVEN NIET-NATUURLIJK PERSOON". Maar de specificatie geeft niet aan welk uniek nummer je hiervoor moet gebruiken, rsin of KvK-nummer. 

Bij het koppelen met verschillende zaakregistratiesystemen zien we dat het ene systeem in `betrokkeneIdentificatie.InnNnpId` een rsin verwacht, en een andere een KvK-nummer. In sommige gevallen geeft het registratiesysteem zelfs een 400 bad request terug, als het gegeven niet voldoet aan het format van het gekozen gegeven. 

**Probleem**

We kunnen per gekoppelde zaakregistratie configurabel maken, welk gegeven het systeem verwacht in `betrokkeneIdentificatie.InnNnpId` . We kunnen ook naar elke zaakregistratie beide opties proberen en zien welke een resultaat geeft. 

- **Keuze**: we kiezen voor die laatste optie, omdat hiermee de code overzichtelijk en begrijpelijk blijft. We hebben er hierbij wel voor gezorgd dat eventuele bad request errors vanuit de zaakregistratie niet gelogd worden. 
- **Overwegingen**: elke featureswitch levert complexiteit in code op. Door niet met een featureswitch te werken, maar gewoon beide opties te proberen, blijft de code overzichtelijker.