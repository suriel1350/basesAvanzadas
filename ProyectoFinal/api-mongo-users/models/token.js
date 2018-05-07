'use strict'

var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var TokenSchema = Schema({
	token: String,		
	userId: { type: Schema.ObjectId, ref: 'User' }
});

module.exports = mongoose.model('Token', TokenSchema);