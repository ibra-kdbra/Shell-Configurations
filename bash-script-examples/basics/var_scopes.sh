#!/usr/bin/env bash

var1="I'm a global variable 1"

myfunction() {
	var2="I'm a global variable 2"
	local var3="I'm a local variable 3 (but kind of 1)"
}

# Setting variables
myfunction

echo $var1
echo $var2
echo $var3
