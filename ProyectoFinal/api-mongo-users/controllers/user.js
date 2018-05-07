'use strict'
var fs = require('fs');
var path = require('path');
var bcrypt = require('bcrypt-nodejs');
var User = require('../models/user');
var Token = require('../models/token');
var jwt = require('../services/jwt');
var jwtToSend = require('../services/jwtToSend');
var validarToken = require('../middlewares/authenticatedToSend');
var nodemailer = require('nodemailer');

var transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'muelas1350@gmail.com',
    pass: '1995muelas01'
  }
});

function pruebas(req, res){
	res.status(200).send({
		message: 'Probando una accion del controlador de usuarios del api rest con Node y MOngo'
	});
}

function saveUser(req, res){
	var user = new User();
	var params = req.body;

	user.nombre = params.nombre;
	user.email = params.email.toLowerCase(),
	user.role = params.role || 'ROLE_USER';
	user.image = 'null';

	User.findOne({email: user.email.toLowerCase()}, (err, userFound) => {
		if(err){
			res.status(404).send({message: 'Error en la peticion'});
		}else{
			if(!userFound){
				//Aqui ya podemos registrar al usuario
				if(params.password){
					//Encriptar contraeeña y guardar datos
					bcrypt.hash(params.password, null, null, function(err, hash){
						user.password = hash;

						if(user.nombre != null && user.email != null){
							//GUaradar el usuario 
							user.save((err, userStored) => {
								if(err){
									res.status(404).send({message: 'Error al guardar el usuario'});
								}else{
									if(!userStored){
										res.status(404).send({message: 'No se ha registrado el usuario'});
									}else{
										res.status(200).send(userStored);
									}
								}
							});

						}else{
							res.status(500).send({message: 'Rellena todos los campos'});
						}
					});
				}else{
					res.status(404).send({message: 'Introduce un password'});
				}
			}else{
				res.status(404).send({message: 'El email ya existe'});
			}
		}
	});
}

function sendTokenUser(req, res){
	var user = new User();
	var tokenToSend = new Token();
	var params = req.body;

	req.assert('email', 'Email is not valid').isEmail();
  	req.assert('email', 'Email cannot be blank').notEmpty();
  	req.sanitize('email').normalizeEmail({ remove_dots: false });

  	var errors = req.validationErrors();
  	
  	if(errors){ 
  		return res.status(400).send({message: 'Error en el correo'}); 
  	}
	
	if(params.email){
		user.email = params.email.toLowerCase(),
		user.role = 'ROLE_USER';

		User.findOne({email: user.email.toLowerCase()}, (err, userFound) => {
			if(err){
				res.status(404).send({message: 'Error en la peticion'});
			}else{
				if(!userFound){
					user.save((err, userStored) => {
						if(err){
							res.status(404).send({message: 'Error al enviar token al usuario'});
						}else{
							if(!userStored){
								res.status(404).send({message: 'No se ha registrado el usuario'});
							}else{
								/*	Aqui ya se registra al usuario pero ahora necesitamos guardar el token 
									en la tabla de tokens haciendo referencia al id del user */							
								tokenToSend.token = jwtToSend.createToken(user);
								tokenToSend.userId = userStored._id;

								tokenToSend.save((err, tokenStored) => {
									if(err){
										res.status(404).send({message: 'Error al guardar el token'});
									}else{
										if(!tokenStored){
											res.status(404).send({message: 'No se ha guardado el token'});
										}else{
											//res.status(200).send({userPendiente: userStored, tokenInfo: tokenStored});
											var mailOptions = {
											  from: 'muelas1350@gmail.com',
											  to: user.email.toLowerCase(),
											  subject: 'Sending Token using Node.js',
											  text: tokenStored.token
											};

											transporter.sendMail(mailOptions, function(error, info){
											  if (error) {
											    console.log(error);
											  } else {
											    //console.log('Email sent: ' + info.response);
											    res.status(200).send({sent: info.response});
											  }
											});
										}
									}
								});
							}
						}
					});
				}else{
					//El email ya existe por lo que ahora validaremos si ya ha sido verificado
					if(userFound.isVerified){
						//El user ya ha sido verificado
						res.status(404).send({message: 'El user ya ha sido verificado'});
					}else{
						/*	El user no ha sido verificado, por lo que le enviaremos un token
							Esto debido a que en ocasiones el user puede no verificar su cuenta en el tiempo
							que tiene el token, por lo tanto se le envía de nuevo un token para registrarse */
						if(userFound.role == 'ROLE_USER'){
							//Aqui reenviaremos el token al email
							
							var newToken = jwtToSend.createToken(userFound);
							
							Token.findOne({userId: userFound._id}, (err, tokenIsEqual) => {
								if(err){
									res.status(404).send({message: 'Error en la petición'});
								}else{
									if(!tokenIsEqual){
										res.status(404).send({message: 'Error en la petición'});
									}else{
										Token.findByIdAndUpdate(tokenIsEqual._id, {token: newToken}, (err, tokenFound) => {
											if(err){
												res.status(404).send({message: 'Error en la petición'});
											}else{
												if(!tokenFound){
													res.status(404).send({message: 'Error en la petición'});	
												}else{
													var mailOptions = {
													  from: 'muelas1350@gmail.com',
													  to: userFound.email.toLowerCase(),
													  subject: 'Sending Token using Node.js',
													  text: newToken
													};

													transporter.sendMail(mailOptions, function(error, info){
													  if (error) {
													    console.log(error);
													  } else {
													    //console.log('Email sent: ' + info.response);
													    res.status(200).send({message: 'Se ha enviado el token'});
													  }
													});
												}
											}
										});		
									}
								}								
							});					

						}else{
							res.status(404).send({message: 'Eres un admin :O'});
						}
					}
				}
			}
		});
	}else{
		res.status(404).send({message: 'Por favor ingrese un email para enviar un token'});
	}
}

