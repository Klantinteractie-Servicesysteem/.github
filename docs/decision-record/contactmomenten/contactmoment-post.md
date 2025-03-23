# Contactmoment: de uitgebreide POST
Voor de aansluiting op Open Klant 2.x en de Klantinteracties API, schreef KISS de Contactmomenten weg m.b.v. de VNG Contactmomenten API zoals deze is geïmplementeerd in Open Klant v0.5-pre. In een eerdere versie van KISS waren de gegevens die nu in Contactmomentdetails zitten, onderdeel van het uitgebreide Contactmoment. Omdat in KISS 1C de weg is gekozen om bestaande standaarden niet uit te breiden, zijn deze gegevens verplaatst naar Contactmomentdetails. Bij de overgang naar de VNG Contactmomentne API bleven deze gegevens onderdeel van de POST die KISS doet op deze API. Ook bij   het ontvangende register negeeert deze onderdelen, en registreert alleen het object zoals gedefinieerde in de Contactmomenten API. 

Bij de integratie met de e-Suite (in gebruikt bij Dimpact-gemeenten), in januari-februari 2024, is een additionele [uitbreiding gedaan van de POST-data in contactmoment](POST-contactmoment.md). 


