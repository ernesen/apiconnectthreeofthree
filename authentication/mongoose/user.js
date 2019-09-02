const mongoose = require('mongoose');

const User = new mongoose.Schema({
    uuid: {type:String, trim:true, default:''},
    name: {type:String, trim:true, default:''},
    email: {type:String, trim:true, default:''},
    phone: {type:String, trim:true, default:''},
    gender: {type:String, trim:true, default:''},
    dob: {type:String, trim:true, default:''},
    kid: {type:String, trim:true, default:''},
    password: {type:String, trim:true, default:''}
});

module.exports = mongoose.model('User', User);
