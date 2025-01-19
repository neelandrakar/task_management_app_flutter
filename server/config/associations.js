const TaskMaster = require('../models/task_master');
const TaskType = require('../models/task_type_master');
const TaskDaywiseStreak = require('../models/task_daywise_streak');

// Define associations after both models are loaded
TaskMaster.belongsTo(TaskType, { foreignKey: 'task_type_id' });
TaskType.hasMany(TaskMaster, { foreignKey: 'task_type_id' });

TaskDaywiseStreak.belongsTo(TaskMaster, {
    foreignKey: 'task_id'
});
TaskMaster.hasMany(TaskDaywiseStreak, {
    foreignKey: 'task_id'
});



module.exports = { TaskMaster, TaskType, TaskDaywiseStreak };
