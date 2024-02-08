#!/bin/bash

HOST="127.0.0.1"
USER="jamal"
PASSWORD="****"

SOURCE=$1
ALL_FILES="${@:2}"

ftp -inv $HOST <<EOF
user $USER $PASSWORD
cd $SOURCE
mget $ALL_FILES
bye
EOF
