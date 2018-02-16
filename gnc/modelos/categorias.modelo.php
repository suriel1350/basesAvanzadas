<?php

require_once "conexion.php";

class ModeloCategorias{

	static public function mdlMostrarCategorias($tabla){
		//$sql = "INSERT INTO auto2 (idauto,nombrec,idmarca, ac) values(null, ?, ?, ?)";
		$pdo = Conexion::conectar();
		
		$sql = "CALL GetCategorias()";

		$stmt = $pdo->prepare($sql);
		
		$stmt -> execute();
		
		return $stmt -> fetchAll();			

		$stmt -> close();		

		$stmt = null;		
	}

	static public function mdlMostrarProductosCat($tabla, $idcategoria){
		//$sql = "INSERT INTO auto2 (idauto,nombrec,idmarca, ac) values(null, ?, ?, ?)";
		$pdo = Conexion::conectar();
		
		$sql = "SELECT nombre FROM $tabla WHERE idcategoria = $idcategoria";

		$stmt = $pdo->prepare($sql);
		
		$stmt -> execute();
		
		return $stmt -> fetchAll();			

		$stmt -> close();		

		$stmt = null;		
	}

}