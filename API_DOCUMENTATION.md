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
  - **Corps :**
    ```json
    {
      "firstName": "Jean",
      "lastName": "Dupont",
      "email": "jean.dupont@exemple.fr",
      "password": "motdepasse123",
      "phone": "0612345678",
      "role": "agent",
      "agencyId": "550e8400-e29b-41d4-a716-446655440000"
    }
    ```
    Champs obligatoires : `firstName`, `lastName`, `email`, `password`, `role`  
    `role` : `super_admin` | `agency_admin` | `agent` | `client`
  - **Réponse `201` :**
    ```json
    {
      "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
      "first_name": "Jean",
      "last_name": "Dupont",
      "email": "jean.dupont@exemple.fr",
      "role": "agent",
      "agency_id": "550e8400-e29b-41d4-a716-446655440000",
      "created_at": "2026-05-05T10:00:00.000Z"
    }
    ```

- `POST /api/auth/login`
  - Authentifie l'utilisateur
  - **Corps :**
    ```json
    {
      "email": "jean.dupont@exemple.fr",
      "password": "motdepasse123"
    }
    ```
  - **Réponse `200` :**
    ```json
    {
      "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
      "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
      "user": {
        "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
        "firstName": "Jean",
        "lastName": "Dupont",
        "email": "jean.dupont@exemple.fr",
        "role": "agent",
        "mustChangePassword": false
      }
    }
    ```
  - `mustChangePassword: true` est retourné pour les clients se connectant avec leur mot de passe provisoire — le frontend doit rediriger vers le changement de mot de passe.

- `POST /api/auth/refresh`
  - Rafraîchit l'access token
  - **Corps :**
    ```json
    {
      "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
    }
    ```
  - **Réponse `200` :**
    ```json
    {
      "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
    }
    ```

- `POST /api/auth/logout`
  - Déconnecte l'utilisateur
  - Requiert un header `Authorization: Bearer <token>`
  - **Réponse `200` :** corps vide

- `GET /api/auth/me`
  - Retourne le profil de l'utilisateur connecté
  - Requiert un token JWT valide
  - **Réponse `200` :**
    ```json
    {
      "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
      "agency_id": "550e8400-e29b-41d4-a716-446655440000",
      "first_name": "Jean",
      "last_name": "Dupont",
      "email": "jean.dupont@exemple.fr",
      "phone": "0612345678",
      "role": "agent",
      "is_active": true,
      "created_at": "2026-05-05T10:00:00.000Z"
    }
    ```

- `POST /api/auth/change-password`
  - Change le mot de passe de l'utilisateur connecté (obligatoire pour les clients à la première connexion)
  - Requiert un header `Authorization: Bearer <token>`
  - **Corps :**
    ```json
    {
      "currentPassword": "motDePasseActuel",
      "newPassword": "nouveauMotDePasse123"
    }
    ```
    Champs obligatoires : `currentPassword`, `newPassword` (minimum 8 caractères)
  - **Réponse `200` :**
    ```json
    { "message": "Mot de passe mis à jour avec succès." }
    ```
  - **Erreurs :** `401` si `currentPassword` incorrect, `400` si `newPassword` trop court

---

## Routes API

### Agencies

- `GET /api/agencies`
  - Liste toutes les agences
  - Public (aucun token requis)
  - **Réponse `200` :**
    ```json
    [
      {
        "id": "550e8400-e29b-41d4-a716-446655440000",
        "name": "Agence Centrale Immo",
        "siret": "12345678900014",
        "email": "contact@centrale-immo.fr",
        "phone": "0456789012",
        "address": "12 rue de la Paix",
        "city": "Lyon",
        "postal_code": "69001",
        "country": "FR",
        "created_at": "2026-01-15T08:30:00.000Z",
        "updated_at": "2026-03-20T14:00:00.000Z"
      }
    ]
    ```

- `POST /api/agencies`
  - Crée une agence
  - Requiert token + rôle `super_admin`
  - **Corps :**
    ```json
    {
      "name": "Agence Centrale Immo",
      "siret": "12345678900014",
      "email": "contact@centrale-immo.fr",
      "phone": "0456789012",
      "address": "12 rue de la Paix",
      "city": "Lyon",
      "postalCode": "69001",
      "country": "FR"
    }
    ```
    Champs obligatoires : `name`, `email`
  - **Réponse `201` :** objet agence (même structure que ci-dessus)

