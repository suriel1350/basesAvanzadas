'use strict'

var jwt = require('jwt-simple');
var moment = require('moment');
var secret = 'clave_secreta_email';

exports.ensureAuth = function(tokenToCheck){
	if(!tokenToCheck){
		return 0;
	}

	var token = tokenToCheck.replace(/['"]+/g, '');

	try{
		var payload = jwt.decode(token, secret);
		//var expira = moment().add(120, 'seconds').unix();
		//var expi = moment().add(120, 'seconds').unix();
		
		//console.log(payload);
		//console.log(expi);
		//console.log(moment().unix());
		if(payload.exp <= moment().unix()){
			return 0;
		}
	}catch(ex){
		//console.log(ex);
		return 0;
	}

	//req.user = payload;

	return 1;
};