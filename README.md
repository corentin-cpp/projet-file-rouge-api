<div align="center">

# 🏠 Ymmo API

**Plateforme de gestion immobilière — API REST & temps réel**

[![Node.js](https://img.shields.io/badge/Node.js-18+-339933?style=flat-square&logo=node.js&logoColor=white)](https://nodejs.org)
[![Express](https://img.shields.io/badge/Express-4-000000?style=flat-square&logo=express&logoColor=white)](https://expressjs.com)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14+-4169E1?style=flat-square&logo=postgresql&logoColor=white)](https://postgresql.org)
[![Socket.IO](https://img.shields.io/badge/Socket.IO-4-010101?style=flat-square&logo=socket.io&logoColor=white)](https://socket.io)
[![JWT](https://img.shields.io/badge/Auth-JWT-FB015B?style=flat-square&logo=jsonwebtokens&logoColor=white)](https://jwt.io)
[![Swagger](https://img.shields.io/badge/Docs-Swagger-85EA2D?style=flat-square&logo=swagger&logoColor=black)](https://swagger.io)

*Gestion des biens, mandats, contacts, clients, offres, visites, documents et messagerie en temps réel*

</div>

---

## Sommaire

- [Stack technique](#-stack-technique)
- [Prérequis](#-prérequis)
- [Démarrage rapide](#-démarrage-rapide)
- [Configuration](#-configuration)
- [Migrations](#-migrations)
- [Authentification & Rôles](#-authentification--rôles)
- [Endpoints](#-endpoints)
- [Messagerie temps réel](#-messagerie-temps-réel-socketio)
- [Documentation Swagger](#-documentation-swagger)
- [Tests Postman](#-tests-avec-postman)
- [Structure du projet](#-structure-du-projet)
- [Base de données](#-base-de-données)
- [Espace client](#-espace-client)

---

## ⚡ Stack technique

<table>
  <tr>
    <th>Catégorie</th>
    <th>Technologie</th>
    <th>Détail</th>
  </tr>
  <tr>
    <td>Runtime</td>
    <td><strong>Node.js 18+</strong></td>
    <td>JavaScript côté serveur</td>
  </tr>
  <tr>
    <td>Framework</td>
    <td><strong>Express 4</strong></td>
    <td>Routing, middlewares</td>
  </tr>
  <tr>
    <td>Base de données</td>
    <td><strong>PostgreSQL 14+</strong></td>
    <td>Driver <code>pg</code>, SQL brut, UUID natif</td>
  </tr>
  <tr>
    <td>Authentification</td>
    <td><strong>JWT</strong></td>
    <td>Access token 15 min + Refresh token 7 j</td>
  </tr>
  <tr>
    <td>Temps réel</td>
    <td><strong>Socket.IO 4</strong></td>
    <td>Messagerie instantanée, rooms par conversation</td>
  </tr>
  <tr>
    <td>Documentation</td>
    <td><strong>Swagger UI</strong></td>
    <td>Disponible en dev/test uniquement</td>
  </tr>
  <tr>
    <td>Sécurité</td>
    <td><strong>Helmet · bcrypt · RBAC</strong></td>
    <td>Headers sécurisés, hachage, contrôle par rôle</td>
  </tr>
</table>

---

## 📋 Prérequis

- **Node.js** ≥ 18
- **PostgreSQL** ≥ 14
- **npm** ≥ 9

---

## 🚀 Démarrage rapide

```bash
# 1. Cloner le dépôt
git clone <url-du-repo>
cd projet-file-rouge-api

# 2. Installer les dépendances
npm install

# 3. Configurer les variables d'environnement
cp .env.example .env

# 4. Créer la base de données
createdb ymmo

# 5. Appliquer les migrations
npm run migrate

# 6. Démarrer
npm run dev     # développement avec hot-reload
npm start       # production
```

> L'API est disponible sur `http://localhost:3000`

---

## ⚙️ Configuration

Copier `.env.example` vers `.env` et renseigner :

```env
NODE_ENV=development
PORT=3000

# PostgreSQL
DB_HOST=localhost
DB_PORT=5432
DB_NAME=ymmo
DB_USER=postgres
DB_PASSWORD=your_password

# JWT
JWT_SECRET=your_jwt_secret_here
JWT_REFRESH_SECRET=your_refresh_secret_here
JWT_EXPIRES_IN=15m
JWT_REFRESH_EXPIRES_IN=7d
```

> [!IMPORTANT]
> En production, `NODE_ENV=production` désactive automatiquement la documentation Swagger et active les logs au format `combined`.

---

## 🗄️ Migrations

Les migrations sont des fichiers SQL numérotés dans `migrations/`. Le runner interne maintient une table `_migrations` pour n'exécuter que les fichiers non encore appliqués.

```bash
npm run migrate
```

<details>
<summary>Ordre des migrations</summary>

```
001_create_agencies
002_create_users
003_create_properties
004_create_tags
005_create_property_images
006_create_contacts
007_create_mandates
008_create_offers
009_create_visits
010_create_documents
011_create_messaging
012_fix_property_status
013_create_client_profiles
```

</details>

---

## 🔐 Authentification & Rôles

### Flux d'authentification

```
┌─────────────┐     POST /api/auth/register    ┌─────────────┐
│    Client   │ ──────────────────────────────► │     API     │
│             │     POST /api/auth/login        │             │
│             │ ──────────────────────────────► │             │
│             │ ◄────────── accessToken (15m) ──│             │
│             │ ◄────────── refreshToken (7j) ──│             │
│             │                                 │             │
│             │  Authorization: Bearer <token>  │             │
│             │ ──────────────────────────────► │             │
│             │     POST /api/auth/refresh      │             │
│             │ ──────────────────────────────► │             │
│             │ ◄────────── new accessToken ────│             │
└─────────────┘                                 └─────────────┘
```

### Matrice des rôles

| Rôle | Agences | Biens | Contacts | Mandats / Offres / Visites | Clients |
|---|:---:|:---:|:---:|:---:|:---:|
| `super_admin` | ✅ CRUD | ✅ CRUD | ✅ CRUD | ✅ CRUD | ✅ CRUD |
| `agency_admin` | ✅ Read/Update | ✅ CRUD | ✅ CRUD | ✅ CRUD | ✅ CRUD |
| `agent` | ✅ Read | ✅ CRUD | ✅ CRUD | ✅ CRUD | ✅ Create/Read/Update |
| `client` | — | ✅ Read | — | — | ✅ Update (données financières propres) |

> Les clients ne peuvent pas créer de compte eux-mêmes. Seuls les agents et admins créent des comptes clients.

---

## 📡 Endpoints

### 🔑 Auth

| Méthode | Route | Description | Accès |
|---|---|---|:---:|
| `POST` | `/api/auth/register` | Créer un compte | Public |
| `POST` | `/api/auth/login` | Se connecter | Public |
| `POST` | `/api/auth/refresh` | Rafraîchir le token | Public |
| `POST` | `/api/auth/logout` | Se déconnecter | 🔒 |
| `GET` | `/api/auth/me` | Profil connecté | 🔒 |
| `POST` | `/api/auth/change-password` | Changer son mot de passe | 🔒 |

### 🏢 Agences

| Méthode | Route | Rôles requis |
|---|---|---|
| `GET` | `/api/agencies` | Tous |
| `POST` | `/api/agencies` | `super_admin` |
| `GET` | `/api/agencies/:id` | Tous |
| `PUT` | `/api/agencies/:id` | `super_admin` · `agency_admin` |
| `DELETE` | `/api/agencies/:id` | `super_admin` |

### 🏘️ Biens immobiliers

| Méthode | Route | Description |
|---|---|---|
| `GET` | `/api/properties` | Liste filtrée (`city`, `type`, `transactionType`, `minPrice`, `maxPrice`) |
| `POST` | `/api/properties` | Créer un bien |
| `GET` | `/api/properties/:id` | Détail avec tags et images |
| `PUT` | `/api/properties/:id` | Modifier |
| `DELETE` | `/api/properties/:id` | Supprimer |
| `GET` | `/api/properties/:id/images` | Images du bien |
| `POST` | `/api/properties/:id/images` | Ajouter une image |
| `POST` | `/api/properties/:id/tags` | Associer un tag |
| `DELETE` | `/api/properties/:id/tags/:tagId` | Retirer un tag |

### 🧑‍💼 Clients

| Méthode | Route | Description | Rôles |
|---|---|---|---|
| `POST` | `/api/clients` | Créer un client (retourne le mot de passe provisoire) | agent, agency_admin, super_admin |
| `GET` | `/api/clients` | Lister les clients | agent, agency_admin, super_admin |
| `GET` | `/api/clients/portal` | Tableau de bord du client connecté | **client** |
| `GET` | `/api/clients/:id` | Détail d'un client | agent, agency_admin, super_admin |
| `PUT` | `/api/clients/:id` | Modifier (tous champs pour agents, champs financiers pour client) | tous 🔒 |
| `DELETE` | `/api/clients/:id` | Supprimer un client | agency_admin, super_admin |
| `POST` | `/api/clients/:id/reset-password` | Régénérer un mot de passe provisoire | agent, agency_admin, super_admin |

### Autres ressources CRUD

Les routes suivantes exposent `GET /`, `POST /`, `GET /:id`, `PUT /:id`, `DELETE /:id` :

| Ressource | Base URL | Particularité |
|---|---|---|
| Tags | `/api/tags` | — |
| Contacts | `/api/contacts` | Filtre par `agencyId` |
| Mandats | `/api/mandates` | + `POST /:id/contacts` |
| Offres | `/api/offers` | Filtre par `propertyId`, `contactId` |
| Visites | `/api/visits` | Filtre par `agentId`, `propertyId`, `contactId` |
| Documents | `/api/documents` | Filtre par `propertyId`, `contactId`, `offerId` |

### 💬 Messagerie

| Méthode | Route | Description |
|---|---|---|
| `GET` | `/api/conversations` | Mes conversations |
| `POST` | `/api/conversations` | Créer une conversation |
| `GET` | `/api/conversations/:id` | Détail + marquer comme lu |
| `POST` | `/api/conversations/:id/users` | Ajouter un participant |
| `GET` | `/api/conversations/:id/messages` | Historique (pagination par curseur) |
| `POST` | `/api/conversations/:id/messages` | Envoyer un message (REST + Socket.IO) |
| `DELETE` | `/api/conversations/:id/messages/:messageId` | Soft delete |

---

## 🔴 Messagerie temps réel (Socket.IO)

### Connexion

```js
import { io } from 'socket.io-client';

const socket = io('http://localhost:3000', {
  auth: { token: '<accessToken>' }
});
```

### Événements

**Client → Serveur**

| Événement | Payload | Description |
|---|---|---|
| `join_conversation` | `conversationId` | Rejoindre une salle |
| `leave_conversation` | `conversationId` | Quitter une salle |
| `send_message` | `{ conversationId, content, messageType }` | Envoyer un message |
| `typing:start` | `{ conversationId }` | Indicateur de saisie |
| `typing:stop` | `{ conversationId }` | Fin de saisie |

**Serveur → Client**

| Événement | Payload | Description |
|---|---|---|
| `message:new` | Objet message complet | Nouveau message reçu |
| `message:deleted` | `{ id }` | Message supprimé |
| `typing:start` | `{ userId, conversationId }` | Quelqu'un écrit |
| `typing:stop` | `{ userId, conversationId }` | Fin de saisie |
| `user:joined` | `{ userId, conversationId }` | Participant rejoint |
| `user:left` | `{ userId, conversationId }` | Participant parti |

> Les rooms Socket.IO sont nommées `conversation:{id}`.

---

## 📖 Documentation Swagger

Disponible **uniquement** hors production :

```
http://localhost:3000/api/docs
```

> [!WARNING]
> En production (`NODE_ENV=production`), cette URL renvoie `404`.

---

## 🧪 Tests avec Postman

Importer `postman/Ymmo.postman_collection.json` dans Postman.

La collection intègre des **scripts de test automatiques** qui capturent les tokens et IDs dans les variables de collection (`{{token}}`, `{{agencyId}}`, `{{propertyId}}`, etc.) après chaque requête.

**Ordre recommandé pour initialiser les données :**

```
1. Auth › Register              →  créer un compte super_admin
2. Auth › Login                 →  {{token}} et {{refreshToken}} sont stockés
3. Agencies › Create            →  {{agencyId}} est stocké
4. Properties › Create          →  {{propertyId}} est stocké
5. Tags › Create                →  {{tagId}} est stocké
6. Contacts › Create            →  {{contactId}} est stocké
7. Clients › Create             →  {{clientId}} est stocké, {{temporaryPassword}} affiché
8. Auth › Login (client)        →  connexion avec le mot de passe provisoire
9. Auth › Change Password       →  définir le mot de passe définitif
10. Clients › Portal            →  accéder au tableau de bord client
11. Mandates › Create           →  {{mandateId}} est stocké
12. Offers / Visits / Docs      →  utiliser les IDs précédents
```

---

## 📁 Structure du projet

```
projet-file-rouge-api/
│
├── migrations/                  # Fichiers SQL numérotés (001 → 013)
│   ├── 001_create_agencies.sql
│   ├── 002_create_users.sql
│   ├── ...
│   ├── 012_fix_property_status.sql
│   └── 013_create_client_profiles.sql
│
├── postman/
│   └── Ymmo.postman_collection.json
│
├── src/
│   ├── app.js                   # Configuration Express + Swagger conditionnel
│   ├── server.js                # Serveur HTTP + initialisation Socket.IO
│   │
│   ├── config/
│   │   ├── database.js          # Pool de connexions PostgreSQL
│   │   ├── migrate.js           # Runner de migrations SQL
│   │   └── swagger.js           # Spécification OpenAPI 3.0
│   │
│   ├── middleware/
│   │   ├── auth.js              # Vérification JWT → req.user
│   │   ├── authorize.js         # Factory authorize(...roles)
│   │   └── errorHandler.js      # Gestionnaire d'erreurs global
│   │
│   ├── routes/                  # Endpoints + annotations @swagger
│   │   ├── client.routes.js     # Gestion des clients (espace client)
│   │   └── ...
│   ├── controllers/             # Handlers HTTP (thin layer)
│   │   ├── client.controller.js
│   │   └── ...
│   └── services/                # Logique métier + requêtes SQL
│       ├── client.service.js    # Création client, portail, reset password
│       ├── socket.service.js    # Gestion des événements Socket.IO
│       └── ...
│
├── .env.example
├── CLAUDE.md
├── package.json
└── README.md
```

---

## 🗃️ Base de données

Le schéma couvre **15 entités** interconnectées :

```
agencies ──── users ──── properties ──── property_images
    │           │  │           │
    │           │  │           ├──── property_tags ──── tags
    │           │  │           │
    │      client_profiles     ├──── mandates ──── mandate_contacts
    │           │              │
    │         contacts         ├──── offers
    │              │           │
    │              └───────────├──── visits
    │                          │
    │                          └──── documents
    │
    └── conversations ──── conversation_users
              │
              └── messages
```

> `client_profiles` est lié `1:1` à `users` (via `user_id`) et `1:1` à `contacts` (via `contact_id`). Il stocke les informations financières du client et le lien vers le bien associé.

Toutes les clés primaires sont des **UUID** générés nativement par PostgreSQL (`uuid_generate_v4()`).

---

## 🧑‍💼 Espace client

### Cycle de vie d'un compte client

```
Agent crée le client
  → POST /api/clients
  → Réponse : temporaryPassword (visible une seule fois)
  → L'agent transmet le mot de passe au client hors ligne

Client se connecte
  → POST /api/auth/login
  → Réponse : mustChangePassword: true

Client change son mot de passe
  → POST /api/auth/change-password
  → Flag réinitialisé, mot de passe provisoire effacé

Client accède à son espace
  → GET /api/clients/portal
  → Voir : bien, offres, visites, documents

Client met à jour ses infos bancaires
  → PUT /api/clients/:id (champs financiers uniquement)
```

### Champs financiers (modifiables par le client)

| Champ | Type | Description |
|---|---|---|
| `iban` | string | IBAN bancaire |
| `bic` | string | Code BIC/SWIFT |
| `bankName` | string | Nom de la banque |
| `monthlyIncome` | number | Revenus mensuels nets |
| `employmentType` | enum | `employee` · `self_employed` · `civil_servant` · `retired` · `student` · `unemployed` · `other` |

### Réinitialisation du mot de passe provisoire

Si le client perd son mot de passe avant la première connexion, l'agent peut régénérer un nouveau mot de passe provisoire :

```
POST /api/clients/:id/reset-password
→ Retourne : { "temporaryPassword": "xK9mP2nQ4wRs" }
```

---

<div align="center">

Projet académique — **Ynov Campus** · Promo 2026

</div>
