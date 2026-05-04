-- Migration 004: Create tags and property_tags tables
CREATE TABLE IF NOT EXISTS tags (
    id     UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    label  VARCHAR(100) UNIQUE NOT NULL,
    color  VARCHAR(7)
);

CREATE TABLE IF NOT EXISTS property_tags (
    property_id UUID NOT NULL REFERENCES properties(id) ON DELETE CASCADE,
    tag_id      UUID NOT NULL REFERENCES tags(id) ON DELETE CASCADE,
    PRIMARY KEY (property_id, tag_id)
);
