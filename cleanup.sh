#!/bin/bash

#Proper header for a Bash script.

# Cleanup, version 2.

# Run as root, of course.
# Insert code here to print error message and exit if not root.

LOG_DIR=/var/log
# Variables are better than hard_coded values.
cd $LOG_DIR

cat /dev/null > messages
cat /dev/null > wtmp

echo "Logs cleaned up."

exit # The right and proper method ot "exiting" from a script.
     # A bare "exit" (no parameters) returns the exit status
     #+ of the preceding command.
