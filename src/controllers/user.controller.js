const userService = require('../services/user.service');

const getAll = async (req, res, next) => { try { res.json(await userService.findAll(req.query)); } catch (e) { next(e); } };
const getOne = async (req, res, next) => { try { res.json(await userService.findById(req.params.id)); } catch (e) { next(e); } };
const update = async (req, res, next) => { try { res.json(await userService.update(req.params.id, req.body)); } catch (e) { next(e); } };
const remove = async (req, res, next) => { try { await userService.remove(req.params.id); res.status(204).send(); } catch (e) { next(e); } };

module.exports = { getAll, getOne, update, remove };
