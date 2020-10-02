--Script (con extensión .sql) que contiene todas las consultas necesarias para realizar
--los reportes.

select persona.nombre, persona.telefono, transaccion.cod_transaccion, transaccion.precio_total from transaccion, persona 
where transaccion.cod_persona = persona.cod_persona and transaccion.precio_total = (select max(precio_total) from transaccion) and persona.cod_rol = 2;


