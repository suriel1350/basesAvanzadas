'use strict'

var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var CartSchema = Schema({
	nombre: String,
	categoria: String,
	descripcion: String,
	cantidad: Number,
	id: Number,
	precio: String,
	imagen: String,
	userId: { type: Schema.ObjectId, ref: 'User' }
});

module.exports = mongoose.model('Cart', CartSchema);