function validarRegistro(req, res){
	var user = new User();
	var tokenToSend = new Token();
	var params = req.body;
	
	if(params.email != "" && params.nombre != "" && params.password != "" && params.token != ""){		

		User.findOne({email: params.email.toLowerCase()}, (err, userFound) => {
			if(err){
				res.status(404).send({message: 'Error en la petición'});	
			}else{
				if(!userFound){
					res.status(404).send({message: 'El email no está registrado'});	
				}else{
					if(userFound.role == 'ROLE_USER'){
						if(!userFound.isVerified){
							Token.findOne({token: params.token, userId: userFound._id}, (err, tokenIsEqual) => {
								if(err){
									res.status(404).send({message: 'Error en la petición'});			
								}else{
									if(!tokenIsEqual){
										res.status(404).send({message: 'Lo sentimos, este token no es tuyo'});	
									}else{
										var resultToken = validarToken.ensureAuth(params.token);
										if(resultToken == 0){
											res.status(404).send({message: 'El token ya expiro, pide al administrador uno nuevo'});	
										}else{
											//El token es válido
											//Encriptar contraeeña y guardar datos
											bcrypt.hash(params.password, null, null, function(err, hash){
												user.password = hash;										
												user.nombre = params.nombre;
												user.email = params.email.toLowerCase();
												user.isVerified = true;

												User.findByIdAndUpdate(userFound._id, {email: params.email.toLowerCase(), nombre: params.nombre, isVerified: true, password: hash}, (err, userRegister) => {
													if(err){
														res.status(404).send({message: 'Error en la petición'});
													}else{
														if(!userRegister){
															res.status(404).send({message: 'No se ha podido realizar tu registro'});
														}else{
															res.status(200).send({userRegister, message: 'Tu registro se ha realizado'});
														}
													}
												});		
											});									
										}
									}
								}
							});
						}else{
							res.status(404).send({message: 'Tu registro ya se ha realizado'});
						}
					}else{
						res.status(404).send({message: 'Eres un administrador'});
					}
				}
			}
		});			
	}else{
		res.status(404).send({message: 'Por favor rellene todos los campos'});
	}	
}

