# Configuratie
Bij de installatie van KISS worden er een groot aantal dingen al geconfigureerd. Maar wat daarna in ieder geval nog moet gebeuren, zijn de gemeentespecifieke zaken, zoals het koppelen aan de eigen bronnen, en het inregelen van verschillende lijstjes met eigen gegevens.  

## Koppelen van nieuwe bronnen

De Common Gateway als core onder KISS biedt de optie om extra bronnen (applicaties te koppelen) zonder dat het nodig is om hiervoor een ontwikkelpartij in te schakelen of code te schrijven.

Log hiervoor in op de pagina voor beheer van de Gateway en ga naar het menu item "sources". Daar kunt u bestaande bronnen bewerken en nieuwe bronnen toevoegen
![img_2.png](img_2.png)

Voor het toevoegen van een bron klikt u op "Toevoegen". Daar kunt u de locatie, de externe API en eventueel autorisatie inregelen.

![img_3.png](img_3.png)

Nadat de bron is toegevoegd kunt u de connectie naar de bron toe testen. Het verdient een warme aanbeveling om dit te doen VOORDAT u verder gaat met de inrichting van de externe bron. U kunt de verbinding naar een bron toe testen door op "test connection" te klikken.

![img_4.png](img_4.png)

Als de bron succesvol is toegevoegd en de verbinding is getest, moet de bron nog worden gekoppeld aan een van de in KISS bekende objecten. Dit gaat door het inregelen van zogenoemde synchronisatie-acties. Synchronisaties-acties gaan (net als alle andere acties in de gateway) af als zich een EVENT voordoet. Voorbeelden van events voor het synchroniseren van bronnen zijn:

- Het object verandert in KISS (bijwerken naar de bron toe)
- Het object verandert in de BRON (ophalen vanuit de bron)


## Beheer op Selectielijsten
De KISS-frontend maakt gebruik van een aantal lijstjes, die u kunt beheren in de Gateway. Als u inlogt op de pagina voor het beheer van de Gateway, zie u op het Dashboard een aantal cards die doorverwijzen naar de belangrijkste selectielijsten.
![img.png](img.png)

* _ResultaatTypeOmschrijvingGeneriek_: dit lijstje bevat de soorten afhandeling die de KCM bij de afronding kan registreren bij het contactmoment. Bijvoorbeeld Zelfstandig afgehandeld, Doorverbonden. 
**LET OP:** er is één item op deze lijst die niet aangepast kan worden, en dat is "Contactverzoek gemaakt": deze heeft de frontend nodig voor het registreren van contactverzoeken.
* _Link_: dit zijn de links naar veel gebruikte websites of applicaties. Deze hebben een url, een title (dat is linktekst) en een category. Alle links worden in de frontend gegroepeerd op Categorie getoond. 
* _Afdelingsnaam_: dit is de lijst met afdelingsnamen, die gekoppeld kunnen worden aan een Contactverzoek
* _kiss_openpub_skill_: dit zijn de skills, of categorieën, die aan nieuws en werkinstructies gekoppeld kunnen worden, en waarop je kunt filteren. 



Met een klik op een van deze cards, komt u op de pagina waar u de items van die lijst, dat zijn de objecten van dat type, kunt bewerken. Dit doet u in de tab Objecten (of Objects). Met de knop "+ Object toevoegen" (Add Object), kunt u een nieuw item aan maken voor die lijst. Door in de lijst op het knop Details bij een object te klikken, kunt u dat specifieke item aanpassen.  

![img_1.png](img_1.png)

### Beheren van de kiss_openpub_skill lijst

1. Klik op de startpagina (Dashboard) op de Card van `kiss_openpub_skill`, en zorg dat je op dat tab Objecten (Objects) staat.
2. Klik op `"+ Object Toevoegen"`
3. Vul het veld `"Name"` in
4. Klik op `"Save"`.

Hiermee voeg je een nieuw item toe. Dit item zal zichtbaar zijn in WordPress, bij het veld "Skill". Klik eventueel even buiten het veld en weer opnieuw in het veld om de lijst opnieuw op te halen. 

_Note:_ je kunt bestaande objecten ook aanpassen vanuit de Gateway UI. Op de tab Objecten (Objects) ziet u alle objecten van dat type onder elkaar. Vandaar uit kunt u een specifiek object bekijken, en eventueel aanpassen. 


