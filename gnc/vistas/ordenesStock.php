<?php

	require_once "../controladores/ordenes.controlador.php";
	require_once "../modelos/ordenes.modelo.php";
	

	if($_REQUEST['delete'])
	{	
		$idproducto = $_REQUEST['delete'];

		$stock = $_REQUEST['stock'];
		
		$output = ControladorOrdenes::ctrAbasteceStock($idproducto, $stock);
		

		//echo json_encode($output);
	}
?>