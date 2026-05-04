# API_DOCUMENTATION

## Base URL

Toutes les routes sont disponibles sous le préfixe :

`/api`

Par exemple :

- `POST /api/auth/login`
- `GET /api/properties`

## Documentation Swagger

- En environnement non production : `GET /api/docs`
- Swagger expose les mêmes routes décrites ci-dessous.

---

## Authentification

### Flux JWT

- `POST /api/auth/register`
  - Crée un compte utilisateur
  - Requiert : `firstName`, `lastName`, `email`, `password`, `role`
  - Retour : `201`

- `POST /api/auth/login`
  - Authentifie l'utilisateur
  - Requiert : `email`, `password`
  - Retour : `200` avec `accessToken` et `refreshToken`

- `POST /api/auth/refresh`
  - Rafraîchit l'access token
  - Requiert : `refreshToken`
  - Retour : `200`

- `POST /api/auth/logout`
  - Déconnecte l'utilisateur
  - Requiert un header `Authorization: Bearer <token>`
  - Retour : `200`

- `GET /api/auth/me`
  - Retourne le profil de l'utilisateur connecté
  - Requiert un token JWT valide
  - Retour : `200`

---

## Routes API

### Agencies

- `GET /api/agencies`
  - Liste toutes les agences
  - Requiert token
  - Retour : `200`

- `POST /api/agencies`
  - Crée une agence
  - Requiert token + rôle `super_admin`
  - Corps : `name`, `email`, `siret`, `phone`, `address`, `city`, `postalCode`, `country`
  - Retour : `201`

- `GET /api/agencies/{id}`
  - Détaille une agence
  - Requiert token
  - Retour : `200`

- `PUT /api/agencies/{id}`
  - Met à jour une agence
  - Requiert token + rôle `super_admin` ou `agency_admin`
  - Retour : `200`

- `DELETE /api/agencies/{id}`
  - Supprime une agence
  - Requiert token + rôle `super_admin`
  - Retour : `204`

### Users

- `GET /api/users`
  - Liste les utilisateurs
  - Requiert token + rôle `super_admin` ou `agency_admin`
  - Filtre possible : `agencyId`
  - Retour : `200`

- `GET /api/users/{id}`
  - Détaille un utilisateur
  - Requiert token
  - Retour : `200`

- `PUT /api/users/{id}`
  - Met à jour un utilisateur
  - Requiert token + rôle `super_admin` ou `agency_admin`
  - Retour : `200`

- `DELETE /api/users/{id}`
  - Supprime un utilisateur
  - Requiert token + rôle `super_admin` ou `agency_admin`
  - Retour : `204`

### Properties

- `GET /api/properties`
  - Liste les biens immobiliers
  - Requiert token
  - Filtres disponibles : `agencyId`, `city`, `type`, `transactionType`, `minPrice`, `maxPrice`
  - Retour : `200`

- `POST /api/properties`
  - Crée un bien
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - Retour : `201`

- `GET /api/properties/{id}`
  - Détaille un bien
  - Requiert token
  - Retour : `200`

- `PUT /api/properties/{id}`
  - Met à jour un bien
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - Retour : `200`

- `DELETE /api/properties/{id}`
  - Supprime un bien
  - Requiert token + rôle `super_admin` ou `agency_admin`
  - Retour : `204`

- `GET /api/properties/{id}/images`
  - Liste les images du bien
  - Requiert token
  - Retour : `200`

- `POST /api/properties/{id}/images`
  - Ajoute une image au bien
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - Retour : `201`

- `POST /api/properties/{id}/tags`
  - Ajoute un tag au bien
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - Corps : `tagId`
  - Retour : `204`

- `DELETE /api/properties/{id}/tags/{tagId}`
  - Retire un tag du bien
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - Retour : `204`

### Tags

- `GET /api/tags`
  - Liste tous les tags
  - Requiert token
  - Retour : `200`

- `POST /api/tags`
  - Crée un tag
  - Requiert token + rôle `super_admin` ou `agency_admin`
  - Corps : `label`, `color`
  - Retour : `201`

- `DELETE /api/tags/{id}`
  - Supprime un tag
  - Requiert token + rôle `super_admin` ou `agency_admin`
  - Retour : `204`

### Contacts

- `GET /api/contacts`
  - Liste les contacts
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - Filtre possible : `agencyId`
  - Retour : `200`

- `POST /api/contacts`
  - Crée un contact
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - Retour : `201`

- `GET /api/contacts/{id}`
  - Détaille un contact
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - Retour : `200`

- `PUT /api/contacts/{id}`
  - Met à jour un contact
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - Retour : `200`

- `DELETE /api/contacts/{id}`
  - Supprime un contact
  - Requiert token + rôle `super_admin` ou `agency_admin`
  - Retour : `204`

### Mandates

