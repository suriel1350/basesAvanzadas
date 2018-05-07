import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute, Params } from '@angular/router';

import { GLOBALMYSQL } from '../services/globalmysql';
import { UserService } from '../services/user.service';
import { ConsolaService } from '../services/consola.service';
import { Consola } from '../models/consola';

@Component({
  selector: 'agregar-consola',
  templateUrl: '../views/agregar-consola.html',
  providers: [UserService, ConsolaService]
})

export class AddConsolaComponent implements OnInit{
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
		this.titulo = 'Agregar Consola';
		this.identity = this._userService.getIdentity();
  		this.token = this._userService.getToken();
      this.consola = new Consola("","","",null,null,"");
  		this.url = GLOBALMYSQL.url;
	}

	ngOnInit(){
		console.log('agregar-consola.component cargado');
	}

	crearConsola(){
		if(this.identity.role == 'ROLE_ADMIN'){
				this._consolaService.addConsola(this.token, this.consola).subscribe(
					response => {
            if(!this.filesToUpload){
					//Redireccion
      				}else{
      					this.makeFileRequest(this.url+'upload-image-consola/'+response.id, [], this.filesToUpload).then(
      						(result: any) => {

      						}
      					);
      				}
              this.alertMessage ="Se ha agregado una nueva consola";
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
		}else{
			this.alertMessage = 'Token no valido';
		}
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
