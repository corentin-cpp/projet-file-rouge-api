const conversationService = require('../services/conversation.service');
const messageService = require('../services/message.service');

const getAll = async (req, res, next) => { try { res.json(await conversationService.findAll(req.user.id)); } catch (e) { next(e); } };
const getOne = async (req, res, next) => {
  try {
    const conv = await conversationService.findById(req.params.id, req.user.id);
    await conversationService.markRead(req.params.id, req.user.id);
    res.json(conv);
  } catch (e) { next(e); }
};
const create = async (req, res, next) => {
  try {
    const userIds = req.body.userIds || [];
    if (!userIds.includes(req.user.id)) userIds.push(req.user.id);
    res.status(201).json(await conversationService.create({ ...req.body, userIds }));
  } catch (e) { next(e); }
};
const addUser = async (req, res, next) => {
  try {
    await conversationService.addUser(req.params.id, req.body.userId);
    res.status(204).send();
  } catch (e) { next(e); }
};

const getMessages = async (req, res, next) => {
  try {
    await conversationService.findById(req.params.id, req.user.id);
    const messages = await messageService.findByConversation(req.params.id, req.query);
    await conversationService.markRead(req.params.id, req.user.id);
    res.json(messages);
  } catch (e) { next(e); }
};

const sendMessage = async (req, res, next) => {
  try {
    await conversationService.findById(req.params.id, req.user.id);
    const message = await messageService.create(req.params.id, req.user.id, req.body);
    await conversationService.markRead(req.params.id, req.user.id);
    req.io.to(`conversation:${req.params.id}`).emit('message:new', message);
    res.status(201).json(message);
  } catch (e) { next(e); }
};

const deleteMessage = async (req, res, next) => {
  try {
    await messageService.softDelete(req.params.messageId, req.user.id);
    req.io.to(`conversation:${req.params.id}`).emit('message:deleted', { id: req.params.messageId });
    res.status(204).send();
  } catch (e) { next(e); }
};

module.exports = { getAll, getOne, create, addUser, getMessages, sendMessage, deleteMessage };
