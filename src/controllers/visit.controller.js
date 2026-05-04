const visitService = require('../services/visit.service');

const getAll = async (req, res, next) => { try { res.json(await visitService.findAll(req.query)); } catch (e) { next(e); } };
const getOne = async (req, res, next) => { try { res.json(await visitService.findById(req.params.id)); } catch (e) { next(e); } };
const create = async (req, res, next) => { try { res.status(201).json(await visitService.create({ ...req.body, agentId: req.user.id })); } catch (e) { next(e); } };
const update = async (req, res, next) => { try { res.json(await visitService.update(req.params.id, req.body)); } catch (e) { next(e); } };
const remove = async (req, res, next) => { try { await visitService.remove(req.params.id); res.status(204).send(); } catch (e) { next(e); } };

module.exports = { getAll, getOne, create, update, remove };
