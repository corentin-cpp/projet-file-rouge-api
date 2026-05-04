const router = require('express').Router();
const ctrl = require('../controllers/visit.controller');
const authenticate = require('../middleware/auth');
const authorize = require('../middleware/authorize');

/**
 * @swagger
 * tags:
 *   name: Visits
 *   description: Planification des visites
 */

/**
 * @swagger
 * /visits:
 *   get:
 *     summary: Lister les visites
 *     tags: [Visits]
 *     parameters:
 *       - in: query
 *         name: agentId
 *         schema: { type: string, format: uuid }
 *       - in: query
 *         name: propertyId
 *         schema: { type: string, format: uuid }
 *       - in: query
 *         name: contactId
 *         schema: { type: string, format: uuid }
 *     responses:
 *       200: { description: Liste des visites }
 *   post:
 *     summary: Planifier une visite
 *     tags: [Visits]
 *     responses:
 *       201: { description: Visite planifiée }
 */
router.get('/', authenticate, authorize('super_admin', 'agency_admin', 'agent'), ctrl.getAll);
router.post('/', authenticate, authorize('super_admin', 'agency_admin', 'agent'), ctrl.create);

/**
 * @swagger
 * /visits/{id}:
 *   get:
 *     summary: Obtenir une visite
 *     tags: [Visits]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     responses:
 *       200: { description: Visite trouvée }
 *   put:
 *     summary: Modifier une visite
 *     tags: [Visits]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     responses:
 *       200: { description: Visite modifiée }
 *   delete:
 *     summary: Annuler une visite
 *     tags: [Visits]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     responses:
 *       204: { description: Annulée }
 */
router.get('/:id', authenticate, authorize('super_admin', 'agency_admin', 'agent'), ctrl.getOne);
router.put('/:id', authenticate, authorize('super_admin', 'agency_admin', 'agent'), ctrl.update);
router.delete('/:id', authenticate, authorize('super_admin', 'agency_admin', 'agent'), ctrl.remove);

module.exports = router;
