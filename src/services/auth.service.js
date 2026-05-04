const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const pool = require('../config/database');

const SALT_ROUNDS = 12;

function signAccess(payload) {
  return jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: process.env.JWT_EXPIRES_IN || '15m' });
}

function signRefresh(payload) {
  return jwt.sign(payload, process.env.JWT_REFRESH_SECRET, { expiresIn: process.env.JWT_REFRESH_EXPIRES_IN || '7d' });
}

async function register({ firstName, lastName, email, password, phone, role, agencyId }) {
  const exists = await pool.query('SELECT id FROM users WHERE email = $1', [email]);
  if (exists.rows.length) {
    const err = new Error('Email déjà utilisé.'); err.status = 409; throw err;
  }
  const passwordHash = await bcrypt.hash(password, SALT_ROUNDS);
  const { rows } = await pool.query(
    `INSERT INTO users (first_name, last_name, email, password_hash, phone, role, agency_id)
     VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING id, first_name, last_name, email, role, agency_id, created_at`,
    [firstName, lastName, email, passwordHash, phone || null, role, agencyId || null]
  );
  return rows[0];
}

async function login(email, password) {
  const { rows } = await pool.query('SELECT * FROM users WHERE email = $1 AND is_active = TRUE', [email]);
  if (!rows.length) {
    const err = new Error('Identifiants invalides.'); err.status = 401; throw err;
  }
  const user = rows[0];
  const valid = await bcrypt.compare(password, user.password_hash);
  if (!valid) {
    const err = new Error('Identifiants invalides.'); err.status = 401; throw err;
  }
  const payload = { id: user.id, role: user.role, agencyId: user.agency_id };
  const accessToken = signAccess(payload);
  const refreshToken = signRefresh({ id: user.id });
  await pool.query('UPDATE users SET refresh_token = $1 WHERE id = $2', [refreshToken, user.id]);
  return {
    accessToken,
    refreshToken,
    user: { id: user.id, firstName: user.first_name, lastName: user.last_name, email: user.email, role: user.role },
  };
}

async function refresh(token) {
  let decoded;
  try {
    decoded = jwt.verify(token, process.env.JWT_REFRESH_SECRET);
  } catch {
    const err = new Error('Refresh token invalide.'); err.status = 401; throw err;
  }
  const { rows } = await pool.query('SELECT * FROM users WHERE id = $1 AND refresh_token = $2', [decoded.id, token]);
  if (!rows.length) {
    const err = new Error('Refresh token révoqué.'); err.status = 401; throw err;
  }
  const user = rows[0];
  const accessToken = signAccess({ id: user.id, role: user.role, agencyId: user.agency_id });
  return { accessToken };
}

async function logout(userId) {
  await pool.query('UPDATE users SET refresh_token = NULL WHERE id = $1', [userId]);
}

async function me(userId) {
  const { rows } = await pool.query(
    'SELECT id, first_name, last_name, email, phone, role, agency_id, is_active, created_at FROM users WHERE id = $1',
    [userId]
  );
  if (!rows.length) {
    const err = new Error('Utilisateur introuvable.'); err.status = 404; throw err;
  }
  return rows[0];
}

module.exports = { register, login, refresh, logout, me };
