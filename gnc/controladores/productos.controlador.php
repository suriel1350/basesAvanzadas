<?php

class ControladorProductos{

	/*=============================================
	MOSTRAR PRODUCTOS
	=============================================*/

	public function ctrMostrarProductos(){

		$tabla = "producto";

		$respuesta = ModeloProductos::mdlMostrarProductos($tabla);

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