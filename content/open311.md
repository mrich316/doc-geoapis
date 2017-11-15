## Open 311
API pour créer, visualiser et être informé des demandes au 311.

### Service (Objet)

Le service défini un type de demande acceptée par le 311.

|Membres                   |Description|
---------------------------|---
`service_code` (`string`)  | Identifiant unique de la demande de service
`service_name` (`string`)  | Nom du type de la demande de service
`description`  (`string`)  | Brève description de la demande de service
`metadata`     (`boolean`) | Détermine la présence d'attributs additionnels à la demande.

#### Exemple

```json
{
  "service_code": "001",
  "service_name": "Cans left out 24x7",
  "description": "Garbage or recycling cans that have been left out for more than 24 hours after collection. Violators will be cited.",
  "metadata": true,
  "type": "realtime",
  "keywords": "lorem, ipsum, dolor",
  "group": "sanitation"
}
```

### Liste des services

Liste des demandes de [services](#service-objet) acceptées par le 311.

```endpoint
GET /open311/services.{format?}
```

| Paramètres | Description |
|---|---|
| `format?` | (optionnel) Spécifie le format [`xml`\|`json`] de retour de la réponse. <br />Si non spécifié, la valeur par défaut est `json`.|

#### Exemple de réponse

```json
[
  {
    "service_code":001,
    "service_name":"Cans left out 24x7",
    "description":"Garbage or recycling cans that have been left out for more than 24 hours after collection. Violators will be cited.",
    "metadata":true,
    "type":"realtime",
    "keywords":"lorem, ipsum, dolor",
    "group":"sanitation"
  },
  {
    "service_code":003,
    "metadata":true,
    "type":"realtime",
    "keywords":"lorem, ipsum, dolor",
    "group":"street",
    "service_name":"Curb or curb ramp defect",
    "description":"Sidewalk curb or ramp has problems such as cracking, missing pieces, holes, and/or chipped curb."
  }
]
```