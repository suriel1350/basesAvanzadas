<?php

$servidor = Ruta::ctrRutaServidor();  

?>	

<div class="row">
	<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center">
		<h3>Categorias Disponibles <a href="/gnc" style="padding-right: 10px;"><button class="btn btn-success">Regresar al Menú</button></a></h3>
		<!--include('fabrica.producto.search'-->
	</div>
</div>

<hr>

<!--=====================================
CATEGORIAS DISPONIBLES
======================================-->
	<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="table-responsive">
				<table class="table table-striped table-bordered table-condensed table-hover">
					<thead>
						<th class="text-center">Nombre Categoría</th>											
						<th class="text-center">Productos Disponibles</th>							
						<th class="text-center">Acción</th>
					</thead>
				<?php
					$categorias = ControladorCategorias::ctrMostrarCategorias();

					foreach ($categorias as $key => $value) {						

					echo '<tr>
							<td class="text-center">'.$value["nombre"].'</td>
							<td class="text-center">'.$value["productos"].'</td>							
							<td class="text-center">
								<a href="" class="mostrar-productos-categorias" data-nombre-id="'.$value["nombre"].'" data-categoria-id="'.$value["idcategoria"].'"><button class="btn btn-primary">Ver Productos</button></a>							
							</td>
						</tr>';
					}
				?>					
				</table>
			</div>			
		</div>
	</div>
