const pool = require('../config/database');

async function findAll({ propertyId, contactId, offerId } = {}) {
  const conditions = []; const values = []; let i = 1;
  if (propertyId) { conditions.push(`property_id = $${i++}`); values.push(propertyId); }
  if (contactId) { conditions.push(`contact_id = $${i++}`); values.push(contactId); }
  if (offerId) { conditions.push(`offer_id = $${i++}`); values.push(offerId); }
  const where = conditions.length ? `WHERE ${conditions.join(' AND ')}` : '';
  const { rows } = await pool.query(`SELECT * FROM documents ${where} ORDER BY uploaded_at DESC`, values);
  return rows;
}

async function findById(id) {
  const { rows } = await pool.query('SELECT * FROM documents WHERE id = $1', [id]);
  if (!rows.length) { const err = new Error('Document introuvable.'); err.status = 404; throw err; }
  return rows[0];
}

async function create({ propertyId, contactId, offerId, name, documentType, fileUrl, mimeType, fileSizeKb }) {
  const { rows } = await pool.query(
    `INSERT INTO documents (property_id, contact_id, offer_id, name, document_type, file_url, mime_type, file_size_kb)
     VALUES ($1,$2,$3,$4,$5,$6,$7,$8) RETURNING *`,
    [propertyId || null, contactId || null, offerId || null, name, documentType, fileUrl, mimeType || null, fileSizeKb || null]
  );
  return rows[0];
}

async function remove(id) {
  const { rowCount } = await pool.query('DELETE FROM documents WHERE id = $1', [id]);
  if (!rowCount) { const err = new Error('Document introuvable.'); err.status = 404; throw err; }
}

module.exports = { findAll, findById, create, remove };
