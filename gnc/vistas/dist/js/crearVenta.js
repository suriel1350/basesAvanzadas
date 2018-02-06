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
			/*$.each(dataa, function(i, item) {
			    console.log(item.cantidad);
			});*/
			localStorage.setItem("datos", dataa.cantidad);
			console.log(localStorage.datos['cantidad']);
		})
		.fail(function(){
			bootbox.alert('Error....');
			})							
		
	});
});