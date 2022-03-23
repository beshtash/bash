#!/bin/bash

read -p "What is your first name?: " firstname
read -p "What is your last name?: " lastname
PS3="Select the type of a phone: "
select phone_type in headset handheld;
do
	echo "The selected type of phone is: $phone_type"
	break
done
PS3="Select the department: "
select dept in "finance" "sales" "customer service" "engineering":
do 
	echo "Your department is: $dept"
	break
done
read -N 4 -p "What is your current extension number? (must be 4 digits): " ext
echo
read -N 4 -s -p "What access code would you like to use? (must be 4 digits): " access
echo
echo "$firstname,$lastname,$ext,$access,$phone_type,$dept" >> extensions.csv
