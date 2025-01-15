const express = require("express");
const homeRouter = express.Router();
const auth = require('../../middleware/auth');
const { getGreetingBasedOnTime, getCurrentWeekDays, getWeekStartAndEndDates } = require('../../controller/homeController');
const con = require("../../mysqlConnection"); // Import MySQL connection
const TaskType = require('../../models/task_type_master'); // Import TaskType model
const TaskMaster = require("../../models/task_master");

homeRouter.post('/v1/home/get-dashboard', auth, async (req, res)=>{
    try{

        let user_id = req.user; 
        homeRes = [];
        dayTask = [];
        dayChallange = [];
        myHabits = [];
        const currentTime = new Date();
        let greetingText = "NA";
        let weekRange = "NA";

        greetingText = getGreetingBasedOnTime(currentTime);
        weekRange = getCurrentWeekDays();

        homeRes = {
            "greeting_text": greetingText,
            "week_range": weekRange,
            "day_task": dayTask,
            // "day_challange": dayChallange,
            "my_habits": myHabits
        }

        res.status(200).json({
            success: true,
            msg: homeRes
        })

    }catch (e) {
        res.status(500).json({ 
          success: false,
          msg: e.message
         })
    }
});

homeRouter.post('/v1/home/fetch-tasks', auth, async (req, res)=>{
    try{

        const taskTypes = await TaskType.findAll({
            where: {
              is_active: 1,
              d_status: 0
            },
            attributes: ['task_type_id', 'task_type_name','unit'] // Only fetch task_type_name
          });

        weekRange = getWeekStartAndEndDates();

        let taskRes = {
            "week_range": weekRange,
            "task_types": taskTypes
        }
  
      
  
        res.status(201).json({
            success: true,
            msg: "Tasks are fetched!",
            result: taskRes
        });
        

    }catch (e) {
        res.status(500).json({ 
          success: false,
          msg: e.message
         })
    }
});

homeRouter.post('/v1/home/create-task', auth, async (req, res)=>{
    try{

            const { task_type_id, title, description, priority, color,start_date, end_date,weekly_count, reminder_times } = req.body;
            const user_id = req.user;

            let newTask = new TaskMaster({
                task_type_id: task_type_id,
                user_id: user_id,
                title: title,
                description: description,
                priority: priority,
                color: color,
                start_date: start_date,
                end_date: end_date,
                weekly_count: weekly_count,
                reminder_times: reminder_times

            });
            
            newTask = await newTask.save();
      
  
            res.status(201).json({
              success: true,
              result: newTask,
              msg: "A new task has been successfully created!"
            });
        

    }catch (e) {
        res.status(500).json({ 
          success: false,
          msg: e.message
         })
    }
});



module.exports = homeRouter;