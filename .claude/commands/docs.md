Génère ou met à jour la documentation Swagger JSDoc pour les routes de l'API.

Si un fichier de route est passé en argument (ex: `src/routes/property.routes.js`), documenter uniquement ce fichier. Sinon parcourir tous les fichiers dans `src/routes/` et documenter les endpoints manquants.

Utilise le sous-agent `docs` pour lire les routes, contrôleurs et services, puis écrire les annotations `@swagger` directement dans les fichiers de routes.
