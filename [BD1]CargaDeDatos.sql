--Script (con extensión .sql) que contiene todas las consultas necesarias para llenar el
--modelo relacional propuesto a partir de la tabla temporal.

insert into categoria (categoria) select distinct categoria_producto from carga_temp;


insert into region (region) select distinct region from carga_temp;


insert into compania (nombre,contacto,correo,telefono)
select distinct nombre_compania,contacto_compania,correo_compania,telefono_compania from carga_temp;


insert into rol (rol) select distinct tipo from carga_temp;


insert into producto(nombre,precio,cod_categoria)
select distinct carga_temp.producto, TO_NUMBER(carga_temp.precio_unitario, '9999.99'), categoria.cod_categoria from carga_temp, categoria
where categoria.categoria = carga_temp.categoria_producto;


insert into ciudad(nombre,cod_region)
select distinct carga_temp.ciudad, region.cod_region from carga_temp, region
where region.region = carga_temp.region;


insert into postal(numero_postal,cod_ciudad)
select distinct carga_temp.codigo_postal, ciudad.cod_ciudad from carga_temp, ciudad
where ciudad.nombre = carga_temp.ciudad;


insert into persona(nombre,correo,telefono,fecha_registro,direccion,cod_rol,cod_postal)
select distinct carga_temp.nombre, carga_temp.correo, carga_temp.telefono, carga_temp.fecha_registro, carga_temp.direccion, rol.cod_rol, postal.cod_postal
from carga_temp, rol, postal
where rol.rol = carga_temp.tipo and postal.numero_postal = carga_temp.codigo_postal;


insert into transaccion(cantidad,precio_total,cod_producto,cod_persona,cod_compania)
select distinct carga_temp.cantidad, TO_NUMBER(carga_temp.cantidad*carga_temp.precio_unitario, '9999.99'),  producto.cod_producto, 
persona.cod_persona, compania.cod_compania
from carga_temp, producto, persona, compania
where producto.nombre = carga_temp.producto and persona.nombre = carga_temp.nombre and compania.nombre = carga_temp.nombre_compania;