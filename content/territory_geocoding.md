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

Sommaire de la provenance des clés d'identification

| Nom des clés de l'API   | Provenance originale |
---------------|--
`address.{ID}`			| CIV_NOCIVIQUE_PT.ID_CIV
`street.{ID}`          | VOI_PUBLIQUE_LN.ID_DICT
`ckan_places.{ID}`     | SharePoint.ID_LIEUX
`school.{ID}`			| EDU_ETABLIS_SCOLAIRE_PT.ID_CIV
`municipal_wood.{ID}`  | RCI_BOIS_VILLE_PG.OBJECTID
`cmm_wood.{ID}`		| MNA_BOIS_CMM_PG.OBJECTID
`intersection`          | Il n'y a pas d'identifiant pour un intersection

#### Exemple de réponse pour un adresse

```json
{
  "text": "2000 chemin Saint-Antoine",
  "placeName": "2000 chemin Saint-Antoine, Laval QC  H7R 5Y4",
  "address": "2000 chemin Saint-Antoine",
  "placeType": ["address"],
  "center": [-73.8775257, 45.5345877],
  "context": null,
  "type": "Feature",
  "id": "address.90162",
  "geometry": {
    "type": "Point",
    "coordinates": [-73.8775257, 45.5345877]
  },
  "properties": {
    "address": "2000 chemin Saint-Antoine",
    "address_id": 90162,
    "old_city_name": "Laval-Ouest",
    "old_city_id": 7,
    "postal_code": "H7R 5Y4",
    "street_id": 2096
  },
  "bbox": [-73.8739880197, 45.5332350197, -73.8766859803, 45.5359329803]
}
```

#### Exemple de réponse pour un lieu : école, parc, berge, aréna, boisé, etc.

```json
{
  "text": "Berge des Baigneurs",
  "placeName": "Berge des Baigneurs, 13 rue Hotte, Laval QC  H7L 2R2",
  "address": "13 Rue Hotte",
  "placeType": ["berge", "place"],
  "center": [-73.7897407, 45.6158157],
  "context": null,
  "type": "Feature",
  "id": "place.29",
  "geometry": {
    "type": "Point",
    "coordinates": [-73.7897407, 45.6158157]
  },
  "properties": {
    "address": "13 Rue Hotte",
    "address_id": 102602,
    "common_type": "berge",
    "old_city_name": "Sainte-Rose",
    "old_city_id": 12,
    "place_id": 29,
    "postal_code": "H7L 2R2",
    "street_id": 1206
  },
  "bbox": [-73.7862030197, 45.6144630197, -73.7889009803, 45.6171609803]
}
```

#### Exemple de réponse pour une intersection

```json
{
  "text": "Avenue Marcel-Villeneuve / Montée Masson",
  "placeName": "Avenue Marcel-Villeneuve / Montée Masson, Laval",
  "address": null,
  "placeType": ["intersection"],
  "center": [-73.6411986, 45.6569611],
  "context": null,
  "type": "Feature",
  "geometry": {
    "type": "Point",
    "coordinates": [-73.6411986, 45.6569611]
  },
  "properties": {
    "intersection_id": 12575,
    "intersection_name": "Avenue Marcel-Villeneuve / Montée Masson",
    "streets": [{
        "old_city_name": "Duvernay",
        "old_city_id": 3,
        "street_id": 2639,
        "street_name": "Avenue Marcel-Villeneuve"
      },
      {
        "old_city_name": "Duvernay",
        "old_city_id": 3,
        "street_id": 1608,
        "street_name": "Montée Masson"
      }
    ]
  },
  "bbox": [-73.6377417197, 45.6555992197, -73.6404396803, 45.6582971803]
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

