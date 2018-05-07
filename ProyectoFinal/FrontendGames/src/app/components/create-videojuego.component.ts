import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute, Params } from '@angular/router';

import { GLOBALPOSTGRES } from '../services/globalpostgres';
import { UserService } from '../services/user.service';
import { VideojuegoService } from '../services/videojuego.service';
import { Videojuego } from '../models/videojuego';

@Component({
	selector: 'create-videojuego',
	templateUrl: '../views/create-videojuego.html',
	providers: [UserService, VideojuegoService]
})

export class VideojuegoCreateComponent implements OnInit{
	public titulo: string;
	public game: Videojuego;
	public identity;
	public token;
	public url: string;
	public alertMessage;

	constructor(
		private _route: ActivatedRoute,
		private _router: Router,
		private _userService: UserService,
		private _videojuegoService: VideojuegoService
	){
		this.titulo = 'Agregar nuevo videojuego';
		this.identity = this._userService.getIdentity();
		this.token = this._userService.getToken();
		this.url = GLOBALPOSTGRES.url;
		this.game = new Videojuego('','','',null,null,'');
	}

	ngOnInit(){
		console.log('create-videojuego.component cargado');
	}

	onSubmit(){
		//this.proyecto
		console.log(this.game);
		
		this._videojuegoService.addGame(this.token, this.game).subscribe(
			response => {
										
				
					//this.proyecto = response.artist;
					
				//console.log(response);
				if(!this.filesToUpload){
					//Redireccion 
				}else{
					this.makeFileRequest(this.url+'upload-image-game/'+response.id, [], this.filesToUpload).then(
						(result: any) => {
							
							//this.game.imagen = result.image;
							//localStorage.setItem('identity', JSON.stringify(this.user));

							//let image_path = this.url + 'get-image-user/' + this.user.image;
							//document.getElementById("image-logged").setAttribute('src', image_path);
						}
					);
				}

				this.alertMessage = '¡El Videojuego se ha creado correctamente!';
				//this._router.navigate(['/ver-videojuegos']);

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