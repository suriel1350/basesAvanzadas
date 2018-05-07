'use strict'

var express = require('express');
var UserController = require('../controllers/user');

var api = express.Router();
var md_auth = require('../middlewares/authenticated');

var multipart = require('connect-multiparty');
var md_upload = multipart({uploadDir: './uploads/users'});

api.get('/probando-controlador', md_auth.ensureAuth, UserController.pruebas);
api.post('/register', UserController.saveUser);
api.post('/register-user', UserController.validarRegistro);

api.post('/send-token', md_auth.ensureAuth, UserController.sendTokenUser);
api.get('/all-users', md_auth.ensureAuth, UserController.getAllUsers);
api.get('/usuarios-registrados', UserController.getUsuariosTotales);
api.get('/usuarios-ya-registrados/:id', md_auth.ensureAuth, UserController.getUsuariosRegistrados);
api.get('/get-usuario/:id', md_auth.ensureAuth, UserController.getUser);
api.delete('/delete-user/:id', md_auth.ensureAuth, UserController.deleteUser);

api.post('/login', UserController.loginUser);
api.put('/update-user/:id', md_auth.ensureAuth, UserController.updateUser);
api.post('/upload-image-user/:id', [md_auth.ensureAuth, md_upload], UserController.uploadImage);
api.get('/get-image-user/:imageFile', UserController.getImageFile);

module.exports = api;