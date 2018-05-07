import { Injectable } from '@angular/core';
import { Http, Response, Headers, RequestOptions } from '@angular/http';
import 'rxjs/add/operator/map';
import { Observable } from 'rxjs/Observable';
import { GLOBALPOSTGRES } from './globalpostgres';

@Injectable()
export class VideojuegoService{
	public identity;
	public token;
	public url: string;

	constructor(private _http: Http){
		this.url = GLOBALPOSTGRES.url;
	}

	getGames(token){
		let headers = new Headers({
			'Content-Type':'application/json',
			'Authorization':token
		});

		let options = new RequestOptions({ headers: headers });
		return this._http.get(this.url+'all-videojuegos', options).map(res => res.json());
	}

	addGame(token, game_to_register){
		let params = JSON.stringify(game_to_register);

		let headers = new Headers({
			'Content-Type':'application/json',
			'Authorization':token
		});

		return this._http.post(this.url+'registrar-videojuego', params, {headers: headers}).map(res => res.json());
	}

	deleteGame(token, id){
		let headers = new Headers({
			'Content-Type':'application/json',
			'Authorization':token
		});

		let options = new RequestOptions({ headers: headers });
		return this._http.delete(this.url+'eliminar-videojuego/'+id, options).map(res => res.json());
	}

	getGame(token, id){
		let headers = new Headers({
			'Content-Type':'application/json',
			'Authorization':token
		});

		let options = new RequestOptions({ headers: headers });
		return this._http.get(this.url+'videojuego/'+id, options).map(res => res.json());
	}

	updateGame(token, id, game_to_update){		

		let params = JSON.stringify(game_to_update);

		let headers = new Headers({
				'Content-Type':'application/json',
				'Authorization': token
			});

		return this._http.put(this.url+'update-videojuego/'+id, params, {headers: headers}).map(res => res.json());	
	}

	createVenta(token, venta_data, idUs, nomb, tot){
		let params = JSON.stringify(venta_data);

		let headers = new Headers({
				'Content-Type':'application/json',
				'Authorization': token
			});

		return this._http.post(this.url+'registrar-venta/'+idUs+'/'+nomb+'/'+tot, params, {headers: headers}).map(res => res.json());	
	}	
}