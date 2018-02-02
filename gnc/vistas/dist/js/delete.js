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
});