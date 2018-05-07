'use strict'
var fs = require('fs');
var path = require('path');

var Cart = require('../models/cart');

function buscaItemUser(req, res){
	var params = req.body;

	Cart.findOne({nombre: params.nombre, userId: params.idUser}, (err, itemUserFound) => {
		if(err){
			res.status(500).send({message: 'Error en el servidor'});
		}else{
			if(!itemUserFound){
				res.status(404).send({message: 'El item no se ha encontrado'});
			}else{
				res.status(200).send({itemUser: itemUserFound});
			}
		}
	});
}

function saveItem(req, res){
	var cart = new Cart();
	var params = req.body;
	
	cart.nombre = params.nombre;
	cart.descripcion = params.descripcion;
	cart.categoria = params.categoria;
	cart.cantidad = params.cantidad;
	cart.precio = params.precio;
	cart.id = params.id;
	cart.imagen = params.imagen;
	cart.userId = params.userId;	

	cart.save((err, cartStored) => {
		if(err){
			res.status(500).send({message: 'Error en el servidor'});
		}else{
			if(!cartStored){
				res.status(404).send({message: 'El item no ha sido agregado'});
			}else{
				res.status(200).send({item: cartStored});
			}
		}
	});
}

function updateCartItem(req, res){
	var params = req.body;
	var usuarioId = req.params.idUser;	
	var update = req.body;

	if(params.cantidad > 0){	  
		Cart.findOne({nombre: params.nombre, userId: usuarioId}, (err, itemFound) => {
			if(err){
				res.status(500).send({message: 'Error al encontrar el item'});
			}else{
				if(!itemFound){
					res.status(404).send({message: 'No existe el item'});
				}else{									
					//res.status(200).send({item: itemFound});
					Cart.findByIdAndUpdate(itemFound._id, update, (err, itemUpdated) =>{
						if(err){
							res.status(500).send({message: 'Error al alctualizar el item'});
						}else{
							if(!itemUpdated){
								res.status(404).send({message: 'El item no ha sido actualizado'});
							}else{
								res.status(200).send({item: itemUpdated});
							}
						}
					});
				}
			}
		});		
	}else{
		res.status(404).send({message: 'Introduce una cantidad mayor a 0'});	
	}
}

function getCartItemsByUser(req, res){
	var usuarioId = req.params.idUser;	

	var find = Cart.find({userId: usuarioId}).sort('categoria');

	find.populate({path: 'userId'}).exec((err, items) => {
		if(err){
			res.status(500).send({message: 'Error en la petición'});
		}else{
			if(!items){
				res.status(404).send({message: 'No tienes items agregados!'});
			}else{
				res.status(200).send({items});
			}
		}
	});
}

function deleteCartItem(req, res){
	var cartId = req.params.idCart;
	//console.log(cartId);
	Cart.findByIdAndRemove(cartId, (err, itemRemoved) => {
		if(err){
			res.status(500).send({message: 'Error al eliminar el item'});
		}else{
			if(!itemRemoved){
				res.status(404).send({message: 'El item no ha sido eliminado'});
			}else{				
				res.status(200).send({item: itemRemoved});
			}
		}
	});		
}

module.exports = {
	buscaItemUser,
	saveItem,
	updateCartItem,
	getCartItemsByUser,
	deleteCartItem
};