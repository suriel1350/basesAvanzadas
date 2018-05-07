import { Injectable } from '@angular/core';
import { Http, Response, Headers, RequestOptions } from '@angular/http';
import 'rxjs/add/operator/map';
import { Observable } from 'rxjs/Observable';
import { GLOBALPOSTGRES } from './globalpostgres';
import { GLOBALMYSQL } from './globalmysql';
import { GLOBAL } from './global';

import { Consola } from '../models/consola';
import { Accesorio } from '../models/accesorio';
import { Videojuego } from '../models/videojuego';

@Injectable()
export class CartService{
	public identity;
	public token;
	public urlMongo: string;
	public urlPostgres: string;
	public urlMysql: string;
	public consola: Consola[] = [];
	public accesorio: Accesorio[] = [];
	public videojuego: Videojuego[] = [];

	constructor(private _http: Http){
		this.urlMongo = GLOBAL.url;
		this.urlPostgres = GLOBALPOSTGRES.url;
		this.urlMysql = GLOBALMYSQL.url;		
	}	
	
	addItem(token, item_to_cart){
		let params = JSON.stringify(item_to_cart);

		let headers = new Headers({
			'Content-Type':'application/json',
			'Authorization':token
		});

		return this._http.post(this.urlMongo+'save-item-user', params, {headers: headers}).map(res => res.json());
	}

	buscaItem(token, item_to_check){
		let params = JSON.stringify(item_to_check);

		let headers = new Headers({
			'Content-Type':'application/json',
			'Authorization':token
		});

		return this._http.post(this.urlMongo+'busca-item-user', params, {headers: headers}).map(res => res.json());
	}

	updateItem(token, idUs, item_to_update){		

		let params = JSON.stringify(item_to_update);

		let headers = new Headers({
				'Content-Type':'application/json',
				'Authorization': token
			});

		return this._http.put(this.urlMongo+'update-cart-user/'+idUs, params, {headers: headers}).map(res => res.json());	
	}

	getUserItems(token, id){
		let headers = new Headers({
			'Content-Type':'application/json',
			'Authorization':token
		});

		let options = new RequestOptions({ headers: headers });
		return this._http.get(this.urlMongo+'get-user-cart/'+id, options).map(res => res.json());
	}

	deleteItemCart(token, id){
		let headers = new Headers({
			'Content-Type':'application/json',
			'Authorization':token
		});

		let options = new RequestOptions({ headers: headers });
		return this._http.delete(this.urlMongo+'delete-item-cart/'+id, options).map(res => res.json());
	}
}