- `GET /api/agencies/{id}`
  - Détaille une agence
  - Public (aucun token requis)
  - **Réponse `200` :** objet agence (même structure que la liste)

- `PUT /api/agencies/{id}`
  - Met à jour une agence
  - Requiert token + rôle `super_admin` ou `agency_admin`
  - **Corps :** tous les champs sont optionnels
    ```json
    {
      "phone": "0498765432",
      "city": "Grenoble",
      "postalCode": "38000"
    }
    ```
  - **Réponse `200` :** objet agence mis à jour

- `DELETE /api/agencies/{id}`
  - Supprime une agence
  - Requiert token + rôle `super_admin`
  - **Réponse `204` :** corps vide

### Users

- `GET /api/users`
  - Liste les utilisateurs
  - Public (aucun token requis)
  - **Paramètres query :** `agencyId` (uuid, optionnel)
  - **Réponse `200` :**
    ```json
    [
      {
        "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
        "agency_id": "550e8400-e29b-41d4-a716-446655440000",
        "first_name": "Jean",
        "last_name": "Dupont",
        "email": "jean.dupont@exemple.fr",
        "phone": "0612345678",
        "role": "agent",
        "is_active": true,
        "created_at": "2026-05-05T10:00:00.000Z",
        "updated_at": "2026-05-05T10:00:00.000Z"
      }
    ]
    ```

- `GET /api/users/{id}`
  - Détaille un utilisateur
  - Public (aucun token requis)
  - **Réponse `200` :** objet utilisateur (même structure que la liste)

- `PUT /api/users/{id}`
  - Met à jour un utilisateur
  - Requiert token + rôle `super_admin` ou `agency_admin`
  - **Corps :** tous les champs sont optionnels
    ```json
    {
      "firstName": "Jean",
      "lastName": "Martin",
      "phone": "0699887766",
      "role": "agency_admin",
      "isActive": true,
      "agencyId": "550e8400-e29b-41d4-a716-446655440000",
      "password": "nouveauMotDePasse"
    }
    ```
  - **Réponse `200` :** objet utilisateur mis à jour

- `DELETE /api/users/{id}`
  - Supprime un utilisateur
  - Requiert token + rôle `super_admin` ou `agency_admin`
  - **Réponse `204` :** corps vide

### Properties

- `GET /api/properties`
  - Liste les biens immobiliers
  - Public (aucun token requis)
  - **Paramètres query :**
    | Paramètre | Type | Description |
    |---|---|---|
    | `agencyId` | uuid | Filtrer par agence |
    | `city` | string | Filtrer par ville (recherche partielle) |
    | `type` | string | `apartment` \| `house` \| `land` \| `commercial` \| `garage` \| `other` |
    | `transactionType` | string | `sale` \| `rent` |
    | `minPrice` | number | Prix minimum |
    | `maxPrice` | number | Prix maximum |
  - **Réponse `200` :**
    ```json
    [
      {
        "id": "b3c4d5e6-f7a8-9012-bcde-f12345678901",
        "agency_id": "550e8400-e29b-41d4-a716-446655440000",
        "created_by": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
        "title": "Appartement T3 centre-ville",
        "description": "Bel appartement lumineux avec vue dégagée.",
        "type": "apartment",
        "transaction_type": "sale",
        "price": 245000,
        "surface_area": 72.5,
        "rooms": 3,
        "bedrooms": 2,
        "bathrooms": 1,
        "floor": 3,
        "total_floors": 5,
        "construction_year": 1995,
        "has_parking": true,
        "has_balcony": true,
        "has_garden": false,
        "is_furnished": false,
        "is_available": true,
        "status": "available",
        "address": "8 place Bellecour",
        "city": "Lyon",
        "postal_code": "69002",
        "latitude": 45.7578,
        "longitude": 4.8320,
        "created_at": "2026-04-10T09:00:00.000Z",
        "updated_at": "2026-04-10T09:00:00.000Z",
        "tags": ["Parking", "Balcon"]
      }
    ]
    ```