function loginUser(req, res){
	var params = req.body;

	var email = params.email;
	var password = params.password;

	req.assert('email', 'Email is not valid').isEmail();
  	req.assert('email', 'Email cannot be blank').notEmpty();
  	req.sanitize('email').normalizeEmail({ remove_dots: false });

  	var errors = req.validationErrors();
  	
  	if(errors){ 
  		return res.status(400).send({message: 'Error en el correo'}); 
  	}


	User.findOne({email: email.toLowerCase()}, (err, user) => {
		if(err){
			res.status(500).send({message: 'Error en la peticion'});
		}else{
			if(!user){
				res.status(404).send({message: 'El usuario no existe'});			
			}else{

				//comprobar la contraseña
				bcrypt.compare(password, user.password, function(err, check){
					if(check){
						//devolver los datos del usARIO logueado
						if(params.gethash){
							//devolver un token de jwt
							res.status(200).send({
								token: jwt.createToken(user)
							});
						}else{
							res.status(200).send({user});							
						}
					}else{
						res.status(404).send({message: 'El usuario no ha podido loguearse'});						
					}
				});
			}
		}
	});
}

function updateUser(req, res){
	var userId = req.params.id;
	var update = req.body;	
	var params = req.body;
	//var update = new User();	


	if(params.email){
		User.findById(userId, (err, userWithID) => {
			if(err){
				res.status(500).send({message: 'Error al actualizar el usuario'});
			}else{
				if(!userWithID){
					res.status(404).send({message: 'El usuario no existe'});	
				}else{
					//User.findOne({email: {$not: userWithID.email}}, (err, userFound) => {
					if(userWithID.email == params.email.toLowerCase()){
						//Actualizas pero antes checamos password
						if(params.password){
							bcrypt.hash(params.password, null, null, function(err2, hash){
								update.password = hash;

								User.findByIdAndUpdate(userId, update, (err3, userUpdated) => {
									if(err3){
										res.status(500).send({message: 'Error al actualizar el usuario'});
									}else{
										if(!userUpdated){
											res.status(404).send({message: 'No se ha podido actualizar el usuario'});
										}else{
											res.status(200).send({user: userUpdated});
										}
									}
								});
							});
						}else{
							User.findByIdAndUpdate(userId, update, (err2, userUpdated) => {
								if(err2){
									res.status(500).send({message: 'Error al actualizar el usuario'});
								}else{
									if(!userUpdated){
										res.status(404).send({message: 'No se ha podido actualizar el usuario'});
									}else{
										res.status(200).send({user: userUpdated});
									}
								}
							});
						}
					}else{
						//Verficamos si el email existe
						User.findOne({email: params.email.toLowerCase()}, (err2, userFound) => {
							if(err2){
								res.status(500).send({message: 'Error al actualizar el usuario'});
							}else{
								if(!userFound){
									//Si no existe entonces actualizamos pero checamos password
									if(params.password){
										bcrypt.hash(params.password, null, null, function(err3, hash){
											update.password = hash;
											
											User.findByIdAndUpdate(userId, update, (err4, userUpdated) => {
												if(err4){
													res.status(500).send({message: 'Error al actualizar el usuario'});
												}else{
													if(!userUpdated){
														res.status(404).send({message: 'No se ha podido actualizar el usuario'});
													}else{
														res.status(200).send({user: userUpdated});
													}
												}
											});
										});
									}else{
										User.findByIdAndUpdate(userId, update, (err3, userUpdated) => {
											if(err3){
												res.status(500).send({message: 'Error al actualizar el usuario'});
											}else{
												if(!userUpdated){
													res.status(404).send({message: 'No se ha podido actualizar el usuario'});
												}else{
													res.status(200).send({user: userUpdated});
												}
											}
										});
									}
								}else{
									//NO podemos acrualizar si existe el email
									res.status(404).send({message: 'El email ya existe'});
								}
							}
						});
					}
				}
			}
		});
	}else{
		res.status(404).send({message: 'Introduce un email válido'});
	}
}

