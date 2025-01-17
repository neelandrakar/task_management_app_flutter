const { TaskMaster, TaskType } = require('../config/associations'); // Import the models and associations
const sequelize = require('../config/database');

const fetchUserTasks = async (user_id, start_date, end_date) => {

    console.log(`start_date: ${start_date} && end_date: ${end_date}`);
    try {
        
        const allTasks = await TaskMaster.findAll({
            where: {
                user_id: user_id,
                d_status: 0,
                start_date: start_date,
                end_date: end_date
            },
            attributes: [
                'task_id',
                'task_type_id',
                'user_id',
                'title',
                'description',
                'status',
                'priority',
                'color',
                'start_date',
                'end_date',
                'weekly_count',
                'target',
                'reminder_times',
                'created_at',
                'updated_at',
                'd_status',
                [sequelize.col('TaskType.task_type_name'), 'task_type_name'],
                [sequelize.col('TaskType.description'), 'task_type_description'],
                [sequelize.col('TaskType.unit'), 'task_unit']
            ],
            include: {
                model: TaskType,
                attributes: [] // Prevents TaskType from being included as a nested object
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
