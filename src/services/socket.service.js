const jwt = require('jsonwebtoken');
const messageService = require('./message.service');
const conversationService = require('./conversation.service');

function init(io) {
  io.use((socket, next) => {
    const token = socket.handshake.auth?.token;
    if (!token) return next(new Error('Authentication required'));
    try {
      socket.user = jwt.verify(token, process.env.JWT_SECRET);
      next();
    } catch {
      next(new Error('Invalid token'));
    }
  });

  io.on('connection', (socket) => {
    const userId = socket.user.id;

    socket.on('join_conversation', async (conversationId) => {
      try {
        await conversationService.findById(conversationId, userId);
        socket.join(`conversation:${conversationId}`);
        socket.to(`conversation:${conversationId}`).emit('user:joined', { userId, conversationId });
      } catch {
        socket.emit('error', { message: 'Conversation introuvable ou accès refusé.' });
      }
    });

    socket.on('leave_conversation', (conversationId) => {
      socket.leave(`conversation:${conversationId}`);
      socket.to(`conversation:${conversationId}`).emit('user:left', { userId, conversationId });
    });

    socket.on('send_message', async ({ conversationId, content, messageType }) => {
      try {
        await conversationService.findById(conversationId, userId);
        const message = await messageService.create(conversationId, userId, { content, messageType });
        await conversationService.markRead(conversationId, userId);
        io.to(`conversation:${conversationId}`).emit('message:new', message);
      } catch {
        socket.emit('error', { message: 'Impossible d\'envoyer le message.' });
      }
    });

    socket.on('typing:start', ({ conversationId }) => {
      socket.to(`conversation:${conversationId}`).emit('typing:start', { userId, conversationId });
    });

    socket.on('typing:stop', ({ conversationId }) => {
      socket.to(`conversation:${conversationId}`).emit('typing:stop', { userId, conversationId });
    });

    socket.on('disconnect', () => {});
  });
}

module.exports = { init };
