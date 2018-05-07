import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute, Params } from '@angular/router';

import { GLOBALPOSTGRES } from '../services/globalpostgres';
import { UserService } from '../services/user.service';
import { VideojuegoService } from '../services/videojuego.service';
import { Videojuego } from '../models/videojuego';

@Component({
  selector: 'editar-videojuego',
  templateUrl: '../views/editar-videojuego.html',
  providers: [VideojuegoService, UserService]
})

export class VideojuegoEditComponent implements OnInit{
	public titulo: string;
	public videojuego: Videojuego;
	public identity;
	public token;
	public alertMessage;
	public url: string;

	constructor(
		private _route: ActivatedRoute,
		private _router: Router,
		private _userService: UserService,
    private _videojuegoService: VideojuegoService
	){
		this.titulo = 'Actualizar Videojuego';
		this.identity = this._userService.getIdentity();
  		this.token = this._userService.getToken();
  		this.url = GLOBALPOSTGRES.url;
      this.videojuego = new Videojuego('', '', '', null, null, '');
	}

	ngOnInit(){
		console.log('editar-videojuego.component cargado');

		this.getVideojuego();
	}

	getVideojuego(){

		if(this.identity.role == 'ROLE_ADMIN'){
			this._route.params.forEach((params: Params) => {
				let idVideojuego = params['idVideojuego'];

				this._videojuegoService.getGame(this.token, idVideojuego).subscribe(
					response => {

						if(!response){
							this._router.navigate(['/']);
						}else{
							console.log(response);
							this.videojuego.nombre = response.data.nombre;
							this.videojuego.descripcion = response.data.descripcion;
							this.videojuego.stock = response.data.stock;
              this.videojuego.precio = response.data.precio;
              this.videojuego.imagen = response.data.imagen;
							//this.user.password = response.data.password;
							//this.user.nombre = response[0].nombre;

							//console.log(this.proyecto);
							//console.log(this.auxNombre);
						}
					},
					error => {
						var errorMessage = <any>error;

			  			if(errorMessage != null){
			  				var body = JSON.parse(error._body);
			  				this.alertMessage = body.message;

			  				console.log(error);
			  			}
					}
				);
			});
		}else{
			this.alertMessage = 'Token no valido';
		}
	}

	onSubmit(){
		console.log(this.videojuego);

			this._route.params.forEach((params: Params) => {
				let idVideojuego = params['idVideojuego'];
				//console.log(this.proyecto);

				let body = {
			      nombre: this.videojuego.nombre,
			      descripcion: this.videojuego.descripcion,
			      stock: this.videojuego.stock,
            precio: this.videojuego.precio
			    };

          console.log(idVideojuego);

				this._videojuegoService.updateGame(this.token, idVideojuego, body).subscribe(
					response => {

						if(!response){
							this._router.navigate(['/']);
						}else{
							//console.log(response

              if(!this.filesToUpload){
      						//Redireccion
      					}else{
      						this.makeFileRequest(this.url+'upload-image-game/'+response.id, [], this.filesToUpload).then(
      							(result: any) => {

      							}
      						);
      					}
							this.alertMessage = 'Videojuego actualizada correctamente';
							//this._router.navigate(['/ver-']);
						}
					},
					error => {
						var errorMessage = <any>error;

			  			if(errorMessage != null){
			  				var body = JSON.parse(error._body);
			  				this.alertMessage = body.message;

			  				console.log(error);
			  			}
					}
				);
			});
	}

  public filesToUpload: Array<File>;

  fileChangeEvent(fileInput: any){
    this.filesToUpload = <Array<File>>fileInput.target.files;
    //console.log(this.filesToUpload);
  }

  makeFileRequest(url: string, params: Array<string>, files: Array<File>){
    var token = this.token;

    return new Promise(function(resolve, reject){
      var formData: any = new FormData();
      var xhr = new XMLHttpRequest();

      for(var i = 0; i < files.length; i++){
        formData.append('image', files[i], files[i].name);
      }

      xhr.onreadystatechange = function(){
        if(xhr.readyState == 4){
          if(xhr.status == 200){
            resolve(JSON.parse(xhr.response));
          }else{
            reject(xhr.response);
          }
        }
      }

      xhr.open('POST', url, true);
      xhr.setRequestHeader('Authorization', token);
      xhr.send(formData);
    });
  }
}