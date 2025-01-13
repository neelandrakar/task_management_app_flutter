const express = require("express");
const homeRouter = express.Router();
const auth = require('../../middleware/auth');
const { getGreetingBasedOnTime } = require('../../controller/homeController');

homeRouter.post('/v1/home/get-dashboard', auth, async (req, res)=>{
    try{

        let user_id = req.user; 

        const currentTime = new Date();
        let greetingText = "NA";

        greetingText = getGreetingBasedOnTime(currentTime);

        res.status(200).json({
            success: true,
            msg: greetingText
        })

    }catch (e) {
        res.status(500).json({ 
          success: false,
          msg: e.message
         })
    }
});



module.exports = homeRouter;