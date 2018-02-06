<?php

$servidor = Ruta::ctrRutaServidor();  

?>	

<div class="row">
	<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center">
		<h3>Ventas realizadas <a href="/gnc" style="padding-right: 10px;"><button class="btn btn-success">Regresar al Menú</button></a></h3>
		<!--include('fabrica.producto.search'-->
	</div>
</div>

<hr>

<!--=====================================
DETALLES VENTA
======================================-->
	<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="table-responsive">
				<table class="table table-striped table-bordered table-condensed table-hover">
					<thead>
						<th class="text-center">Fecha</th>											
						<th class="text-center">Total</th>
						<th class="text-center">Cliente</th>
						<th class="text-center">Opciones</th>
					</thead>
				<?php
					$ventas = ControladorVentas::ctrMostrarVentas();						

					foreach ($ventas as $key => $value) {						

					echo '<tr>
							<td class="text-center">'.$value["fecha_hora"].'</td>
							<td class="text-center">'.$value["total_venta"].'</td>
							<td class="text-center">'.$value["nombre_cliente"].'</td>
							<td class="text-center">
								<a href="" class="show-detalles" data-detalles-id="'.$value["idventa"].'" data-target="#'.$value["idventa"].'" data-toggle="modal"><button class="btn btn-primary">Detalles</button></a>							
							</td>
						</tr>

						<div class="modal fade" id="'.$value["idventa"].'" role="dialog">
						    <div class="modal-dialog">
						    
						      <!-- Modal Info-->
						      <div class="modal-content">
						        
						        <div class="modal-header">
						          <button type="button" class="close" data-dismiss="modal">&times;</button>
						          <h4 class="modal-title">Cliente: '.$value["nombre_cliente"].'</h4>
						        </div>
						        
						        <div class="modal-body">
						          <div class="row">					          						        
									
									<div class="col-md-6">
				                        <div class="rating">
				                            <span class="fa fa-star"></span>
				                            <span class="fa fa-star"></span>
				                            <span class="fa fa-star"></span>
				                            <span class="fa fa-star"></span>
				                            <span class="fa fa-star"></span>                            
				                        </div>
									</div>

						          </div>
						        </div>

						        <div class="modal-footer">
						          <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
						        </div>
						      </div>
						      
						    </div>
						</div>';
					}
				?>					
				</table>
			</div>			
		</div>
	</div>
