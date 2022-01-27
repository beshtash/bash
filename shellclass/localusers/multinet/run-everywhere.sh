#!/bin/bash 

# A list of servers, one per line.

SERVER_LIST='/vagrant/servers'

# Options for the ssh command.

SSH_OPTIONS='-o ConnectTimeout=2'

usage(){
  # Display the usage and exit.
  echo "Usage: ${0} [-nsv] [-f FILE] command" >&2
  echo 'Executes COMMAND as a single command on every server.' >&2
  echo " -f FILE Use FILE for the list of servers. Default ${SERVER_LIST}." >&2
  echo ' -f      Dry run mode. Display the COMMAND that would have been executed and exit.' >&2
  echo ' -s      Execute the COMMAND using sudo on the remote server.' >&2
  echo ' -v      Verbose mode. Displays the server name before executing COMMAND.' >&2
  exit 1
}

# Make sure the script is not being executed with superuser privileges.

if [[ "${UID}" -ne 0 ]]
then
  echo "Do not execute this script as root user. Use -s option instead." >&2
  usage
fi

# Parse the options.

while getopts f:nsv OPTION
do
  case ${OPTION} in
    f) SERVER_LIST="${OPTARG}" ;;
    n) DRY_RUN='true' ;;
    s) SUDO='sudo' ;;
    v) VERBOSE='true' ;;
    ?) usage ;;
  esac
done

# Remove the options while leaving the remaining arguments.
shift "$(( OPTIND - 1 ))"

# If the user doesn't supply at least one argument, give then help.

if [[ "${#}" -lt 1 ]]
then
  usage
fi


	
