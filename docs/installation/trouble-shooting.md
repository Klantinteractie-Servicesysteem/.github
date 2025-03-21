## Trouble shooting guide
In dit document houden we bij tegen welke problemen mensen zijn aangelopen bij het installeren van KISS in een gemeentelijk K8S-cluster.

### Open Diensten-producten accepteren geen gebufferde berichten
#### Symptoom
Post en Put berichten lijken leeg. 
#### Mogelijke oorzaak
KISS stuurt berichten in chunks weg. Dat is standaard gedrag van het framework waarop ontwikkeld wordt en conform de standaarden. In ons eigen dev-cluster zit er een Ngingx-controller tussen KISS en de onderliggende registers. Deze buffert standaard berichten en zorgt er voor dat deze mét een content-length-indicate naar de OpenDiensten-registers gaan. 

Dit blijkt ook nodig: registers als OpenObjecten en OpenKlant, Die op het Django framework zijn gebouwd, kunnen de berichten anders niet verwerken. 

Gezien bij: 
- Een gemeente die een anderen ingress-controler gebruikte dan Nginx, liep tegen onduidelijke foutmeldingen aan bij het registreren van Klantcontacten
- Een gemeente die een vergelijkbare situatie had bij het wegschrijven van nieuwe VACs in Objecten.
