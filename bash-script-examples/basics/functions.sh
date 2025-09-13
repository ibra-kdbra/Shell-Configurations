#!/usr/bin/env bash

function greet() {
	echo "Hi there, $1!"
}

echo "Calling a function..."
greet Jana

# -------------------------

function numberthings() {
	declare -i i=1

	for f in $@; do
		echo "$i: $f"
		(( i += 1 ))
	done

	echo "Items were numbered using $FUNCNAME"
}

echo "Numbering directories in root..."
numberthings $(ls /)

echo "Numbering a list of things..."
numberthings pine birch maple spruce
