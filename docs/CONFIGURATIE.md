# Configuratie
Bij de installatie van KISS worden er een groot aantal dingen al geconfigureerd. Op deze pagina staan verschillende onderdelen van de configuratie toegelicht.


## Configuratie t.b.v. Objecten API
KISS maakt voor de koppeling met verschillende registraties gebruik van de Objecten API. Om objecten van een bepaald objecttype op te kunnen halen, moet het de URL weten van dat objecttype in de Objecttype API. Zie ook [de Installatiehandleiding](https://kiss-klantinteractie-servicesysteem.readthedocs.io/en/latest/INSTALLATION/) en de [documentatie bij KISS-Elastic-Sync](https://github.com/Klantinteractie-Servicesysteem/KISS-Elastic-Sync/blob/main/README.md) 

### Authenticatie bij de Objecten API
In de meeste gevallen identificeert KISS zich bij de Objectenregistratie m.b.v. een TOKEN.
In sommige gevallen is het nodig om de authenticatie in de Objecten API, voor Afdelingen, Groepen en Interne Taken, Medewerkers in te regelen m.b.v. een client secret en een client id. Dit is bv. het geval als je KISS gebruikt i.c.m. de e-Suite. Afhankelijk van de situatie moet je dus een Token inregelen, en in andere gevallen een id+secret. **NOOIT ALLEBEI!**

Dit heeft invloed op de volgende Environment Variabelen: 

- Bij gebruik in combinatie met OverigeObjecten met een in OverigeObjecten ingesteld token<br/> 
INTERNE_TAAK_TOKEN

- Bij gebruik in combinatie met de e-suite, met een in de e-suite ingesteld secret en id<br/> 
INTERNE_TAAK_CLIENT_SECRET<br/> 
INTERNE_TAAK_CLIENT_ID

- Bij gebruik in combinatie met OverigeObjecten met een in OverigeObjecten ingesteld token<br/> 
MEDEWERKER_OBJECTEN_TOKEN

- Bij gebruik in combinatie met de e-suite, met een in de e-suite ingesteld secret en id
MEDEWERKER_OBJECTEN_CLIENT_SECRET <br/> MEDEWERKER_OBJECTEN_CLIENT_ID 

### URL configureerbaar
Voor een aantal objecttypen kunt u de URL van het objecttype instellen m.b.v. environment variabelen. 

| Variabele |  Toelichting |
|---|---|
| INTERNE_TAAK_OBJECT_TYPE_URL |  De interne taak is onderdeel van een Contactverzoek |
| INTERNE_TAAK_TYPE_VERSION | De versie van het objecttype die gebruikt wordt in de API-aanroepen. Standaard ingesteld op `1`. |
| GROEPEN_OBJECT_TYPE_URL | Objecttype dat gebruikt wordt om Groepen op te halen <br/> voor gebruik in Contactverzoeken |
| AFDELINGEN_OBJECT_TYPE_URL | Objecttype dat gebruikt wordt om Afdelingen op te halen <br/>voor gebruik in Contactverzoeken, Formulieren <br />contactverzoek en registratie van Contactmomenten  |
| SDG_OBJECT_TYPE_URL | Objecttype dat gebruikt wordt om Kennisartikelen op te halen; <br/>dit objecttype is gebaseerd op het object `product` <br />in de SDG Invoervoorziening |

### URL nog niet configureerbaar
Voor een aantal objecttype is de URL nog niet configureerbaar. In die gevallen zal KISS zelf de Objecttype API gaan bevragen om de URL op te halen. Hiervoor is het van belang dat de objecttypen in uw registratie de juiste naam hebben.

| Naam Objecttype |  Toelichting |
|---|---|
| VAC | Dit zijn de Vraag Antwoord Combinaties die via Elasticsearch ontsloten worden. |
| Medewerker | Dit zijn de medewerkers die via Elasticsearch ontsloten worden. <br />Deze medewerkers worden ook gebruikt in Contactverzoeken |


## Configuratie van uw Identity Provider
Bij de installatie van KISS regelt u de koppeling met uw OpenIDConnect Identity Provider. Daarnaast moet u in uw Identity Provider configureren dat gebruikers die in moeten kunnen loggen bij KISS in ieder geval een 'klantcontactmedewerker'-rol hebben. Een rol is in dit geval een claim van het type `role` of `roles` (beiden worden ondersteund). De waarde die correspondeert met een kiss-medewerker kunt u instellen tijdens de installatie. Standaard is dit `Klantcontactmedewerker`. Voor medewerkers die beheertaken op KISS uitvoeren, is een aparte rol ingeregeld. Ook de naam van deze rol kunt u instellen tijdens de installatie. Standaard is dit `Redacteur`. 

### Claims uit uw Identity provider
KISS gebruikt de claims uit uw Identity Provider om de gegevens van de ingelogde Klantcontactmedewerker toe te voegen aan de Contactmomenten en Contactverzoeken die vanuit KISS worden geregistreerd.
Zie [de installatiehandleiding](INSTALLATION.md#Authenticatie) voor hoe u dit configureert.

Er is in JWT geen standaard claim voor voorletters of voorvoegsel (tussenvoegsel). KISS gebruikt daarom deze mapping:
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


## Configuratie van Elasticsearch voor KISS
Met behulp van [KISS-Elastic-Sync tool](https://github.com/Klantinteractie-Servicesysteem/KISS-Elastic-Sync) is het mogelijk om websites en een aantal gestructureerde bronnen doorzoekbaar te maken vanuit KISS. De eerste keer dat u deze tool gebruikt, wordt er een meta-engine aangemaakt met de naam `kiss-engine`.

### Crawler
Het doorzoeken van een website binnen KISS wordt mogelijk door de website te crawlen vanuit Elastic Search. Hiervoor gebruikt u de [KISS-Elastic-Sync tool](https://github.com/Klantinteractie-Servicesysteem/KISS-Elastic-Sync). Het is aan te raden om verder overleg te hebben met uw websitebeheerder, over het verdere finetunen van de crawler. Mogelijk zijn er aanpassingen nodig in uw robots.txt, is het raadzaam een KISS-specifieke sitemap.xml op te stellen of zijn er aanvullende filterinstellingen nodig. 

Op het moment dat de crawler de eerste keer gedraaid heeft, wordt het engine schema uitgebreid met de [velden die horen bij de crawler](https://www.elastic.co/guide/en/app-search/current/web-crawler-reference.html#web-crawler-reference-web-crawler-schema).

### Syncen van bronnen
De eerste keer dat er via de synctool Kennisartikelen (PDC-producten), Medewerkers of VACs worden geindexeerd in Elastic, wordt het Engine Schema uitgebreid met een aantal velden. Dit zijn: 
- `object_bron`
- `object_meta`

- De velden die bij de bron horen: voor elk property in het schema van de bron, wordt een property aangemaakt binnen de KISS-engine, voorafgegaan door de waarde van `objectbron`. 

### Relevance Tuning
Om de informatie uit de Kennisartikelen en websites doorzoekbaar te maken, moeten deze velden opgenomen zijn in het Engine Schema, en doorzoekbaar gezet in de Relevance tuning. Let op: zijn er nieuwe velden toegevoegd aan het Engine Schema, bijvoorbeeld omdat er een nieuw type bron wordt toegevoegd? Dan moeten deze velden doorzoekbaar gemaakt worden, door op knop 'Update search settings' te klikken, op de pagina Manage engine schema. U kunt ook op de pagina Relevance Tuning aangeven dat een schemaveld doorzoekbaar moet zijn. 

Om de zoekresultaten te beïnvloeden, moet u vervolgens de Relevance Tuning instellen. [Zie ook de documentatie van Elasticsearch](https://www.elastic.co/guide/en/app-search/current/relevance-tuning-guide.html)

Elasticsearch zal binnen de meta-engine voor elk property van een object (een VAC, een medewerker of een Kennisartikel) een property aanmaken. Bijvoorbeeld `Kennisartikel.vertalingen.bezwaarEnBeroep` of `VAC.trefwoorden.trefwoord`. Elasticsearch zal ook zelf voor deze property's aangeven of ze doorzoekbaar moeten zijn of niet. Websitepagina's worden door de crawler aan de meta-engine toegevoegd, en zijn vindbaar via de velden van [het crawler-schema](https://www.elastic.co/guide/en/app-search/8.9/web-crawler-reference.html#web-crawler-reference-web-crawler-schema).

Door vervolgens de relevantie van specifieke velden hoger te zetten, kunt u ervoor zorgen dat deze zwaarder meetellen in het zoekresultaat. Door de properties `VAC.trefwoorden.trewoord`, en `Kennisartikel.vertalingen.trefwoorden.trefwoord` hogere relevantiescore te geven, zullen de trefwoorden zwaarder meetellen.  

Doordat elke bron eigen properties krijgt in de meta-engine, kunt u specifieke bronnen zwaarder laten wegen. Als `VAC.trefwoorden.trewoord` een hogere relevantiescore heeft dan `Kennisartikel.vertalingen.trefwoorden.trefwoord`, zullen de VAC's hoger in het zoekresultaat staan.

Alle property's van het type text worden standaard doorzoekbaar gemaakt. Het is raadzaam deze standaard instellingen na te lopen. Vooral bij Kennisartikelen (waarvan het object gebaseerd is op de API van de SDG invoervoorziening) zijn er veel text property's, die niet relevant zijn voor de zoekresultaten.
