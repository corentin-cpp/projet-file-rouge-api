const documentService = require('../services/document.service');

const getAll = async (req, res, next) => { try { res.json(await documentService.findAll(req.query)); } catch (e) { next(e); } };
const getOne = async (req, res, next) => { try { res.json(await documentService.findById(req.params.id)); } catch (e) { next(e); } };
const create = async (req, res, next) => { try { res.status(201).json(await documentService.create(req.body)); } catch (e) { next(e); } };
const remove = async (req, res, next) => { try { await documentService.remove(req.params.id); res.status(204).send(); } catch (e) { next(e); } };

module.exports = { getAll, getOne, create, remove };
