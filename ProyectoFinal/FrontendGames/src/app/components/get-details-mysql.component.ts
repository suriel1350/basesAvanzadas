import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute, Params } from '@angular/router';

import { GLOBALMYSQL } from '../services/globalmysql';
import { UserService } from '../services/user.service';
import { ConsolaService } from '../services/consola.service';
import { AccesorioService } from '../services/accesorio.service';
import { CartService } from '../services/cart.service';
import { Detalles } from '../models/detalles';

@Component({
  selector: 'ver-detalles-mysql.html',
  templateUrl: '../views/ver-detalles-mysql.html',
  providers: [UserService, ConsolaService, CartService, AccesorioService]
})

export class DetallesMysqlComponent implements OnInit{
	public titulo: string;
  	public detalle: Detalles[]=[];
	public identity;
	public token;
	public url: string;
	public alertMessage;

	constructor(
		private _route: ActivatedRoute,
		private _router: Router,
		private _userService: UserService,
		private _consolaService: ConsolaService,
		private _cartService: CartService,
		private _accesorioService: AccesorioService
	){
		this.titulo = 'Detalles de venta';
		this.identity = this._userService.getIdentity();
  		this.token = this._userService.getToken();
  		this.url = GLOBALMYSQL.url;
	}

	ngOnInit(){
		console.log('get-details-mysql.component cargado');
    	this.detalle=[];
		this.conseguirDetalles();
	}

	conseguirDetalles(){
		this._route.params.forEach((params: Params) => {
			let idVenta = params['idVenta'];

			this._consolaService.getDetallesVenta(this.token, idVenta).subscribe(
				response => {
					//console.log(response);	
					for (var i in response) {
						
						let aux = new Detalles(response[i].id, response[i].cantidad, response[i].precioventa, response[i].Consola.nombre);
						this.detalle.push(aux);
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
