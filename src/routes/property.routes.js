const router = require('express').Router();
const ctrl = require('../controllers/property.controller');
const authenticate = require('../middleware/auth');
const authorize = require('../middleware/authorize');

/**
 * @swagger
 * tags:
 *   name: Properties
 *   description: Gestion des biens immobiliers
 */

/**
 * @swagger
 * /properties:
 *   get:
 *     summary: Lister les biens
 *     tags: [Properties]
 *     parameters:
 *       - in: query
 *         name: agencyId
 *         schema: { type: string }
 *       - in: query
 *         name: city
 *         schema: { type: string }
 *       - in: query
 *         name: type
 *         schema: { type: string, enum: [apartment, house, land, commercial, garage, other] }
 *       - in: query
 *         name: transactionType
 *         schema: { type: string, enum: [sale, rent] }
 *       - in: query
 *         name: minPrice
 *         schema: { type: number }
 *       - in: query
 *         name: maxPrice
 *         schema: { type: number }
 *     responses:
 *       200: { description: Liste des biens }
 *   post:
 *     summary: Créer un bien
 *     tags: [Properties]
 *     responses:
 *       201: { description: Bien créé }
 */
router.get('/', authenticate, ctrl.getAll);
router.post('/', authenticate, authorize('super_admin', 'agency_admin', 'agent'), ctrl.create);

/**
 * @swagger
 * /properties/{id}:
 *   get:
 *     summary: Détail d'un bien
 *     tags: [Properties]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     responses:
 *       200: { description: Bien trouvé }
 *   put:
 *     summary: Modifier un bien
 *     tags: [Properties]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     responses:
 *       200: { description: Bien modifié }
 *   delete:
 *     summary: Supprimer un bien
 *     tags: [Properties]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     responses:
 *       204: { description: Supprimé }
 */
router.get('/:id', authenticate, ctrl.getOne);
router.put('/:id', authenticate, authorize('super_admin', 'agency_admin', 'agent'), ctrl.update);
router.delete('/:id', authenticate, authorize('super_admin', 'agency_admin'), ctrl.remove);

/**
 * @swagger
 * /properties/{id}/images:
 *   get:
 *     summary: Images d'un bien
 *     tags: [Properties]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     responses:
 *       200: { description: Liste des images }
 *   post:
 *     summary: Ajouter une image
 *     tags: [Properties]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     responses:
 *       201: { description: Image ajoutée }
 */
router.get('/:id/images', authenticate, ctrl.getImages);
router.post('/:id/images', authenticate, authorize('super_admin', 'agency_admin', 'agent'), ctrl.addImage);

/**
 * @swagger
 * /properties/{id}/tags:
 *   post:
 *     summary: Ajouter un tag à un bien
 *     tags: [Properties]
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
 *             required: [tagId]
 *             properties:
 *               tagId: { type: string, format: uuid }
 *     responses:
 *       204: { description: Tag ajouté }
 */
router.post('/:id/tags', authenticate, authorize('super_admin', 'agency_admin', 'agent'), ctrl.addTag);

/**
 * @swagger
 * /properties/{id}/tags/{tagId}:
 *   delete:
 *     summary: Retirer un tag d'un bien
 *     tags: [Properties]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *       - in: path
 *         name: tagId
 *         required: true
 *         schema: { type: string, format: uuid }
 *     responses:
 *       204: { description: Tag retiré }
 */
router.delete('/:id/tags/:tagId', authenticate, authorize('super_admin', 'agency_admin', 'agent'), ctrl.removeTag);

module.exports = router;
