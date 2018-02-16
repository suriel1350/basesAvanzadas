$(document).ready(function(){
	$('.show-detalles').click(function(e){
		e.preventDefault();
		var ventaid = $(this).attr('data-detalles-id');
		var parent = $(this).parent("td").parent("tr");
		
		$.ajax({
			type: 'POST',
			url: 'vistas/detalles.php',
			data: 'delete='+ventaid
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
                                "      <th class='text-center'>Cantidad</th>" +       
                                "      <th class='text-center'>Precio Venta</th>" +
                                "      <th class='text-center'>Producto</th>" +
                                "      <th class='text-center'>Total</th>" +                                 
                                "    </tr>" +
                                "  </thead>" +
                                "  <tbody>";
			

			$.each(dataa, function(i, item) {
			    //console.log(item.cantidad);		
			    total = parseInt(item.cantidad) * parseInt(item.precio_venta);


			    myTableProductos +=      "<tr>" +                                                                        
                                    "   <td class='text-center'>" + item.cantidad + "</td>" +                                       
                                    "   <td class='text-center'>" + item.precio_venta + "</td>" +
                                    "   <td class='text-center'>" + item.nombre + "</td>" + 
                                    "   <td class='text-primary text-center'>$ "+ total +"</td>" +
                                    "</tr>";  


			});

			myTableProductos += "</tbody>" +
                            "</table>";
			
          	bootbox.dialog({
				message: myTableProductos,
				title: "Detalle de la Venta",			
			});			
		})
		.fail(function(){
			bootbox.alert('Error....');
			})							
		
	});
});