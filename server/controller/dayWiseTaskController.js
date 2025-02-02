const { Op } = require("sequelize");
const { TaskDaywiseStreak } = require("../config/associations");
 
const dayWiseTask = async (task_id, date) => {
  try {
    // Convert the date input to start and end of the day
    const startOfDay = new Date(date);
    startOfDay.setHours(0, 0, 0, 0); // Set to beginning of the day
 
    const endOfDay = new Date(date);
    endOfDay.setHours(23, 59, 59, 999); // Set to end of the day
 
    const hasDoneTask = await TaskDaywiseStreak.findAll({
      where: {
        d_status: 0,
        created_at: {
          [Op.between]: [startOfDay, endOfDay], // Matches records within the day
        },
        task_id: task_id,
      },
    });
 
    return hasDoneTask;
  } catch (error) {
    console.error("Error fetching user tasks:", error);
    throw error;
  }
};
 
module.exports = { dayWiseTask };