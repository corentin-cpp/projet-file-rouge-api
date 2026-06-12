-- Migration 016: Seed client users and client_profiles
-- 2 clients per agency, each linked to an existing contact and property
-- Password for all: Ymmo2024!

BEGIN;

-- =============================================================================
-- UTILISATEURS CLIENTS
-- hash = bcrypt("Ymmo2024!", 12)
-- =============================================================================

-- ── Paris ────────────────────────────────────────────────────────────────────
INSERT INTO users (id, agency_id, first_name, last_name, email, password_hash, phone, role, must_change_password) VALUES
  ('bc100000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001',
   'François', 'Lemaire', 'portal.francois.lemaire@ymmo.fr',
   '$2b$12$YxjeeD9UWW41k8r/bfYihOF2pRI/Naer4S5Fiwc5lynvbyEhj/Fxq',
   '0601010101', 'client', FALSE),

  ('bc100000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000001',
   'Aurélie', 'Morin', 'portal.aurelie.morin@ymmo.fr',
   '$2b$12$YxjeeD9UWW41k8r/bfYihOF2pRI/Naer4S5Fiwc5lynvbyEhj/Fxq',
   '0604040404', 'client', TRUE);

-- ── Lyon ─────────────────────────────────────────────────────────────────────
INSERT INTO users (id, agency_id, first_name, last_name, email, password_hash, phone, role, must_change_password) VALUES
  ('bc200000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000002',
   'Bertrand', 'Charpentier', 'portal.bertrand.charpentier@ymmo.fr',
   '$2b$12$YxjeeD9UWW41k8r/bfYihOF2pRI/Naer4S5Fiwc5lynvbyEhj/Fxq',
   '0612121212', 'client', FALSE),

  ('bc200000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000002',
   'Éric', 'Blanc', 'portal.eric.blanc@ymmo.fr',
   '$2b$12$YxjeeD9UWW41k8r/bfYihOF2pRI/Naer4S5Fiwc5lynvbyEhj/Fxq',
   '0614141414', 'client', TRUE);

-- ── Bordeaux ──────────────────────────────────────────────────────────────────
INSERT INTO users (id, agency_id, first_name, last_name, email, password_hash, phone, role, must_change_password) VALUES
  ('bc300000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000003',
   'Stéphane', 'Legrand', 'portal.stephane.legrand@ymmo.fr',
   '$2b$12$YxjeeD9UWW41k8r/bfYihOF2pRI/Naer4S5Fiwc5lynvbyEhj/Fxq',
   '0623232323', 'client', FALSE),

  ('bc300000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000003',
   'Cédric', 'Roy', 'portal.cedric.roy@ymmo.fr',
   '$2b$12$YxjeeD9UWW41k8r/bfYihOF2pRI/Naer4S5Fiwc5lynvbyEhj/Fxq',
   '0625252525', 'client', TRUE);

-- ── Aix-en-Provence ───────────────────────────────────────────────────────────
INSERT INTO users (id, agency_id, first_name, last_name, email, password_hash, phone, role, must_change_password) VALUES
  ('bc400000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000004',
   'Jean-Marc', 'Faure', 'portal.jeanmarc.faure@ymmo.fr',
   '$2b$12$YxjeeD9UWW41k8r/bfYihOF2pRI/Naer4S5Fiwc5lynvbyEhj/Fxq',
   '0634343434', 'client', FALSE),

  ('bc400000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000004',
   'Romain', 'Chevallier', 'portal.romain.chevallier@ymmo.fr',
   '$2b$12$YxjeeD9UWW41k8r/bfYihOF2pRI/Naer4S5Fiwc5lynvbyEhj/Fxq',
   '0636363636', 'client', TRUE);

-- =============================================================================
-- PROFILS CLIENTS
-- Préfixe c0 (hex valide) pour distinguer des contacts c1-c4
-- Chaque profil lie : user ↔ contact ↔ agence ↔ bien ↔ agent référent
-- =============================================================================

