# Configuratie
Bij de installatie van KISS worden er een groot aantal dingen al geconfigureerd. Op deze pagina staan verschillende onderdelen van de configuratie toegelicht.


## Configuratie van uw Identity Provider
Bij de installatie van KISS regelt u de koppeling met uw OpenIDConnect Identity Provider. Daarnaast moet u in uw Identity Provider configureren dat gebruikers die in moeten kunnen loggen bij KISS in ieder geval een 'klantcontactmedewerker'-rol hebben. Een rol is in dit geval een claim van het type `role` of `roles` (beiden worden ondersteund). De waarde die correspondeert met een kiss-medewerker kunt u instellen tijdens de installatie. Standaard is dit `Klantcontactmedewerker`. Voor medewerkers die beheertaken op KISS uitvoeren, is een aparte rol ingeregeld. Ook de naam van deze rol kunt u instellen tijdens de installatie. Standaard is dit `Redacteur`. 

### Claims uit uw Identity provider
KISS gebruikt de claims uit uw Identity Provider om de gegevens van de ingelogde Klantcontactmedewerker toe te voegen aan de Contactmomenten en Contactverzoeken die vanuit KISS worden geregistreerd. Er is in JWT geen standaard claim voor voorletters of voorvoegsel (tussenvoegsel). KISS gebruikt daarom deze mapping:

- Voorletters => given_name
- Achternaam => family_name indien beschikbaar, anders name indien beschikbaar, anders http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name
- Op dit moment doen we niets met Tussenvoegsel, omdat er geen voorvoegsel-claim bestaat. In de huidige implementatie komt tussenvoegsel alleen in het contactoment, als het onderdeel is van de Achternaam.

### Voorbeeldinrichting in Azure Active Directory
Als u gebruik maakt van Azure Active Directory als Identity Provider, kunt u dit op de volgende manier inrichten.
1. Bij de installatie van KISS heeft u een App Registration aangemaakt. Ga binnen Azure AD naar App registrations en klik op de applicatie.

<img src="https://raw.githubusercontent.com/Klantinteractie-Servicesysteem/.github/main/docs/images/AzureAD-01.png" />

  
1. Navigeer naar App roles, kies Create app role en vul de benodigde velden in. Belangrijk is dat u kiest voor Users/Groups bij Allowed member types en bij Value kiest voor de rol die u bij de installatie geconfigureerd hebt (standaard `Klantcontactmedewerker`).

    ![image](https://raw.githubusercontent.com/Klantinteractie-Servicesysteem/.github/main/docs/images/AzureAD-02.png)

1. Herhaal de vorige stap voor de rol die u tijdens de installatie heeft geconfigureerd voor medewerkers die beheertaken uitvoeren (standaard `Redacteur`)
1. Nu kunt u deze rollen toekennen aan gebruikers of groepen uit uw organisatie. Hiervoor moet u eerst terug naar Azure Active Directory. Navigeer daar naar Enterprise applications.

    ![image](https://raw.githubusercontent.com/Klantinteractie-Servicesysteem/.github/main/docs/images/AzureAD-03.png)

1. In dit scherm vindt u een applicatie met dezelfde naam als de App registration die u eerder heeft aangemaakt. Klik op de applicatie.

    ![image](https://raw.githubusercontent.com/Klantinteractie-Servicesysteem/.github/main/docs/images/AzureAD-04.png)

1. Navigeer naar Users and groups, en klik op Add user/group.

    ![image](https://raw.githubusercontent.com/Klantinteractie-Servicesysteem/.github/main/docs/images/AzureAD-05.png)

1. In dit scherm kunt u de rollen die u eerder gedefinieerd heeft, toekennen aan individuele gebruikers en - als uw licentie van Active Directory dit toestaat - groepen.



## Koppelen van nieuwe bronnen
### Environment variabelen
_**Organisatie Id voor ZGW APIs**_
Verschillende ZGW APIs, waaronder de Klant en Contactmoment APIs, vragen om een identificatienummer van de organisatie.
- ORGANISATIE_IDS (valide RSIN nummer)

_**ZGW Zaaksysteem**_

Om KISS te koppelen aan een Zgw zaaksysteem (bijvoorbeeld Open Zaak) dienen de volgende variabelen per omgeving ingevuld te worden:


- ZAKEN_BASE_URL (de url van het zaak systeem, bv https://www.zaaksysteem.nl )
- ZAKEN_API_KEY (een door het zaaksysteem geleverde apikey voor KISS. Deze moet **minimaal 16 karakters** lang zijn)
- ZAKEN_API_CLIENT_ID (een door het zaaksysteem geleveerd Id voor KISS)

### Externe registers
_**ZGW Zaaksysteem**_

Voor de autorisatie bij een zaaksysteem gaat KISS uit van een JWT token dat opgebouwd wordt volgens de specificaties die hier te vinden zijn: [https://open-zaak.readthedocs.io/en/latest/client-development/authentication.html](https://open-zaak.readthedocs.io/en/latest/client-development/authentication.html)
## Configuratie van Elasticsearch voor KISS
Met behulp van [KISS-Elastic-Sync tool](https://github.com/Klantinteractie-Servicesysteem/KISS-Elastic-Sync) is het mogelijk om websites en een aantal gestructureerde bronnen doorzoekbaar te maken vanuit KISS. De eerste keer dat u deze tool gebruikt, wordt er een engine aangemaakt met de naam `kiss-engine`.

### Crawler
Het doorzoeken van een website binnen KISS wordt mogelijk door de website te crawlen vanuit Elastic Search. Hiervoor gebruikt u de [KISS-Elastic-Sync tool](https://github.com/Klantinteractie-Servicesysteem/KISS-Elastic-Sync). Het is aan te raden om verder overleg te hebben met uw websitebeheerder, over het verdere finetunen van de crawler. Mogelijk zijn er aanpassingen nodig in uw robots.txt, of zijn er aanvullende filterinstellingen nodig. 

Op het moment dat de crawler de eerste keer gedraaid heeft, wordt het engine schema uitgebreid met de [velden die horen bij de crawler](https://www.elastic.co/guide/en/app-search/current/web-crawler-reference.html#web-crawler-reference-web-crawler-schema).

### Syncen van bronnen
De eerste keer dat er via de synctool Kennisartikelen (PDC-producten), Medewerkers of VACs worden geindexeerd in Elastic, wordt het Engine Schema uitgebreid met een aantal velden. Dit zijn: 
- `object_bron`
- `object_meta`
- De velden die bij de bron horen.

### Relevance Tuning
Om de informatie uit de Kennisartikelen en websites doorzoekbaar te maken, moeten deze velden opgenomen zijn in het Engine Schema. Let op: zijn er nieuwe velden toegevoegd aan het Engine Schema, bijvoorbeeld omdat er een nieuw type bron wordt toegevoegd? Dan moeten deze velden doorzoekbaar gemaakt worden. Dit kunt u doen m.b.v. de knop 'Update search settings' op de pagina Manage engine schema. U kunt ook op de pagina Relevance Tuning aangeven dat een schemaveld doorzoekbaar moet zijn. 

Om de zoekresultaten te beïnvloeden, moet u vervolgens de Relevance Tuning instellen.

[Zie de documentatie van Elasticsearch](https://www.elastic.co/guide/en/app-search/current/relevance-tuning-guide.html)
