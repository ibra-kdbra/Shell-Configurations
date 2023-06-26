#! /bin/bash

if [ "$1" == "--create" ];
then
        cat > $2
        echo "version 1 FMAB" > "./$2"
        DB=$2
else
        DB=$1
fi

while [ "$var" != "0" ];
do
    bash "/home/farouq/Documents/Bash_Scripts/option.sh"
    read option

    case $option in
    1)
    echo "*********"
    bash "/home/farouq/Documents/Bash_Scripts/post.sh" $DB
    ;;
    2)
    echo "*********"
    bash "/home/farouq/Documents/Bash_Scripts/trash.sh" $DB
    ;;
    3)
    echo "*********"
    bash "/home/farouq/Documents/Bash_Scripts/find.sh" $DB
    ;;
    4)
    echo "*********"
    bash "/home/farouq/Documents/Bash_Scripts/update.sh" $DB
    ;;
    0)
    echo "Breaking..."
    ;;
    *)
    echo "try again"
    ;;
    esac

done
