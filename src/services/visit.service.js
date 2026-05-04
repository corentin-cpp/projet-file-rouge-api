const pool = require('../config/database');

async function findAll({ agentId, propertyId, contactId } = {}) {
  const conditions = []; const values = []; let i = 1;
  if (agentId) { conditions.push(`agent_id = $${i++}`); values.push(agentId); }
  if (propertyId) { conditions.push(`property_id = $${i++}`); values.push(propertyId); }
  if (contactId) { conditions.push(`contact_id = $${i++}`); values.push(contactId); }
  const where = conditions.length ? `WHERE ${conditions.join(' AND ')}` : '';
  const { rows } = await pool.query(`SELECT * FROM visits ${where} ORDER BY scheduled_at DESC`, values);
  return rows;
}

async function findById(id) {
  const { rows } = await pool.query('SELECT * FROM visits WHERE id = $1', [id]);
  if (!rows.length) { const err = new Error('Visite introuvable.'); err.status = 404; throw err; }
  return rows[0];
}

async function create({ propertyId, contactId, agentId, scheduledAt, durationMinutes, status, notes }) {
  const { rows } = await pool.query(
    `INSERT INTO visits (property_id, contact_id, agent_id, scheduled_at, duration_minutes, status, notes)
     VALUES ($1,$2,$3,$4,$5,$6,$7) RETURNING *`,
    [propertyId, contactId, agentId, scheduledAt, durationMinutes || 30, status || 'scheduled', notes || null]
  );
  return rows[0];
}

async function update(id, data) {
  const map = { scheduledAt: 'scheduled_at', durationMinutes: 'duration_minutes', status: 'status', notes: 'notes', feedback: 'feedback' };
  const fields = []; const values = []; let i = 1;
  for (const [k, v] of Object.entries(data)) {
    if (map[k]) { fields.push(`${map[k]} = $${i++}`); values.push(v); }
  }
  if (!fields.length) { const err = new Error('Aucun champ.'); err.status = 400; throw err; }
  fields.push('updated_at = NOW()'); values.push(id);
  const { rows } = await pool.query(`UPDATE visits SET ${fields.join(', ')} WHERE id = $${i} RETURNING *`, values);
  if (!rows.length) { const err = new Error('Visite introuvable.'); err.status = 404; throw err; }
  return rows[0];
}

async function remove(id) {
  const { rowCount } = await pool.query('DELETE FROM visits WHERE id = $1', [id]);
  if (!rowCount) { const err = new Error('Visite introuvable.'); err.status = 404; throw err; }
}

module.exports = { findAll, findById, create, update, remove };
