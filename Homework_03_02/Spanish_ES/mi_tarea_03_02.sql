use empresa;

/* # 1
¿Qué tan actualizada está la información? 
¿La forma en que se actualiza ó mantiene esa información se puede mejorar?
*/
-- Consulto que tablas contiene una columna de fecha
select distinct table_name from information_schema.columns
where table_schema = "empresa"
and column_name like "%fecha%";

-- Aparentemente la tabla 'clientes' contiene datos desactualizados, datos del 2015
select Fecha_Alta,Fecha_Ultima_Modificacion from clientes order by 1,2 desc;

-- Tabla 'compras' se podria considerar actualizada dentro de todo, ya que sus datos van del '2015-01-30' al '2020-12-25'.
select min(Fecha) as 'Oldest date', max(fecha) as 'Newest date' from compras limit 1;

-- La tabla 'venta' se encuentra con datos bastente recientes que van del 2015-01-01 a 2021-01-06
describe venta;
select min(Fecha),max(fecha_entrega) from venta; 

-- Por ultimo la tabla 'gasto' tambien tiene los datos actualizados, de 2015-01-01 a 2020-12-01
describe gasto;
select min(fecha), max(fecha) from gasto;

/* # 2
¿Los datos están completos en todas las tablas?
*/
-- Consulto en que tablas de mi database existen valores vacios 
select 
	table_name as Tabla,
	column_name as 'Columnas con datos vacios'
from information_schema.columns
where table_schema = 'empresa'
and is_nullable = "Yes";

select subquery.Tabla, count(*) Nulos
from (select 
	table_name as Tabla,
	column_name as 'Columnas con datos vacios'
from information_schema.columns
where table_schema = 'empresa'
and is_nullable = "Yes") subquery
group by Tabla
order by Nulos desc;

/*
Tabla			Total de Nulos
clientes		13
venta			9
empleados		6
proveedores		6
sucursales		6
compras			5
gasto			4
productos		3
tipodegasto		2
canalventa		1
*/

/* # 3
¿Se conocen las fuentes de los datos?
*/

### En la Homework nos aclara de donde provienen las tablas:
/*
La Dirección de Ventas ha solicitado las siguientes tablas a Marketing con el fin de que sean integradas:

La tabla de puntos de venta propios, un Excel frecuentemente utilizado para contactar a cada sucursal, actualizada en 2021.
La tabla de empleados, un Excel mantenido por el personal administrativo de RRHH.
La tabla de proveedores, un Excel mantenido por un analista de otra dirección que ya no esta en la empresa.
La tabla de clientes, alojada en el CRM de la empresa.
La tabla de productos, un Excel mantenido por otro analista.
Las tablas de ventas, gastos y compras, tres archivos CSV generados a partir del sistema transaccional de la empresa.
*/

/* # 4
Es importante revisar la consistencia de los datos. 
¿Se pueden relacionar todas las tablas al modelo?
*/
-- El modelo tiene las relaciones adecuadas entre las tablas, por lo que se podria decir
-- que las tablas estan perfectamente relacionadas


/* # 5
¿Cuáles son las tablas de hechos y las tablas dimensionales o maestros?
*/

/*
Con la siguiente consulta, podemos observar que la tabla 'venta' 
tiene la mayor cantidad de foreign keys asociadas en su estructura (5 fk), con lo que podemos afirmar
que es la fact table de nuestro modelo
*/
select
    table_name as tabla,
    count(*) as total
from
information_schema.table_constraints
where table_schema = 'empresa'
and constraint_type = 'FOREIGN KEY'
group by tabla
order by total desc;

/*
Las dimension tables o tablas de dimension de mi modelo serian las siguientes:
- canalventa
- clientes
- empleados
- gasto
- productos
- proveedores
- sucursales
- tipodegasto

Estas tablas de dimensiones tienen atributos descriptivos que proporcionan 
contexto y detalles sobre las medidas en la tabla de hechos 'venta'.
Por ejemplo, la tabla 'clientes' puede contener información sobre los clientes, como su nombre, dirección y categoría. 
La tabla 'productos' puede contener información sobre los productos, como el nombre, la categoría y el proveedor.
*/

/* # 6
Podemos hacer esa separación en los datos que tenemos (tablas de hecho y dimensiones)?
*/
-- Si es posible realizar una separación de las tablas en el modelo, asignando a la tabla
-- 'venta' como la "central", es decir la fact table y el resto como tablas de dimension que aporten caracteristicas
-- a la tabla venta.

