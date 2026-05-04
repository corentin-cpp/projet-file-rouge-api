const router = require('express').Router();
const ctrl = require('../controllers/conversation.controller');
const authenticate = require('../middleware/auth');

/**
 * @swagger
 * tags:
 *   name: Conversations
 *   description: Messagerie en temps réel
 */

/**
 * @swagger
 * /conversations:
 *   get:
 *     summary: Mes conversations
 *     tags: [Conversations]
 *     responses:
 *       200: { description: Liste des conversations de l'utilisateur }
 *   post:
 *     summary: Créer une conversation
 *     tags: [Conversations]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [conversationType, userIds]
 *             properties:
 *               conversationType: { type: string, enum: [internal, client, support] }
 *               title: { type: string }
 *               agencyId: { type: string, format: uuid }
 *               propertyId: { type: string, format: uuid }
 *               contactId: { type: string, format: uuid }
 *               userIds: { type: array, items: { type: string, format: uuid } }
 *     responses:
 *       201: { description: Conversation créée }
 */
router.get('/', authenticate, ctrl.getAll);
router.post('/', authenticate, ctrl.create);

/**
 * @swagger
 * /conversations/{id}:
 *   get:
 *     summary: Détail d'une conversation
 *     tags: [Conversations]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     responses:
 *       200: { description: Conversation trouvée }
 */
router.get('/:id', authenticate, ctrl.getOne);

/**
 * @swagger
 * /conversations/{id}/users:
 *   post:
 *     summary: Ajouter un participant
 *     tags: [Conversations]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [userId]
 *             properties:
 *               userId: { type: string, format: uuid }
 *     responses:
 *       204: { description: Participant ajouté }
 */
router.post('/:id/users', authenticate, ctrl.addUser);

/**
 * @swagger
 * /conversations/{id}/messages:
 *   get:
 *     summary: Messages d'une conversation
 *     tags: [Conversations]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *       - in: query
 *         name: limit
 *         schema: { type: integer, default: 50 }
 *       - in: query
 *         name: before
 *         schema: { type: string, format: date-time }
 *     responses:
 *       200: { description: Liste des messages }
 *   post:
 *     summary: Envoyer un message (REST + Socket.IO)
 *     tags: [Conversations]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [content]
 *             properties:
 *               content: { type: string }
 *               messageType: { type: string, enum: [text, image, file, system], default: text }
 *     responses:
 *       201: { description: Message envoyé }
 */
router.get('/:id/messages', authenticate, ctrl.getMessages);
router.post('/:id/messages', authenticate, ctrl.sendMessage);

/**
 * @swagger
 * /conversations/{id}/messages/{messageId}:
 *   delete:
 *     summary: Supprimer un message (soft delete)
 *     tags: [Conversations]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *       - in: path
 *         name: messageId
 *         required: true
 *         schema: { type: string, format: uuid }
 *     responses:
 *       204: { description: Message supprimé }
 */
router.delete('/:id/messages/:messageId', authenticate, ctrl.deleteMessage);

module.exports = router;
