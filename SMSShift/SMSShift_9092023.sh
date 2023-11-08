#!/bin/bash
#------------------------------------------|
# Reset                                    | 
Color_Off='\033[0m'       # Text Reset     |
#                                          |
# Regular Colors                           |
Black='\033[0;30m'        # Black          |
Red='\033[0;31m'          # Red            |
Green='\033[0;32m'        # Green          |
Yellow='\033[0;33m'       # Yellow         |
Blue='\033[0;34m'         # Blue           |
Purple='\033[0;35m'       # Purple         |
Cyan='\033[0;36m'         # Cyan           |
White='\033[0;37m'        # White          |
#                                          |
# Bold                                     |
BBlack='\033[1;30m'       # Black          |
BRed='\033[1;31m'         # Red            |
BGreen='\033[1;32m'       # Green          |
BYellow='\033[1;33m'      # Yellow         |
BBlue='\033[1;34m'        # Blue           |
BPurple='\033[1;35m'      # Purple         |
BCyan='\033[1;36m'        # Cyan           |
BWhite='\033[1;37m'       # White          |
#                                          |
# Underline                                |
UBlack='\033[4;30m'       # Black          |
URed='\033[4;31m'         # Red            |
UGreen='\033[4;32m'       # Green          |
UYellow='\033[4;33m'      # Yellow         |
UBlue='\033[4;34m'        # Blue           |
UPurple='\033[4;35m'      # Purple         |
UCyan='\033[4;36m'        # Cyan           |
UWhite='\033[4;37m'       # White          |
#                                          |
# Background                               |
On_Black='\033[40m'       # Black          |
On_Red='\033[41m'         # Red            |
On_Green='\033[42m'       # Green          |
On_Yellow='\033[43m'      # Yellow         |
On_Blue='\033[44m'        # Blue           |
On_Purple='\033[45m'      # Purple         |
On_Cyan='\033[46m'        # Cyan           |
On_White='\033[47m'       # White          |
#                                          |
# High Intensity                           |
IBlack='\033[0;90m'       # Black          |
IRed='\033[0;91m'         # Red            |
IGreen='\033[0;92m'       # Green          |
IYellow='\033[0;93m'      # Yellow         |
IBlue='\033[0;94m'        # Blue           |
IPurple='\033[0;95m'      # Purple         |
ICyan='\033[0;96m'        # Cyan           |
IWhite='\033[0;97m'       # White          |
#                                          |
# Bold High Intensity                      |
BIBlack='\033[1;90m'      # Black          |
BIRed='\033[1;91m'        # Red            |
BIGreen='\033[1;92m'      # Green          |
BIYellow='\033[1;93m'     # Yellow         |
BIBlue='\033[1;94m'       # Blue           |
BIPurple='\033[1;95m'     # Purple         |
BICyan='\033[1;96m'       # Cyan           |
BIWhite='\033[1;97m'      # White          |
#                                          |
# High Intensity backgrounds               |
On_IBlack='\033[0;100m'   # Black          |
On_IRed='\033[0;101m'     # Red            |
On_IGreen='\033[0;102m'   # Green          |
On_IYellow='\033[0;103m'  # Yellow         |
On_IBlue='\033[0;104m'    # Blue           |
On_IPurple='\033[0;105m'  # Purple         |
On_ICyan='\033[0;106m'    # Cyan           |
On_IWhite='\033[0;107m'   # White          |
#------------------------------------------|

#-----------------------------------------------------DEVELOPER - INFO------------------------------------------------------------

devloper_INFO(){
echo
echo -e "${BIRed}REVE SMS SHIFT SCRIPT(1.0.0)${Color_Off}"
echo -e "${BIYellow}*-----------------------------------------------------------------------*${Color_Off}"
echo -e "${BRed}TODAY                : ${Color_Off}${BYellow}`date +"%d-%m-%Y"` ${Color_Off}"
echo -e "${BRed}LAST UPDATE          : ${Color_Off}${BYellow}05-09-2023 ${Color_Off}"
echo -e "${BRed}PREVIOUS IMPLEMENTED : ${Color_Off}${BYellow} ${Color_Off}"
echo -e "${BRed}LAST IMPLEMENTED     : ${Color_Off}${BYellow}Shift To New Server${Color_Off}"
echo -e "${BIYellow}*-----------------------------------------------------------------------*${Color_Off}"
echo -e "${BRed}IMPLEMENTED BY MD. SABBIR HOSSAIN BORNO ${Color_Off}"
echo -e "${BRed}SOFTWARE SUPPORT ENGINEER ${Color_Off}"
echo -e "${BRed}REVE SYSTEMS ${Color_Off}"
echo
}


# Call the function
devloper_INFO


#-----------------------------------------------------EXIT------------------------------------------------------------

