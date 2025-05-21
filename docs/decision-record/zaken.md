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

KISS toont het Zaaknummer van de zaak die is gekoppeld aan een Contactmoment. Hiervoor kijkt KISS naar de waarde  `"codeObjecttype": "zgw-Zaak"`  én `"codeRegister": "openzaak"`. Dit om te voorkomen dat een uuid wordt gezocht dat niet bestaat in de gekoppelde Open Zaak instantie.
