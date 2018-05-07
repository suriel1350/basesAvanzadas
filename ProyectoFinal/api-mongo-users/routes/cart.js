'use strict'

var express = require('express');
var CartController = require('../controllers/cart');

var api = express.Router();
var md_auth = require('../middlewares/authenticated');

var multipart = require('connect-multiparty');

api.post('/busca-item-user', md_auth.ensureAuth, CartController.buscaItemUser);
api.post('/save-item-user', md_auth.ensureAuth, CartController.saveItem);
api.put('/update-cart-user/:idUser', md_auth.ensureAuth, CartController.updateCartItem);
api.get('/get-user-cart/:idUser', md_auth.ensureAuth, CartController.getCartItemsByUser);
api.delete('/delete-item-cart/:idCart', md_auth.ensureAuth, CartController.deleteCartItem);
/*api.post('/register-user', UserController.validarRegistro);

api.post('/send-token', md_auth.ensureAuth, UserController.sendTokenUser);
api.get('/all-users', md_auth.ensureAuth, UserController.getAllUsers);
api.get('/usuarios-registrados', UserController.getUsuariosTotales);
api.get('/get-usuario/:id', md_auth.ensureAuth, UserController.getUser);

api.post('/login', UserController.loginUser);*/

module.exports = api;