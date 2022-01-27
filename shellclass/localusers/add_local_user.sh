

#!/bin/bash

# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" -ne 0 ]]
then
  echo 'Please run with sudo or as a root.'
  exit 1
fi

chmod +x add_local_user.sh

# Get the user name

read -p "Please enter your user name: " USER_NAME

# Get the real name

read -p "Please enter your name: " COMMENT

# Get the password

read -p "Please enter your password: " PASSWORD

# Create the user with the password 
useradd -c "${COMMENT}" -m ${USER_NAME}

echo ${PASSWORD} | passwd --stdn ${USER_NAME}

passwd --expire ${USER_NAME}


echo ${USER_NAME} ${PASSWORD} ${HOSTNAME}
