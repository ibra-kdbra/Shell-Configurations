#! /bin/bash

while [ "$var" != "0" ];
do
    bash "/home/farouq/Documents/Bash_Scripts/option_2.sh"
    read option

    case $option in
    1)
    echo "Please enter backup name :"
    read bam

    echo "1)gzip  2)rar  3)tar  default) zip"
    echo "Choose the format :"
    read file
    echo "***********"

        case $file in
        1)
        echo "*********"
        bash "/home/farouq/Documents/Bash_Scripts/backup.sh" $1 $bam "/home/farouq/Documents/Backups/" "gz"
        ;;
        2)
        echo "*********"
        bash "/home/farouq/Documents/Bash_Scripts/backup.sh" $1 $bam "/home/farouq/Documents/Backups/" "rar"
        ;;
        3)
        echo "*********"
        bash "/home/farouq/Documents/Bash_Scripts/backup.sh" $1 $bam "/home/farouq/Documents/Backups/" "tar" 
        ;;
        *)
        echo "*********"
        bash "/home/farouq/Documents/Bash_Scripts/backup.sh" $1 $bam "/home/farouq/Documents/Backups/" "zip"
        ;;
        esac
    echo "Backup done : (/home/farouq/Documents/Backups/$bam/)"
    ;;
    2)
    echo "Choose from the following backup folders to get back :"
    ls -l /home/farouq/Documents/Backups/
    read doc
    echo "choose version of the backup files :"
    ls -l ./Backups/$doc/
    read ver
    file=$(find "/home/farouq/Documents/Backups/$doc/" - type f | head -n $ver | sort -r | head -n 1)
    echo "Restored name : "
    read name 
    echo "******"
    bash "/home/farouq/Documents/Bash_Scripts/restore.sh" "$file" $name
    echo "Restoration been made:(/home/farouq/Documents/DB/)"
    ;;

    3)
    echo "backup schedule: 1)daily 2)weekly 3)default monthly"
    echo "Please choose the schedule:"
    read sched
    echo "Please enter the max number of files to keep: "
    read num
    echo "choose the backup name :"
    read backup_name
    echo "****"
    bash "/home/farouq/Documents/Bash_Scripts/scheduling.sh" $1 $sched $backup_name $num "zip"
    ;;
    *)
    echo "-----"
    echo "try again"
    ;;
    esac

done