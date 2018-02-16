-- MySQL dump 10.13  Distrib 5.7.20, for Linux (x86_64)
--
-- Host: localhost    Database: gnc_suplementos
-- ------------------------------------------------------
-- Server version	5.7.20-0ubuntu0.17.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoria` (
  `idcategoria` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `descripcion` varchar(256) DEFAULT NULL,
  `condicion` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idcategoria`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Aminoacido','Formula 8:1:1',1),(2,'Vitamina','Compuestos heterogéneos imprescindibles para la vida',1),(3,'Proteinas','A base de aislado de suero de leche, una proteína de un alto valor biológico',1),(4,'Aminoacidos','Sustancias básicas para conformar las proteínas, y ambos, proteínas y aminoácidos, resultan ser los sostenes esenciales de la vida',1),(5,'CLA','El Ácido Linoleico Conjugado, también conocido como CLA, es un ácido graso esencial indicado en dietas de control de peso y de definición muscular.',1),(6,'Accesorios','Encuentra lo que necesites para hacer de tu entrenamiento más divertido',1),(7,'Barras','Gracias a su aporte calórico natural, ayuda a diferentes procesos metabolicos del cuerpo ',0),(8,'Proteinas Cero Carbs','Proteinas totalmente sin carbohidratos si buscas definición musculas',1),(9,'Creatina','Ayudan a la generación de músculo sufrido durante el entrenamiento',0),(10,'Oxido','Eleva tu energía para que des todo en el entrenamiento',1),(11,'Omegas','Vitaminas esenciales durante el día en tus comidas',1);
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente` (
  `idcliente` int(11) NOT NULL,
  `idsucursal` int(11) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `direccion` varchar(256) DEFAULT NULL,
  `telefono` bigint(20) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `estado` varchar(30) DEFAULT NULL,
  `pais` varchar(30) DEFAULT NULL,
  `condicion` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idcliente`),
  KEY `idsucursal` (`idsucursal`),
  CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`idsucursal`) REFERENCES `sucursal` (`idsucursal`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,1,'Fernando Castillo Cosme','Libertad #5947, San Baltazar Lindavista',2228526256,'fcastillocosme@gmail.com','Puebla','Mexico',1),(2,2,'Suriel Asael Rosas Mendez','Av. Emiliano Zapata #3004',2228424853,'surielar@gmail.com','Veracruz','Mexico',1),(3,3,'Ernesto Ramirez Sayago','14 Sur #1109',2228526267,'ramsay@gmail.com','Tampico','Mexico',1),(4,4,'Monica Perez Martin','Zavaleta #9908',2228547836,'mmartin@gmail.com','Veracruz','Mexico',1),(5,5,'Rafael Antonio Comonfort Viveros','Atlixcayotl #2255',8846896745,'comonfortr@gmail.com','Puebla','Mexico',1),(6,1,'Carlos Amador Ramirez','Lindavista #4566',2220864792,'ramcarl@gmail.com','Puebla','Mexico',1),(7,7,'Francisco Alberto Ramirez Augusto','Las Hadas #4445',2226463892,'ramaugfran@gmail.com','Puebla','Mexico',1),(8,8,'Alfredo Gutierrez Garcia','Xicotencatl #556',2229758493,'gugaalf@gmail.com','Tlaxcala','Mexico',1),(9,9,'Jose Ricardo Aguilar Cosme','Anzures #440',2229859312,'jaguilar@gmail.com','Monterrey','Mexico',1),(10,10,'Mabel Ayala Herrera','Priv. Lomas #4654',2224097869,'mabeayher@gmail.com','Mexico','Mexico',1),(11,2,'Maria Fernanda Alvarado Torres','Campeche #990',3338728475,'mafert@gmail.com','Chihuahua','Mexico',1),(12,2,'Diana Esther Castillo Cosme','Libertad #5947',2224353637,'esthercastillo@gmail.com','Puebla','Mexico',1);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compra`
--

DROP TABLE IF EXISTS `compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compra` (
  `idcompra` int(11) NOT NULL AUTO_INCREMENT,
  `idcliente` int(11) DEFAULT NULL,
  `idsucursal` int(11) DEFAULT NULL,
  `idempleado` int(11) DEFAULT NULL,
  `fecha_hora` datetime DEFAULT NULL,
  `total_compra` decimal(11,3) DEFAULT NULL,
  `empresa_compra` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`idcompra`),
  KEY `idcliente` (`idcliente`),
  KEY `idsucursal` (`idsucursal`),
  KEY `idempleado` (`idempleado`),
  CONSTRAINT `compra_ibfk_1` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idcliente`),
  CONSTRAINT `compra_ibfk_2` FOREIGN KEY (`idsucursal`) REFERENCES `sucursal` (`idsucursal`),
  CONSTRAINT `compra_ibfk_3` FOREIGN KEY (`idempleado`) REFERENCES `empleado` (`idempleado`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra`
--

LOCK TABLES `compra` WRITE;
/*!40000 ALTER TABLE `compra` DISABLE KEYS */;
INSERT INTO `compra` VALUES (1,1,1,1,'2018-02-15 19:51:39',8000.000,'Strength FIT'),(2,1,1,1,'2018-02-15 19:56:00',9000.000,'Bull Dog');
/*!40000 ALTER TABLE `compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_compra`
--

DROP TABLE IF EXISTS `detalle_compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detalle_compra` (
  `iddetallecompra` int(11) NOT NULL AUTO_INCREMENT,
  `idcompra` int(11) DEFAULT NULL,
  `idproducto` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precio_compra` decimal(11,3) DEFAULT NULL,
  `descuento` decimal(11,3) DEFAULT NULL,
  `impuesto` decimal(11,3) DEFAULT NULL,
  PRIMARY KEY (`iddetallecompra`),
  KEY `idcompra` (`idcompra`),
  KEY `idproducto` (`idproducto`),
  CONSTRAINT `detalle_compra_ibfk_1` FOREIGN KEY (`idcompra`) REFERENCES `compra` (`idcompra`),
  CONSTRAINT `detalle_compra_ibfk_2` FOREIGN KEY (`idproducto`) REFERENCES `producto` (`idproducto`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_compra`
--

LOCK TABLES `detalle_compra` WRITE;
/*!40000 ALTER TABLE `detalle_compra` DISABLE KEYS */;
INSERT INTO `detalle_compra` VALUES (1,1,1,10,800.000,0.000,16.000),(2,2,1,10,900.000,0.000,16.000);
/*!40000 ALTER TABLE `detalle_compra` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_updStockCompra` AFTER INSERT ON `detalle_compra` FOR EACH ROW BEGIN
UPDATE producto SET stock = stock + NEW.cantidad
WHERE producto.idproducto = NEW.idproducto;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `detalle_venta`
--

DROP TABLE IF EXISTS `detalle_venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detalle_venta` (
  `iddetalleventa` int(11) NOT NULL AUTO_INCREMENT,
  `idventa` int(11) DEFAULT NULL,
  `idproducto` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precio_venta` decimal(11,3) DEFAULT NULL,
  `descuento` decimal(11,3) DEFAULT NULL,
  `impuesto` decimal(11,3) DEFAULT NULL,
  PRIMARY KEY (`iddetalleventa`),
  KEY `idventa` (`idventa`),
  KEY `idproducto` (`idproducto`),
  CONSTRAINT `detalle_venta_ibfk_1` FOREIGN KEY (`idventa`) REFERENCES `venta` (`idventa`),
  CONSTRAINT `detalle_venta_ibfk_2` FOREIGN KEY (`idproducto`) REFERENCES `producto` (`idproducto`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_venta`
--

LOCK TABLES `detalle_venta` WRITE;
/*!40000 ALTER TABLE `detalle_venta` DISABLE KEYS */;
INSERT INTO `detalle_venta` VALUES (56,56,4,2,89.000,0.000,16.000),(57,57,3,2,145.000,0.000,16.000),(58,58,1,10,980.000,0.000,16.000),(59,59,1,10,980.000,0.000,16.000),(60,60,2,30,1024.000,0.000,16.000),(62,62,3,98,145.000,0.000,16.000),(67,67,4,16,89.000,0.000,16.000),(68,68,6,2,78.000,0.000,16.000),(69,69,6,43,78.000,0.000,16.000),(70,70,7,3,178.000,0.000,16.000),(71,71,7,2,178.000,0.000,16.000),(72,72,7,30,178.000,0.000,16.000),(73,73,7,10,178.000,0.000,16.000),(74,74,7,7,178.000,0.000,16.000),(75,74,7,3,178.000,0.000,16.000),(76,75,7,10,178.000,0.000,16.000),(77,76,14,10,789.000,0.000,16.000),(78,77,8,2,567.000,0.000,16.000),(79,78,8,2,567.000,0.000,16.000),(80,80,8,2,567.000,0.000,16.000),(81,81,8,2,567.000,0.000,16.000),(82,82,8,2,567.000,0.000,16.000),(83,83,8,2,567.000,0.000,16.000),(84,84,8,2,567.000,0.000,16.000),(85,85,8,2,567.000,0.000,16.000),(86,86,8,2,567.000,0.000,16.000),(87,87,8,1,567.000,0.000,16.000),(88,88,8,1,567.000,0.000,16.000),(89,89,8,1,567.000,0.000,16.000),(90,97,8,1,567.000,0.000,16.000),(91,98,8,1,567.000,0.000,16.000),(92,99,8,1,567.000,0.000,16.000),(93,100,8,2,567.000,0.000,16.000),(94,101,8,1,567.000,0.000,16.000),(95,102,8,1,567.000,0.000,16.000),(96,103,8,1,567.000,0.000,16.000),(97,104,8,1,567.000,0.000,16.000),(98,105,17,1,200.000,0.000,56.000),(99,106,8,10,567.000,0.000,16.000),(100,107,8,5,567.000,0.000,16.000),(101,108,8,5,567.000,0.000,16.000),(102,109,14,20,789.000,0.000,16.000),(103,110,14,10,789.000,0.000,16.000),(104,111,11,20,400.000,0.000,16.000),(105,112,11,10,400.000,0.000,16.000),(106,114,9,40,567.000,0.000,16.000),(107,116,10,30,457.000,0.000,16.000),(108,118,12,40,700.000,0.000,16.000),(109,119,4,2,89.000,0.000,16.000),(110,120,1,10,980.000,0.000,16.000),(111,121,4,2,89.000,0.000,16.000),(112,122,19,35,400.000,0.000,16.000),(113,123,4,10,89.000,0.000,16.000),(114,124,4,10,89.000,0.000,16.000),(115,125,21,78,390.000,0.000,16.000),(116,126,4,36,89.000,0.000,16.000),(117,130,13,15,800.000,0.000,16.000);
/*!40000 ALTER TABLE `detalle_venta` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_updStockVenta` AFTER INSERT ON `detalle_venta` FOR EACH ROW BEGIN
UPDATE producto SET stock = stock - NEW.cantidad
WHERE producto.idproducto = NEW.idproducto;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_ordProductos` AFTER INSERT ON `detalle_venta` FOR EACH ROW BEGIN
IF (select producto.stock from producto where producto.idproducto = NEW.idproducto) = 0 THEN
INSERT INTO purchaseOrders(idproducto, product_name, products_ordered, products_in_stock, date_time_of_order, estado) values (NEW.idproducto, (select p.nombre from producto p where p.idproducto = NEW.idproducto), (select p.ordenar from producto p where p.idproducto = NEW.idproducto), (select p.stock from producto p where p.idproducto = NEW.idproducto), NOW(), "Pendiente");
END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `devoluciones`
--

DROP TABLE IF EXISTS `devoluciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devoluciones` (
  `iddevoluciones` int(11) NOT NULL,
  `idproducto` int(11) DEFAULT NULL,
  `idcliente` int(11) DEFAULT NULL,
  `razones` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`iddevoluciones`),
  KEY `idproducto` (`idproducto`),
  KEY `idcliente` (`idcliente`),
  CONSTRAINT `devoluciones_ibfk_1` FOREIGN KEY (`idproducto`) REFERENCES `producto` (`idproducto`),
  CONSTRAINT `devoluciones_ibfk_2` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idcliente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devoluciones`
--

LOCK TABLES `devoluciones` WRITE;
/*!40000 ALTER TABLE `devoluciones` DISABLE KEYS */;
INSERT INTO `devoluciones` VALUES (1,6,9,'No cumplio mis extectativas '),(2,7,6,'El producto venía abierto'),(3,7,1,'La Mochila venía con una abertura'),(4,7,6,'La mochila no era la de la imagen en el sistema'),(5,7,9,'La mochila venía rota'),(6,4,7,'La barra ya estaba caducada'),(7,6,5,'El sabor de la barra era otro'),(8,2,9,'El frasco ya venía abierto'),(9,2,5,'La proteína era de otro sabor'),(10,3,4,'Las vitaminas ya estaban caducadas');
/*!40000 ALTER TABLE `devoluciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleado`
--

DROP TABLE IF EXISTS `empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empleado` (
  `idempleado` int(11) NOT NULL,
  `idsucursal` int(11) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `apellidos` varchar(50) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `rfc` varchar(50) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `estado` varchar(30) DEFAULT NULL,
  `pais` varchar(30) DEFAULT NULL,
  `imagen` varchar(30) DEFAULT NULL,
  `condicion` tinyint(1) DEFAULT NULL,
  `fecha_ingreso` date DEFAULT NULL,
  `puesto` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idempleado`),
  KEY `idsucursal` (`idsucursal`),
  CONSTRAINT `empleado_ibfk_1` FOREIGN KEY (`idsucursal`) REFERENCES `sucursal` (`idsucursal`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleado`
--

LOCK TABLES `empleado` WRITE;
/*!40000 ALTER TABLE `empleado` DISABLE KEYS */;
INSERT INTO `empleado` VALUES (1,7,'Juan','Lopez','juanlopez@juanlopez.com','1995-03-23','CUPU800825569','Blvd. Juarez #345','Puebla','Mexico',NULL,1,'2018-01-01','Gerente'),(2,5,'Armando','Torres Paz','armando@armando.com','1989-12-23','ARTP800825569','Prolongacion Benito Juarez # 45','Veracruz','Mexico',NULL,1,'2017-09-04','Gerente'),(3,1,'Miguel','Lopez Cruz','miguel@miguel.com','1978-02-24','MLPR800825569','Blvd. Atlixcayotl #234','Puebla','Mexico',NULL,1,'2016-06-14','Empleado'),(4,4,'Diana','Cruz Martinez','diana@diana.com','1990-03-30','DCMA900825569','Av las torres #456','Puebla','Mexico',NULL,1,'2015-09-17','Empleado'),(5,6,'Karen','Lopez Muñoz','karen@karen.com','1987-09-19','KLMU800825569','Gustavo A Madero #34','Morelos','Mexico',NULL,1,'2018-01-10','Gerente'),(6,7,'Ana','Sanchez Martinez','ana@ana.com','1990-12-29','ASMA800825569','Calle Bugambilias #45','Veracruz','Mexico',NULL,1,'2016-08-27','Empleado'),(7,9,'Carlos','Sanchez Lopez','carlos@carlos.com','1995-07-19','CSLO800825569','Penn Station #29','Nueva York','USA',NULL,1,'2015-08-19','Empleado'),(8,8,'Gustavo','Cruz Sanchez','tavo@tavo.com','1987-01-28','GCSA800825569','Penn Station #89','Nueva York','USA',NULL,1,'2017-04-20','Gerente'),(9,10,'Liz','Paz Paz','liz@liz.com','1994-02-27','LPPA800825569','Av las torres #45','Puebla','Mexico',NULL,1,'2017-09-27','Gerente'),(10,8,'Marcos','Diaz Diaz','marcos@marcos.com','1995-10-29','MDDI800825569','Av Concepcion la Cruz #2123','Puebla ','Mexico',NULL,1,'2014-09-27','Empleado'),(11,2,'Ana','Cid Cid','ana@ana.com','1993-09-25','ACCI800825569','Av Emiliano Zapata','Veracruz','Mexico',NULL,1,'2016-11-11','Empleado');
/*!40000 ALTER TABLE `empleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facturacion`
--

DROP TABLE IF EXISTS `facturacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facturacion` (
  `idfacturacion` int(11) NOT NULL,
  `idventa` int(11) DEFAULT NULL,
  `idcliente` int(11) DEFAULT NULL,
  `idempleado` int(11) DEFAULT NULL,
  `total` decimal(11,3) DEFAULT NULL,
  `fecha_facturacion` datetime DEFAULT NULL,
  `idsucursal` int(11) DEFAULT NULL,
  PRIMARY KEY (`idfacturacion`),
  KEY `idcliente` (`idcliente`),
  KEY `idempleado` (`idempleado`),
  KEY `idsucursal` (`idsucursal`),
  KEY `idventa` (`idventa`),
  CONSTRAINT `facturacion_ibfk_2` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idcliente`),
  CONSTRAINT `facturacion_ibfk_3` FOREIGN KEY (`idempleado`) REFERENCES `empleado` (`idempleado`),
  CONSTRAINT `facturacion_ibfk_4` FOREIGN KEY (`idsucursal`) REFERENCES `sucursal` (`idsucursal`),
  CONSTRAINT `facturacion_ibfk_5` FOREIGN KEY (`idventa`) REFERENCES `venta` (`idventa`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facturacion`
--

LOCK TABLES `facturacion` WRITE;
/*!40000 ALTER TABLE `facturacion` DISABLE KEYS */;
INSERT INTO `facturacion` VALUES (1,1,1,3,1000.000,'2017-10-02 10:00:00',2),(2,2,2,3,5000.000,'2018-01-01 11:00:00',2),(3,3,3,3,4000.000,'2017-09-05 14:00:00',2),(4,4,4,6,3500.000,'2018-01-09 13:00:00',5),(5,5,7,9,4600.000,'2018-01-02 10:00:00',5),(6,6,12,6,3500.000,'2017-08-07 14:00:00',5),(7,7,7,2,780.000,'2017-07-11 14:00:00',5),(8,8,8,8,3400.000,'2016-09-08 00:00:00',9),(9,9,4,6,789.000,'2018-01-08 10:00:00',5),(10,10,4,10,500.000,'2018-01-11 15:00:00',5);
/*!40000 ALTER TABLE `facturacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `membresia`
--

DROP TABLE IF EXISTS `membresia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `membresia` (
  `idmembresia` int(11) NOT NULL,
  `idcliente` int(11) DEFAULT NULL,
  `idsucursal` int(11) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_final` date DEFAULT NULL,
  `tipo_membresia` varchar(100) DEFAULT NULL,
  `beneficios` varchar(100) DEFAULT NULL,
  `foto_cliente` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idmembresia`),
  KEY `idcliente` (`idcliente`),
  KEY `idsucursal` (`idsucursal`),
  CONSTRAINT `membresia_ibfk_1` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idcliente`),
  CONSTRAINT `membresia_ibfk_2` FOREIGN KEY (`idsucursal`) REFERENCES `sucursal` (`idsucursal`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membresia`
--

LOCK TABLES `membresia` WRITE;
/*!40000 ALTER TABLE `membresia` DISABLE KEYS */;
INSERT INTO `membresia` VALUES (1,1,3,'2018-01-01','2019-01-01','GOLD CARD','20% de descuento. 2DO al 50% de descuento del 1 al 7 de cada mes.',NULL),(2,2,3,'2017-06-14','2018-06-14','GOLD CARD','20% de descuento. 2DO al 50% de descuento del 1 al 7 de cada mes.',NULL),(3,3,3,'2017-05-08','2018-05-08','GOLD CARD','20% de descuento. 2DO al 50% de descuento del 1 al 7 de cada mes.',NULL),(4,4,1,'2017-04-11','2018-04-11','GOLD CARD','20% de descuento. 2DO al 50% de descuento del 1 al 7 de cada mes.',NULL),(5,5,2,'2017-11-06','2018-11-06','GOLD CARD','20% de descuento. 2DO al 50% de descuento del 1 al 7 de cada mes.',NULL),(6,6,2,'2017-11-06','2018-11-06','GOLD CARD','20% de descuento. 2DO al 50% de descuento del 1 al 7 de cada mes.',NULL),(7,7,4,'2017-08-20','2018-08-20','GOLD CARD','20% de descuento. 2DO al 50% de descuento del 1 al 7 de cada mes.',NULL),(8,8,5,'2017-07-31','2018-08-31','GOLD CARD','20% de descuento. 2DO al 50% de descuento del 1 al 7 de cada mes.',NULL),(9,9,6,'2018-01-02','2019-01-02','GOLD CARD','20% de descuento. 2DO al 50% de descuento del 1 al 7 de cada mes.',NULL),(10,10,7,'2017-12-01','2018-12-01','GOLD CARD','20% de descuento. 2DO al 50% de descuento del 1 al 7 de cada mes.',NULL);
/*!40000 ALTER TABLE `membresia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedido` (
  `idpedido` int(11) NOT NULL,
  `idcliente` int(11) DEFAULT NULL,
  `idproducto` int(11) DEFAULT NULL,
  `num_pedido` int(11) DEFAULT NULL,
  `fecha_pedido` datetime DEFAULT NULL,
  `condicion` tinyint(1) DEFAULT NULL,
  `direccion` varchar(30) DEFAULT NULL,
  `estado` varchar(30) DEFAULT NULL,
  `pais` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idpedido`),
  KEY `idcliente` (`idcliente`),
  KEY `idproducto` (`idproducto`),
  CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idcliente`),
  CONSTRAINT `pedido_ibfk_2` FOREIGN KEY (`idproducto`) REFERENCES `producto` (`idproducto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES (1,1,1,1,'2017-07-04 13:00:00',1,'Libertad #5947','Puebla','Mexico'),(2,2,2,2,'2017-11-07 14:00:00',1,'Margaritas #8880','Veracruz','Mexico'),(3,3,3,3,'2018-01-01 10:00:00',1,'Zavaleta #778','Puebla','Mexico'),(4,4,4,4,'2018-01-25 10:00:00',0,'Priv. Heroes #332','Puebla','Mexico'),(5,5,6,5,'2018-01-04 08:00:00',1,'Xicotencatl #440','Puebla','Mexico'),(6,6,6,6,'2018-01-17 16:00:00',1,'Limas #550','Tlaxcala','Mexico'),(7,7,7,7,'2018-01-23 17:00:00',0,'Atlixcayotl #2250','Monterrey','Mexico'),(8,8,8,8,'2018-01-24 18:00:00',0,'Zavaleta #770','Mexico','Mexico'),(9,9,9,9,'2018-01-25 08:00:00',0,'14 Sur #1330','Chihuahua','Mexico'),(10,10,10,10,'2018-01-04 14:00:00',1,'Villas de Atlixco #440','Puebla','Mexico');
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `producto` (
  `idproducto` int(11) NOT NULL,
  `idsucursal` int(11) DEFAULT NULL,
  `idcategoria` int(11) DEFAULT NULL,
  `idproveedor` int(11) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `precio` decimal(11,3) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `descripcion` varchar(256) DEFAULT NULL,
  `imagen` varchar(100) DEFAULT NULL,
  `condicion` tinyint(1) DEFAULT NULL,
  `ordenar` int(11) DEFAULT NULL,
  PRIMARY KEY (`idproducto`),
  KEY `idcategoria` (`idcategoria`),
  KEY `idsucursal` (`idsucursal`),
  KEY `idproveedor` (`idproveedor`),
  CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`idcategoria`) REFERENCES `categoria` (`idcategoria`),
  CONSTRAINT `producto_ibfk_2` FOREIGN KEY (`idsucursal`) REFERENCES `sucursal` (`idsucursal`),
  CONSTRAINT `producto_ibfk_3` FOREIGN KEY (`idproveedor`) REFERENCES `proveedor` (`idproveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES (1,2,3,4,0,980.000,'Gold Standard Whey','Proteina de Suero de Leche','vistas/img/productos/whey.png',1,60),(2,8,3,3,0,1024.000,'MP Muscle','Proteina de suero de leche sabor chocolate','vistas/img/productos/mpmuscle.png',1,60),(3,4,2,1,0,145.000,'Vitamina C','Frasco con 180 Capsulas','vistas/img/productos/vitaminac.jpg',1,60),(4,5,7,8,0,89.000,'Barra Avena','Mezcla de chocolate, avena y proteina','vistas/img/productos/avenabarra.png',1,60),(6,7,7,2,60,78.000,'Barra Quinoa','Exquisita mezcla de quinoa, avena y Splenda','vistas/img/productos/barraquinoa.png',1,60),(7,2,6,3,60,178.000,'Mochila 3 en 1','Lleva tus comidas, shakers y pastillas','vistas/img/productos/mochila.png',1,60),(8,6,6,3,0,567.000,'Faja reductora','Para quemar esos kilos de mas','vistas/img/productos/faja.jpg',1,60),(9,9,11,2,0,567.000,'Diablo Power Oxido','Para hacer de tu entrenamiento mas duradero y sin cansancio','vistas/img/productos/oxido.png',1,60),(10,4,10,6,0,457.000,'Omega 3','Ideal antes del cardio para quemar mas calorias','vistas/img/productos/omega3.png',1,60),(11,1,1,1,0,400.000,'Ganador Masa','Eleva tu nivel de masa muscular','vistas/img/productos/ganador.png',1,60),(12,1,2,1,0,700.000,'Proteína Isolate','Con un buen porcentaje de carbohidratos','vistas/img/productos/isolate.png',1,60),(13,1,1,1,14,800.000,'Quemadores de grasa','Para reducir tu porcentaje de grasa corporal','vistas/img/productos/quemador.jpg',1,60),(14,1,1,1,0,789.000,'Quemador Arnold','Motívate con el quemador del famoso Arnold','vistas/img/productos/quemador-arnold.png',1,60),(15,1,1,1,38,200.000,'Quemador BPI','El mejor quemador de la región','vistas/img/productos/bpi-quemador.png',1,60),(16,1,1,2,47,300.000,'Sudadera para entrenar','Para motivarte al 100','vistas/img/productos/sudadera.png',1,60),(17,1,1,1,55,200.000,'Mancuerna 2kg','Para bombear ese bicep','vistas/img/productos/mancuerna.png',1,60),(18,1,1,1,67,389.000,'Barra Pecho','Para que entrenes como los grandes','vistas/img/productos/barra.jpg',1,60),(19,1,1,1,0,400.000,'Glutamina','Para el entrenamiento','vistas/img/productos/glutamina.png',1,60),(20,1,1,1,57,390.000,'Glutamina DNA','Para fortalecer los músculos durante el entreno','vistas/img/productos/glutamina-dna.png',1,60),(21,1,1,1,0,390.000,'Galletas Avena POWER','Recupera esos carbos','vistas/img/productos/galletas-power.png',1,60);
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedor` (
  `idproveedor` int(11) NOT NULL,
  `idsucursal` int(11) DEFAULT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `direccion` varchar(250) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `estado` varchar(30) DEFAULT NULL,
  `pais` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idproveedor`),
  KEY `idsucursal` (`idsucursal`),
  CONSTRAINT `proveedor_ibfk_1` FOREIGN KEY (`idsucursal`) REFERENCES `sucursal` (`idsucursal`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES (1,3,'Juan Lopez','Av Emiliano Zapata #200','juan@juan.com','Puebla','Mexico'),(2,4,'Marcos JImenez','Blvd 5 Mayo #450','marcos@marcos.com','Veracruz','Mexico'),(3,3,'Michell Muñoz','Av las torres #590','michell@michell.com','Puebla','Mexico'),(4,8,'Pedro Lopez','Av Juarez #245','pedro@pedro.com','Morelos','Mexico'),(5,8,'Andres Juarez','Prolongacion Galeana #245','andres@andres.com','Veracruz','Mexico'),(6,4,'suriel rosas','Av Concepcion la cruz #226','suriel@suriel.com','Puebla','Mexico'),(7,1,'Asael Mendez','Blvd. Atlixcayotl #2343','asael@asael.com','Morelos','Mexico'),(8,2,'Mike Johnson','Penn Station #234','mike@mike.com','Nueva York','USA'),(9,2,'Lucas Freeman','Penn Station #234','lucas@lucas.com','California','USA'),(10,2,'Jerry Fernandez','Birdman avenue #892','jerry@jerry.com','California','USA'),(11,7,'Mark Santos','Penn Station #234','mark@mark.com','Florida','USA');
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchaseOrders`
--

DROP TABLE IF EXISTS `purchaseOrders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchaseOrders` (
  `idpurchaseorders` int(11) NOT NULL AUTO_INCREMENT,
  `idproducto` int(11) DEFAULT NULL,
  `product_name` varchar(256) DEFAULT NULL,
  `products_ordered` int(11) DEFAULT NULL,
  `products_in_stock` int(11) DEFAULT NULL,
  `date_time_of_order` datetime DEFAULT NULL,
  `estado` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idpurchaseorders`),
  KEY `idproducto` (`idproducto`),
  CONSTRAINT `purchaseOrders_ibfk_1` FOREIGN KEY (`idproducto`) REFERENCES `producto` (`idproducto`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchaseOrders`
--

LOCK TABLES `purchaseOrders` WRITE;
/*!40000 ALTER TABLE `purchaseOrders` DISABLE KEYS */;
INSERT INTO `purchaseOrders` VALUES (1,2,'prueba',60,60,'2018-02-12 22:51:00','Bien'),(2,4,'Barra Avena',60,60,'2018-02-12 23:10:25','Bien'),(3,6,'Barra Quinoa',60,0,'2018-02-12 23:13:25','Bien'),(4,7,'Mochila 3 en 1',60,0,'2018-02-13 12:29:19','Bien'),(5,8,'Faja reductora',60,0,'2018-02-13 18:28:18','Pendiente'),(6,14,'Quemador Arnold',60,0,'2018-02-13 18:32:33','Pendiente'),(7,11,'Ganador Masa',60,0,'2018-02-13 18:50:49','Pendiente'),(8,9,'Diablo Power Oxido',60,0,'2018-02-13 18:52:57','Pendiente'),(9,10,'Omega 3',60,0,'2018-02-13 19:03:38','Pendiente'),(10,12,'Proteína Isolate',60,0,'2018-02-13 22:46:41','Pendiente'),(11,1,'Gold Standard Whey',60,0,'2018-02-15 20:01:28','Pendiente'),(12,19,'Glutamina',60,0,'2018-02-15 20:43:47','Pendiente'),(13,21,'Galletas Avena POWER',60,0,'2018-02-16 12:11:19','Pendiente'),(14,4,'Barra Avena',60,0,'2018-02-16 12:13:37','Pendiente');
/*!40000 ALTER TABLE `purchaseOrders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salesPerHour`
--

DROP TABLE IF EXISTS `salesPerHour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salesPerHour` (
  `idsalesperhour` int(11) NOT NULL AUTO_INCREMENT,
  `total_sales` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idsalesperhour`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salesPerHour`
--

LOCK TABLES `salesPerHour` WRITE;
/*!40000 ALTER TABLE `salesPerHour` DISABLE KEYS */;
INSERT INTO `salesPerHour` VALUES (1,1,NULL),(2,10,NULL),(14,3,'2018-02-12 21:25:43'),(22,2,'2018-02-12 22:02:50'),(23,2,'2018-02-12 23:02:50'),(24,7,'2018-02-13 13:02:50'),(25,1,'2018-02-13 14:02:50'),(26,0,'2018-02-13 15:02:50'),(27,0,'2018-02-13 16:02:50'),(28,0,'2018-02-13 17:02:50'),(29,11,'2018-02-13 18:02:50'),(30,17,'2018-02-13 19:02:50'),(31,0,'2018-02-13 20:54:55'),(32,0,'2018-02-13 21:02:50'),(33,0,'2018-02-13 22:02:50'),(34,1,'2018-02-13 23:02:50'),(35,2,'2018-02-15 20:02:50'),(36,1,'2018-02-15 21:02:50'),(37,0,'2018-02-15 22:02:50'),(38,2,'2018-02-16 11:04:59'),(39,1,'2018-02-16 12:04:59'),(40,3,'2018-02-16 13:04:59');
/*!40000 ALTER TABLE `salesPerHour` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sucursal`
--

DROP TABLE IF EXISTS `sucursal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sucursal` (
  `idsucursal` int(11) NOT NULL,
  `ubicacion` varchar(100) DEFAULT NULL,
  `estado` varchar(100) DEFAULT NULL,
  `pais` varchar(100) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `condicion` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idsucursal`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sucursal`
--

LOCK TABLES `sucursal` WRITE;
/*!40000 ALTER TABLE `sucursal` DISABLE KEYS */;
INSERT INTO `sucursal` VALUES (1,'Blvd. Del Niño Poblano 2510','Puebla','México','GNC ANGELOPOLIS',1),(2,'Av. Juárez No. 2927','Puebla','México','GNC LA PAZ',1),(3,'Blvd. Héroes 5 De Mayo No. 3510','Puebla','México','GNC PLAZA DORADA',1),(4,'Lateral Sur No. 905','Puebla','México','GNC SPORT CITY PUEBLA',1),(5,'Av. Forjadores No. 1009','Puebla','México','GNC CHEDRAUI FORJADORES',1),(6,'Via Atlixcayotl No. 1504','Puebla','México','GNC WALMART SAN ANGEL',1),(7,'Av. 9 Sur No. 11302','Puebla','México','GNC WALMART GRAN PLAZA SUR',1),(8,'Av. Reforma No. 309','Puebla','México','GNC AVENIDA REFORMA',1),(9,'Prolongación 11 Sur No. 8307','Puebla','México','GNC AURRERA MAYORAZGO',1),(10,'Blvd. Forjadores No. 3401','Puebla ','México','GNC AURRERA PLAZA SAN DIEGO',1);
/*!40000 ALTER TABLE `sucursal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sueldo`
--

DROP TABLE IF EXISTS `sueldo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sueldo` (
  `idsueldo` int(11) NOT NULL,
  `idempleado` int(11) DEFAULT NULL,
  `cantidad` decimal(11,3) DEFAULT NULL,
  PRIMARY KEY (`idsueldo`),
  KEY `idempleado` (`idempleado`),
  CONSTRAINT `sueldo_ibfk_1` FOREIGN KEY (`idempleado`) REFERENCES `empleado` (`idempleado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sueldo`
--

LOCK TABLES `sueldo` WRITE;
/*!40000 ALTER TABLE `sueldo` DISABLE KEYS */;
INSERT INTO `sueldo` VALUES (1,2,678.000),(2,11,789.000),(3,10,987.000),(4,9,1089.000),(5,8,567.000),(6,7,621.000),(7,6,890.000),(8,5,1234.000),(9,4,1089.000),(10,3,926.000);
/*!40000 ALTER TABLE `sueldo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turno`
--

DROP TABLE IF EXISTS `turno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `turno` (
  `idturno` int(11) NOT NULL,
  `idempleado` int(11) DEFAULT NULL,
  `nombre_turno` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idturno`),
  KEY `idempleado` (`idempleado`),
  CONSTRAINT `turno_ibfk_1` FOREIGN KEY (`idempleado`) REFERENCES `empleado` (`idempleado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turno`
--

LOCK TABLES `turno` WRITE;
/*!40000 ALTER TABLE `turno` DISABLE KEYS */;
INSERT INTO `turno` VALUES (1,1,'MATUTINO'),(2,11,'NOCTURNO'),(3,7,'MIXTO'),(4,3,'MIXTO'),(5,2,'MATUTINO'),(6,4,'TARDE'),(7,8,'NOCTURNO'),(8,5,'MATUTINO'),(9,6,'MIXTO'),(10,9,'MATUTINO');
/*!40000 ALTER TABLE `turno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venta`
--

DROP TABLE IF EXISTS `venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `venta` (
  `idventa` int(11) NOT NULL AUTO_INCREMENT,
  `idcliente` int(11) DEFAULT NULL,
  `idsucursal` int(11) DEFAULT NULL,
  `idempleado` int(11) DEFAULT NULL,
  `fecha_hora` datetime DEFAULT NULL,
  `total_venta` decimal(11,3) DEFAULT NULL,
  `nombre_cliente` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`idventa`),
  KEY `idcliente` (`idcliente`),
  KEY `idsucursal` (`idsucursal`),
  KEY `idempleado` (`idempleado`),
  CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idcliente`),
  CONSTRAINT `venta_ibfk_2` FOREIGN KEY (`idsucursal`) REFERENCES `sucursal` (`idsucursal`),
  CONSTRAINT `venta_ibfk_3` FOREIGN KEY (`idempleado`) REFERENCES `empleado` (`idempleado`)
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venta`
--

LOCK TABLES `venta` WRITE;
/*!40000 ALTER TABLE `venta` DISABLE KEYS */;
INSERT INTO `venta` VALUES (56,1,1,1,'2018-02-05 19:31:00',178.000,'Suriel Asael'),(57,1,1,1,'2018-02-12 21:17:03',290.000,'Suriel'),(58,1,1,1,'2018-02-12 21:17:18',9800.000,'Suriel'),(59,1,1,1,'2018-02-12 22:40:44',9800.000,'Asael'),(60,1,1,1,'2018-02-12 22:51:00',30720.000,'Mike'),(62,1,1,1,'2018-02-12 23:06:53',14210.000,'Prubea'),(67,1,1,1,'2018-02-12 23:10:25',1424.000,'NUEVO'),(68,1,1,1,'2018-02-12 23:11:10',156.000,'MIGUEL'),(69,1,1,1,'2018-02-12 23:13:25',3354.000,'Luke'),(70,1,1,1,'2018-02-13 12:20:02',534.000,'werwewer'),(71,1,1,1,'2018-02-13 12:20:57',356.000,''),(72,1,1,1,'2018-02-13 12:29:18',5340.000,'danperez'),(73,1,1,1,'2018-02-13 12:29:19',1780.000,'moni'),(74,1,1,1,'2018-02-13 12:29:19',1780.000,'BOB2'),(75,1,1,1,'2018-02-13 12:29:21',1780.000,'Pantufla'),(76,1,1,1,'2018-02-13 12:29:21',7890.000,'Arnold Schwarzenegger'),(77,1,1,1,'2018-02-13 13:07:21',1134.000,'Suriel'),(78,1,1,1,'2018-02-13 17:41:38',1134.000,'HAHAHA'),(80,1,1,1,'2018-02-13 17:44:17',1134.000,'hshshs'),(81,1,1,1,'2018-02-13 17:45:36',1134.000,'hahaha'),(82,1,1,1,'2018-02-13 17:45:56',1134.000,'hahaha'),(83,1,1,1,'2018-02-13 17:49:02',1134.000,'Hola'),(84,1,1,1,'2018-02-13 17:49:27',1134.000,'Hola'),(85,1,1,1,'2018-02-13 17:49:43',1134.000,'Suriel'),(86,1,1,1,'2018-02-13 17:50:20',1134.000,'suriel'),(87,1,1,1,'2018-02-13 17:51:47',567.000,'ssjajja'),(88,1,1,1,'2018-02-13 17:54:41',567.000,'ss'),(89,1,1,1,'2018-02-13 17:55:50',567.000,'suriel'),(97,1,1,1,'2018-02-13 18:18:46',567.000,'sshshs'),(98,1,1,1,'2018-02-13 18:20:19',567.000,'shshs'),(99,1,1,1,'2018-02-13 18:21:05',567.000,'sss'),(100,1,1,1,'2018-02-13 18:21:55',1134.000,'hshss'),(101,1,1,1,'2018-02-13 18:22:06',567.000,'sssss'),(102,1,1,1,'2018-02-13 18:22:29',567.000,'jjjaj'),(103,1,1,1,'2018-02-13 18:23:07',567.000,'hhhhhhh'),(104,1,1,1,'2018-02-13 18:23:43',567.000,'bbbbb'),(105,1,1,1,'2018-02-13 18:24:55',200.000,'prueba fin'),(106,1,1,1,'2018-02-13 18:27:20',5670.000,'Suriel'),(107,1,1,1,'2018-02-13 18:28:18',2835.000,'ASAEL'),(108,1,1,1,'2018-02-13 18:28:18',2835.000,'Test Fer'),(109,1,1,1,'2018-02-13 18:32:33',15780.000,'Test Fer'),(110,1,1,1,'2018-02-13 18:32:34',7890.000,'Suriel'),(111,1,1,1,'2018-02-13 18:50:02',8000.000,'SURIEL'),(112,1,1,1,'2018-02-13 18:50:49',4000.000,'PRUEBA PROCEDURE'),(114,1,1,1,'2018-02-13 18:52:57',22680.000,'ASAEL '),(116,1,1,1,'2018-02-13 19:03:38',13710.000,'Testt'),(118,1,1,1,'2018-02-13 22:46:41',28000.000,'SURIEL'),(119,1,1,1,'2018-02-14 13:33:07',178.000,'FEBRERO 14'),(120,1,1,1,'2018-02-15 20:01:28',9800.000,'Luke'),(121,1,1,1,'2018-02-15 20:02:08',178.000,'Chochos'),(122,1,1,1,'2018-02-15 20:43:47',14000.000,'Test iPhone'),(123,1,1,1,'2018-02-16 11:53:18',890.000,'Test EVENTO'),(124,1,1,1,'2018-02-16 11:02:00',890.000,'SURIEL'),(125,1,1,1,'2018-02-16 12:11:19',30420.000,'TEST TRIGGER'),(126,1,1,1,'2018-02-16 12:13:37',3204.000,'Test Iphone'),(130,1,1,1,'2018-02-16 12:15:07',12000.000,'test Stored Procedure 2');
/*!40000 ALTER TABLE `venta` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-02-16 13:05:24
