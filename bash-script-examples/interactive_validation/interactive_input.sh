#!/usr/bin/env bash

echo "What is your name?"
read name

echo "What is your password?"
read -s pass

read -p "What's your favourite vegetable? " vegetable

echo -e "\n=== Your data ==="
echo "Name: $name"
echo "Password: $pass"
echo "Favourite vegetable: $vegetable"
