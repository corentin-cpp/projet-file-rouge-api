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

**Migrations** : fichiers SQL numérotés dans `migrations/` (001 → 013). Le runner `src/config/migrate.js` maintient une table `_migrations` pour ne rejouer que les fichiers non encore appliqués. Ordre obligatoire : agencies → users → properties → tags → property_tags → property_images → contacts → mandates → mandate_contacts → offers → visits → documents → conversations → conversation_users → messages → client_profiles.

**Swagger** : monté sur `/api/docs` uniquement quand `NODE_ENV !== 'production'`. Les specs sont générées via `swagger-jsdoc` à partir des annotations `@swagger` dans les fichiers de routes.

## Routes publiques (sans authentification)

Les routes suivantes sont accessibles sans token JWT :

| Route | Description |
|---|---|
| `GET /api/agencies` | Liste des agences |
| `GET /api/agencies/:id` | Détail d'une agence |
| `GET /api/users` | Liste des utilisateurs |
| `GET /api/users/:id` | Détail d'un utilisateur |
| `GET /api/properties` | Liste des biens |
| `GET /api/properties/:id` | Détail d'un bien |
| `GET /api/properties/:id/images` | Images d'un bien |
| `GET /api/offers` | Liste des offres |
| `GET /api/offers/:id` | Détail d'une offre |

Toutes les routes d'écriture (POST/PUT/DELETE) restent protégées. Toutes les routes `/api/clients` sont protégées.

## Rôles

| Rôle | Accès |
|---|---|
| `super_admin` | Tout, y compris création/suppression d'agences |
| `agency_admin` | Gestion complète de sa propre agence |
| `agent` | Biens, contacts, mandats, offres, visites, clients (lecture/écriture) |
| `client` | Espace personnel uniquement : `GET /api/clients/portal`, `PUT /api/clients/:id` (champs financiers), `POST /api/auth/change-password` |

## Gestion des clients

**Table `client_profiles`** (migration 013) : liée `1:1` à `users` via `user_id` et à `contacts` via `contact_id`. Stocke les données financières (IBAN, BIC, revenus, emploi) et le lien au bien (`property_id`).

**Colonnes ajoutées à `users`** (migration 013) : `must_change_password BOOLEAN` et `temp_password_hash TEXT` — gèrent le flux de première connexion.

**Flux de création** : `POST /api/clients` génère un mot de passe provisoire via `crypto.randomBytes(9).toString('base64url')`, le hache en bcrypt, et retourne le plaintext **une seule fois** dans la réponse. Après changement de mot de passe via `POST /api/auth/change-password`, `must_change_password` passe à `FALSE` et `temp_password_hash` est vidé.

**Séparation des champs** :
- Agents/admins modifient via `PUT /api/clients/:id` : `firstName`, `lastName`, `email`, `phone`, `isActive`, `propertyId`, `assignedAgentId`
- Clients modifient uniquement : `iban`, `bic`, `bankName`, `monthlyIncome`, `employmentType`

**Portail client** : `GET /api/clients/portal` retourne via sous-requêtes SQL le profil + bien + offres + visites + documents agrégés (identifié par `req.user.id`, pas de paramètre d'URL).
