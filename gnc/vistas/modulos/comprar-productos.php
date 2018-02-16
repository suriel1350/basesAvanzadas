<?php
ob_start();
$servidor = Ruta::ctrRutaServidor();  

$cantidades = array();
$idproductos = array();
$precio_compras = array();

$contador = 0;

if ($_SERVER["REQUEST_METHOD"] == "POST") {
	
	foreach ($_POST["cantidad"] as $key => $val) {
	 	$cantidades[$contador] = $val;
	 	$contador = $contador + 1;
	}

	$contador = 0;

	foreach ($_POST["precio_compra"] as $key => $val) {
	 	$precio_compras[$contador] = $val;
	 	$contador = $contador + 1;
	}

	$contador = 0;

	foreach ($_POST["idproducto"] as $key => $val) {
	 	$idproductos[$contador] = $val;
	 	$contador = $contador + 1;
	}

	$total_venta = $_POST["total_venta2"];	
	$nombre_empresa = $_POST["pppnombre_empresa"];	

	$resultado = ControladorCompras::ctrCrearCompra($cantidades, $idproductos, $precio_compras, $total_venta,$nombre_empresa);	
	
	echo '<script>window.location = "/gnc";</script>';	

}

?>	

<div class="row">
	<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center">
		<h3>Crear compra <a href="/gnc" style="padding-right: 10px;"><button class="btn btn-success">Regresar al Menú</button></a></h3>
		<!--include('fabrica.producto.search'-->
	</div>
</div>

<form method="post" action="comprar-productos">
<div class="row">
		<div class="panel panel-primary">
			<div class="panel-body">
				<div class="col-lg-2 col-sm-2 col-md-2 col-xs-12">
					<div class="form-group">
						<label>Producto</label>
						<select name="pidproducto2" class="form-control selectpicker" id="pidproducto2" data-live-search="true">
							
							<?php
								$productos = ControladorProductos::ctrMostrarProductosCompra();	
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
						<label for="nombreEmpresa">Lugar de compra</label>
						<input type="text" name="pppnombre_empresa" id="pnombreEmpresa" class="form-control" placeholder="Nombre del lugar...">
					</div>
				</div>
				<div class="col-lg-1 col-sm-1 col-md-1 col-xs-12">
					<div class="form-group">
						<label for="cantidad2">Cantidad</label>
						<input type="number" name="pcantidad2" id="pcantidad2" class="form-control" placeholder="Cantidad">
					</div>
				</div>
				
				<div class="col-lg-2 col-sm-2 col-md-2 col-xs-12">
					<div class="form-group">
						<label for="precio_compra">Precio Compra</label>
						<input type="number" name="pprecio_compra" id="pprecio_compra" class="form-control" placeholder="Precio...">
					</div>
				</div>

				<div class="col-lg-2 col-sm-2 col-md-2 col-xs-12">
					<div class="form-group">
						<label for="precio_venta2">Precio Venta</label>
						<input type="number" disabled name="pprecio_venta2" id="pprecio_venta2" class="form-control" placeholder="Precio...">
					</div>
				</div>

				<div class="col-lg-2 col-sm-2 col-md-2 col-xs-12">
					<div class="form-group">
						<label for="stock2">Stock</label>
						<input type="number" disabled name="pstock2" id="pstock2" class="form-control" placeholder="Disponibles...">
					</div>
				</div>
				
				<div class="col-lg-1 col-sm-1 col-md-1 col-xs-12">
					<div class="form-group">
						<button type="button" id="bt_add2" class="btn btn-primary">Agregar</button>
					</div>
				</div>

				<div class="col-lg-12 col-sm-12 col-md-12 col-xs-12">
					<table id="detalles2" class="table table-striped table-bordered table-condensed table-hover">
						<thead style="background-color: #A9D0F5">
							<th>Opciones</th>
							<th>Producto</th>
							<th>Cantidad</th>
							<th>Precio Compra</th>
							<th>Subtotal</th>
						</thead>
						<tfoot>
							<th>TOTAL</th>						
							<th></th>
							<th></th>
							<th></th>
							<th><h4 id="total2">$ 0.00</h4><input type="hidden" name="total_venta2" id="total_venta2"></th>
						</tfoot>
						<tbody>
							
						</tbody>
					</table>
				</div>
				
			</div>
		</div>
		
		<div class="col-lg-6 col-sm-6 col-md-6 col-xs-12" id="guardar2"> 
			<div class="form-group">
				<input name="_token" value="" type="hidden"></input>
				<button class="btn btn-primary" type="submit" name="submit" value="Submit">Comprar</button>
				<button class="btn btn-danger" type="reset">Cancelar</button>
			</div>
		</div>	
	</div>
</form>	