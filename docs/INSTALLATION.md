# Installatie handleiding
De installatie van KISS bestaad uit twee primaire stappen
1. Het installeren van de software
2. Een basis configuratie van de ssoftware

Er Met betrekking tot het installeren van de software zijn er twee manieren om KISS te installeren.

## Kubernetes (haven)
Voor installatie op een haven omgeving zijn helm installatie bestanden beschikbaar op Artifacthub. 

## Linux (LAMP)
Het installeren van KISS op een  Linux omgeving vereist enig handwerk
- a.	Randvoorwaarden: Een LAMP machine met daarop:
  - Linux: [min versie]
  - Apache: [min versie]
  - MySQL: [min versie]
  - PHP: [min versie] + extensies
  - Composer: [{min versie] installatie handleiding()
- [Elastic serach](https://www.elastic.co/) locaal of als saas
- Een OAuth2 compatable identity provider, bijvoorbeeld [DEX](https://dexidp.io/), [KeyCloack](https://www.keycloak.org/) of ADFS

## Basis configuratie
KISS vereist minimaal een aantal configuraite handelingen na de installatie om te kunnen werken, deze kunnen worden verricht via de gateway admin UI

1. Elasstic search moet worden ingesteld (altijd)
   1. Tijden de installatie is een source aangemaakt voor elastic en toegevoegd aan het dashboard van de Admin UI. Open deze source en voorzie hem van de jusite instellingen voor ellastic op uw omgeving. Onder [configuratie](/docs/CONFIGURATIE.md) kunt u meer informatie vinden over het instellen van sources
   2. Activeer de elastic acties, ga naar acties onder het hoofdmenu van de gateway ui. In de lijst voor u ziet u een aantal acties met Elastic in de naam. Deze staan na de installatie op niet actief (ellastic is immers nog niet gekoppeld). Open de betreffende acties en zet ze op actief.
   3. Activeer de elastic search proxy, ga naar endpoints onder het hoofdmenu. In de lijst voor us ziet u een aantaal endpoint met Elastic in de naam. Deze staan na de installatie op niet actief (ellastic is immers nog niet gekoppeld). Open de betreffende endpoints en zet ze op actief.
4. Koppelen van ZGW en Klanten API (alleen productie)
   1. Ga naar sources in het hoofdmenu
   2. Open de betreffende sources (met ZGW en/of Klant in de naam), vul de verbindgsgegevens in, test de verbinding en zet deze DAARNA op actief
   3. Ga naar acties in het hoofdmenu
   4. Open en activeer de acties met ZGW en Klant in de naam
5. Koppelen SDG  (Optioneel)
6. Koppelen OpenPUB (Optioneel)
7. Koppelen Handels Registers, Basis Administratie Gebouwen en Basisregistratie Personen
   1. Ga naar sources in het hoofdmenu
   2. Open de betreffende sources (met BRP, BAG, KVK HR in de naam), vul de verbindgsgegevens in, test de verbinding en zet deze DAARNA op actief
   3. Ga naar acties in het hoofdmenu
   4. Open en activeer de acties met BRP, BAG, KVK HR in de naam