import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute, Params } from '@angular/router';

import { GLOBAL } from '../services/global';
import { UserService } from '../services/user.service';
import { User } from '../models/user';

@Component({
  selector: 'editar-usuario',
  templateUrl: '../views/editar-usuario.html',
  providers: [UserService]
})

export class UsuarioEditComponent implements OnInit{
	public titulo: string;
	public user: User;
	public identity;
	public token;
	public alertMessage;
	public url: string;

	constructor(
		private _route: ActivatedRoute,
		private _router: Router,
		private _userService: UserService
	){
		this.titulo = 'Actualizar Usuario';
		this.identity = this._userService.getIdentity();
  		this.token = this._userService.getToken();
  		this.user = this.identity;
  		this.url = GLOBAL.url;
  		this.user = new User('','','','','','','');
	}

	ngOnInit(){
		console.log('editar-user.component cargado');

		this.getUsuario();
	}

	getUsuario(){

		if(this.identity.role == 'ROLE_ADMIN'){
			this._route.params.forEach((params: Params) => {
				let idUser = params['idUser'];

				this._userService.getUsuario(this.token, idUser).subscribe(
					response => {

						if(!response){
							this._router.navigate(['/']);
						}else{
							console.log(response);
							this.user.nombre = response.nombre;
							this.user.email = response.email;
							this.user.role = response.role;
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
		console.log(this.user);

			this._route.params.forEach((params: Params) => {
				let idUser = params['idUser'];
				//console.log(this.proyecto);

				let body = {
			      email: this.user.email,
			      nombre: this.user.nombre,
			      role: this.user.role
			    };

				this._userService.updateUsuario(this.token, idUser, body).subscribe(
					response => {

						if(!response){
							this._router.navigate(['/']);
						}else{
							//console.log(response);
							this.alertMessage = 'Miembro actualizado correctamente';
							this._router.navigate(['/ver-usuarios']);
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
}
