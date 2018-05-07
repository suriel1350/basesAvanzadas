const DetalleVentas = require('../models').DetalleVentas;
const Consolas = require('../models').Consolas;
const Ventas = require('../models').Ventas;
const Sequelize = require('sequelize');
var sequelize = new Sequelize('mysql://root:supc1234@localhost:3306/gamesproyectofinal');

var fs = require('fs');
var path = require('path');
var bcrypt = require('bcrypt-nodejs');
var jwt = require('../services/jwt');

function saveVenta(req, res){
	var params = req.body;		
	var usuarioId = req.params.idUser;
	var nombreCliente = req.params.nombreUser;
	var total = req.params.totVenta;
	var idVentaCreada;
	/*for (var i = 0; i < params.length; i++) {
		console.log(params[i].id + ' ' + params[i].cantidad + ' ' + params[i].precio);		
	}
	res.status(200).send({message: params, idmongo: usuarioId, nombre: nombreCliente, total: total});*/
	//res.status(200).send({message: params, idmongo: usuarioId, nombre: nombreCliente, total: total});	
	 //Aqui ya podemos registrar una consola	  
	 return sequelize.transaction(function (t) {
	  // chain all your queries here. make sure you return them.
	  return Ventas.create({
	    idusuario: usuarioId,
        cliente: nombreCliente,
        totalventa: total
	  }, {transaction: t}).then(function (ventaCreada) {
	  		idVentaCreada = ventaCreada.id;

	  		var promises = []
	        for (var i = 0; i < params.length; i++) {
	        	
	        	var newPromise = DetalleVentas.create({
	            	idventas: idVentaCreada,
				    idconsolas: params[i].id,
				    cantidad: params[i].cantidad,
				    precioventa: params[i].precio
	            }, {transaction: t});
		        
	           promises.push(newPromise);
	        }
	        return Promise.all(promises).then(function(users) {
	            
	        });
	  });
	}).then(function (result) {
	  // Transaction has been committed	  
	  res.status(200).send({message: 'La venta fue realizada',});
	  

	}).catch(function (err) {
	  // Transaction has been rolled back	  
	  res.status(404).send({message: 'Lo sentimos hubo un error :(',});
	});
}

function getVentas(req, res){
	
	return Ventas
	    .findAll({
	      include: [{
	        model: DetalleVentas,
	        as: 'idventas',
	      }]
	    })
	    .then(ventas => res.status(200).send(ventas))
	    .catch(error => res.status(400).send(error));	
}

function getDetalles(req, res){
	var ventaId = req.params.idVenta;
	
	return DetalleVentas
	    .findAll({
	      include: [{
	        model: Consolas,
	      }],
	      where: {
			idventas: ventaId,
		  }
	    })
	    .then(mydetails => res.status(200).send(mydetails))
	    .catch(error => res.status(400).send(error));	
}

function deleteVenta(req, res){
	var ventaId = req.params.idVenta;

	return Ventas
    .findById(ventaId)
    .then(venta => {
      if (!venta) {        
		return res.status(404).send({message: 'La venta no existe'});
      }else{
	      return venta
	        .destroy()
	        .then(() => res.status(200).send({message: 'Venta eliminada'}))
	        .catch(error => res.status(400).send(error));
	  }
    })
    .catch(error => res.status(400).send(error));
}

module.exports = {  
  saveVenta,
  getVentas,
  deleteVenta,
  getDetalles,
};

/*
DELIMITER $$
CREATE TRIGGER `tr_updStockCompra` AFTER INSERT ON `detalle_compra` FOR EACH ROW BEGIN
UPDATE producto SET stock = stock + NEW.cantidad
WHERE producto.idproducto = NEW.idproducto;
END
$$
DELIMITER ;
*/