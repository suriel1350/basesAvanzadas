import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute, Params } from '@angular/router';

import { GLOBALPOSTGRES } from '../services/globalpostgres';
import { UserService } from '../services/user.service';
import { AccesorioService } from '../services/accesorio.service';
import { Accesorio } from '../models/accesorio';

@Component({
  selector: 'editar-accesorio',
  templateUrl: '../views/editar-accesorio.html',
  providers: [AccesorioService, UserService]
})

export class AccesorioEditComponent implements OnInit{
	public titulo: string;
	public accesorio: Accesorio;
	public identity;
	public token;
	public alertMessage;
	public url: string;

	constructor(
		private _route: ActivatedRoute,
		private _router: Router,
		private _userService: UserService,
    private _accesorioService: AccesorioService
	){
		this.titulo = 'Actualizar Accesorio';
		this.identity = this._userService.getIdentity();
  		this.token = this._userService.getToken();
  		this.url = GLOBALPOSTGRES.url;
      this.accesorio = new Accesorio('', '', '', null, null, '');
	}

	ngOnInit(){
		console.log('editar-accesorio.component cargado');

		this.getAccesorio();
	}

	getAccesorio(){

		if(this.identity.role == 'ROLE_ADMIN'){
			this._route.params.forEach((params: Params) => {
				let idAccesorio = params['idAccesorio'];

				this._accesorioService.getAccesorio(this.token, idAccesorio).subscribe(
					response => {

						if(!response){
							this._router.navigate(['/']);
						}else{
							console.log(response);
							this.accesorio.nombre = response.data.nombre;
							this.accesorio.descripcion = response.data.descripcion;
							this.accesorio.stock = response.data.stock;
              this.accesorio.precio = response.data.precio;
              this.accesorio.imagen = response.data.imagen;
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
		console.log(this.accesorio);

			this._route.params.forEach((params: Params) => {
				let idAccesorio = params['idAccesorio'];
				//console.log(this.proyecto);

				let body = {
			      nombre: this.accesorio.nombre,
			      descripcion: this.accesorio.descripcion,
			      stock: this.accesorio.stock,
            precio: this.accesorio.precio
			    };

          console.log(idAccesorio);

				this._accesorioService.updateAccesorio(this.token, idAccesorio, body).subscribe(
					response => {

						if(!response){
							this._router.navigate(['/']);
						}else{
							//console.log(response

              if(!this.filesToUpload){
      						//Redireccion
      					}else{
      						this.makeFileRequest(this.url+'upload-image-accesorio/'+response.id, [], this.filesToUpload).then(
      							(result: any) => {

      							}
      						);
      					}
							this.alertMessage = 'Accesorio actualizada correctamente';
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