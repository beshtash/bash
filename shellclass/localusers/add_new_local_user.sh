# add_new_local_user.sh

#!/bin/bash

# Make sure the script is being executed with superuser privileges.

if [[ "${UID}" -ne 0 ]]
then
  echo "Please use sudo privileges or be a root user."
fi

# If the user doesn't supply at least one argument, then give them help.

if [[ "${#}" -lt 1 ]] 
then
  echo "Usage: ${0} USER_NAME [COMMENT]..."
fi


# The first parameter is the user name.
USER_NAME="${1}"

#The rest of the parameters are for the account comments.

shift
COMMENT="${@}"


# Generate a password.

PASSWORD=$(date +%s%N | sha256sum | head -c12)

# Create the user with the password.

useradd -c "$COMMENT" -m "${USER_NAME}"

# Check to see if teh 'useradd' command succeeded.

if [[ "${?}" -ne 0 ]]
then
  echo "User can not be created."
  exit 1
fi

# Set the password.

echo "${PASSWORD}" | passwd --stdin "${USER_NAME}"

# Check to see if the 'passwd' command succeeded.

if [[ ${?} -ne 0 ]]
then
  echo "Password can not be set."
fi

# Force password change on first login.

passwd --expire ${USER_NAME}

# Display the username, password, and the host where the user was created.

echo " username: ${USER_NAME}, password: ${PASSWORD}, host: ${HOSTNAME}"


