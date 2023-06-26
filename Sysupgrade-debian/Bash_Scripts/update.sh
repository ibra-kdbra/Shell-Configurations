#! /bin/bash

echo "please enter the key"
read cle
echo "please enter the value"
read val
cipher=$(echo "$val"| base64)

while IFS= read -r line;
do 
    if [ $(echo "$line" | awk '{print $1}') == "$cle" ];
    then 
    sed -i "s/$line/$(echo "$cle : $cipher")/" $1
    fi
done < $1