const pool = require("../config/database");

async function findAll({
  agencyId,
  city,
  type,
  transactionType,
  minPrice,
  maxPrice,
  isAvailable,
} = {}) {
  const conditions = [];
  const values = [];
  let i = 1;
  if (agencyId) {
    conditions.push(`p.agency_id = $${i++}`);
    values.push(agencyId);
  }
  if (city) {
    conditions.push(`p.city ILIKE $${i++}`);
    values.push(`%${city}%`);
  }
  if (type) {
    conditions.push(`p.type = $${i++}`);
    values.push(type);
  }
  if (transactionType) {
    conditions.push(`p.transaction_type = $${i++}`);
    values.push(transactionType);
  }
  if (minPrice) {
    conditions.push(`p.price >= $${i++}`);
    values.push(minPrice);
  }
  if (maxPrice) {
    conditions.push(`p.price <= $${i++}`);
    values.push(maxPrice);
  }
  if (isAvailable !== undefined) {
    conditions.push(`p.is_available = $${i++}`);
    values.push(isAvailable);
  }
  const where = conditions.length ? `WHERE ${conditions.join(" AND ")}` : "";
  const { rows } = await pool.query(
    `SELECT p.*, array_agg(DISTINCT t.label) FILTER (WHERE t.label IS NOT NULL) AS tags
     FROM properties p
     LEFT JOIN property_tags pt ON pt.property_id = p.id
     LEFT JOIN tags t ON t.id = pt.tag_id
     ${where}
     GROUP BY p.id ORDER BY p.created_at DESC`,
    values,
  );
  return rows;
}

async function findById(id) {
  const { rows } = await pool.query(
    `SELECT p.*,
       json_agg(DISTINCT jsonb_build_object('id', t.id, 'label', t.label, 'color', t.color)) FILTER (WHERE t.id IS NOT NULL) AS tags,
       json_agg(DISTINCT jsonb_build_object('id', pi.id, 'url', pi.url, 'altText', pi.alt_text, 'isCover', pi.is_cover, 'displayOrder', pi.display_order)) FILTER (WHERE pi.id IS NOT NULL) AS images
     FROM properties p
     LEFT JOIN property_tags pt ON pt.property_id = p.id
     LEFT JOIN tags t ON t.id = pt.tag_id
     LEFT JOIN property_images pi ON pi.property_id = p.id
     WHERE p.id = $1
     GROUP BY p.id`,
    [id],
  );
  if (!rows.length) {
    const err = new Error("Bien introuvable.");
    err.status = 404;
    throw err;
  }
  return rows[0];
}

async function create(data, userId) {
  const { rows } = await pool.query(
    `INSERT INTO properties
       (agency_id, created_by, title, description, type, transaction_type, price, surface_area,
        rooms, bedrooms, bathrooms, floor, total_floors, construction_year, has_parking, has_balcony,
        has_garden, is_furnished, is_available, status, address, city, postal_code, latitude, longitude)
     VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23,$24,$25)
     RETURNING *`,
    [
      data.agencyId,
      userId,
      data.title,
      data.description || null,
      data.type,
      data.transactionType,
      data.price || null,
      data.surfaceArea || null,
      data.rooms || null,
      data.bedrooms || null,
      data.bathrooms || null,
      data.floor || null,
      data.totalFloors || null,
      data.constructionYear || null,
      data.hasParking || false,
      data.hasBalcony || false,
      data.hasGarden || false,
      data.isFurnished || false,
      data.isAvailable !== undefined ? data.isAvailable : true,
      data.status || "available",
      data.address,
      data.city,
      data.postalCode || null,
      data.latitude || null,
      data.longitude || null,
    ],
  );
  return rows[0];
}

async function update(id, data) {
  const map = {
    title: "title",
    description: "description",
    type: "type",
    transactionType: "transaction_type",
    price: "price",
    surfaceArea: "surface_area",
    rooms: "rooms",
    bedrooms: "bedrooms",
    bathrooms: "bathrooms",
    floor: "floor",
    totalFloors: "total_floors",
    constructionYear: "construction_year",
    hasParking: "has_parking",
    hasBalcony: "has_balcony",
    hasGarden: "has_garden",
    isFurnished: "is_furnished",
    isAvailable: "is_available",
    status: "status",
    address: "address",
    city: "city",
    postalCode: "postal_code",
    latitude: "latitude",
    longitude: "longitude",
  };
  const fields = [];
  const values = [];
  let i = 1;
  for (const [k, v] of Object.entries(data)) {
    if (map[k]) {
      fields.push(`${map[k]} = $${i++}`);
      values.push(v);
    }
  }
  if (!fields.length) {
    const err = new Error("Aucun champ.");
    err.status = 400;
    throw err;
  }
  fields.push("updated_at = NOW()");
  values.push(id);
  const { rows } = await pool.query(
    `UPDATE properties SET ${fields.join(", ")} WHERE id = $${i} RETURNING *`,
    values,
  );
  if (!rows.length) {
    const err = new Error("Bien introuvable.");
    err.status = 404;
    throw err;
  }
  return rows[0];
}

async function remove(id) {
  const { rowCount } = await pool.query(
    "DELETE FROM properties WHERE id = $1",
    [id],
  );
  if (!rowCount) {
    const err = new Error("Bien introuvable.");
    err.status = 404;
    throw err;
  }
}

async function addImage(propertyId, { url, altText, isCover, displayOrder }) {
  if (isCover) {
    await pool.query(
      "UPDATE property_images SET is_cover = FALSE WHERE property_id = $1",
      [propertyId],
    );
  }
  const { rows } = await pool.query(
    `INSERT INTO property_images (property_id, url, alt_text, is_cover, display_order)
     VALUES ($1,$2,$3,$4,$5) RETURNING *`,
    [propertyId, url, altText || null, isCover || false, displayOrder || 0],
  );
  return rows[0];
}

async function getImages(propertyId) {
  const { rows } = await pool.query(
    "SELECT * FROM property_images WHERE property_id = $1 ORDER BY display_order",
    [propertyId],
  );
  return rows;
}

async function addTag(propertyId, tagId) {
  await pool.query(
    "INSERT INTO property_tags (property_id, tag_id) VALUES ($1,$2) ON CONFLICT DO NOTHING",
    [propertyId, tagId],
  );
}

async function removeTag(propertyId, tagId) {
  await pool.query(
    "DELETE FROM property_tags WHERE property_id = $1 AND tag_id = $2",
    [propertyId, tagId],
  );
}

module.exports = {
  findAll,
  findById,
  create,
  update,
  remove,
  addImage,
  getImages,
  addTag,
  removeTag,
};
