#!/usr/bin/env bash

echo "Which vegetable"

select vegetable in "pumpkin" "tomato" "cucumber"
do
	echo "You selected $vegetable"
	break # It's important to break, or the loop will continue forever
done
