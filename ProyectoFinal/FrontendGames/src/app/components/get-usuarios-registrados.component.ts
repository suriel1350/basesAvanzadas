import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute, Params } from '@angular/router';

import { GLOBAL } from '../services/global';
import { UserService } from '../services/user.service';
import { User } from '../models/user';

@Component({
  selector: 'ver-usuarios',
  templateUrl: '../views/ver-usuarios.html',
  providers: [UserService]
})

export class UsuariosGetComponent implements OnInit{
	public titulo: string;
	public user: User[] = [];
	public identity;
	public token;
	public url: string;
	public alertMessage;

	constructor(
		private _route: ActivatedRoute,
		private _router: Router,
		private _userService: UserService
	){
		this.titulo = 'Usuarios registrados';
		this.identity = this._userService.getIdentity();
  		this.token = this._userService.getToken();
  		this.url = GLOBAL.url;
	}

	ngOnInit(){
		console.log('get-usuarios-registrados.component cargado');

		this.conseguirUsuarios();
	}

	conseguirUsuarios(){

			if(this.identity.role == 'ROLE_ADMIN'){
				this._userService.getUsuarios(this.token, this.identity._id).subscribe(
					response => {

						//console.log(response);
	 					for (var i in response) {
	 						//console.log(response[i]);
							this.user.push(response[i]);
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
			}else{
			  	this.alertMessage = 'Token no valido';
			}

	}

	eliminarUsuario(idUs){
		this._userService.deleteUser(this.token, idUs).subscribe(
			response => {
				if(!response){
					this._router.navigate(['/']);
				}else{
					this.user = [];
					this.conseguirUsuarios();
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
	}
}
