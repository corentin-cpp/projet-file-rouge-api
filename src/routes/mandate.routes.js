const router = require('express').Router();
const ctrl = require('../controllers/mandate.controller');
const authenticate = require('../middleware/auth');
const authorize = require('../middleware/authorize');

/**
 * @swagger
 * tags:
 *   name: Mandates
 *   description: Gestion des mandats de vente/location
 */

/**
 * @swagger
 * /mandates:
 *   get:
 *     summary: Lister les mandats
 *     tags: [Mandates]
 *     parameters:
 *       - in: query
 *         name: agencyId
 *         schema: { type: string, format: uuid }
 *     responses:
 *       200: { description: Liste des mandats }
 *   post:
 *     summary: Créer un mandat
 *     tags: [Mandates]
 *     responses:
 *       201: { description: Mandat créé }
 */
router.get('/', authenticate, authorize('super_admin', 'agency_admin', 'agent'), ctrl.getAll);
router.post('/', authenticate, authorize('super_admin', 'agency_admin', 'agent'), ctrl.create);

/**
 * @swagger
 * /mandates/{id}:
 *   get:
 *     summary: Obtenir un mandat
 *     tags: [Mandates]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     responses:
 *       200: { description: Mandat trouvé }
 *   put:
 *     summary: Modifier un mandat
 *     tags: [Mandates]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     responses:
 *       200: { description: Mandat modifié }
 *   delete:
 *     summary: Supprimer un mandat
 *     tags: [Mandates]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     responses:
 *       204: { description: Supprimé }
 */
router.get('/:id', authenticate, authorize('super_admin', 'agency_admin', 'agent'), ctrl.getOne);
router.put('/:id', authenticate, authorize('super_admin', 'agency_admin', 'agent'), ctrl.update);
router.delete('/:id', authenticate, authorize('super_admin', 'agency_admin'), ctrl.remove);

/**
 * @swagger
 * /mandates/{id}/contacts:
 *   post:
 *     summary: Associer un contact à un mandat
 *     tags: [Mandates]
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
 *             required: [contactId, role]
 *             properties:
 *               contactId: { type: string, format: uuid }
 *               role: { type: string }
 *     responses:
 *       204: { description: Contact associé }
 */
router.post('/:id/contacts', authenticate, authorize('super_admin', 'agency_admin', 'agent'), ctrl.addContact);

module.exports = router;
