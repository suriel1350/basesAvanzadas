'use strict'

var express = require('express');
var bodyParser = require('body-parser');
var validator = require('express-validator');

var app = express();

// cragar rutas 
var user_routes = require('./routes/user');
var cart_routes = require('./routes/cart');
/*var album_routes = require('./routes/album');
var song_routes = require('./routes/song'); */

app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json());
app.use(validator());


//configurar cabeceras http 
app.use((req, res, next) => {
	res.header('Access-Control-Allow-Origin', '*');
	res.header('Access-Control-Allow-Headers', 'Authorization, X-API-KEY, Origin, X-Requested-With, Content-Type, Access-Control-Allow-Request-Method');
	res.header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, DELETE');
	res.header('Allow', 'GET, POST, OPTIONS, PUT, DELETE');

	next();
});

//rustas base
app.use('/api', user_routes);
app.use('/api', cart_routes);
/*app.use('/api', album_routes);
app.use('/api', song_routes);*/
	//middleware
	
/*app.get('/pruebas', function(req, res){
	res.status(200).send({message: 'Bienvenido al curso de Aplicaciones Web'});
})*/

module.exports = app;