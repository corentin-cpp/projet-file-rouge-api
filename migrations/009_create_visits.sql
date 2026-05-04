-- Migration 009: Create visits table
CREATE TABLE IF NOT EXISTS visits (
    id               UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id      UUID NOT NULL REFERENCES properties(id) ON DELETE CASCADE,
    contact_id       UUID NOT NULL REFERENCES contacts(id) ON DELETE CASCADE,
    agent_id         UUID NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    scheduled_at     TIMESTAMP NOT NULL,
    duration_minutes INTEGER DEFAULT 30,
    status           VARCHAR(20) NOT NULL DEFAULT 'scheduled' CHECK (status IN ('scheduled', 'confirmed', 'completed', 'cancelled', 'no_show')),
    notes            TEXT,
    feedback         TEXT,
    created_at       TIMESTAMP DEFAULT NOW(),
    updated_at       TIMESTAMP DEFAULT NOW()
);
