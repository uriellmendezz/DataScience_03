
# Homework Clase 2

Con el objetivo de asegurarse de que la calidad de la información con la que se va a trabajar sea la óptima, es necesario realizar una lista de propuestas de mejora teniendo en cuenta los siguientes puntos:

1) ¿Qué tan actualizada está la información? ¿La forma en que se actualiza ó mantiene esa información se puede mejorar?
2) ¿Los datos están completos en todas las tablas?
3) ¿Se conocen las fuentes de los datos?
4) Es importante revisar la consistencia de los datos. ¿Se pueden relacionar todas las tablas al modelo? 
5) ¿Cuáles son las tablas de hechos y las tablas dimensionales o maestros? 
6) ¿Podemos hacer esa separación en los datos que tenemos (tablas de hecho y dimensiones)? 
7) ¿Hay claves duplicadas? 
8) ¿Cuáles son variables cualitativas y cuáles son cuantitativas? 
9) ¿Qué acciones podemos aplicar sobre las mismas?

### Limpieza, Valores faltantes

10) Normalizar los nombres de los campos y colocar el tipo de dato adecuado para cada uno en cada una de las tablas. Descartar columnas que consideres que no tienen relevancia.
11) Buscar valores faltantes y campos inconsistentes en las tablas sucursal, proveedor, empleado y cliente. De encontrarlos, deberás corregirlos o desestimarlos. Propone y realiza una acción correctiva sobre ese problema.
12) Chequear la consistencia de los campos precio y cantidad de la tabla de ventas.
13) Chequear que no haya claves duplicadas, y de encontrarla en alguna de las tablas, proponer una solución.

### Normalización

14) Generar dos nuevas tablas a partir de la tabla 'empelado' que contengan las entidades Cargo y Sector.
15) Generar una nueva tabla a partir de la tabla 'producto' que contenga la entidad Tipo de Producto.

### Sugerencia:

#### Instrucción INSERT:

Es posible usarla a partir del resultado de otra consulta. Por ejemplo:

```SQL
INSERT INTO cargo (Cargo) 
SELECT DISTINCT Cargo 
FROM empleado 
ORDER BY Cargo;
```

#### Instrucción UPDATE:

Es posible usarla a partir del resultado del resultado de una consulta de la tabla a modificar y otra/s tabla/s. Por ejemplo:

```SQL
UPDATE empleado e JOIN cargo c 
    ON (c.Cargo = e.Cargo)
SET e.IdCargo = c.IdCargo;
```