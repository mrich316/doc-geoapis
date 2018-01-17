## Snow Removal (Info-Neige)

L'enlèvement de la neige est encadrée par la politique et la stratégie neige.
Pour plus d'informations à ce sujet, consulter
[Info-Déneigement](https://www.laval.ca/Pages/Fr/Citoyens/info-deneigement.aspx).

API pour permettre au citoyen de mieux comprendre et réagir face aux opérations
d'enlèvement de la neige sur le territoire lavallois. En étant mieux informé,
le citoyen ne placera pas son véhicule dans une zone à déneiger, ce qui
accélérera les opérations et diminuera les délais et les coûts globaux
d’opérations.

### Snow Removal State (Feature)

Représente un état d'enlèvement de la neige pour un côté de rue donné
au format GeoJSON.

| Snow Removal State Properties | Description |
--------------------|--
`state`             | Description de l'état, valeurs possibles: \[ `todo` \| `planned` \| `in_progress` \| `done` \| `out_of_scenario` ]
`state_code`        | Code de l'état
`state_modified_at` | Date du changement d'état
`planned_from`      | Date de début projeté de l'enlèvement de la neige
`planned_to`        | Date de fin projeté de l'enlèvement de la neige
`completed_at`      | Date de fin réelle de l'enlèvement de la neige

| Snow Removal State Enumeration | Description |
------------------|--
`todo`            | Segment participant à l'opération d'enlèvement non déneigé.
`planned`         | Segment participant à l'opération d'enlèvement non déneigé et été planifié
`in_progress`     | Segment en cours de déneigement (non utilisé actuellement)
`done`            | Segment complété.
`out_of_scenario` | Segment ne participant pas à cette opération d'enlèvement.

#### Exemple

```json
{
    "id": "street_side_id", // something like 500234:R
    "type": "snow_removal_state",  // some day, we could have more than one event type
    "properties": {
        "state": "planned|todo|..",
        "state_code": 10, // 10 = not in snow_removal scenario, 0 = Todo, 1 = Done, etc.
        "state_modified_at": "iso8601",
        "planned_from": "iso8601",
        "planned_to": "iso8601",
        "completed_at": "iso8601"
    },
    "geometry": {
        // geojson object, will never be used for InfoNeige mobile App.
        // will not be filled on first release.
    }
}
```

### Get Event Stream

Obtient les changements d'état sur les tronçons routiers de la géobase
des travaux publiques.

```endpoint
GET /transport/snow_removal/event_stream/v1/?from={from_date}&to={to_date?}
```

Retourne une `FeatureCollection` (GeoJSON) de [`snow_removal_state`](#snowremovalstate-feature) entre `from_date` et `to_date`
au format [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601).

| Url Parameters | Description |
-----------------|--
`from_date`      | Date de début de l'interrogation, ex: `2018-01-01T13:00:00Z`
`to_date?`        | (optionnel) Date de fin. Si non définie, l'heure actuelle est utilisée.

#### Example response

```json
{
    "from_date": "iso8601",
    "to_date": "iso8601",
    "features": [
        {
            "id": "street_side_id", // something like 500234:R
            "type": "snow_removal_state",  // some day, we could have more than one event type
            "properties": {
                "state": "planned|todo|..",
                "state_code": 10, // 10 = not in snow_removal scenario, 0 = Todo, 1 = Done, etc.
                "state_modified_at": "iso8601",
                "planned_from": "iso8601",
                "planned_to": "iso8601",
                "completed_at": "iso8601"
            },
            "geometry": {
                // geojson object, will never be used for InfoNeige mobile App.
                // will not be filled on first release.
            }
        }
    ]
}

```