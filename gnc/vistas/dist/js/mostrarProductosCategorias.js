$(document).ready(function(){
	$('.mostrar-productos-categorias').click(function(e){
		e.preventDefault();
		var categoriaid = $(this).attr('data-categoria-id');
		var nombre = $(this).attr('data-nombre-id');		
		var parent = $(this).parent("td").parent("tr");
		
		$.ajax({
			type: 'POST',
			url: 'vistas/getProductosCategorias.php',
			data: 'delete='+categoriaid
		})
		.done(function(response){
			//bootbox.alert(response);
			//parent.fadeOut('slow');
			var dataa = $.parseJSON(response);
			var cantidades = new Array();
			var precio_ventas = new Array();
			var productos = new Array();
			var total;
			var myTableProductos =  "<table class='table table-striped table-hover'>" +
                                "  <thead>"+
                                "    <tr>"+                                                                
                                "      <th class='text-center'>Producto</th>" +                              
                                "    </tr>" +
                                "  </thead>" +
                                "  <tbody>";
			

			$.each(dataa, function(i, item) {
			    //console.log(item.cantidad);		

			    myTableProductos += "<tr>" +                                       
                                    "   <td class='text-center'>" + item.nombre + "</td>" +                                    
                                    "</tr>";  


			});

			myTableProductos += "</tbody>" +
                            "</table>";
			
          	bootbox.dialog({
				message: myTableProductos,
				title: "Productos en categoria " + nombre,			
			});			
		})
		.fail(function(){
			bootbox.alert('Error....');
			})							
		
	});
});