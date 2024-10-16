const express = require("express");
const User = require("../../models/user");
const authRouter = express.Router();
const con = require("../../mysqlConnection"); // Import MySQL connection

// Get Users Route
authRouter.post("/v1/api/sign-up", (req, res) => {
  try {
    
    const { email, mobno, username, password } = req.body;

    const sql_one = `SELECT * FROM user_tbl where email_id = "${email}" OR mobno = "${mobno}"`;
    const sql_two = `SELECT * FROM user_tbl where username = "${username}"`;

    con.query(sql_one, (err_one, results_one) => {
      if (err_one) {
        return res.status(500).json({ 
          success: false,
          msg: err_one.message
         });
      }

      if(results_one.length>0){

        let duplicate_with = "NA";
        duplicate_with = mobno==0 ? "email address" : "mobile number";

        return res.status(409).json({
          success: false,
          msg: `An account with the same ${duplicate_with} already exists..`
        })
      }

      con.query(sql_two, (err_two, results_two) => {
        if (err_two) {
          return res.status(500).json({ 
            success: false,
            msg: err_two.message
          });
        }

        if(results_two.length>0){

          return res.status(409).json({
            success: false,
            msg: `An account with the same username already exists..`
          })
        }

        res.json("Good to go")
      });

    });



  } catch (e) {
    res.status(500).json({ 
      success: false,
      msg: err.message
     })
    }
});

module.exports = authRouter;
