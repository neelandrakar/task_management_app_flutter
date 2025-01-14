const express = require("express");
const homeRouter = express.Router();
const auth = require('../../middleware/auth');
const { getGreetingBasedOnTime, getCurrentWeekDays } = require('../../controller/homeController');
const con = require("../../mysqlConnection"); // Import MySQL connection
const TaskType = require('../../models/task_type_master'); // Import TaskType model

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
            "day_challange": dayChallange,
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

homeRouter.post('/v1/home/create-task', auth, async (req, res)=>{
    try{

        let user_id = req.user;
        const taskTypes = await TaskType.findAll({
            where: {
              is_active: 1,
              d_status: 0
            },
            attributes: ['task_type_name'] // Only fetch task_type_name
          });
      
        const taskTypeNames = taskTypes.map(task => task.task_type_name);
  
            res.status(201).json({
              success: true,
              msg: taskTypeNames
            });
        

    }catch (e) {
        res.status(500).json({ 
          success: false,
          msg: e.message
         })
    }
});



module.exports = homeRouter;