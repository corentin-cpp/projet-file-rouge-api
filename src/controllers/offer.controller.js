const offerService = require('../services/offer.service');

const getAll = async (req, res, next) => { try { res.json(await offerService.findAll(req.query)); } catch (e) { next(e); } };
const getOne = async (req, res, next) => { try { res.json(await offerService.findById(req.params.id)); } catch (e) { next(e); } };
const create = async (req, res, next) => { try { res.status(201).json(await offerService.create({ ...req.body, agentId: req.user.id })); } catch (e) { next(e); } };
const update = async (req, res, next) => { try { res.json(await offerService.update(req.params.id, req.body)); } catch (e) { next(e); } };
const remove = async (req, res, next) => { try { await offerService.remove(req.params.id); res.status(204).send(); } catch (e) { next(e); } };

module.exports = { getAll, getOne, create, update, remove };
