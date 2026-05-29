const { Pool, neonConfig } = require("@neondatabase/serverless");
const ws = require("ws");
require("dotenv").config();

neonConfig.webSocketConstructor = ws;

const pool = new Pool({ connectionString: process.env.DB_URL });

pool.on("error", (err) => {
  console.error("Unexpected error on idle client", err);
  process.exit(-1);
});

module.exports = pool;