/* # 7
¿Hay claves duplicadas?
*/

/*
Antes de hacer el ETL, algunas tablas venian con claves duplicadas, lo cual es un error. 
Para poder cumplir el rol de primary key en una tabla, las claves o mejor dicho los IDs,
deben ser irrepetibles ya que como su nombre expresa, son Identificadores Unicos.

Obviamente ahora ninguna tabla tiene claves duplicadas porque sino MySQL no me dejaria hacer ninguna operación
*/

/* # 8
¿Cuáles son variables cualitativas y cuáles son cuantitativas?
*/
-- Para hacerlo de una manera rapida para todas las tablas, creo una procedure:
DELIMITER //
create procedure TipoVariable(nombre_tabla varchar(100))
begin
	select
	column_name as Columna,
	data_type,
	case
		when data_type in ('tinyint', 'smallint', 'mediumint', 'int', 'bigint', 'float', 'double', 'decimal') then 'Cuantitativa'
		else 'Cualitativa'
		end as 'Tipo de Variable'
	from information_schema.columns
	where table_schema = 'empresa' and table_name = nombre_tabla;
end // DELIMITER ;

call TipoVariable('canalventa');
call TipoVariable('clientes');
call TipoVariable('compras');
call TipoVariable('empleados');
call TipoVariable('gasto');
call TipoVariable('productos');
call TipoVariable('proveedores');
call TipoVariable('sucursales');
call TipoVariable('tipodegasto');
call TipoVariable('venta');

/* # 9
¿Qué acciones podemos aplicar sobre las mismas?
*/

/*
Con las variables cuantitativas podemos utilizarlas para funciones de agregación como son SUM(), MAX(), MIN(), COUNT()
AVERAGE(), etc y gracias a las variables culitativas podemos filtrar datos con la clausula WHERE o HAVING y ademas podemos
agrupar datos con GROUP BY
*/

/* # 10
Normalizar los nombres de los campos y colocar el tipo de dato adecuado para cada uno en cada una de las tablas. 
Descartar columnas que consideres que no tienen relevancia.
*/

/*
En el momento del ETL en Python normalice las columnas y elimine columnas que sentia que no aportaban información
*/

-- En la tabla clientes la columna 'Marca_Baja' creo que no aporta demasiada info ya que todos los valores
-- son 0
select distinct Marca_Baja from clientes;

alter table clientes
drop column Marca_Baja;

/* # 11
Buscar valores faltantes y campos inconsistentes en las tablas sucursales, proveedores, empleados y clientes. 
De encontrarlos, deberás corregirlos o desestimarlos. Propone y realiza una acción correctiva sobre ese problema.
*/
-- Hay que normalizar los valores de las columnas 'Localidad' y 'Provincia'
select * from sucursales;

select distinct Localidad from sucursales;

update sucursales
set Localidad =
	case
		when Localidad in ("Cap. Federal",'Cap.   Federal','Cap. Fed.','CapFed','Capital','CABA') then 'Capital Federal'
        when Localidad in ('Cdad de Buenos Aires','Bs As','BsAs') then 'Ciudad de Buenos Aires'
        when Localidad in ('Coroba','Cba','CORDOBA','Cordoba','CBA') then 'Córdoba'
        else Localidad
	end;
    
select distinct Provincia from sucursales;
update sucursales
set Provincia =
	case
		when Provincia in ("Cap. Federal",'Bs.As. ','Cdad de Buenos Aires','Bs As','BsAs','Ciudad de Buenos Aires','Cap.   Federal','C deBuenos Aires','Bs.As','B. Aires','B.Aires','Provincia de Buenos Aires','Pcia Bs AS','Prov de Bs As.','Cap. Fed.','CapFed','Capital','CABA') then 'Buenos Aires'
        when Provincia in ('Coroba','Cba','CORDOBA','Cordoba','CBA') then 'Córdoba'
        else Provincia
	end;
    
/* # 12
Chequear la consistencia de los campos precio y cantidad de la tabla de ventas.
*/

select column_name, data_type
from information_schema.columns
where table_schema = 'empresa'
and table_name = 'venta'
and column_name = 'Precio';


select length(precio) as len, precio from venta group by 2 order by 2 desc;

-- limpieza para la columna precio. Seteando todos los valores maximos a 4 digitos a 4 digitos con dos decimales

