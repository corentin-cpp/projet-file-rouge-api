-- Migration 007: Create mandates and mandate_contacts tables
CREATE TABLE IF NOT EXISTS mandates (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id     UUID NOT NULL REFERENCES properties(id) ON DELETE CASCADE,
    agency_id       UUID NOT NULL REFERENCES agencies(id) ON DELETE CASCADE,
    agent_id        UUID NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    mandate_type    VARCHAR(20) NOT NULL CHECK (mandate_type IN ('simple', 'exclusive', 'semi_exclusive')),
    start_date      DATE NOT NULL,
    end_date        DATE,
    commission_rate DECIMAL(5, 2),
    is_exclusive    BOOLEAN DEFAULT FALSE,
    status          VARCHAR(20) NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'expired', 'cancelled', 'completed')),
    created_at      TIMESTAMP DEFAULT NOW(),
    updated_at      TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS mandate_contacts (
    mandate_id UUID NOT NULL REFERENCES mandates(id) ON DELETE CASCADE,
    contact_id UUID NOT NULL REFERENCES contacts(id) ON DELETE CASCADE,
    role       VARCHAR(30) NOT NULL,
    PRIMARY KEY (mandate_id, contact_id)
);
