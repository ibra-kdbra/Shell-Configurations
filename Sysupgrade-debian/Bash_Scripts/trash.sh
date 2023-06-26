#! /bin/bash

echo "please enter the key"
read cle
sed -i "/$cle/d" $1