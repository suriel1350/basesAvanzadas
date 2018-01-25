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
-- Table structure for table `detalle_venta`
--

DROP TABLE IF EXISTS `detalle_venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detalle_venta` (
  `iddetalleventa` int(11) NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_venta`
--

LOCK TABLES `detalle_venta` WRITE;
/*!40000 ALTER TABLE `detalle_venta` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_venta` ENABLE KEYS */;
UNLOCK TABLES;

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
  KEY `idventa` (`idventa`),
  KEY `idcliente` (`idcliente`),
  KEY `idempleado` (`idempleado`),
  KEY `idsucursal` (`idsucursal`),
  CONSTRAINT `facturacion_ibfk_1` FOREIGN KEY (`idventa`) REFERENCES `venta` (`idventa`),
  CONSTRAINT `facturacion_ibfk_2` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idcliente`),
  CONSTRAINT `facturacion_ibfk_3` FOREIGN KEY (`idempleado`) REFERENCES `empleado` (`idempleado`),
  CONSTRAINT `facturacion_ibfk_4` FOREIGN KEY (`idsucursal`) REFERENCES `sucursal` (`idsucursal`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facturacion`
--

LOCK TABLES `facturacion` WRITE;
/*!40000 ALTER TABLE `facturacion` DISABLE KEYS */;
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
INSERT INTO `producto` VALUES (1,2,3,4,20,980.000,'Gold Standard Whey','Proteina de Suero de Leche',NULL,1),(2,8,3,3,30,1024.000,'MP Muscle','Proteina de suero de leche sabor chocolate',NULL,1),(3,4,2,1,100,145.000,'Vitamina C','Frasco con 180 Capsulas',NULL,1),(4,5,7,8,38,89.000,'Barra Avena','Mezcla de chocolate, avena y proteina',NULL,1),(6,7,7,2,45,78.000,'Barra Quinoa','Exquisita mezcla de quinoa, avena y Splenda',NULL,1),(7,2,6,3,10,178.000,'Mochila 3 en 1','Lleva tus comidas, shakers y pastillas',NULL,1),(8,6,6,3,45,567.000,'Faja reductora','Para quemar esos kilos de mas',NULL,1),(9,9,11,2,34,567.000,'Diablo Power Oxido','Para hacer de tu entrenamiento mas duradero y sin cansancio',NULL,1),(10,4,10,6,30,457.000,'Omega 3','Ideal antes del cardio para quemar mas calorias',NULL,1);
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
  `idventa` int(11) NOT NULL,
  `idcliente` int(11) DEFAULT NULL,
  `idsucursal` int(11) DEFAULT NULL,
  `idempleado` int(11) DEFAULT NULL,
  `fecha_hora` datetime DEFAULT NULL,
  `total_venta` decimal(11,3) DEFAULT NULL,
  PRIMARY KEY (`idventa`),
  KEY `idcliente` (`idcliente`),
  KEY `idsucursal` (`idsucursal`),
  KEY `idempleado` (`idempleado`),
  CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idcliente`),
  CONSTRAINT `venta_ibfk_2` FOREIGN KEY (`idsucursal`) REFERENCES `sucursal` (`idsucursal`),
  CONSTRAINT `venta_ibfk_3` FOREIGN KEY (`idempleado`) REFERENCES `empleado` (`idempleado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venta`
--

LOCK TABLES `venta` WRITE;
/*!40000 ALTER TABLE `venta` DISABLE KEYS */;
INSERT INTO `venta` VALUES (1,1,2,3,'2017-10-02 00:00:00',1000.000),(2,2,2,3,'2018-01-01 00:00:00',5000.000),(3,3,2,3,'2017-09-05 00:00:00',4000.000),(4,4,5,6,'2018-01-09 00:00:00',3500.000),(5,7,5,9,'2018-01-02 00:00:00',4600.000),(6,12,5,6,'2017-08-07 00:00:00',3500.000),(7,7,5,2,'2017-07-11 00:00:00',780.000),(8,8,9,8,'2016-09-06 00:00:00',3400.000),(9,4,5,6,'2018-01-08 00:00:00',789.000),(10,4,5,10,'2018-01-10 00:00:00',500.000);
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

-- Dump completed on 2018-01-25 13:21:23
