--Script (con extensión .sql) que contiene las instrucciones DDL para crear el
--modelo relacional. A este script debe de aplicarle todas las reglas de
--integridad vistas en clase y laboratorio. 

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

-- CREAR TABLAS DEL MODELO 
create sequence comp_seq start with 1;

create table compania(
    cod_compania integer default comp_seq.nextval not null,
    nombre varchar(150) not null,
    contacto varchar(150) not null,
    correo varchar(75) not null,
    telefono varchar(50) not null,
    constraint PK_compania primary key(cod_compania)
);


create sequence rol_seq start with 1;

create table rol(
    cod_rol integer default rol_seq.nextval not null,
    rol varchar(1) not null,
    constraint PK_rol primary key(cod_rol)
);


create sequence region_seq start with 1;

create table region(
    cod_region integer default region_seq.nextval not null,
    region varchar(75) not null,
    constraint PK_region primary key (cod_region)
);


create sequence catg_seq start with 1;

create table categoria(
    cod_categoria integer default catg_seq.nextval not null,
    categoria varchar(100) not null,
    constraint PK_categoria primary key (cod_categoria)
);


create table ciudad(
    cod_postal integer not null,
    nombre varchar(75) not null,
    cod_region integer not null,
    constraint PK_ciudad primary key (cod_postal),
    constraint FK_reg_ciu foreign key cod_region references region(cod_region)
);