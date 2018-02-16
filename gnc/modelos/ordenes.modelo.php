<?php

require_once "conexion.php";

class ModeloOrdenes{

	static public function mdlMostrarOrdenes($tabla){

		$stmt = Conexion::conectar()->prepare("SELECT *  FROM $tabla WHERE estado = 'Pendiente'");

		$stmt -> execute();

		return $stmt -> fetchAll();	

		$stmt -> close();

		$stmt = null;

	}

	static public function mdlAbasteceStock($tabla, $idproducto, $stock){

		$pdo = Conexion::conectar();
		
		$sql = "UPDATE $tabla SET stock=$stock where idproducto=$idproducto";

		$stmt = $pdo->prepare($sql);
		
		$stmt -> execute();

		$sql = "UPDATE purchaseOrders SET estado='Bien' where idproducto=$idproducto";

		$stmt = $pdo->prepare($sql);
		
		$stmt -> execute();

		return "Exito";	

		$stmt -> close();

		$stmt = null;
	}

}