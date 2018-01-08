## Requêtes sur des couches géomatiques

Ces points d'accès permettent de rechercher des données géomatiques en fonction de différents critères descriptifs ou spatiaux.

L'implémentation actuelle peut retourner une collection au format ESRI, mais vous ne devriez pas en tenir compte, car le format
final de l'API sera en FeatureCollection (GeoJSON). Si vous utilisez les `attributes` des réponses au format ESRI, vous devrez
penser à modifier vos appels pour utiliser `properties` lorsque le service sera en GeoJSON.

### Get Layers

Obtient les classes d'entités pouvant être utilisé par ce service.

```endpoint
GET /layers
```

| Response Members | Description |
-------|--
`name` | Nom de la classe d'entités
`link` | Lien permettant d'interroger cette classe d'entités

#### Example response

```json
[
  {
    "name": "adresse",
    "link": "/layers/adresse"
  },
  {
    "name": "district_electoral",
    "link": "/layers/district_electoral"
  }
]
```

### Get Entities

Obtient les entités de la couche demandée.

```endpoint
GET /layers/{layer}
```

|URL Parameters|Description|
---|---
`layer`|Nom de la couche d'interrogation.

|Query Parameters|Description|
-----|---
`x`  |Coordonnée `x` du point d'interrogation. Doit être dans le même système de projection que la donnée source. À utiliser conjointement avec `y`.
`y`  |Coordonnée `y` du point d'interrogation. Doit être dans le même système de projection que la donnée source. À utiliser conjointement avec `x`.
`lat`|Latitude du point d'interrogation. Les données seront reprojetées à la volée en WGS84. À utiliser conjointement avec `lng`.
`lng`|Longitude du point d'interrogation. Les données seront reprojetées à la volée en WGS84. À utiliser conjointement avec `lat`.

Notez que les paramètres `x`, `y`, `lat` et `lng` ne sont pas encore disponible.
L'utilisation de `x`, `y`, `lat` et `lng` sur des couches de points ou de lignes ne donnera sûrement pas les résultats escomptés, car
il est très difficile, voir impossible de sélectionner une ligne ou un point avec une position sans tolérance.

#### Exemple: Obtient toutes les entités de `district_electoral` intersectant le point (`x`,`y`):

```curl
$ curl $SERVERNAME/layers/district_electoral?x={x}&y={y}
```

#### Example response

```json
{
  "type": "FeatureCollection",
  "features": [
    {
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

### Get Entity by ID

Obtient les éléments avec les identifiants d'affaires demandés.

```endpoint
GET /layers/{layer}/{id}
```

|URL Parameters|Description|
---|---
`layer`| Nom de la couche d'interrogation.
`id`   | Identifiant (clé d'affaires) de l'élément recherché.

#### Exemple: Obtient le cadastre *1 034 789*:

```curl
$ curl $SERVERNAME/layers/cadastre/1034789
```

#### Example response

```json
[{"todo":true}
]
```

### Get Related Entities

Obtient les éléments liés à l'élément demandé par son identifiant d'affaires `id` demandée.

```endpoint
GET /layers/{layer}/{id}/{relLayer}?rel={relation}&distance={distance}
```

|URL Parameters|Description|
---------------|---
`layer`        | Nom de la couche d'interrogation.
`relLayer`     | Couche à analyser pour la `relation` spatiale en paramètre. `_all` peut être utilisé pour effectuer une interrogation sur toutes les couches simultanément.
`id`           | Identifiant d'affaire demandé.

|Query Parameters|Description|
|----------------|-----------|
`relation`       | Type de relation spatiale à appliquer. Valeurs acceptées: `intersects` (valeur par défaut), `contains`, `crosses`, `overlaps`, `touches`, `within`.
`distance`       | Tampon à effectuer sur les éléments de `layer` avant d'exécuter l'analyse des relations spatiales.
`x`  |Coordonnée `x` du point d'interrogation. Doit être dans le même système de projection que la donnée source. À utiliser conjointement avec `y`.
`y`  |Coordonnée `y` du point d'interrogation. Doit être dans le même système de projection que la donnée source. À utiliser conjointement avec `x`.
`lat`|Latitude du point d'interrogation. Les données seront reprojetées à la volée en WGS84. À utiliser conjointement avec `lng`.
`lng`|Longitude du point d'interrogation. Les données seront reprojetées à la volée en WGS84. À utiliser conjointement avec `lat`.

Les `Query Parameters` ne sont pas encore supportés dans cette version.

L'utilisation de `x`, `y`, `lat` et `lng` sur des couches de points ou de lignes ne donnera sûrement pas les résultats escomptés, car
il est très difficile, voir impossible de sélectionner une ligne ou un point avec une position sans tolérance.

#### Exemple: Obtient la zone inondable touchant le cadastre *1 034 789*:

```curl
$ curl $SERVERNAME/layers/cadastre/1034789/zone_inondable
```

#### Exemple: Obtient les parcs à 500m de l'adresse *1 Place du Souvenir (CIV41567)*:

```curl
$ curl $SERVERNAME/layers/adresse_civique/41567/espace_vert?distance=100
```

#### Exemple de response

```json
[{"todo":true}
]
```
