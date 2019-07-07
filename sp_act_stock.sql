DELIMITER $$

USE `data_stock`$$

DROP PROCEDURE IF EXISTS `sp_act_stock`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_act_stock`()
BEGIN
INSERT INTO stock
SELECT DISTINCT sector, producto, 0 FROM ingresos_retiros AS ir
WHERE NOT(CONCAT(ir.sector, '-', ir.producto) =ANY(
SELECT CONCAT(sector,'-', producto) FROM stock));

CREATE TEMPORARY TABLE tempo(
sector INT,
producto INT,
cantidad INT
);


INSERT INTO tempo 
SELECT sector, producto, SUM(cantidad) 
FROM(
SELECT sector, producto, tipo,
CASE 
WHEN tipo = 1 THEN cantidad
WHEN tipo = 2 THEN cantidad * -1
END AS cantidad
FROM ingresos_retiros
) AS t
GROUP BY sector, producto;

UPDATE stock AS s 
INNER JOIN tempo AS t
ON t.sector = s.sector AND t.producto = s.producto 
SET s.cantidad = t.cantidad;

DROP TEMPORARY TABLE IF EXISTS tempo;
END$$

DELIMITER ;