- `POST /api/properties`
  - Crée un bien
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - **Corps :**
    ```json
    {
      "agencyId": "550e8400-e29b-41d4-a716-446655440000",
      "title": "Appartement T3 centre-ville",
      "description": "Bel appartement lumineux avec vue dégagée.",
      "type": "apartment",
      "transactionType": "sale",
      "price": 245000,
      "surfaceArea": 72.5,
      "rooms": 3,
      "bedrooms": 2,
      "bathrooms": 1,
      "floor": 3,
      "totalFloors": 5,
      "constructionYear": 1995,
      "hasParking": true,
      "hasBalcony": true,
      "hasGarden": false,
      "isFurnished": false,
      "isAvailable": true,
      "status": "available",
      "address": "8 place Bellecour",
      "city": "Lyon",
      "postalCode": "69002",
      "latitude": 45.7578,
      "longitude": 4.8320
    }
    ```
    Champs obligatoires : `agencyId`, `title`, `type`, `transactionType`, `address`, `city`  
    `type` : `apartment` | `house` | `land` | `commercial` | `garage` | `other`  
    `transactionType` : `sale` | `rent`  
    `status` : `available` | `under_offer` | `sold` | `rented`
  - **Réponse `201` :** objet bien (sans les champs `tags` et `images`)

- `GET /api/properties/{id}`
  - Détaille un bien
  - Public (aucun token requis)
  - **Réponse `200` :**
    ```json
    {
      "id": "b3c4d5e6-f7a8-9012-bcde-f12345678901",
      "title": "Appartement T3 centre-ville",
      "type": "apartment",
      "transaction_type": "sale",
      "price": 245000,
      "tags": [
        { "id": "t1a2b3c4-...", "label": "Parking", "color": "#3B82F6" },
        { "id": "t2b3c4d5-...", "label": "Balcon", "color": "#10B981" }
      ],
      "images": [
        {
          "id": "i1a2b3c4-...",
          "url": "https://cdn.exemple.fr/proprietes/salon.jpg",
          "altText": "Salon principal",
          "isCover": true,
          "displayOrder": 0
        }
      ]
    }
    ```

- `PUT /api/properties/{id}`
  - Met à jour un bien
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - **Corps :** tous les champs sont optionnels (mêmes clés que le POST, sans `agencyId`)
  - **Réponse `200` :** objet bien mis à jour

- `DELETE /api/properties/{id}`
  - Supprime un bien
  - Requiert token + rôle `super_admin` ou `agency_admin`
  - **Réponse `204` :** corps vide

- `GET /api/properties/{id}/images`
  - Liste les images du bien
  - Public (aucun token requis)
  - **Réponse `200` :**
    ```json
    [
      {
        "id": "i1a2b3c4-d5e6-7890-abcd-ef1234567890",
        "property_id": "b3c4d5e6-f7a8-9012-bcde-f12345678901",
        "url": "https://cdn.exemple.fr/proprietes/salon.jpg",
        "alt_text": "Salon principal",
        "is_cover": true,
        "display_order": 0
      }
    ]
    ```

- `POST /api/properties/{id}/images`
  - Ajoute une image au bien
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - **Corps :**
    ```json
    {
      "url": "https://cdn.exemple.fr/proprietes/cuisine.jpg",
      "altText": "Cuisine équipée",
      "isCover": false,
      "displayOrder": 1
    }
    ```
    Champ obligatoire : `url`
  - **Réponse `201` :** objet image (même structure que la liste)

- `POST /api/properties/{id}/tags`
  - Ajoute un tag au bien
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - **Corps :**
    ```json
    {
      "tagId": "t1a2b3c4-d5e6-7890-abcd-ef1234567890"
    }
    ```
  - **Réponse `204` :** corps vide

- `DELETE /api/properties/{id}/tags/{tagId}`
  - Retire un tag du bien
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - **Réponse `204` :** corps vide

### Tags

- `GET /api/tags`
  - Liste tous les tags
  - Requiert token
  - **Réponse `200` :**
    ```json
    [
      {
        "id": "t1a2b3c4-d5e6-7890-abcd-ef1234567890",
        "label": "Parking",
        "color": "#3B82F6"
      },
      {
        "id": "t2b3c4d5-e6f7-8901-bcde-f12345678902",
        "label": "Balcon",
        "color": "#10B981"
      }
    ]
    ```

- `POST /api/tags`
  - Crée un tag
  - Requiert token + rôle `super_admin` ou `agency_admin`
  - **Corps :**
    ```json
    {
      "label": "Parking",
      "color": "#3B82F6"
    }
    ```
    Champ obligatoire : `label`
  - **Réponse `201` :** objet tag (même structure que la liste)

