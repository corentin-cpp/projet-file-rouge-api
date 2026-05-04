-- =============================================================================
-- YMMO — Script de données de test
-- Mot de passe de tous les utilisateurs : Ymmo2024!
-- =============================================================================

BEGIN;

-- =============================================================================
-- AGENCES
-- =============================================================================

INSERT INTO agencies (id, name, siret, email, phone, address, city, postal_code, country) VALUES
  ('a1000000-0000-0000-0000-000000000001', 'Ymmo Paris',          '75200001000011', 'contact@ymmo-paris.fr',      '0140001100', '12 Rue de Rivoli',              'Paris',           '75001', 'FR'),
  ('a1000000-0000-0000-0000-000000000002', 'Ymmo Lyon',           '69200002000022', 'contact@ymmo-lyon.fr',       '0472002200', '8 Place Bellecour',             'Lyon',            '69002', 'FR'),
  ('a1000000-0000-0000-0000-000000000003', 'Ymmo Bordeaux',       '33200003000033', 'contact@ymmo-bordeaux.fr',   '0556003300', '14 Cours de l''Intendance',     'Bordeaux',        '33000', 'FR'),
  ('a1000000-0000-0000-0000-000000000004', 'Ymmo Aix-en-Provence','13200004000044', 'contact@ymmo-aix.fr',        '0442004400', '3 Cours Mirabeau',              'Aix-en-Provence', '13100', 'FR');

-- =============================================================================
-- UTILISATEURS
-- hash = bcrypt("Ymmo2024!", 12)
-- =============================================================================

-- Super admin plateforme
INSERT INTO users (id, agency_id, first_name, last_name, email, password_hash, phone, role) VALUES
  ('b0000000-0000-0000-0000-000000000000', NULL,
   'Sophie', 'Martin', 'sophie.martin@ymmo.fr',
   '$2b$12$YxjeeD9UWW41k8r/bfYihOF2pRI/Naer4S5Fiwc5lynvbyEhj/Fxq', '0600000000', 'super_admin');

-- ── Paris ────────────────────────────────────────────────────────────────────
INSERT INTO users (id, agency_id, first_name, last_name, email, password_hash, phone, role) VALUES
  ('b1000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001',
   'Thomas',  'Leroy',   'thomas.leroy@ymmo-paris.fr',
   '$2b$12$YxjeeD9UWW41k8r/bfYihOF2pRI/Naer4S5Fiwc5lynvbyEhj/Fxq', '0611000001', 'agency_admin'),
  ('b1000000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000001',
   'Clara',   'Dubois',  'clara.dubois@ymmo-paris.fr',
   '$2b$12$YxjeeD9UWW41k8r/bfYihOF2pRI/Naer4S5Fiwc5lynvbyEhj/Fxq', '0611000002', 'agent'),
  ('b1000000-0000-0000-0000-000000000003', 'a1000000-0000-0000-0000-000000000001',
   'Lucas',   'Bernard', 'lucas.bernard@ymmo-paris.fr',
   '$2b$12$YxjeeD9UWW41k8r/bfYihOF2pRI/Naer4S5Fiwc5lynvbyEhj/Fxq', '0611000003', 'agent'),
  ('b1000000-0000-0000-0000-000000000004', 'a1000000-0000-0000-0000-000000000001',
   'Emma',    'Petit',   'emma.petit@ymmo-paris.fr',
   '$2b$12$YxjeeD9UWW41k8r/bfYihOF2pRI/Naer4S5Fiwc5lynvbyEhj/Fxq', '0611000004', 'agent');

-- ── Lyon ─────────────────────────────────────────────────────────────────────
INSERT INTO users (id, agency_id, first_name, last_name, email, password_hash, phone, role) VALUES
  ('b2000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000002',
   'Antoine', 'Moreau',  'antoine.moreau@ymmo-lyon.fr',
   '$2b$12$YxjeeD9UWW41k8r/bfYihOF2pRI/Naer4S5Fiwc5lynvbyEhj/Fxq', '0622000001', 'agency_admin'),
  ('b2000000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000002',
   'Julie',   'Simon',   'julie.simon@ymmo-lyon.fr',
   '$2b$12$YxjeeD9UWW41k8r/bfYihOF2pRI/Naer4S5Fiwc5lynvbyEhj/Fxq', '0622000002', 'agent'),
  ('b2000000-0000-0000-0000-000000000003', 'a1000000-0000-0000-0000-000000000002',
   'Nicolas', 'Laurent', 'nicolas.laurent@ymmo-lyon.fr',
   '$2b$12$YxjeeD9UWW41k8r/bfYihOF2pRI/Naer4S5Fiwc5lynvbyEhj/Fxq', '0622000003', 'agent');

-- ── Bordeaux ──────────────────────────────────────────────────────────────────
INSERT INTO users (id, agency_id, first_name, last_name, email, password_hash, phone, role) VALUES
  ('b3000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000003',
   'Camille', 'Garcia',  'camille.garcia@ymmo-bordeaux.fr',
   '$2b$12$YxjeeD9UWW41k8r/bfYihOF2pRI/Naer4S5Fiwc5lynvbyEhj/Fxq', '0633000001', 'agency_admin'),
  ('b3000000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000003',
   'Hugo',    'Roux',    'hugo.roux@ymmo-bordeaux.fr',
   '$2b$12$YxjeeD9UWW41k8r/bfYihOF2pRI/Naer4S5Fiwc5lynvbyEhj/Fxq', '0633000002', 'agent'),
  ('b3000000-0000-0000-0000-000000000003', 'a1000000-0000-0000-0000-000000000003',
   'Léa',     'Fournier','lea.fournier@ymmo-bordeaux.fr',
   '$2b$12$YxjeeD9UWW41k8r/bfYihOF2pRI/Naer4S5Fiwc5lynvbyEhj/Fxq', '0633000003', 'agent');

-- ── Aix-en-Provence ───────────────────────────────────────────────────────────
INSERT INTO users (id, agency_id, first_name, last_name, email, password_hash, phone, role) VALUES
  ('b4000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000004',
   'Maxime',  'Girard',  'maxime.girard@ymmo-aix.fr',
   '$2b$12$YxjeeD9UWW41k8r/bfYihOF2pRI/Naer4S5Fiwc5lynvbyEhj/Fxq', '0644000001', 'agency_admin'),
  ('b4000000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000004',
   'Inès',    'Bonnet',  'ines.bonnet@ymmo-aix.fr',
   '$2b$12$YxjeeD9UWW41k8r/bfYihOF2pRI/Naer4S5Fiwc5lynvbyEhj/Fxq', '0644000002', 'agent'),
  ('b4000000-0000-0000-0000-000000000003', 'a1000000-0000-0000-0000-000000000004',
   'Paul',    'Dupont',  'paul.dupont@ymmo-aix.fr',
   '$2b$12$YxjeeD9UWW41k8r/bfYihOF2pRI/Naer4S5Fiwc5lynvbyEhj/Fxq', '0644000003', 'agent'),
  ('b4000000-0000-0000-0000-000000000004', 'a1000000-0000-0000-0000-000000000004',
   'Marie',   'Lambert', 'marie.lambert@ymmo-aix.fr',
   '$2b$12$YxjeeD9UWW41k8r/bfYihOF2pRI/Naer4S5Fiwc5lynvbyEhj/Fxq', '0644000004', 'agent');

-- =============================================================================
-- TAGS
-- =============================================================================

