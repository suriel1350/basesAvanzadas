<?php

	require_once "../controladores/categorias.controlador.php";
	require_once "../modelos/categorias.modelo.php";
	

	if($_REQUEST['delete'])
	{	
		$idcategoria = $_REQUEST['delete'];

		$output = ControladorCategorias::ctrMostrarProductosCat($idcategoria);
		

		echo json_encode($output);
	}
?>