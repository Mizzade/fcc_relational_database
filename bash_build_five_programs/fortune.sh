#!/bin/bash

# Program to tell a persons fortune

echo -e "\n~~ Fortune Teller ~~\n"

RESPONSES=("Yes" "No" "Maybe" "Outlook good" "Don't count on it" "Ask again later")
N=$(( $RANDOM % 6 ))

GET_FORTUNE() {
  echo Ask a yes or no question:
  read QUESTION
}

GET_FORTUNE

until [[ $QUESTION =~ \?$ ]]
do
  if [[ ! $1 ]]
  then
    echo Try again. Make sure it ends with a question mark:
  else
    echo
  fi
  GET_FORTUNE again
done

echo -e "\n${RESPONSES[$N]}"
