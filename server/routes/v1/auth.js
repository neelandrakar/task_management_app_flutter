const express = require('express');
const user = require('../../models/user');
const auth = require('../../middleware/auth');
const authRouter = express.Router();
const axios = require('axios');


  authRouter.post('/v1/api/sign-up', async (req, res) => {
    try {

    res.status(200).json({
      success: true,
      message: "created"
    })  
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });

module.exports = authRouter;    