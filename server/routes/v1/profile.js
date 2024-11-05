const express = require("express");
const profileRouter = express.Router();

//edit profile
profileRouter.post('/v1/profile/edit-profile', async (req, res)=>{

    res.json("HELLO");
});



module.exports = profileRouter;