INSERT INTO tags (id, label, color) VALUES
  ('d0000000-0000-0000-0000-000000000001', 'Vue dégagée',       '#3B82F6'),
  ('d0000000-0000-0000-0000-000000000002', 'Lumineux',          '#F59E0B'),
  ('d0000000-0000-0000-0000-000000000003', 'Calme',             '#10B981'),
  ('d0000000-0000-0000-0000-000000000004', 'Proche transports', '#8B5CF6'),
  ('d0000000-0000-0000-0000-000000000005', 'Terrasse',          '#EC4899'),
  ('d0000000-0000-0000-0000-000000000006', 'Jardin',            '#84CC16'),
  ('d0000000-0000-0000-0000-000000000007', 'Parking inclus',    '#6B7280'),
  ('d0000000-0000-0000-0000-000000000008', 'Neuf',              '#06B6D4'),
  ('d0000000-0000-0000-0000-000000000009', 'Rénovation récente','#F97316'),
  ('d0000000-0000-0000-0000-000000000010', 'Proche écoles',     '#EF4444'),
  ('d0000000-0000-0000-0000-000000000011', 'Centre-ville',      '#A855F7'),
  ('d0000000-0000-0000-0000-000000000012', 'Investissement',    '#14B8A6');

-- =============================================================================
-- BIENS IMMOBILIERS
-- Coordonnées GPS réelles
-- =============================================================================

-- ── Paris ────────────────────────────────────────────────────────────────────
INSERT INTO properties (id, agency_id, created_by, title, description, type, transaction_type, price, surface_area, rooms, bedrooms, bathrooms, floor, total_floors, construction_year, has_parking, has_balcony, has_garden, is_furnished, is_available, status, address, city, postal_code, latitude, longitude) VALUES

  ('e1000000-0000-0000-0000-000000000001',
   'a1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000002',
   'Appartement haussmannien — Marais', 'Superbe 4 pièces dans un immeuble haussmannien classique. Parquet point de Hongrie, moulures, cheminée d''époque. Double vitrage récent.',
   'apartment', 'sale', 895000.00, 98.50, 4, 2, 1, 3, 6, 1882,
   FALSE, TRUE, FALSE, FALSE, TRUE, 'available',
   '24 Rue des Archives', 'Paris', '75004', 48.857700, 2.352300),

  ('e1000000-0000-0000-0000-000000000002',
   'a1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000002',
   'Studio meublé — Bastille', 'Studio refait à neuf de 28 m². Idéal investissement locatif ou premier achat. Digicode, interphone, gardien.',
   'apartment', 'sale', 285000.00, 28.00, 1, 0, 1, 5, 7, 1965,
   FALSE, FALSE, FALSE, TRUE, TRUE, 'available',
   '8 Boulevard Beaumarchais', 'Paris', '75011', 48.853500, 2.369100),

  ('e1000000-0000-0000-0000-000000000003',
   'a1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000003',
   'T3 moderne — Montparnasse', 'Appartement traversant, cuisine ouverte aménagée, double exposition sud/ouest. Parquet flottant, salle de bain avec baignoire.',
   'apartment', 'rent', 2200.00, 67.00, 3, 2, 1, 2, 8, 1978,
   TRUE, FALSE, FALSE, FALSE, TRUE, 'available',
   '42 Rue du Départ', 'Paris', '75014', 48.842000, 2.320500),

  ('e1000000-0000-0000-0000-000000000004',
   'a1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000003',
   'Loft atypique — Oberkampf', 'Loft de 120 m² en rez-de-chaussée avec verrière, béton brut et poutres apparentes. Idéal artiste ou professionnel libéral.',
   'apartment', 'sale', 1150000.00, 120.00, 3, 1, 2, 0, 1, 2005,
   TRUE, FALSE, FALSE, FALSE, TRUE, 'available',
   '17 Rue Oberkampf', 'Paris', '75011', 48.865300, 2.378800),

  ('e1000000-0000-0000-0000-000000000005',
   'a1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000004',
   'Maison de ville — Vincennes', 'Maison de ville sur 3 niveaux avec jardin privatif de 80 m². Proche RER A, écoles, commerces. Cuisine équipée récente.',
   'house', 'sale', 1420000.00, 145.00, 6, 4, 2, 0, 3, 1930,
   TRUE, FALSE, TRUE, FALSE, TRUE, 'available',
   '3 Rue de Fontenay', 'Paris', '94300', 48.843600, 2.439100);

-- ── Lyon ─────────────────────────────────────────────────────────────────────
INSERT INTO properties (id, agency_id, created_by, title, description, type, transaction_type, price, surface_area, rooms, bedrooms, bathrooms, floor, total_floors, construction_year, has_parking, has_balcony, has_garden, is_furnished, is_available, status, address, city, postal_code, latitude, longitude) VALUES

  ('e2000000-0000-0000-0000-000000000001',
   'a1000000-0000-0000-0000-000000000002', 'b2000000-0000-0000-0000-000000000002',
   'Appartement T4 — Presqu''île', 'Appartement familial avec vue sur Saône. Parquet chêne, double séjour, cuisine équipée américaine. Cave et parking en sous-sol.',
   'apartment', 'sale', 560000.00, 102.00, 4, 3, 2, 4, 7, 1970,
   TRUE, TRUE, FALSE, FALSE, TRUE, 'available',
   '15 Quai Saint-Antoine', 'Lyon', '69002', 45.762300, 4.830100),

  ('e2000000-0000-0000-0000-000000000002',
   'a1000000-0000-0000-0000-000000000002', 'b2000000-0000-0000-0000-000000000002',
   'Traboule T2 — Vieux-Lyon', 'Charmant duplex dans immeuble Renaissance classé. Cachet exceptionnel, pierres apparentes, escalier à vis d''origine.',
   'apartment', 'sale', 340000.00, 55.00, 2, 1, 1, 1, 3, 1520,
   FALSE, FALSE, FALSE, FALSE, TRUE, 'available',
   '7 Rue du Bœuf', 'Lyon', '69005', 45.762000, 4.826400),

  ('e2000000-0000-0000-0000-000000000003',
   'a1000000-0000-0000-0000-000000000002', 'b2000000-0000-0000-0000-000000000003',
   'Villa contemporaine — Caluire', 'Villa neuve BBC de 180 m² sur 600 m² de terrain clos. Piscine chauffée, garage double, domotique intégrée.',
   'house', 'sale', 890000.00, 180.00, 7, 4, 3, 0, 2, 2021,
   TRUE, FALSE, TRUE, FALSE, TRUE, 'available',
   '48 Chemin des Pins', 'Lyon', '69300', 45.797200, 4.847600),

  ('e2000000-0000-0000-0000-000000000004',
   'a1000000-0000-0000-0000-000000000002', 'b2000000-0000-0000-0000-000000000003',
   'Studio étudiant — Part-Dieu', 'Studio 22 m² entièrement équipé, proche gare Part-Dieu et universités. Idéal investissement Pinel.',
   'apartment', 'rent', 650.00, 22.00, 1, 0, 1, 6, 10, 1988,
   FALSE, FALSE, FALSE, TRUE, TRUE, 'available',
   '32 Rue Garibaldi', 'Lyon', '69003', 45.757300, 4.843500),

  ('e2000000-0000-0000-0000-000000000005',
   'a1000000-0000-0000-0000-000000000002', 'b2000000-0000-0000-0000-000000000002',
   'Local commercial — Confluence', 'Local commercial de 85 m² en rez-de-chaussée d''un immeuble neuf. Vitrine double, arrière-boutique, WC. Idéal boutique ou restauration.',
   'commercial', 'rent', 3200.00, 85.00, 1, 0, 1, 0, 4, 2018,
   FALSE, FALSE, FALSE, FALSE, TRUE, 'available',
   '2 Cours Charlemagne', 'Lyon', '69002', 45.741600, 4.815900);

