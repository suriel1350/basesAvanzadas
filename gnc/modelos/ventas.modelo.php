<?php

require_once "conexion.php";

class ModeloVentas{

	static public function mdlCrearVenta($tabla, $cantidades, $idproductos, $precio_ventas, $total_venta, $nombre_cliente){
		//$sql = "INSERT INTO auto2 (idauto,nombrec,idmarca, ac) values(null, ?, ?, ?)";			

		$pdo = Conexion::conectar();
		
		$pdo->beginTransaction();

		try{
			$sql = "INSERT INTO venta (idcliente, idsucursal, idempleado, fecha_hora, total_venta, nombre_cliente) values(1,1,1,NOW(),$total_venta, '$nombre_cliente')";

			$stmt = $pdo->prepare($sql);
			$stmt -> execute();
			$last_id = $pdo->lastInsertId();

			//$data = $q->fetch(PDO::FETCH_ASSOC);

			for ($i=0; $i < count($idproductos) ; $i++) { 
				
			
				$sql = "INSERT INTO detalle_venta (idventa, idproducto, cantidad, precio_venta, descuento, impuesto) values($last_id, $idproductos[$i], $cantidades[$i], $precio_ventas[$i], 0, 16)";
				
				$stmt = $pdo->prepare($sql);

				$stmt -> execute();

			}

			$pdo->commit();
			
			return $nombre_cliente;

			$stmt -> close();		

			$stmt = null;
		}
		catch(Exception $e){
			echo $e->getMessage();

			$pdo->rollBack();

		}

	}

	static public function mdlMostrarVenta($tabla){

		$stmt = Conexion::conectar()->prepare("SELECT * FROM $tabla");

		$stmt -> execute();

		return $stmt -> fetchAll();

		$stmt -> close();

		$stmt = null;
	}

}