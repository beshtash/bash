#!/bin/bash

# Cleanup, version 3.

LOG_DIR=/home/dastan/Workspace/bash/temp

ROOT_UID=0  # Root UID 0.
LINES=40    # Number of lines that should be saved before clean-up.
E_XCD=86    # Can't change directory?
E_NOTROOT=87 # Not root error.

# Check if the user is root or has root privileges

if [ "$UID" -ne "$ROOT_UID" ] 
then
	echo "Must be root to run this script."
	exit $E_NOTROOT
fi

# Check if $1 argument is not empty

        E_WRONGARGS=85
	case "$1" in
	""	 ) lines=$LINES;;
	*[!0-9]*   ) echo "USAGE: $(basename $0) lines-to-cleanup";
	exit $E_WRONGARGS;;
	*          ) lines=$1
         esac
         
#if [ -n "$1" ]
#then
#	lines=$1
#else
#	lines=$LINES
#lsfi

# Make sure you change directoru to '/home/dastan/Workspace/bash/temp'.

if [ $(pwd) != "$LOG_DIR" ]
then
	echo "Can't change into $LOG_DIR."
	exit $E_XCD
fi

# Copy last 40 lines of 'messages' to messages itself.

tail -n $lines messages > msg.temp 
mv msg.temp messages

cat /dev/null > messages_other

exit 0
