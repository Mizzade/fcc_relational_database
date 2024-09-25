# Notes

### Capitalize all values in a text/varchar column
```postgresql
UPDATE <table_name> SET <column_name> = INITCAP(<column_name>);

-- Example: Table `elements` with column `symbol`
-- UPDATE elements SET symbol = INITCAP(symbol);
```

### Create column that is references another table's column
```postgresql
ALTER TABLE <table_name> ADD COLUMN <column_name> <data_type> REFERENCES <other_table_name>(<other_column_name>);

-- Example:
-- table properties with column type_id of type int. (references)
-- other table types with column type_id of type int.
ALTER TABLE properties ADD COLUMN type_id int REFERENCES types(type_id);
```

### Fill a reference column with the references values from another table

Given the table `types`:
```
 type_id |   type
---------+-----------
       1 | nonmetal
       2 | metal
       3 | metalloid
```

Given the table `properties`:
```
 atomic_number |   type    | atomic_mass | melting_point_celsius | boiling_point_celsius | type_id
---------------+-----------+-------------+-----------------------+-----------------------+---------
             1 | nonmetal  |    1.008000 |                -259.1 |                -252.9 |
             2 | nonmetal  |    4.002600 |                -272.2 |                  -269 |
             3 | metal     |    6.940000 |                180.54 |                  1342 |
             4 | metal     |    9.012200 |                  1287 |                  2470 |
             5 | metalloid |   10.810000 |                  2075 |                  4000 |
             6 | nonmetal  |   12.011000 |                  3550 |                  4027 |
             7 | nonmetal  |   14.007000 |                -210.1 |                -195.8 |
             8 | nonmetal  |   15.999000 |                  -218 |                  -183 |
          1000 | metalloid |    1.000000 |                    10 |                   100 |
```

Fill the column `type_id` so that:
```
 atomic_number |   type    | atomic_mass | melting_point_celsius | boiling_point_celsius | type_id
---------------+-----------+-------------+-----------------------+-----------------------+---------
             1 | nonmetal  |    1.008000 |                -259.1 |                -252.9 |       1
             2 | nonmetal  |    4.002600 |                -272.2 |                  -269 |       1
             3 | metal     |    6.940000 |                180.54 |                  1342 |       2
             4 | metal     |    9.012200 |                  1287 |                  2470 |       2
             5 | metalloid |   10.810000 |                  2075 |                  4000 |       3
             6 | nonmetal  |   12.011000 |                  3550 |                  4027 |       1
             7 | nonmetal  |   14.007000 |                -210.1 |                -195.8 |       1
             8 | nonmetal  |   15.999000 |                  -218 |                  -183 |       1
          1000 | metalloid |    1.000000 |                    10 |                   100 |       3
```

```postgresql
UPDATE <table_name>
SET <column_name> = <other_table><other_column_name>
FROM <other_table>
WHERE <table_name>.<column_name> = <other_table>.<other_column_name>

-- Example above:
UPDATE properties
SET type_id = t.type_id
FROM types t
WHERE properties.type = t.type;
```

### Change the type of a numeric column to real and convert the values
Given the table `properties`:
```
 atomic_number |   type    | atomic_mass | melting_point_celsius | boiling_point_celsius | type_id
---------------+-----------+-------------+-----------------------+-----------------------+---------
             8 | nonmetal  |   15.999000 |                  -218 |                  -183 |       1
             7 | nonmetal  |   14.007000 |                -210.1 |                -195.8 |       1
             6 | nonmetal  |   12.011000 |                  3550 |                  4027 |       1
             2 | nonmetal  |    4.002600 |                -272.2 |                  -269 |       1
             1 | nonmetal  |    1.008000 |                -259.1 |                -252.9 |       1
             4 | metal     |    9.012200 |                  1287 |                  2470 |       2
             3 | metal     |    6.940000 |                180.54 |                  1342 |       2
          1000 | metalloid |    1.000000 |                    10 |                   100 |       3
             5 | metalloid |   10.810000 |                  2075 |                  4000 |       3
```

Convert it to:
```
 atomic_number |   type    | atomic_mass | melting_point_celsius | boiling_point_celsius | type_id
---------------+-----------+-------------+-----------------------+-----------------------+---------
             8 | nonmetal  |      15.999 |                  -218 |                  -183 |       1
             7 | nonmetal  |      14.007 |                -210.1 |                -195.8 |       1
             6 | nonmetal  |      12.011 |                  3550 |                  4027 |       1
             2 | nonmetal  |      4.0026 |                -272.2 |                  -269 |       1
             1 | nonmetal  |       1.008 |                -259.1 |                -252.9 |       1
             4 | metal     |      9.0122 |                  1287 |                  2470 |       2
             3 | metal     |        6.94 |                180.54 |                  1342 |       2
          1000 | metalloid |           1 |                    10 |                   100 |       3
             5 | metalloid |       10.81 |                  2075 |                  4000 |       3
```

```postgresql
ALTER TABLE <table_name> ALTER COLUMN <column_name> TYPE <type> USING (<column_name>::<type>);

-- Example above:
ALTER TABLE properties ALTER COLUMN atomic_mass TYPE REAL USING (atomic_mass::real);
```
