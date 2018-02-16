<?php
ob_start();
$servidor = Ruta::ctrRutaServidor();  

$cantidades = array();
$idproductos = array();
$precio_ventas = array();

$contador = 0;

if ($_SERVER["REQUEST_METHOD"] == "POST") {
	
	foreach ($_POST["cantidad"] as $key => $val) {
	 	$cantidades[$contador] = $val;
	 	$contador = $contador + 1;
	}

	$contador = 0;

	foreach ($_POST["precio_venta"] as $key => $val) {
	 	$precio_ventas[$contador] = $val;
	 	$contador = $contador + 1;
	}

	$contador = 0;

	foreach ($_POST["idproducto"] as $key => $val) {
	 	$idproductos[$contador] = $val;
	 	$contador = $contador + 1;
	}

	$total_venta = $_POST["total_venta"];	
	$nombre_cliente = $_POST["pppnombre_cliente"];	

	$resultado = ControladorVentas::ctrCrearVenta($cantidades, $idproductos, $precio_ventas, $total_venta,$nombre_cliente);	
	
	echo '<script>window.location = "/gnc";</script>';	

}

?>	

<div class="row">
	<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center">
		<h3>Crear venta <a href="/gnc" style="padding-right: 10px;"><button class="btn btn-success">Regresar al Menú</button></a></h3>
		<!--include('fabrica.producto.search'-->
	</div>
</div>

<form method="post" action="ventas">
<div class="row">
		<div class="panel panel-primary">
			<div class="panel-body">
				<div class="col-lg-2 col-sm-2 col-md-2 col-xs-12">
					<div class="form-group">
						<label>Producto</label>
						<select name="pidproducto" class="form-control selectpicker" id="pidproducto" data-live-search="true">
							
							<?php
								$productos = ControladorProductos::ctrMostrarProductos();	
								$totalStocks = array();
								$contador = 0;

								foreach ($productos as $key => $value) {									
									echo '<option value="'.$value["idproducto"].'_'.$value["stock"].'_'.$value["precio"].'">'.$value["nombre"].'</option>';					

									$totalStocks[$contador] = $value["stock"];
									$contador = $contador + 1;
								}

							?>

						</select>
					</div>					
				</div>				
				<div class="col-lg-2 col-sm-2 col-md-2 col-xs-12">
					<div class="form-group">
						<label for="nombreCliente">Nombre Cliente</label>
						<input type="text" name="pppnombre_cliente" id="pnombreCliente" class="form-control" placeholder="Introduce tu nombre...">
					</div>
				</div>
				<div class="col-lg-2 col-sm-2 col-md-2 col-xs-12">
					<div class="form-group">
						<label for="cantidad">Cantidad</label>
						<input type="number" name="pcantidad" id="pcantidad" class="form-control" placeholder="Cantidad">
					</div>
				</div>
				<div class="col-lg-2 col-sm-2 col-md-2 col-xs-12">
					<div class="form-group">
						<label for="stock">Disponibles</label>
						<input type="number" disabled name="pstock" id="pstock" class="form-control" placeholder="Disponibles...">
					</div>
				</div>
				<div class="col-lg-2 col-sm-2 col-md-2 col-xs-12">
					<div class="form-group">
						<label for="precio_venta">Precio Venta</label>
						<input type="number" disabled name="pprecio_venta" id="pprecio_venta" class="form-control" placeholder="Precio...">
					</div>
				</div>
				
				<div class="col-lg-2 col-sm-2 col-md-2 col-xs-12">
					<div class="form-group">
						<button type="button" id="bt_add" class="btn btn-primary">Agregar</button>
					</div>
				</div>

				<div class="col-lg-12 col-sm-12 col-md-12 col-xs-12">
					<table id="detalles" class="table table-striped table-bordered table-condensed table-hover">
						<thead style="background-color: #A9D0F5">
							<th>Opciones</th>
							<th>Producto</th>
							<th>Cantidad</th>
							<th>Precio Venta</th>
							<th>Subtotal</th>
						</thead>
						<tfoot>
							<th>TOTAL</th>						
							<th></th>
							<th></th>
							<th></th>
							<th><h4 id="total">$ 0.00</h4><input type="hidden" name="total_venta" id="total_venta"></th>
						</tfoot>
						<tbody>
							
						</tbody>
					</table>
				</div>
				
			</div>
		</div>
		
		<div class="col-lg-6 col-sm-6 col-md-6 col-xs-12" id="guardar"> 
			<div class="form-group">
				<input name="_token" value="" type="hidden"></input>
				<button class="btn btn-primary" type="submit" name="submit" value="Submit">Comprar</button>
				<button class="btn btn-danger" type="reset">Cancelar</button>
			</div>
		</div>	
	</div>
</form>	