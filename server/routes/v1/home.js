const express = require("express");
const homeRouter = express.Router();
const auth = require('../../middleware/auth');

homeRouter.post('/v1/home/get-dashboard', auth, async (req, res)=>{
    try{

        let user_id = req.user; 

        res.status(200).json({
            success: true,
            msg: `Hello dashboard ${user_id}`
        })

    }catch (e) {
        res.status(500).json({ 
          success: false,
          msg: e.message
         })
    }
});



module.exports = homeRouter;