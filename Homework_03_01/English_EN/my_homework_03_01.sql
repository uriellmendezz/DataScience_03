
## Homework Clase 01 - M3

# I create the database
create database empresa;
use empresa;

/*
Creating the tables
*/

create table CanalVenta(
	IdCanal int not null AUTO_INCREMENT,
	Tipo varchar(50),
	primary key (IdCanal)
);

create table empleados(
	IdEmpleado int not null primary key,
    Nombre varchar(50),
    Apellido varchar(50),
    Sucursal varchar (70),
    Sector varchar(50),
    Cargo varchar(50),
    Salario decimal(10,2)
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

create table venta(
	IdVenta int not null AUTO_INCREMENT primary key,
    Fecha date,
    Fecha_Entrega date,
    IdCanal int ,
    IdCliente int,
    IdSucursal int,
    IdEmpleado int,
    IdProducto int,
    Precio decimal(15,2),
    Cantidad int,
    foreign key (IdCanal) references canalventa (IdCanal),
    foreign key (IdCliente) references clientes (IdCliente),
    foreign key (IdSucursal) references sucursales (IdSucursal),
    foreign key (IdEmpleado) references empleados (IdEmpleado),
    foreign key (IdProducto) references productos (IdProducto)
);


/*
Once I have all the tables, lets go ahead to insert the values into the tables
*/

-- Table 'canalventa' (sales channel)
load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Homework_clase_1_m3/CanalDeVenta_csv.csv"
into table canalventa
fields terminated by ","
LINES TERMINATED BY '\n'
ignore 1 lines;

-- Table 'clientes' (clients)
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Homework_clase_1_m3/clientes_clean.csv'
into table clientes
fields terminated by ","
enclosed by '"'
lines TERMINATED BY "\n"
ignore 1 lines;

-- Table 'productos' (products)
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Homework_clase_1_m3/Productos_csv.csv'
into table productos
fields terminated by ","
-- enclosed by '"'
lines TERMINATED BY "\n"
ignore 1 lines;

-- Table 'compras'(purchases)
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Homework_clase_1_m3/Compra.csv'
into table compras
fields terminated by ","
-- enclosed by '"'
lines TERMINATED BY "\n"
ignore 1 lines;

-- Table 'gasto' (expense)
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Homework_clase_1_m3/Gasto.csv'
into table gasto
fields terminated by ","
-- enclosed by '"'
lines TERMINATED BY "\n"
ignore 1 lines;

-- Table 'proveedores' (providers)
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Homework_clase_1_m3/Proveedores_csv.csv'
into table proveedores
fields terminated by ","
-- enclosed by '"'
lines TERMINATED BY "\n"
ignore 1 lines;

-- Table 'sucursales' (branches)
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Homework_clase_1_m3/Sucursales_clean.csv'
into table sucursales
fields terminated by ","
-- enclosed by '"'
lines TERMINATED BY "\n"
ignore 1 lines;

-- Table 'tipodegasto' (expense type)
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Homework_clase_1_m3/TiposDeGasto.csv'
into table tipodegasto
fields terminated by ","
-- enclosed by '"'
lines TERMINATED BY "\n"
ignore 1 lines;

-- Table 'empleados' (employees)
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Homework_clase_1_m3/Empleados_clean.csv'
into table empleados
fields terminated by ","
-- enclosed by '"'
lines TERMINATED BY "\n"
ignore 1 lines;

-- Tabla 'venta' (sales)
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Homework_clase_1_m3/Venta.csv'
into table venta
fields terminated by ","
-- enclosed by '"'
lines TERMINATED BY "\n"
ignore 1 lines;

# Finally, all the tables were created and their respective data were inserted into them successfully!