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
const homeRouter = require("./routes/v1/home");
var server = http.createServer(app);
const io = initSocket(server);
const ipAddress = '0.0.0.0'


// Pass the io instance to the authRouter
app.use((req, res, next) => {
    req.io = io; // Attach the io instance to the request object
    next();
});


//middleware
app.use(express.json());
app.use(authRouter);
app.use(voteRouter);
app.use(profileRouter);
app.use(homeRouter);

mongoose.connect(DB_URL)
.then(()=>{
    console.log('Connected Successfully');
})
.catch((e)=>{
    console.log(`Error while connecting. Error: ${e}`);
});

server.listen(PORT,'0.0.0.0',function(){
    console.log(`Connected at ${PORT}`);
});

// Import MySQL Connection (for immediate usage if needed)
require("./mysqlConnection");
require("./config/database");