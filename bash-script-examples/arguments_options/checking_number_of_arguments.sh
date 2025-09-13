#!/usr/bin/env bash

if (($#<3)); then
	echo "This command requires three arguments:"
	echo "username, userid, and favourite number"
else
	# the program goes here
	echo "username: $1"
	echo "userid: $2"
	echo "favourite number: $3"
fi
