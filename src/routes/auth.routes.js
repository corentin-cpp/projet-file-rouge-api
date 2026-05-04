const router = require('express').Router();
const ctrl = require('../controllers/auth.controller');
const authenticate = require('../middleware/auth');

/**
 * @swagger
 * tags:
 *   name: Auth
 *   description: Authentification et gestion de session
 */

/**
 * @swagger
 * /auth/register:
 *   post:
 *     summary: Créer un compte utilisateur
 *     tags: [Auth]
 *     security: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [firstName, lastName, email, password, role]
 *             properties:
 *               firstName: { type: string }
 *               lastName: { type: string }
 *               email: { type: string, format: email }
 *               password: { type: string, minLength: 8 }
 *               phone: { type: string }
 *               role: { type: string, enum: [super_admin, agency_admin, agent, client] }
 *               agencyId: { type: string, format: uuid }
 *     responses:
 *       201: { description: Utilisateur créé }
 *       409: { description: Email déjà utilisé }
 */
router.post('/register', ctrl.register);

/**
 * @swagger
 * /auth/login:
 *   post:
 *     summary: Se connecter
 *     tags: [Auth]
 *     security: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [email, password]
 *             properties:
 *               email: { type: string }
 *               password: { type: string }
 *     responses:
 *       200: { description: Tokens JWT retournés }
 *       401: { description: Identifiants invalides }
 */
router.post('/login', ctrl.login);

/**
 * @swagger
 * /auth/refresh:
 *   post:
 *     summary: Rafraîchir l'access token
 *     tags: [Auth]
 *     security: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [refreshToken]
 *             properties:
 *               refreshToken: { type: string }
 *     responses:
 *       200: { description: Nouvel access token }
 *       401: { description: Refresh token invalide }
 */
router.post('/refresh', ctrl.refresh);

/**
 * @swagger
 * /auth/logout:
 *   post:
 *     summary: Se déconnecter
 *     tags: [Auth]
 *     responses:
 *       200: { description: Déconnexion réussie }
 */
router.post('/logout', authenticate, ctrl.logout);

/**
 * @swagger
 * /auth/me:
 *   get:
 *     summary: Profil de l'utilisateur connecté
 *     tags: [Auth]
 *     responses:
 *       200: { description: Données utilisateur }
 */
router.get('/me', authenticate, ctrl.me);

module.exports = router;
