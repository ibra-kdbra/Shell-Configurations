#!/usr/bin/env bash

# A colon after each option name means that the script will expect a value assigned to it.
# If an option is specified without a colon after it, that would mean we want to check if the flag is present.
# Adding a colon in front of any options (on its own) is used to determine which unspecified flags were used.

while getopts :u:p:ab option; do
	case $option in
		u) user=$OPTARG;;
		p) pass=$OPTARG;;
		a) echo "got the A flag";;
		b) echo "got the B flag";;
		?) echo "Unknown option - $OPTARG";;
	esac
done

echo "user: $user / pass: $pass"
