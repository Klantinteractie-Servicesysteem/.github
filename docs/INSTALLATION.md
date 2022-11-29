# Installatie handleiding

De installatie van KISS bestaat uit drie primaire stappen

1. Installeren backend for frontend (common gateway)
2. Installeren frontend
3. Basale applicatie configuratie

We raden aan om gebruikt te maken van de HELM installatie voor kubernetes waarin bovenstaande stappen zijn geautomatiseerd.

De speciefieke stappen van de installatie hangen af van de omgeving waarop u KISS wilt installeren. Op dit moment ondersteunen we 3 omgevingen

1. Kubernetes (haven)
2. Linux Machine
3. De kiss plugin toevoegen aan een reeds bestaande common gateway installatie

## Kubernetes (haven)

Voor installatie op een haven omgeving zijn helm installatie bestanden beschikbaar op [Artifacthub]().

Deze kunnen handmatige worden geïnstalleerd via een helm commando `helm install .....` of via een beheerstool zo als [Rancher](https://www.rancher.com/),[Openshift](https://www.redhat.com/en/technologies/cloud-computing/openshift), [Otomi](https://redkubes.com/category/otomi/) of [Dashkube](https://www.dashkube.com/).

Alle bovenstaande opties laten het toe om tijdens de installatie keuzes te maken met betrekking tot wat er in de installatie word geïnstalleerd of wellicht al beschikbaar is binnen de organisatie (b.v. Elastic) en geven keuzes met betrekking tot database (MySQL, Postgress, MonoDb, CloudDB, MSSQL, Oracle DB). Meer informatie over de installatie opties en hoe deze te gebruiken vind u op artifacthub.

Na installatie op kubernetes hoeven de basis configuratie stappen alleen te worden uitgevoerd als het een productie omgeving betreft. En kan de stap koppelen Elastic worden overgeslagen (tenzij er binnen de installatie voor gekozen is om Elastic  niet mee te installeren)

## Linux (LAMP)

Het installeren van KISS op een  Linux omgeving vereist enig handwerk

- a. Randvoorwaarden: Een LAMP machine met daarop:
  - Linux: [min versie]
  - [Apache](https://ubuntu.com/tutorials/install-and-configure-apache#1-overview): [^2.4]
  - [MySQL](https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-20-04): [^5.7]
  - [PHP](https://www.php.net/manual/en/install.unix.debian.php): [^7.4.0] + extensies
  - [Composer](https://getcomposer.org/download/): [^2.4.0]
  - [NPM](https://www.npmjs.com/package/npm): [^9.1]
- [Elastic serach](https://www.elastic.co/) lokaal of als SAAS  (het is mogelijk om Elastic op de zelfde linux machine te draaien maar niet aanbevolen)
- Een OAuth2 compatible identity provider, bijvoorbeeld [DEX](https://dexidp.io/), [KeyCloack](https://www.keycloak.org/) of ADFS

1. Log in op de bovenstaande lamp machine
2. Navigeer naar de www map (doorgaans var/www) `$cd var/www`
3. Maak een directory voor de gateway aan `$ mkdir gateway` en navigeer daar in `cd gateway`
4. Installeer de gateway met `$ composer install klantinteractie-servicesysteem/kiss-bundle`
5. Ga naar var/www/gateway/config/packadges/doctrine.yaml en geef de [db credentails van mysql op](https://www.doctrine-project.org/projects/doctrine-dbal/en/latest/reference/configuration.html)
6. Ga terug naar de hoofdmap `$cd var/www`
7. Maak een directory voor de frontend aan `$ mkdir frontend` en navigeer daar in `cd frontend`
8. Installeer de frontend met het commando `npm install Klantinteractie-Servicesysteem/KISS-frontend`
8. Draai de frontend met het commando `npm run`

Voer vervolgens de basis configuratie stappen uit.

## Toevoegen aan een bestaande Common Gateway installatie

Ga in het hoofd menu naar plugins en vervolgens plugin toevoegen. Zoek de plugin genaamd "Klantinteractie Service systeem" en klik op toevoegen.

Voor vervolgens alleen de basis configuratie stappen uit voor registers die u nog niet in het verleden hebt gekoppeld aan uw gateway

Let op! Dit voegt alleen de onderliggende services voor KISS toe. Voor het draaien van de applicatie zal de frontend nog los moeten worden geïnstalleerd. Zie daarvoor de [frontend documentatie](https://github.com/Klantinteractie-Servicesysteem/KISS-frontend).

## Basis configuratie

KISS vereist minimaal een aantal configuratie handelingen na de installatie om te kunnen werken, deze kunnen worden verricht via de gateway admin UI

1. Elasstic search moet worden ingesteld (altijd)
   1. Tijden de installatie is een source aangemaakt voor elastic en toegevoegd aan het dashboard van de Admin UI. Open deze source en voorzie hem van de jusite instellingen voor ellastic op uw omgeving. Onder [configuratie](/docs/CONFIGURATIE.md) kunt u meer informatie vinden over het instellen van sources
   2. Activeer de elastic acties, ga naar acties onder het hoofdmenu van de gateway ui. In de lijst voor u ziet u een aantal acties met Elastic in de naam. Deze staan na de installatie op niet actief (ellastic is immers nog niet gekoppeld). Open de betreffende acties en zet ze op actief.
   3. Activeer de elastic search proxy, ga naar endpoints onder het hoofdmenu. In de lijst voor us ziet u een aantaal endpoint met Elastic in de naam. Deze staan na de installatie op niet actief (ellastic is immers nog niet gekoppeld). Open de betreffende endpoints en zet ze op actief.
4. Koppelen van ZGW en Klanten API (alleen productie)
   1. Ga naar sources in het hoofdmenu
   2. Open de betreffende sources (met ZGW en/of Klant in de naam), vul de verbindingsgegevens in, test de verbinding en zet deze DAARNA op actief
   3. Ga naar acties in het hoofdmenu
   4. Open en activeer de acties met ZGW en Klant in de naam
5. Koppelen SDG  (Optioneel)
6. Koppelen OpenPUB (Optioneel)
7. Koppelen Handels Registers, Basis Administratie Gebouwen en Basisregistratie Personen
   1. Ga naar sources in het hoofdmenu
   2. Open de betreffende sources (met BRP, BAG, KVK HR in de naam), vul de verbindingsgegevens in, test de verbinding en zet deze DAARNA op actief
   3. Ga naar acties in het hoofdmenu
   4. Open en activeer de acties met BRP, BAG, KVK HR in de naam

## Geavenceerde configuratie

Het is ook mogenlijk om KISS te koppelen aan zaaksystemen aan de hand van ZDS, STUFF, VrijBRP-STUFF, SIM XML of XLLNCE API. Hiervoor zijn diverse opensource plugins beschickbaar. Kijk in uw admin UI dashboard onder plugins voor meer informatie en de mogenlijkheden van deze plugins.

Ook kunt u zelf (handmatig) bronnen koppelen aan de hand van JSON, XML en SOAP api's. Meet informatie daarover vind u bij configuratie onder bronnen.

## Installatie WordPress plugin voor Openpub

Om publicaties te beheren via een WordPress omgeving, kan de op maat gemaakte Openpub WordPress plugin geïnstalleerd worden.

_Nog niet eerder met WordPress plugins gewerkt? Lees hier de [officiele documentatie](https://wordpress.org/support/article/managing-plugins/)._

1. [Download hier](https://github.com/Klantinteractie-Servicesysteem/Openpub/tree/master/plugins/OpenPub) de Openpub plugin
2. Volg vervolgens de [Openpub plugin installatie stappen](https://github.com/Klantinteractie-Servicesysteem/Openpub#readme)
