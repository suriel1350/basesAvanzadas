<?php

$servidor = Ruta::ctrRutaServidor();  

?>	

<div class="row">
	<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center">
		<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 text-center">
			<h3>Productos disponibles <a href="/gnc" style="padding-right: 10px;"><button class="btn btn-success">Regresar al Menú</button></a></h3>
		</div>
		<div class="col-lg-2 col-md-2 col-sm-2 col-xs-2 text-center">
			<h3> <a href="categorias" style="padding-right: 10px;"><button class="btn btn-warning">Categorías</button></a></h3>
		</div>
		<div class="col-lg-2 col-md-2 col-sm-2 col-xs-2 text-center">
			<h3> <a href="ventas" style="padding-right: 10px;"><button class="btn btn-primary">Ventas</button></a></h3>
		</div>
		<div class="col-lg-2 col-md-2 col-sm-2 col-xs-2 text-center">
			<h3> <a href="comprar-productos" style="padding-right: 10px;"><button class="btn btn-primary">Compras</button></a></h3>
		</div>
		<!--include('fabrica.producto.search'-->
	</div>
</div>

<hr>

<!--=====================================
VITRINA DE PRODUCTOS 
======================================-->

<div class="row">
	<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
		<?php
			
			$productos = ControladorProductos::ctrMostrarProductos();	

			foreach ($productos as $key => $value) {	
								  								
		    echo '<div class="col-xs-6 col-md-4">
		       		<div class="text-center product tumbnail thumbnail-3"><a href="" data-target="#'.$value["idproducto"].'" data-toggle="modal"><img src="'.$value["imagen"].'" alt="" class="img-thumbnail muestra"></a>
		         		<div class="caption text-center">
		           			<h4><a href="" data-target="#'.$value["idproducto"].'" data-toggle="modal">'.$value["nombre"].'</a></h4><span class="price">
		             		<a href="" data-target="#'.$value["idproducto"].'" data-toggle="modal"><button class="btn btn-primary fa fa-info"></button></a>
							<a class="delete_student" data-student-id="'.$value["idproducto"].'"  href="javascript:void(0)"">
								<button class="btn btn-danger fa fa-times"></button>
							 </a>
		         		</div>
		       		</div>
		     	</div>

		     	
				<div class="modal fade" id="'.$value["idproducto"].'" role="dialog">
				    <div class="modal-dialog">
				    
				      <!-- Modal Info-->
				      <div class="modal-content">
				        
				        <div class="modal-header">
				          <button type="button" class="close" data-dismiss="modal">&times;</button>
				          <h4 class="modal-title">'.$value["nombre"].'</h4>
				        </div>
				        
				        <div class="modal-body">
				          <div class="row">
				          	
				          	<div class="col-md-4 text-center product tumbnail thumbnail-3">
								<a href="#"><img src="'.$value["imagen"].'" alt="" class="img-thumbnail muestra"></a>
							</div>
							
							<div class="col-md-6">
		                        <div class="rating">
		                            <span class="fa fa-star"></span>
		                            <span class="fa fa-star"></span>
		                            <span class="fa fa-star"></span>
		                            <span class="fa fa-star"></span>
		                            <span class="fa fa-star"></span>                            
		                        </div>
		                        <br>
		                        <p>'.$value["descripcion"].'</p>
		                        <h3>Disponibles: '.$value["stock"].'</h3>
							</div>

				          </div>
				        </div>

				        <div class="modal-footer">
				          <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
				        </div>
				      </div>
				      
				    </div>
				</div>';
				

				/*<div class="modal fade" id="eliminar-'.$value["idproducto"].'" role="dialog">
				    
					    <div class="modal-dialog">
					    
					      <!-- Modal eliminar-->
					      <div class="modal-content">
					        
					        <div class="modal-header">
					          <button type="button" class="close" data-dismiss="modal">&times;</button>
					          <h4 class="modal-title">Eliminar el producto: </h4>
					        </div>
					        
					        <div class="modal-body">
					          <div class="row">
					          	
		    				<input type="hidden" name="id" value="'.$value["idproducto"].'"/>				

					          	<div class="col-md-12 text-center product tumbnail thumbnail-3 centrarEliminar">
					          		<h3>Confirme si desea eliminar el producto</h3>	
					          		<h4>'.$value["nombre"].'</h4>
								</div>	
								
					          </div>
					        </div>

					        <div class="modal-footer">
					          <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
					          <a class="delete_student" data-student-id="'.$value["idproducto"].'"  href="javascript:void(0)"">
								<i class="glyphicon glyphicon-trash"></i>
							 </a>
					        </div>
					      </div>
					      
					    </div>
					
				</div>';*/						    						
			}
		?>
	</div>
</div>

	