const express = require("express");
const profileRouter = express.Router();
const auth = require('../../middleware/auth');

//edit profile
profileRouter.post('/v1/profile/edit-profile', auth, async (req, res)=>{

    res.json("HELLO");
});



module.exports = profileRouter;