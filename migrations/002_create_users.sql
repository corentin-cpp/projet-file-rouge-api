-- Migration 002: Create users table
CREATE TABLE IF NOT EXISTS users (
    id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    agency_id     UUID REFERENCES agencies(id) ON DELETE SET NULL,
    first_name    VARCHAR(100) NOT NULL,
    last_name     VARCHAR(100) NOT NULL,
    email         VARCHAR(255) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    phone         VARCHAR(20),
    role          VARCHAR(30) NOT NULL CHECK (role IN ('super_admin', 'agency_admin', 'agent', 'client')),
    is_active     BOOLEAN DEFAULT TRUE,
    refresh_token TEXT,
    created_at    TIMESTAMP DEFAULT NOW(),
    updated_at    TIMESTAMP DEFAULT NOW()
);
