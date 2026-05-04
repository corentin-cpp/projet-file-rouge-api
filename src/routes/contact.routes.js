const router = require('express').Router();
const ctrl = require('../controllers/contact.controller');
const authenticate = require('../middleware/auth');
const authorize = require('../middleware/authorize');

/**
 * @swagger
 * tags:
 *   name: Contacts
 *   description: Gestion des contacts clients
 */

/**
 * @swagger
 * /contacts:
 *   get:
 *     summary: Lister les contacts
 *     tags: [Contacts]
 *     parameters:
 *       - in: query
 *         name: agencyId
 *         schema: { type: string, format: uuid }
 *     responses:
 *       200: { description: Liste des contacts }
 *   post:
 *     summary: Créer un contact
 *     tags: [Contacts]
 *     responses:
 *       201: { description: Contact créé }
 */
router.get('/', authenticate, authorize('super_admin', 'agency_admin', 'agent'), ctrl.getAll);
router.post('/', authenticate, authorize('super_admin', 'agency_admin', 'agent'), ctrl.create);

/**
 * @swagger
 * /contacts/{id}:
 *   get:
 *     summary: Obtenir un contact
 *     tags: [Contacts]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     responses:
 *       200: { description: Contact trouvé }
 *   put:
 *     summary: Modifier un contact
 *     tags: [Contacts]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     responses:
 *       200: { description: Contact modifié }
 *   delete:
 *     summary: Supprimer un contact
 *     tags: [Contacts]
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

module.exports = router;
