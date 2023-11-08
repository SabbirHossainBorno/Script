#!/bin/bash

# Function to drop tables within a given range
drop_tables_in_range() {
    local db_name="$1"
    local table_name="$2"
    local start_table="$3"
    local last_table="$4"

    valid_range=false
    existing_tables=""

    for ((i=start_table; i<=last_table; i++)); do
        table_to_check="${table_name}_$i"
        exists=$(mysql -u root --force -D "$db_name" -e "SHOW TABLES LIKE '$table_to_check';" | grep -o "$table_to_check")
        if [ -z "$exists" ]; then
            echo "Table $table_to_check does not exist."
        else
            existing_tables+=" $table_to_check"
        fi
    done

    if [ -z "$existing_tables" ]; then
        echo "No existing tables found within the specified range."
    else
        for table_to_drop in $existing_tables; do
            echo "Dropping table: $table_to_drop"
            mysql -u root --force -D "$db_name" -e "DROP TABLE IF EXISTS $table_to_drop;"
        done
        echo "Tables dropped for $table_name."
    fi
}

# Move to the appropriate directory
cd /usr/local/jakarta-tomcat-7.0.61/webapps/

# List directories (billing names)
echo "Available Billing Names:"
ls

# Read billing name from user input
read -p "Enter Billing name: " billingname

# Extract MySQL connection details from DatabaseConnection_Failed.xml
failed_db_name=$(grep -o 'jdbc:mysql:///[^?"]*' "/usr/local/jakarta-tomcat-7.0.61/webapps/$billingname/WEB-INF/classes/DatabaseConnection_Failed.xml" | sed -e 's/.*\/\/\([^?]*\)/\1/')

# Connect to the failed database and show tables
echo "Tables in $failed_db_name:"
mysql -u root --force -D "$failed_db_name" -e "SHOW TABLES;"

# Loop through table names
table_names=(
    "vbAuthFailedCDR"
    "vbFailedCDR"
    "vbFailedSummaryCDR"
    "vbPacket"
)

# Loop through table names
for table_name in "${table_names[@]}"; do
    while true; do
        while true; do
            read -p "Enter start table number for $table_name (or press enter to skip, or 'e' to exit): " start_table
            if [ -z "$start_table" ]; then
                echo "Skipping $table_name"
                break 2  # Break out of both loops
            fi
            
            if [ "$start_table" = "e" ]; then
                echo "Remaining tables:"
                mysql -u root --force -D "$failed_db_name" -e "SHOW TABLES;"
                echo "Exiting..."
                exit 0
            fi

            read -p "Enter last table number for $table_name (or press enter for just one table): " last_table

            if [ -z "$last_table" ]; then
                last_table="$start_table"
            fi

            if [ "$start_table" -gt "$last_table" ]; then
                echo "Invalid range. Start table number cannot be greater than last table number."
            else
                exists=$(mysql -u root --force -D "$failed_db_name" -e "SHOW TABLES LIKE '${table_name}_$start_table';" | grep -o "${table_name}_$start_table")
                if [ -z "$exists" ]; then
                    echo "Table ${table_name}_$start_table does not exist. Please enter a valid range."
                else
                    drop_tables_in_range "$failed_db_name" "$table_name" "$start_table" "$last_table"
                    break
                fi
            fi
        done

        break
    done
done

# Show remaining tables
echo "Remaining tables:"
mysql -u root --force -D "$failed_db_name" -e "SHOW TABLES;"
