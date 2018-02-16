<?php

class ControladorCompras{
	/*=============================================
	CREAR VENTA
	=============================================*/

	static public function ctrCrearCompra($cantidades, $idproductos, $precio_compras, $total_venta, $nombre_empresa){

		$tabla = "compra";

		$respuesta = ModeloCompras::mdlCrearCompra($tabla, $cantidades, $idproductos, $precio_compras, $total_venta, $nombre_empresa);

		return $respuesta;
		
	}

}