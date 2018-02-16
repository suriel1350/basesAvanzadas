<?php

require_once "controladores/plantilla.controlador.php";
require_once "controladores/productos.controlador.php";
require_once "controladores/ventas.controlador.php";
require_once "controladores/ordenes.controlador.php";
require_once "controladores/categorias.controlador.php";
require_once "controladores/compras.controlador.php";

require_once "modelos/productos.modelo.php";
require_once "modelos/ventas.modelo.php";
require_once "modelos/ordenes.modelo.php";
require_once "modelos/categorias.modelo.php";
require_once "modelos/compras.modelo.php";

require_once "modelos/rutas.php";

$plantilla = new ControladorPlantilla();
$plantilla -> plantilla();