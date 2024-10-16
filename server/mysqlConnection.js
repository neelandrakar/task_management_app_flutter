// mysqlConnection.js
const mysql = require("mysql");

// MySQL Connection Setup
const con = mysql.createConnection({
  host: "0.0.0.0",
  user: "root",
  password: "Neelandra@10",
  database: "task_management_schema",
});

// Connect to the MySQL database
con.connect((err) => {
  if (err) {
    console.error(`MySQL Connection Error: ${err.message}`);
    process.exit(1); // Exit if connection fails
  } else {
    console.log("Connected to MySQL database");
  }
});

// Export the connection for reuse
module.exports = con;
