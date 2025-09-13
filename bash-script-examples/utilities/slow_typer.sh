#!/usr/bin/env bash

while read line
do
    grep -o . <<<$line | while read a
    do
        sleep 0.1
        echo -n "${a:- }"
    done
    echo
done
