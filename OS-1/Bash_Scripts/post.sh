#! /bin/bash

echo "please enter the key"
read key
echo "please enter the value"
read string
cipher=$(echo "$string"| base64)

echo "$key : $cipher " >> $1 