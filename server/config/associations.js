const TaskMaster = require('../models/task_master');
const TaskType = require('../models/task_type_master');

// Define associations after both models are loaded
TaskMaster.belongsTo(TaskType, { foreignKey: 'task_type_id' });
TaskType.hasMany(TaskMaster, { foreignKey: 'task_type_id' });

module.exports = { TaskMaster, TaskType };
