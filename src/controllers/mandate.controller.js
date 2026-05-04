const mandateService = require('../services/mandate.service');

const getAll = async (req, res, next) => { try { res.json(await mandateService.findAll(req.query)); } catch (e) { next(e); } };
const getOne = async (req, res, next) => { try { res.json(await mandateService.findById(req.params.id)); } catch (e) { next(e); } };
const create = async (req, res, next) => { try { res.status(201).json(await mandateService.create(req.body)); } catch (e) { next(e); } };
const update = async (req, res, next) => { try { res.json(await mandateService.update(req.params.id, req.body)); } catch (e) { next(e); } };
const remove = async (req, res, next) => { try { await mandateService.remove(req.params.id); res.status(204).send(); } catch (e) { next(e); } };
const addContact = async (req, res, next) => {
  try {
    await mandateService.addContact(req.params.id, req.body.contactId, req.body.role);
    res.status(204).send();
  } catch (e) { next(e); }
};

module.exports = { getAll, getOne, create, update, remove, addContact };
