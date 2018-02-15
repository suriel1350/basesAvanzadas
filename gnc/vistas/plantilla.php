<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  
  <title>GNC Suplementos</title>

  <?php
    /*=============================================
    RUTA DONDE ESTA EL SERVIDOR
    =============================================*/

    $url = Ruta::ctrRutaServidor();

  ?>

  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  
  <link rel="icon" href="vistas/img/favicon.ico">

  <!--=====================================
  PLUGINS DE CSS
  ======================================-->
  
  <link rel="stylesheet" href="vistas/bower_components/bootstrap/dist/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="vistas/bower_components/font-awesome/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="vistas/bower_components/Ionicons/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="vistas/dist/css/AdminLTE.min.css">
  <link rel="stylesheet" href="vistas/dist/css/style.css">
  <link rel="stylesheet" href="vistas/dist/css/bootstrap-select.min.css">
  
  <!-- AdminLTE Skins. We have chosen the skin-blue for this starter
        page. However, you can choose any other skin. Make sure you
        apply the skin class to the body tag so the changes take effect. -->
  <link rel="stylesheet" href="vistas/dist/css/skins/skin-red.min.css">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

  <!-- Google Font -->
  <link rel="stylesheet"
        href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>
<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect

| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |

|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |

-->
<body class="hold-transition skin-red sidebar-mini">
<div class="wrapper">

  <!-- Main Header -->
  <header class="main-header">

    <!-- Logo -->
    <a href="index2.html" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>G</b>NC</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><b>GNC</b> Suplementos</span>
    </a>

    <!-- Header Navbar -->
    <nav class="navbar navbar-static-top" role="navigation">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>     
      
    </nav>
  </header>
  <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">

    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">

      <!-- Sidebar user panel (optional) -->
      <div class="user-panel">
        <div class="pull-left image">
          <img src="vistas/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
        </div>
        <div class="pull-left info">
          <p>Usuario</p>
          <!-- Status -->
          <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
        </div>
      </div>

      
      <!-- /.search form -->

      <!-- Sidebar Menu -->
      <ul class="sidebar-menu" data-widget="tree">
        <li class="header">Opciones</li>
        <!-- Optionally, you can add icons to the links -->
        <li><a href="ventas"><i class="fa fa-money"></i> <span>Crear Venta</span></a></li>
        <li><a href="productos"><i class="fa fa-shopping-cart"></i> <span>Productos</span></a></li>
        <li><a href="ver-ventas"><i class="fa fa-circle-o"></i> <span>Ventas</span></a></li>
      </ul>
      <!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        BIENVENIDO A GNC SUPLEMENTOS
        <small> Elige una opción</small>
      </h1>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">

      <!-- Contenido va aquí -->
      <?php

        /*=============================================
        CONTENIDO DINAMICO 
        =============================================*/
        
        $rutas = array();
        $ruta = null;
        
        $valor = $_SERVER['REQUEST_URI'];
        $valorN = explode("/", $valor);        

        //echo $valorN[2];        

        /*if($valorN[2] == null)
          echo "aAlgo";
        else
          echo $valorN[2];*/

        if( $valorN[2] == null ){
          
          /*=============================================
          BOTONES INICIO
          ===============================================
          */

          include "modulos/botones.php";

        }else{

          /*=============================================
          LISTA BLANCA DE URL'S AMIGABLES
          =============================================*/

          if($valorN[2] == "productos") {            
            include "modulos/productos.php";          
          }else if($valorN[2] == "ventas"){
            include "modulos/ventas.php";          
          }else if($valorN[2] == "ver-ventas"){
            include "modulos/ver-ventas.php";
          }else if($valorN[2] == "detalles-venta"){
            include "modulos/detalles-venta.php";
          }else if($valorN[2] == "error-transaccion"){
            include "modulos/error-transaccion.php";
          }else if($valorN[2] == "ver-ordenes"){
            include "modulos/ver-ordenes.php";
          }else if($valorN[2] == "categorias"){
            include "modulos/categorias.php";
          }else if($valorN[2] == "ventas-hora"){
            include "modulos/ventas-hora.php";
          }else {

            include "modulos/error404.php";

          }
        
        }


      ?>

      <!-- Termina Contenido -->
    </section>  
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Main Footer -->
  <footer class="main-footer">
    <!-- To the right -->
    <div class="pull-right hidden-xs">
      Todo en Suplementación
    </div>
    <!-- Default to the left -->
    <strong>Base de datos avanzadas &copy; 2018 <a href="#">ITESM</a>.</strong> Suriel Asael - Fernando Castillo.
  </footer>
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->

<!-- jQuery 3 -->
<script src="vistas/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="vistas/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="vistas/dist/js/adminlte.min.js"></script>

<script type="text/javascript" src="vistas/dist/js/abastecerStock.js"></script>
<script type="text/javascript" src="vistas/dist/js/mostrarProductosCategorias.js"></script>
<script type="text/javascript" src="vistas/dist/js/delete.js"></script>
<script type="text/javascript" src="vistas/dist/js/crearVenta.js"></script>
<script type="text/javascript" src="vistas/dist/js/bootbox.min.js"></script>
<script type="text/javascript" src="vistas/dist/js/bootstrap-select.min.js"></script>

<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->
</body>
</html>