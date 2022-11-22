# Installatie handleiding
De installatie van KISS bestaat uit drie primaire stappen
1. Installeren backend for frontend (Common Gateway)
2. Installeren frontend 
3. Basale applicatie configuratie

We raden aan om gebruikt te maken van de HELM-installatie voor Kubernetes waarin bovenstaande stappen zijn geautomatiseerd.

De specifieke stappen van de installatie hangen af van de omgeving waarop u KISS wilt installeren. Op dit moment ondersteunen we 3 omgevingen
1. Kubernetes (haven)
2. Linux Machine
3. De KISS-plugin toevoegen aan een al bestaande common gateway installatie

## Kubernetes (haven)
Voor installatie op een haven omgeving zijn helm installatie bestanden beschikbaar op [Artifacthub](). 

Deze kunnen handmatige worden geïnstalleerd via een helm commando `helm install .....` of via een beheertool zo als [Rancher](https://www.rancher.com/),[Openshift](https://www.redhat.com/en/technologies/cloud-computing/openshift), [Otomi](https://redkubes.com/category/otomi/) of [Dashkube](https://www.dashkube.com/).

Alle bovenstaande opties laten het toe om tijdens de installatie keuzes te maken met betrekking tot wat er in de installatie wordt geïnstalleerd of wellicht al beschikbaar is binnen de organisatie (b.v. Elastic) en geven keuzes met betrekking tot database (MySQL, PostgreSQL, MongoDB, CloudDB, MSSQL, Oracle DB). Meer informatie over de installatie opties en hoe deze te gebruiken vindt u op Artifact Hub.

Na installatie op Kubernetes hoeven de basis configuratie stappen alleen te worden uitgevoerd als het een productieomgeving betreft. En kan de stap koppelen Elastic worden overgeslagen (maar niet als er binnen de installatie voor gekozen is om Elastic  niet mee te installeren)

## Linux (LAMP)
Het installeren van KISS op een  Linux omgeving vereist enig handwerk
- a.	Randvoorwaarden: Een LAMP machine met daarop:
  - Linux: [min versie]
  - [Apache](https://ubuntu.com/tutorials/install-and-configure-apache#1-overview): [^2.4]
  - [MySQL](https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-20-04): [^5.7]
  - [PHP](https://www.php.net/manual/en/install.unix.debian.php): [^7.4.0] + extensies
  - [Composer](https://getcomposer.org/download/): [^2.4.0]
  - [NPM](https://www.npmjs.com/package/npm): [^9.1]
- [Elasticsearch](https://www.elastic.co/) lokaal of als SAAS  (het is mogelijk om Elastic op dezelfde Linuxmachine te draaien, maar niet aanbevolen)
- Een OAuth2 compatible identity provider, bijvoorbeeld [DEX](https://dexidp.io/), [Keycloak](https://www.keycloak.org/) of ADFS

1. Log in op de bovenstaande lamp machine 
2. Navigeer naar de www map (doorgaans var/www) `$cd var/www`
3. Maak een directory voor de gateway aan `$ mkdir gateway` en navigeer daar in `cd gateway`
4. Installeer de gateway met `$ composer install klantinteractie-servicesysteem/kiss-bundle`
5. Ga naar var/www/gateway/config/packages/doctrine.yaml en geef de [db credentials van MySQL op](https://www.doctrine-project.org/projects/doctrine-dbal/en/latest/reference/configuration.html)
6. Ga terug naar de hoofdmap `$cd var/www`
7. Maak een directory voor de frontend aan `$ mkdir frontend` en navigeer daar in `cd frontend`
8. Installeer de frontend met het commando `npm install Klantinteractie-Servicesysteem/KISS-frontend`
8. Draai de frontend met het commando `npm run`



Voer vervolgens de basis configuratie stappen uit.

## Toevoegen aan een bestaande Common Gateway installatie
Ga in het hoofdmenu naar plug-ins en vervolgens plug-in toevoegen. Zoek de plug-in genaamd "Klantinteractie Service systeem" en klik op toevoegen. 

Voor vervolgens alleen de basis configuratie stappen uit voor registers die u nog niet in het verleden hebt gekoppeld aan uw gateway

Let op! Dit voegt alleen de onderliggende services voor KISS toe. Voor het draaien van de applicatie zal de frontend nog los moeten worden geïnstalleerd. Zie daarvoor de [frontend documentatie](https://github.com/Klantinteractie-Servicesysteem/KISS-frontend).

## Basis configuratie
KISS vereist minimaal een aantal configuratie handelingen na de installatie om te kunnen werken, deze kunnen worden verricht via de gateway admin UI

1. Elasticsearch moet worden ingesteld (altijd)
   1. Tijden de installatie is een source aangemaakt voor Elastic en toegevoegd aan het dashboard van de Admin UI. Open deze source en voorzie hem van de juiste instellingen voor Elastic op uw omgeving. Onder [configuratie](/docs/CONFIGURATIE.md) kunt u meer informatie vinden over het instellen van sources
   2. Activeer de Elastic acties, ga naar acties onder het hoofdmenu van de gateway ui. In de lijst voor u ziet u een aantal acties met Elastic in de naam. Deze staan na de installatie op niet actief (Elastic is immers nog niet gekoppeld). Open de betreffende acties en zet ze op actief.
   3. Activeer de Elasticsearch proxy, ga naar endpoints onder het hoofdmenu. In de lijst voor u ziet u een aantal endpoints met Elastic in de naam. Deze staan na de installatie op niet actief (Elastic is immers nog niet gekoppeld). Open de betreffende endpoints en zet ze op actief.
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

## Geavanceerde configuratie
Het is ook mogelijk om KISS te koppelen aan zaaksystemen aan de hand van ZDS, STUFF, VrijBRP-STUFF, SIM XML of XLLNCE API. Hiervoor zijn diverse opensource plug-ins beschikbaar. Kijk in uw admin UI-dashboard onder plug-ins voor meer informatie en de mogelijkheden van deze plug-ins.

Ook kunt u zelf (handmatig) bronnen koppelen aan de hand van JSON, XML en SOAP API’s. Meet informatie daarover vindt u bij configuratie onder bronnen. 
