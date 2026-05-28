const crypto = require('crypto');
const bcrypt = require('bcrypt');
const pool = require('../config/database');

const SALT_ROUNDS = 12;

const BASE_SELECT = `
  SELECT
    cp.id, cp.user_id, cp.contact_id, cp.agency_id, cp.property_id,
    cp.assigned_agent_id, cp.iban, cp.bic, cp.bank_name,
    cp.monthly_income, cp.employment_type,
    cp.created_at, cp.updated_at,
    u.first_name, u.last_name, u.email, u.phone, u.is_active, u.must_change_password,
    c.first_name AS contact_first_name, c.last_name AS contact_last_name,
    c.email AS contact_email, c.contact_type
  FROM client_profiles cp
  JOIN users u ON u.id = cp.user_id
  JOIN contacts c ON c.id = cp.contact_id
`;

function generateTempPassword() {
  return crypto.randomBytes(9).toString('base64url');
}

async function create({ agencyId, contactId, propertyId, assignedAgentId, firstName, lastName, email, phone }) {
  const contactCheck = await pool.query(
    agencyId
      ? 'SELECT id, agency_id FROM contacts WHERE id = $1 AND agency_id = $2'
      : 'SELECT id, agency_id FROM contacts WHERE id = $1',
    agencyId ? [contactId, agencyId] : [contactId]
  );
  if (!contactCheck.rows.length) {
    const err = new Error('Contact introuvable dans cette agence.'); err.status = 404; throw err;
  }
  // eslint-disable-next-line no-param-reassign
  agencyId = agencyId || contactCheck.rows[0].agency_id;

  const dupCheck = await pool.query('SELECT id FROM client_profiles WHERE contact_id = $1', [contactId]);
  if (dupCheck.rows.length) {
    const err = new Error('Un compte client existe déjà pour ce contact.'); err.status = 409; throw err;
  }

  const emailCheck = await pool.query('SELECT id FROM users WHERE email = $1', [email]);
  if (emailCheck.rows.length) {
    const err = new Error('Email déjà utilisé.'); err.status = 409; throw err;
  }

  const tempPassword = generateTempPassword();
  const passwordHash = await bcrypt.hash(tempPassword, SALT_ROUNDS);

  const dbClient = await pool.connect();
  try {
    await dbClient.query('BEGIN');

    const userResult = await dbClient.query(
      `INSERT INTO users (agency_id, first_name, last_name, email, password_hash, phone, role, must_change_password, temp_password_hash)
       VALUES ($1, $2, $3, $4, $5, $6, 'client', TRUE, $7)
       RETURNING id, first_name, last_name, email, role, agency_id, must_change_password`,
      [agencyId, firstName, lastName, email, passwordHash, phone || null, passwordHash]
    );
    const user = userResult.rows[0];

    const profileResult = await dbClient.query(
      `INSERT INTO client_profiles (user_id, contact_id, agency_id, property_id, assigned_agent_id)
       VALUES ($1, $2, $3, $4, $5)
       RETURNING *`,
      [user.id, contactId, agencyId, propertyId || null, assignedAgentId || null]
    );

    await dbClient.query('COMMIT');

    return {
      ...profileResult.rows[0],
      firstName: user.first_name,
      lastName: user.last_name,
      email: user.email,
      phone: phone || null,
      isActive: true,
      mustChangePassword: true,
      temporaryPassword: tempPassword,
    };
  } catch (err) {
    await dbClient.query('ROLLBACK');
    if (err.code === '23505') {
      const e = new Error('Email déjà utilisé.'); e.status = 409; throw e;
    }
    throw err;
  } finally {
    dbClient.release();
  }
}

async function findAll({ agencyId } = {}) {
  const { rows } = agencyId
    ? await pool.query(`${BASE_SELECT} WHERE cp.agency_id = $1 ORDER BY cp.created_at DESC`, [agencyId])
    : await pool.query(`${BASE_SELECT} ORDER BY cp.created_at DESC`);
  return rows;
}

async function findById(clientId) {
  const { rows } = await pool.query(`${BASE_SELECT} WHERE cp.id = $1`, [clientId]);
  if (!rows.length) { const err = new Error('Client introuvable.'); err.status = 404; throw err; }
  return rows[0];
}

