const clientService = require('../services/client.service');

const getAll = async (req, res, next) => {
  try {
    const agencyId = req.user.role === 'super_admin' ? req.query.agencyId : req.user.agencyId;
    res.json(await clientService.findAll({ agencyId }));
  } catch (e) { next(e); }
};

const getOne = async (req, res, next) => {
  try { res.json(await clientService.findById(req.params.id)); } catch (e) { next(e); }
};

const create = async (req, res, next) => {
  try {
    const agencyId = req.user.role === 'super_admin' ? req.body.agencyId : req.user.agencyId;
    const client = await clientService.create({ ...req.body, agencyId });
    res.status(201).json(client);
  } catch (e) { next(e); }
};

const update = async (req, res, next) => {
  try {
    const result = await clientService.update(
      req.params.id,
      req.body,
      req.user.role,
      req.user.id,
      req.user.agencyId
    );
    res.json(result);
  } catch (e) { next(e); }
};

const remove = async (req, res, next) => {
  try { await clientService.remove(req.params.id); res.status(204).send(); } catch (e) { next(e); }
};

const getPortal = async (req, res, next) => {
  try { res.json(await clientService.findPortal(req.user.id)); } catch (e) { next(e); }
};

const resetPassword = async (req, res, next) => {
  try { res.json(await clientService.resetPassword(req.params.id)); } catch (e) { next(e); }
};

module.exports = { getAll, getOne, create, update, remove, getPortal, resetPassword };
