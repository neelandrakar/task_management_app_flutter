const express = require("express");
const homeRouter = express.Router();
const auth = require('../../middleware/auth');
const { getGreetingBasedOnTime, getCurrentWeekDays } = require('../../controller/homeController');

homeRouter.post('/v1/home/get-dashboard', auth, async (req, res)=>{
    try{

        let user_id = req.user; 

        const currentTime = new Date();
        let greetingText = "NA";
        let weekRange = "NA";

        greetingText = getGreetingBasedOnTime(currentTime);
        home_res = [];
        weekRange = getCurrentWeekDays();

        home_res = {
            "greeting_text": greetingText,
            "week_range": weekRange
        }

        res.status(200).json({
            success: true,
            msg: home_res
        })

    }catch (e) {
        res.status(500).json({ 
          success: false,
          msg: e.message
         })
    }
});



module.exports = homeRouter;