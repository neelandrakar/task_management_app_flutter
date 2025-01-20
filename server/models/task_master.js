const { Sequelize, DataTypes, INTEGER } = require('sequelize');
const sequelize = require('../config/database'); // Sequelize instance
const TaskType = require('./task_type_master');

const TaskMaster = sequelize.define('TaskMaster',{
    task_id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    task_type_id: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    streak: {
        type: DataTypes.INTEGER,
        allowNull: true
    },
    total_done: {
        type: DataTypes.INTEGER,
        allowNull: true
    },
    user_id: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    title: {
        type: DataTypes.STRING,
        allowNull: true
    },
    description: {
        type: DataTypes.STRING,
        allowNull: true,
        defaultValue: ""
    },
    status: {
        type: DataTypes.ENUM('0', '1', '2', '3', '4'),
        allowNull: true,
        defaultValue: '0'
    },
    priority: {
        type: DataTypes.ENUM('1','2','3'),
        allowNull: false,
        defaultValue: '2'
    },
    color: {
        type: DataTypes.STRING,
        allowNull: false
    },
    start_date: {
        type: DataTypes.DATE,
        allowNull: false
    },
    end_date: {
        type: DataTypes.DATE,
        allowNull: false
    },
    weekly_count: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    target: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    reminder_times: {
        type: DataTypes.JSON,
        allowNull: true
    },
    created_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    },
    updated_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    },
    d_status: {
        type: INTEGER,
        defaultValue: 0
    }
}, {
    tableName: 'task_master',
    timestamps: false
});

module.exports = TaskMaster;