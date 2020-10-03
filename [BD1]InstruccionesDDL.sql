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

--sudo docker exec -it eb4d48c5b3fb /bin/bash
--$ORACLE_HOME/bin/sqlldr sicmmar/123456@172.18.0.2:1521/xe control=[BD1]ArchivoControl.ctl data=DataCenterData.csv log=registrolog.txt
--sudo docker cp /home/sicmmar/Documents/Bases/BD1-Proyecto1/[BD1]ArchivoControl.ctl eb4d48c5b3fb:/bases1

-- CREAR TABLAS DEL MODELO 

create sequence catg_seq start with 1;

create table categoria(
    cod_categoria integer default catg_seq.nextval not null,
    categoria varchar(100) not null,
    constraint PK_categoria primary key (cod_categoria)
);


create sequence region_seq start with 1;

create table region(
    cod_region integer default region_seq.nextval not null,
    region varchar(75) not null,
    constraint PK_region primary key (cod_region)
);


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


create sequence prod_seq start with 1;

create table producto(
    cod_producto integer default prod_seq.nextval not null,
    nombre varchar(150) not null,
    precio decimal(14,2) not null,
    --TO_NUMBER(t.precio_unitario, '9999.99')
    cod_categoria integer null,
    constraint PK_producto primary key (cod_producto),
    constraint FK_cat_pro foreign key (cod_categoria) references categoria(cod_categoria)
);


create sequence cd_seq start with 1;

create table ciudad(
    cod_ciudad integer default cd_seq.nextval not null,
    nombre varchar(75) not null,
    cod_region integer null,
    constraint PK_ciudad primary key (cod_ciudad),
    constraint FK_reg_ciu foreign key (cod_region) references region(cod_region)
);


create sequence codp_seq start with 1;

create table postal(
    cod_postal integer default codp_seq.nextval not null,
    numero_postal integer not null,
    cod_ciudad integer null,
    constraint PK_postal primary key (cod_postal),
    constraint FK_ciu_pos foreign key (cod_ciudad) references ciudad(cod_ciudad)
);


create sequence person_seq start with 1;

create table persona(
    cod_persona integer default person_seq.nextval not null,
    nombre varchar(75) not null,
    correo varchar(75) not null,
    telefono varchar(75) not null,
    fecha_registro date not null,
    direccion varchar(150) not null,
    cod_rol integer null,
    cod_postal integer null,
    constraint PK_persona primary key (cod_persona),
    constraint FK_tip_per foreign key (cod_rol) references rol(cod_rol),
    constraint FK_pos_per foreign key (cod_postal) references postal(cod_postal)
);


create sequence trans_seq start with 1;

create table transaccion(
    cod_transaccion integer default trans_seq.nextval not null,
    cantidad integer not null,
    precio_total decimal(15,2) not null,
    cod_producto integer null,
    cod_persona integer null,
    cod_compania integer null,
    constraint FK_pro_tra foreign key(cod_producto) references producto(cod_producto),
    constraint FK_per_tra foreign key(cod_persona) references persona(cod_persona),
    constraint FK_com_tra foreign key(cod_compania) references compania(cod_compania),
    constraint PK_trans primary key (cod_transaccion, cod_producto, cod_persona, cod_compania)
);