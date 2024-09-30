# Contactmomentendetails API Documentation

## Endpoint

`GET /api/contactmomentendetails`

Deze API haalt een lijst van contactmomentendetails op, met ondersteuning voor datum/tijd filters, paginering en een `CancellationToken`.

---

## Query Parameters

| Parameter  | Type   | Verplicht? | Standaard  | Omschrijving                                               |
|------------|--------|------------|------------|------------------------------------------------------------|
| `from`     | string | Ja         | -          | De startdatum in ISO 8601 formaat (bijv. `yyyy-MM-ddTHH:mm:ssZ`). |
| `to`       | string | Ja         | -          | De einddatum in ISO 8601 formaat (bijv. `yyyy-MM-ddTHH:mm:ssZ`). |
| `pageSize` | int    | Nee        | 5000       | Het aantal resultaten per pagina, maximaal 5000.             |
| `page`     | int    | Nee        | 1          | De pagina van de resultaten die moet worden opgehaald.       |

---

## Voorbeeld Verzoek

```bash
GET /api/contactmomentendetails?from=2023-09-01T00:00:00Z&to=2023-09-25T23:59:59Z&pageSize=100&page=1
