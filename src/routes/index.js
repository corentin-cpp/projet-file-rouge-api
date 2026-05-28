const router = require('express').Router();

router.use('/auth', require('./auth.routes'));
router.use('/agencies', require('./agency.routes'));
router.use('/clients', require('./client.routes'));
router.use('/users', require('./user.routes'));
router.use('/properties', require('./property.routes'));
router.use('/tags', require('./tag.routes'));
router.use('/contacts', require('./contact.routes'));
router.use('/mandates', require('./mandate.routes'));
router.use('/offers', require('./offer.routes'));
router.use('/visits', require('./visit.routes'));
router.use('/documents', require('./document.routes'));
router.use('/conversations', require('./conversation.routes'));

module.exports = router;
