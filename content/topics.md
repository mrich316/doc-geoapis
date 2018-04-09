## Pagination

The [Python requests library](http://docs.python-requests.org/en/master/user/advanced/#link-headers), and the [link-header-parser module for JavaScript](https://github.com/thlorenz/parse-link-header) can parse Link headers. Link headers follow the [RFC 5988 specifications](http://tools.ietf.org/html/rfc5988).

## Code HTTP

Les codes http pouvant être retournés dans les API.

|Code - Réponses de succès|Description|
------------------------|---
`200 OK`				| La requète a réussi. La signification du succès peut varier selon la méthode HTTP :</br> GET : La ressource a été récupérée et est retransmise dans le corps du message. </br>HEAD : Les en-têtes d'entité sont dans le corps du message. </br>POST : La ressource décrivant le résultat de l'action est transmise dans le corps du message. </br>TRACE : Le corps du message contient le message de requête tel que reçu par le serveur
`201 Created` 			| La requête a réussi et une nouvelle ressource a été créée en guise de résultat. Il s'agit typiquement de la réponse envoyée après une requête PUT.
`204 No Content` 		| Il n'y a pas de contenu à envoyer pour cette requête, mais les en-têtes peuvent être utiles. L'agent utilisateur peut mettre à jour ses en-têtes en cache pour cette ressource en les remplaçant par les nouveaux.

|Code - Messages de redirection|Description|
------------------------|---
`301 Moved Permanently` | Ce code de réponse signifie que l'URI de la ressource demandée a été modifiée. Une nouvelle URI sera probablement donnée dans la réponse.


|Code - Réponses d'erreur côté client|Description|
------------------------|---
`400 Bad Request` 		| Cette réponse indique que le serveur n'a pas pu comprendre la requête à cause d'une syntaxe invalide.
`401 Unauthorized`		| Une identification est nécessaire pour obtenir la réponse demandée. Ceci est similaire au code 403, mais dans ce cas, l'identification est possible.
`403 Forbidden` 		| Le client n'a pas les droits d'accès au contenu, donc le serveur refuse de donner la véritable réponse.
`404 Not Found` 		| Le serveur n'a pas trouvé la ressource demandée. Ce code de réponse est principalement connu pour son apparition fréquente sur le web.
`405 Method Not Allowed`| La méthode de requête est connue du serveur mais a été désactivée et ne peut pas être utilisée. Les deux méthodes obligatoires, GET et HEAD, ne doivent jamais être désactivées et ne doivent pas retourner ce code d'erreur.
`429 Too Many Requests` | L'utilisateur a émis trop de requêtes dans un laps temps donné.

|Code - Réponses d'erreur côté serveur|Description|
------------------------|---
`500 Internal Server Error` | Le serveur a rencontré une situation qu'il ne sait pas traiter.
`501 Not Implemented` 	| La méthode de requête n'est pas supportée par le serveur et ne peut pas être traitée. Les seules méthodes que les serveurs sont tenus de supporter (et donc pour lesquelles ils ne peuvent pas renvoyer ce code) sont GET et HEAD.
`502 Bad Gateway`		| Cette réponse d'erreur signifie que le serveur, alors qu'il fonctionnait en tant que passerelle pour recevoir une reponse nécessaire pour traiter la requête, a reçu une réponse invalide.
`503 Service Unavailable` | Le serveur n'est pas prêt pour traiter la requête. Les causes les plus communes sont que le serveur est éteint pour maintenance ou qu'il est surchargé. Notez qu'avec cette réponse, une page ergonomique peut expliquer le problème. Ces réponses doivent être utilisées temporairement et le champ d'en-tête Retry-After doit, dans la mesure du possible, contenir une estimation de l'heure de reprise du service. Le webmestre doit aussi faire attention aux en-têtes de mise en cache qui sont envoyés avec cette réponse (qui ne doivent typiquement pas être mis en cache).
`504 Gateway Timeout` 	| Cette réponse d'erreur est renvoyée lorsque le serveur sert de passerelle et ne peut pas donner de réponse dans les temps.