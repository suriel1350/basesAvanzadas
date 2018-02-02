<?php

	require_once "../controladores/productos.controlador.php";
	require_once "../modelos/productos.modelo.php";

	if($_REQUEST['delete'])
	{	
		$idProducto = $_REQUEST['delete'];
		
		$productos = ControladorProductos::ctrEliminarProducto($idProducto);			

		echo "$productos";
	}
?>