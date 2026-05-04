# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
npm install          # Installer les dépendances
npm run migrate      # Appliquer les migrations SQL
npm run dev          # Démarrer en développement (nodemon)
npm start            # Démarrer en production
```

Variables d'environnement requises : copier `.env.example` vers `.env` et renseigner `DB_*`, `JWT_SECRET`, `JWT_REFRESH_SECRET`.

## Architecture

**Stack** : Express 4 + PostgreSQL (`pg` pool) + Socket.IO. Pas d'ORM — requêtes SQL brutes dans les services.

**Couches** :
- `src/routes/` — définition des endpoints + annotations Swagger JSDoc + application des middlewares `authenticate` / `authorize`
- `src/controllers/` — handlers HTTP minces qui appellent les services et gèrent `try/catch → next(err)`
- `src/services/` — logique métier et requêtes SQL (`pool.query`)
- `src/middleware/auth.js` — vérifie le JWT Bearer → peuple `req.user`
- `src/middleware/authorize.js` — factory `authorize(...roles)` vérifiant `req.user.role`
- `src/middleware/errorHandler.js` — gestionnaire d'erreurs global (dernier middleware dans `app.js`)

**Temps réel** : `src/services/socket.service.js` initialise Socket.IO sur `server.js`. Les rooms sont nommées `conversation:{id}`. Le JWT est vérifié dans le middleware Socket.IO via `socket.handshake.auth.token`. Les contrôleurs accèdent à `req.io` (injecté dans `app.js` via `app.set('io', io)`).

**Migrations** : fichiers SQL numérotés dans `migrations/` (001 → 011). Le runner `src/config/migrate.js` maintient une table `_migrations` pour ne rejouer que les fichiers non encore appliqués. Ordre obligatoire : agencies → users → properties → tags → property_tags → property_images → contacts → mandates → mandate_contacts → offers → visits → documents → conversations → conversation_users → messages.

**Swagger** : monté sur `/api/docs` uniquement quand `NODE_ENV !== 'production'`. Les specs sont générées via `swagger-jsdoc` à partir des annotations `@swagger` dans les fichiers de routes.

## Rôles

| Rôle | Accès |
|---|---|
| `super_admin` | Tout, y compris création/suppression d'agences |
| `agency_admin` | Gestion complète de sa propre agence |
| `agent` | Biens, contacts, mandats, offres, visites (lecture/écriture) |
| `client` | Lecture seule (non implémenté en routes dédiées) |

## Postman

La collection `postman/Ymmo.postman_collection.json` contient tous les endpoints avec des scripts de test qui extraient automatiquement les IDs et tokens dans les variables de collection (`{{token}}`, `{{agencyId}}`, etc.). Commencer par **Register → Login** pour initialiser `{{token}}`.
