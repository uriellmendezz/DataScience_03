
# Homework Class 2

In order to ensure that the quality of the information with which you are going to work is optimal, it is necessary to make a list of improvement proposals taking into account the following points:

1) How up to date is the information? Can the way in which this information is updated or maintained be improved?
2) Is the data complete in all tables?
3) Are the sources of the data known?
4) It is important to check the consistency of the data. Can all the tables be related to the model?
5) What are fact tables and dimensional or master tables?
6) Can we do this separation in the data we have (dimension and fact tables)?
7) Are there duplicate keys?
8) Which are qualitative variables and which are quantitative?
9) What actions can we apply on them?

### Cleanup, Missing Values

10) Normalize the names of the fields and place the appropriate data type for each one in each of the tables. Discard columns that you consider to be irrelevant.
11) Find missing values and inconsistent fields in the branch, vendor, employee, and customer tables. If you find them, you must correct or dismiss them. Proposes and performs corrective action on that problem.
12) Check the consistency of the price and quantity fields of the sales table.
13) Check that there are no duplicate keys, and if found in any of the tables, propose a solution.

### Normalization

14) Generate two new tables from the 'empleado' (employee) table that contain the entities Position and Sector.
15) Generate a new table from the 'product' table that contains the Product Type entity.

### Suggestion:

#### INSERT statement:

It is possible to use it from the result of another query. For example:

```SQL
INSERT INTO charge (Charge)
SELECT DISTINCT Position
FROM employee
ORDER BY Charge;
```

#### UPDATE statement:

It is possible to use it from the result of the result of a query of the table to be modified and another table/s. For example:

```SQL
UPDATE employee and JOIN position c
     ON (c.Charge = e.Charge)
SET e.IdCargo = c.IdCargo;
```