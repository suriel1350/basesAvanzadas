import { Injectable } from '@angular/core';
import { Http, Response, Headers, RequestOptions } from '@angular/http';
import 'rxjs/add/operator/map';
import { Observable } from 'rxjs/Observable';
import { GLOBALMYSQL } from './globalmysql';

@Injectable()
export class ConsolaService{
	public identity;
	public token;
	public url: string;

	constructor(private _http: Http){
		this.url = GLOBALMYSQL.url;
	}

  getConsolas(token){
    let headers = new Headers({
				'Content-Type':'application/json',
				'Authorization': token
			});

    let options = new RequestOptions({ headers: headers });
		return this._http.get(this.url+'all-consolas/', options).map(res => res.json());
  }

  getConsola(token, id){
    let headers = new Headers({
				'Content-Type':'application/json',
				'Authorization': token
			});

    let options = new RequestOptions({ headers: headers });
		return this._http.get(this.url+'consola/'+id, options).map(res => res.json());
  }

  addConsola(token, consola_para_registrar){

		let params = JSON.stringify(consola_para_registrar);
    let headers = new Headers({
				'Content-Type':'application/json',
				'Authorization': token
			});

    return this._http.post(this.url+'registrar-consola', params, {headers: headers}).map(res => res.json());
  }

  deleteConsola(token, id){
    let headers = new Headers({
				'Content-Type':'application/json',
				'Authorization': token
			});

    let options = new RequestOptions({ headers: headers });
		return this._http.delete(this.url+'eliminar-consola/'+id, options).map(res => res.json());
  }

  updateConsola(token, id, consola_to_update){
    let params = JSON.stringify(consola_to_update);
    let headers = new Headers({
				'Content-Type':'application/json',
				'Authorization': token
			});

    return this._http.put(this.url+'update-consola/'+id, params, {headers: headers}).map(res => res.json());
  }

  createVenta(token, venta_data, idUs, nomb, tot){
		let params = JSON.stringify(venta_data);

		let headers = new Headers({
				'Content-Type':'application/json',
				'Authorization': token
			});

		return this._http.post(this.url+'registrar-venta/'+idUs+'/'+nomb+'/'+tot, params, {headers: headers}).map(res => res.json());	
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
