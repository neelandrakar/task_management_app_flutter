console.log("Initiating Server...");

const mongoose = require("mongoose");
const express = require("express");
const global_variables = require("./global_variables");
const DB_URL = global_variables.MONGODB_URL;
const PORT = 3000;
const app = express();
const authRouter = require('./routes/v1/auth');
const voteRouter = require('./routes/v1/votes');
const profileRouter = require('./routes/v1/profile');
const http = require('http');
const { initSocket } = require('./socket/socket_manager');
var server = http.createServer(app);
const io = initSocket(server);


// Pass the io instance to the authRouter
app.use((req, res, next) => {
    req.io = io; // Attach the io instance to the request object
    next();
});


server.listen(PORT, "192.168.195.6", () => {
    console.log("socket server started");
  });


//middleware
app.use(express.json());
app.use(authRouter);
app.use(voteRouter);
app.use(profileRouter)

mongoose.connect(DB_URL)
.then(()=>{
    console.log('Connected Successfully');
})
.catch((e)=>{
    console.log(`Error while connecting. Error: ${e}`);
});


app.listen(PORT,'0.0.0.0',function(){
    console.log(`Connected at ${PORT}`);
});

// Import MySQL Connection (for immediate usage if needed)
require("./mysqlConnection");