function deleteUser(req, res){
	var userId = req.params.id;

	User.findByIdAndRemove(userId, (err, userRemoved) => {
		if(err){
			res.status(500).send({message: 'Error al eliminar el user'});
		}else{
			if(!userRemoved){
				res.status(404).send({message: 'El user no ha sido eliminado porque no existe'});				
			}else{
				
				Token.find({userId: userRemoved._id}).remove((err, tokenRemoved) => {
					if(err){
						res.status(500).send({message: 'Error al eliminar el token del user'});
					}else{
						if(!tokenRemoved){
							res.status(404).send({message: 'El token no ha sido eliminado'});				
						}else{									
							res.status(200).send({user: userRemoved, token: tokenRemoved});
						}
					}
				});					

			}
		}
	});		
}

//Este método devuelve solamente los usuarios que estan por registrarse
function getAllUsers(req, res){

	var find = Token.find({}).sort('userId');

	find.populate({path: 'user'}).exec((err, tokensUsers) => {
		if(err){
			res.status(500).send({message: 'Error en la petición'});
		}else{
			if(!tokensUsers){
				res.status(404).send({message: 'No hay tokens ni users!'});
			}else{
				res.status(200).send({tokensUsers});
			}
		}
	});
}

//Devuelve los usuarios que ya han sido registrados
function getUsuariosRegistrados(req, res){
	var userId = req.params.id; 

	//User.findOne({email: {$not: userWithID.email}}, (err, userFound) => {
	User.where("_id").ne(userId).exec((err, users) => {
		if(err){
			res.status(500).send({message: 'Error en la peticion'});
		}else{
			if(!users){
				res.status(404).send({message: 'Aún no se han registrado usuarios'});
			}else{
				res.status(200).send(users);
			}
		}
	});
}

//funcion que devuelve todos los usuarios 
function getUsuariosTotales(req, res){
	
	var page = 1;

	var itemsPerPage = 4;

	User.find().sort('email').exec((err, usuarios) =>{
		if(err){
			res.status(500).send({message: 'Error en la petición'});
		}else{
			if(!usuarios){
				res.status(404).send({message: 'No hay usuarios!!'});
			}else{
				return res.status(200).send({users : usuarios});	
			}
		}
	});
}	

//Obtener Usuario por ID
function getUser(req, res){
	var userId = req.params.id;

	User.findById(userId, (err, userWithID) => {
		if(err){
			res.status(500).send({message: 'Error en la petición'});
		}else{
			if(!userWithID){
				res.status(404).send({message: 'No hay usuario!!'});
			}else{
				return res.status(200).send(userWithID);	
			}
		}
	});
}


function uploadImage(req, res){
	var userId = req.params.id;
	var file_name = 'No subido...';

	if(req.files){
		var file_path = req.files.image.path;
		var file_split = file_path.split('/');
		var file_name = file_split[2];

		var ext_split = file_name.split('\.');
		var file_ext = ext_split[1];

		console.log(file_ext);

		if(file_ext == 'png' || file_ext == 'jpg' || file_ext == 'gif'){

			User.findByIdAndUpdate(userId, {image: file_name}, (err, userUpdated) => {
				if(!userUpdated){
					res.status(404).send({message: 'No se ha podido actualizar el usuario'});										
				}else{
					res.status(200).send({image: file_name, user: userUpdated});
				}
			});
		}else{
			res.status(200).send({message: 'Extensión del archivo no válida'});
		}
	}else{
		res.status(200).send({message: 'No has subido ninguna imagen...'});
	}
}

function getImageFile(req, res){
	var imageFile = req.params.imageFile;
	var path_file = './uploads/users/'+imageFile;
	fs.exists(path_file, function(exists){
		if(exists){
			res.sendFile(path.resolve(path_file));
		}else{
			res.status(200).send({message: 'No existe la imagen'});
		}
	});
}

module.exports = {
	pruebas,
	saveUser,
	loginUser, 
	updateUser,
	uploadImage, 
	getImageFile,
	sendTokenUser,
	deleteUser,
	getAllUsers,
	validarRegistro,
	getUsuariosTotales,
	getUsuariosRegistrados,
	getUser
};