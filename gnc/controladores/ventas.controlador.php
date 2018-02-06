<?php

class ControladorVentas{
	/*=============================================
	CREAR VENTA
	=============================================*/

	static public function ctrCrearVenta($cantidades, $idproductos, $precio_ventas, $total_venta, $nombre_cliente){

		$tabla = "venta";

		$respuesta = ModeloVentas::mdlCrearVenta($tabla, $cantidades, $idproductos, $precio_ventas, $total_venta, $nombre_cliente);

		return $respuesta;
		
	}

	public function ctrMostrarVentas(){

		$tabla = "venta";

		$respuesta = ModeloVentas::mdlMostrarVenta($tabla);

		return $respuesta;
		
	}
}