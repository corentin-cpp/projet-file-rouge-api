const bcrypt = require('bcrypt');
const pool = require('../config/database');

const PUBLIC_COLS = 'id, agency_id, first_name, last_name, email, phone, role, is_active, created_at, updated_at';

async function findAll({ agencyId } = {}) {
  if (agencyId) {
    const { rows } = await pool.query(`SELECT ${PUBLIC_COLS} FROM users WHERE agency_id = $1 ORDER BY created_at DESC`, [agencyId]);
    return rows;
  }
  const { rows } = await pool.query(`SELECT ${PUBLIC_COLS} FROM users ORDER BY created_at DESC`);
  return rows;
}

async function findById(id) {
  const { rows } = await pool.query(`SELECT ${PUBLIC_COLS} FROM users WHERE id = $1`, [id]);
  if (!rows.length) { const err = new Error('Utilisateur introuvable.'); err.status = 404; throw err; }
  return rows[0];
}

async function update(id, data) {
  const fields = [];
  const values = [];
  let i = 1;
  const allowed = { firstName: 'first_name', lastName: 'last_name', phone: 'phone', role: 'role', isActive: 'is_active', agencyId: 'agency_id' };
  for (const [k, v] of Object.entries(data)) {
    if (allowed[k]) { fields.push(`${allowed[k]} = $${i++}`); values.push(v); }
  }
  if (data.password) {
    const hash = await bcrypt.hash(data.password, 12);
    fields.push(`password_hash = $${i++}`); values.push(hash);
  }
  if (!fields.length) { const err = new Error('Aucun champ à mettre à jour.'); err.status = 400; throw err; }
  fields.push('updated_at = NOW()');
  values.push(id);
  const { rows } = await pool.query(`UPDATE users SET ${fields.join(', ')} WHERE id = $${i} RETURNING ${PUBLIC_COLS}`, values);
  if (!rows.length) { const err = new Error('Utilisateur introuvable.'); err.status = 404; throw err; }
  return rows[0];
}

async function remove(id) {
  const { rowCount } = await pool.query('DELETE FROM users WHERE id = $1', [id]);
  if (!rowCount) { const err = new Error('Utilisateur introuvable.'); err.status = 404; throw err; }
}

module.exports = { findAll, findById, update, remove };
