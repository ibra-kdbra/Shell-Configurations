#!/usr/bin/env bash

# -e allows to put a placeholder text and help the user avoid an empty response

read -ep "Favourite colour? " -i "Blue" favcolour

echo $favcolour
