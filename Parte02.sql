
select producto, sum(cantidad) as stock
from (select producto, cantidad as cantidad from ingresos_retiros
where producto in(10, 30, 50) and tipo = 1
union
select producto, cantidad*-1 as cantidad from ingresos_retiros
where producto in(10, 30, 50) and tipo = 2) as t
group by producto 


drop view if exists vw_stock;
create view vw_stock as 
	select c.rut, c.razonsocial, p.*, s.cantidad as stock
	from stock as s 
	join productos as p on p.num = s.producto
	join clientes as c on c.num = p.cliente 
    
delete from stock;
insert into stock 
select sector, producto, sum(cantidad) as stock
from (select sector, producto, cantidad as cantidad from ingresos_retiros
where tipo = 1
union
select sector, producto, cantidad*-1 as cantidad from ingresos_retiros
where  tipo = 2) as t
group by sector, producto 


select rut, razonsocial, codigo, volumen, stock
from vw_stock 
where stock <0 


delete from stock;
insert into stock 
select distinct sector, producto, 0
from ingresos_retiros;

select * from stock;


update stock set cantidad = 0;
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




delimiter $$

drop procedure if exists sp_act_stock$$

create procedure sp_act_stock()
begin

	delete from stock;

	insert into stock 
	select distinct sector, producto, 0
	from ingresos_retiros;

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









