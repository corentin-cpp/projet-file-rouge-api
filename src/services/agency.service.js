const pool = require('../config/database');

async function findAll() {
  const { rows } = await pool.query('SELECT * FROM agencies ORDER BY created_at DESC');
  return rows;
}

async function findById(id) {
  const { rows } = await pool.query('SELECT * FROM agencies WHERE id = $1', [id]);
  if (!rows.length) { const err = new Error('Agence introuvable.'); err.status = 404; throw err; }
  return rows[0];
}

async function create({ name, siret, email, phone, address, city, postalCode, country }) {
  const { rows } = await pool.query(
    `INSERT INTO agencies (name, siret, email, phone, address, city, postal_code, country)
     VALUES ($1,$2,$3,$4,$5,$6,$7,$8) RETURNING *`,
    [name, siret || null, email, phone || null, address || null, city || null, postalCode || null, country || 'FR']
  );
  return rows[0];
}

async function update(id, data) {
  const fields = [];
  const values = [];
  let i = 1;
  const allowed = ['name', 'siret', 'email', 'phone', 'address', 'city', 'postal_code', 'country'];
  const map = { postalCode: 'postal_code' };
  for (const [k, v] of Object.entries(data)) {
    const col = map[k] || k;
    if (allowed.includes(col)) { fields.push(`${col} = $${i++}`); values.push(v); }
  }
  if (!fields.length) { const err = new Error('Aucun champ à mettre à jour.'); err.status = 400; throw err; }
  fields.push(`updated_at = NOW()`);
  values.push(id);
  const { rows } = await pool.query(`UPDATE agencies SET ${fields.join(', ')} WHERE id = $${i} RETURNING *`, values);
  if (!rows.length) { const err = new Error('Agence introuvable.'); err.status = 404; throw err; }
  return rows[0];
}

async function remove(id) {
  const { rowCount } = await pool.query('DELETE FROM agencies WHERE id = $1', [id]);
  if (!rowCount) { const err = new Error('Agence introuvable.'); err.status = 404; throw err; }
}

module.exports = { findAll, findById, create, update, remove };
