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