<?php

	require_once "../controladores/detalles.controlador.php";
	require_once "../modelos/detalles.modelo.php";
	

	if($_REQUEST['delete'])
	{	
		$idventa = $_REQUEST['delete'];

		$output = ControladorDetalles::ctrMostrarDetalles($idventa);
		

		echo json_encode($output);
	}
?>