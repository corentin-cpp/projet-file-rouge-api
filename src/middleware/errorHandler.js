module.exports = function errorHandler(err, req, res, next) {
  const status = err.status || 500;
  const message = err.message || 'Erreur interne du serveur.';
  if (status === 500) console.error(err);
  res.status(status).json({ message, ...(err.details && { details: err.details }) });
};
