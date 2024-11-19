const express = require("express");
const User = require("../../models/user");
const authRouter = express.Router();
const con = require("../../mysqlConnection"); // Import MySQL connection
const bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken');
const {identifyInputType, fetchUsername} = require('../../controller/auth_controller');

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
          //console.log(jwt_token);

          const updatedEmp = {
            user_id: user_id,
            username: username,
            name: name,
            mobno: mobno,
            jwt_token: jwt_token,
            hashedPassword: hashedPassword,
            creation_date: creation_date
          }

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

          //Searching for log history
          const get_login_history = `SELECT * FROM login_history_tbl WHERE user_id = ${user_id} and is_logged_in=1`;
          con.query(get_login_history, async (log_error, log_res) => {
            

            if (log_error) {
              return res.status(500).json({ 
                success: false,
                msg: err_one.message
               });
            }

            if(log_res.length>0){

              const delete_log_history = `UPDATE login_history_tbl SET is_logged_in = 0 WHERE user_id = ${user_id}`;
              con.query(delete_log_history, async (del_log_err, del_log_res) => {
    
                if (del_log_err) {
                  return res.status(500).json({ 
                    success: false,
                    msg: err_one.message
                   });
                }
              });
            }
              const insert_log_data = `INSERT INTO login_history_tbl (user_id, brand, model, device_id, os_type, os_version, is_logged_in)
               VALUES ("${user_id}", "${brand}", "${model}", "${device_id}", "${os_type}", "${os_version}", '1');`;
              con.query(insert_log_data, async (ins_log_err, ins_log_res) => {
    
                if (ins_log_err) {
                  return res.status(500).json({ 
                    success: false,
                    msg: err_one.message
                  });
                }
              });
            
          });

          

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
authRouter.post('/v1/auth/checkToken', async (req,res)=>{

  try{
      
      const token = req.header('x-auth-token');

      res.json(true);

  }catch(e){
      res.status(500).json({ error: e.message });
  }

});

module.exports = authRouter;
