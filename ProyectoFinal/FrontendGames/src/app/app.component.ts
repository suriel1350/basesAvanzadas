import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute, Params } from '@angular/router';

import { GLOBAL } from './services/global';
import { UserService } from './services/user.service';
import { User } from './models/user';
import { TokenToCheck } from './models/token';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  providers: [UserService]
})
export class AppComponent implements OnInit{
  public title = 'Games';
  public user: User;
  public user_register: User;
  public identity;
  public token;
  public tokenreg: TokenToCheck;
  public errorMessage;
  public alertRegister;
  public url: string;

  constructor(
    private _route: ActivatedRoute,
    private _router: Router,
    private _userService: UserService
  ){
  	this.user = new User('','','','','','','');
  	this.user_register = new User('','','','','','','');
    this.url = GLOBAL.url;
    this.tokenreg = new TokenToCheck('');
  }

  ngOnInit(){
  	this.identity = this._userService.getIdentity();
  	this.token = this._userService.getToken();

  	console.log(this.identity);
  	console.log(this.token);
  }

  public onSubmit(){
  	//console.log(this.user);
    localStorage.setItem('contrasenia', this.user.password);
  	//Conseguir los datos del usuario identificado
  	this._userService.signup(this.user).subscribe(
  		response => {
  			let identity = response.user;
        console.log(response.user);
  			this.identity = identity;

  			if(!this.identity._id){
  				alert("El usuario no está correctamente identificado");
  			}else{
  				// Crear elemento en el local Storage para tener al usuario sesión
  				localStorage.setItem('identity', JSON.stringify(identity));

  				//Conseguir el token para enviarlo a cada peticion http 

  				this._userService.signup(this.user, 'true').subscribe(
			  		response => {
			  			let token = response.token;
			  			this.token = token;

			  			if(this.token.length <= 0){
			  				alert("El token no se ha generado");
			  			}else{
			  				// Crear elemento en el local Storage para tener token disponible
  							localStorage.setItem('token', token);
  							this.user = new User('','','','','','','');
                this._router.navigate(['inicio']);                	
			  			}
			  		},
			  		error => {
			  			var errorMessage = <any>error;

			  			if(errorMessage!=null){
			  				var body = JSON.parse(error._body);
			  				this.errorMessage = body.message;
			  				console.log(error);
			  			}
			  		}
			  	);
  			}
  		},
  		error => {
  			var errorMessage = <any>error;

  			if(errorMessage!=null){
  				var body = JSON.parse(error._body);
  				this.errorMessage = body.message;
  				console.log(error);
  			}
  		}
  	);
  }

  logout(){
  	localStorage.removeItem('identity');
    localStorage.removeItem('token');
  	localStorage.removeItem('contrasenia');
  	localStorage.clear();
  	this.identity = null;
  	this.token = null;
    this._router.navigate(['/']);
  }

  onSubmitRegister(){
  	console.log(this.user_register);
    console.log(this.tokenreg);

    let body = {
      email: this.user_register.email,
      nombre: this.user_register.nombre,
      password: this.user_register.password,
      token: this.tokenreg.tokentocheck     
    };

  	this._userService.validarRegister(body).subscribe(
	  	response => {
	  		
	  			this.alertRegister = 'El registro se ha realizado correctamente, identificate con ' + this.user_register.email;
  				this.user_register = new User('','','','','','','');	  				
	  		
	  	},
	  	error => {
  			var errorMessage = <any>error;

  			if(errorMessage!=null){
  				var body = JSON.parse(error._body);
  				this.alertRegister = body.message;
  				console.log(error);
  			}
  		}
  	);
  }

}
