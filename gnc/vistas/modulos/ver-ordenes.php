<?php

$servidor = Ruta::ctrRutaServidor();  

?>	

<div class="row">
	<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center">
		<h3>Ordenes de Compra <a href="/gnc" style="padding-right: 10px;"><button class="btn btn-success">Regresar al Menú</button></a></h3>
		<!--include('fabrica.producto.search'-->
	</div>
</div>

<hr>

<!--=====================================
ORDENES DE COMPRA
======================================-->
	<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="table-responsive">
				<table class="table table-striped table-bordered table-condensed table-hover">
					<thead>
						<th class="text-center">ID Producto</th>											
						<th class="text-center">Producto</th>											
						<th class="text-center">No. Ordenes</th>
						<th class="text-center">En Stock</th>
						<th class="text-center">Fecha Orden</th>
						<th class="text-center">Estado</th>
						<th class="text-center">Acción</th>
					</thead>
				<?php
					$ordenes = ControladorOrdenes::ctrMostrarOrdenes();						

					foreach ($ordenes as $key => $value) {						

					echo '<tr>
							<td class="text-center">'.$value["idproducto"].'</td>
							<td class="text-center">'.$value["product_name"].'</td>
							<td class="text-center">'.$value["products_ordered"].'</td>
							<td class="text-center">'.$value["products_in_stock"].'</td>
							<td class="text-center">'.$value["date_time_of_order"].'</td>
							<td class="text-center">'.$value["estado"].'</td>
							<td class="text-center">
								<a href="" class="update-stock" data-stocks="'.$value["products_ordered"].'" data-producto-id="'.$value["idproducto"].'"><button class="btn btn-primary">Abastecer</button></a>							
							</td>
						</tr>';
					}
				?>					
				</table>
			</div>			
		</div>
	</div>
