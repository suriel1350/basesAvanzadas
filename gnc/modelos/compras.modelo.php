<?php

require_once "conexion.php";

class ModeloCompras{

	static public function mdlCrearCompra($tabla, $cantidades, $idproductos, $precio_compras, $total_venta, $nombre_empresa){
		//$sql = "INSERT INTO auto2 (idauto,nombrec,idmarca, ac) values(null, ?, ?, ?)";			
		$resul;

		$pdo = Conexion::conectar();
		
		$pdo->beginTransaction();

		try{
			$sql = "INSERT INTO $tabla (idcliente, idsucursal, idempleado, fecha_hora, total_compra, empresa_compra) values(1,1,1,NOW(),$total_venta, '$nombre_empresa')";

			$stmt = $pdo->prepare($sql);
			$stmt -> execute();
			$last_id = $pdo->lastInsertId();

			//$data = $q->fetch(PDO::FETCH_ASSOC);

			for ($i=0; $i < count($idproductos) ; $i++) { 								
				
					$sql = "INSERT INTO detalle_compra (idcompra, idproducto, cantidad, precio_compra, descuento, impuesto) values($last_id, $idproductos[$i], $cantidades[$i], $precio_compras[$i], 0, 16)";
				
					$stmt = $pdo->prepare($sql);

					$stmt -> execute();
				

			}

			$pdo->commit();
			
			return $nombre_empresa;

			$stmt -> close();		

			$stmt = null;
		}
		catch(Exception $e){
			echo '<script>window.location = "/gnc/error-transaccion";</script>';				

			$pdo->rollBack();

		}

	}

}