-- ── Bordeaux ──────────────────────────────────────────────────────────────────
INSERT INTO properties (id, agency_id, created_by, title, description, type, transaction_type, price, surface_area, rooms, bedrooms, bathrooms, floor, total_floors, construction_year, has_parking, has_balcony, has_garden, is_furnished, is_available, status, address, city, postal_code, latitude, longitude) VALUES

  ('e3000000-0000-0000-0000-000000000001',
   'a1000000-0000-0000-0000-000000000003', 'b3000000-0000-0000-0000-000000000002',
   'Chartrons — T3 vue Garonne', 'Appartement de standing dans quartier des Chartrons. Vue directe sur la Garonne, parquet ancien restauré, moulures. Emplacement numéro 1.',
   'apartment', 'sale', 480000.00, 82.00, 3, 2, 1, 3, 5, 1895,
   FALSE, TRUE, FALSE, FALSE, TRUE, 'available',
   '58 Quai des Chartrons', 'Bordeaux', '33000', 44.857200, -0.568900),

  ('e3000000-0000-0000-0000-000000000002',
   'a1000000-0000-0000-0000-000000000003', 'b3000000-0000-0000-0000-000000000002',
   'Maison girondine — Caudéran', 'Maison typiquement girondine sur 3 niveaux. Jardin arboré de 250 m², double garage, piscine hors sol. Quartier résidentiel calme.',
   'house', 'sale', 675000.00, 162.00, 6, 4, 2, 0, 3, 1955,
   TRUE, FALSE, TRUE, FALSE, TRUE, 'available',
   '14 Rue de la Tivoli', 'Bordeaux', '33200', 44.846500, -0.615200),

  ('e3000000-0000-0000-0000-000000000003',
   'a1000000-0000-0000-0000-000000000003', 'b3000000-0000-0000-0000-000000000003',
   'T2 neuf — Euratlantique', 'Appartement neuf BBC dans la ZAC Euratlantique. Balcon filant, cuisine équipée Siemens, place de parking en sous-sol.',
   'apartment', 'sale', 295000.00, 48.00, 2, 1, 1, 2, 8, 2023,
   TRUE, TRUE, FALSE, FALSE, TRUE, 'available',
   '6 Rue Lucien Faure', 'Bordeaux', '33300', 44.855600, -0.548100),

  ('e3000000-0000-0000-0000-000000000004',
   'a1000000-0000-0000-0000-000000000003', 'b3000000-0000-0000-0000-000000000003',
   'Loft atelier — Saint-Michel', 'Ancien atelier d''artiste converti en loft de 95 m². Verrière zenithale, cuisine industrielle, mezzanine chambre.',
   'apartment', 'rent', 1450.00, 95.00, 2, 1, 1, 0, 1, 1920,
   FALSE, FALSE, FALSE, TRUE, TRUE, 'available',
   '10 Place Canteloup', 'Bordeaux', '33800', 44.832500, -0.563400),

  ('e3000000-0000-0000-0000-000000000005',
   'a1000000-0000-0000-0000-000000000003', 'b3000000-0000-0000-0000-000000000002',
   'Terrain constructible — Mérignac', 'Terrain plat viabilisé de 800 m² en zone UA. Proche tram B, permis de construire accordé pour maison individuelle de 150 m².',
   'land', 'sale', 210000.00, 800.00, 0, 0, 0, 0, 0, 0,
   FALSE, FALSE, FALSE, FALSE, TRUE, 'available',
   '28 Avenue du Maréchal de Lattre de Tassigny', 'Bordeaux', '33700', 44.841300, -0.641700);

-- ── Aix-en-Provence ───────────────────────────────────────────────────────────
INSERT INTO properties (id, agency_id, created_by, title, description, type, transaction_type, price, surface_area, rooms, bedrooms, bathrooms, floor, total_floors, construction_year, has_parking, has_balcony, has_garden, is_furnished, is_available, status, address, city, postal_code, latitude, longitude) VALUES

  ('e4000000-0000-0000-0000-000000000001',
   'a1000000-0000-0000-0000-000000000004', 'b4000000-0000-0000-0000-000000000002',
   'Bastide provençale — Jas de Bouffan', 'Bastide du XVIIIe siècle entièrement restaurée. 7 pièces sur parc arboré de 4000 m², piscine à débordement, dépendances.',
   'house', 'sale', 2200000.00, 280.00, 7, 5, 3, 0, 2, 1750,
   TRUE, FALSE, TRUE, FALSE, TRUE, 'available',
   '12 Chemin du Jas de Bouffan', 'Aix-en-Provence', '13090', 43.524600, 5.411300),

  ('e4000000-0000-0000-0000-000000000002',
   'a1000000-0000-0000-0000-000000000004', 'b4000000-0000-0000-0000-000000000002',
   'T3 centre historique — Cours Mirabeau', 'Appartement en plein cœur historique d''Aix. Vue sur les platanes du Cours Mirabeau, parquet ancien, hauts plafonds.',
   'apartment', 'sale', 420000.00, 75.00, 3, 2, 1, 2, 4, 1880,
   FALSE, TRUE, FALSE, FALSE, TRUE, 'available',
   '18 Cours Mirabeau', 'Aix-en-Provence', '13100', 43.526800, 5.447300),

  ('e4000000-0000-0000-0000-000000000003',
   'a1000000-0000-0000-0000-000000000004', 'b4000000-0000-0000-0000-000000000003',
   'Villa neuve BBC — Les Milles', 'Villa de 2022 aux normes RE2020. 4 chambres, piscine 10x4, garage double, panneaux photovoltaïques. Quartier résidentiel prisé.',
   'house', 'sale', 785000.00, 168.00, 5, 4, 2, 0, 1, 2022,
   TRUE, TRUE, TRUE, FALSE, TRUE, 'available',
   '55 Rue des Platanes', 'Aix-en-Provence', '13290', 43.497500, 5.376800),

  ('e4000000-0000-0000-0000-000000000004',
   'a1000000-0000-0000-0000-000000000004', 'b4000000-0000-0000-0000-000000000003',
   'Studio meublé — Campus Recteur Vitton', 'Studio 30 m² refait à neuf, proche universités et IUT d''Aix. Cuisinette équipée, parking vélo sécurisé.',
   'apartment', 'rent', 750.00, 30.00, 1, 0, 1, 1, 5, 2001,
   FALSE, FALSE, FALSE, TRUE, TRUE, 'available',
   '8 Rue Pierre et Marie Curie', 'Aix-en-Provence', '13100', 43.520100, 5.462000),

  ('e4000000-0000-0000-0000-000000000005',
   'a1000000-0000-0000-0000-000000000004', 'b4000000-0000-0000-0000-000000000004',
   'Duplex T4 — Mazarin', 'Duplex au cœur du quartier Mazarin, patrimoine UNESCO. Séjour voûté, 3 chambres en mezzanine, terrasse de 25 m² avec vue toits.',
   'apartment', 'sale', 695000.00, 110.00, 4, 3, 2, 1, 2, 1820,
   FALSE, TRUE, FALSE, FALSE, TRUE, 'under_offer',
   '4 Rue Mazarine', 'Aix-en-Provence', '13100', 43.525400, 5.451200);

-- =============================================================================
-- PROPERTY TAGS
-- =============================================================================

INSERT INTO property_tags (property_id, tag_id) VALUES
-- Paris
  ('e1000000-0000-0000-0000-000000000001', 'd0000000-0000-0000-0000-000000000002'), -- Lumineux
  ('e1000000-0000-0000-0000-000000000001', 'd0000000-0000-0000-0000-000000000011'), -- Centre-ville
  ('e1000000-0000-0000-0000-000000000001', 'd0000000-0000-0000-0000-000000000009'), -- Rénovation récente
  ('e1000000-0000-0000-0000-000000000002', 'd0000000-0000-0000-0000-000000000012'), -- Investissement
  ('e1000000-0000-0000-0000-000000000002', 'd0000000-0000-0000-0000-000000000004'), -- Proche transports
  ('e1000000-0000-0000-0000-000000000003', 'd0000000-0000-0000-0000-000000000003'), -- Calme
  ('e1000000-0000-0000-0000-000000000003', 'd0000000-0000-0000-0000-000000000007'), -- Parking inclus
  ('e1000000-0000-0000-0000-000000000004', 'd0000000-0000-0000-0000-000000000002'), -- Lumineux
  ('e1000000-0000-0000-0000-000000000004', 'd0000000-0000-0000-0000-000000000011'), -- Centre-ville
  ('e1000000-0000-0000-0000-000000000005', 'd0000000-0000-0000-0000-000000000006'), -- Jardin
  ('e1000000-0000-0000-0000-000000000005', 'd0000000-0000-0000-0000-000000000010'), -- Proche écoles
