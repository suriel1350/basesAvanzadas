<?php

require_once "conexion.php";

class ModeloProductos{

	static public function mdlMostrarProductos($tabla){

		$stmt = Conexion::conectar()->prepare("SELECT * FROM $tabla WHERE condicion = 1");

		$stmt -> execute();

		return $stmt -> fetchAll();

		$stmt -> close();

		$stmt = null;

	}

	static public function mdlEliminarProductos($tabla, $id, $columna){

		$stmt = Conexion::conectar()->prepare("UPDATE $tabla SET $columna = 0 WHERE idproducto = :id");

		$stmt -> bindValue(":id", $id);		

		$stmt -> execute();

		return "Exito";

		$stmt -> close();

		$stmt = null;

	}

}