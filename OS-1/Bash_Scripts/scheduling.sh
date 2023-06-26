#! /bin/bash

    case $2 in
    1)
    crontab -l > temp
    echo "0 0 * * * /home/farouq/Documents/Bash_scripts/backup.sh /home/farouq/Documents/$1 $3 $5 /home/farouq/Documents/Backups/ --max $4" >>temp
    crontab temp
    rm temp
    echo "Adding (daily backup.sh job to database $1 --outputdir /home/farouq/Documents/Backups/$3/ --max $4)"
    ;;
    2)
    crontab -l > temp
    echo "0 0 * * 0 /home/farouq/Documents/Bash_scripts/backup.sh /home/farouq/Documents/$1 $3 $5 /home/farouq/Documents/Backups/ --max $4" >>temp
    crontab temp
    rm temp
    echo "Adding (weekly backup.sh job to database $1 --outputdir /home/farouq/Documents/Backups/$3/ --max $4)"
    ;;
    *)
    crontab -l > temp
    echo "0 0 1 * * /home/farouq/Documents/Bash_scripts/backup.sh /home/farouq/Documents/$1 $3 $5 /home/farouq/Documents/Backups/ --max $4" >>temp
    crontab temp
    rm temp
    echo "Adding (monthly backup.sh job to database $1 --outputdir /home/farouq/Documents/Backups/$3/ --max $4)"
    ;;
    esac