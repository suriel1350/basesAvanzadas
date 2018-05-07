'use strict'

var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var UserSchema = Schema({
	nombre: String,
	email: String, 
	password: String, 
	role: String,
	isVerified: { type: Boolean, default: false },
	image: String
});

module.exports = mongoose.model('User', UserSchema);