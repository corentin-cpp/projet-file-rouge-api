const propertyService = require('../services/property.service');

const getAll = async (req, res, next) => { try { res.json(await propertyService.findAll(req.query)); } catch (e) { next(e); } };
const getOne = async (req, res, next) => { try { res.json(await propertyService.findById(req.params.id)); } catch (e) { next(e); } };
const create = async (req, res, next) => { try { res.status(201).json(await propertyService.create(req.body, req.user.id)); } catch (e) { next(e); } };
const update = async (req, res, next) => { try { res.json(await propertyService.update(req.params.id, req.body)); } catch (e) { next(e); } };
const remove = async (req, res, next) => { try { await propertyService.remove(req.params.id); res.status(204).send(); } catch (e) { next(e); } };

const getImages = async (req, res, next) => { try { res.json(await propertyService.getImages(req.params.id)); } catch (e) { next(e); } };
const addImage = async (req, res, next) => { try { res.status(201).json(await propertyService.addImage(req.params.id, req.body)); } catch (e) { next(e); } };

const addTag = async (req, res, next) => { try { await propertyService.addTag(req.params.id, req.body.tagId); res.status(204).send(); } catch (e) { next(e); } };
const removeTag = async (req, res, next) => { try { await propertyService.removeTag(req.params.id, req.params.tagId); res.status(204).send(); } catch (e) { next(e); } };

module.exports = { getAll, getOne, create, update, remove, getImages, addImage, addTag, removeTag };