- `DELETE /api/tags/{id}`
  - Supprime un tag
  - Requiert token + rôle `super_admin` ou `agency_admin`
  - **Réponse `204` :** corps vide

### Contacts

- `GET /api/contacts`
  - Liste les contacts
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - **Paramètres query :** `agencyId` (uuid, optionnel)
  - **Réponse `200` :**
    ```json
    [
      {
        "id": "c1d2e3f4-a5b6-7890-cdef-123456789012",
        "agency_id": "550e8400-e29b-41d4-a716-446655440000",
        "assigned_agent_id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
        "first_name": "Marie",
        "last_name": "Leblanc",
        "email": "marie.leblanc@email.fr",
        "phone": "0687654321",
        "contact_type": "buyer",
        "source": "website",
        "notes": "Recherche un T3 à Lyon.",
        "created_at": "2026-04-20T11:00:00.000Z",
        "updated_at": "2026-04-20T11:00:00.000Z"
      }
    ]
    ```

- `POST /api/contacts`
  - Crée un contact
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - **Corps :**
    ```json
    {
      "agencyId": "550e8400-e29b-41d4-a716-446655440000",
      "firstName": "Marie",
      "lastName": "Leblanc",
      "contactType": "buyer",
      "assignedAgentId": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
      "email": "marie.leblanc@email.fr",
      "phone": "0687654321",
      "source": "website",
      "notes": "Recherche un T3 à Lyon."
    }
    ```
    Champs obligatoires : `agencyId`, `firstName`, `lastName`, `contactType`  
    `contactType` : `buyer` | `seller` | `tenant` | `landlord` | `other`
  - **Réponse `201` :** objet contact (même structure que la liste)

- `GET /api/contacts/{id}`
  - Détaille un contact
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - **Réponse `200` :** objet contact (même structure que la liste)

- `PUT /api/contacts/{id}`
  - Met à jour un contact
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - **Corps :** tous les champs sont optionnels
    ```json
    {
      "phone": "0611223344",
      "notes": "Budget max 300 000 €.",
      "assignedAgentId": "a1b2c3d4-e5f6-7890-abcd-ef1234567890"
    }
    ```
  - **Réponse `200` :** objet contact mis à jour

- `DELETE /api/contacts/{id}`
  - Supprime un contact
  - Requiert token + rôle `super_admin` ou `agency_admin`
  - **Réponse `204` :** corps vide

### Clients

> Les clients sont des contacts qualifiés qui ont signé un contrat avec l'agence et disposent d'un accès authentifié à leur espace personnel.

- `POST /api/clients`
  - Crée un compte client à partir d'un contact existant. Génère un mot de passe provisoire retourné **une seule fois** dans la réponse.
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - **Corps :**
    ```json
    {
      "contactId": "c1d2e3f4-a5b6-7890-cdef-123456789012",
      "firstName": "Marie",
      "lastName": "Leblanc",
      "email": "marie.leblanc@email.fr",
      "phone": "0687654321",
      "propertyId": "b3c4d5e6-f7a8-9012-bcde-f12345678901",
      "assignedAgentId": "a1b2c3d4-e5f6-7890-abcd-ef1234567890"
    }
    ```
    Champs obligatoires : `contactId`, `firstName`, `lastName`, `email`  
    `agencyId` : obligatoire uniquement pour `super_admin` (les autres rôles héritent de leur agence)
  - **Réponse `201` :**
    ```json
    {
      "id": "cp1a2b3c-d4e5-6789-abcd-ef1234567890",
      "user_id": "u1a2b3c4-d5e6-7890-abcd-ef1234567890",
      "contact_id": "c1d2e3f4-a5b6-7890-cdef-123456789012",
      "agency_id": "550e8400-e29b-41d4-a716-446655440000",
      "property_id": "b3c4d5e6-f7a8-9012-bcde-f12345678901",
      "assigned_agent_id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
      "firstName": "Marie",
      "lastName": "Leblanc",
      "email": "marie.leblanc@email.fr",
      "phone": "0687654321",
      "isActive": true,
      "mustChangePassword": true,
      "temporaryPassword": "aB3xQ7mP2wRs",
      "created_at": "2026-05-28T10:00:00.000Z"
    }
    ```
  > ⚠️ `temporaryPassword` n'est visible qu'à la création. L'agent doit le transmettre au client hors ligne (SMS, email). Il ne peut plus être consulté ensuite (utiliser reset-password pour en générer un nouveau).