-- Lyon
  ('e2000000-0000-0000-0000-000000000001', 'd0000000-0000-0000-0000-000000000001'), -- Vue dégagée
  ('e2000000-0000-0000-0000-000000000001', 'd0000000-0000-0000-0000-000000000007'), -- Parking inclus
  ('e2000000-0000-0000-0000-000000000002', 'd0000000-0000-0000-0000-000000000003'), -- Calme
  ('e2000000-0000-0000-0000-000000000002', 'd0000000-0000-0000-0000-000000000011'), -- Centre-ville
  ('e2000000-0000-0000-0000-000000000003', 'd0000000-0000-0000-0000-000000000006'), -- Jardin
  ('e2000000-0000-0000-0000-000000000003', 'd0000000-0000-0000-0000-000000000008'), -- Neuf
  ('e2000000-0000-0000-0000-000000000004', 'd0000000-0000-0000-0000-000000000004'), -- Proche transports
  ('e2000000-0000-0000-0000-000000000004', 'd0000000-0000-0000-0000-000000000012'), -- Investissement
-- Bordeaux
  ('e3000000-0000-0000-0000-000000000001', 'd0000000-0000-0000-0000-000000000001'), -- Vue dégagée
  ('e3000000-0000-0000-0000-000000000001', 'd0000000-0000-0000-0000-000000000002'), -- Lumineux
  ('e3000000-0000-0000-0000-000000000002', 'd0000000-0000-0000-0000-000000000006'), -- Jardin
  ('e3000000-0000-0000-0000-000000000002', 'd0000000-0000-0000-0000-000000000003'), -- Calme
  ('e3000000-0000-0000-0000-000000000003', 'd0000000-0000-0000-0000-000000000008'), -- Neuf
  ('e3000000-0000-0000-0000-000000000003', 'd0000000-0000-0000-0000-000000000007'), -- Parking inclus
  ('e3000000-0000-0000-0000-000000000004', 'd0000000-0000-0000-0000-000000000011'), -- Centre-ville
  ('e3000000-0000-0000-0000-000000000005', 'd0000000-0000-0000-0000-000000000012'), -- Investissement
-- Aix
  ('e4000000-0000-0000-0000-000000000001', 'd0000000-0000-0000-0000-000000000006'), -- Jardin
  ('e4000000-0000-0000-0000-000000000001', 'd0000000-0000-0000-0000-000000000003'), -- Calme
  ('e4000000-0000-0000-0000-000000000002', 'd0000000-0000-0000-0000-000000000002'), -- Lumineux
  ('e4000000-0000-0000-0000-000000000002', 'd0000000-0000-0000-0000-000000000011'), -- Centre-ville
  ('e4000000-0000-0000-0000-000000000003', 'd0000000-0000-0000-0000-000000000008'), -- Neuf
  ('e4000000-0000-0000-0000-000000000003', 'd0000000-0000-0000-0000-000000000006'), -- Jardin
  ('e4000000-0000-0000-0000-000000000004', 'd0000000-0000-0000-0000-000000000004'), -- Proche transports
  ('e4000000-0000-0000-0000-000000000005', 'd0000000-0000-0000-0000-000000000005'), -- Terrasse
  ('e4000000-0000-0000-0000-000000000005', 'd0000000-0000-0000-0000-000000000011'); -- Centre-ville

-- =============================================================================
-- IMAGES DE BIENS
-- =============================================================================

INSERT INTO property_images (id, property_id, url, alt_text, is_cover, display_order) VALUES
  (uuid_generate_v4(), 'e1000000-0000-0000-0000-000000000001', 'https://cdn.ymmo.fr/paris/marais-salon.jpg',      'Salon avec parquet',   TRUE,  1),
  (uuid_generate_v4(), 'e1000000-0000-0000-0000-000000000001', 'https://cdn.ymmo.fr/paris/marais-chambre.jpg',    'Chambre principale',   FALSE, 2),
  (uuid_generate_v4(), 'e1000000-0000-0000-0000-000000000001', 'https://cdn.ymmo.fr/paris/marais-facade.jpg',     'Façade haussmannienne',FALSE, 3),
  (uuid_generate_v4(), 'e1000000-0000-0000-0000-000000000002', 'https://cdn.ymmo.fr/paris/bastille-studio.jpg',   'Vue générale studio',  TRUE,  1),
  (uuid_generate_v4(), 'e1000000-0000-0000-0000-000000000003', 'https://cdn.ymmo.fr/paris/montparnasse-sejour.jpg','Séjour lumineux',      TRUE,  1),
  (uuid_generate_v4(), 'e1000000-0000-0000-0000-000000000004', 'https://cdn.ymmo.fr/paris/loft-verriere.jpg',     'Verrière principale',  TRUE,  1),
  (uuid_generate_v4(), 'e1000000-0000-0000-0000-000000000005', 'https://cdn.ymmo.fr/paris/vincennes-facade.jpg',  'Façade maison',        TRUE,  1),
  (uuid_generate_v4(), 'e1000000-0000-0000-0000-000000000005', 'https://cdn.ymmo.fr/paris/vincennes-jardin.jpg',  'Jardin arrière',       FALSE, 2),

  (uuid_generate_v4(), 'e2000000-0000-0000-0000-000000000001', 'https://cdn.ymmo.fr/lyon/saone-sejour.jpg',       'Séjour vue Saône',     TRUE,  1),
  (uuid_generate_v4(), 'e2000000-0000-0000-0000-000000000001', 'https://cdn.ymmo.fr/lyon/saone-balcon.jpg',       'Balcon vue fleuve',    FALSE, 2),
  (uuid_generate_v4(), 'e2000000-0000-0000-0000-000000000002', 'https://cdn.ymmo.fr/lyon/vieux-escalier.jpg',     'Escalier à vis',       TRUE,  1),
  (uuid_generate_v4(), 'e2000000-0000-0000-0000-000000000003', 'https://cdn.ymmo.fr/lyon/caluire-piscine.jpg',    'Piscine extérieure',   TRUE,  1),
  (uuid_generate_v4(), 'e2000000-0000-0000-0000-000000000003', 'https://cdn.ymmo.fr/lyon/caluire-jardin.jpg',     'Jardin paysager',      FALSE, 2),
  (uuid_generate_v4(), 'e2000000-0000-0000-0000-000000000004', 'https://cdn.ymmo.fr/lyon/partdieu-studio.jpg',    'Studio meublé',        TRUE,  1),
  (uuid_generate_v4(), 'e2000000-0000-0000-0000-000000000005', 'https://cdn.ymmo.fr/lyon/confluence-local.jpg',   'Vitrine rue',          TRUE,  1),

  (uuid_generate_v4(), 'e3000000-0000-0000-0000-000000000001', 'https://cdn.ymmo.fr/bordeaux/chartrons-garonne.jpg','Vue sur Garonne',     TRUE,  1),
  (uuid_generate_v4(), 'e3000000-0000-0000-0000-000000000001', 'https://cdn.ymmo.fr/bordeaux/chartrons-salon.jpg', 'Salon parquet',       FALSE, 2),
  (uuid_generate_v4(), 'e3000000-0000-0000-0000-000000000002', 'https://cdn.ymmo.fr/bordeaux/cauderan-facade.jpg', 'Façade girondine',    TRUE,  1),
  (uuid_generate_v4(), 'e3000000-0000-0000-0000-000000000002', 'https://cdn.ymmo.fr/bordeaux/cauderan-jardin.jpg', 'Jardin arboré',       FALSE, 2),
  (uuid_generate_v4(), 'e3000000-0000-0000-0000-000000000003', 'https://cdn.ymmo.fr/bordeaux/euratlantique-appt.jpg','Salon neuf',         TRUE,  1),
  (uuid_generate_v4(), 'e3000000-0000-0000-0000-000000000004', 'https://cdn.ymmo.fr/bordeaux/loft-verriere.jpg',  'Verrière atelier',    TRUE,  1),

  (uuid_generate_v4(), 'e4000000-0000-0000-0000-000000000001', 'https://cdn.ymmo.fr/aix/bastide-facade.jpg',      'Bastide restaurée',    TRUE,  1),
  (uuid_generate_v4(), 'e4000000-0000-0000-0000-000000000001', 'https://cdn.ymmo.fr/aix/bastide-piscine.jpg',     'Piscine à débordement',FALSE, 2),
  (uuid_generate_v4(), 'e4000000-0000-0000-0000-000000000001', 'https://cdn.ymmo.fr/aix/bastide-parc.jpg',        'Parc arboré',          FALSE, 3),
  (uuid_generate_v4(), 'e4000000-0000-0000-0000-000000000002', 'https://cdn.ymmo.fr/aix/mirabeau-salon.jpg',      'Salon vue platanes',   TRUE,  1),
  (uuid_generate_v4(), 'e4000000-0000-0000-0000-000000000003', 'https://cdn.ymmo.fr/aix/milles-villa.jpg',        'Villa extérieur',      TRUE,  1),
  (uuid_generate_v4(), 'e4000000-0000-0000-0000-000000000004', 'https://cdn.ymmo.fr/aix/campus-studio.jpg',       'Studio meublé',        TRUE,  1),
  (uuid_generate_v4(), 'e4000000-0000-0000-0000-000000000005', 'https://cdn.ymmo.fr/aix/mazarin-terrasse.jpg',    'Terrasse vue toits',   TRUE,  1);

