#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=salon -X --tuples-only -c"

SERVICES=$($PSQL "SELECT * FROM services")

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e $1
  fi
  echo "$SERVICES" | while read SERVICE_ID BAR SERVICE_NAME
  do
    echo "$SERVICE_ID) $SERVICE_NAME"
  done
}

echo -e "\n~~~~~ MY SALON ~~~~~"
echo -e "\nWelcome to My Salon, how can I help you?\n"
MAIN_MENU
read SERVICE_ID_SELECTED
SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
while [[ -z $SERVICE_NAME ]]
do
  MAIN_MENU "\nI could not find that service. What would you like today?"
  read SERVICE_ID_SELECTED
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
done
echo -e "\nWhat's your phone number?"
read CUSTOMER_PHONE
CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
if [[ -z $CUSTOMER_NAME ]]
then
  echo -e "\nI don't have a record for that phone number, what's your name?"
  read CUSTOMER_NAME
  INSERT_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES ('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
fi
CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE name='$CUSTOMER_NAME'")
echo -e "\nWhat time would you like your cut, Fabio?"
read SERVICE_TIME
INSERT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
