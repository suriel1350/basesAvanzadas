import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute, Params } from '@angular/router';

import { GLOBALMYSQL } from '../services/globalmysql';
import { GLOBALPOSTGRES } from '../services/globalpostgres';

import { ConsolaService } from '../services/consola.service';
import { VideojuegoService } from '../services/videojuego.service';
import { AccesorioService } from '../services/accesorio.service';

import { UserService } from '../services/user.service';
import { CartService } from '../services/cart.service';
import { Consola } from '../models/consola';
import { Accesorio } from '../models/accesorio';
import { Videojuego } from '../models/videojuego';
import { Cart } from '../models/cart';

@Component({
  selector: 'ver-carrito', 
  templateUrl: '../views/ver-carrito.html',
  providers: [UserService, CartService, ConsolaService, VideojuegoService, AccesorioService]
})

export class CarritoGetComponent implements OnInit{
	public titulo: string;
	public consola: Consola[] = [];
	public accesorio: Accesorio[] = [];
	public videojuego: Videojuego[] = [];
	public cart: Cart[] = [];
	public identity;
	public token;
	public alertMessage;
	public urlMysql: string;
	public urlPostgres: string;
	public total: number;
	public auxBoton: number;

	constructor(
		private _route: ActivatedRoute,      
		private _router: Router,
		private _userService: UserService,		
		private _cartService: CartService,
		private _consolaService: ConsolaService,
		private _accesorioService: AccesorioService,
		private _videojuegoService: VideojuegoService
	){
		this.titulo = 'Mi Carrito de compras';		
		this.identity = this._userService.getIdentity();
  		this.token = this._userService.getToken();  		
  		this.urlMysql = GLOBALMYSQL.url;
  		this.urlPostgres = GLOBALPOSTGRES.url;
  		this.total = 0;
  		this.auxBoton = 0;
	}

	ngOnInit(){
		console.log('get-carrito.component cargado');
		
		this.conseguirCarrito();
	}

	conseguirCarrito(){							
		this._cartService.getUserItems(this.token, this.identity._id).subscribe(
			response => {							
				//console.log(response);

					for (var i in response.items) {
						//console.log(response.items[i]);
						//response.items[i].nombre = 'hola';
						var img = response.items[i].imagen;
						if(response.items[i].categoria == 'consolas')
						{							
							response.items[i].imagen = this.urlMysql + 'get-image-consola/' + img;
						}else{
							if(response.items[i].categoria == 'videojuegos')
							{						
								response.items[i].imagen = this.urlPostgres + 'get-image-game/' + img;
							}else{						
								response.items[i].imagen = this.urlPostgres + 'get-image-accesorio/' + img;
							}
						}
						var tot = response.items[i].precio * response.items[i].cantidad;
						this.total = this.total + tot;
						this.cart.push(response.items[i]);
					}
					if(this.total == 0){
						this.auxBoton = 1;
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

	eliminarItem(idItem){
		console.log(idItem);
		this._cartService.deleteItemCart(this.token, idItem).subscribe(
			response => {					
				if(!response){
					this._router.navigate(['/']);
				}else{											
					this.cart = [];
					this.total = 0;
					this.conseguirCarrito();
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

	updateItemAdd(objItemUpdate){
		let body = {
			nombre: objItemUpdate.nombre,
			cantidad: objItemUpdate.cantidad + 1
		};

		this._cartService.updateItem(this.token, this.identity._id, body).subscribe(
			response => {									
				this.cart = [];
				this.total = 0;
				this.conseguirCarrito();
			},
			error => {
				var errorMessage = <any>error;

	  			if(errorMessage != null){
	  				var body = JSON.parse(error._body);
	  				this.alertMessage = body.message;	  				
	  			}
			}
		);
	}

	updateItemDec(objItemUpdate){
		let body = {
			nombre: objItemUpdate.nombre,
			cantidad: objItemUpdate.cantidad - 1
		};

		if(body.cantidad > 0){
			this._cartService.updateItem(this.token, this.identity._id, body).subscribe(
				response => {										
					this.cart = [];
					this.total = 0;
					this.conseguirCarrito();
				},
				error => {
					var errorMessage = <any>error;

		  			if(errorMessage != null){
		  				var body = JSON.parse(error._body);
		  				this.alertMessage = body.message;		  				
		  			}
				}
			);
		}else{
			this.eliminarItem(objItemUpdate._id);
		}
	}

	comprarProductos(objItems, tot){
		this.auxBoton = 1;
		var mysqlAux = 0;
		var postAux = 0;

		for (var i in objItems) {

			if(objItems[i].categoria == 'consolas'){
				this.consola.push(objItems[i]);
				mysqlAux = 1;
			}
			
			if(objItems[i].categoria == 'accesorios' || objItems[i].categoria == 'videojuegos'){
				this.videojuego.push(objItems[i]);
				postAux = 1;
			}
			

		}
		
		if(mysqlAux == 1){
			this._consolaService.createVenta(this.token, this.consola, this.identity._id, this.identity.nombre, this.total).subscribe(
				response => {
					console.log(response);
					//eliminamos los items del carrito
					for (var i in objItems) {
						if(objItems[i].categoria == 'consolas'){
							this.eliminarItem(objItems[i]._id);
						}
					}
				},
				error => {
					var errorMessage = <any>error;

		  			if(errorMessage != null){
		  				var body = JSON.parse(error._body);
		  				this.alertMessage = body.message;		  				
		  			}
				}
			);
		}

		if(postAux == 1){
			this._videojuegoService.createVenta(this.token, this.videojuego, this.identity._id, this.identity.nombre, this.total).subscribe(
				response => {
					console.log(response);
					//eliminamos los items del carrito
					for (var i in objItems) {
						if(objItems[i].categoria == 'accesorios'){
							this.eliminarItem(objItems[i]._id);
						}
						if(objItems[i].categoria == 'videojuegos'){
							this.eliminarItem(objItems[i]._id);
						}
					}
				},
				error => {
					var errorMessage = <any>error;

		  			if(errorMessage != null){
		  				var body = JSON.parse(error._body);
		  				this.alertMessage = body.message;		  				
		  			}
				}
			);
		}

		/*console.log(this.accesorio);		
		console.log(this.videojuego);*/
	}
}