-- =============================================================================
-- CONTACTS (CLIENTS)
-- =============================================================================

-- Clients Paris
INSERT INTO contacts (id, agency_id, assigned_agent_id, first_name, last_name, email, phone, contact_type, source, notes) VALUES
  ('c1000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000002',
   'François', 'Lemaire', 'francois.lemaire@gmail.com', '0601010101', 'buyer', 'website',
   'Budget max 950k€. Cherche grand appartement dans le Marais ou Île Saint-Louis. Pas de dernier étage.'),
  ('c1000000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000003',
   'Nathalie', 'Perrin', 'nathalie.perrin@outlook.fr', '0602020202', 'seller', 'referral',
   'Vend son T3 Montparnasse suite à mutation professionnelle. Disponible dès juin.'),
  ('c1000000-0000-0000-0000-000000000003', 'a1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000004',
   'Karim',    'Benali',  'karim.benali@free.fr',      '0603030303', 'investor', 'ad',
   'Investisseur. Cherche studios à Paris ou Vincennes pour mise en location. Enveloppe 600k€.'),
  ('c1000000-0000-0000-0000-000000000004', 'a1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000002',
   'Aurélie',  'Morin',   'aurelie.morin@yahoo.fr',    '0604040404', 'tenant', 'website',
   'Cherche T3 à louer Montparnasse ou 14e, budget 2500€/mois, entrée septembre.');

-- Clients Lyon
INSERT INTO contacts (id, agency_id, assigned_agent_id, first_name, last_name, email, phone, contact_type, source, notes) VALUES
  ('c2000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000002', 'b2000000-0000-0000-0000-000000000002',
   'Bertrand', 'Charpentier', 'bertrand.charpentier@sfr.fr', '0612121212', 'buyer', 'referral',
   'Cherche T4 vue sur Saône ou T3 Vieux-Lyon. Budget 600k€. Propriétaire actuel.'),
  ('c2000000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000002', 'b2000000-0000-0000-0000-000000000003',
   'Sandrine', 'Renard',      'sandrine.renard@gmail.com',   '0613131313', 'buyer', 'website',
   'Cherche villa à Caluire avec piscine pour famille de 5. Budget 950k€.'),
  ('c2000000-0000-0000-0000-000000000003', 'a1000000-0000-0000-0000-000000000002', 'b2000000-0000-0000-0000-000000000002',
   'Éric',     'Blanc',       'eric.blanc@orange.fr',        '0614141414', 'investor', 'ad',
   'Investisseur locatif, cible studios et T2 proche Part-Dieu. Pinel ou classique.'),
  ('c2000000-0000-0000-0000-000000000004', 'a1000000-0000-0000-0000-000000000002', 'b2000000-0000-0000-0000-000000000003',
   'Véronique','Dumont',      'veronique.dumont@free.fr',    '0615151515', 'tenant', 'walk_in',
   'Cherche local commercial Confluence pour ouvrir salon de coiffure. Budget 3500€/mois.');

-- Clients Bordeaux
INSERT INTO contacts (id, agency_id, assigned_agent_id, first_name, last_name, email, phone, contact_type, source, notes) VALUES
  ('c3000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000003', 'b3000000-0000-0000-0000-000000000002',
   'Stéphane', 'Legrand',  'stephane.legrand@gmail.com',  '0623232323', 'buyer', 'website',
   'Mutation depuis Paris. Cherche appartement Chartrons ou Caudéran, budget 520k€.'),
  ('c3000000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000003', 'b3000000-0000-0000-0000-000000000003',
   'Isabelle', 'Marchand', 'isabelle.marchand@outlook.fr','0624242424', 'seller', 'phone',
   'Vend maison Caudéran suite divorce. Pressée de conclure, marge de négociation 5%.'),
  ('c3000000-0000-0000-0000-000000000003', 'a1000000-0000-0000-0000-000000000003', 'b3000000-0000-0000-0000-000000000002',
   'Cédric',   'Roy',      'cedric.roy@free.fr',          '0625252525', 'tenant', 'ad',
   'Cherche loft ou appartement atypique Saint-Michel, budget 1600€/mois, meublé apprécié.'),
  ('c3000000-0000-0000-0000-000000000004', 'a1000000-0000-0000-0000-000000000003', 'b3000000-0000-0000-0000-000000000003',
   'Patricia', 'Henry',    'patricia.henry@yahoo.fr',     '0626262626', 'buyer', 'referral',
   'Cherche T2 neuf BBC pour investissement Pinel. Budget 310k€ max. Secteur Euratlantique.');

-- Clients Aix-en-Provence
INSERT INTO contacts (id, agency_id, assigned_agent_id, first_name, last_name, email, phone, contact_type, source, notes) VALUES
  ('c4000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000004', 'b4000000-0000-0000-0000-000000000002',
   'Jean-Marc', 'Faure',    'jeanmarc.faure@gmail.com',   '0634343434', 'buyer', 'referral',
   'Chef d''entreprise. Cherche bastide ou villa de prestige autour d''Aix. Budget 2,5M€.'),
  ('c4000000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000004', 'b4000000-0000-0000-0000-000000000003',
   'Céline',    'Arnaud',   'celine.arnaud@sfr.fr',       '0635353535', 'buyer', 'website',
   'Cherche villa neuve Les Milles ou Luynes, 4 chambres, piscine impérative. Budget 850k€.'),
  ('c4000000-0000-0000-0000-000000000003', 'a1000000-0000-0000-0000-000000000004', 'b4000000-0000-0000-0000-000000000004',
   'Romain',    'Chevallier','romain.chevallier@gmail.com','0636363636', 'tenant', 'website',
   'Étudiant en master. Cherche studio meublé proche campus, max 800€/mois.'),
  ('c4000000-0000-0000-0000-000000000004', 'a1000000-0000-0000-0000-000000000004', 'b4000000-0000-0000-0000-000000000002',
   'Delphine',  'Vasseur',  'delphine.vasseur@orange.fr', '0637373737', 'seller', 'walk_in',
   'Vend duplex Mazarin pour acheter en dehors d''Aix. Délai de vente flexible.');