- `GET /api/mandates`
  - Liste les mandats
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - Filtre possible : `agencyId`
  - Retour : `200`

- `POST /api/mandates`
  - Crée un mandat
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - Retour : `201`

- `GET /api/mandates/{id}`
  - Détaille un mandat
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - Retour : `200`

- `PUT /api/mandates/{id}`
  - Met à jour un mandat
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - Retour : `200`

- `DELETE /api/mandates/{id}`
  - Supprime un mandat
  - Requiert token + rôle `super_admin` ou `agency_admin`
  - Retour : `204`

- `POST /api/mandates/{id}/contacts`
  - Associe un contact à un mandat
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - Corps : `contactId`, `role`
  - Retour : `204`

### Offers

- `GET /api/offers`
  - Liste les offres
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - Filtres possibles : `propertyId`, `contactId`
  - Retour : `200`

- `POST /api/offers`
  - Crée une offre
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - Retour : `201`

- `GET /api/offers/{id}`
  - Détaille une offre
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - Retour : `200`

- `PUT /api/offers/{id}`
  - Met à jour une offre
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - Retour : `200`

- `DELETE /api/offers/{id}`
  - Supprime une offre
  - Requiert token + rôle `super_admin` ou `agency_admin`
  - Retour : `204`

### Visits

- `GET /api/visits`
  - Liste les visites
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - Filtres possibles : `agentId`, `propertyId`, `contactId`
  - Retour : `200`

- `POST /api/visits`
  - Planifie une visite
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - Retour : `201`

- `GET /api/visits/{id}`
  - Détaille une visite
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - Retour : `200`

- `PUT /api/visits/{id}`
  - Met à jour une visite
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - Retour : `200`

- `DELETE /api/visits/{id}`
  - Annule une visite
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - Retour : `204`

### Documents

- `GET /api/documents`
  - Liste les documents
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - Filtres possibles : `propertyId`, `contactId`, `offerId`
  - Retour : `200`

- `POST /api/documents`
  - Enregistre un document
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - Corps : `name`, `documentType`, `fileUrl`, `mimeType`, `fileSizeKb`, `propertyId`, `contactId`, `offerId`
  - Retour : `201`

- `GET /api/documents/{id}`
  - Détaille un document
  - Requiert token
  - Retour : `200`

- `DELETE /api/documents/{id}`
  - Supprime un document
  - Requiert token + rôle `super_admin` ou `agency_admin`
  - Retour : `204`

### Conversations (messagerie)

- `GET /api/conversations`
  - Récupère les conversations de l'utilisateur connecté
  - Requiert token
  - Retour : `200`

- `POST /api/conversations`
  - Crée une conversation
  - Requiert token
  - Corps : `conversationType`, `title`, `agencyId`, `propertyId`, `contactId`, `userIds`
  - Retour : `201`

- `GET /api/conversations/{id}`
  - Détaille une conversation
  - Requiert token
  - Retour : `200`

- `POST /api/conversations/{id}/users`
  - Ajoute un utilisateur à une conversation
  - Requiert token
  - Corps : `userId`
  - Retour : `204`

- `GET /api/conversations/{id}/messages`
  - Récupère les messages d'une conversation
  - Requiert token
  - Filtres possibles : `limit`, `before`
  - Retour : `200`

- `POST /api/conversations/{id}/messages`
  - Envoie un message dans une conversation
  - Requiert token
  - Corps : `content`, `messageType`
  - Retour : `201`

- `DELETE /api/conversations/{id}/messages/{messageId}`
  - Supprime un message (soft delete)
  - Requiert token
  - Retour : `204`

---

## Socket.IO - Messagerie temps réel

### Connexion

- URL de socket : même hôte que l'API
- Authentification via handshake :

```js
const socket = io('http://localhost:3000', {
  auth: {
    token: '<accessToken>'
  }
});
```

### Événements Socket

- `join_conversation`
  - Rejoint la room `conversation:{conversationId}`

- `leave_conversation`
  - Quitte la room

- `send_message`
  - Payload : `{ conversationId, content, messageType }`
  - Émet `message:new` à la room après création

- `typing:start`
  - Notifie les autres participants que l'utilisateur est en train d'écrire

- `typing:stop`
  - Notifie la fin de saisie

### Rooms

- Format : `conversation:{id}`
- Les événements sont émis uniquement à la room associée à la conversation

---

## Bonnes pratiques

- Toujours envoyer un header `Authorization: Bearer <token>` pour les routes protégées.
- Utiliser `POST /api/auth/refresh` lorsque l'access token expire.
- Si Swagger n'est pas disponible, se référer à ce document et aux routes définies dans `src/routes/`.

---

## Notes

- Le préfixe global est définie dans `src/app.js` : `app.use('/api', routes)`.
- La documentation Swagger est chargée via `src/config/swagger.js`.
- La logique métier est dans `src/controllers/` et `src/services/`.
