#! /bin/bash

echo "enter key :"
read cle

while IFS= read -r line;
do 
    if [ $(echo "$line" | awk '{print $1}') == "$cle" ];
    then 
    echo "$line"
    fi
    done < $1