-- =============================================================================
-- MANDATS
-- =============================================================================

INSERT INTO mandates (id, property_id, agency_id, agent_id, mandate_type, start_date, end_date, commission_rate, is_exclusive, status) VALUES
  -- Paris
  ('f1000000-0000-0000-0000-000000000001', 'e1000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000002', 'exclusive',      '2026-01-15', '2026-07-15', 5.00, TRUE,  'active'),
  ('f1000000-0000-0000-0000-000000000002', 'e1000000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000002', 'simple',         '2026-02-01', '2026-08-01', 4.00, FALSE, 'active'),
  ('f1000000-0000-0000-0000-000000000003', 'e1000000-0000-0000-0000-000000000003', 'a1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000003', 'simple',         '2026-03-01', '2027-03-01', 8.33, FALSE, 'active'),
  ('f1000000-0000-0000-0000-000000000004', 'e1000000-0000-0000-0000-000000000004', 'a1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000003', 'exclusive',      '2026-01-01', '2026-07-01', 5.00, TRUE,  'active'),
  ('f1000000-0000-0000-0000-000000000005', 'e1000000-0000-0000-0000-000000000005', 'a1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000004', 'semi_exclusive', '2026-02-15', '2026-08-15', 4.50, FALSE, 'active'),
  -- Lyon
  ('f2000000-0000-0000-0000-000000000001', 'e2000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000002', 'b2000000-0000-0000-0000-000000000002', 'exclusive',      '2026-01-10', '2026-07-10', 5.00, TRUE,  'active'),
  ('f2000000-0000-0000-0000-000000000002', 'e2000000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000002', 'b2000000-0000-0000-0000-000000000002', 'simple',         '2026-02-05', '2026-08-05', 4.50, FALSE, 'active'),
  ('f2000000-0000-0000-0000-000000000003', 'e2000000-0000-0000-0000-000000000003', 'a1000000-0000-0000-0000-000000000002', 'b2000000-0000-0000-0000-000000000003', 'exclusive',      '2025-10-01', '2026-04-01', 5.00, TRUE,  'active'),
  ('f2000000-0000-0000-0000-000000000004', 'e2000000-0000-0000-0000-000000000005', 'a1000000-0000-0000-0000-000000000002', 'b2000000-0000-0000-0000-000000000003', 'simple',         '2026-03-01', '2027-03-01', 10.00, FALSE, 'active'),
  -- Bordeaux
  ('f3000000-0000-0000-0000-000000000001', 'e3000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000003', 'b3000000-0000-0000-0000-000000000002', 'exclusive',      '2026-01-20', '2026-07-20', 5.00, TRUE,  'active'),
  ('f3000000-0000-0000-0000-000000000002', 'e3000000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000003', 'b3000000-0000-0000-0000-000000000003', 'semi_exclusive', '2026-02-10', '2026-08-10', 4.50, FALSE, 'active'),
  ('f3000000-0000-0000-0000-000000000003', 'e3000000-0000-0000-0000-000000000003', 'a1000000-0000-0000-0000-000000000003', 'b3000000-0000-0000-0000-000000000003', 'exclusive',      '2026-01-01', '2026-07-01', 3.50, TRUE,  'active'),
  -- Aix
  ('f4000000-0000-0000-0000-000000000001', 'e4000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000004', 'b4000000-0000-0000-0000-000000000002', 'exclusive',      '2025-11-01', '2026-05-01', 5.50, TRUE,  'active'),
  ('f4000000-0000-0000-0000-000000000002', 'e4000000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000004', 'b4000000-0000-0000-0000-000000000002', 'simple',         '2026-02-01', '2026-08-01', 4.00, FALSE, 'active'),
  ('f4000000-0000-0000-0000-000000000003', 'e4000000-0000-0000-0000-000000000005', 'a1000000-0000-0000-0000-000000000004', 'b4000000-0000-0000-0000-000000000004', 'exclusive',      '2026-03-15', '2026-09-15', 5.00, TRUE,  'active');

-- =============================================================================
-- MANDATE CONTACTS (vendeurs liés aux mandats)
-- =============================================================================

INSERT INTO mandate_contacts (mandate_id, contact_id, role) VALUES
  ('f1000000-0000-0000-0000-000000000001', 'c1000000-0000-0000-0000-000000000001', 'buyer'),
  ('f1000000-0000-0000-0000-000000000003', 'c1000000-0000-0000-0000-000000000002', 'seller'),
  ('f1000000-0000-0000-0000-000000000003', 'c1000000-0000-0000-0000-000000000004', 'tenant'),
  ('f1000000-0000-0000-0000-000000000002', 'c1000000-0000-0000-0000-000000000003', 'buyer'),
  ('f2000000-0000-0000-0000-000000000001', 'c2000000-0000-0000-0000-000000000001', 'buyer'),
  ('f2000000-0000-0000-0000-000000000003', 'c2000000-0000-0000-0000-000000000002', 'buyer'),
  ('f2000000-0000-0000-0000-000000000004', 'c2000000-0000-0000-0000-000000000004', 'tenant'),
  ('f3000000-0000-0000-0000-000000000001', 'c3000000-0000-0000-0000-000000000001', 'buyer'),
  ('f3000000-0000-0000-0000-000000000002', 'c3000000-0000-0000-0000-000000000002', 'seller'),
  ('f3000000-0000-0000-0000-000000000003', 'c3000000-0000-0000-0000-000000000004', 'buyer'),
  ('f4000000-0000-0000-0000-000000000001', 'c4000000-0000-0000-0000-000000000001', 'buyer'),
  ('f4000000-0000-0000-0000-000000000003', 'c4000000-0000-0000-0000-000000000004', 'seller');

-- =============================================================================
-- OFFRES D'ACHAT
-- =============================================================================

INSERT INTO offers (id, property_id, contact_id, agent_id, amount, conditions, validity_date, status, rejection_reason) VALUES
  -- Paris : offre acceptée sur Marais
  ('0b100000-0000-0000-0000-000000000001', 'e1000000-0000-0000-0000-000000000001', 'c1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000002',
   870000.00, 'Sous réserve de prêt bancaire. Apport 30%.', '2026-05-20', 'pending', NULL),

  -- Paris : offre refusée sur studio Bastille
  ('0b100000-0000-0000-0000-000000000002', 'e1000000-0000-0000-0000-000000000002', 'c1000000-0000-0000-0000-000000000003', 'b1000000-0000-0000-0000-000000000002',
   265000.00, 'Comptant, pas de condition suspensive.', '2026-04-10', 'rejected', 'Offre trop basse par rapport au prix affiché.'),

  -- Paris : contre-offre sur loft Oberkampf
  ('0b100000-0000-0000-0000-000000000003', 'e1000000-0000-0000-0000-000000000004', 'c1000000-0000-0000-0000-000000000003', 'b1000000-0000-0000-0000-000000000003',
   1090000.00, 'Sous réserve de prêt. Délai de réalisation 3 mois.', '2026-05-15', 'counter_offered', NULL),

  -- Lyon : offre acceptée sur T4 Presqu''île
  ('0b200000-0000-0000-0000-000000000001', 'e2000000-0000-0000-0000-000000000001', 'c2000000-0000-0000-0000-000000000001', 'b2000000-0000-0000-0000-000000000002',
   545000.00, 'Sous réserve de prêt. Entrée pour octobre 2026.', '2026-05-25', 'accepted', NULL),

  -- Lyon : offre sur villa Caluire
  ('0b200000-0000-0000-0000-000000000002', 'e2000000-0000-0000-0000-000000000003', 'c2000000-0000-0000-0000-000000000002', 'b2000000-0000-0000-0000-000000000003',
   860000.00, 'Vente avec reprise de l''ancien bien. Conditions suspensives classiques.', '2026-06-01', 'pending', NULL),

  -- Bordeaux : offre acceptée sur Chartrons
  ('0b300000-0000-0000-0000-000000000001', 'e3000000-0000-0000-0000-000000000001', 'c3000000-0000-0000-0000-000000000001', 'b3000000-0000-0000-0000-000000000002',
   465000.00, 'Sous réserve de prêt. Apport 20%.', '2026-05-10', 'accepted', NULL),

  -- Bordeaux : offre sur T2 BBC Euratlantique
  ('0b300000-0000-0000-0000-000000000002', 'e3000000-0000-0000-0000-000000000003', 'c3000000-0000-0000-0000-000000000004', 'b3000000-0000-0000-0000-000000000003',
   290000.00, 'Investissement Pinel. Dossier financement en cours.', '2026-05-30', 'pending', NULL),

  -- Aix : offre sur bastide
  ('0b400000-0000-0000-0000-000000000001', 'e4000000-0000-0000-0000-000000000001', 'c4000000-0000-0000-0000-000000000001', 'b4000000-0000-0000-0000-000000000002',
   2100000.00, 'Comptant. Prise de possession souhaitée juillet 2026.', '2026-05-15', 'pending', NULL),

  -- Aix : offre acceptée sur duplex Mazarin (bien sous offre)
  ('0b400000-0000-0000-0000-000000000002', 'e4000000-0000-0000-0000-000000000005', 'c4000000-0000-0000-0000-000000000004', 'b4000000-0000-0000-0000-000000000004',
   675000.00, 'Sous réserve de prêt. Délai 4 mois.', '2026-04-30', 'accepted', NULL);

