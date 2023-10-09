## Klantinteractie Servicesysteem (KISS)
### Onderhoud
Onderhoud, wijzigingen en nieuwe features binnen de applicatie worden middels een Pull Request aangeboden.
Deze wordt gereviewed en na acceptatie doorgezet naar main. 

Het kan voorkomen dat er een wijziging is in de configuratie van de omgevings variablen.
Er bestaan 2 soorten: zichtbare, en geheime variabelen.
In de KISS Helm configuratie zijn dit respectievelijk ConfigMaps en Secrets. (zie [install_kiss.ps1](https://github.com/Klantinteractie-Servicesysteem/.github/blob/main/docs/scripts/install_kiss.ps1))

### Helm configuratie aanpassen

1. Voeg toe/ pas aan / verwijder de variabel in helm/kiss-frontend/values.yaml
2. Hoog 'version' op in helm/kiss-frontend/Chart.yaml
3. Clone de helm folder op https://github.com/Klantinteractie-Servicesysteem/KISS-frontend/tree/main/helm
4. Voer de volgende commando's uit in een terminal in de helm folder:
    ```
    helm package .\kiss-frontend\
    helm repo index .
    ```
5. Update INSTALLATION.MD
6. Commit de aanpassingen in een nieuwe branch en deponeer een Pull Request

Na review en akkoord wordt de branch en helm config doorgzet naar main.