- `GET /api/clients`
  - Liste les clients de l'agence
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - **Paramètres query :** `agencyId` (uuid, pour `super_admin` uniquement)
  - **Réponse `200` :** tableau de profils clients (sans données financières sensibles)

- `GET /api/clients/portal`
  - Tableau de bord du client connecté : profil, bien associé, offres, visites et documents
  - Requiert token + rôle `client`
  - **Réponse `200` :**
    ```json
    {
      "id": "u1a2b3c4-d5e6-7890-abcd-ef1234567890",
      "first_name": "Marie",
      "last_name": "Leblanc",
      "email": "marie.leblanc@email.fr",
      "iban": "FR76 1234 5678 9012 3456 7890 189",
      "bic": "BNPAFRPP",
      "bank_name": "BNP Paribas",
      "monthly_income": 3200.00,
      "employment_type": "employee",
      "property": { "id": "...", "title": "Appartement T3 centre-ville", "price": 245000 },
      "offers": [
        { "id": "...", "amount": 238000, "status": "pending", "createdAt": "2026-05-01T14:00:00.000Z" }
      ],
      "visits": [
        { "id": "...", "scheduledAt": "2026-05-10T14:00:00.000Z", "status": "scheduled" }
      ],
      "documents": [
        { "id": "...", "name": "Compromis de vente", "documentType": "contract", "fileUrl": "https://..." }
      ]
    }
    ```

- `GET /api/clients/{id}`
  - Détaille un profil client (vue agent)
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - **Réponse `200` :** profil complet avec informations financières

- `PUT /api/clients/{id}`
  - Met à jour un client
  - Rôles `super_admin`, `agency_admin`, `agent` : peuvent modifier tous les champs
  - Rôle `client` : peut modifier **uniquement** les champs financiers (`iban`, `bic`, `bankName`, `monthlyIncome`, `employmentType`) et seulement son propre profil
  - **Corps (agent) :**
    ```json
    {
      "firstName": "Marie",
      "lastName": "Martin",
      "phone": "0611223344",
      "isActive": true,
      "propertyId": "b3c4d5e6-f7a8-9012-bcde-f12345678901",
      "assignedAgentId": "a1b2c3d4-e5f6-7890-abcd-ef1234567890"
    }
    ```
  - **Corps (client — champs financiers uniquement) :**
    ```json
    {
      "iban": "FR76 1234 5678 9012 3456 7890 189",
      "bic": "BNPAFRPP",
      "bankName": "BNP Paribas",
      "monthlyIncome": 3200.00,
      "employmentType": "employee"
    }
    ```
    `employmentType` : `employee` | `self_employed` | `civil_servant` | `retired` | `student` | `unemployed` | `other`
  - **Réponse `200` :** profil client mis à jour

- `DELETE /api/clients/{id}`
  - Supprime le compte client (supprime également le compte utilisateur associé, le contact source est préservé)
  - Requiert token + rôle `super_admin` ou `agency_admin`
  - **Réponse `204` :** corps vide

- `POST /api/clients/{id}/reset-password`
  - Régénère un nouveau mot de passe provisoire et force le changement à la prochaine connexion
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - **Réponse `200` :**
    ```json
    { "temporaryPassword": "xK9mP2nQ4wRs" }
    ```
  > ⚠️ Visible une seule fois.

### Mandates

- `GET /api/mandates`
  - Liste les mandats
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - **Paramètres query :** `agencyId` (uuid, optionnel)
  - **Réponse `200` :**
    ```json
    [
      {
        "id": "m1n2o3p4-q5r6-7890-stuv-123456789012",
        "property_id": "b3c4d5e6-f7a8-9012-bcde-f12345678901",
        "agency_id": "550e8400-e29b-41d4-a716-446655440000",
        "agent_id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
        "mandate_type": "sale",
        "start_date": "2026-04-01",
        "end_date": "2026-10-01",
        "commission_rate": 5.00,
        "is_exclusive": true,
        "status": "active",
        "created_at": "2026-04-01T08:00:00.000Z",
        "updated_at": "2026-04-01T08:00:00.000Z"
      }
    ]
    ```

