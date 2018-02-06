var prueba = new Array();
var stocksIniciales = new Array();
var stocksEnCompra = new Array();
var x;
var nuevoStock = 0;
var contStockCompras = 0;

$(document).ready(function(){
	$('.delete_student').click(function(e){
		e.preventDefault();
		var studentid = $(this).attr('data-student-id');
		var parent = $(this).parent("td").parent("tr");
		bootbox.dialog({
			message: "¿Estás seguro que quieres eliminar el producto?",
			title: "<i class='glyphicon glyphicon-trash'></i> Delete !",
			buttons: {
				success: {
					label: "No",
					className: "btn-success",
					callback: function() {
						$('.bootbox').modal('hide');
						}
						},
						danger: {
							label: "Delete!",
							className: "btn-danger",
							callback: function() {
								$.ajax({
									type: 'POST',
									url: 'vistas/deleteproducto.php',
									data: 'delete='+studentid
								})
								.done(function(response){
									//bootbox.alert(response);
									//parent.fadeOut('slow');
									window.location.reload();
								})
								.fail(function(){
									bootbox.alert('Error....');
									})
							}
						}
				}
		});
	});

		

		var listarray = new Array();
		datosProducto2=document.getElementById('pidproducto');				

		for(var i = 0; i < datosProducto2.options.length; i++){
		   listarray.push(datosProducto2.options[i].value);
		// 	prueba.push(listarray[i].split('_'));
		}

		for(var i = 0; i < datosProducto2.options.length; i++){
			dato =  listarray[i].split('_')			
			prueba.push(dato[1]);
			stocksIniciales.push(dato[1]);
		}
		//prueba =  listarray[1].split('_')
		//console.log(prueba[0]); Primer elemento

		datosProducto=document.getElementById('pidproducto').value.split('_');	
		x = document.getElementById("pidproducto").selectedIndex;	
		prueba[x] = prueba[x] - nuevoStock;
		$("#pprecio_venta").val(datosProducto[2]);
		$("#pstock").val(prueba[x]);


	$('#bt_add').click(function(){
		agregar();
	});				
});

	var cont = 0;
	total = 0;
	subtotal = [];
	$("#guardar").hide();
	
	$(document).on('ready',function(){
		$('select[name=pidproducto]').val(1);
		$('.selectpicker').selectpicker('refresh');
		mostrarValores();
	});

	$("#pidproducto").change(function(){
		nuevoStock = 0;
		mostrarValores();
	});

	function mostrarValores()
	{
		datosProducto=document.getElementById('pidproducto').value.split('_');
		x = document.getElementById("pidproducto").selectedIndex;
		
		$("#pprecio_venta").val(datosProducto[2]);
		$("#pstock").val(prueba[x]);
	}

	function agregar()
	{
		

		datosProducto=document.getElementById('pidproducto').value.split('_');

		idproducto = datosProducto[0];
		producto = $("#pidproducto option:selected").text();
		cantidad = $("#pcantidad").val();

		precio_venta = $("#pprecio_venta").val();
		stock = $("#pstock").val();

		nuevoStock = stock - cantidad;
		prueba[x] = nuevoStock;

		if(idproducto != "" && cantidad != "" && cantidad > 0 && precio_venta != "")
		{
			if(Number(stock) >= Number(cantidad) )
			{
				subtotal[cont] = (cantidad*precio_venta);
				total = total + subtotal[cont];

				var fila = '<tr class="selected" id="fila' + cont+ '"><td><button type="button" class="btn btn-warning btnEliminar'+x+'" onclick="eliminar('+cont+');">X</button></td><td><input type="hidden" name="idproducto[]" value="'+idproducto+'">'+producto+'</td><td><input type="hidden" name="cantidad[]" id='+cont+' class="' +x+ '" value="'+cantidad+'">'+cantidad+'</td><td><input type="hidden" name="precio_venta[]" value="'+precio_venta+'">'+precio_venta+'</td><td>'+subtotal[cont]+'</td></tr>';
				cont++;
				//stocksEnCompra[x] = cantidad;
				//contStockCompras++;
				limpiar();
				$("#total").html("$ " + total);
				$("#total_venta").val(total);
				evaluar();
				$("#detalles").append(fila);	
				//$('select[name=pidproducto]').val(1);
    			//$('.selectpicker').selectpicker('refresh')
    			//mostrarValores();
    			$("#pstock").val(nuevoStock);
    			$("#pprecio_venta").val(precio_venta);
			}
			else
			{
				bootbox.alert('La cantidad a vender supera el stock');
			}
			
		}
		else
		{
			bootbox.alert("Error. Por favor ingrese una cantidad de productos");			
		}
	}

	function limpiar()
	{
		$("#pcantidad").val("");
		$("#pprecio_venta").val("");
	}

	function evaluar()
	{
		if(total>0)
		{
			$("#guardar").show();
		}
		else
		{
			$("#guardar").hide();
		}
	}

	function eliminar(index)
	{
		//var cantidadIndice = document.getElementById("cantidadId"+index).value;
		//stocksIniciales[x] = stocksIniciales[x] - cantidadIndice;
		
		var indice = document.getElementById(index).className;
		var valor = document.getElementById(index).value;
		valor = parseInt(valor)

		prueba[indice] = prueba[indice] + valor;

		var inOriginal = document.getElementById("pidproducto").selectedIndex;

		if(inOriginal == indice)
			$("#pstock").val(prueba[indice]);			
		
		total = total-subtotal[index];
		$("#total").html("$ " + total);
		$("#total_venta").val(total);
		$("#fila" + index).remove();
		evaluar();
	}