<?php

require_once "conexion.php";

class ModeloDetalles{

	static public function mdlMostrarDetalles($tabla, $id){

		$stmt = Conexion::conectar()->prepare("SELECT * FROM $tabla WHERE idventa = :id");

		$stmt -> bindValue(":id", $id);				

		$stmt -> execute();

		return $stmt -> fetchAll();	

		$stmt -> close();

		$stmt = null;

	}

}