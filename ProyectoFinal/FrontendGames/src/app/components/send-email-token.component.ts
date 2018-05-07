import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute, Params } from '@angular/router';

import { GLOBAL } from '../services/global';
import { UserService } from '../services/user.service';
import { TokenToCheck } from '../models/token';

@Component({
  selector: 'ver-usuarios',
  templateUrl: '../views/send-email-token.html',
  providers: [UserService]
})

export class SendEmailTokenComponent implements OnInit{
	public titulo: string;
	public identity;
	public token;
	public url: string;
  public email: string;
	public alertMessage;

	constructor(
		private _route: ActivatedRoute,
		private _router: Router,
		private _userService: UserService
	){
		this.titulo = 'Enviar token por email';
		this.identity = this._userService.getIdentity();
  		this.token = this._userService.getToken();
      this.email = "";
  		this.url = GLOBAL.url;
	}

	ngOnInit(){
		console.log('send-email-token.component cargado');
	}

	enviarToken(){

			if(this.identity.role == 'ROLE_ADMIN'){
        let body = {
          email: this.email
        };

				this._userService.sendTokenEmail(this.token, body).subscribe(
					response => {

						//console.log(response);
	 					this.alertMessage="Se ha enviado un token al email: " + this.email;

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
}
