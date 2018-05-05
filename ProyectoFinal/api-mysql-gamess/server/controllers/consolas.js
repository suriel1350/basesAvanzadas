const Consolas = require('../models').Consolas;
const Sequelize = require('sequelize');
const Op = Sequelize.Op

var fs = require('fs');
var path = require('path');
var bcrypt = require('bcrypt-nodejs');
var jwt = require('../services/jwt');
//var fileUpload = require('express-fileupload');

function pruebas(req, res){
	res.status(200).send({
		message: 'Probando una accion del controlador de usuarios del api rest con Node y Mysql'
	});
}

function saveConsola(req, res){
	var params = req.body;		

			//Aqui ya podemos registrar una consola
			return Consolas
		      .create({
		        nombre: params.nombre.toLowerCase(),
		        descripcion: params.descripcion,
		        stock: params.stock,
		        precio: params.precio,
		        imagen: 'null',				
		      })
		      .then(consolaCreated => res.status(200).send(consolaCreated))
		      .catch(error => res.status(404).send(error));		
}

function allConsolas(req, res){

	return Consolas
		.findAll({		  			
			where: { 
				stock: {[Op.gt]: 0}, // > 0
			}
		})
		.then(consolas => res.status(200).send(consolas))
		.catch(error => res.status(400).send(error));
}

function uploadImage(req, res){
	var consolaId = req.params.id;
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
		        	return Consolas
					    .findById(consolaId)
					    .then(consola => {
					      if (!consola) {
					        return res.status(404).send({message: 'La consola no existe',});
					      }
					      else{
						      return consola
						        .update({
						          imagen: file_name || consola.imagen,
						        })
						        .then(() => {
						        	res.status(200).send(consola)
						        	  
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
		res.status(404).send({message: 'No has subido ninguna imagen...'});
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

function updateConsola(req, res){
	var consolaId = req.params.id;
	var update = req.body;
	var params = req.body;
	var pass;

	if(params.nombre){				
		Consolas.findById(consolaId)
		.then(consola => {
			if(!consola){				
				res.status(404).send({message: 'La consola no existe'});
			}else{
				
			      return consola
			        .update({					          				          	
				        nombre: params.nombre.toLowerCase() || consola.nombre, 
				        descripcion: params.descripcion || consola.descripcion,
				        stock: params.stock || consola.stock,
				        precio: params.precio || consola.precio,				        
			        })
			        .then(() => {
			        	res.status(200).send(consola)			        	  
			        })  // Send back the updated user
			        .catch((error) => res.status(400).send({message: 'Error en Update'}));						  
				
			}
		})
		.catch(error => res.status(500).send({message: 'Error al actualizar la consola'}));
	}else{
		res.status(404).send({message: 'INtroduce un nombre para actualizar'});
	}
}

function deleteConsola(req, res){
	var consolaId = req.params.idConsola;

	return Consolas
    .findById(consolaId)
    .then(consola => {
      if (!consola) {        
		return res.status(404).send({message: 'La consola no existe'});
      }else{
	      return consola
	        .destroy()
	        .then(() => res.status(200).send({message: 'Consola eliminada'}))
	        .catch(error => res.status(400).send(error));
	  }
    })
    .catch(error => res.status(400).send(error));
}

function getConsola(req, res){
	var consolaId = req.params.idConsola;

	return Consolas
	    .findById(consolaId)
	    .then(consola => res.status(200).send({data: consola}))
	    .catch((error) => res.status(400).send(error));
}


module.exports = {
  pruebas,
  saveConsola,
  allConsolas,
  uploadImage,
  getImageFile,
  updateConsola,
  getConsola,
  deleteConsola,
};