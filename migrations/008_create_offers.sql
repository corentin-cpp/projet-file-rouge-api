-- Migration 008: Create offers table
CREATE TABLE IF NOT EXISTS offers (
    id               UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id      UUID NOT NULL REFERENCES properties(id) ON DELETE CASCADE,
    contact_id       UUID NOT NULL REFERENCES contacts(id) ON DELETE CASCADE,
    agent_id         UUID NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    amount           DECIMAL(12, 2) NOT NULL,
    conditions       TEXT,
    validity_date    DATE,
    status           VARCHAR(20) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'accepted', 'rejected', 'withdrawn', 'counter_offered')),
    rejection_reason TEXT,
    created_at       TIMESTAMP DEFAULT NOW(),
    updated_at       TIMESTAMP DEFAULT NOW()
);