-- ── Paris ────────────────────────────────────────────────────────────────────
INSERT INTO client_profiles (id, user_id, contact_id, agency_id, property_id, assigned_agent_id, iban, bic, bank_name, monthly_income, employment_type) VALUES
  -- François Lemaire : acheteur intéressé par l'appartement du Marais
  ('c0100000-0000-0000-0000-000000000001',
   'bc100000-0000-0000-0000-000000000001',
   'c1000000-0000-0000-0000-000000000001',
   'a1000000-0000-0000-0000-000000000001',
   'e1000000-0000-0000-0000-000000000001',
   'b1000000-0000-0000-0000-000000000002',
   'FR7630006000011234567890189', 'BNPAFRPPXXX', 'BNP Paribas', 8500.00, 'employee'),

  -- Aurélie Morin : locataire pour le T3 Montparnasse
  ('c0100000-0000-0000-0000-000000000002',
   'bc100000-0000-0000-0000-000000000002',
   'c1000000-0000-0000-0000-000000000004',
   'a1000000-0000-0000-0000-000000000001',
   'e1000000-0000-0000-0000-000000000003',
   'b1000000-0000-0000-0000-000000000004',
   'FR7614508020001234567890112', 'AGRIFRPPXXX', 'Crédit Agricole', 3200.00, 'employee');

-- ── Lyon ─────────────────────────────────────────────────────────────────────
INSERT INTO client_profiles (id, user_id, contact_id, agency_id, property_id, assigned_agent_id, iban, bic, bank_name, monthly_income, employment_type) VALUES
  -- Bertrand Charpentier : acheteur T4 Presqu'île
  ('c0200000-0000-0000-0000-000000000001',
   'bc200000-0000-0000-0000-000000000001',
   'c2000000-0000-0000-0000-000000000001',
   'a1000000-0000-0000-0000-000000000002',
   'e2000000-0000-0000-0000-000000000001',
   'b2000000-0000-0000-0000-000000000002',
   'FR7617569000401234567890034', 'SOGEFRPPXXX', 'Société Générale', 6800.00, 'employee'),

  -- Éric Blanc : investisseur studio Part-Dieu
  ('c0200000-0000-0000-0000-000000000002',
   'bc200000-0000-0000-0000-000000000002',
   'c2000000-0000-0000-0000-000000000003',
   'a1000000-0000-0000-0000-000000000002',
   'e2000000-0000-0000-0000-000000000004',
   'b2000000-0000-0000-0000-000000000003',
   'FR7610096000501234567890015', 'CMCIFRPPXXX', 'CIC', 9200.00, 'self_employed');

-- ── Bordeaux ──────────────────────────────────────────────────────────────────
INSERT INTO client_profiles (id, user_id, contact_id, agency_id, property_id, assigned_agent_id, iban, bic, bank_name, monthly_income, employment_type) VALUES
  -- Stéphane Legrand : acheteur appartement Chartrons
  ('c0300000-0000-0000-0000-000000000001',
   'bc300000-0000-0000-0000-000000000001',
   'c3000000-0000-0000-0000-000000000001',
   'a1000000-0000-0000-0000-000000000003',
   'e3000000-0000-0000-0000-000000000001',
   'b3000000-0000-0000-0000-000000000002',
   'FR7630004000031234567890143', 'BNPAFRPPXXX', 'BNP Paribas', 5400.00, 'civil_servant'),

  -- Cédric Roy : locataire loft Saint-Michel
  ('c0300000-0000-0000-0000-000000000002',
   'bc300000-0000-0000-0000-000000000002',
   'c3000000-0000-0000-0000-000000000003',
   'a1000000-0000-0000-0000-000000000003',
   'e3000000-0000-0000-0000-000000000004',
   'b3000000-0000-0000-0000-000000000002',
   'FR7613135000801234567890062', 'CEPAFRPPXXX', 'Caisse d''Épargne', 2800.00, 'employee');

-- ── Aix-en-Provence ───────────────────────────────────────────────────────────
INSERT INTO client_profiles (id, user_id, contact_id, agency_id, property_id, assigned_agent_id, iban, bic, bank_name, monthly_income, employment_type) VALUES
  -- Jean-Marc Faure : acheteur bastide prestige
  ('c0400000-0000-0000-0000-000000000001',
   'bc400000-0000-0000-0000-000000000001',
   'c4000000-0000-0000-0000-000000000001',
   'a1000000-0000-0000-0000-000000000004',
   'e4000000-0000-0000-0000-000000000001',
   'b4000000-0000-0000-0000-000000000002',
   'FR7620041010051234567890095', 'BREDFRPPXXX', 'Bred Banque Populaire', 24000.00, 'self_employed'),

  -- Romain Chevallier : locataire studio campus
  ('c0400000-0000-0000-0000-000000000002',
   'bc400000-0000-0000-0000-000000000002',
   'c4000000-0000-0000-0000-000000000003',
   'a1000000-0000-0000-0000-000000000004',
   'e4000000-0000-0000-0000-000000000004',
   'b4000000-0000-0000-0000-000000000003',
   'FR7614508070001234567890126', 'AGRIFRPPXXX', 'Crédit Agricole', 650.00, 'student');

COMMIT;
