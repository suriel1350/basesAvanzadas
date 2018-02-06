<?php

class ControladorDetalles{

	/*=============================================
	CONSEGUIR DETALLES
	=============================================*/

	public function ctrMostrarDetalles($idventa){

		$tabla = "detalle_venta";

		$respuesta = ModeloDetalles::mdlMostrarDetalles($tabla, $idventa);

		return $respuesta;
		
	}

}