<?php

class ControladorOrdenes{
	/*=============================================
	ORDENES
	=============================================*/

	public function ctrMostrarOrdenes(){

		$tabla = "purchaseOrders";

		$respuesta = ModeloOrdenes::mdlMostrarOrdenes($tabla);

		return $respuesta;
		
	}

	static public function ctrAbasteceStock($idproducto, $stock){

		$tabla = "producto";

		$respuesta = ModeloOrdenes::mdlAbasteceStock($tabla, $idproducto, $stock);

		return $respuesta;
		
	}
}