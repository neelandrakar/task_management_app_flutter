const express = require('express');
const voteRouter = express.Router();
const axios = require('axios');

voteRouter.post('/v1/api/vote-for-palmer', async (req, res) => {
    try {
      // Data to be sent in the POST request
      const data = {
        nomination: "1CGiLgTLnmhrGdK3bPEdnZ"
      };
  
      let i=0;
      while(i<100000){
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

  voteRouter.post('/v1/api/redeem-product', async (req, res) => {
    try {

      console.log("Redeeming");
      // Data to be sent in the POST request
      const data = {
        gift_type: 2,
        sku: "UBEFLOW",
        item_points: 1000,
        quantity: 2
      };
  
      let i = 0;
      while (i < 10) {
        // Make the POST request
        const response = await axios.post(
          'https://devcrm.shyamsteel.in/api/loyalty/partner/redeemproduct',
          data,
          {
            headers: {
              'Content-type': 'application/x-www-form-urlencoded',
              'Authorization': 'JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkZWFsZXJfaWQiOjIyNDE5NjgsImVtcF9pZCI6MCwiYXBwbGljYXRpb25JZCI6MTMsImlhdCI6MTczMDI4MDc4NSwiZXhwIjoxNzMwMjgxMzg1fQ.WZ40Om6Tw6gtFfXgCn-EEwcqxU_7JcnSDMPSaA5BCVA'
            }
          }
        );
        console.log(`Redeemed ${i + 1} times`);
        i++;
      }
  
      // Send back the response data to the client
      res.status(200).json(`Redeemed product ${i} times`);
    } catch (e) {
      console.error(e);
      res.status(500).json({ error: e.message });
    }
  });

module.exports = voteRouter;    