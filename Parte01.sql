
update ingresos_retiros set cantidad = 25 
where producto = 10 and tipo =1;

update ingresos_retiros set cantidad = 13
where producto = 50 and tipo =1;


select producto, sum(cantidad) as stock
from (select producto, cantidad as cantidad from ingresos_retiros
where producto in(10, 30, 50) and tipo = 1
union
select producto, cantidad*-1 as cantidad from ingresos_retiros
where producto in(10, 30, 50) and tipo = 2) as t
group by producto 

select * 
from ingresos_retiros 
where not(producto between 10 and 50 );
-- where producto >= 10 and producto <= 50 

select * from clientes 
where not(num = any(select p.cliente from 
productos as p 
inner join ingresos_retiros as ir on ir.producto = p.num))


delete from ingresos_retiros;
insert into ingresos_retiros 
(producto, sector, cantidad, fecha, tipo)
select p.num, 1, 10, now(), 1
from clientes as c
inner join productos as p
on c.num = p.cliente
where c.rut = '11111111';

insert into ingresos_retiros 
(producto, sector, cantidad, fecha, tipo)
select p.num, 1, 7, now(), 2
from clientes as c
inner join productos as p
on c.num = p.cliente
where c.rut = '11111111';

select c.rut, c.razonsocial, p.*, s.*, b.*
from clientes as c
inner join productos as p on p.cliente = c.num
inner join ingresos_retiros as ir on ir.producto = p.num
inner join bodega_sector as s on s.num = ir.sector 
inner join bodega as b on b.num = s.bodega 
where ir.tipo in(1, 2)
-- where ir.tipo = 1 or ir.tipo = 2 





