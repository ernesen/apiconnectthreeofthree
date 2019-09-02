const mongoose = require('mongoose');

const Transaction = new mongoose.Schema({
    uuid: {type:String, trim:true, default:''},
    amount: {type:Number, default:0},
    currency: {type:String, trim:true, default:''},
    description: {type:String, trim:true, default:''},
    date: {type:String, trim:true, default:''},
    category: {type:String, trim:true, default:''}
});

module.exports = mongoose.model('Transaction', Transaction);
