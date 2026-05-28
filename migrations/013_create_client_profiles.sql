-- Migration 013: Add client support columns to users + create client_profiles

ALTER TABLE users
  ADD COLUMN IF NOT EXISTS must_change_password BOOLEAN NOT NULL DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS temp_password_hash    TEXT;

CREATE TABLE IF NOT EXISTS client_profiles (
  id                UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id           UUID NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
  contact_id        UUID NOT NULL REFERENCES contacts(id) ON DELETE RESTRICT,
  agency_id         UUID NOT NULL REFERENCES agencies(id) ON DELETE CASCADE,
  property_id       UUID REFERENCES properties(id) ON DELETE SET NULL,
  assigned_agent_id UUID REFERENCES users(id) ON DELETE SET NULL,
  iban              VARCHAR(34),
  bic               VARCHAR(11),
  bank_name         VARCHAR(100),
  monthly_income    DECIMAL(10,2),
  employment_type   VARCHAR(30) CHECK (employment_type IN (
                      'employee', 'self_employed', 'civil_servant',
                      'retired', 'student', 'unemployed', 'other'
                    )),
  created_at        TIMESTAMP DEFAULT NOW(),
  updated_at        TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_client_profiles_agency_id   ON client_profiles(agency_id);
CREATE INDEX IF NOT EXISTS idx_client_profiles_contact_id  ON client_profiles(contact_id);
CREATE INDEX IF NOT EXISTS idx_client_profiles_property_id ON client_profiles(property_id);
