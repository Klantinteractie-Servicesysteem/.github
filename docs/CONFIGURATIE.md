# Configuratie
Bij de installatie van KISS worden er een groot aantal dingen al geconfigureerd. Maar wat daarna in ieder geval nog moet gebeuren, zijn de gemeentespecifieke zaken, zoals het koppelen aan de eigen bronnen, en het inregelen van verschillende lijstjes met eigen gegevens.  

## Configuratie van uw Identity Provider
Bij de installatie van KISS regelt u de koppeling met uw OpenIDConnect Identity Provider. Daarnaast moet u in uw Identity Provider configureren dat gebruikers die in moeten kunnen loggen bij KISS in ieder geval een 'klantcontactmedewerker'-rol hebben. Een rol is in dit geval een claim van het type `role` of `roles` (beiden worden ondersteund). De waarde die correspondeert met een kiss-medewerker kunt u instellen tijdens de installatie. Standaard is dit `Klantcontactmedewerker`. Voor medewerkers die beheertaken op KISS uitvoeren, is een aparte rol ingeregeld. Ook de naam van deze rol kunt u instellen tijdens de installatie. Standaard is dit `Redacteur`. 
### Voorbeeldinrichting in Azure Active Directory
Als u gebruik maakt van Azure Active Directory als Identity Provider, kunt u dit op de volgende manier inrichten.
1. Bij de installatie van KISS heeft u een App Registration aangemaakt. Ga binnen Azure AD naar App registrations en klik op de applicatie.
![image](https://github.com/Klantinteractie-Servicesysteem/.github/assets/104420825/ed03cc61-ff31-4030-875f-fca89ba01381)
2. Navigeer naar App roles, kie Create app role en vol de benodigde velden in. Belangrijk is dat u kiest voor Users/Groups als Allowed member types en bij Value kiest voor de rol die u bij de installatie geconfigureerd hebt (standaard `Klantcontactmedewerker`).
![image](https://github.com/Klantinteractie-Servicesysteem/.github/assets/104420825/313a6637-2ea7-49ec-9792-4a8e961b8127)
3. Herhaal de vorige stap voor de rol die u tijdens de installatie heeft geconfigureerd voor medewerkers die beheertaken uitvoeren (standaard `Redacteur`)
4. Nu kunt u deze rollen toekennen aan gebruikers of groepen uit uw organisatie. Hiervoor moet u eerst terug naar Azure Active Directory. Navigeer daar naar Enterprise applications.
![image](https://github.com/Klantinteractie-Servicesysteem/.github/assets/104420825/dd22f150-358b-4a1c-b994-b9601e28b72b)
5. In dit scherm vindt u een applicatie met dezelfde naam als de App registration die u eerder heeft aangemaakt. Klik op de applicatie.
![image](https://github.com/Klantinteractie-Servicesysteem/.github/assets/104420825/baefd96c-e3a7-4ef6-abd7-d158a6bf1356)
6. Navigeer naar Users and groups, en klik op Add user/group.
![image](https://github.com/Klantinteractie-Servicesysteem/.github/assets/104420825/5c211af6-08eb-4511-b744-9ef4ea81d572)
7. In dit scherm kunt u de rollen die u eerder gedefinieerd heeft, toekennen aan individuele gebruikers en - als uw licentie van Active Directory dit toestaat - groepen.


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


