const tagService = require('../services/tag.service');

const getAll = async (req, res, next) => { try { res.json(await tagService.findAll()); } catch (e) { next(e); } };
const create = async (req, res, next) => { try { res.status(201).json(await tagService.create(req.body)); } catch (e) { next(e); } };
const remove = async (req, res, next) => { try { await tagService.remove(req.params.id); res.status(204).send(); } catch (e) { next(e); } };

module.exports = { getAll, create, remove };
