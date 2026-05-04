const router = require('express').Router();
const ctrl = require('../controllers/tag.controller');
const authenticate = require('../middleware/auth');
const authorize = require('../middleware/authorize');

/**
 * @swagger
 * tags:
 *   name: Tags
 *   description: Gestion des tags de biens
 */

/**
 * @swagger
 * /tags:
 *   get:
 *     summary: Lister tous les tags
 *     tags: [Tags]
 *     responses:
 *       200: { description: Liste des tags }
 *   post:
 *     summary: Créer un tag
 *     tags: [Tags]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [label]
 *             properties:
 *               label: { type: string }
 *               color: { type: string, description: "Couleur hex (ex: #FF5733)" }
 *     responses:
 *       201: { description: Tag créé }
 */
router.get('/', authenticate, ctrl.getAll);
router.post('/', authenticate, authorize('super_admin', 'agency_admin'), ctrl.create);

/**
 * @swagger
 * /tags/{id}:
 *   delete:
 *     summary: Supprimer un tag
 *     tags: [Tags]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     responses:
 *       204: { description: Supprimé }
 */
router.delete('/:id', authenticate, authorize('super_admin', 'agency_admin'), ctrl.remove);

module.exports = router;
