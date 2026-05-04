-- Migration 005: Create property_images table
CREATE TABLE IF NOT EXISTS property_images (
    id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id   UUID NOT NULL REFERENCES properties(id) ON DELETE CASCADE,
    url           VARCHAR(1024) NOT NULL,
    alt_text      VARCHAR(255),
    is_cover      BOOLEAN DEFAULT FALSE,
    display_order INTEGER DEFAULT 0,
    created_at    TIMESTAMP DEFAULT NOW(),
    updated_at    TIMESTAMP DEFAULT NOW()
);
