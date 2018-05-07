import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute, Params } from '@angular/router';

import { GLOBALPOSTGRES } from '../services/globalpostgres';
import { UserService } from '../services/user.service';
import { VideojuegoService } from '../services/videojuego.service';
import { CartService } from '../services/cart.service';
import { Videojuego } from '../models/videojuego';

@Component({
  selector: 'ver-videojuegos', 
  templateUrl: '../views/ver-videojuegos.html',
  providers: [UserService, VideojuegoService, CartService]
})

export class VideojuegosGetComponent implements OnInit{
	public titulo: string;
	public game: Videojuego[] = [];
	public identity;
	public token;
	public alertMessage;
	public url: string;

	constructor(
		private _route: ActivatedRoute,      
		private _router: Router,
		private _userService: UserService,
		private _videojuegoService: VideojuegoService,
		private _cartService: CartService
	){
		this.titulo = 'Videojuegos disponibles';		
		this.identity = this._userService.getIdentity();
  		this.token = this._userService.getToken();  		
  		this.url = GLOBALPOSTGRES.url;
	}

	ngOnInit(){
		console.log('get-videojuegos.component cargado');
		this.game = [];
		this.conseguirGames();
	}

	conseguirGames(){							
		this._videojuegoService.getGames(this.token).subscribe(
			response => {											
				
				//console.log(response);
					for (var i in response) {
						//console.log(response[i]);
						this.game.push(response[i]);
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

	eliminarGame(idGam){
		this._videojuegoService.deleteGame(this.token, idGam).subscribe(
			response => {					
				if(!response){
					this._router.navigate(['/']);
				}else{											
					this.game = [];
					this.conseguirGames();
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

	checkItemCart(nombre, idUs, item){
		let body = {		      
	      nombre: nombre,
	      idUser: idUs
	    }; 

		this._cartService.buscaItem(this.token, body).subscribe(
			response => {					
				//console.log(response.itemUser);		
				//
				this.updateItemCart(response.itemUser);

			},
			error => {
				var errorMessage = <any>error;

	  			if(errorMessage != null){
	  				var body = JSON.parse(error._body);
	  				//this.alertMessage = body.message;	  				
	  				this.addItemtoCart(item);
	  				//console.log(error);
	  			}
			}
		);
	}

	updateItemCart(objItemUpdate){
		let body = {
			nombre: objItemUpdate.nombre,
			cantidad: objItemUpdate.cantidad + 1
		};

		this._cartService.updateItem(this.token, this.identity._id, body).subscribe(
			response => {					
				console.log(response);		
				this.alertMessage = 'Se ha añadido otro ' + objItemUpdate.nombre + ' al carrito' ;
			},
			error => {
				var errorMessage = <any>error;

	  			if(errorMessage != null){
	  				var body = JSON.parse(error._body);
	  				this.alertMessage = body.message;
	  				//this.alertMessage = 'Se ha agregado un nuevo item al carrito';
	  				//this.addItemtoCart(item);
	  				//console.log(error);
	  			}
			}
		);
	}

	addItemtoCart(objItem){
		let body = {
			nombre: objItem.nombre,
			categoria: 'videojuegos',
			descripcion: objItem.descripcion,
			cantidad: 1,
			id: objItem.id,
			precio: objItem.precio,
			imagen: objItem.imagen,
			userId: this.identity._id
		};

		//console.log(body);
		this._cartService.addItem(this.token, body).subscribe(
			response => {					
				//console.log(response);		
				this.alertMessage = 'Se ha agregado un nuevo item al carrito';
			},
			error => {
				var errorMessage = <any>error;

	  			if(errorMessage != null){
	  				var body = JSON.parse(error._body);
	  				this.alertMessage = body.message;
	  				//this.alertMessage = 'Se ha agregado un nuevo item al carrito';
	  				//this.addItemtoCart(item);
	  				//console.log(error);
	  			}
			}
		);
	}
}