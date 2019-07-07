DELIMITER $$
USE data_stock$$
DROP TRIGGER tg_insert_ingresos_retiros$$
CREATE
    TRIGGER tg_insert_ingresos_retiros AFTER INSERT ON ingresos_retiros
    FOR EACH ROW BEGIN
CALL sp_act_stock();
END;
$$
DELIMITER ;

DELIMITER $$
USE data_stock$$
DROP TRIGGER tg_delete_ingresos_retiros$$
CREATE
    TRIGGER tg_delete_ingresos_retiros AFTER DELETE ON ingresos_retiros
    FOR EACH ROW BEGIN
CALL sp_act_stock();
END;
$$
DELIMITER ;


DELIMITER $$
USE data_stock$$
DROP TRIGGER tg_update_ingresos_retiros$$
CREATE
    TRIGGER tg_update_ingresos_retiros AFTER UPDATE ON ingresos_retiros
    FOR EACH ROW BEGIN
CALL sp_act_stock();
END;
$$
DELIMITER ;