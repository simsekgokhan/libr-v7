#!/bin/bash

logfile="change_log.txt"

# Initialize log file
echo "Change log:" > $logfile

# Files and directories to process
files_and_dirs=$(find . -type f -o -type d)

# Process each file or directory
for fd in $files_and_dirs
do
    # Replace 'diem' and 'Diem' with 'diem' and 'Diem' respectively in files
    if [ -f "$fd" ]
    then
        # Replace in file
        sed -i -e 's/diem/diem/g' -e 's/Diem/Diem/g' -e 's/DIEM/DIEM/g' "$fd"

        # If a replacement was made
        if [ $? -eq 0 ]
        then
            echo "Made replacements in file: $fd" >> $logfile
        fi
    fi

    # Replace 'diem' and 'Diem' in directory names
    if [ -d "$fd" ]
    then
        new_fd=$(echo "$fd" | sed -e 's/diem/diem/g' -e 's/Diem/Diem/g' -e 's/DIEM/DIEM/g')
        
        # If the directory name was changed
        if [ "$fd" != "$new_fd" ]
        then
            # Rename directory
            mv "$fd" "$new_fd"

            # If the rename was successful
            if [ $? -eq 0 ]
            then
                echo "Renamed directory from: $fd to: $new_fd" >> $logfile
            fi
        fi
    fi
done

