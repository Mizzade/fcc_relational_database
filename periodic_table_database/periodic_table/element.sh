#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

MSG_PROVIDE_ELEMENT_AS_ARGUMENT="Please provide an element as an argument."
MSG_ELEMENT_NOT_FOUND="I could not find that element in the database."
QUERY_BASE="SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id)"


# if no argument was passed to the script
if [[ -z $1 ]]
then
  echo "$MSG_PROVIDE_ELEMENT_AS_ARGUMENT"
else
  # if argument was a number
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    WHERE_CLAUSE="WHERE atomic_number = $1;"

  # if argument is a string (element name)
  elif [[ $1 =~ ^[A-Z][a-z]{2,}$ ]]
  then
    WHERE_CLAUSE="WHERE name = '$1';"

  # if argument is a string (element symbol)
  elif [[ $1 =~ ^[A-Z][a-z]?$ ]]
  then
    WHERE_CLAUSE="WHERE symbol = '$1';"
  fi

  # if argument did not match a valid number or string input
  if [[ -z $WHERE_CLAUSE ]]
  then
    # print error message
    echo "$MSG_ELEMENT_NOT_FOUND"
  else
    # get element from DB
    ELEMENT_INFO=$($PSQL "$QUERY_BASE $WHERE_CLAUSE")

    # if element not found
    if [[ -z $ELEMENT_INFO ]]
    then
      # print error message
      echo "$MSG_ELEMENT_NOT_FOUND"
    else
      # extract element data
      # use IFS (Internal Field Separator) to split based on '|'
      # <<< operator is know ans `here string`. It feeds a string directly into the standard input (stdin) of a command.
      # <<< "some string" feeds the string "some string" to the command on its left.
      # It is equivalent to using echo "some string" | some_command
      IFS='|' read -r ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT_IN_CELSIUS BOILING_POINT_IN_CELSIUS <<< "$ELEMENT_INFO"

      # print element info
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_IN_CELSIUS celsius and a boiling point of $BOILING_POINT_IN_CELSIUS celsius."
    fi
  fi
fi

