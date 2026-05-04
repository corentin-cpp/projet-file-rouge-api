const pool = require('../config/database');

async function findByConversation(conversationId, { limit = 50, before } = {}) {
  const values = [conversationId, limit];
  let cursor = '';
  if (before) { cursor = 'AND m.sent_at < $3'; values.push(before); }
  const { rows } = await pool.query(
    `SELECT m.*, u.first_name, u.last_name
     FROM messages m JOIN users u ON u.id = m.sender_id
     WHERE m.conversation_id = $1 AND m.is_deleted = FALSE ${cursor}
     ORDER BY m.sent_at DESC LIMIT $2`,
    values
  );
  return rows.reverse();
}

async function create(conversationId, senderId, { content, messageType }) {
  const { rows } = await pool.query(
    `INSERT INTO messages (conversation_id, sender_id, content, message_type)
     VALUES ($1,$2,$3,$4) RETURNING *`,
    [conversationId, senderId, content, messageType || 'text']
  );
  return rows[0];
}

async function softDelete(id, userId) {
  const { rows } = await pool.query('SELECT * FROM messages WHERE id = $1', [id]);
  if (!rows.length) { const err = new Error('Message introuvable.'); err.status = 404; throw err; }
  if (rows[0].sender_id !== userId) { const err = new Error('Accès refusé.'); err.status = 403; throw err; }
  await pool.query('UPDATE messages SET is_deleted = TRUE, deleted_at = NOW() WHERE id = $1', [id]);
}

module.exports = { findByConversation, create, softDelete };