update venta
set precio =
case
	when precio not like '%.%' and length(precio) = 8 then format(precio/10000,2)
	when precio not like '%.%' and length(precio) = 7 then format(precio/1000,2)
	when precio not like '%.%' and length(precio) = 6 then format(precio/100,2)
	when precio not like '%.%' and length(precio) = 5 then format(precio/10,2)
	else precio
end;

-- Agrego '.00' a los numeros enteros para convertirlos en decimales
update venta
set precio = concat(precio, '.00')
where precio not like '%.%';

-- Elimino las comas de los valores que la tienen
update venta
set precio = replace(precio,',','')
where precio like '%,%';

-- Agrego un 0 al ultimo para los numeros que tienen solo un decimal
update venta
set precio = concat(precio, '0')
WHERE LENGTH(SUBSTRING_INDEX(precio, '.', -1)) = 1;


-- Veo como quedaron los cambios
select DISTINCT length(precio) as Len, precio from venta group by 1,2 order by 1;

## Por seguridad,en vez de hacer un MODIFY COLUMN a decimal, creamos una nueva columna de tipo decimal 
## para insertar todos los valores de la columna precio.

alter table venta
add precio_decimal decimal(10,2);

update venta
set precio_decimal = cast(precio as decimal(10,2));

-- Visualizo como quedo la nueva columna
select IdVenta, precio, precio_decimal from venta;

-- Una vez que tenemos la nueva columna creada y asegurado de que se copiaron bien los datos, procedo a eliminar la columna vieja 'precio'
alter table venta
drop column precio;

alter table venta
rename column precio_decimal to Precio;

select * from venta limit 5;

-- La columna 'cantidad' tiene valores nulos, asi que los remplazaré a 0
update venta
set Cantidad = 0
where cantidad = " " or isnull(cantidad);

select distinct cantidad from venta;

/* # 13
Generar dos nuevas tablas a partir de la tabla 'empelado' que contengan las entidades Cargo y Sector.
*/
select * from empleados limit 5;

create table Sector(
	IdSector int not null auto_increment primary key,
    TipoSector varchar(70)
);

create table Cargo(
	IdCargo int not null auto_increment primary key,
    TipoCargo varchar(70)
);

insert into sector (TipoSector)
select distinct sector from empleados;

insert into cargo (TipoCargo)
select distinct cargo from empleados;

select * from sector;
select * from cargo;

-- Creo las tablas IdSector y IdCargo en la tabla empleados
alter table empleados
add column IdCargo int,
add column IdSector int,
add foreign key (IdCargo) references Cargo (IdCargo),
add foreign key (IdSector) references Sector (IdSector);

select * from empleados limit 5;

-- Actualizo los datos de las nuevas columnas
update empleados e
join cargo c
on e.Cargo = c.TipoCargo
set e.IdCargo = c.IdCargo;

update empleados e
join sector s
on e.Sector = s.TipoSector
set e.IdSector = s.IdSector;

select distinct cargo, sector, idcargo, idsector from empleados;

-- Elimino las columnas Cargo y Sector y dejo sus respectivos Id'SAVEPOINT
alter table empleados
drop column cargo,
drop column sector;

select * from empleados limit 10;

/* # 14
Generar una nueva tabla a partir de la tabla 'producto' que contenga la entidad Tipo de Producto.
*/

select * from productos limit 5;

create table TipoProducto(
	IdTipoProducto int not null auto_increment primary key,
    Tipo varchar(70)
);

insert into TipoProducto (Tipo)
select distinct tipo from productos;

select * from tipoproducto;

-- Agrego la columna IdTipoProducto a la tabla productos
alter table productos
add column IdTipoProducto int,
add foreign key (IdTipoProducto) references TipoProducto (IdTipoProducto);

-- Inserto los ids para la nueva columna
update productos p
join tipoproducto tp
on p.Tipo = tp.Tipo
set p.IdTipoProducto = tp.IdTipoProducto;

-- Elimino la columna Tipo ya que ahora es innecesaria
alter table productos
drop column tipo;

select * from productos;

/* Extra 
crear una columna llamada 'IdSucursal' para la tabla 'empleados' 
*/
select distinct table_name
from information_schema.columns
where table_schema = 'empresa'
and column_name like '%Sucursal%';

alter table empleados
add column IdSucursal int,
add foreign key (IdSucursal) references sucursales (IdSucursal);

update empleados e
join sucursales s
on e.Sucursal = s.Sucursal
set e.IdSucursal = s.IdSucursal;


