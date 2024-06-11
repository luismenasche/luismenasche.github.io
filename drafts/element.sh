#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --no-align -t -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    RESULT_ID=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
  else
    RESULT_ID=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1' OR name='$1'")
  fi
  if [[ -z $RESULT_ID ]]
  then
    echo "I could not find that element in the database."
  else
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$RESULT_ID")
    NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$RESULT_ID")
    TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$RESULT_ID")
    MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$RESULT_ID")
    MELTING=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$RESULT_ID")
    BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$RESULT_ID")
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID") 
    echo "The element with atomic number $RESULT_ID is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
  fi
fi