- `POST /api/mandates`
  - Crée un mandat
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - **Corps :**
    ```json
    {
      "propertyId": "b3c4d5e6-f7a8-9012-bcde-f12345678901",
      "agencyId": "550e8400-e29b-41d4-a716-446655440000",
      "agentId": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
      "mandateType": "sale",
      "startDate": "2026-04-01",
      "endDate": "2026-10-01",
      "commissionRate": 5.00,
      "isExclusive": true,
      "status": "active"
    }
    ```
    Champs obligatoires : `propertyId`, `agencyId`, `agentId`, `mandateType`, `startDate`  
    `mandateType` : `sale` | `rent`  
    `status` : `active` | `expired` | `terminated`
  - **Réponse `201` :** objet mandat (même structure que la liste)

- `GET /api/mandates/{id}`
  - Détaille un mandat
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - **Réponse `200` :**
    ```json
    {
      "id": "m1n2o3p4-q5r6-7890-stuv-123456789012",
      "property_id": "b3c4d5e6-f7a8-9012-bcde-f12345678901",
      "mandate_type": "sale",
      "status": "active",
      "contacts": [
        { "contactId": "c1d2e3f4-a5b6-7890-cdef-123456789012", "role": "seller" }
      ]
    }
    ```

- `PUT /api/mandates/{id}`
  - Met à jour un mandat
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - **Corps :** tous les champs sont optionnels
    ```json
    {
      "status": "terminated",
      "endDate": "2026-07-15"
    }
    ```
  - **Réponse `200` :** objet mandat mis à jour

- `DELETE /api/mandates/{id}`
  - Supprime un mandat
  - Requiert token + rôle `super_admin` ou `agency_admin`
  - **Réponse `204` :** corps vide

- `POST /api/mandates/{id}/contacts`
  - Associe un contact à un mandat
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - **Corps :**
    ```json
    {
      "contactId": "c1d2e3f4-a5b6-7890-cdef-123456789012",
      "role": "seller"
    }
    ```
    Champs obligatoires : `contactId`, `role`
  - **Réponse `204` :** corps vide

### Offers

- `GET /api/offers`
  - Liste les offres
  - Public (aucun token requis)
  - **Paramètres query :** `propertyId` (uuid), `contactId` (uuid) — optionnels
  - **Réponse `200` :**
    ```json
    [
      {
        "id": "o1p2q3r4-s5t6-7890-uvwx-123456789012",
        "property_id": "b3c4d5e6-f7a8-9012-bcde-f12345678901",
        "contact_id": "c1d2e3f4-a5b6-7890-cdef-123456789012",
        "agent_id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
        "amount": 238000,
        "conditions": "Sous réserve d'obtention du prêt.",
        "validity_date": "2026-06-01",
        "status": "pending",
        "rejection_reason": null,
        "created_at": "2026-05-01T14:00:00.000Z",
        "updated_at": "2026-05-01T14:00:00.000Z"
      }
    ]
    ```

- `POST /api/offers`
  - Crée une offre
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - **Corps :**
    ```json
    {
      "propertyId": "b3c4d5e6-f7a8-9012-bcde-f12345678901",
      "contactId": "c1d2e3f4-a5b6-7890-cdef-123456789012",
      "agentId": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
      "amount": 238000,
      "conditions": "Sous réserve d'obtention du prêt.",
      "validityDate": "2026-06-01",
      "status": "pending"
    }
    ```
    Champs obligatoires : `propertyId`, `contactId`, `agentId`, `amount`  
    `status` : `pending` | `accepted` | `rejected` | `withdrawn`
  - **Réponse `201` :** objet offre (même structure que la liste)

- `GET /api/offers/{id}`
  - Détaille une offre
  - Public (aucun token requis)
  - **Réponse `200` :** objet offre (même structure que la liste)

- `PUT /api/offers/{id}`
  - Met à jour une offre (accepter, refuser…)
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - **Corps :** tous les champs sont optionnels
    ```json
    {
      "status": "rejected",
      "rejectionReason": "Prix trop bas.",
      "amount": 240000,
      "validityDate": "2026-06-15"
    }
    ```
  - **Réponse `200` :** objet offre mis à jour

- `DELETE /api/offers/{id}`
  - Supprime une offre
  - Requiert token + rôle `super_admin` ou `agency_admin`
  - **Réponse `204` :** corps vide