# Function to validate an IP address
function validate_ip() {
    local ip="$1"
    if [[ "$ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        return 0  # Valid IP address
    else
        return 1  # Invalid IP address
    fi
}

# Function to establish an SSH connection
function fn_Connect() {
    conSuccssfl=""

    # Set up SSH control socket
    SSHSOCKET=~/.ssh_connection
    ssh -M -f -N -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server

    if [ $? -eq 0 ]; then
        conSuccssfl=1
        echo -e "${BGreen}Connection stablishment successful${Color_Off}"
        # Save the SSH access for future use
        echo "ssh_user=$ssh_user" > ~/.ssh_saved_access
        echo "ssh_port=$ssh_port" >> ~/.ssh_saved_access
        echo "destination_server=$destination_server" >> ~/.ssh_saved_access
        echo "SSHSOCKET=$SSHSOCKET" >> ~/.ssh_saved_access
    else
        echo -e "${BRed}Connection establishment was not successful${Color_Off}"
        exit
    fi
}

# Function to install rsync on the destination server (for CentOS)
function install_rsync() {
    if ! ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "command -v rsync >/dev/null 2>&1"; then
        ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "yum install -y rsync"
    fi
}

# Function to check MySQL version 8 on the destination server
function check_mysql_version() {
    mysql_version=$(ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "mysql --version" 2>/dev/null)
    if [[ $mysql_version == *" 8."* ]]; then
        return 0  # MySQL version 8 found
    else
        return 1  # MySQL version 8 not found
    fi
}

# Function to close the SSH control socket
function fn_CloseControlSocket() {
    if [ -n "$SSHSOCKET" ]; then
        echo "SOCKET GOING CLOSLE."
        ssh -S $SSHSOCKET -O exit $ssh_user@$destination_server
        rm -f $SSHSOCKET  # Remove the control socket file
        rm -rf ~/.ssh_saved_access
    fi
}


# Function to transfer the file using rsync in the background
function fn_TransferFile_bk_server() {
    source_file="/usr/local/$folder_name"

    current_month=$(date +'%b')
    current_year=$(date +'%Y')
    # Create the folder with the desired name
    des_folder_name="${current_month}_${current_year}"

    destination_folder="/db_backup/$des_folder_name/"

    # Check if the source file exists on the local server
    if [ ! -f "$source_file" ]; then
        echo "Error: Source file does not exist on the local server."
        return 1  # Abort the transfer
    fi

    # Check if the destination folder exists, and if not, create it
    ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "mkdir -p '$destination_folder'"

    # Run rsync in the background, sending standard error to /dev/null to suppress
    rsync -ah --info=progress2 -e "ssh -p $ssh_port -o ControlPath=$SSHSOCKET" "$source_file" "$ssh_user@$destination_server:$destination_folder" 2>/dev/null &
    rsync_pid=$!

    # Wait for the rsync process to complete
    wait $rsync_pid

    # Check if the rsync process exited successfully
    if [ $? -eq 0 ]; then
        # Get the file size on the destination server
        transferred_size=$(ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "stat -c%s '$destination_folder/$folder_name'" 2>/dev/null)
        if [ -n "$transferred_size" ]; then
            # Convert the size to a human-readable format
            size_human_readable=$(du -h "$folder_name" | awk '{print $1}')
            echo -e "Transfer completed successfully"
            echo "Total transferred data size: $size_human_readable"
        else
            echo "Error: Unable to determine the transferred data size."
        fi
    else
        echo "Error: File transfer failed"
    fi
}

function fn_TransferFile_new_server() {

    source_file="/usr/local/$folder_name"
    destination_folder_location="/usr/local/"

    # Check if the source directory exists
    if [ ! -d "$source_file" ]; then
        echo "Error: Source directory '$source_file' does not exist on the local server."
        return 1
    fi

    # Run rsync in the background with progress and stats
    
    rsync -ah --info=progress2 -e "ssh -p $ssh_port -o ControlPath=$SSHSOCKET" "$source_file" "$ssh_user@$destination_server:$destination_folder_location" 2>/dev/null &
    
    #rsync -ah --progress --info=progress2,stats -e "ssh -p $ssh_port -o ControlPath=$SSHSOCKET" "$source_file" "$ssh_user@$destination_server:$destination_folder_location" 2>/dev/null &
    rsync_pid=$!

    # Wait for the rsync process to complete
    wait $rsync_pid

    # Check if the rsync process exited successfully
    if [ $? -eq 0 ]; then
        # Calculate the size of the transferred directory on the destination server
        transferred_size=$(ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "du -sh '$destination_folder_location/$folder_name'" 2>/dev/null | awk '{print $1}')
        if [ -n "$transferred_size" ]; then
            echo -e "Transfer completed successfully"
            echo -e "Removing Folder From Current Server($serverIP)"
            rm -rf $source_file
            echo "Total transferred data size on the destination server: $transferred_size"
        else
            echo "Error: Unable to determine the transferred data size on the destination server."
        fi
    else
        echo "Error: File transfer failed"
    fi
}







# Function to validate an IP address
function validate_ip() {
    local ip="$1"
    if [[ "$ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        return 0  # Valid IP address
    else
        return 1  # Invalid IP address
    fi
}

# Function to validate an SSH port
function validate_ssh_port() {
    local port="$1"
    if [[ "$port" =~ ^[0-9]+$ && "$port" -ge 1 && "$port" -le 65535 ]]; then
        return 0  # Valid SSH port
    else
        return 1  # Invalid SSH port
    fi
}




#> /etc/hosts.allow
#> /etc/hosts.deny
#echo -e "${BIRed}Truncate${Color_Off} ${BIGreen}(hosts.allow & hosts.deny)${Color_Off}"

serverIP=$(ip route get 8.8.8.8 | sed -n '/src/{s/.*src *\([^ ]*\).*/\1/p;q}')
#echo "$serverIP"

list_smsDB=$(cd /var/lib/mysql && ls | grep -E 'iTelSMS|iTelSMSFailed' | sed 's/iTelSMS\|iTelSMSFailed//' | sort | uniq | sed 's/^/-> /')
#echo "$list_smsDB"

list_smsFolder=$(cd /usr/local/ && ls | grep -E 'WholeSaleSMSServer|iTelSMSAppServer' | sed -e 's/WholeSaleSMSServer//' -e 's/iTelSMSAppServer//' | sort | uniq | sed 's/^/-> /')
#echo "$list_smsFolder"

list_smsAppFolder=$(cd /usr/local/ && ls | grep -E 'iTelSMSAppServer' | sed -e 's/iTelSMSAppServer//' | sort | uniq | sed 's/^/-> /')
#echo "$list_smsAppFolder"

list_MongoDB=$(mongo --eval "db.getMongo().getDBNames().forEach(function(db) { print(db) });" | grep 'SMSCampaigns\|SMSContacts' | sed 's/^/-> /')
#echo "$list_MongoDB"

list_billing=$(cd /usr/local/apache-tomcat-7.0.59/webapps/ && for dir in */; do if [ "$dir" != "ROOT/" ]; then echo "-> ${dir%/}"; fi; done)
#echo "$list_billing"




timeout_duration=60  # Timeout in seconds

        while true; do
        echo
        echo -e "${BPurple} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
        echo -e "${BPurple}|${Color_Off}${BGreen}               REVE SMS SHIFT             ${Color_Off}${BPurple}|${Color_Off}"
        echo -e "${BPurple} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
        echo -e "${BPurple}|${Color_Off}                                          ${BPurple}|${Color_Off}"
        echo -e "  ${BCyan}1. New Server${Color_Off}"
        echo -e "${BPurple}|${Color_Off}                                          ${BPurple}|${Color_Off}"
        echo -e "  ${BCyan}2. Backup Server${Color_Off}"
        echo -e "${BPurple}|${Color_Off}                                          ${BPurple}|${Color_Off}"
        echo -e "${BPurple} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
        echo -e "${BPurple}|${Color_Off}${BGreen}             Press [e] For Exit           ${Color_Off}${BPurple}|${Color_Off}"
        echo -e "${BPurple} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
        echo
        echo -e "${BCyan}Where You Want To Shift?${Color_Off}"
        echo
        echo -e "${BCyan}PRESS & ENTER PLEASE:${Color_Off} "
        echo

        read -t $timeout_duration option || true
        echo

        if [[ -z "$option" ]]; then
                echo -e "${On_IRed}Timeout Reached. Script Is Exiting Due To Inactivity.${Color_Off}"
                echo
                break
        fi

        case $option in

        1)
                #-----------------------------------------------------ShiftToNewServer------------------------------------------------------------
                echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
                echo -e "${BCyan}Service--${Color_Off}${BRed}(REVE SMS SHIFT)${Color_Off}"
                echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
                echo

                echo -e "${BICyan}Server Main IP = ${Color_Off}${BIRed}$serverIP${Color_Off}"
                echo

                # Check if saved SSH access exists and load it
                if [ -f ~/.ssh_saved_access ]; then
                source ~/.ssh_saved_access
                fi

                # If saved SSH access is not found, prompt for new server details
                if [ -z "$destination_server" ]; then
                # Prompt for new server details
                while true; do
                        read -p "Enter new server IP: " new_server_ip
                        echo

                        if [[ -z "$new_server_ip" ]]; then
                        echo "Destination server IP cannot be empty. Please enter a valid IP address."
                        elif ! validate_ip "$new_server_ip"; then
                        echo "Invalid IP address format. Please enter a valid IP address."
                        else
                        break
                        fi
                done
                echo
                while true; do
                        read -p "Enter new server port (press Enter for default '64246'): " new_server_port
                        echo

                        if [[ -z "$new_server_port" ]]; then
                        ssh_port="64246"  # Default SSH port
                        echo "Using default SSH port: $ssh_port"
                        break
                        elif ! validate_ssh_port "$new_server_port"; then
                        echo "Invalid SSH port. Please enter a valid port number (1-65535) or press Enter for the default port."
                        else
                        ssh_port="$new_server_port"
                        break
                        fi
                done
                while true; do
                        read -p "Enter new server user (press Enter for default 'root'): " new_server_user
                        echo

                        if [[ -z "$new_server_user" ]]; then
                        ssh_user="root"  # Default SSH user
                        echo "Using default SSH user: $ssh_user"
                        break
                        else
                        ssh_user="$new_server_user"
                        break
                        fi
                done

                # Use default values if inputs are empty
                destination_server="${new_server_ip}"
                ssh_port="${new_server_port:-64246}"
                ssh_user="${new_server_user:-root}"

                # Call the function to establish the connection
                fn_Connect
                else
                echo "Using saved SSH access for destination server: $destination_server"
                fi

                echo -e "${BCyan}Put The Information Bellow For Transfer Data.${Color_Off}"
                echo
                smsFolder=""
                while [[ -z "$smsFolder" ]]; do
                echo -e "${BYellow}List Of [ WholeSaleSMSServer ] Directory :${Color_Off}"
                echo "$list_smsFolder"
                echo
                echo -e "${BGreen}Enter [ WholeSaleSMSServer ] Directory Name : ${Color_Off}"
                read smsFolder

                if [ -z "$smsFolder" ]; then
                        echo -e "${BRed}Directory Name Cannot Be Empty. Please Enter A Valid Directory Name.${Color_Off}"
                        echo
                elif [ ! -d "/usr/local/WholeSaleSMSServer$smsFolder" ]; then
                        echo
                        echo -e "${BRed}Directory${Color_Off} ${BYellow}(/usr/local/WholeSaleSMSServer$smsFolder)${Color_Off} ${BRed}Does Not Exist. Please Enter A Valid Directory Name.${Color_Off}"
                        echo
                        smsFolder=""
                fi
                done

                smsAppFolder=""
                while [[ -z "$smsAppFolder" ]]; do
                echo
                echo -e "${BYellow}List Of [ iTelSMSAppServer ] Directory :${Color_Off}"
                echo "$list_smsAppFolder"
                echo
                echo -e "${BGreen}Enter [ iTelSMSAppServer ] Directory Name : ${Color_Off}"
                read smsAppFolder

                if [ -z "$smsAppFolder" ]; then
                        echo -e "${BRed}Directory Name Cannot Be Empty. Please Enter A Valid Directory Name.${Color_Off}"
                        echo
                elif [ ! -d "/usr/local/iTelSMSAppServer$smsAppFolder" ]; then
                        echo
                        echo -e "${BRed}Directory${Color_Off} ${BYellow}(/usr/local/iTelSMSAppServer$smsAppFolder)${Color_Off} ${BRed}Does Not Exist. Please Enter A Valid Directory Name.${Color_Off}"
                        echo
                        smsAppFolder=""
                fi
                done    

                billingName=""
                while [[ -z "$billingName" ]]; do
                echo
                echo -e "${BYellow}List Of [ SMS Billing ] :${Color_Off}"
                echo "$list_billing"
                echo
                echo -e "${BGreen}Enter [ Billing ] Name : ${Color_Off}"
                read billingName

                if [ -z "$billingName" ]; then
                        echo -e "${BRed}Billing name cannot be empty. Please enter a valid billing name.${Color_Off}"
                        echo
                elif [ ! -d "/usr/local/apache-tomcat-7.0.59/webapps/$billingName" ]; then
                        echo
                        echo -e "${BRed}Billing${Color_Off} ${BYellow}($billingName)${Color_Off} ${BRed} Does Not Exist. Please Enter A Valid Billing Name.${Color_Off}"
                        echo
                        billingName=""
                fi
                done

                refNo=""
                while [[ -z "$refNo" || ! "$refNo" =~ ^REF_[0-9]+$ ]]; do
                echo
                echo -e "${BGreen}Enter Reference NO. (${Color_Off}${BYellow}e.g., REF_66958${Color_Off}${BGreen}): ${Color_Off}"
                read refNo

                if [ -z "$refNo" ]; then
                        echo -e "${BRed}Reference NO. Cannot Be Empty. Please Enter A Valid Reference NO.${Color_Off} ${BYellow}(REF_XXXXX)${Color_Off}${BRed}.${Color_Off}"
                        echo
                elif [[ ! "$refNo" =~ ^REF_[0-9]+$ ]]; then
                        echo
                        echo -e "${BRed}Invalid Reference NO. Please Enter A Valid Reference NO.${Color_Off}${BYellow}(REF_XXXXX)${Color_Off}${BRed}.${Color_Off}"
                        echo
                        refNo=""
                fi
                done




                smsiTel_db_name=$(grep -o 'jdbc:mysql:///[^?"]*' "/usr/local/apache-tomcat-7.0.59/webapps/$billingName/WEB-INF/classes/DatabaseConnection.xml" | sed -e 's/.*\/\/\([^?]*\)/\1/')
                #echo -e "${BYellow}iTelSMS Database :${Color_Off} ${BRed}$smsiTel_db_name${Color_Off}"
                #echo

                smsfailed_db_name=$(grep -o 'jdbc:mysql:///[^?"]*' "/usr/local/apache-tomcat-7.0.59/webapps/$billingName/WEB-INF/classes/DatabaseConnection_Failed.xml" | sed -e 's/.*\/\/\([^?]*\)/\1/')
                #echo -e "${BYellow}iTelFailedSMS Database :${Color_Off} ${BRed}$smsfailed_db_name${Color_Off}"
                #echo

                SMSCampaigns_mongodb_name=$(grep -o 'DATABASE="[^"]*"' /usr/local/apache-tomcat-7.0.59/webapps/$billingName/WEB-INF/classes/DatabaseConnectionMongo.xml | grep 'SMSCampaigns' | sed -e 's/DATABASE="//' -e 's/"//')
                #echo -e "${BYellow}Mongo Database(SMSCampaigns) :${Color_Off} ${BRed}$SMSCampaigns_mongodb_name${Color_Off}"
                #echo

                SMSContacts_mongodb_name=$(grep -o 'DATABASE="[^"]*"' /usr/local/apache-tomcat-7.0.59/webapps/$billingName/WEB-INF/classes/DatabaseConnectionMongo.xml | grep 'SMSContacts' | sed -e 's/DATABASE="//' -e 's/"//')
                #echo -e "${BYellow}Mongo Database(SMSContacts) :${Color_Off} ${BRed}$SMSContacts_mongodb_name${Color_Off}"
                #echo


                echo
                echo -e "${BCyan}|-------------------------------------------------------------------|${Color_Off}"
                echo -e "${BCyan}|${Color_Off}                         ${BRed}SMS Switch Details${Color_Off}                        ${BCyan}|${Color_Off}"
                echo -e "${BCyan}|-------------------------------------------------------------------|${Color_Off}"
                echo -e "${BYellow}  Current Server IP               :${Color_Off}      ${BRed}$serverIP${Color_Off}"
                echo -e "${BCyan}|-------------------------------------------------------------------|${Color_Off}"
                echo -e "${BYellow}  Destination Server IP           :${Color_Off}      ${BRed}$destination_server${Color_Off}"
                echo -e "${BCyan}|-------------------------------------------------------------------|${Color_Off}"
                echo -e "${BYellow}  Destination Server SSH PORT     :${Color_Off}      ${BRed}$ssh_port${Color_Off}"
                echo -e "${BCyan}|-------------------------------------------------------------------|${Color_Off}"
                echo -e "${BYellow}  Destination Server USER         :${Color_Off}      ${BRed}$ssh_user${Color_Off}"
                echo -e "${BCyan}|-------------------------------------------------------------------|${Color_Off}"
                echo -e "${BYellow}  Reference NO                    :${Color_Off}      ${BRed}$refNo${Color_Off}"
                echo -e "${BCyan}|-------------------------------------------------------------------|${Color_Off}"
                echo -e "${BYellow}  iTelSMS Database                :${Color_Off}      ${BRed}$smsiTel_db_name${Color_Off}"
                echo -e "${BCyan}|-------------------------------------------------------------------|${Color_Off}"
                echo -e "${BYellow}  iTelFailedSMS Database          :${Color_Off}      ${BRed}$smsfailed_db_name${Color_Off}"
                echo -e "${BCyan}|-------------------------------------------------------------------|${Color_Off}"
                echo -e "${BYellow}  Mongo Database(SMSCampaigns)    :${Color_Off}      ${BRed}$SMSCampaigns_mongodb_name${Color_Off}"
                echo -e "${BCyan}|-------------------------------------------------------------------|${Color_Off}"
                echo -e "${BYellow}  Mongo Database(SMSContacts)     :${Color_Off}      ${BRed}$SMSContacts_mongodb_name${Color_Off}"
                echo -e "${BCyan}|-------------------------------------------------------------------|${Color_Off}"
                echo

                #|-------------------------------------------------------------------------------------------------------------------------------------------|
                echo -e "${BPurple}|--------------------------[${Color_Off} ${BCyan}Folder Create${Color_Off} ${BPurple}]------------------------|${Color_Off}"
                echo
                # Get the current month in abbreviated format (e.g., "Feb" for February)
                
                folder_name="SMS_Backup_$refNo"
                echo -e "${BGreen}Creating Backup Folder :${Color_Off} ${BRed}/usr/local/$folder_name${Color_Off}"
                echo
                # Check if the folder already exists
                if [ ! -d "/usr/local/$folder_name" ]; then
                mkdir "/usr/local/$folder_name"
                echo
                echo -e "${BCyan}Created Backup Folder :${Color_Off} ${BRed}/usr/local/$folder_name${Color_Off} ${BGreen}Successfully${Color_Off}"
                echo
                else
                echo
                echo -e "${BRed}Folder Already Exists :${Color_Off} ${BYellow}/usr/local/$folder_name${Color_Off}"
                echo
                fi
                echo -e "${BPurple}|-----------------------------[${Color_Off} ${BCyan}FINISH${Color_Off} ${BPurple}]----------------------------|${Color_Off}"
                echo
                #|-------------------------------------------------------------------------------------------------------------------------------------------|
                echo -e "${BPurple}|---------------------[${Color_Off} ${BCyan}iTelSMS Database Dump${Color_Off} ${BPurple}]---------------------|${Color_Off}"
                echo
                echo -e "${BCyan}Dumping Database : ${Color_Off}${BRed}$smsiTel_db_name${Color_Off}"
                cd /var/lib/mysql
                rm -rf $smsiTel_db_name.sql
                # Start the mysqldump in the background
                mysqldump $smsiTel_db_name > $smsiTel_db_name.sql &
                # Get the process ID of mysqldump
                mysqldump_pid=$!
                # Wait for the mysqldump process to complete
                wait $mysqldump_pid
                # Check if the dump was successful
                if [ $? -eq 0 ]; then
                echo
                echo -e "${BYellow}Database${Color_Off} ${BRed}$smsiTel_db_name${Color_Off} ${BYellow}Dump${Color_Off} ${BGreen}Complete${Color_Off}${BYellow}.${Color_Off}"
                echo
                # Display the file name and its creation time
                echo -e "${BCyan}Server Current Time : ${Color_Off}${BRed}$(date +'%b %e %H:%M')${Color_Off}"
                echo
                iTelSMSSQLFile=$(cd /var/lib/mysql && ls -hl "$smsiTel_db_name.sql" | awk '{print $9, $5, $6, $7, $8}')
                echo -e "${BCyan}$smsiTel_db_name.sql File :${Color_Off} ${BRed}$iTelSMSSQLFile${Color_Off}"
                echo
                else
                echo
                echo -e "${BRed}Error Dumping${Color_Off} ${BYellow}$smsiTel_db_name${Color_Off} ${BRed}Database.${Color_Off}"
                echo
                fi
                echo -e "${BPurple}|-----------------------------[${Color_Off} ${BCyan}FINISH${Color_Off} ${BPurple}]----------------------------|${Color_Off}"
                echo
                #|-------------------------------------------------------------------------------------------------------------------------------------------|
                echo -e "${BPurple}|------------------[${Color_Off} ${BCyan}iTelSMSFailed Database Dump${Color_Off} ${BPurple}]------------------|${Color_Off}"
                echo
                echo -e "${BCyan}Dumping Database :${Color_Off} ${BRed}$smsfailed_db_name${Color_Off}"
                cd /var/lib/mysql
                rm -rf $smsfailed_db_name.sql
                # Start the mysqldump in the background
                mysqldump -u root $smsfailed_db_name vbSMSPacketLogger $(mysql -u root -N -B -e "show tables like 'vbSMSPacketLogger_%'" $smsfailed_db_name | tail -n 10) > $smsfailed_db_name.sql &

                # Get the process ID of mysqldump
                mysqldump_pid=$!

                # Wait for the mysqldump process to complete
                wait $mysqldump_pid

                # Check if the dump was successful
                if [ $? -eq 0 ]; then
                echo
                echo -e "${BYellow}Database${Color_Off} ${BRed}$smsfailed_db_name${Color_Off} ${BYellow}Dump${Color_Off} ${BGreen}Complete${Color_Off}${BYellow}.${Color_Off}"
                echo

                # Display the file name and its creation time
                echo -e "${BCyan}Server Current Time : ${Color_Off}${BRed}$(date +'%b %e %H:%M')${Color_Off}"
                echo
                iTelSMSFAILEDSQLFile=$(cd /var/lib/mysql && ls -hl $smsfailed_db_name.sql | awk '{print $9, $5, $6, $7, $8}')
                echo -e "${BCyan}$smsiTel_db_name.sql File :${Color_Off} ${BRed}$iTelSMSFAILEDSQLFile${Color_Off}"
                echo
                else
                echo
                echo -e "${BRed}Error Dumping${Color_Off} ${BYellow}$smsfailed_db_name${Color_Off} ${BRed}Database.${Color_Off}"
                echo
                fi
                echo -e "${BPurple}|-----------------------------[${Color_Off} ${BCyan}FINISH${Color_Off} ${BPurple}]----------------------------|${Color_Off}"
                #|-------------------------------------------------------------------------------------------------------------------------------------------|
                echo
                echo -e "${BPurple}|--------------------------[${Color_Off} ${BCyan}Moving File${Color_Off} ${BPurple}]--------------------------|${Color_Off}"
                echo
                echo -e "${BCyan}Moving [${Color_Off} ${BRed}$smsfailed_db_name.sql${Color_Off} & ${BRed}$smsiTel_db_name.sql${Color_Off} ${BCyan}] \nTo ${Color_Off}${BGreen}/usr/local/$folder_name${Color_Off}"
                echo
                mv /var/lib/mysql/$smsfailed_db_name.sql $smsiTel_db_name.sql /usr/local/$folder_name
                echo -e "${BPurple}|-----------------------------[${Color_Off} ${BCyan}FINISH${Color_Off} ${BPurple}]----------------------------|${Color_Off}"
                echo
                #|-------------------------------------------------------------------------------------------------------------------------------------------|
                echo -e "${BPurple}|------------------[${Color_Off} ${BCyan}Mongo DB SMSCampaigns Dump${Color_Off} ${BPurple}]-------------------|${Color_Off}"
                echo
                echo -e "${BCyan}Dumping Mongo Database :${Color_Off} ${BRed}$SMSCampaigns_mongodb_name${Color_Off}"
                cd /usr/local/
                # Start the mongodump in the background
                mongodump --db $SMSCampaigns_mongodb_name -o "/usr/local/$folder_name/" > /dev/null 2>&1 &
                # Get the process ID of mongodump
                mongodump_pid=$!
                # Wait for the mysqldump process to complete
                wait $mongodump_pid
                # Check if the dump was successful
                if [ $? -eq 0 ]; then
                echo
                echo -e "${BYellow}Mongo Database${Color_Off} ${BRed}$SMSCampaigns_mongodb_name${Color_Off} ${BYellow}Dump${Color_Off} ${BGreen}Complete${Color_Off}${BYellow}.${Color_Off}"
                echo
                # Display the file name and its creation time
                echo -e "${BCyan}Server Current Time : ${Color_Off}${BRed}$(date +'%b %e %H:%M')${Color_Off}"
                echo
                cd /usr/local/$folder_name/
                mongoDBSMSCampaignsFile=$(ls -ld --time-style="+%b %_d %H:%M" /usr/local/$folder_name/$SMSCampaigns_mongodb_name | awk '{print $6, $7, $8, $9}' | sed 's/\/usr\/local\/'$folder_name'\///')
                echo -e "${BCyan}Mongo Databases File (SMSCampaigns) :${Color_Off} ${BRed}$mongoDBSMSCampaignsFile${Color_Off}"
                echo
                else
                echo
                echo -e "${BRed}Error Dumping${Color_Off} ${BYellow}$SMSCampaigns_mongodb_name${Color_Off} ${BRed}Database.${Color_Off}"
                echo
                fi

                echo -e "${BPurple}|-----------------------------[${Color_Off} ${BCyan}FINISH${Color_Off} ${BPurple}]----------------------------|${Color_Off}"
                echo
                #|-------------------------------------------------------------------------------------------------------------------------------------------|
                echo -e "${BPurple}|-------------------[${Color_Off} ${BCyan}Mongo DB SMSContacts Dump${Color_Off} ${BPurple}]-------------------|${Color_Off}"
                echo
                echo -e "${BCyan}Dumping Mongo Database :${Color_Off} ${BRed}$SMSContacts_mongodb_name${Color_Off}"
                cd /usr/local/
                # Start the mongodump in the background
                mongodump --db $SMSContacts_mongodb_name -o "/usr/local/$folder_name/" > /dev/null 2>&1 &
                # Get the process ID of mongodump
                mongodump_pid=$!
                # Wait for the mysqldump process to complete
                wait $mongodump_pid
                # Check if the dump was successful
                if [ $? -eq 0 ]; then
                echo
                echo -e "${BYellow}Mongo Database${Color_Off} ${BRed}$SMSContacts_mongodb_name${Color_Off} ${BYellow}Dump${Color_Off} ${BGreen}Complete${Color_Off}${BYellow}.${Color_Off}"
                echo
                # Display the file name and its creation time
                echo -e "${BCyan}Server Current Time : ${Color_Off}${BRed}$(date +'%b %e %H:%M')${Color_Off}"
                echo
                cd /usr/local/$folder_name/
                mongoDBSMSContactsFile=$(ls -ld --time-style="+%b %_d %H:%M" /usr/local/$folder_name/$SMSContacts_mongodb_name | awk '{print $6, $7, $8, $9}' | sed 's/\/usr\/local\/'$folder_name'\///')
                echo -e "${BCyan}Mongo Databases File (SMSContacts) :${Color_Off} ${BRed}$mongoDBSMSContactsFile${Color_Off}"
                echo
                else
                echo
                echo -e "${BRed}Error Dumping${Color_Off} ${BYellow}$SMSContacts_mongodb_name${Color_Off} ${BRed}Database.${Color_Off}"
                echo
                fi

                echo -e "${BPurple}|-----------------------------[${Color_Off} ${BCyan}FINISH${Color_Off} ${BPurple}]----------------------------|${Color_Off}"
                echo
                #|-------------------------------------------------------------------------------------------------------------------------------------------|
                echo -e "${BPurple}|-----------[${Color_Off} ${BCyan}Collecting WholeSaleSMS & iTelSMSAppServer${Color_Off} ${BPurple}]----------|${Color_Off}"
                echo

                cd /usr/local/
                echo -e "${BCyan}Removing Old Logs${Color_Off} ${BRed}[WholeSaleSMSServer$smsFolder]${Color_Off}"
                echo
                # Check if the directories exist before removing files
                if [ -d "/usr/local/WholeSaleSMSServer$smsFolder/logs" ]; then
                rm -rf /usr/local/WholeSaleSMSServer$smsFolder/logs/20*
                rm -f /usr/local/WholeSaleSMSServer$smsFolder/SMSServer.log.*
                echo -e "${BRed}Removing Old Logs${Color_Off} ${BGreen}Successfully${Color_Off}"
                echo
                else
                echo
                echo -e "${BRed}Directory${Color_Off} ${BYellow}(/usr/local/WholeSaleSMSServer$smsFolder/logs)${Color_Off} ${BRed}Does Not Exist.${Color_Off}"
                echo
                rm -f /usr/local/WholeSaleSMSServer$smsFolder/SMSServer.log.*
                echo -e "${BRed}Removing Old Logs${Color_Off} ${BGreen}Successfully${Color_Off}"
                echo
                fi

                echo
                echo -e "${BCyan}Removing Old Logs${Color_Off} ${BRed}[iTelSMSAppServer$smsAppFolder]${Color_Off}"
                echo
                if [ -d "/usr/local/iTelSMSAppServer$smsAppFolder/logs" ]; then 
                rm -rf /usr/local/iTelSMSAppServer$smsAppFolder/logs/20*
                echo -e "${BRed}Removing Old Logs${Color_Off} ${BGreen}Successfully${Color_Off}"
                echo
                else
                echo
                echo -e "${BRed}Directory${Color_Off} ${BYellow}(/usr/local/iTelSMSAppServer$smsAppFolder/logs)${Color_Off} ${BRed}Does Not Exist.${Color_Off}"
                echo
                fi

                echo
                echo -e "${BCyan}Moving [${Color_Off} ${BRed}WholeSaleSMSServer$smsFolder${Color_Off} & ${BRed}iTelSMSAppServer$smsAppFolder${Color_Off} ${BCyan}] \nTo ${Color_Off}${BGreen}/usr/local/$folder_name${Color_Off}" 
                echo
                cp -r "WholeSaleSMSServer$smsFolder" "iTelSMSAppServer$smsAppFolder" "/usr/local/$folder_name/"
                echo -e "${BPurple}|-----------------------------[${Color_Off} ${BCyan}FINISH${Color_Off} ${BPurple}]----------------------------|${Color_Off}"
                echo
                #|-------------------------------------------------------------------------------------------------------------------------------------------|
                echo -e "${BPurple}|----------[${Color_Off} ${BCyan}Collecting Full Billing With Apache - Tomcat${Color_Off} ${BPurple}]---------|${Color_Off}"
                echo
                cd /usr/local/
                echo -e "${BCyan}Moving [${Color_Off} ${BRed}Apache - Tomcat${Color_Off} ${BCyan}] \nTo ${Color_Off}${BGreen}/usr/local/$folder_name${Color_Off}"
                echo
                cp -r "apache-tomcat-7.0.59" "/usr/local/$folder_name/"
                echo -e "${BPurple}|-----------------------------[${Color_Off} ${BCyan}FINISH${Color_Off} ${BPurple}]----------------------------|${Color_Off}"
                echo
                #|-------------------------------------------------------------------------------------------------------------------------------------------|
                echo -e "${BPurple}|---------------------------[${Color_Off} ${BCyan}All Files${Color_Off} ${BPurple}]---------------------------|${Color_Off}"
                echo
                echo -e "${BCyan}All Contents Of${Color_Off} ${BRed}[$folder_name]${Color_Off}"
                echo
                cd /usr/local/$folder_name
                ls -ld --time-style="+%b %e %H:%M" * | awk '{print NR, $9, $5, $6, $7, $8}' | column -t
                echo
                total_size=$(du -sh . | awk '{print $1}')
                echo -e "${BCyan}Total Size :${Color_Off} ${BRed}$total_size${Color_Off}"
                echo
                echo -e "${BPurple}|-----------------------------[${Color_Off} ${BCyan}FINISH${Color_Off} ${BPurple}]----------------------------|${Color_Off}"
                echo

                #|-------------------------------------------------------------------------------------------------------------------------------------------|

                echo -e "${BPurple}|---------------------------[${Color_Off} ${BCyan}Transfer Data${Color_Off} ${BPurple}]---------------------------|${Color_Off}"
                echo
                # Check MySQL version on the destination server
                if ! check_mysql_version; then
                echo "Error: MySQL version 8 is not installed on the destination server."
                echo "Please install MySQL version 8 and ensure it's running before proceeding with the transfer."
                exit 1
                else
                echo "MySQL version 8 found on the destination server."
                fi

                # Check if rsync is installed on the destination server
                if ! ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "command -v rsync >/dev/null 2>&1"; then
                echo "Rsync is not installed on the destination server. Installing..."
                install_rsync
                if [ $? -eq 0 ]; then
                        echo "Rsync installation completed."
                else
                        echo "Error: Failed to install rsync on the destination server. Aborting transfer."
                        exit 1
                fi
                else
                echo "Rsync found on the destination server."
                fi

                # Call the function to transfer the file using rsync
                fn_TransferFile_new_server


                echo -e "${BPurple}|-----------------------------[${Color_Off} ${BCyan}FINISH${Color_Off} ${BPurple}]----------------------------|${Color_Off}"
                echo

                









                # Call the function to close the SSH control socket
                fn_CloseControlSocket

                echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
                echo -e "${BRed}                              [ FINISH ]                             ${Color_Off}"
                echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
                echo
                ;;
                #--------------------------------------------------------------Exit---------------------------------------------------
        e)
                #-----------------------------------------------------------------------------------------------------------------
                echo -e "*${BRed}------------* THANKS FOR USING THIS SCRIPT *-------------${Color_Off}*"
                echo
                echo -e "*${BRed}-------------------------${Color_Off}${BYellow}EXIT${Color_Off}${BRed}----------------------------${Color_Off}*"
                echo
                break
                ;;
                #-----------------------------------------------------------------------------------------------------------------
        *)
                echo -e "${BRed}Please Enter Valid Serial NO.${Color_Off}"
                ;;
        esac
        echo
        done