var prueba = new Array();
var stocksIniciales = new Array();
var stocksEnCompra = new Array();
var x;
var nuevoStock = 0;
var contStockCompras = 0;

$(document).ready(function(){	

		var listarray = new Array();
		datosProducto2 = document.getElementById('pidproducto2');				

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

		datosProducto=document.getElementById('pidproducto2').value.split('_');	
		x = document.getElementById("pidproducto2").selectedIndex;	
		prueba[x] = prueba[x] - nuevoStock;
		$("#pprecio_venta2").val(datosProducto[2]);
		$("#pstock2").val(prueba[x]);


	$('#bt_add2').click(function(){
		agregar2();
	});				
});

	var cont = 0;
	total = 0;
	subtotal = [];
	$("#guardar2").hide();
	
	$(document).on('ready',function(){
		$('select[name=pidproducto2]').val(1);
		$('.selectpicker').selectpicker('refresh');
		mostrarValores2();
	});

	$("#pidproducto2").change(function(){
		nuevoStock = 0;
		mostrarValores2();
	});

	function mostrarValores2()
	{
		datosProducto=document.getElementById('pidproducto2').value.split('_');
		x = document.getElementById("pidproducto2").selectedIndex;
		
		$("#pprecio_venta2").val(datosProducto[2]);
		$("#pstock2").val(prueba[x]);
	}

	function agregar2()
	{
		datosProducto=document.getElementById('pidproducto2').value.split('_');

		idproducto = datosProducto[0];
		producto = $("#pidproducto2 option:selected").text();
		cantidad = $("#pcantidad2").val();

		precio_venta = $("#pprecio_venta2").val();
		precio_compra = $("#pprecio_compra").val();
		lugar = $("#pnombreEmpresa").val();
		stock = $("#pstock2").val();

		nuevoStock = stock - cantidad;
		prueba[x] = nuevoStock;

		if(idproducto != "" && cantidad != "" && cantidad > 0 && precio_venta != "" && precio_compra != "" && lugar != "")
		{			
				subtotal[cont] = (cantidad*precio_compra);
				total = total + subtotal[cont];

				var fila = '<tr class="selected" id="fila2' + cont+ '"><td><button type="button" class="btn btn-warning btnEliminar'+x+'" onclick="eliminar('+cont+');">X</button></td><td><input type="hidden" name="idproducto[]" value="'+idproducto+'">'+producto+'</td><td><input type="hidden" name="cantidad[]" id='+cont+' class="' +x+ '" value="'+cantidad+'">'+cantidad+'</td><td><input type="hidden" name="precio_compra[]" value="'+precio_compra+'">'+precio_compra+'</td><td>'+subtotal[cont]+'</td></tr>';
				cont++;
				//stocksEnCompra[x] = cantidad;
				//contStockCompras++;
				limpiar();
				$("#total2").html("$ " + total);
				$("#total_venta2").val(total);
				evaluar2();
				$("#detalles2").append(fila);	
				//$('select[name=pidproducto]').val(1);
    			//$('.selectpicker').selectpicker('refresh')
    			//mostrarValores();
    			$("#pprecio_venta2").val(precio_venta);			
		}
		else
		{
			bootbox.alert("Error. Por favor verifique los campos");			
		}
	}

	function limpiar2()
	{
		$("#pcantidad2").val("");
		$("#pprecio_venta2").val("");
	}

	function evaluar2()
	{
		if(total>0)
		{
			$("#guardar2").show();
		}
		else
		{
			$("#guardar2").hide();
		}
	}

	function eliminar2(index)
	{
		//var cantidadIndice = document.getElementById("cantidadId"+index).value;
		//stocksIniciales[x] = stocksIniciales[x] - cantidadIndice;
		
		var indice = document.getElementById(index).className;
		var valor = document.getElementById(index).value;
		valor = parseInt(valor)

		prueba[indice] = prueba[indice] + valor;

		var inOriginal = document.getElementById("pidproducto2").selectedIndex;

				
		
		total = total-subtotal[index];
		$("#total2").html("$ " + total);
		$("#total_venta2").val(total);
		$("#fila2" + index).remove();
		evaluar2();
	}