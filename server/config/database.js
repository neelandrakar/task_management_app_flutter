const { Sequelize } = require("sequelize");


// Create a Sequelize instance
const sequelize = new Sequelize("task_management_schema", "root", "Neelandra@10", {
  host: "0.0.0.0", // Database host
  dialect: "mysql", // Database dialect (MySQL in this case)
  logging: false, // Disable logging of SQL queries (set to `true` for debugging)
  pool: {
    max: 5, // Maximum number of connections
    min: 0, // Minimum number of connections
    acquire: 30000, // Maximum time (ms) a connection can be idle before being released
    idle: 10000, // Maximum time (ms) a connection can be idle
  },
});

// Test the connection
(async () => {
  try {
    await sequelize.authenticate();
    console.log("Connected to the MySQL database via Sequelize!");
  } catch (error) {
    console.error("Unable to connect to the database:", error.message);
    process.exit(1); // Exit if connection fails
  }
})();

// Export the Sequelize instance for reuse
module.exports = sequelize;
