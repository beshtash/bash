#!/bin/bash

# This script, upon invocation, shows the time and date, lists all logged-in users, and
#+ gives the system uptime.

# Current time and date
echo $(date)
echo 
# List all logged-in users

w
echo 
# shows uptime of the system

echo $(uptime)
echo 
exit 0


