## Interrogation géomatique

Ces points d'accès permettent de rechercher des données géomatiques en fonction de différents critères descriptifs ou spatiaux.

L'implémentation actuelle peut retourner une collection au format ESRI, mais vous ne devriez pas en tenir compte, car le format
final de l'API sera en FeatureCollection (GeoJSON). Si vous utilisez les `attributes` des réponses au format ESRI, vous devrez
penser à modifier vos appels pour utiliser `properties` lorsque le service sera en GeoJSON.

### Get Discovery Document

Obtient les métadonnées sur les types d'entités disponibles par cette instance de service.

```endpoint
GET /features/.discovery
```

| Response Members | Description |
---------------|--
`place_type`   | Nom de la classe d'entités.
`id_field`     | Nom de la clé utilisée pour effectuer des recherches.
`id_label`     | Libellé de la clé pour afficher dans un formulaire.
`fields`       | Liste des attributs disponibles pour chaque couche.
`fields[i].name`  |
`fields[i].label` |
`fields[i].type`  |
`link`         | Lien permettant d'interroger cette couche.

#### Example response

```json
[
  {
    "place_type": "adresse",
    "id_field": "id_civ",
    "id_label": "ID REPERE",
    "fields": [
      {
        "name": "address",
        "label": "Adresse complète",
        "type": "string"
      }
    ],
    "link": "/features/adresse"
  }
]
```

### Get Features across types

Obtient les entités de chaque collection correspondant au filtre de recherche demandé.

```endpoint
GET /features?lat={latitude}&lon={longitude}&distance={distance}&place_types={place_types}
```

```endpoint
GET /features?q={feature_query}&distance={distance}&place_types={place_types}
```

|Query Parameters|Description|
-----------------|---
`x`              | Coordonnée `x` du point d'interrogation. Doit être dans le même système de projection que la donnée source. À utiliser conjointement avec `y`.
`y`              | Coordonnée `y` du point d'interrogation. Doit être dans le même système de projection que la donnée source. À utiliser conjointement avec `x`.
`lat`            | Latitude du point d'interrogation. Les données seront reprojetées à la volée en WGS84. À utiliser conjointement avec `lon`.
`lon`            | Longitude du point d'interrogation. Les données seront reprojetées à la volée en WGS84. À utiliser conjointement avec `lat`.
`feature_query`  | Recherche par clé selon le format suivant: `collection_name/key`, ex: `q=adresses%2f1234`.
`distance`       | Tampon autour du point d'interrogation. La distance est en fonction de l'unité utilisée dans le service sous-jacent.
`place_types`    | Liste des types à inclure dans la recherche (séparé par des virgules). Par défaut, tous les types sont inclus. Ex: `place_types=adresses,districts`

### Get Features of type

Obtient les entités de la couche demandée.

```endpoint
GET /features/{place_type}?lat={latitude}&lon={longitude}&distance={distance}
```

```endpoint
GET /features/{place_type}?q={feature_query}&distance={distance}
```

|URL Parameters|Description|
---|---
`place_type`|Nom de la couche d'interrogation.

|Query Parameters|Description|
-----------|---
`x`        | Coordonnée `x` du point d'interrogation. Doit être dans le même système de projection que la donnée source. À utiliser conjointement avec `y`.
`y`        | Coordonnée `y` du point d'interrogation. Doit être dans le même système de projection que la donnée source. À utiliser conjointement avec `x`.
`lat`      | Latitude du point d'interrogation. Les données seront reprojetées à la volée en WGS84. À utiliser conjointement avec `lon`.
`lon`      | Longitude du point d'interrogation. Les données seront reprojetées à la volée en WGS84. À utiliser conjointement avec `lat`.
`feature_query`  | Recherche par clé selon le format suivant: `collection_name/key`, ex: `q=adresses%2f1234`.
`distance` | Tampon autour du point d'interrogation. La distance est en fonction de l'unité utilisée dans le service sous-jacent.

#### Exemple: Obtient toutes les entités de `district_electoral` intersectant le point (`x`,`y`):

```curl
$ curl $SERVERNAME/features/district_electoral?x={x}&y={y}
```

#### Example response

```json
{
  "type": "FeatureCollection",
  "features": [
    {
      "id": "district_electoral.123",
      "place_name": "Saint-Vincent-de-Paul",
      "place_type": ["district_electoral"],
      "properties": {
        "OBJECTID": 1011,
        "NOM": "Saint-Vincent-de-Paul",
        "NUMERO": "2",
        "CONSEILLER": "Nom Conseiller",
        "TEL_RES": null,
        "TEL_BUR": "999 999-9999",
        "TEL_CELL": null,
        "COURRIEL": "nom@laval.ca",
        "TEL_FAX": null
      },
      "geometry": {
      }
    }
  ]
}
```

### Get Feature

Obtient les éléments avec les identifiants d'affaires demandés.

```endpoint
GET /features/{place_type}/{id}
```

|URL Parameters|Description|
---|---
`place_type`| Nom de la couche d'interrogation.
`id`   | Identifiant (clé d'affaires) de l'élément recherché.

#### Exemple: Obtient le cadastre *1 034 789*:

```curl
$ curl $SERVERNAME/features/cadastre/1034789
```

#### Example response

```json
[{"todo":true}
]
```
