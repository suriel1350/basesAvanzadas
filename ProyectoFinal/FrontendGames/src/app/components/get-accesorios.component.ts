import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute, Params } from '@angular/router';

import { GLOBALPOSTGRES } from '../services/globalpostgres';
import { UserService } from '../services/user.service';
import { AccesorioService } from '../services/accesorio.service';
import { CartService } from '../services/cart.service';
import { Accesorio } from '../models/accesorio';

@Component({
  selector: 'ver-accesorios', 
  templateUrl: '../views/ver-accesorios.html',
  providers: [UserService, AccesorioService, CartService]
})

export class AccesoriosGetComponent implements OnInit{
	public titulo: string;
	public accesorio: Accesorio[] = [];
	public identity;
	public token;
	public alertMessage;
	public url: string;

	constructor(
		private _route: ActivatedRoute,      
		private _router: Router,
		private _userService: UserService,
		private _accesorioService: AccesorioService,
		private _cartService: CartService
	){
		this.titulo = 'Accesorios disponibles';		
		this.identity = this._userService.getIdentity();
  		this.token = this._userService.getToken();  		
  		this.url = GLOBALPOSTGRES.url;
	}

	ngOnInit(){
		console.log('get-accesorios.component cargado');
		this.accesorio = [];
		this.conseguirAccesorios();
	}

	conseguirAccesorios(){							
		this._accesorioService.getAccesorios(this.token).subscribe(
			response => {											
				
				//console.log(response);
					for (var i in response) {
						//console.log(response[i]);
						this.accesorio.push(response[i]);
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

	eliminarAccesorio(idAcc){
		this._accesorioService.deleteAccesorio(this.token, idAcc).subscribe(
			response => {					
				if(!response){
					this._router.navigate(['/']);
				}else{											
					this.accesorio = [];
					this.conseguirAccesorios();
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
			categoria: 'accesorios',
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