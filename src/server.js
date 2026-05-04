const http = require('http');
const { Server } = require('socket.io');
const app = require('./app');
const socketService = require('./services/socket.service');

const PORT = process.env.PORT || 3000;

const server = http.createServer(app);

const io = new Server(server, {
  cors: { origin: '*', methods: ['GET', 'POST'] },
});

app.set('io', io);
socketService.init(io);

server.listen(PORT, () => {
  console.log(`Ymmo API démarrée sur le port ${PORT} [${process.env.NODE_ENV || 'development'}]`);
});