### Visits

- `GET /api/visits`
  - Liste les visites
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - **Paramètres query :** `agentId` (uuid), `propertyId` (uuid), `contactId` (uuid) — optionnels
  - **Réponse `200` :**
    ```json
    [
      {
        "id": "v1w2x3y4-z5a6-7890-bcde-123456789012",
        "property_id": "b3c4d5e6-f7a8-9012-bcde-f12345678901",
        "contact_id": "c1d2e3f4-a5b6-7890-cdef-123456789012",
        "agent_id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
        "scheduled_at": "2026-05-10T14:00:00.000Z",
        "duration_minutes": 45,
        "status": "scheduled",
        "notes": "Prévoir les clés du garage.",
        "feedback": null,
        "created_at": "2026-05-05T09:00:00.000Z",
        "updated_at": "2026-05-05T09:00:00.000Z"
      }
    ]
    ```

- `POST /api/visits`
  - Planifie une visite
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - **Corps :**
    ```json
    {
      "propertyId": "b3c4d5e6-f7a8-9012-bcde-f12345678901",
      "contactId": "c1d2e3f4-a5b6-7890-cdef-123456789012",
      "agentId": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
      "scheduledAt": "2026-05-10T14:00:00.000Z",
      "durationMinutes": 45,
      "status": "scheduled",
      "notes": "Prévoir les clés du garage."
    }
    ```
    Champs obligatoires : `propertyId`, `contactId`, `agentId`, `scheduledAt`  
    `status` : `scheduled` | `done` | `cancelled`  
    `durationMinutes` par défaut : `30`
  - **Réponse `201` :** objet visite (même structure que la liste)

- `GET /api/visits/{id}`
  - Détaille une visite
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - **Réponse `200` :** objet visite (même structure que la liste)

- `PUT /api/visits/{id}`
  - Met à jour une visite
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - **Corps :** tous les champs sont optionnels
    ```json
    {
      "scheduledAt": "2026-05-12T10:00:00.000Z",
      "status": "done",
      "feedback": "Client très intéressé."
    }
    ```
  - **Réponse `200` :** objet visite mis à jour

- `DELETE /api/visits/{id}`
  - Annule une visite
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - **Réponse `204` :** corps vide

### Documents

- `GET /api/documents`
  - Liste les documents
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - **Paramètres query :** `propertyId` (uuid), `contactId` (uuid), `offerId` (uuid) — optionnels
  - **Réponse `200` :**
    ```json
    [
      {
        "id": "d1e2f3g4-h5i6-7890-jklm-123456789012",
        "property_id": "b3c4d5e6-f7a8-9012-bcde-f12345678901",
        "contact_id": null,
        "offer_id": null,
        "name": "Diagnostics DPE",
        "document_type": "dpe",
        "file_url": "https://cdn.exemple.fr/docs/dpe-lyon.pdf",
        "mime_type": "application/pdf",
        "file_size_kb": 512,
        "uploaded_at": "2026-05-03T10:00:00.000Z"
      }
    ]
    ```

- `POST /api/documents`
  - Enregistre un document
  - Requiert token + rôle `super_admin`, `agency_admin` ou `agent`
  - **Corps :**
    ```json
    {
      "name": "Diagnostics DPE",
      "documentType": "dpe",
      "fileUrl": "https://cdn.exemple.fr/docs/dpe-lyon.pdf",
      "mimeType": "application/pdf",
      "fileSizeKb": 512,
      "propertyId": "b3c4d5e6-f7a8-9012-bcde-f12345678901",
      "contactId": null,
      "offerId": null
    }
    ```
    Champs obligatoires : `name`, `documentType`, `fileUrl`
  - **Réponse `201` :** objet document (même structure que la liste)

- `GET /api/documents/{id}`
  - Détaille un document
  - Requiert token
  - **Réponse `200` :** objet document (même structure que la liste)

- `DELETE /api/documents/{id}`
  - Supprime un document
  - Requiert token + rôle `super_admin` ou `agency_admin`
  - **Réponse `204` :** corps vide

### Conversations (messagerie)

