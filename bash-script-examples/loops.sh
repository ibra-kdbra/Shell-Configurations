#!/usr/bin/env bash

# set -x

echo "While loop"

declare -i n=0
while (( n < 10 )); do
	echo "n: $((n+1))"
	(( n++ ))
done

# -------------------------------------------

echo -e "\nUntil loop"

declare -i m=0
until (( m==10 ))
do
	echo "m:$m"
	(( m++ ))
	#sleep 1
done

# -------------------------------------------

echo -e "\nFor loop (for each)"

for i in {1..100}
do
	echo "i: $i"
done

# -------------------------------------------

echo -e "\nFor loop (C style)"

for (( i=1; i<=100; i++ ))
do
	echo "i: $i"
done

# -------------------------------------------

echo -e "\nFor loop through an array"

declare -a fruits=("apple" "banana" "cherry")
for i in ${fruits[@]}
do
	echo "Current fruit is: $i"
done

# -------------------------------------------

echo -e "\nFor loop through results of a command"

for i in $(ls)
do
	echo "Current file is: $i"
	sleep 1
done
