const pool = require('../config/database');

async function findAll({ agencyId } = {}) {
  const { rows } = agencyId
    ? await pool.query('SELECT * FROM mandates WHERE agency_id = $1 ORDER BY created_at DESC', [agencyId])
    : await pool.query('SELECT * FROM mandates ORDER BY created_at DESC');
  return rows;
}

async function findById(id) {
  const { rows } = await pool.query(
    `SELECT m.*, json_agg(jsonb_build_object('contactId', mc.contact_id, 'role', mc.role)) FILTER (WHERE mc.contact_id IS NOT NULL) AS contacts
     FROM mandates m LEFT JOIN mandate_contacts mc ON mc.mandate_id = m.id WHERE m.id = $1 GROUP BY m.id`,
    [id]
  );
  if (!rows.length) { const err = new Error('Mandat introuvable.'); err.status = 404; throw err; }
  return rows[0];
}

async function create({ propertyId, agencyId, agentId, mandateType, startDate, endDate, commissionRate, isExclusive, status }) {
  const { rows } = await pool.query(
    `INSERT INTO mandates (property_id, agency_id, agent_id, mandate_type, start_date, end_date, commission_rate, is_exclusive, status)
     VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9) RETURNING *`,
    [propertyId, agencyId, agentId, mandateType, startDate, endDate || null, commissionRate || null, isExclusive || false, status || 'active']
  );
  return rows[0];
}

async function update(id, data) {
  const map = { agentId: 'agent_id', mandateType: 'mandate_type', startDate: 'start_date', endDate: 'end_date', commissionRate: 'commission_rate', isExclusive: 'is_exclusive', status: 'status' };
  const fields = []; const values = []; let i = 1;
  for (const [k, v] of Object.entries(data)) {
    if (map[k]) { fields.push(`${map[k]} = $${i++}`); values.push(v); }
  }
  if (!fields.length) { const err = new Error('Aucun champ.'); err.status = 400; throw err; }
  fields.push('updated_at = NOW()'); values.push(id);
  const { rows } = await pool.query(`UPDATE mandates SET ${fields.join(', ')} WHERE id = $${i} RETURNING *`, values);
  if (!rows.length) { const err = new Error('Mandat introuvable.'); err.status = 404; throw err; }
  return rows[0];
}

async function remove(id) {
  const { rowCount } = await pool.query('DELETE FROM mandates WHERE id = $1', [id]);
  if (!rowCount) { const err = new Error('Mandat introuvable.'); err.status = 404; throw err; }
}

async function addContact(mandateId, contactId, role) {
  await pool.query(
    'INSERT INTO mandate_contacts (mandate_id, contact_id, role) VALUES ($1,$2,$3) ON CONFLICT (mandate_id, contact_id) DO UPDATE SET role = $3',
    [mandateId, contactId, role]
  );
}

module.exports = { findAll, findById, create, update, remove, addContact };
