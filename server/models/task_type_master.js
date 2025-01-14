const { Sequelize, DataTypes } = require('sequelize');
const sequelize = require('../config/database'); // Sequelize instance

const TaskType = sequelize.define('TaskType', {
    task_type_id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    task_type_name: {
        type: DataTypes.STRING,
        allowNull: false
    },
    description: {
        type: DataTypes.TEXT,
        allowNull: true
    },
    is_active: {
        type: DataTypes.TINYINT,
        defaultValue: 1
    },
    d_status: {
        type: DataTypes.TINYINT,
        defaultValue: 0
    }
}, {
    tableName: 'task_type_master',
    timestamps: false
});

module.exports = TaskType;
