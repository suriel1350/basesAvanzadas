import { Injectable } from '@angular/core';
import { Http, Response, Headers, RequestOptions } from '@angular/http';
import 'rxjs/add/operator/map';
import { Observable } from 'rxjs/Observable';
import { GLOBALPOSTGRES } from './globalpostgres';

@Injectable()
export class AccesorioService{
	public identity;
	public token;
	public url: string;

	constructor(private _http: Http){
		this.url = GLOBALPOSTGRES.url;
	}

	getAccesorios(token){
		let headers = new Headers({
			'Content-Type':'application/json',
			'Authorization':token
		});

		let options = new RequestOptions({ headers: headers });
		return this._http.get(this.url+'all-accesorios', options).map(res => res.json());
	}

	addAccesorio(token, accesorio_to_register){
		let params = JSON.stringify(accesorio_to_register);

		let headers = new Headers({
			'Content-Type':'application/json',
			'Authorization':token
		});

		return this._http.post(this.url+'registrar-accesorio', params, {headers: headers}).map(res => res.json());
	}

	deleteAccesorio(token, id){
		let headers = new Headers({
			'Content-Type':'application/json',
			'Authorization':token
		});

		let options = new RequestOptions({ headers: headers });
		return this._http.delete(this.url+'eliminar-accesorio/'+id, options).map(res => res.json());
	}

	getAccesorio(token, id){
		let headers = new Headers({
			'Content-Type':'application/json',
			'Authorization':token
		});

		let options = new RequestOptions({ headers: headers });
		return this._http.get(this.url+'accesorio/'+id, options).map(res => res.json());
	}

	updateAccesorio(token, id, accesorio_to_update){		

		let params = JSON.stringify(accesorio_to_update);

		let headers = new Headers({
				'Content-Type':'application/json',
				'Authorization': token
			});

		return this._http.put(this.url+'update-accesorio/'+id, params, {headers: headers}).map(res => res.json());	
	}

	getVentas(token){
		let headers = new Headers({
				'Content-Type':'application/json',
				'Authorization': token
			});

    	let options = new RequestOptions({ headers: headers });
		return this._http.get(this.url+'all-ventas/', options).map(res => res.json());	
	}

	eliminarVenta(token, id){
		let headers = new Headers({
				'Content-Type':'application/json',
				'Authorization': token
			});

    	let options = new RequestOptions({ headers: headers });
		return this._http.delete(this.url+'eliminar-venta/'+id, options).map(res => res.json());
	}

	getDetallesVenta(token, id){
    	let headers = new Headers({
				'Content-Type':'application/json',
				'Authorization': token
			});

    	let options = new RequestOptions({ headers: headers });
		return this._http.get(this.url+'ventas-detalle/'+id, options).map(res => res.json());
  	}
}