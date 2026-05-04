-- Migration 010: Create documents table
CREATE TABLE IF NOT EXISTS documents (
    id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id   UUID REFERENCES properties(id) ON DELETE CASCADE,
    contact_id    UUID REFERENCES contacts(id) ON DELETE SET NULL,
    offer_id      UUID REFERENCES offers(id) ON DELETE SET NULL,
    name          VARCHAR(255) NOT NULL,
    document_type VARCHAR(30) NOT NULL CHECK (document_type IN ('contract', 'id_card', 'tax_notice', 'bank_statement', 'diagnostics', 'photo', 'other')),
    file_url      VARCHAR(1024) NOT NULL,
    mime_type     VARCHAR(100),
    file_size_kb  INTEGER,
    uploaded_at   TIMESTAMP DEFAULT NOW(),
    updated_at    TIMESTAMP DEFAULT NOW()
);
