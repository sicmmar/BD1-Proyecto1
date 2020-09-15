create table carga_temporal (
    nombre_compania varchar(150),
    contacto_compania varchar(150),
    correo_compania varchar(50),
    telefono_compania varchar(50),
    tipo varchar(1),
    nombre varchar(50),
    correo varchar(50),
    telefono varchar(50),
    fecha_registro date,
    direccion varchar(150),
    ciudad varchar(50),
    codigo_postal integer,
    region varchar(50),
    producto varchar(150),
    categoria_producto varchar(100),
    cantidad integer,
    precio_unitario varchar(50)
);

--$ORACLE_HOME/bin/sqlldr sicmmar/123456@172.18.0.2:1521/xe control=/home/sicmmar/Documents/Bases/BD1-Proyecto1/[BD1]ArchivoControl.ctl data=/home/sicmmar/Documents/Bases/BD1-Proyecto1/DataCenterData.csv log=registrolog.txt
