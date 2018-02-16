
DELIMITER $$
CREATE PROCEDURE GetStock(
 IN producto int,
 OUT disponibles INT)
  BEGIN
   SELECT stock
   INTO disponibles
   FROM producto
   WHERE idproducto = producto;
  END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE GetCategorias()
  BEGIN
	SELECT count(c.idcategoria) as productos, c.idcategoria, c.nombre
	FROM producto p, categoria c
	WHERE c.idcategoria = p.idcategoria
	GROUP BY c.idcategoria;
  END$$
DELIMITER ;

--Procedure
SELECT p.nombre, c.nombre, c.idcategoria 
FROM producto p, categoria c
WHERE c.idcategoria = p.idcategoria
ORDER BY c.idcategoria;

--Get categories availables
SELECT DISTINCT c.idcategoria, c.nombre
FROM producto p, categoria c
WHERE c.idcategoria = p.idcategoria
ORDER BY c.idcategoria;

--Count Repeated
SELECT count(c.idcategoria), c.idcategoria, c.nombre
FROM producto p, categoria c
WHERE c.idcategoria = p.idcategoria
GROUP BY c.idcategoria


DELIMITER $$
CREATE TRIGGER `tr_updStockCompra` AFTER INSERT ON `detalle_compra` FOR EACH ROW BEGIN
UPDATE producto SET stock = stock + NEW.cantidad
WHERE producto.idproducto = NEW.idproducto;
END
$$
DELIMITER ;