<?php

require_once "conexion.php";

class ModeloDetalles{

	static public function mdlMostrarDetalles($tabla, $id){

		$stmt = Conexion::conectar()->prepare("SELECT producto.nombre, $tabla.cantidad, $tabla.precio_venta  FROM $tabla, producto WHERE idventa = :id and producto.idproducto = $tabla.idproducto");

		$stmt -> bindValue(":id", $id);				

		$stmt -> execute();

		return $stmt -> fetchAll();	

		$stmt -> close();

		$stmt = null;

	}

}