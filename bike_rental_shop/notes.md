### Bash
#### Case steatement

```
case EXPRESSION in
  PATTERN) STATEMENTS ;;
  PATTERN) STATEMENTS ;;
  PATTERN) STATEMENTS ;;
  *) STATEMENTS ;;
esac
```


#### Echo a while loop
This will pipe the output of the echo call. There each word is assigned one of the `<varI>` variables which then can be used in the statements block.
```
 echo <var> | while read <var1> <var2> <var3> <var4> <var5>
    do
      statements
    done
```

#### Check if input is a number

This regexp expression checks if the the variable `$VAR` only consists of one or more numbers:
```
[[ $VAR =~ ^[0-9]+$ ]]
```

If you want to negate that expression add an `!` in front of the expression, but beware the needed spaces in bash.

```
[[ ! $VAR =~ ^[0-9]+$ ]]
```

### PSQL
#### Connect to psql remotely for this course
```
psql --username=freecodecamp --dbname=postgres
```

#### Exporting/Dumping a database

Exmaple on how to export the database with a given name `<name>`.
```bash
pg_dump -cC --inserts -U freecodecamp <name> > <name>.sql

# Example:
# pg_dump -cC --inserts -U freecocecamp bikes > bikes.sql
```

#### Rebuild database

```bash
psql -U postgres < <name>.sql

# Example:
# psql -U postgres < bikes.sql
```


## Error Handling
When you encounter this error:
```bash
psql: error: connection to server at "127.0.0.1", port 5432 failed: Connection refused
```

You can solve this by
1. Dump the current database (see above).
2. Restart the postgresql service with:
```
sudo service postgresql restart
```
3. Create the freecodecamp user role again:
```bash
echo "SELECT 'CREATE USER freecodecamp WITH CREATEDB' WHERE NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname='freecodecamp')\gexec" | psql -U postgres -X
```
4. Rebuild the database again (see above).
