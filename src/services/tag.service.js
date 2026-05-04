const pool = require('../config/database');

async function findAll() {
  const { rows } = await pool.query('SELECT * FROM tags ORDER BY label');
  return rows;
}

async function create({ label, color }) {
  const { rows } = await pool.query(
    'INSERT INTO tags (label, color) VALUES ($1,$2) RETURNING *',
    [label, color || null]
  );
  return rows[0];
}

async function remove(id) {
  const { rowCount } = await pool.query('DELETE FROM tags WHERE id = $1', [id]);
  if (!rowCount) { const err = new Error('Tag introuvable.'); err.status = 404; throw err; }
}

module.exports = { findAll, create, remove };
