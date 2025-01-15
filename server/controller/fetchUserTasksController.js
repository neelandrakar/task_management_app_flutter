const { TaskMaster, TaskType } = require('../config/associations'); // Import the models and associations

const fetchUserTasks = async (user_id, start_date, end_date) => {
    try {
        // Fetch all tasks related to the user, including the task type information
        const allTasks = await TaskMaster.findAll({
            where: {
                user_id: user_id,
                d_status: 0,
                start_date: start_date,
                end_date: end_date
            },
            include: {
                model: TaskType,
                attributes: ['task_type_name'], // Fetch only the task_type_name from TaskType
            }
        });

        // You can now access task_type_name within each task in the result
        return allTasks;
    } catch (error) {
        console.error("Error fetching user tasks:", error);
        throw error;
    }
}

module.exports = { fetchUserTasks };
