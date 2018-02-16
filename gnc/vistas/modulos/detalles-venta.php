<?php

$servidor = Ruta::ctrRutaServidor();  

?>	

<div class="row">
	<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center">
		<h3>Detalles de venta <a href="ver-ventas" style="padding-right: 10px;"><button class="btn btn-success">Regresar a lista Ventas</button></a></h3>
		<!--include('fabrica.producto.search'-->
	</div>
</div>

<hr>

<div class="row">
		<div class="panel panel-primary">
			<div class="panel-body">
				
				<div class="col-lg-12 col-sm-12 col-md-12 col-xs-12">
					<table id="detalles" class="table table-striped table-bordered table-condensed table-hover">
						<thead style="background-color: #A9D0F5">
							
							<th class="text-center">Producto</th>
							<th class="text-center">Cantidad</th>
							<th class="text-center">Precio Venta</th>						
							<th class="text-center">Subtotal</th>
						</thead>
						<tfoot>
							
							<th class="text-center">TOTAL</th>
							<th></th>
							<th></th>
							<th><h4 id="total">{{$venta->total_venta}}</h4></th>
						</tfoot>
						<tbody>
							
							<tr>
								<td>{{$det->producto}}</td>
								<td>{{$det->cantidad}}</td>
								<td>{{$det->precio_venta}}</td>								
								<td>{{$det->cantidad*$det->precio_venta}}</td>
							</tr>
							
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>