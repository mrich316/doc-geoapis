## Requêtes sur des couches géomatiques

Ces points d'accès permettent de rechercher des données géomatiques en fonction de différents critères descriptifs ou spatiaux.

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

#### Exemple: Obtient toutes les entités de `layer` intersectant le point (`x`,`y`):

```curl
$ curl https://geo.laval.ca/geoapi/layers/{layer}?x={x}&y={y}
```

#### Example response

```json
[{"todo":true}
]
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
$ curl https://geo.laval.ca/geoapi/layers/cadastre/1034789
```

#### Example response

```json
[{"todo":true}
]
```

#### Exemple: Obtient le cadastre *1 034 789* et le plan complémentaire *PC-00342*:

```curl
$ curl https://geo.laval.ca/geoapi/layers/cadastre/1034789,PC-00342
```

#### Example response

```json
[{"todo":true}
]
```

### Get Related Entities

Obtient les éléments liés à l'élément demandé par son identifiant d'affaires `id` demandée.

```endpoint
GET /layers/{layer}/{ids}/{relLayers}?rel={relation}&distance={distance}
```

|URL Parameters|Description|
---------------|---
`layer`        | Nom de la couche d'interrogation.
`relLayers`    | Liste des couches à analyser pour la `relation` spatiale en paramètre.
`ids`          | Liste des identifiants d'affaires demandés. La longueur maximale d'une requête HTTP varie d'un navigateur à l'autre. Si vous avez plusieurs identifiants à rechercher, il est possible que vous deviez effectuer plusieurs appels en succession pour l'ensemble de votre requête.

|Query Parameters|Description|
|----------------|-----------|
`relation`       | Type de relation spatiale à appliquer. Valeurs acceptées: `intersects` (valeur par défaut), `contains`, `crosses`, `overlaps`, `touches`, `within`.
`distance`       | Tampon à effectuer sur les éléments de `layer` avant d'exécuter l'analyse des relations spatiales.

#### Exemple: Obtient la zone inondable touchant le cadastre *1 034 789*:

```curl
$ curl https://geo.laval.ca/geoapi/layers/cadastre/1034789/zone_inondable
```

#### Exemple: Obtient les parcs à 500m de l'adresse *1 Place du Souvenir (CIV41567)*:

```curl
$ curl https://geo.laval.ca/geoapi/layers/adresse_civique/41567/espace_vert?distance=100
```

#### Exemple de response

```json
[{"todo":true}
]
```
