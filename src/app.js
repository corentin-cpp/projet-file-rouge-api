require('dotenv').config();
const express = require('express');
const helmet = require('helmet');
const cors = require('cors');
const morgan = require('morgan');

const routes = require('./routes');
const errorHandler = require('./middleware/errorHandler');

const app = express();

app.use(helmet());
app.use(cors());
app.use(morgan(process.env.NODE_ENV === 'production' ? 'combined' : 'dev'));
app.use(express.json());

// Swagger — uniquement hors production
if (process.env.NODE_ENV !== 'production') {
  const swaggerUi = require('swagger-ui-express');
  const swaggerSpec = require('./config/swagger');
  app.use('/api/docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));
  console.log('Swagger disponible sur /api/docs');
}

// Injecter io dans req pour les contrôleurs
app.use((req, res, next) => {
  req.io = app.get('io');
  next();
});

app.use('/api', routes);

app.use((req, res) => res.status(404).json({ message: 'Route introuvable.' }));
app.use(errorHandler);

module.exports = app;
