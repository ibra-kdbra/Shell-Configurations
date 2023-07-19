#!/usr/bin/env bash

read -p "Favourite animal? [cat] " fav

while [[ -z $fav ]]
do
	fav = cat
done

echo "$fav was selected."
