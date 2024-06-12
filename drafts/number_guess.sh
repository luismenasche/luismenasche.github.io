#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

NUMBER=$(( $RANDOM % 1000 + 1 ))
echo "Enter your username:"
read USERNAME
USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
if [[ -z $USER_ID ]]
then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  RESULT=$($PSQL "INSERT INTO users(username) VALUES ('$USERNAME')")
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
  GAMES_PLAYED=0
  BEST_GAME=0
else
  GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE username='$USERNAME'")
  BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE username='$USERNAME'")
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi
echo "Guess the secret number between 1 and 1000:"
read GUESS
NUM_GUESSES=1
while [[ $GUESS != $NUMBER ]]
do
  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
  else
    if (( $GUESS < $NUMBER ))
    then
      echo "It's higher than that, guess again:"
    else
      echo "It's lower than that, guess again:"
    fi
  fi
  NUM_GUESSES=$(( NUM_GUESSES + 1 ))
  read GUESS
done
echo "You guessed it in $NUM_GUESSES tries. The secret number was $NUMBER. Nice job!"
RESULT=$($PSQL "UPDATE users SET games_played = games_played + 1 WHERE user_id=$USER_ID")
if (( $BEST_GAME == 0 || $NUM_GUESSES < $BEST_GAME))
then
  RESULT=$($PSQL "UPDATE users SET best_game = $NUM_GUESSES WHERE user_id=$USER_ID")  
fi