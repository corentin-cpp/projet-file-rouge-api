const router = require('express').Router();
const ctrl = require('../controllers/client.controller');
const authenticate = require('../middleware/auth');
const authorize = require('../middleware/authorize');

/**
 * @swagger
 * tags:
 *   name: Clients
 *   description: Gestion des clients (accès espace personnel)
 */

/**
 * @swagger
 * /clients:
 *   get:
 *     summary: Lister les clients
 *     tags: [Clients]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: agencyId
 *         schema: { type: string, format: uuid }
 *         description: Filtrer par agence (super_admin uniquement)
 *     responses:
 *       200: { description: Liste des clients }
 *   post:
 *     summary: Créer un client (génère un mot de passe provisoire)
 *     tags: [Clients]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [contactId, firstName, lastName, email]
 *             properties:
 *               contactId:        { type: string, format: uuid }
 *               firstName:        { type: string }
 *               lastName:         { type: string }
 *               email:            { type: string, format: email }
 *               phone:            { type: string }
 *               propertyId:       { type: string, format: uuid }
 *               assignedAgentId:  { type: string, format: uuid }
 *               agencyId:         { type: string, format: uuid, description: "super_admin uniquement" }
 *     responses:
 *       201:
 *         description: Client créé — temporaryPassword visible une seule fois
 */
router.get('/', authenticate, authorize('super_admin', 'agency_admin', 'agent'), ctrl.getAll);
router.post('/', authenticate, authorize('super_admin', 'agency_admin', 'agent'), ctrl.create);

/**
 * @swagger
 * /clients/portal:
 *   get:
 *     summary: Tableau de bord du client connecté (bien, offres, visites, documents)
 *     tags: [Clients]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200: { description: Données du portail client }
 */
router.get('/portal', authenticate, authorize('client'), ctrl.getPortal);

/**
 * @swagger
 * /clients/{id}:
 *   get:
 *     summary: Obtenir un client
 *     tags: [Clients]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     responses:
 *       200: { description: Profil client }
 *   put:
 *     summary: Modifier un client (agents — tous les champs ; client — champs financiers uniquement)
 *     tags: [Clients]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     requestBody:
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               firstName:      { type: string }
 *               lastName:       { type: string }
 *               email:          { type: string, format: email }
 *               phone:          { type: string }
 *               isActive:       { type: boolean }
 *               propertyId:     { type: string, format: uuid }
 *               assignedAgentId:{ type: string, format: uuid }
 *               iban:           { type: string }
 *               bic:            { type: string }
 *               bankName:       { type: string }
 *               monthlyIncome:  { type: number }
 *               employmentType: { type: string, enum: [employee, self_employed, civil_servant, retired, student, unemployed, other] }
 *     responses:
 *       200: { description: Client mis à jour }
 *   delete:
 *     summary: Supprimer un client
 *     tags: [Clients]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     responses:
 *       204: { description: Supprimé }
 */
router.get('/:id', authenticate, authorize('super_admin', 'agency_admin', 'agent'), ctrl.getOne);
router.put('/:id', authenticate, authorize('super_admin', 'agency_admin', 'agent', 'client'), ctrl.update);
router.delete('/:id', authenticate, authorize('super_admin', 'agency_admin'), ctrl.remove);

/**
 * @swagger
 * /clients/{id}/reset-password:
 *   post:
 *     summary: Régénérer un mot de passe provisoire pour un client
 *     tags: [Clients]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: string, format: uuid }
 *     responses:
 *       200:
 *         description: Nouveau mot de passe provisoire — visible une seule fois
 */
router.post('/:id/reset-password', authenticate, authorize('super_admin', 'agency_admin', 'agent'), ctrl.resetPassword);

module.exports = router;
