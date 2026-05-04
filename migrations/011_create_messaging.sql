-- Migration 011: Create conversations, conversation_users and messages tables
CREATE TABLE IF NOT EXISTS conversations (
    id                UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    agency_id         UUID REFERENCES agencies(id) ON DELETE SET NULL,
    property_id       UUID REFERENCES properties(id) ON DELETE SET NULL,
    contact_id        UUID REFERENCES contacts(id) ON DELETE SET NULL,
    conversation_type VARCHAR(20) NOT NULL CHECK (conversation_type IN ('internal', 'client', 'support')),
    title             VARCHAR(255),
    created_at        TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS conversation_users (
    conversation_id UUID NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
    user_id         UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    joined_at       TIMESTAMP DEFAULT NOW(),
    last_read_at    TIMESTAMP,
    PRIMARY KEY (conversation_id, user_id)
);

CREATE TABLE IF NOT EXISTS messages (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    conversation_id UUID NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
    sender_id       UUID NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    content         TEXT NOT NULL,
    message_type    VARCHAR(20) NOT NULL DEFAULT 'text' CHECK (message_type IN ('text', 'image', 'file', 'system')),
    sent_at         TIMESTAMP DEFAULT NOW(),
    is_deleted      BOOLEAN DEFAULT FALSE,
    deleted_at      TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT NOW()
);
