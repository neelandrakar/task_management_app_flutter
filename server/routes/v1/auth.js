const express = require("express");
const User = require("../../models/user");
const authRouter = express.Router();
const con = require("../../mysqlConnection"); // Import MySQL connection

// Get Users Route
authRouter.post("/v1/api/sign-up", (req, res) => {
  try {
    
    const { email, mobno, username, password } = req.body;

    const sql = `SELECT * FROM user_tbl where email_id = "${email}" OR mobno = "${mobno}" OR username = "${username}"`;
    console.log(sql)

    con.query(sql, (err, results) => {
      if (err) {
        return res.status(500).json({ 
          success: false,
          msg: err.message
         });
      }

      if(results.length>0){

        let duplicate_with = "NA";
        duplicate_with = mobno==0 ? "email address" : "mobile number";
        return res.status(409).json({
          success: false,
          msg: `An account with the same ${duplicate_with} already exists..`
        })
      }



    

      res.status(200).json({
        success: true,
        msg: "Ready to be created",
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
