import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute, Params } from '@angular/router';

import { GLOBALMYSQL } from '../services/globalmysql';
import { UserService } from '../services/user.service';
import { ConsolaService } from '../services/consola.service';
import { Consola } from '../models/consola';

@Component({
  selector: 'editar-consola',
  templateUrl: '../views/editar-consola.html',
  providers: [ConsolaService, UserService]
})

export class ConsolaEditComponent implements OnInit{
	public titulo: string;
	public consola: Consola;
	public identity;
	public token;
	public alertMessage;
	public url: string;

	constructor(
		private _route: ActivatedRoute,
		private _router: Router,
		private _userService: UserService,
    private _consolaService: ConsolaService
	){
		this.titulo = 'Actualizar Consola';
		this.identity = this._userService.getIdentity();
  		this.token = this._userService.getToken();
  		this.url = GLOBALMYSQL.url;
      this.consola = new Consola('', '', '', null, null, '');
	}

	ngOnInit(){
		console.log('editar-consola.component cargado');

		this.getConsola();
	}

	getConsola(){

		if(this.identity.role == 'ROLE_ADMIN'){
			this._route.params.forEach((params: Params) => {
				let idConsola = params['idConsola'];

				this._consolaService.getConsola(this.token, idConsola).subscribe(
					response => {

						if(!response){
							this._router.navigate(['/']);
						}else{
							console.log(response);
							this.consola.nombre = response.data.nombre;
							this.consola.descripcion = response.data.descripcion;
							this.consola.stock = response.data.stock;
              this.consola.precio = response.data.precio;
              this.consola.imagen = response.data.imagen;
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
		console.log(this.consola);

			this._route.params.forEach((params: Params) => {
				let idConsola = params['idConsola'];
				//console.log(this.proyecto);
				let body = {
			      nombre: this.consola.nombre,
			      descripcion: this.consola.descripcion,
			      stock: this.consola.stock,
            precio: this.consola.precio
			    };

          console.log(idConsola);

				this._consolaService.updateConsola(this.token, idConsola, body).subscribe(
					response => {

						if(!response){
							this._router.navigate(['/']);
						}else{
							//console.log(response
              if(!this.filesToUpload){
      						//Redireccion
      					}else{
      						this.makeFileRequest(this.url+'upload-image-consola/'+response.id, [], this.filesToUpload).then(
      							(result: any) => {

      							}
      						);
      					}
							this.alertMessage = 'Consola actualizada correctamente';
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