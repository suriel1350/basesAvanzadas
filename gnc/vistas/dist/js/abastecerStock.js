$(document).ready(function(){
	$('.update-stock').click(function(e){
		e.preventDefault();
		var ventaid = $(this).attr('data-producto-id');
		var stock = $(this).attr('data-stocks');

		var parent = $(this).parent("td").parent("tr");
		
		$.ajax({
			type: 'POST',
			url: 'vistas/ordenesStock.php',
			data: {'delete': ventaid, 'stock': stock}
		})
		.done(function(response){
			//bootbox.alert(response);
			//parent.fadeOut('slow');
			window.location.reload();          	
		})
		.fail(function(){
			bootbox.alert('Error....');
			})							
		
	});
});