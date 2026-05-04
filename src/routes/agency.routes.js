const router = require('express').Router();
const ctrl = require('../controllers/agency.controller');
const authenticate = require('../middleware/auth');
const authorize = require('../middleware/authorize');

/**
 * @swagger
 * tags:
 *   name: Agencies
 *   description: Gestion des agences immobilières
 */

/**
 * @swagger
 * /agencies:
 *   get:
 *     summary: Lister toutes les agences
 *     tags: [Agencies]
 *     responses:
 *       200: { description: Liste des agences }
 *   post:
 *     summary: Créer une agence
 *     tags: [Agencies]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [name, email]
 *             properties:
 *               name: { type: string }
 *               siret: { type: string }
 *               email: { type: string }
 *               phone: { type: string }
 *               address: { type: string }
 *               city: { type: string }
 *               postalCode: { type: string }
 *               country: { type: string }
 *     responses:
 *       201: { description: Agence créée }
 */
router.get('/', ctrl.getAll);
router.post('/', authenticate, authorize('super_admin'), ctrl.create);

/**
 * @swagger
 * /agencies/{id}:
 *   get:
 *     summary: Obtenir une agence
 *     tags: [Agencies]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     responses:
 *       200: { description: Agence trouvée }
 *       404: { description: Introuvable }
 *   put:
 *     summary: Modifier une agence
 *     tags: [Agencies]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     responses:
 *       200: { description: Agence modifiée }
 *   delete:
 *     summary: Supprimer une agence
 *     tags: [Agencies]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     responses:
 *       204: { description: Supprimée }
 */
router.get('/:id', ctrl.getOne);
router.put('/:id', authenticate, authorize('super_admin', 'agency_admin'), ctrl.update);
router.delete('/:id', authenticate, authorize('super_admin'), ctrl.remove);

module.exports = router;
