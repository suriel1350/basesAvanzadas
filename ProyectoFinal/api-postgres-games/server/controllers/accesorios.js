const Accesorios = require('../models').Accesorios;
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

function saveAccesorio(req, res){
	var params = req.body;		

			//Aqui ya podemos registrar al videojuego			
			return Accesorios
		      .create({
		        nombre: params.nombre.toLowerCase(),
		        descripcion: params.descripcion,
		        stock: params.stock,
		        precio: params.precio,
		        imagen: 'null',				
		      })
		      .then(accesorioCreated => res.status(200).send(accesorioCreated))
		      .catch(error => res.status(404).send(error));		
}

function allAccesorios(req, res){

	return Accesorios
		.findAll({		  			
			where: { 
				stock: {[Op.gt]: 0}, // > 0
			}
		})
		.then(accesorios => res.status(200).send(accesorios))
		.catch(error => res.status(400).send(error));
}

function uploadImage(req, res){
	var accesorioId = req.params.id;
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
		        	return Accesorios
					    .findById(accesorioId)
					    .then(accesorio => {
					      if (!accesorio) {
					        return res.status(404).send({message: 'El accesorio no existe',});
					      }
					      else{
						      return accesorio
						        .update({
						          imagen: file_name || accesorio.imagen,
						        })
						        .then(() => {
						        	res.status(200).send(accesorio)
						        	  
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

function updateAccesorio(req, res){
	var accesorioId = req.params.id;
	var update = req.body;
	var params = req.body;
	var pass;

	if(params.nombre){				
		Accesorios.findById(accesorioId)
		.then(accesorio => {
			if(!accesorio){				
				res.status(404).send({message: 'El accesorio no existe'});
			}else{
				
			      return accesorio
			        .update({					          				          	
				        nombre: params.nombre.toLowerCase() || accesorio.nombre, 
				        descripcion: params.descripcion || accesorio.descripcion,
				        stock: params.stock || accesorio.stock,
				        precio: params.precio || accesorio.precio,				        
			        })
			        .then(() => {
			        	res.status(200).send(accesorio)			        	  
			        })  // Send back the updated user
			        .catch((error) => res.status(400).send({message: 'Error en Update'}));						  
				
			}
		})
		.catch(error => res.status(500).send({message: 'Error al actualizar el accesorio'}));
	}else{
		res.status(404).send({message: 'INtroduce un nombre para actualizar'});
	}
}

function deleteAccesorio(req, res){
	var accesorioId = req.params.idAccesorio;

	return Accesorios
    .findById(accesorioId)
    .then(accesorio => {
      if (!accesorio) {        
		return res.status(404).send({message: 'El accesorio no existe'});
      }else{
	      return accesorio
	        .destroy()
	        .then(() => res.status(200).send({message: 'Accesorio eliminado'}))
	        .catch(error => res.status(400).send(error));
	  }
    })
    .catch(error => res.status(400).send(error));
}

function getAccesorio(req, res){
	var accesorioId = req.params.idAccesorio;

	return Accesorios
	    .findById(accesorioId)
	    .then(accesorio => res.status(200).send({data: accesorio}))
	    .catch((error) => res.status(400).send(error));
}


module.exports = {
  pruebas,
  saveAccesorio,
  allAccesorios,
  uploadImage,
  getImageFile,
  updateAccesorio,
  getAccesorio,
  deleteAccesorio,
};