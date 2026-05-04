const router = require('express').Router();
const ctrl = require('../controllers/offer.controller');
const authenticate = require('../middleware/auth');
const authorize = require('../middleware/authorize');

/**
 * @swagger
 * tags:
 *   name: Offers
 *   description: Gestion des offres d'achat/location
 */

/**
 * @swagger
 * /offers:
 *   get:
 *     summary: Lister les offres
 *     tags: [Offers]
 *     parameters:
 *       - in: query
 *         name: propertyId
 *         schema: { type: string, format: uuid }
 *       - in: query
 *         name: contactId
 *         schema: { type: string, format: uuid }
 *     responses:
 *       200: { description: Liste des offres }
 *   post:
 *     summary: Créer une offre
 *     tags: [Offers]
 *     responses:
 *       201: { description: Offre créée }
 */
router.get('/', authenticate, authorize('super_admin', 'agency_admin', 'agent'), ctrl.getAll);
router.post('/', authenticate, authorize('super_admin', 'agency_admin', 'agent'), ctrl.create);

/**
 * @swagger
 * /offers/{id}:
 *   get:
 *     summary: Obtenir une offre
 *     tags: [Offers]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     responses:
 *       200: { description: Offre trouvée }
 *   put:
 *     summary: Modifier une offre (accepter, refuser…)
 *     tags: [Offers]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     responses:
 *       200: { description: Offre modifiée }
 *   delete:
 *     summary: Supprimer une offre
 *     tags: [Offers]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     responses:
 *       204: { description: Supprimée }
 */
router.get('/:id', authenticate, authorize('super_admin', 'agency_admin', 'agent'), ctrl.getOne);
router.put('/:id', authenticate, authorize('super_admin', 'agency_admin', 'agent'), ctrl.update);
router.delete('/:id', authenticate, authorize('super_admin', 'agency_admin'), ctrl.remove);

module.exports = router;