async function update(clientId, data, requesterRole, requesterId, requesterAgencyId) {
  const { rows } = await pool.query(
    'SELECT cp.user_id, cp.agency_id FROM client_profiles cp WHERE cp.id = $1',
    [clientId]
  );
  if (!rows.length) { const err = new Error('Client introuvable.'); err.status = 404; throw err; }
  const profile = rows[0];

  if (requesterRole === 'client' && profile.user_id !== requesterId) {
    const err = new Error('Accès refusé.'); err.status = 403; throw err;
  }
  if (requesterRole !== 'super_admin' && requesterRole !== 'client' && profile.agency_id !== requesterAgencyId) {
    const err = new Error('Accès refusé.'); err.status = 403; throw err;
  }

  const CLIENT_MAP = { iban: 'iban', bic: 'bic', bankName: 'bank_name', monthlyIncome: 'monthly_income', employmentType: 'employment_type' };
  const USERS_MAP = { firstName: 'first_name', lastName: 'last_name', email: 'email', phone: 'phone', isActive: 'is_active' };
  const PROFILE_AGENT_MAP = { ...CLIENT_MAP, propertyId: 'property_id', assignedAgentId: 'assigned_agent_id' };

  const dbClient = await pool.connect();
  try {
    await dbClient.query('BEGIN');

    if (requesterRole === 'client') {
      const fields = []; const values = []; let i = 1;
      for (const [k, v] of Object.entries(data)) {
        if (CLIENT_MAP[k] !== undefined) { fields.push(`${CLIENT_MAP[k]} = $${i++}`); values.push(v); }
      }
      if (fields.length) {
        fields.push('updated_at = NOW()'); values.push(clientId);
        await dbClient.query(`UPDATE client_profiles SET ${fields.join(', ')} WHERE id = $${i}`, values);
      }
    } else {
      const uFields = []; const uValues = []; let ui = 1;
      for (const [k, v] of Object.entries(data)) {
        if (USERS_MAP[k] !== undefined) { uFields.push(`${USERS_MAP[k]} = $${ui++}`); uValues.push(v); }
      }
      if (uFields.length) {
        uFields.push('updated_at = NOW()'); uValues.push(profile.user_id);
        await dbClient.query(`UPDATE users SET ${uFields.join(', ')} WHERE id = $${ui}`, uValues);
      }

      const pFields = []; const pValues = []; let pi = 1;
      for (const [k, v] of Object.entries(data)) {
        if (PROFILE_AGENT_MAP[k] !== undefined) { pFields.push(`${PROFILE_AGENT_MAP[k]} = $${pi++}`); pValues.push(v); }
      }
      if (pFields.length) {
        pFields.push('updated_at = NOW()'); pValues.push(clientId);
        await dbClient.query(`UPDATE client_profiles SET ${pFields.join(', ')} WHERE id = $${pi}`, pValues);
      }
    }

    await dbClient.query('COMMIT');
  } catch (err) {
    await dbClient.query('ROLLBACK');
    throw err;
  } finally {
    dbClient.release();
  }

  return findById(clientId);
}

async function remove(clientId) {
  const { rows } = await pool.query('SELECT user_id FROM client_profiles WHERE id = $1', [clientId]);
  if (!rows.length) { const err = new Error('Client introuvable.'); err.status = 404; throw err; }
  await pool.query('DELETE FROM users WHERE id = $1', [rows[0].user_id]);
}

async function findPortal(userId) {
  const { rows } = await pool.query(
    `SELECT
       u.id, u.first_name, u.last_name, u.email, u.phone,
       cp.id AS profile_id, cp.agency_id, cp.property_id, cp.assigned_agent_id,
       cp.iban, cp.bic, cp.bank_name, cp.monthly_income, cp.employment_type,
       cp.created_at, cp.updated_at,
       (SELECT row_to_json(p) FROM properties p WHERE p.id = cp.property_id) AS property,
       (
         SELECT COALESCE(json_agg(json_build_object(
           'id', o.id, 'amount', o.amount, 'status', o.status,
           'conditions', o.conditions, 'validityDate', o.validity_date,
           'createdAt', o.created_at
         ) ORDER BY o.created_at DESC), '[]')
         FROM offers o WHERE o.contact_id = cp.contact_id
       ) AS offers,
       (
         SELECT COALESCE(json_agg(json_build_object(
           'id', v.id, 'scheduledAt', v.scheduled_at, 'status', v.status,
           'durationMinutes', v.duration_minutes, 'notes', v.notes
         ) ORDER BY v.scheduled_at DESC), '[]')
         FROM visits v WHERE v.contact_id = cp.contact_id
       ) AS visits,
       (
         SELECT COALESCE(json_agg(json_build_object(
           'id', d.id, 'name', d.name, 'documentType', d.document_type,
           'fileUrl', d.file_url, 'uploadedAt', d.uploaded_at
         ) ORDER BY d.uploaded_at DESC), '[]')
         FROM documents d WHERE d.contact_id = cp.contact_id
       ) AS documents
     FROM users u
     JOIN client_profiles cp ON cp.user_id = u.id
     WHERE u.id = $1`,
    [userId]
  );
  if (!rows.length) { const err = new Error('Profil client introuvable.'); err.status = 404; throw err; }
  return rows[0];
}

async function resetPassword(clientId) {
  const { rows } = await pool.query('SELECT user_id FROM client_profiles WHERE id = $1', [clientId]);
  if (!rows.length) { const err = new Error('Client introuvable.'); err.status = 404; throw err; }

  const tempPassword = generateTempPassword();
  const passwordHash = await bcrypt.hash(tempPassword, SALT_ROUNDS);

  await pool.query(
    `UPDATE users
     SET password_hash = $1, must_change_password = TRUE, temp_password_hash = $2, updated_at = NOW()
     WHERE id = $3`,
    [passwordHash, passwordHash, rows[0].user_id]
  );

  return { temporaryPassword: tempPassword };
}

module.exports = { create, findAll, findById, update, remove, findPortal, resetPassword };
