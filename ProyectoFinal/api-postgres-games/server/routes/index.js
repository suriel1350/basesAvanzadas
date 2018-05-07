const videojuegosController = require('../controllers').videojuegos;
const accesoriosController = require('../controllers').accesorios;
const ventasController = require('../controllers').ventas;
//const proyectoController = require('../controllers').proyecto;

var md_auth = require('../middlewares/authenticated');

const multipart = require('connect-multiparty');
var md_upload = multipart({uploadDir: './server/uploads/users'});

module.exports = (app) => {
  app.get('/api', (req, res) => res.status(200).send({
    message: 'Welcome to the GamePlanet API Postgres!',
  }));

  app.get('/api/probando-controlador', md_auth.ensureAuth, videojuegosController.pruebas); 

  // Api Routes para videojuegos
  app.post('/api/upload-image-game/:id', [md_auth.ensureAuth, md_upload], videojuegosController.uploadImage);  
  app.post('/api/registrar-videojuego', md_auth.ensureAuth, videojuegosController.saveGame)
  app.get('/api/get-image-game/:imageFile', videojuegosController.getImageFile);  
  app.get('/api/all-videojuegos', md_auth.ensureAuth, videojuegosController.allGames); //Ruta para obtener todos los games
  app.get('/api/videojuego/:idGame', md_auth.ensureAuth, videojuegosController.getGame);  //Ruta para obtener un miembro  
  app.put('/api/update-videojuego/:id', md_auth.ensureAuth, videojuegosController.updateGame);  
  app.delete('/api/eliminar-videojuego/:idGame', md_auth.ensureAuth, videojuegosController.deleteGame);  

  // Api Routes para accesorios
  app.post('/api/upload-image-accesorio/:id', [md_auth.ensureAuth, md_upload], accesoriosController.uploadImage);  
  app.post('/api/registrar-accesorio', md_auth.ensureAuth, accesoriosController.saveAccesorio)
  app.get('/api/get-image-accesorio/:imageFile', accesoriosController.getImageFile);  
  app.get('/api/all-accesorios', md_auth.ensureAuth, accesoriosController.allAccesorios); //Ruta para obtener todos los games
  app.get('/api/accesorio/:idAccesorio', md_auth.ensureAuth, accesoriosController.getAccesorio);  //Ruta para obtener un miembro  
  app.put('/api/update-accesorio/:id', md_auth.ensureAuth, accesoriosController.updateAccesorio);  
  app.delete('/api/eliminar-accesorio/:idAccesorio', md_auth.ensureAuth, accesoriosController.deleteAccesorio);

  //Api Routes para Ventas
  app.post('/api/registrar-venta/:idUser/:nombreUser/:totVenta', md_auth.ensureAuth, ventasController.saveVenta);
  app.get('/api/all-ventas', md_auth.ensureAuth, ventasController.getVentas);
  app.get('/api/ventas-detalle/:idVenta', md_auth.ensureAuth, ventasController.getDetalles);
  app.delete('/api/eliminar-venta/:idVenta', md_auth.ensureAuth, ventasController.deleteVenta);  
};