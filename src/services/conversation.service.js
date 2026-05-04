const pool = require('../config/database');

async function findAll(userId) {
  const { rows } = await pool.query(
    `SELECT c.*, array_agg(cu.user_id) AS members
     FROM conversations c
     JOIN conversation_users cu ON cu.conversation_id = c.id
     WHERE c.id IN (SELECT conversation_id FROM conversation_users WHERE user_id = $1)
     GROUP BY c.id ORDER BY c.created_at DESC`,
    [userId]
  );
  return rows;
}

async function findById(id, userId) {
  const { rows } = await pool.query(
    `SELECT c.* FROM conversations c
     JOIN conversation_users cu ON cu.conversation_id = c.id
     WHERE c.id = $1 AND cu.user_id = $2`,
    [id, userId]
  );
  if (!rows.length) { const err = new Error('Conversation introuvable.'); err.status = 404; throw err; }
  return rows[0];
}

async function create({ agencyId, propertyId, contactId, conversationType, title, userIds }) {
  const client = await pool.connect();
  try {
    await client.query('BEGIN');
    const { rows } = await client.query(
      `INSERT INTO conversations (agency_id, property_id, contact_id, conversation_type, title)
       VALUES ($1,$2,$3,$4,$5) RETURNING *`,
      [agencyId || null, propertyId || null, contactId || null, conversationType, title || null]
    );
    const conv = rows[0];
    for (const uid of userIds) {
      await client.query(
        'INSERT INTO conversation_users (conversation_id, user_id) VALUES ($1,$2) ON CONFLICT DO NOTHING',
        [conv.id, uid]
      );
    }
    await client.query('COMMIT');
    return conv;
  } catch (err) {
    await client.query('ROLLBACK');
    throw err;
  } finally {
    client.release();
  }
}

async function addUser(conversationId, userId) {
  await pool.query(
    'INSERT INTO conversation_users (conversation_id, user_id) VALUES ($1,$2) ON CONFLICT DO NOTHING',
    [conversationId, userId]
  );
}

async function markRead(conversationId, userId) {
  await pool.query(
    'UPDATE conversation_users SET last_read_at = NOW() WHERE conversation_id = $1 AND user_id = $2',
    [conversationId, userId]
  );
}

module.exports = { findAll, findById, create, addUser, markRead };