-- =============================================================================
-- VISITES
-- =============================================================================

INSERT INTO visits (id, property_id, contact_id, agent_id, scheduled_at, duration_minutes, status, notes, feedback) VALUES
  -- Paris
  ('5a100000-0000-0000-0000-000000000001', 'e1000000-0000-0000-0000-000000000001', 'c1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000002',
   '2026-04-10 10:00:00', 60, 'completed', 'Première visite. Client accompagné de son épouse.',
   'Très intéressé. Demande contre-visite avec architecte pour évaluer travaux cuisine.'),

  ('5a100000-0000-0000-0000-000000000002', 'e1000000-0000-0000-0000-000000000001', 'c1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000002',
   '2026-04-22 14:30:00', 90, 'completed', 'Contre-visite avec architecte Mme Beaumont.',
   'Architecte confirme travaux légers. Client prêt à formuler une offre.'),

  ('5a100000-0000-0000-0000-000000000003', 'e1000000-0000-0000-0000-000000000003', 'c1000000-0000-0000-0000-000000000004', 'b1000000-0000-0000-0000-000000000003',
   '2026-05-08 11:00:00', 30, 'confirmed', 'Première visite locative.', NULL),

  ('5a100000-0000-0000-0000-000000000004', 'e1000000-0000-0000-0000-000000000004', 'c1000000-0000-0000-0000-000000000003', 'b1000000-0000-0000-0000-000000000003',
   '2026-05-12 16:00:00', 45, 'scheduled', 'Visite loft investisseur.', NULL),

  -- Lyon
  ('5a200000-0000-0000-0000-000000000001', 'e2000000-0000-0000-0000-000000000001', 'c2000000-0000-0000-0000-000000000001', 'b2000000-0000-0000-0000-000000000002',
   '2026-03-25 10:00:00', 60, 'completed', 'Visite T4 vue Saône.',
   'Client conquis par la vue. Souhaite prendre le temps de réfléchir. Très sérieux.'),

  ('5a200000-0000-0000-0000-000000000002', 'e2000000-0000-0000-0000-000000000003', 'c2000000-0000-0000-0000-000000000002', 'b2000000-0000-0000-0000-000000000003',
   '2026-04-05 14:00:00', 75, 'completed', 'Visite villa avec enfants.',
   'Famille enthousiaste. Piscine et jardin ont fait la différence. En attente accord financement.'),

  ('5a200000-0000-0000-0000-000000000003', 'e2000000-0000-0000-0000-000000000005', 'c2000000-0000-0000-0000-000000000004', 'b2000000-0000-0000-0000-000000000003',
   '2026-05-15 09:30:00', 30, 'scheduled', 'Visite local commercial Confluence.', NULL),

  -- Bordeaux
  ('5a300000-0000-0000-0000-000000000001', 'e3000000-0000-0000-0000-000000000001', 'c3000000-0000-0000-0000-000000000001', 'b3000000-0000-0000-0000-000000000002',
   '2026-04-03 10:30:00', 60, 'completed', 'Visite appartement Chartrons.',
   'Client venu de Paris, très motivé. La vue Garonne a été décisive.'),

  ('5a300000-0000-0000-0000-000000000002', 'e3000000-0000-0000-0000-000000000002', 'c3000000-0000-0000-0000-000000000002', 'b3000000-0000-0000-0000-000000000003',
   '2026-04-15 11:00:00', 60, 'completed', 'Visite maison Caudéran avec vendeur.',
   'Vendeur pressé. Contact difficile mais bien en bon état. Négociation possible.'),

  ('5a300000-0000-0000-0000-000000000003', 'e3000000-0000-0000-0000-000000000004', 'c3000000-0000-0000-0000-000000000003', 'b3000000-0000-0000-0000-000000000002',
   '2026-05-06 17:00:00', 30, 'no_show', 'Visite loft Saint-Michel. Client n''est pas venu.', NULL),

  -- Aix
  ('5a400000-0000-0000-0000-000000000001', 'e4000000-0000-0000-0000-000000000001', 'c4000000-0000-0000-0000-000000000001', 'b4000000-0000-0000-0000-000000000002',
   '2026-03-20 11:00:00', 90, 'completed', 'Visite bastide avec M. Faure et conseiller financier.',
   'Coup de cœur immédiat. Le parc et la piscine ont convaincu. Offre à venir.'),

  ('5a400000-0000-0000-0000-000000000002', 'e4000000-0000-0000-0000-000000000003', 'c4000000-0000-0000-0000-000000000002', 'b4000000-0000-0000-0000-000000000003',
   '2026-04-18 14:00:00', 60, 'completed', 'Visite villa Les Milles.',
   'Client très intéressé. Demande délai pour vente de son bien actuel.'),

  ('5a400000-0000-0000-0000-000000000003', 'e4000000-0000-0000-0000-000000000004', 'c4000000-0000-0000-0000-000000000003', 'b4000000-0000-0000-0000-000000000004',
   '2026-05-10 10:00:00', 20, 'scheduled', 'Visite studio étudiant.', NULL);

-- =============================================================================
-- DOCUMENTS
-- =============================================================================

