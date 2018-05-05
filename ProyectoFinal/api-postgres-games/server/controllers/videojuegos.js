const Videojuegos = require('../models').Videojuegos;
const Sequelize = require('sequelize');
const Op = Sequelize.Op

var fs = require('fs');
var path = require('path');
var bcrypt = require('bcrypt-nodejs');
var jwt = require('../services/jwt');
//var fileUpload = require('express-fileupload');

function pruebas(req, res){
	res.status(200).send({
		message: 'Probando una accion del controlador de usuarios del api rest con Node y Postgres'
	});
}

function saveGame(req, res){
	var params = req.body;		

			//Aqui ya podemos registrar al videojuego			
			return Videojuegos
		      .create({
		        nombre: params.nombre.toLowerCase(),
		        descripcion: params.descripcion,
		        stock: params.stock,
		        precio: params.precio,
		        imagen: 'null',				
		      })
		      .then(gameCreated => res.status(200).send(gameCreated))
		      .catch(error => res.status(404).send(error));		
}

function allGames(req, res){

	return Videojuegos
		.findAll({		  			
			where: { 
				stock: {[Op.gt]: 0}, // > 0
			}
		})
		.then(games => res.status(200).send(games))
		.catch(error => res.status(400).send(error));
}

function uploadImage(req, res){
	var gameId = req.params.id;
	var file_name = 'No subido...';

	if(req.files){
		var file_path = req.files.image.path;
		var file_split = file_path.split('/');
		var file_name = file_split[3];

		var ext_split = file_name.split('\.');
		var file_ext = ext_split[1];

		console.log("imagen "+file_path);

		if(file_ext == 'png' || file_ext == 'jpg' || file_ext == 'gif')
		{		
			var oldpath = req.files.image.path;
		      var newpath = './server/uploads/users/' + file_name;
		      fs.rename(oldpath, newpath, function (err) {
		        if (err){
		        	res.status(404).send({message: 'Error subiendo file'});
		        }
		        else{
		        	return Videojuegos
					    .findById(gameId)
					    .then(game => {
					      if (!game) {
					        return res.status(404).send({message: 'El videojuego no existe',});
					      }
					      else{
						      return game
						        .update({
						          imagen: file_name || game.imagen,
						        })
						        .then(() => {
						        	res.status(200).send(game)			        	
						        	  
						        })  // Send back the updated user
						        .catch((error) => res.status(400).send({message: 'Error en Update'}));
						  }
					    })
					    .catch((error) => res.status(400).send(error));			        	
		        }
		      });	
					
		}
		else
		{
			res.status(404).send({message: 'Extensión del archivo no válida'});
		}
	}
	else
	{
		res.status(200).send({message: 'No has subido ninguna imagen...'});
	}
}

function getImageFile(req, res){
	var imageFile = req.params.imageFile;
	var path_file = './server/uploads/users/'+imageFile;
	fs.exists(path_file, function(exists){
		if(exists){
			res.sendFile(path.resolve(path_file));
		}else{
			res.status(404).send({message: 'No existe la imagen'});
		}
	});
}

function updateGame(req, res){
	var gameId = req.params.id;
	var update = req.body;
	var params = req.body;
	var pass;

	if(params.nombre){				
		Videojuegos.findById(gameId)
		.then(game => {
			if(!game){				
				res.status(404).send({message: 'El videojuego no existe'});
			}else{
				
			      return game
			        .update({					          				          	
				        nombre: params.nombre.toLowerCase() || game.nombre, 
				        descripcion: params.descripcion || game.descripcion,
				        stock: params.stock || game.stock,
				        precio: params.precio || game.precio,				        
			        })
			        .then(() => {
			        	res.status(200).send(game)			        	  
			        })  // Send back the updated user
			        .catch((error) => res.status(400).send({message: 'Error en Update'}));						  
				
			}
		})
		.catch(error => res.status(500).send({message: 'Error al actualizar el videojuego'}));
	}else{
		res.status(404).send({message: 'INtroduce un nombre para actualizar'});
	}
}

function deleteGame(req, res){
	var gameId = req.params.idGame;

	return Videojuegos
    .findById(gameId)
    .then(game => {
      if (!game) {        
		return res.status(404).send({message: 'El videojuego no existe'});
      }else{
	      return game
	        .destroy()
	        .then(() => res.status(200).send({message: 'Videojuego eliminado'}))
	        .catch(error => res.status(400).send(error));
	  }
    })
    .catch(error => res.status(400).send(error));
}

function getGame(req, res){
	var gameId = req.params.idGame;

	return Videojuegos
	    .findById(gameId)
	    .then(game => res.status(200).send({data: game}))
	    .catch((error) => res.status(400).send(error));
}


module.exports = {
  pruebas,
  saveGame,
  allGames,
  uploadImage,
  getImageFile,
  updateGame,
  getGame,
  deleteGame,
};