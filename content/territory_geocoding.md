## Géocodage

Le géocodeur permet d'effectuer des recherches sur les entités couramment
utilisées pour se localiser. On peut y effectuer des recherches:
par adresses civiques, noms de rues, intersections, lieux occupés ou gérés
par la ville de Laval, etc.

### Carmen Object

L'api de géocodage retourne un message au format
[Carmen](https://github.com/mapbox/carmen/blob/master/carmen-geojson.md)
de Mapbox. Ce format permet de référencer plusieurs types d'entités sous un
même format et reste très accessible vu que la structure respecte le format
[GeoJSON](https://tools.ietf.org/html/rfc7946).

Le message est toujours un `FeatureCollection` avec les propriétés
suivantes:

| Membres      | Description |
---------------|--------------
`attribution`  | (facultatif) Attribution des sources des endroits retournés.
`features`     | Membre du format `GeoJSON`.
`query`        | Termes soumis à l'api de géocodage.

Chaque éléments de `features` correspond au type `Feature` GeoJSON
avec des propriétés suivantes:

| Membres      | Description |
---------------|--------------
`address`      | (facultatif) Adresse de l'élément, lorsque disponible.
`bbox`         | (facultatif) Enveloppe de l'élément.
`center`       | Liste de coordonnées sous la forme longitude, latitude. Représente le centre de l'élément retourné.
`context`      | Liste hierarchique des parents de cet élément. Chaque parent possède les attributs `id` et `text`.
`geometry`     | Géométrie au format `GeoJSON`.
`id`           | Identifiant unique de l'élément, format `{place_type}.{ref_number}`.
`place_name`   | Nom complet (avec hierarchie) de l'élément.
`place_type`   | Liste des types associés à l'élément.
`properties`   | Propriétés `GeoJSON` de l'élément. Varie en fonction de l'élément retourné
`text`         | Texte représentant l'élément retourné
`type`         | Type `GeoJSON`, toujours `Feature`


#### Exemple d'un message Carmen

```json
{
  "type": "FeatureCollection",
  "features": [
    {
      "text": "Parc Rodolphe-Lavoie",
      "place_name": "Parc Rodolphe-Lavoie, 4890 rue Saint-Joseph, Laval, QC H7C 1H5",
      "address": "4890 rue Saint-Joseph",
      "place_type": ["pbh", "parc", "place"],
      "center": [-73.662393692315, 45.596541722524],
      "type": "Feature",
      "id": "pbh.2576",
      "geometry": {
        "type": "Polygon",
        "coordinates": [
          [
            [-73.649595415409,45.610636994848],
            [-73.648700509899,45.611122269602],
            [-73.648458904103,45.610906625591],
            [-73.648230149572,45.610701762299],
            [-73.649130173658,45.610213785033],
            [-73.649595415409,45.610636994848]
          ]
        ]
      },
      "properties": {
        "address": "4890 rue Saint-Joseph",
        "address_id": 914,
        "street_id": 2131,
        "postal_code": "H7C 1H5",
        "old_city": "Saint-Vincent-de-Paul",
        "old_city_id": 13,
        "city": "Laval"
      },
      "bbox": [-73.66434213,45.59601437,-73.66239369,45.59834489]
    }
  ]
}
```

### Discovery Document

Obtient les métadonnées sur les types d'entités disponibles par cette instance de service.

```endpoint
GET /territory/geocoding/v1/.discovery
```

Le document de découverte permet de créer des interfaces utilisateurs dynamiques qui
s'ajustent en fonction des types supportés par le géocodeur. Ce document
contient seulement la prioriété `place_types`:

| Membres      | Description |
---------------|--
`place_types`  | Dictionnaire où la clé est un type d'endroit et la valeur, le métadata associé à ce dernier.

Chaque type de place contient les propriétés suivantes:

| Membres      | Description |
---------------|--
`description`  | Description des endroits inclus dans ce `place_type`.
`text`         | Libellé du type d'endroit
`examples`     | Liste d'exemples

#### Exemple de réponse

```json
{
  "place_types": {
    "address": {
      "text": "Adresses civiques",
      "description": "Adresses civiques émise par le service de l'Urbanisme",
      "examples": [
        "1 place du Souvenir",
        "1 pl du Souvenir",
        "1 du Souvenir",
        "1 Souvenir"
      ]
    },
    "intersection": {
      "text": "Intersections",
      "description": "Intersections entre 2 voies de communications (rues carrossables).",
      "examples": [
        "Boulevard Souvenir / Boulevard Chomedey",
        "Boulevard Chomedey / Boulevard Souvenir",
        "Souvenir / Chomedey",
        "Chomedey / Souvenir"
      ]
    }
  }
}
```

### Suggestions

L'api suggestions permet de suggérer des noms d'endroits en fonction d'un
texte partiel entré par un utilisateur. L'objet retourné est un objet
[Carmen](#carmen-object).  L'api résiste à quelques fautes orthographiques
et auto-complétion du texte entré.  Il est également possible de restreindre
les types d'endroits par le paramètre `place_types`.

L'interface utilisateur connecté à cet api ne doit pas faire une requête
à chaque touche pressée. Pour alléger la charge, il est conseillé
d'utiliser une librairie de
[throttle & debounce](https://medium.com/@ellenaua/throttle-debounce-behavior-lodash-6bcae1494e03).

```endpoint
GET /territory/geocoding/v1/suggest?q={query}&place_types={place_types}&lc={locale}
```

| Query String  | Description |
----------------|--
`query`         | Termes utilisés pour suggérer des endroits.
`place_types`   | Restreindre les suggestions à ces types d'endroits.
`locale`        | Locale à privilégier lors des suggestions.

