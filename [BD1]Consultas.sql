--Script (con extensión .sql) que contiene todas las consultas necesarias para realizar
--los reportes.

--1. Mostrar el nombre del proveedor, número de teléfono, número de orden, total de la orden por la cual se haya pagado la mayor cantidad de dinero.
select persona.nombre, persona.telefono, transaccion.cod_transaccion, transaccion.precio_total from transaccion, persona 
where transaccion.cod_persona = persona.cod_persona and transaccion.precio_total = (select max(precio_total) from transaccion) and persona.cod_rol = 2;


--2. Mostrar el número de cliente, nombre, apellido y total del cliente que más productos ha comprado.
select p.cod_persona as numero_cliente, p.nombre as nombre_apellido, sum(t.precio_total) as total_comprado from transaccion t, persona p 
where p.cod_persona = t.cod_persona and p.cod_rol = 1 group by p.cod_persona, p.nombre order by count(t.cod_persona) desc fetch next 1 rows only;


--3. Mostrar la dirección, región, ciudad y código postal hacia la cual se han hecho más solicitudes de pedidos y a cuál menos (en una sola consulta).
select distinct p.direccion, r.region, c.nombre as ciudad, postal.numero_postal from persona p inner join postal on p.cod_postal = postal.cod_postal
inner join ciudad c on postal.cod_ciudad = c.cod_ciudad inner join region r on c.cod_region = r.cod_region where p.direccion = (
select p.direccion from persona p, transaccion t where p.cod_persona = t.cod_persona group by p.direccion order by count(t.cod_persona) desc fetch next 1 rows only) union all
select distinct p.direccion, r.region, c.nombre as ciudad, postal.numero_postal from persona p inner join postal on p.cod_postal = postal.cod_postal
inner join ciudad c on postal.cod_ciudad = c.cod_ciudad inner join region r on c.cod_region = r.cod_region where p.direccion = (
select p.direccion from persona p, transaccion t where p.cod_persona = t.cod_persona group by p.direccion order by count(t.cod_persona) asc fetch next 1 rows only);


--4. Mostrar el número de cliente, nombre, apellido, el número de órdenes que ha realizado y el total de cada una de los cinco clientes que más han comprado productos de la categoría ‘Cheese’ .
select p.cod_persona as num_cliente, p.nombre as nombre_apellido, count(t.cantidad) as num_ordenes, sum(t.precio_total) as total_comprado
from persona p inner join transaccion t on t.cod_persona = p.cod_persona and p.cod_rol = 1
inner join producto prod on t.cod_producto = prod.cod_producto inner join categoria ctg on prod.cod_categoria = ctg.cod_categoria and ctg.categoria = 'Cheese' 
group by p.cod_persona, p.nombre order by count(t.cantidad) desc fetch first 5 rows only;


--5. Mostrar el número de mes de la fecha de registro, nombre y apellido de todos los clientes que más han comprado y los que menos han comprado (en dinero) utilizando una sola consulta.
(select extract(month from p.fecha_registro) as mes, p.nombre as nombre_apellido, sum(t.precio_total) as total_compras from persona p inner join transaccion t on p.cod_persona = t.cod_persona 
group by p.fecha_registro, p.nombre order by sum(t.precio_total) desc fetch first 5 rows only ) union all
(select extract(month from p.fecha_registro) as mes, p.nombre as nombre_apellido, sum(t.precio_total) as total_compras from persona p inner join transaccion t on p.cod_persona = t.cod_persona 
group by p.fecha_registro, p.nombre order by sum(t.precio_total) asc fetch first 5 rows only);


--6. Mostrar el nombre de la categoría más y menos vendida y el total vendido en dinero (en una sola consulta).
(select ctg.categoria, sum(t.precio_total) as total_vendido from transaccion t inner join producto p on t.cod_producto = p.cod_producto inner join persona per on t.cod_persona = per.cod_persona and per.cod_rol = 2
inner join categoria ctg on p.cod_categoria = ctg.cod_categoria group by ctg.categoria order by sum(t.precio_total) desc fetch first 1 rows only) union all
(select ctg.categoria, sum(t.precio_total) as total_vendido from transaccion t inner join producto p on t.cod_producto = p.cod_producto inner join persona per on t.cod_persona = per.cod_persona and per.cod_rol = 2
inner join categoria ctg on p.cod_categoria = ctg.cod_categoria group by ctg.categoria order by sum(t.precio_total) asc fetch first 1 rows only)


--7. Mostrar el top 5 de proveedores que más productos han vendido (en dinero) de la categoría de productos 'Fresh Vegetables' .
select p.nombre as proveedor, sum(t.precio_total) as total_vendido from transaccion t inner join persona p on t.cod_persona = p.cod_persona and p.cod_rol = 2
inner join producto prod on t.cod_producto = prod.cod_producto inner join categoria ctg on prod.cod_categoria = ctg.cod_categoria and ctg.categoria = 'Fresh Vegetables'
group by p.nombre order by sum(t.precio_total) desc fetch first 5 rows only;


--8. Mostrar la dirección, región, ciudad y código postal de los clientes que más han comprado y de los que menos (en dinero) en una sola consulta.
(select p.direccion, r.region, c.nombre as ciudad, post.numero_postal as cod_postal, sum(t.precio_total) as total_comprado from transaccion t inner join persona p on t.cod_persona = p.cod_persona 
and p.cod_rol = 1 inner join postal post on p.cod_postal = post.cod_postal inner join ciudad c on post.cod_ciudad = c.cod_ciudad inner join region r on c.cod_region = r.cod_region 
group by p.direccion, r.region, c.nombre, post.numero_postal order by sum(t.precio_total) desc fetch first 5 rows only) union all
(select p.direccion, r.region, c.nombre as ciudad, post.numero_postal as cod_postal, sum(t.precio_total) as total_comprado from transaccion t inner join persona p on t.cod_persona = p.cod_persona 
and p.cod_rol = 1 inner join postal post on p.cod_postal = post.cod_postal inner join ciudad c on post.cod_ciudad = c.cod_ciudad inner join region r on c.cod_region = r.cod_region 
group by p.direccion, r.region, c.nombre, post.numero_postal order by sum(t.precio_total) asc fetch first 5 rows only);


--9. Mostrar el nombre del proveedor, número de teléfono, número de orden, total de la orden por la cual se haya obtenido la menor cantidad de producto.
select p.nombre, p.telefono, t.cod_transaccion, sum(t.precio_total) as total_orden from transaccion t inner join persona p on t.cod_persona = p.cod_persona and t.cantidad = (
select min(cantidad) from transaccion) and p.cod_rol = 2 group by p.nombre, p.telefono, t.cod_transaccion order by sum(t.precio_total) asc fetch first 5 rows only;


--10. Mostrar el top 10 de los clientes que más productos han comprado de la categoría 'Seafood'.
select p.nombre, count(t.cantidad) as cant_productos from transaccion t inner join persona p on t.cod_persona = p.cod_persona and p.cod_rol = 1 inner join producto prod on t.cod_producto = prod.cod_producto
inner join categoria ctg on prod.cod_categoria = ctg.cod_categoria and ctg.categoria = 'Seafood' group by p.nombre order by count(t.cantidad) desc fetch first 10 rows only;

