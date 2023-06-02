create database empresa;

use empresa;

/*
Empiezo cargando las tablas que estan en formato de Excel y despues hago la limpieza
de las tablas que estan en formato csv
*/

create table CanalVenta(
	IdCanal int not null AUTO_INCREMENT,
	Tipo varchar(50),
	primary key (IdCanal)
);

create table empleados(
	IdEmpleado int not null,
    Nombre varchar(50),
    Apellido varchar(50),
    Sucursal varchar (70),
    Sector varchar(50),
    Cargo varchar(50),
    Salario decimal(10,2),
    primary key (IdEmpleado)
);

create table productos(
	IdProducto int not null,
    Concepto varchar(100),
    Tipo varchar(50),
    Precio decimal(30,2),
    primary key (IdProducto)
);


create table proveedores(
	IdProveedor int not null AUTO_INCREMENT,
    Nombre varchar(50),
    Direccion varchar(100),
    Ciudad varchar(50),
    Provincia varchar(50),
    Pais varchar(50),
    Localidad varchar(50),
    primary key (IdProveedor)
);

/* Ahora cargo las tablas que vienen en fomato CSV */
create table clientes(
	IdCliente int not null primary key,
    Provincia varchar(80),
    Nombre_y_Apellido varchar(80),
    Domicilio varchar(80), 
    Telefono varchar(80),
    Edad int,
    Localidad varchar(80),
    Longitud varchar(80),
    Latitud varchar(80),
    Fecha_Alta date,
    Usuario_Alta varchar(40),
    Fecha_Ultima_Modificacion date,
    Usuario_Ultima_Modificacion varchar(40),
    Marca_Baja int
);

create table compras(
	IdCompra int not null AUTO_INCREMENT,
    Fecha date,
    IdProducto int,
    Cantidad int,
    Precio decimal(10,2),
    IdProveedor int,
    primary key (IdCompra)
);

create table gasto(
	IdGasto int not null AUTO_INCREMENT,
    IdSucursal int,
    IdTipoGasto int,
    Fecha date,
    Monto decimal(10,2),
    primary key (IdGasto)
);

create table sucursales(
	IdSucursal int not null auto_increment,
    Sucursal varchar(70),
    Direccion varchar(100),
    Localidad varchar(70),
    Provincia varchar(70),
    Latitud decimal(15,10),
    Longitud decimal(15,10),
    primary key (IdSucursal)
);

create table tipodegasto(
	IdTipoGasto int not null AUTO_INCREMENT,
    Descripcion varchar(50),
    Monto_Aproximado decimal(10,2),
    primary key(IdTipoGasto)
);

/*
Comenzamos con la inserción de la data
*/

-- Tabla canalventa
load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Homework_clase_1_m3/CanalDeVenta_csv.csv"
into table canalventa
fields terminated by ","
LINES TERMINATED BY '\n'
ignore 1 lines;

-- Tabla clientes
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Homework_clase_1_m3/clientes_clean.csv'
into table clientes
fields terminated by ","
enclosed by '"'
lines TERMINATED BY "\n"
ignore 1 lines;

-- Tabla productos
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Homework_clase_1_m3/Productos_csv.csv'
into table productos
fields terminated by ","
-- enclosed by '"'
lines TERMINATED BY "\n"
ignore 1 lines;

-- Tabla empleados
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Homework_clase_1_m3/Empleados_csv.csv'
into table empleados
fields terminated by ","
-- enclosed by '"'
lines TERMINATED BY "\n"
ignore 1 lines;

use empresa;

drop table empleados;

