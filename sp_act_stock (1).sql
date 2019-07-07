delimiter $$
drop procedure if exists sp_act_stock$$
CREATE PROCEDURE sp_act_stock()
begin
	insert into stock
	select distinct sector, producto, 0 from ingresos_retiros as ir
	where not(concat(ir.sector, '-', ir.producto) =any(
	select concat(sector,'-', producto) from stock));

	update stock as s 
	inner join ingresos_retiros as ir 
	on ir.sector = s.sector and ir.producto = s.producto 
	set s.cantidad = s.cantidad + ir.cantidad
	where ir.tipo = 1;

	update stock as s 
	inner join ingresos_retiros as ir 
	on ir.sector = s.sector and ir.producto = s.producto 
	set s.cantidad = s.cantidad - ir.cantidad
	where ir.tipo = 2;
end$$

delimiter ;
