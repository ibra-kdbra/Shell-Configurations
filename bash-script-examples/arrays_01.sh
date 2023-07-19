#!/usr/bin/env bash

# Implicit array creation
snacks=("apple" "banana" "orange")

# Explicit array creation
declare -a snacks=("apple" "banana" "orange")

# Set an element to the specified position
snacks[5]="grapes"

# Add an element to the end of an array
snacks+=("mango")

echo "The second element in the snacks array is ${snacks[2]}"

# Printing out all elements in the array (it doesn't show empty elements)
echo "Snacks: ${snacks[@]}"

# Printing out all elements (including empty ones)
for i in {0..6}
do echo "$i: ${snacks[$i]}"
done

# Associative array (maps / dictionaries)
declare -A office
office["city"]="Novgorod"
office["building name"]="HQ East"
