## Trouble shooting guide
In dit document houden we bij tegen welke problemen mensen zijn aangelopen bij het installeren van KISS in een gemeentelijk K8S-cluster.

### Open Diensten-producten accepteren geen gebufferde berichten
KISS stuurt berichten gebufferd weg, zonder informatie over content-length. In ons eigen dev-cluster zit er een Ngingx-controller tussen KISS en de onderliggende registers. Die pakt de gebufferde berichten op en zorgt er voor dat deze mét een content-length-indicate naar de OpenDiensten-registers gaan. 

Dit blijkt ook nodig: registers als OpenObjecten en OpenKlant vereisen informatie over content-length in de berichten. Is die er niet, dan komen er foutmeldingen (die soms moeilijk te plaatsen zijn). 

Gezien bij: 
- Een gemeente die een anderen ingress-controler gebruikte dan Nginx, liep tegen onduidelijke foutmeldingen aan bij het registreren van Klantcontacten
- Een gemeente die een vergelijkbare situatie had bij het wegschrijven van nieuwe VACs in Objecten.
