<?php

$servidor = Ruta::ctrRutaServidor();  

?>	

<div class="row">
	<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center">
		<h3>Ventas por última hora <a href="/gnc" style="padding-right: 10px;"><button class="btn btn-success">Regresar al Menú</button></a></h3>
		<!--include('fabrica.producto.search'-->
	</div>
</div>

<!--=====================================
VENTAS ULTIMA HORA
======================================-->
	<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="table-responsive">
				<table class="table table-striped table-bordered table-condensed table-hover">
					<thead>						
						<th class="text-center">No. Ventas</th>
						<th class="text-center">Última Hora</th>						
					</thead>
				<?php
					$ventashora = ControladorVentas::ctrObtenerVentasHora();						

					foreach ($ventashora as $key => $value) {						

					echo '<tr>
							<td class="text-center">'.$value["total_sales"].'</td>
							<td class="text-center">'.$value["created_at"].'</td>							
						</tr>';
					}
				?>					
				</table>
			</div>			
		</div>
	</div>
