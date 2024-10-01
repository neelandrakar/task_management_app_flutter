const mongoose = require('mongoose');

const userSchema = mongoose.Schema({

    username: {
        type: String,
        required: true,
    },

    mobno: {
        type: Number,
        default: 0
    },

    email: {
        type: String,
        default: ""
    },

    name: {
        type: String,
        required: true
    },

    active: {
        type: Boolean,
        default: true
    },

    creation_date: {
        type: Date,
        default: Date.now
    },

    jwt_token: {
        type: String,
        default: ''
    },

    profile_pic: {

        type: String,
        default: ''
    }
});