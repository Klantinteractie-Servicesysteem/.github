# Handleiding voor het upgraden van Elasticsearch, Kibana en EnterpriseSearch 

## Van versie 7.17.6 naar 8.9.0

### Stap 1: Controleer en los kritieke fouten op in Kibana Upgrade Assistant

Voordat u de upgrade uitvoert, moet u alle kritieke fouten in Kibana's Upgrade Assistant oplossen. 

[Voorbeeld overview](https://kibana.dev.kiss-demo.nl/app/management/stack/upgrade_assistant/overview).
![image](https://raw.githubusercontent.com/Klantinteractie-Servicesysteem/.github/main/docs/images/elastic-criticals-kibana.png)

### Stap 2: PowerShell Script

Een PowerShell-script wordt gebruikt om de kritieke fouten op te lossen. Hier is de [PowerShell-script voor de patch](https://github.com/Klantinteractie-Servicesysteem/.github/blob/main/docs/scripts/elastic/patch-criticals.ps1). Let op: het is cruciaal dat u de token in dit PowerShell-script aanpast naar een recente token.
<br><br>
### Stap 3: Verkrijgen van een nieuwe token

Een nieuwe token kunt u verkrijgen door een call naar Elasticsearch te doen. Dit kan via Kibana Dev Tools of Postman. 
![image](https://raw.githubusercontent.com/Klantinteractie-Servicesysteem/.github/main/docs/images/elastic-token-postman.png)

### Stap 4: Voer het PowerShell-script uit

Het uitgevoerde script zal wijzigingen aanbrengen in de YAML-bestanden in het cluster.

### Stap 5: Voer de upgrade uit

Zodra alle kritieke fouten zijn opgelost, kunt u de upgrade naar versie 8.9.0 uitvoeren. Het upgrade-script zal ervoor zorgen dat de images in AKS worden bijgewerkt. Hier is de [PowerShell-script voor de upgrade](https://github.com/Klantinteractie-Servicesysteem/.github/blob/main/docs/scripts/elastic/upgrade-elastic.ps1).

### Stap 6: Geef Kibana tijd om op te starten

Na het uitvoeren van de upgrade, moet u Kibana enige tijd geven om op te starten. De Enterprise Search-pod kan mogelijk niet direct meegaan vanwege aanstaande migraties. 

![image](https://raw.githubusercontent.com/Klantinteractie-Servicesysteem/.github/main/docs/images/elastic-migrations.png)

### Stap 7: Voer de port forward uit

Om de migraties uit te voeren, moet EnterpriseSearch in 'alleen-lezen' modus worden gezet. Dit kan worden gedaan door een API-call te maken naar de bestaande pod van Enterprise Search. Dit kan worden gedaan door de pod te portforwarden. 

![image](https://raw.githubusercontent.com/Klantinteractie-Servicesysteem/.github/main/docs/images/elastic-port-forward.png)

### Stap 8: Voer de migraties uit

Zodra het portforwarden succesvol is voltooid, kunt u de API-aanroep uitvoeren naar de bestaande pod van Enterprise Search door deze op 'alleen-lezen' te zetten.

![image](https://raw.githubusercontent.com/Klantinteractie-Servicesysteem/.github/main/docs/images/elastic-read-only.png)

### Stap 9: Wacht tot de pod de migraties uitvoert en de oude pod afsluit

Na het uitvoeren van de migraties, moet u even wachten tot de pod de migraties heeft voltooid en de oude pod heeft afgesloten.
<br><br>
### Stap 10: Zet 'alleen-lezen' op false

Doe een port forward naar de nieuwe pod en zet 'alleen-lezen' op 'false'.

Zodra alle stappen zijn voltooid, zou de upgrade van Elasticsearch, Kibana en EnterpriseSearch naar versie 8.9.0 succesvol moeten zijn. 
