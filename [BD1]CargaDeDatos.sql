--Script (con extensión .sql) que contiene todas las consultas necesarias para llenar el
--modelo relacional propuesto a partir de la tabla temporal.

insert into compania (nombre,contacto,correo,telefono)
select distinct nombre_compania,contacto_compania,correo_compania,telefono_compania from carga_temp;

insert into rol (rol) select distinct tipo from carga_temp;

insert into region (region) select distinct region from carga_temp;

insert into categoria (categoria) select distinct categoria_producto from carga_temp;

insert into ciudad (cod_postal,nombre,cod_region) 
select distinct carga_temp.codigo_postal, carga_temp.ciudad, region.cod_region from carga_temp, region
where region.region = carga_temp.region;