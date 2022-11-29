# Configuratie



## Koppelen van nieuwe bronnen
De Commongateway als core onder kiss bied de optie om extra bronnen (applicaties te koppelen) zonder dat het nodig is om hiervoor een ontwikkelpartij in te schakkelen of code te schrijven.

Log hiervoor in op de admin omgeving en ga naar het menu item "sources", daar kunt u bestaande bronnen bewerken en nieuwe bronnen toevoegen
![img_2.png](img_2.png)

Voor het toevoegen van een bron klikt u op "Toevoegen", daar kunt u de locatie de externe api en eventueele authorisatie inregelen.

![img_3.png](img_3.png)

Nadat de bron is toegevoegd is het ook mogenlijk om de connectie naar de bron toe te testen, het verdient een warme aan beveling om dit te doen VOORDAT u verder gaat met de inrichting van de externe bron. U kunt de verbinding naar een bron toe testen door op "test connection" te klikken.

![img_4.png](img_4.png)

Als de bron succesvol is toegevoegd en de verbinding getest moet de bron nog worden gekoppeld aan een van de in kiss bekende objecten. Dit gaat door het inregelen van zogenoemde synchronisatie acties. Synchronisaties acties gaan (net als alle andere acties in de gateway) af als zich een EVENT voordoet. Voorbeelden van events voor het sycnhonyseren van bronnen zijn:
- Het object veranderd in KISS (bijwerken naar de bron toe)
- Het object veranderd in de BRON (ophalen vanuit de bron)

## Opzetten van proxies


## Beheer op Selectielijsten
Op het beheer dashboard vind u een aantal cards die doorverwijzen naar de diverse beschickbare selectielijsten
![img.png](img.png)

Het klikken op een van deze cards leid naar een overzicht lijst van de verschillende items die onderdeel zijn van deze lijst. Hier kunt u items toevoegen, bewerken (via de details knop) en verwijderen.

![img_1.png](img_1.png)

### Beheren van de openpub_skill lijst

1. Navigeer naar Schemas en navigeer naar het juiste schema (`kiss_openpub_skill`)
2. Klik op `"+ Object Toevoegen"`
3. Vul het veld `"Name"` in
4. Klik op `"Save"`.

_Note:_ je kunt bestaande objecten ook aanpassen vanuit de Gateway UI, de objecten zijn te vinden in het schema (onder de `"+ Object Toevoegen"` knop van stap 3. Dit zal een **nieuw object** aanmaken in de WordPress omgeving.

**Koppeling tussen de beheerde lijsten en Wordpress**

Wanneer je WordPress opent (refresh required!) zal die automatisch de geüpdatete lijst van de Gateway ophalen en de Skills updaten. Hier hoef je niets voor te doen.
