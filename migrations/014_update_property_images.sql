-- Migration 014: Replace property images with Unsplash real estate photos
DELETE FROM property_images;

INSERT INTO property_images (property_id, url, alt_text, is_cover, display_order) VALUES
  -- Paris — Marais (3 images)
  ('e1000000-0000-0000-0000-000000000001', 'https://images.unsplash.com/photo-1718030463382-896949a8d53a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', 'Salon avec parquet et fenêtres',        TRUE,  1),
  ('e1000000-0000-0000-0000-000000000001', 'https://images.unsplash.com/photo-1760067538612-c0ecd3bc3d3a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', 'Salon moderne avec canapé et plantes',  FALSE, 2),
  ('e1000000-0000-0000-0000-000000000001', 'https://images.unsplash.com/photo-1760067537620-6aaab015fba5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', 'Séjour avec canapé et télévision',      FALSE, 3),

  -- Paris — Bastille (1 image)
  ('e1000000-0000-0000-0000-000000000002', 'https://images.unsplash.com/photo-1760067537639-0fb475c87657?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', 'Salon spacieux avec grandes fenêtres',  TRUE,  1),

  -- Paris — Montparnasse (1 image)
  ('e1000000-0000-0000-0000-000000000003', 'https://images.unsplash.com/photo-1761158497156-c8f202a07b42?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', 'Maison moderne avec grande véranda',    TRUE,  1),

  -- Paris — Loft (1 image)
  ('e1000000-0000-0000-0000-000000000004', 'https://images.unsplash.com/photo-1768488314310-3742b3c75579?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', 'Salon cosy avec cheminée',              TRUE,  1),

  -- Paris — Vincennes (2 images)
  ('e1000000-0000-0000-0000-000000000005', 'https://images.unsplash.com/photo-1772411650649-f88111bcb8a5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', 'Salon avec vue sur le lac',             TRUE,  1),
  ('e1000000-0000-0000-0000-000000000005', 'https://images.unsplash.com/photo-1777305153838-4207eec294f6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', 'Cour moderne avec piscine',             FALSE, 2),

  -- Lyon — Saône (2 images)
  ('e2000000-0000-0000-0000-000000000001', 'https://images.unsplash.com/photo-1774199616762-31d947dc7d35?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', 'Salon moderne avec jardin',             TRUE,  1),
  ('e2000000-0000-0000-0000-000000000001', 'https://images.unsplash.com/photo-1718030463382-896949a8d53a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', 'Salon avec parquet et fenêtres',        FALSE, 2),

  -- Lyon — Vieux-Lyon (1 image)
  ('e2000000-0000-0000-0000-000000000002', 'https://images.unsplash.com/photo-1760067538612-c0ecd3bc3d3a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', 'Salon moderne avec canapé et plantes',  TRUE,  1),

  -- Lyon — Caluire (2 images)
  ('e2000000-0000-0000-0000-000000000003', 'https://images.unsplash.com/photo-1777305153838-4207eec294f6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', 'Cour moderne avec piscine',             TRUE,  1),
  ('e2000000-0000-0000-0000-000000000003', 'https://images.unsplash.com/photo-1760067537620-6aaab015fba5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', 'Séjour avec canapé et télévision',      FALSE, 2),

  -- Lyon — Part-Dieu (1 image)
  ('e2000000-0000-0000-0000-000000000004', 'https://images.unsplash.com/photo-1760067537639-0fb475c87657?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', 'Salon spacieux avec grandes fenêtres',  TRUE,  1),

  -- Lyon — Confluence (1 image)
  ('e2000000-0000-0000-0000-000000000005', 'https://images.unsplash.com/photo-1761158497156-c8f202a07b42?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', 'Maison moderne avec grande véranda',    TRUE,  1),

  -- Bordeaux — Chartrons (2 images)
  ('e3000000-0000-0000-0000-000000000001', 'https://images.unsplash.com/photo-1768488314310-3742b3c75579?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', 'Salon cosy avec cheminée',              TRUE,  1),
  ('e3000000-0000-0000-0000-000000000001', 'https://images.unsplash.com/photo-1772411650649-f88111bcb8a5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', 'Salon avec vue sur le lac',             FALSE, 2),

  -- Bordeaux — Cauderan (2 images)
  ('e3000000-0000-0000-0000-000000000002', 'https://images.unsplash.com/photo-1761158497156-c8f202a07b42?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', 'Façade maison moderne',                 TRUE,  1),
  ('e3000000-0000-0000-0000-000000000002', 'https://images.unsplash.com/photo-1777305153838-4207eec294f6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', 'Jardin avec piscine',                   FALSE, 2),

  -- Bordeaux — Euratlantique (1 image)
  ('e3000000-0000-0000-0000-000000000003', 'https://images.unsplash.com/photo-1774199616762-31d947dc7d35?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', 'Salon moderne avec vue jardin',         TRUE,  1),

  -- Bordeaux — Loft (1 image)
  ('e3000000-0000-0000-0000-000000000004', 'https://images.unsplash.com/photo-1718030463382-896949a8d53a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', 'Espace principal lumineux',             TRUE,  1),

  -- Aix — Bastide (3 images)
  ('e4000000-0000-0000-0000-000000000001', 'https://images.unsplash.com/photo-1777305153838-4207eec294f6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', 'Piscine à débordement',                 TRUE,  1),
  ('e4000000-0000-0000-0000-000000000001', 'https://images.unsplash.com/photo-1761158497156-c8f202a07b42?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', 'Façade bastide restaurée',              FALSE, 2),
  ('e4000000-0000-0000-0000-000000000001', 'https://images.unsplash.com/photo-1772411650649-f88111bcb8a5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', 'Parc arboré vue lac',                   FALSE, 3),

  -- Aix — Mirabeau (1 image)
  ('e4000000-0000-0000-0000-000000000002', 'https://images.unsplash.com/photo-1760067538612-c0ecd3bc3d3a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', 'Salon vue platanes',                    TRUE,  1),

  -- Aix — Milles (1 image)
  ('e4000000-0000-0000-0000-000000000003', 'https://images.unsplash.com/photo-1760067537620-6aaab015fba5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', 'Villa extérieur séjour',                TRUE,  1),

  -- Aix — Campus (1 image)
  ('e4000000-0000-0000-0000-000000000004', 'https://images.unsplash.com/photo-1760067537639-0fb475c87657?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', 'Studio meublé lumineux',                TRUE,  1),

  -- Aix — Mazarin (1 image)
  ('e4000000-0000-0000-0000-000000000005', 'https://images.unsplash.com/photo-1768488314310-3742b3c75579?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', 'Terrasse vue toits',                    TRUE,  1);
