const express = require("express");
const homeRouter = express.Router();
const auth = require('../../middleware/auth');
const { getGreetingBasedOnTime, getCurrentWeekDays, getWeekStartAndEndDates, countConsecutive } = require('../../controller/homeController');
const con = require("../../mysqlConnection"); // Import MySQL connection
const TaskType = require('../../models/task_type_master'); // Import TaskType model
const TaskMaster = require("../../models/task_master");
const { fetchUserTasks } = require('../../controller/fetchUserTasksController');
const { getDateDifference } = require('../../controller/dateController');
// const sequelize = require('../../config/database'); // Sequelize instance


homeRouter.post('/v1/home/get-dashboard', auth, async (req, res)=>{
    try{

        const { date } = req.body;
        let user_id = req.user; 
        let homeRes = [];
        let dayTask = [];
        let dayChallange = [];
        let myHabits = [];
        const currentTime = new Date();
        let greetingText = "NA";
        let weekRange = "NA";

        greetingText = getGreetingBasedOnTime(currentTime);
        weekRange = getCurrentWeekDays();

        startAndEndDates = getWeekStartAndEndDates(date);
        const start_date = startAndEndDates.mondayDate;
        const end_date = startAndEndDates.saturdayDate;
        dayTask = await fetchUserTasks(user_id, start_date, end_date);
        dayTask = dayTask.map(task => task.get({ plain: true }));  //To prevent dayTask from acting like a model

        //console.log(dayTask[0]['TaskDaywiseStreaks'][0]['created_at']);

        for(i=0; i<dayTask.length; i++){
            let streak = 0;
            let streakDates = [];
            let total_done = 0;

            for(j=0; j<dayTask[i]['TaskDaywiseStreaks'].length; j++){

                const streakDate = new Date(dayTask[i]['TaskDaywiseStreaks'][j]['created_at']);
                total_done += dayTask[i]['TaskDaywiseStreaks'][j]['target_reached'];

                const dateDiff = getDateDifference(currentTime,streakDate);
                // console.log(`dateDiff between ${streakDate} and ${currentTime}: ${dateDiff}`);
                if(dateDiff<=0){
                    streakDates.push(dateDiff);
                }
            }
            console.log(streakDates);
            streak = countConsecutive(streakDates);
            dayTask[i].streak = streak;
            dayTask[i].total_done = total_done;

            dayTask[i] = {
                task_id: dayTask[i].task_id,
                task_type_name: dayTask[i].task_type_name,
                task_unit: dayTask[i].task_unit,
                streak: dayTask[i].streak,
                total_done: dayTask[i].total_done,
                target: dayTask[i].target,
                color: dayTask[i].color,
                task_icon: dayTask[i].task_icon
            };
        }
        
    
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
        
          const currentDate = new Date();

        weekRange = getWeekStartAndEndDates(currentDate);

        let taskRes = {
            "week_range": weekRange,
            "task_types": taskTypes
        }      
  
        res.status(200).json({
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

            const { task_type_id, title, description, priority, color,start_date, end_date,weekly_count,target, reminder_times } = req.body;
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
                target: target,
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