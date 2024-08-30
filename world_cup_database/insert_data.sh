#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "truncate games, teams;")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  # omit first line in .csv
  if [[ $YEAR != year ]]
  then
    # get winner_id
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER';")

    # if not found
    if [[ -z $WINNER_ID ]]
    then
      # insert winner_id
      INSERT_WINNER_ID_RESULT=$($PSQL "INSERT INTO teams(name) VALUES ('$WINNER');")

      if [[ $INSERT_WINNER_ID_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into teams: $WINNER
      fi
    fi

    # get new winner_id
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER';")

    # get opponent_id
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT';")

    # if not found
    if [[ -z $OPPONENT_ID ]]
    then
      # insert opponent_id
      INSERT_OPPONENT_ID_RESULT=$($PSQL "INSERT INTO teams(name) VALUES ('$OPPONENT');")

      if [[ $INSERT_OPPONENT_ID_RESULT == "INSERT 0 1" ]]
      then
        echo "Inserted into teams: $OPPONENT"
      fi
    fi

    # get new opponent_id
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT';")


    # insert new game
    INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS);")

    if [[ $INSERT_GAME_RESULT == "INSERT 0 1" ]]
    then
      echo "Inserted into games: ($YEAR, $ROUND, $WINNER, $OPPONENT, $WINNER_GOALS, $OPPONENT_GOALS)"
    fi
  fi
done
