-- Migration 006: Create contacts table
CREATE TABLE IF NOT EXISTS contacts (
    id                UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    agency_id         UUID NOT NULL REFERENCES agencies(id) ON DELETE CASCADE,
    assigned_agent_id UUID REFERENCES users(id) ON DELETE SET NULL,
    first_name        VARCHAR(100) NOT NULL,
    last_name         VARCHAR(100) NOT NULL,
    email             VARCHAR(255),
    phone             VARCHAR(20),
    contact_type      VARCHAR(20) NOT NULL CHECK (contact_type IN ('buyer', 'seller', 'tenant', 'landlord', 'investor', 'other')),
    source            VARCHAR(20) CHECK (source IN ('website', 'referral', 'ad', 'walk_in', 'phone', 'other')),
    notes             TEXT,
    created_at        TIMESTAMP DEFAULT NOW(),
    updated_at        TIMESTAMP DEFAULT NOW()
);
