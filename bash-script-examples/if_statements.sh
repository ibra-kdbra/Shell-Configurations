#!/usr/bin/env bash

declare -i a=3

# Using extended test notation
if [[ $a -gt 4 ]]; then
	echo "$a is greater than 4"
else 
	echo "$a is not greater than 4"
fi

# Using arithmetic evaluation
if (( $a > 4 )); then
	echo "$a is greater than 4"
elif (( $a > 2 )); then
	echo "$a is greater than 2"
else 
	echo "$a is not greater than 4"
fi
