const consolasController = require('../controllers').consolas;
//const proyectoController = require('../controllers').proyecto;

var md_auth = require('../middlewares/authenticated');

const multipart = require('connect-multiparty');
var md_upload = multipart({uploadDir: './server/uploads/users'});

module.exports = (app) => {
  app.get('/api', (req, res) => res.status(200).send({
    message: 'Welcome to the GamePlanet API Mysql!',
  }));

  app.get('/api/probando-controlador', md_auth.ensureAuth, consolasController.pruebas); 

  // Api Routes para videojuegos
  app.post('/api/upload-image-consola/:id', [md_auth.ensureAuth, md_upload], consolasController.uploadImage);  
  app.post('/api/registrar-consola', md_auth.ensureAuth, consolasController.saveConsola)
  app.get('/api/get-image-consola/:imageFile', consolasController.getImageFile);  
  app.get('/api/all-consolas', md_auth.ensureAuth, consolasController.allConsolas); //Ruta para obtener todos los games
  app.get('/api/consola/:idConsola', md_auth.ensureAuth, consolasController.getConsola);  //Ruta para obtener un miembro  
  app.put('/api/update-consola/:id', md_auth.ensureAuth, consolasController.updateConsola);  
  app.delete('/api/eliminar-consola/:idConsola', md_auth.ensureAuth, consolasController.deleteConsola);    
};