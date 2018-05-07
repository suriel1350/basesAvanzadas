const DetalleVentas = require('../models').DetalleVentas;
const Accesorios = require('../models').Accesorios;
const Videojuegos = require('../models').Videojuegos;
const Ventas = require('../models').Ventas;
const Sequelize = require('sequelize');
var sequelize = new Sequelize('postgres://suriel:holasuriel@localhost:5432/gamesproyfin');

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
		console.log(params[i].id + ' ' + params[i].cantidad + ' ' + params[i].precio + ' ' + params[i].categoria);		
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
	        	if(params[i].categoria == 'accesorios'){
		            var newPromise = DetalleVentas.create({
		            	idventas: idVentaCreada,
					    idaccesorios: params[i].id,
					    cantidad: params[i].cantidad,
					    precioventa: params[i].precio
		            }, {transaction: t});
		        }else{
		        	var newPromise = DetalleVentas.create({
		            	idventas: idVentaCreada,
					    idvideojuegos: params[i].id,
					    cantidad: params[i].cantidad,
					    precioventa: params[i].precio
		            }, {transaction: t});
		        }
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


/*CREATE TRIGGER update_accesorio_trigger AFTER INSERT ON "DetalleVentas"
FOR EACH ROW EXECUTE PROCEDURE venta_accesorios();

CREATE OR REPLACE FUNCTION venta_accesorios() RETURNS TRIGGER AS $$
   BEGIN
      	UPDATE "Accesorios" SET "stock" = "stock" - NEW.cantidad
      	WHERE "Accesorios"."id" = NEW.idaccesorios;       	
      RETURN NEW;      
   END;
$$ LANGUAGE plpgsql;*/

/*CREATE TRIGGER update_videojuego_trigger AFTER INSERT ON "DetalleVentas"
FOR EACH ROW EXECUTE PROCEDURE venta_videojuegos();

CREATE OR REPLACE FUNCTION venta_videojuegos() RETURNS TRIGGER AS $$
   BEGIN
      	UPDATE "Videojuegos" SET "stock" = "stock" - NEW.cantidad
      	WHERE "Videojuegos"."id" = NEW.idvideojuegos;
      RETURN NEW;      
   END;
$$ LANGUAGE plpgsql;*/

/*DELIMITER $$
CREATE TRIGGER `tr_updStockVenta` AFTER INSERT ON `DetalleVentas` FOR EACH ROW BEGIN
UPDATE Consolas SET stock = stock - NEW.cantidad
WHERE Consolas.id = NEW.idconsolas;
END
$$
DELIMITER ;*/