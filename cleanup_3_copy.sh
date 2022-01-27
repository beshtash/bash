#!/bin/bash

# Cleanup, version 3.

LOG_DIR=/home/dastan/Workspace/bash/temp 
ROOT_UID=0       # Only users with $UID 0 have root priveleges.
LINES=50         # Default number of lines saved.
E_XCD=86         # Can't change directory?
E_NOTROOT=87     # Non-root exit error.

# Run as root, of course.

if [ "${UID}" -ne "$ROOT_UID" ]
then
    echo "Must be root to run this script."
    exit $E_NOTROOT
fi

# Test whether command-line argument is present (non-empty).
if [ -n ${1} ]
then
    lines=$1
else
    lines=$LINES
fi

cd $LOG_DIR

# Make sure you execute commands in /var/log directory.

if [ $(pwd) != "$LOG_DIR" ]  #or if [ "$PWD" != "$LOG_DIR" ]
then
    echo "Can't change to $LOG_DIR."
    exit $E_XCD
fi

tail -n $lines messages > mesg.temp # Save last session of message log file.
mv mesg.temp messages               # Rename it as system log file.

cat /dev/null: > wtmp 

echo "Log files cleaned!"
exit 0


