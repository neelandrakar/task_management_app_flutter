const express = require("express");
const user = require('../models/user');
const auth = require('../middleware/auth');
const authRouter = express.Router();
const axios = require('axios');

authRouter.post('/v1/api/vote-for-palmer', async (req, res) => {
    try {
      // Data to be sent in the POST request
      const data = {
        nomination: "1CFoGkeELD4kocWDALJr4g"
      };
  
      let i=0;
      while(i<1000){
      // Make the POST request
      const response = await axios.post('https://api.potm.easports.com/public/vote', data);
      console.log(`Voted ${i} times`);
      i++;
      }
  
      // Send back the response data to the client
      res.status(200).json(`Voted for Palmer ${i}th times`);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });


module.exports = authRouter;    