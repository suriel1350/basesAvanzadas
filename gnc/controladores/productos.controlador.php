<?php

class ControladorProductos{

	/*=============================================
	MOSTRAR PRODUCTOS DISPONIBLES PARA VENTA
	=============================================*/

	public function ctrMostrarProductos(){

		$tabla = "producto";

		$respuesta = ModeloProductos::mdlMostrarProductos($tabla);

		return $respuesta;
		
	}

	/*=============================================
	MOSTRAR PRODUCTOS DISPONIBLES PARA COMPRA
	=============================================*/

	public function ctrMostrarProductosCompra(){

		$tabla = "producto";

		$respuesta = ModeloProductos::mdlMostrarProductosCompra($tabla);

		return $respuesta;
		
	}

	/*=============================================
	ELIMINAR PRODUCTO
	=============================================*/

	static public function ctrEliminarProducto($id){

		$tabla = "producto";
		$columna = "condicion";

		$respuesta = ModeloProductos::mdlEliminarProductos($tabla, $id, $columna);

		return $respuesta;
	}

}