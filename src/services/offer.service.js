const pool = require('../config/database');

async function findAll({ agencyId, propertyId, contactId } = {}) {
  const conditions = []; const values = []; let i = 1;
  if (agencyId) {
    conditions.push(`p.agency_id = $${i++}`); values.push(agencyId);
  }
  if (propertyId) { conditions.push(`o.property_id = $${i++}`); values.push(propertyId); }
  if (contactId) { conditions.push(`o.contact_id = $${i++}`); values.push(contactId); }
  const where = conditions.length ? `WHERE ${conditions.join(' AND ')}` : '';
  const { rows } = await pool.query(
    `SELECT o.* FROM offers o JOIN properties p ON p.id = o.property_id ${where} ORDER BY o.created_at DESC`,
    values
  );
  return rows;
}

async function findById(id) {
  const { rows } = await pool.query('SELECT * FROM offers WHERE id = $1', [id]);
  if (!rows.length) { const err = new Error('Offre introuvable.'); err.status = 404; throw err; }
  return rows[0];
}

async function create({ propertyId, contactId, agentId, amount, conditions, validityDate, status }) {
  const { rows } = await pool.query(
    `INSERT INTO offers (property_id, contact_id, agent_id, amount, conditions, validity_date, status)
     VALUES ($1,$2,$3,$4,$5,$6,$7) RETURNING *`,
    [propertyId, contactId, agentId, amount, conditions || null, validityDate || null, status || 'pending']
  );
  return rows[0];
}

async function update(id, data) {
  const map = { amount: 'amount', conditions: 'conditions', validityDate: 'validity_date', status: 'status', rejectionReason: 'rejection_reason' };
  const fields = []; const values = []; let i = 1;
  for (const [k, v] of Object.entries(data)) {
    if (map[k]) { fields.push(`${map[k]} = $${i++}`); values.push(v); }
  }
  if (!fields.length) { const err = new Error('Aucun champ.'); err.status = 400; throw err; }
  fields.push('updated_at = NOW()'); values.push(id);
  const { rows } = await pool.query(`UPDATE offers SET ${fields.join(', ')} WHERE id = $${i} RETURNING *`, values);
  if (!rows.length) { const err = new Error('Offre introuvable.'); err.status = 404; throw err; }
  return rows[0];
}

async function remove(id) {
  const { rowCount } = await pool.query('DELETE FROM offers WHERE id = $1', [id]);
  if (!rowCount) { const err = new Error('Offre introuvable.'); err.status = 404; throw err; }
}

module.exports = { findAll, findById, create, update, remove };
