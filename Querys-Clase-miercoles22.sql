use data_stock;
create temporary table if not exists tempo(
sector int,
producto int,
cantidad int
);
insert into tempo
select sector, producto, sum(cantidad)
from (select sector, producto, tipo,
case
	when tipo = 1 then cantidad
	when tipo = 2 then cantidad*-1
end as cantidad 
from ingresos_retiros) as tmp
group by sector, producto;

select * from tempo;




/* *************** */
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

/* **************** */



delete from stock;

call sp_act_stock();

select * from stock;

/* ************ */

DELIMITER $$
USE data_stock$$
DROP TRIGGER if exists tg_insert_ingresos_retiros$$
CREATE
    TRIGGER tg_insert_ingresos_retiros AFTER INSERT ON ingresos_retiros
    FOR EACH ROW BEGIN
CALL sp_act_stock();
END;
$$
DELIMITER ;

DELIMITER $$
USE data_stock$$
DROP TRIGGER if exists tg_delete_ingresos_retiros$$
CREATE
    TRIGGER tg_delete_ingresos_retiros AFTER DELETE ON ingresos_retiros
    FOR EACH ROW BEGIN
CALL sp_act_stock();
END;
$$
DELIMITER ;


DELIMITER $$
USE data_stock$$
DROP TRIGGER if exists tg_update_ingresos_retiros$$
CREATE
    TRIGGER tg_update_ingresos_retiros AFTER UPDATE ON ingresos_retiros
    FOR EACH ROW BEGIN
CALL sp_act_stock();
END;
$$
DELIMITER ;

/* ******* */


-- delete from ingresos_retiros where num in(347, 644, 645)

-- update ingresos_retiros set cantidad = 0 where num in(650)

select * from stock


