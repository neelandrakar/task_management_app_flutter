const express = require("express");
const User = require("../../models/user");
const authRouter = express.Router();
const con = require("../../mysqlConnection"); // Import MySQL connection
const bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken');
const {identifyInputType, fetchUsername} = require('../../controller/auth_controller');
const { updateLoginHistory } = require('../../controller/loginHistoryController');
const auth = require('../../middleware/auth');

// SIGN UP
authRouter.post("/v1/auth/sign-up", async (req, res) => {
  try {
    
    const { email, mobno, username, password } = req.body;
    let mob_email_key = "";

    mob_email_key = mobno==0 ? `email_id = "${email}"` : `mobno = "${mobno}"`;

    const sql_one = `SELECT * FROM user_tbl where ${mob_email_key} and d_status = 0;`;
    const sql_two = `SELECT * FROM user_tbl where username = "${username}" and d_status = 0;`;
    let hashedPassword = "NA";

    con.query(sql_one, (err_one, results_one) => {
      console.log(sql_one)
      if (err_one) {
        return res.status(500).json({ 
          success: false,
          msg: err_one.message
         });
      }

      if(results_one.length>0){
        //console.log(results_one);

        let duplicate_with = "NA";
        duplicate_with = mobno==0 ? "email address" : "mobile number";

        return res.status(409).json({
          success: false,
          msg: `An account with the same ${duplicate_with} already exists..`
        })
      }

      con.query(sql_two, async (err_two, results_two) => {
        if (err_two) {
          return res.status(500).json({ 
            success: false,
            msg: err_two.message
          });
        }

        if(results_two.length>0){

          return res.status(409).json({
            success: false,
            msg: `An account with the same username already exists...`
          })
        }

        hashedPassword = await bcryptjs.hash(password,8);
        console.log(hashedPassword)

        const insert_sql = `INSERT INTO user_tbl (username, mobno, email_id, password) VALUES ("${username}", "${mobno}", "${email}", "${hashedPassword}");`
        console.log(insert_sql);

        con.query(insert_sql, function (err_three, result) {  
          
          if (err_three) {
            return res.status(500).json({ 
              success: false,
              msg: err_two.message
            });           
          }

          res.status(201).json({
            success: true,
            msg: "User has been created successfully..."
          });
      });
      });

    });
  } catch (e) {
    res.status(500).json({ 
      success: false,
      msg: err.message
     })
    }
});

//SIGN IN
authRouter.post("/v1/auth/sign-in", async (req, res) => {
  try {
    
    const {input,password, brand, model, device_id,os_type, os_version} = req.body;
    let search_key = `username`;
    const inputType = identifyInputType(input);
    //console.log(`inputtype: ${inputType}`)
    const getUsername = await fetchUsername(7);
    //console.log(`getUsername: ${getUsername}`);

    if(inputType=='email'){
      search_key = `email_id`
    } else if(inputType=='mobno'){
      search_key = `mobno`
    }

    const sql_one = `SELECT * FROM user_tbl where ${search_key} = "${input}" and d_status = 0;`;

    con.query(sql_one, async (err_one, results_one) => {
      console.log(sql_one)
      if (err_one) {
        return res.status(500).json({ 
          success: false,
          msg: err_one.message
         });
      }

      // Check if results are not empty and print the email address
      if (results_one.length > 0) {
        const hashedPassword = results_one[0].password;
        const user_id = results_one[0].user_id ?? 'NA';
        const name = results_one[0].name ?? 'NA';
        const mobno = parseInt(results_one[0].mobno) ?? 0;
        const username = results_one[0].username;
        const creation_date = results_one[0].creation_date;
        const isMatch = await bcryptjs.compare(password, hashedPassword);
        //console.log(`Password status: ${isMatch}`);

        if(isMatch){

          const jwt_token = jwt.sign({id: user_id},"PasswordKey");

          const update_token_sql = `UPDATE user_tbl SET jwt_token = "${jwt_token}" WHERE (user_id = "${user_id}");`;
          //UPDATE JWT TOKEN
          con.query(update_token_sql, async (err_two, results_one) => {
            //console.log(update_token_sql)

            if (err_two) {
              return res.status(500).json({ 
                success: false,
                msg: err_one.message
               });
            }
          });

          try {
            await updateLoginHistory(req.io, user_id, { brand, model, device_id, os_type, os_version });
          } catch (logError) {
            return res.status(500).json({
              success: false,
              msg: logError.message
            });
          }

          const updatedEmp = {
            user_id: user_id,
            username: username,
            name: name,
            mobno: mobno,
            jwt_token: jwt_token,
            hashedPassword: hashedPassword,
            creation_date: creation_date
          }  

          return res.status(201).json({
            success: true,
            msg: updatedEmp 
          });

      } else{

          return res.status(401).json({
            success: false,
            msg: 'Please enter the correct password'
          });
      }
      } else {
        return res.status(401).json({
          success: false,
          msg: `Please enter a valid ${inputType}`
        });

      }
    });

  } catch (e) {
    res.status(500).json({ 
      success: false,
      msg: e.message
     })
    }
});

//Check JWT Token
authRouter.post('/v1/auth/checkToken', auth,async (req,res)=>{

  try{
      
      const { device_id } = req.body;
      const user_id = req.user;
      console.log(device_id);
      const check_login_history_sql = `SELECT * FROM task_management_schema.login_history_tbl WHERE user_id = "${user_id}"
                                       AND is_logged_in = 1 AND device_id = "${device_id}";`;
      
      console.log(check_login_history_sql);                                       
                                    

      con.query(check_login_history_sql, async (err_two, results_one) => {

        if (err_two) {
          return res.status(500).json({ 
            success: false,
            msg: err_one.message
           });
        } else {

          if(results_one.length>0){
            return res.status(200).json({
              success: true,
              message: "Proceed to login"
            });
          } else {
            return res.status(401).json({
              success: false,
              message: "Session timeout!"
            })
          }
        }
      });

  }catch(e){
      res.status(500).json({ error: e.message }); 
  }

});

module.exports = authRouter;
