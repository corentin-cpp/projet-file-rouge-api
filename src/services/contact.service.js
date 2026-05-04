const pool = require('../config/database');

async function findAll({ agencyId } = {}) {
  const { rows } = agencyId
    ? await pool.query('SELECT * FROM contacts WHERE agency_id = $1 ORDER BY created_at DESC', [agencyId])
    : await pool.query('SELECT * FROM contacts ORDER BY created_at DESC');
  return rows;
}

async function findById(id) {
  const { rows } = await pool.query('SELECT * FROM contacts WHERE id = $1', [id]);
  if (!rows.length) { const err = new Error('Contact introuvable.'); err.status = 404; throw err; }
  return rows[0];
}

async function create({ agencyId, assignedAgentId, firstName, lastName, email, phone, contactType, source, notes }) {
  const { rows } = await pool.query(
    `INSERT INTO contacts (agency_id, assigned_agent_id, first_name, last_name, email, phone, contact_type, source, notes)
     VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9) RETURNING *`,
    [agencyId, assignedAgentId || null, firstName, lastName, email || null, phone || null, contactType, source || null, notes || null]
  );
  return rows[0];
}

async function update(id, data) {
  const map = { firstName: 'first_name', lastName: 'last_name', email: 'email', phone: 'phone', assignedAgentId: 'assigned_agent_id', contactType: 'contact_type', source: 'source', notes: 'notes' };
  const fields = []; const values = []; let i = 1;
  for (const [k, v] of Object.entries(data)) {
    if (map[k]) { fields.push(`${map[k]} = $${i++}`); values.push(v); }
  }
  if (!fields.length) { const err = new Error('Aucun champ.'); err.status = 400; throw err; }
  fields.push('updated_at = NOW()'); values.push(id);
  const { rows } = await pool.query(`UPDATE contacts SET ${fields.join(', ')} WHERE id = $${i} RETURNING *`, values);
  if (!rows.length) { const err = new Error('Contact introuvable.'); err.status = 404; throw err; }
  return rows[0];
}

async function remove(id) {
  const { rowCount } = await pool.query('DELETE FROM contacts WHERE id = $1', [id]);
  if (!rowCount) { const err = new Error('Contact introuvable.'); err.status = 404; throw err; }
}

module.exports = { findAll, findById, create, update, remove };
