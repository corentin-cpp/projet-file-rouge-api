const router = require('express').Router();
const ctrl = require('../controllers/document.controller');
const authenticate = require('../middleware/auth');
const authorize = require('../middleware/authorize');

/**
 * @swagger
 * tags:
 *   name: Documents
 *   description: Gestion des documents
 */

/**
 * @swagger
 * /documents:
 *   get:
 *     summary: Lister les documents
 *     tags: [Documents]
 *     parameters:
 *       - in: query
 *         name: propertyId
 *         schema: { type: string, format: uuid }
 *       - in: query
 *         name: contactId
 *         schema: { type: string, format: uuid }
 *       - in: query
 *         name: offerId
 *         schema: { type: string, format: uuid }
 *     responses:
 *       200: { description: Liste des documents }
 *   post:
 *     summary: Enregistrer un document
 *     tags: [Documents]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [name, documentType, fileUrl]
 *             properties:
 *               name: { type: string }
 *               documentType: { type: string }
 *               fileUrl: { type: string }
 *               mimeType: { type: string }
 *               fileSizeKb: { type: integer }
 *               propertyId: { type: string, format: uuid }
 *               contactId: { type: string, format: uuid }
 *               offerId: { type: string, format: uuid }
 *     responses:
 *       201: { description: Document enregistré }
 */
router.get('/', authenticate, authorize('super_admin', 'agency_admin', 'agent'), ctrl.getAll);
router.post('/', authenticate, authorize('super_admin', 'agency_admin', 'agent'), ctrl.create);

/**
 * @swagger
 * /documents/{id}:
 *   get:
 *     summary: Obtenir un document
 *     tags: [Documents]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     responses:
 *       200: { description: Document trouvé }
 *   delete:
 *     summary: Supprimer un document
 *     tags: [Documents]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     responses:
 *       204: { description: Supprimé }
 */
router.get('/:id', authenticate, ctrl.getOne);
router.delete('/:id', authenticate, authorize('super_admin', 'agency_admin'), ctrl.remove);

module.exports = router;
