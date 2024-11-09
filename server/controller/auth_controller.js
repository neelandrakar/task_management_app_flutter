const con = require("../mysqlConnection"); // Import MySQL connection


// Function to determine the type of input
const identifyInputType = (input) => {

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const phoneRegex = /^\d{10}$/; // Adjust this regex based on your phone number format
  
    if (emailRegex.test(input)) {
      return 'email';
    } else if (phoneRegex.test(input)) {
      return 'mobno';
    } else {
      return 'username'; // Default to username if it doesn't match email or mobno
    }
  };

//Fetching username  
const fetchUsername = async (user_id) => {
  
  const sql_one = `SELECT username FROM user_tbl WHERE user_id = "${user_id}" AND d_status = 0;`;

  // Return a new promise
  return new Promise((resolve, reject) => {
    con.query(sql_one, (err_one, results_one) => {
      if (err_one) {
        return reject(new Error(err_one.message)); // Reject the promise on error
      }
      
      // If results are empty, resolve with null or undefined
      if (results_one.length === 0) {
        return resolve(null);
      }

      // Resolve the promise with the username
      resolve(results_one[0].username);
    });
  });
};  
  
module.exports = { 
  identifyInputType,
  fetchUsername
  };