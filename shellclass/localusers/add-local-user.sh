# Make sure the script is being executed with superuser privileges

if [[ "${UID}" -ne 0 ]]; then echo "Please run with sudo or as root."; exit 1; fi

# Get the username(login).

read -p "Please enter your user name: " USER_NAME

# Get the real name (contents for the description field).

read -p "Please enter your name and last name: " COMMENT

# Get the password.

read -p "Please enter your password: " PASSWORD

# Create user with password.

useradd -c "${COMMENT}" -m "${USER_NAME}" 

# Check to see if the useradd command succeeded.

if [[ "${?}" -ne 0 ]] 
then 
  echo "User can not be created."
  exit 1
fi

# Set the password 

echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Check to see if the passwd command succeeded.

if [[ "${?}" -ne 0 ]]
then
  echo "Password is not set"
  exit 1
fi

# Force password change on first login.

passwd -e ${USER_NAME}

# Display the username, password, and the host where the user was created.

echo "Username: ${USER_NAME}"
echo "Password: ${PASSWORD}"
echo "Hostname: ${HOSTNAME}" 

