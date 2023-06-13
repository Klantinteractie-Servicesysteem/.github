# Configuratie
Bij de installatie van KISS worden er een groot aantal dingen al geconfigureerd. Maar wat daarna in ieder geval nog moet gebeuren, zijn de gemeentespecifieke zaken, zoals het koppelen aan de eigen bronnen, en het inregelen van verschillende lijstjes met eigen gegevens.  


## Configuratie van uw Identity Provider
Bij de installatie van KISS regelt u de koppeling met uw OpenIDConnect Identity Provider. Daarnaast moet u in uw Identity Provider configureren dat gebruikers die in moeten kunnen loggen bij KISS in ieder geval een 'klantcontactmedewerker'-rol hebben. Een rol is in dit geval een claim van het type `role` of `roles` (beiden worden ondersteund). De waarde die correspondeert met een kiss-medewerker kunt u instellen tijdens de installatie. Standaard is dit `Klantcontactmedewerker`. Voor medewerkers die beheertaken op KISS uitvoeren, is een aparte rol ingeregeld. Ook de naam van deze rol kunt u instellen tijdens de installatie. Standaard is dit `Redacteur`. 
### Voorbeeldinrichting in Azure Active Directory
Als u gebruik maakt van Azure Active Directory als Identity Provider, kunt u dit op de volgende manier inrichten.
1. Bij de installatie van KISS heeft u een App Registration aangemaakt. Ga binnen Azure AD naar App registrations en klik op de applicatie.
  
    ![image](https://github.com/Klantinteractie-Servicesysteem/.github/assets/104420825/ed03cc61-ff31-4030-875f-fca89ba01381)
  
1. Navigeer naar App roles, kie Create app role en vol de benodigde velden in. Belangrijk is dat u kiest voor Users/Groups als Allowed member types en bij Value kiest voor de rol die u bij de installatie geconfigureerd hebt (standaard `Klantcontactmedewerker`).

    ![image](https://github.com/Klantinteractie-Servicesysteem/.github/assets/104420825/313a6637-2ea7-49ec-9792-4a8e961b8127)

1. Herhaal de vorige stap voor de rol die u tijdens de installatie heeft geconfigureerd voor medewerkers die beheertaken uitvoeren (standaard `Redacteur`)
1. Nu kunt u deze rollen toekennen aan gebruikers of groepen uit uw organisatie. Hiervoor moet u eerst terug naar Azure Active Directory. Navigeer daar naar Enterprise applications.

    ![image](https://github.com/Klantinteractie-Servicesysteem/.github/assets/104420825/dd22f150-358b-4a1c-b994-b9601e28b72b)

1. In dit scherm vindt u een applicatie met dezelfde naam als de App registration die u eerder heeft aangemaakt. Klik op de applicatie.

    ![image](https://github.com/Klantinteractie-Servicesysteem/.github/assets/104420825/baefd96c-e3a7-4ef6-abd7-d158a6bf1356)

1. Navigeer naar Users and groups, en klik op Add user/group.

    ![image](https://github.com/Klantinteractie-Servicesysteem/.github/assets/104420825/5c211af6-08eb-4511-b744-9ef4ea81d572)

1. In dit scherm kunt u de rollen die u eerder gedefinieerd heeft, toekennen aan individuele gebruikers en - als uw licentie van Active Directory dit toestaat - groepen.


## Koppelen van nieuwe bronnen
#### Environment variabelen
_**ZGW Zaaksysteem**_

Om KISS te koppelen aan een Zgw zaaksysteem (bijvoorbeeld Open Zaak) dienen de volgende variabelen per omgeving ingevuld te worden:


- ZAKEN_BASE_URL (de url van het zaak systeem, bv https://www.zaaksysteem.nl )
- ZAKEN_API_KEY (een door het zaaksysteem geleverde apikey voor KISS. Deze moet **minimaal 16 karakters** lang zijn)
- ZAKEN_API_CLIENT_ID (een door het zaaksysteem geleveerd Id voor KISS)

#### Externe registers
_**ZGW Zaaksysteem**_

Voor de autorisatie bij een zaaksysteem gaat KISS uit van een JWT token dat opgebouwd wordt volgens de specificaties die hier te vinden zijn: [https://open-zaak.readthedocs.io/en/latest/client-development/authentication.html](https://open-zaak.readthedocs.io/en/latest/client-development/authentication.html)



