# Travaux publiques

Ces points d'accès permettent de suivre et de participer à une opération des travaux publiques.

## Parcours

Un parcours opérationnel est une séquence de tronçons participant à un réseau d'entretiens de la ville.
Ces tronçons représentent des voies carrossables ou des pistes cyclables et leur ordonnancement indique
la séquence normale de traitement.

### Get Routes

Obtient les routes opérationnelles des travaux publiques.

```endpoint
GET /public_works/routes/{layer}
```

#### ou

```endpoint
GET /public_works/snow_plowing/routes
```

```endpoint
GET /public_works/snow_salting/routes
```

```endpoint
GET /public_works/snow_disposal/routes
```

## Opérations

Une opération est un regroupement de plusieurs activités (ou bons de travail) mesurables et accomplies
selon une séquence logique quelconque. Par exemple, dans le cadre du suivi de la disposition de la neige,
l'opération regroupe l'ensemble des parcours où la neige doit être enlevée par camion ou soufflé sur les
terrains.

### Get operations types

Obtient les types d'opérations supportées par les travaux publiques.

```endpoint
GET /public_works/operation_types
```

#### ou

```endpoint
GET /public_works/operations
```

### Get operations

Obtient les opérations récentes et en cours des travaux publiques.

```endpoint
GET /public_works/operations
```

### Get operation by id

Obtient le détail d'une opération des travaux publiques.

```endpoint
GET /public_works/operations/{operation_id}
```

### Start operation

Démarre une nouvelle opération des travaux publiques selon un scénario prédéfini.

```endpoint
POST /public_works/operations?type={operation_type}&scenario={scenario_id?}
```

#### Message Payload: simplified form

```json
[{
  "type":"soufflage",
  "version": 1,
  "routes: ["route_1", "route_2", "route_3"],
}]
```

##### Message payload: complex form

```json
[{
  "type":"soufflage",
  "version": 1,
  "routes: ["route_1", "route_2", {
      "id": "route_3",
      // supports partial routes
      "segments": ["segment_5", "segment_6"]
  }],
}]
```

### Update an operation

Modifie les parcours attitrés à une opération. Si l'opération est terminée ou qu'un avancement a été
documenté pour les parcours à retirer, le retrait sera refusé.

```endpoint
PUT /public_works/operations/{operation_id}
```

### Add/Update a route

Ajoute ou modifie un parcours attitré à une opération.
Si la requête est exécutée sans message, tous les segments du parcours seront
ajoutés à l'opération.

```endpoint
PUT /public_works/operations/{operation_id}/route/{route_id}
```

##### Optional message payload

```json
[{
  // only keep 2 segments from {route_id}.
  "segments": ["segment_5", "segment_6"]
}]
```

### Remove a route

Retire un parcours d'une opération.

```endpoint
DELETE /public_works/operations/{operation_id}/route/{route_id}
```
