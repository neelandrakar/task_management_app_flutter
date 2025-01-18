const { Sequelize, DataTypes } = require('sequelize');
const sequelize = require('../config/database'); // Sequelize instance
const TaskMaster = require('./task_master');

const TaskDaywiseStreak = sequelize.define('TaskDaywiseStreak', {
    streak_id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    task_id: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    remarks: {
        type: DataTypes.STRING,
        allowNull: false
    },
    target_reached: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    created_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    },
    d_status: {
        type: DataTypes.TINYINT,
        defaultValue: 0
    }
}, {
    tableName: 'task_daywise_streak',
    timestamps: false
});

module.exports = TaskDaywiseStreak;
