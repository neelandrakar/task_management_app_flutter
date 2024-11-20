const con = require('../mysqlConnection'); // Import your database connection

const updateLoginHistory = async (user_id, deviceInfo) => {
  const { brand, model, device_id, os_type, os_version } = deviceInfo;

  return new Promise((resolve, reject) => {
    const get_login_history = `SELECT * FROM login_history_tbl WHERE user_id = ${user_id} AND is_logged_in = 1`;

    con.query(get_login_history, (log_error, log_res) => {
      if (log_error) {
        return reject(new Error(log_error.message));
      }

      if (log_res.length > 0) {
        const get_device_id = log_res[0]['device_id'];

        if (get_device_id !== device_id) {
          console.log(`Other device found, call socket`);
        } else {
          console.log(`Same device found`);
        }

        const delete_log_history = `UPDATE login_history_tbl SET is_logged_in = 0 WHERE user_id = ${user_id}`;
        con.query(delete_log_history, (del_log_err) => {
          if (del_log_err) {
            return reject(new Error(del_log_err.message));
          }
        });
      }

      const insert_log_data = `
        INSERT INTO login_history_tbl (user_id, brand, model, device_id, os_type, os_version, is_logged_in)
        VALUES ("${user_id}", "${brand}", "${model}", "${device_id}", "${os_type}", "${os_version}", '1');
      `;
      con.query(insert_log_data, (ins_log_err) => {
        if (ins_log_err) {
          return reject(new Error(ins_log_err.message));
        }
        resolve();
      });
    });
  });
};

module.exports = { updateLoginHistory };
