-- Migration 001: Create agencies table
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS agencies (
    id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name          VARCHAR(255) NOT NULL,
    siret         VARCHAR(14) UNIQUE,
    email         VARCHAR(255) NOT NULL,
    phone         VARCHAR(20),
    address       TEXT,
    city          VARCHAR(100),
    postal_code   VARCHAR(10),
    country       VARCHAR(3) DEFAULT 'FR',
    created_at    TIMESTAMP DEFAULT NOW(),
    updated_at    TIMESTAMP DEFAULT NOW()
);
