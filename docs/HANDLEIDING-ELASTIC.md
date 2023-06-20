# Configuratie van Elasticsearch voor KISS

KISS maakt gebruik van Elasticsearch voor het ontsluiten van doorzoekbare bronnen. Dit zijn: Kennisartikelen (PDC-producten), websitepagina's en ook medewerkers.  Om te zorgen dat de informatie van deze bronnen opd e juiste manier in KISS terecht komt moet u een aantal zaken regelen

## Engine met de naam 'kiss-engine'
_Deze stap wordt automatisch uitgevoerd in het installatiescript ['NaamScriptEnEenLInk' uit de installatiehandleiding](https://github.com/Klantinteractie-Servicesysteem/.github/blob/main/docs/INSTALLATION.md)_

- Ga in de Kibana-interface van de Elastic-installatie naar Enterprise Search > App Search > Engines. 
- Maak een nieuwe engine aan, en noem deze kiss-engine; **Let op!** Zorg dat de **Engine language** ingesetld staat op **Dutch**

## Crawler
_Deze stap wordt automatisch uitgevoerd in het installatiescript ['NaamScriptEnEenLInk' uit de installatiehandleiding](https://github.com/Klantinteractie-Servicesysteem/.github/blob/main/docs/INSTALLATION.md)_

Het doorzoeken van een website binnen KISS wordt mogelijk door de website te crawlen vanuit Elastic Search. Hiervoor maak je binnen de engine een crawler aan. Als u het installatiescript 'NaamScriptEnEenLInk' hebt gebruikt, is er een eenvoudige crawler aangemaakt op het hele domein van uw website. Het is aan te raden om verder overleg te hebben met uw websitebeheerder, over het verdere finetunen van de crawler. Mogelijk zijn er aanpassingen nodig in uw robots.txt, of zijn er aanvullende filterinstellingen nodig. 

Op het moment dat de crawler de eerste keer gedraaid heeft, wordt het engine schema uitgebreid met de [velden die horen biJa de crawler](https://www.elastic.co/guide/en/app-search/current/web-crawler-reference.html#web-crawler-reference-web-crawler-schema).

## Syncen van bronnen
De eerste keer dat er via de synctool Kennisartikelen (PDC-producten) of Medewekers worden geindexeerd in Elastic, wordt het Engine Schema uitgebreid met een aantal velden. Dit zijn: 
- `object_bron`
- `object_meta`
- `object`

## Relevance Tuning
_Deze stap wordt automatisch uitgevoerd in het installatiescript ['NaamScriptEnEenLInk' uit de installatiehandleiding](https://github.com/Klantinteractie-Servicesysteem/.github/blob/main/docs/INSTALLATION.md)_

Om de informatie uit de Kennisartikelen en websites doorzoekbaar te maken, moeten deze velden opgenomen zijn in het Engine Schema. Let op: zijn er nieuwe velden toegevoegd aan het Engine Schema, bijvoorbeeld omdat er een nieuw type bron wordt toegevoegd? Dan moeten deze velden doorzoekbaar gemaakt worden. Dit kunt u doen m.b.v. de knop 'Update search settings' op de pagina Manage engine schema. U kunt ook op de pagina Relevance Tuning aangeven dat een schemaveld doorzoekbaar moet zijn. 


Om de zoekresultaten te beïnvloeden, moet u vervolgens de Relevance Tuning instellen. We gaan uit van onderstaande instellingen voor Relevantie. Tijdens de instalatie worden deze instellingen scriptmatig ingesteld. U kunt dit altijd handmatig wijzigen. 



| Schemaveld   | Hoort bij Website-schema | Doorzoeken  | Relevantie |
|--------|--------|--------|--------|
| title | Ja | Ja | 9 |
|meta_descriptioNee| Ja | Ja | 7 | 
|  meta_keywords | Ja | Ja | 4 | 
| headings | Ja | Ja | 2 |
| additional_urls | Ja | Ja | 1 |
| body_content | Ja | Ja | 1 |
| links | Ja | Ja | 1 |
| url_path | Ja | Ja | 1 |
| object_meta | Nee | Ja | 7 | 
| object | Nee | Ja | 6 | 0 |
| url_path_dir1 | Ja | Nee| 0 |
| url_path_dir2 | Ja | Nee| 0 |
|  url_path_dir3 | Ja | Nee| 0 |
| domains | Ja | Nee| 0 |
| last_crawled_at | Ja  | Nee| 0 |
| url | Ja | Nee| 0 |
| url_host | Ja | Nee| 0 |
| url_port | Ja | Nee| 0 |
| url_scheme | Ja | Nee| 0 |
| self | Nee | Nee| 0 |
| object_bron| Nee | Nee| 0 |
