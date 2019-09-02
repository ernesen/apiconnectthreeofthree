// MongoDB Full Tutorial w/ Node.js, Express, & Mongoose
// https://www.youtube.com/watch?v=4yqu8YF29cU
// mongoimport --db 'db_name' --collection 'collection_name' --file 'file-name.json'
const mongoose = require('mongoose');

const Account = new mongoose.Schema({
    uuid: {type:String, trim:true, default:''},
    type: {type:String, trim:true, default:''},
    currency: {type:String, trim:true, default:''},
    balance: {type:Number, default:0},
    number: {type:Number, default:0}
});

module.exports = mongoose.model('Account', Account);
