import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute, Params } from '@angular/router';

import { GLOBALMYSQL } from '../services/globalmysql';
import { UserService } from '../services/user.service';
import { ConsolaService } from '../services/consola.service';
import { AccesorioService } from '../services/accesorio.service';
import { VideojuegoService } from '../services/videojuego.service';
import { CartService } from '../services/cart.service';
import { Detalles } from '../models/detalles';

@Component({
  selector: 'ver-detalles-postgres.html',
  templateUrl: '../views/ver-detalles-postgres.html',
  providers: [UserService, ConsolaService, CartService, AccesorioService, VideojuegoService]
})

export class DetallesPostgresComponent implements OnInit{
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
		private _accesorioService: AccesorioService,
		private _videojuegoService: VideojuegoService
	){
		this.titulo = 'Detalles de venta';
		this.identity = this._userService.getIdentity();
  		this.token = this._userService.getToken();
  		this.url = GLOBALMYSQL.url;
	}

	ngOnInit(){
		console.log('get-details-postgres.component cargado');
    	this.detalle=[];
		this.conseguirDetalles();
	}

	conseguirDetalles(){
		this._route.params.forEach((params: Params) => {
			let idVenta = params['idVenta'];

			this._accesorioService.getDetallesVenta(this.token, idVenta).subscribe(
				response => {
					for (var i in response) {
						
						let aux = new Detalles(response[i].id, response[i].cantidad, response[i].precioventa, '');

						if(response[i].idvideojuegos == null){
							//console.log("idvideo null");
							
							this._accesorioService.getAccesorio(this.token, response[i].idaccesorios).subscribe(
								responseAcces => {
									//console.log(responseAcces);
									aux.nombre = responseAcces.data.nombre;
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

						if(response[i].idaccesorios == null){
							
							this._videojuegoService.getGame(this.token, response[i].idvideojuegos).subscribe(
								responseAcces => {
									//console.log(responseAcces);
									aux.nombre = responseAcces.data.nombre;
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
						this.detalle.push(aux);
						//let aux = new Detalles(response[i].id, response[i].cantidad, response[i].precioventa, response[i].Consola.nombre);
						//this.detalle.push(aux); 
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
