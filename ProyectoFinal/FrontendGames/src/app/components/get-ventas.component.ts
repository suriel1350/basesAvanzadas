import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute, Params } from '@angular/router';

import { GLOBALMYSQL } from '../services/globalmysql';
import { UserService } from '../services/user.service';
import { ConsolaService } from '../services/consola.service';
import { AccesorioService } from '../services/accesorio.service';
import { CartService } from '../services/cart.service';
import { Venta } from '../models/venta';

@Component({
  selector: 'ver-ventas',
  templateUrl: '../views/ver-ventas.html',
  providers: [UserService, ConsolaService, CartService, AccesorioService]
})

export class VentasComponent implements OnInit{
	public titulo: string;
  	public venta: Venta[]=[];
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
		this.titulo = 'Ventas realizadas';
		this.identity = this._userService.getIdentity();
  		this.token = this._userService.getToken();
  		this.url = GLOBALMYSQL.url;
	}

	ngOnInit(){
		console.log('get-ventas.component cargado');
    	this.venta=[];
		this.conseguirVentas();
	}

	conseguirVentas(){

			if(this.identity.role == 'ROLE_ADMIN'){
				this._consolaService.getVentas(this.token).subscribe(
					response => {

						
	 					for (var i in response) {
	 						
	 						let aux = new Venta(response[i].id, response[i].idusuario, response[i].cliente, response[i].totalventa, response[i].createdAt, 'consolas');
							this.venta.push(aux);
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

				this._accesorioService.getVentas(this.token).subscribe(
					response => {

						//console.log(response);
	 					for (var i in response) {
	 						//console.log(response[i].idventas.);
	 						let aux = new Venta(response[i].id, response[i].idusuario, response[i].cliente, response[i].totalventa, response[i].createdAt, 'postgres');
							this.venta.push(aux);
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

	detallesVenta(venObj){
		if(venObj.categoria == 'consolas'){
			this._router.navigate(['detalles-venta-consola',venObj.id]);	
		}

		if(venObj.categoria == 'postgres'){
			this._router.navigate(['detalles-venta-post',venObj.id]);	
		}
	}

	eliminarVenta(venObj){
		if(venObj.categoria == 'consolas'){
			//venta en consolas			
			this._consolaService.eliminarVenta(this.token, venObj.id).subscribe(
				response => {
					if(!response){
						this._router.navigate(['/']);
					}else{
						this.venta = [];
						this.conseguirVentas();
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

		if(venObj.categoria == 'postgres'){
			//venta en consolas			
			this._accesorioService.eliminarVenta(this.token, venObj.id).subscribe(
				response => {
					if(!response){
						this._router.navigate(['/']);
					}else{
						this.venta = [];
						this.conseguirVentas();
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
}
