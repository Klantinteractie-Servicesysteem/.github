# Zaken

## Zaken: het zaakdetailscherm

In onderstaande afbeelding is gedocumenteerd welke gegevens uit de verschillende ZGW-objecten worden gebruikt in het Zaak-detailscherm. 

![image](https://raw.githubusercontent.com/Klantinteractie-Servicesysteem/.github/refs/heads/main/docs/images/MappingZaakDetail.png)

## Onderwerpobject-identificatoren

Bij het verwerken van onderwerpen in contactmomenten en contactverzoeken in KISS worden onderwerpobjecten gehanteerd. KISS maakt hierbij onderscheid tussen verschillende typen onderwerpobjecten, waaronder zaken.

### Zaak-identificator

Voor objecten van het type zaak, herkend aan de `codeObjecttype`, wordt een koppeling gemaakt met het zaaksysteem en worden relevante zaakgegevens opgehaald:

```json
{
   "onderwerpobjectidentificator": {
       "objectId": "12345678-abcd-1234-efgh-1234567890ab",
       "codeObjecttype": "zgw-Zaak",
       "codeRegister": "openzaak",
       "codeSoortObjectId": "uuid"
   }
}
```

### Overige onderwerpobject-identificatoren

KISS ondersteunt ook andere typen onderwerpobjecten, zoals:
* Klantcontacten
* Internetaken
* Andere ZGW-objecten

Deze worden op dezelfde manier geïdentificeerd via hun `codeObjecttype`, maar worden anders verwerkt dan zaken. Bij objecten die geen zaken zijn, worden geen zaakgegevens opgehaald en getoond in het contactmomentenoverzicht.

## Verwerking van onderwerpobjecten in KISS

KISS filtert onderwerpobjecten op basis van hun `codeObjecttype` bij het verrijken van contactmomenten met zaakinformatie. Alleen objecten met het juiste zaak-type `codeObjecttype` worden verwerkt als zaken en hiervoor wordt zaakidentificatie opgehaald.

Deze filtering voorkomt 404-fouten die kunnen optreden wanneer een onderwerpobject verwijst naar een ander type object dan een zaak, zoals een klantcontact dat is aangemaakt vanuit een contactverzoek in een andere applicatie.