- `GET /api/conversations`
  - Récupère les conversations de l'utilisateur connecté
  - Requiert token
  - **Réponse `200` :**
    ```json
    [
      {
        "id": "conv1234-abcd-5678-efgh-ijklmnopqrst",
        "agency_id": "550e8400-e29b-41d4-a716-446655440000",
        "property_id": "b3c4d5e6-f7a8-9012-bcde-f12345678901",
        "contact_id": null,
        "conversation_type": "internal",
        "title": "Dossier Appartement Bellecour",
        "created_at": "2026-05-01T10:00:00.000Z",
        "members": [
          "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
          "b2c3d4e5-f6a7-8901-bcde-f12345678901"
        ]
      }
    ]
    ```

- `POST /api/conversations`
  - Crée une conversation
  - Requiert token
  - **Corps :**
    ```json
    {
      "conversationType": "internal",
      "title": "Dossier Appartement Bellecour",
      "userIds": [
        "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
        "b2c3d4e5-f6a7-8901-bcde-f12345678901"
      ],
      "agencyId": "550e8400-e29b-41d4-a716-446655440000",
      "propertyId": "b3c4d5e6-f7a8-9012-bcde-f12345678901",
      "contactId": null
    }
    ```
    Champs obligatoires : `conversationType`, `userIds`  
    `conversationType` : `internal` | `client` | `support`
  - **Réponse `201` :**
    ```json
    {
      "id": "conv1234-abcd-5678-efgh-ijklmnopqrst",
      "agency_id": "550e8400-e29b-41d4-a716-446655440000",
      "property_id": "b3c4d5e6-f7a8-9012-bcde-f12345678901",
      "contact_id": null,
      "conversation_type": "internal",
      "title": "Dossier Appartement Bellecour",
      "created_at": "2026-05-05T10:00:00.000Z"
    }
    ```

- `GET /api/conversations/{id}`
  - Détaille une conversation
  - Requiert token
  - **Réponse `200` :** objet conversation (sans le champ `members`)

- `POST /api/conversations/{id}/users`
  - Ajoute un utilisateur à une conversation
  - Requiert token
  - **Corps :**
    ```json
    {
      "userId": "c3d4e5f6-a7b8-9012-cdef-123456789012"
    }
    ```
  - **Réponse `204` :** corps vide

- `GET /api/conversations/{id}/messages`
  - Récupère les messages d'une conversation
  - Requiert token
  - **Paramètres query :**
    | Paramètre | Type | Défaut | Description |
    |---|---|---|---|
    | `limit` | integer | 50 | Nombre de messages à récupérer |
    | `before` | datetime (ISO 8601) | — | Pagination : messages antérieurs à cette date |
  - **Réponse `200` :**
    ```json
    [
      {
        "id": "msg1234-abcd-5678-efgh-ijklmnopqrst",
        "conversation_id": "conv1234-abcd-5678-efgh-ijklmnopqrst",
        "sender_id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
        "first_name": "Jean",
        "last_name": "Dupont",
        "content": "Bonjour, le client confirme la visite de demain.",
        "message_type": "text",
        "is_deleted": false,
        "sent_at": "2026-05-05T11:30:00.000Z"
      }
    ]
    ```

- `POST /api/conversations/{id}/messages`
  - Envoie un message dans une conversation (déclenche aussi un événement Socket.IO `message:new`)
  - Requiert token
  - **Corps :**
    ```json
    {
      "content": "Bonjour, le client confirme la visite de demain.",
      "messageType": "text"
    }
    ```
    Champ obligatoire : `content`  
    `messageType` : `text` | `image` | `file` | `system` (défaut : `text`)
  - **Réponse `201` :**
    ```json
    {
      "id": "msg1234-abcd-5678-efgh-ijklmnopqrst",
      "conversation_id": "conv1234-abcd-5678-efgh-ijklmnopqrst",
      "sender_id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
      "content": "Bonjour, le client confirme la visite de demain.",
      "message_type": "text",
      "is_deleted": false,
      "sent_at": "2026-05-05T11:30:00.000Z"
    }
    ```

- `DELETE /api/conversations/{id}/messages/{messageId}`
  - Supprime un message (soft delete — seul l'expéditeur peut supprimer son propre message)
  - Requiert token
  - **Réponse `204` :** corps vide

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

- Le préfixe global est défini dans `src/app.js` : `app.use('/api', routes)`.
- La documentation Swagger est chargée via `src/config/swagger.js`.
- La logique métier est dans `src/controllers/` et `src/services/`.
