const contactService = require('../services/contact.service');

const getAll = async (req, res, next) => { try { res.json(await contactService.findAll(req.query)); } catch (e) { next(e); } };
const getOne = async (req, res, next) => { try { res.json(await contactService.findById(req.params.id)); } catch (e) { next(e); } };
const create = async (req, res, next) => { try { res.status(201).json(await contactService.create(req.body)); } catch (e) { next(e); } };
const update = async (req, res, next) => { try { res.json(await contactService.update(req.params.id, req.body)); } catch (e) { next(e); } };
const remove = async (req, res, next) => { try { await contactService.remove(req.params.id); res.status(204).send(); } catch (e) { next(e); } };

module.exports = { getAll, getOne, create, update, remove };
