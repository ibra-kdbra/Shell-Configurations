#!/usr/bin/env bash

myvar="Hello!"
echo "The value of the myvar variable: $myvar"

myvar="Bonjour!"
echo "The value of the myvar variable: $myvar"

# This is going to be a constant
declare -r myname="Wall-E"
echo "My name is $myname"

myname="Eva"
echo "My name is $myname"

# This is used for declaring lowercase variables
declare -l lowerstring="This is some TEXT"
echo "The value of the lowerstring variable: $lowerstring"

lowerstring="value CHANGED"
echo "The value of the lowerstring variable: $lowerstring"

# Uppercase text can be declared via declare -u
