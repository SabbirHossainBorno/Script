#!/bin/bash

# Move to the directory
cd /var/lib/mysql

# Function to validate input range
validate_input_range() {
    local start=$1
    local last=$2
    local max_limit=100

    if [[ $last -gt $max_limit ]]; then
        echo "You can't gzip more than $max_limit files at a time."
        return 1
    fi

    if [[ $start -gt $last ]]; then
        echo "Start file number must be less than or equal to the last file number."
        return 1
    fi

    return 0
}

# List non-gzipped files excluding mysqld-bin.index and the last file
echo "Available non-gzipped binlog files:"
non_gzipped_files=$(ls mysqld-bin.* | grep -vE '(\.gz$|mysqld-bin\.index$)' | awk -F'.' '{print $0}' | head -n -1)
echo "$non_gzipped_files"

# Read start and last file numbers from user input with validation
while true; do
    read -p "Enter start file number (e.g., 1): " start_number
    read -p "Enter last file number (e.g., 5): " last_number

    if ! [[ "$start_number" =~ ^[0-9]+$ ]] || ! [[ "$last_number" =~ ^[0-9]+$ ]]; then
        echo "Invalid input. Please enter valid numbers."
    else
        # Remove leading zeros
        start_number=$(echo "$start_number" | sed 's/^0*//')
        last_number=$(echo "$last_number" | sed 's/^0*//')

        if ! validate_input_range "$start_number" "$last_number"; then
            continue
        else
            break
        fi
    fi
done

# Loop through file numbers and gzip each non-gzipped file
for ((i=start_number; i<=last_number; i++)); do
    current_file="mysqld-bin.$(printf "%06d" $i)"
    if [ -f "$current_file" ] && ! [[ $current_file =~ \.gz$ ]]; then
        gzip "$current_file"
        echo "Gzipping completed for: $current_file"
    fi
done

echo "Gzipping completed for non-gzipped files between $start_number and $last_number."
ls mysqld-bin.*
