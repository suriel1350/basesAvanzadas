import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute, Params } from '@angular/router';

import { GLOBALMYSQL } from '../services/globalmysql';
import { UserService } from '../services/user.service';
import { ConsolaService } from '../services/consola.service';
import { CartService } from '../services/cart.service';
import { Consola } from '../models/consola';

@Component({
  selector: 'ver-consolas',
  templateUrl: '../views/ver-consolas.html',
  providers: [UserService, ConsolaService, CartService]
})

export class ConsolaComponent implements OnInit{
	public titulo: string;
  public consola: Consola[]=[];
	public identity;
	public token;
	public url: string;
	public alertMessage;

	constructor(
		private _route: ActivatedRoute,
		private _router: Router,
		private _userService: UserService,
		private _consolaService: ConsolaService,
		private _cartService: CartService
	){
		this.titulo = 'Consolas disponibles';
		this.identity = this._userService.getIdentity();
  		this.token = this._userService.getToken();
  		this.url = GLOBALMYSQL.url;
	}

	ngOnInit(){
		console.log('ver-consolas.component cargado');
    this.consola=[];
		this.conseguirConsolas();
	}

	conseguirConsolas(){

			
				this._consolaService.getConsolas(this.token).subscribe(
					response => {

						//console.log(response);
	 					for (var i in response) {
	 						//console.log(response[i]);
							this.consola.push(response[i]);
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

	eliminarConsola(idCons){
		this._consolaService.deleteConsola(this.token, idCons).subscribe(
			response => {
				if(!response){
					this._router.navigate(['/']);
				}else{
					this.consola = [];
					this.conseguirConsolas();
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
			categoria: 'consolas',
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
