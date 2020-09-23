create table carga_temp (
    nombre_compania varchar(150),
    contacto_compania varchar(150),
    correo_compania varchar(75),
    telefono_compania varchar(75),
    tipo varchar(1),
    nombre varchar(75),
    correo varchar(75),
    telefono varchar(75),
    fecha_registro date,
    direccion varchar(150),
    ciudad varchar(75),
    codigo_postal integer,
    region varchar(75),
    producto varchar(150),
    categoria_producto varchar(100),
    cantidad integer,
    precio_unitario varchar(75)
);

--$ORACLE_HOME/bin/sqlldr sicmmar/123456@172.18.0.2:1521/xe control=[BD1]ArchivoControl.ctl data=DataCenterData.csv log=registrolog.txt
--sudo docker exec -it eb4d48c5b3fb /bin/bash

