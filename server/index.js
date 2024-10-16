console.log("Initiating Server...");

const mongoose = require("mongoose");
const express = require("express");
const global_variables = require("./global_variables");
const mysql = require('mysql');

const DB_URL = global_variables.MONGODB_URL;
const PORT = 3000;
const app = express();
const authRouter = require('./routes/v1/auth');
const voteRouter = require('./routes/v1/votes');

//middleware
app.use(express.json());
app.use(authRouter);
app.use(voteRouter);

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