INSERT INTO documents (id, property_id, contact_id, offer_id, name, document_type, file_url, mime_type, file_size_kb) VALUES
  (uuid_generate_v4(), 'e1000000-0000-0000-0000-000000000001', NULL, NULL,
   'DPE - Marais', 'diagnostics', 'https://cdn.ymmo.fr/docs/paris/dpe-marais.pdf', 'application/pdf', 420),
  (uuid_generate_v4(), 'e1000000-0000-0000-0000-000000000001', NULL, NULL,
   'Règlement de copropriété', 'contract', 'https://cdn.ymmo.fr/docs/paris/rcp-marais.pdf', 'application/pdf', 1250),
  (uuid_generate_v4(), 'e2000000-0000-0000-0000-000000000001', NULL, NULL,
   'DPE - Presqu''île', 'diagnostics', 'https://cdn.ymmo.fr/docs/lyon/dpe-presquile.pdf', 'application/pdf', 390),
  (uuid_generate_v4(), 'e3000000-0000-0000-0000-000000000001', NULL, NULL,
   'DPE - Chartrons', 'diagnostics', 'https://cdn.ymmo.fr/docs/bordeaux/dpe-chartrons.pdf', 'application/pdf', 410),
  (uuid_generate_v4(), 'e4000000-0000-0000-0000-000000000001', NULL, NULL,
   'DPE - Bastide', 'diagnostics', 'https://cdn.ymmo.fr/docs/aix/dpe-bastide.pdf', 'application/pdf', 380),
  (uuid_generate_v4(), NULL, 'c1000000-0000-0000-0000-000000000001', '0b100000-0000-0000-0000-000000000001',
   'Pièce d''identité - Lemaire', 'id_card', 'https://cdn.ymmo.fr/docs/contacts/cni-lemaire.pdf', 'application/pdf', 180),
  (uuid_generate_v4(), NULL, 'c1000000-0000-0000-0000-000000000001', '0b100000-0000-0000-0000-000000000001',
   'Accord de principe bancaire - Lemaire', 'bank_statement', 'https://cdn.ymmo.fr/docs/contacts/accord-banque-lemaire.pdf', 'application/pdf', 95),
  (uuid_generate_v4(), NULL, 'c2000000-0000-0000-0000-000000000001', '0b200000-0000-0000-0000-000000000001',
   'Compromis de vente - Charpentier', 'contract', 'https://cdn.ymmo.fr/docs/lyon/compromis-charpentier.pdf', 'application/pdf', 870),
  (uuid_generate_v4(), NULL, 'c3000000-0000-0000-0000-000000000001', '0b300000-0000-0000-0000-000000000001',
   'Compromis de vente - Legrand', 'contract', 'https://cdn.ymmo.fr/docs/bordeaux/compromis-legrand.pdf', 'application/pdf', 830),
  (uuid_generate_v4(), NULL, 'c4000000-0000-0000-0000-000000000004', '0b400000-0000-0000-0000-000000000002',
   'Compromis - Duplex Mazarin', 'contract', 'https://cdn.ymmo.fr/docs/aix/compromis-mazarin.pdf', 'application/pdf', 920);

-- =============================================================================
-- CONVERSATIONS
-- =============================================================================

INSERT INTO conversations (id, agency_id, property_id, contact_id, conversation_type, title) VALUES
  -- Interne Paris : dossier Marais
  ('ca100000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'e1000000-0000-0000-0000-000000000001', NULL,
   'internal', 'Dossier Marais — Suivi offre Lemaire'),
  -- Client Paris : échange avec Lemaire
  ('ca100000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000001', 'e1000000-0000-0000-0000-000000000001', 'c1000000-0000-0000-0000-000000000001',
   'client', 'Échange avec François Lemaire'),
  -- Interne Lyon : dossier villa Caluire
  ('ca200000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000002', 'e2000000-0000-0000-0000-000000000003', NULL,
   'internal', 'Dossier Villa Caluire — Sandrine Renard'),
  -- Interne Bordeaux : coordination vente Chartrons
  ('ca300000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000003', 'e3000000-0000-0000-0000-000000000001', NULL,
   'internal', 'Coordination vente Chartrons'),
  -- Interne Aix : dossier bastide prestige
  ('ca400000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000004', 'e4000000-0000-0000-0000-000000000001', NULL,
   'internal', 'Dossier Bastide Jas de Bouffan — M. Faure');

-- =============================================================================
-- CONVERSATION USERS
-- =============================================================================

INSERT INTO conversation_users (conversation_id, user_id, joined_at) VALUES
  ('ca100000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', NOW()),
  ('ca100000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000002', NOW()),
  ('ca100000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000003', NOW()),

  ('ca100000-0000-0000-0000-000000000002', 'b1000000-0000-0000-0000-000000000002', NOW()),

  ('ca200000-0000-0000-0000-000000000001', 'b2000000-0000-0000-0000-000000000001', NOW()),
  ('ca200000-0000-0000-0000-000000000001', 'b2000000-0000-0000-0000-000000000003', NOW()),

  ('ca300000-0000-0000-0000-000000000001', 'b3000000-0000-0000-0000-000000000001', NOW()),
  ('ca300000-0000-0000-0000-000000000001', 'b3000000-0000-0000-0000-000000000002', NOW()),

  ('ca400000-0000-0000-0000-000000000001', 'b4000000-0000-0000-0000-000000000001', NOW()),
  ('ca400000-0000-0000-0000-000000000001', 'b4000000-0000-0000-0000-000000000002', NOW());

-- =============================================================================
-- MESSAGES
-- =============================================================================

INSERT INTO messages (id, conversation_id, sender_id, content, message_type, sent_at) VALUES
  -- Paris interne — dossier Marais
  ('ae100000-0000-0000-0000-000000000001', 'ca100000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000002',
   'Lemaire a fait une offre à 870k€. Il attend une réponse avant le 20 mai.', 'text', '2026-05-02 09:15:00'),
  ('ae100000-0000-0000-0000-000000000002', 'ca100000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001',
   'Bien reçu. Le vendeur demande 895k€ ferme. Essayons de trouver un compromis à 882k€.', 'text', '2026-05-02 10:30:00'),
  ('ae100000-0000-0000-0000-000000000003', 'ca100000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000002',
   'Je rappelle Lemaire cet après-midi pour lui soumettre la contre-proposition.', 'text', '2026-05-02 10:45:00'),
  ('ae100000-0000-0000-0000-000000000004', 'ca100000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000003',
   'J''ai reçu les documents complets de la banque. Financement validé jusqu''à 950k€.', 'text', '2026-05-03 08:50:00'),

  -- Paris client — échange avec Lemaire
  ('ae100000-0000-0000-0000-000000000005', 'ca100000-0000-0000-0000-000000000002', 'b1000000-0000-0000-0000-000000000002',
   'Bonjour M. Lemaire, j''ai bien transmis votre offre. Nous attendons le retour du vendeur d''ici vendredi.', 'text', '2026-05-02 14:00:00'),

  -- Lyon interne — villa Caluire
  ('ae200000-0000-0000-0000-000000000001', 'ca200000-0000-0000-0000-000000000001', 'b2000000-0000-0000-0000-000000000003',
   'Sandrine Renard a visité la villa hier. Elle est très intéressée mais attend la réponse de sa banque.', 'text', '2026-04-06 09:00:00'),
  ('ae200000-0000-0000-0000-000000000002', 'ca200000-0000-0000-0000-000000000001', 'b2000000-0000-0000-0000-000000000001',
   'Parfait. Le vendeur est prêt à attendre 3 semaines. On reste en contact avec la cliente.', 'text', '2026-04-06 09:45:00'),

  -- Bordeaux interne — Chartrons
  ('ae300000-0000-0000-0000-000000000001', 'ca300000-0000-0000-0000-000000000001', 'b3000000-0000-0000-0000-000000000002',
   'Legrand a accepté de monter à 465k€. Offre acceptée par le vendeur ce matin !', 'text', '2026-05-05 11:00:00'),
  ('ae300000-0000-0000-0000-000000000002', 'ca300000-0000-0000-0000-000000000001', 'b3000000-0000-0000-0000-000000000001',
   'Excellent travail ! Prépare le compromis pour la semaine prochaine.', 'text', '2026-05-05 11:20:00'),

  -- Aix interne — bastide prestige
  ('ae400000-0000-0000-0000-000000000001', 'ca400000-0000-0000-0000-000000000001', 'b4000000-0000-0000-0000-000000000002',
   'Visite exceptionnelle ce matin avec M. Faure. Il a adoré la propriété et son conseiller financier est optimiste.', 'text', '2026-03-20 13:00:00'),
  ('ae400000-0000-0000-0000-000000000002', 'ca400000-0000-0000-0000-000000000001', 'b4000000-0000-0000-0000-000000000001',
   'Super nouvelle. Reste disponible pour lui, ce dossier est prioritaire. Tiens-moi informé à chaque étape.', 'text', '2026-03-20 14:15:00'),
  ('ae400000-0000-0000-0000-000000000003', 'ca400000-0000-0000-0000-000000000001', 'b4000000-0000-0000-0000-000000000002',
   'M. Faure propose 2,1M€ comptant. J''attends validation du propriétaire.', 'text', '2026-04-28 10:00:00');

COMMIT;
