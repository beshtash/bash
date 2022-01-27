#!/bin/bash

# Prompt for a number and check that it is no greater than ten.

printf "Enter a number no greater than 10: "
read number 

if [ "$number" -gt 10 ]
then
  printf "%d is too big\n" "$number" >&2
  exit 1
else
  printf "You entered %d\n" "$number"
fi



printf "Enter a number between ten and twenty: "
read number

if [ "${number}" -lt 10 ]
then
  echo "You entered  the number that is less than 10" >&2
  #echo "Please enter a number between 10 and 20: "
  #read number
elif [ ${number} -gt 20 ]
then
  echo "You entered ${number} which is greater than 20." >&2
  #echo "Please enter any number between 10 and 20: "
  #read number
else
  echo "You entered $number."
fi
