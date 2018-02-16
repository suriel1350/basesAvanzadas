<?php

class ControladorCategorias{
	/*=============================================
	CATEGORIAS
	=============================================*/

	public function ctrMostrarCategorias(){

		$tabla = "categoria";

		$respuesta = ModeloCategorias::mdlMostrarCategorias($tabla);

		return $respuesta;
		
	}

	static public function ctrMostrarProductosCat($idcategoria){

		$tabla = "producto";

		$respuesta = ModeloCategorias::mdlMostrarProductosCat($tabla, $idcategoria);

		return $respuesta;
		
	}

}