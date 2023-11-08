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
echo -e "${BIRed}REVE SMS SHIFT SCRIPT(5.1.0)${Color_Off}"
echo -e "${BIYellow}*-----------------------------------------------------------------------*${Color_Off}"
echo -e "${BRed}TODAY                : ${Color_Off}${BYellow}`date +"%d-%m-%Y"` ${Color_Off}"
echo -e "${BRed}LAST UPDATE          : ${Color_Off}${BYellow}27-09-2023 ${Color_Off}"
echo -e "${BRed}PREVIOUS IMPLEMENTED : ${Color_Off}${BYellow}Shift To New Server ${Color_Off}"
echo -e "${BRed}LAST IMPLEMENTED     : ${Color_Off}${BYellow}Client Reply${Color_Off}"
echo -e "${BIYellow}*-----------------------------------------------------------------------*${Color_Off}"
echo -e "${BRed}IMPLEMENTED BY MD. SABBIR HOSSAIN BORNO ${Color_Off}"
echo -e "${BRed}SOFTWARE SUPPORT ENGINEER ${Color_Off}"
echo -e "${BRed}REVE SYSTEMS ${Color_Off}"
echo
}


# Call the function
devloper_INFO


#-----------------------------------------------------EXIT------------------------------------------------------------
# Function to check and install required packages on the Destination Server (CentOS)
function check_dependency_destination_server() {
    local destination_server="$1"

    # List of required packages
    local required_packages=("lsof" "zip" "wget" "screen")

    # Check if each package is installed, and install if missing
    for package in "${required_packages[@]}"; do
        if ! ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "command -v $package >/dev/null 2>&1"; then
            echo -e "${BIRed}[$package]${Color_Off} ${BICyan}Is${Color_Off} ${BIRed}Not Installed${Color_Off} ${BICyan}On The Destination Server${Color_Off} \n\n${BIGreen}Installing ${Color_Off} ${BIRed}[$package]${Color_Off}"
            echo
            ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "nohup sudo yum install -y $package > /dev/null 2>&1 &"

            if [ $? -eq 0 ]; then
                echo -e "${BIRed}[$package]${Color_Off} ${BICyan}Has Been${Color_Off} ${BIGreen}Successfully Installed${Color_Off}"
                echo
            else
                echo -e "${BIBlue}Error :${Color_Off} ${BIRed}Failed To Install${Color_Off} ${BIGreen}$package${Color_Off}"
                echo
                return 1
            fi
        else
            echo -e "${BIRed}[$package]${Color_Off} ${BICyan}Is Already${Color_Off} ${BIGreen}Installed${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
            echo
        fi
    done
}

# Function to check and install packages on the current server
function check_dependency_current_server() {
    # List of required packages
    local packages=("rsync" "zip" "wget" "screen" "lsof")

    # Iterate through the list of packages
    for package in "${packages[@]}"; do
        if ! command -v "$package" > /dev/null 2>&1; then
            echo -e "${BIRed}[$package]${Color_Off} ${BICyan}Is${Color_Off} ${BIRed}Not Installed${Color_Off} ${BICyan}On The Current Server${Color_Off} \n\n${BIGreen}Installing${Color_Off} ${BIRed}[$package]${Color_Off}"
            echo

            sudo yum install -y "$package" > /dev/null 2>&1 &
            
            echo -e "${BIRed}[$package]${Color_Off} ${BICyan}Has Been${Color_Off} ${BIGreen}Successfully Installed${Color_Off}"
            echo
        else
            echo -e "${BIRed}[$package]${Color_Off} ${BICyan}Is Already${Color_Off} ${BIGreen}Installed${Color_Off} ${BICyan}On The Curent Server${Color_Off}"
            echo
        fi
    done
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

# Function to establish an SSH connection
function fn_Connect() {
    conSuccssfl=""

    # Set up SSH control socket
    SSHSOCKET=~/.ssh_connection
    ssh -M -f -N -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server

    if [ $? -eq 0 ]; then
        conSuccssfl=1
        echo -e "${BIRed}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
        echo -e "${BIRed}|${Color_Off}    ${BICyan}Connection Establishment${Color_Off} ${BIGreen}Successful${Color_Off}   ${BIRed}|${Color_Off}"
        echo -e "${BIRed}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
        echo

        # Save the SSH access for future use
        echo "ssh_user=$ssh_user" > ~/.ssh_saved_access
        echo "ssh_port=$ssh_port" >> ~/.ssh_saved_access
        echo "destination_server=$destination_server" >> ~/.ssh_saved_access
        echo "SSHSOCKET=$SSHSOCKET" >> ~/.ssh_saved_access
    else
        echo
        echo -e "${BIGreen}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
        echo -e "${BIGreen}|${Color_Off}     ${BICyan}Connection Establishment${Color_Off} ${BIRed}Failed${Color_Off}     ${BIGreen}|${Color_Off}"
        echo -e "${BIGreen}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
        echo
        exit
    fi
}

# Function to check if rsync is installed on the Destination Server
function check_rsync_installed() {
    if ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "command -v rsync >/dev/null 2>&1"; then
        echo -e "${BIYellow}Rsync${Color_Off} ${BIGreen}Found${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
        echo
        return 0
    else
        echo -e "${BIBlue}Error :${Color_Off} ${BIYellow}Rsync${Color_Off} ${BIRed}Not Found${Color_Off} ${BICyan}On The Destination Server${Color_Off} \n${BIGreen}Installing${Color_Off} ${BIYellow}Rsync${Color_Off}"
        echo
        ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "yum install -y rsync"
        if [ $? -eq 0 ]; then
            echo -e "${BIYellow}Rsync${Color_Off} ${BIGreen}Installed Successfully${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
            echo
            return 0
        else
            echo -e "${BIBlue}Error :${Color_Off} ${BIRed}Failed To Install${Color_Off} ${BIYellow}Rsync${Color_Off} ${BIRed}On The Destination Server${Color_Off} \n${BICyan}File Transfer${Color_Off} ${BIRed}Aborted${Color_Off}"
            echo
            return 1
        fi
    fi
}

# Function to install rsync on the Destination Server (for CentOS)
function check_rsync_install_rsync() {
    if ! ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "command -v rsync >/dev/null 2>&1"; then
        echo -e "${BIYellow}Rsync${Color_Off} ${BIRed}Not Found${Color_Off} ${BICyan}On The Destination Server${Color_Off} \n${BIGreen}Installing${Color_Off} ${BIYellow}Rsync${Color_Off}"
        echo
        ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "yum install -y rsync"
        if [ $? -eq 0 ]; then
            echo -e "${BIYellow}Rsync${Color_Off} ${BIGreen}Installed Successfully${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
            echo
            return 0
        else
            echo -e "${BIBlue}Error :${Color_Off} ${BIRed}Failed To Install${Color_Off} ${BIYellow}Rsync${Color_Off} ${BIRed}On The Destination Server${Color_Off} \n${BICyan}File Transfer${Color_Off} ${BIRed}Aborted${Color_Off}"
            echo
            return 1
        fi
    else
        echo -e "${BIYellow}Rsync${Color_Off} ${BIGreen}Found${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
        echo
        return 0
    fi
}

# Function to check if JDK 'jdk1.8.0_111' is installed on the Destination Server
function check_jdk_installed() {
    if ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "[ -d '/usr/jdk1.8.0_111' ]"; then
        echo -e "${BIYellow}JDK${Color_Off} ${BIRed}[ jdk1.8.0_111 ]${Color_Off} ${BIGreen}Found${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
        echo
        return 0
    else
        echo -e "${BIBlue}Error :${Color_Off} ${BIYellow}JDK${Color_Off} ${BIRed}Not Found${Color_Off} ${BICyan}On The Destination Server${Color_Off} \n${BIRed}Please Install JDK & Retry${Color_Off}"
        echo
        return 1
    fi
}

# Function to check MySQL version 8 on the Destination Server
function check_mysql_version() {
    mysql_version=$(ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "mysql --version" 2>/dev/null)
    if [[ $mysql_version == *" 8."* ]]; then
        echo -e "${BIYellow}MySQL${Color_Off} ${BIGreen}Version 8 Found${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
        echo
        return 0
    else
        echo -e "${BIBlue}Error :${Color_Off} ${BIYellow}MySQL${Color_Off} ${BIRed}Version 8 Not Found${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
        echo
        return 1
    fi
}

# Function to check if Tomcat directory '/usr/local/apache-tomcat-7.0.59' exists on the Destination Server
function check_tomcat_installed() {
    if ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "[ -d '/usr/local/apache-tomcat-7.0.59' ]"; then
        echo -e "${BIYellow}[Apache - Tomcat]${Color_Off} ${BIRed}Found${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
        echo
        return 0
    else
        echo -e "${BIYellow}[Apache - Tomcat]${Color_Off} ${BIGreen}Not Found${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
        echo
        return 1
    fi
}

# Function to take a backup of the Tomcat directory
function backup_tomcat() {
    # Check if the Tomcat directory exists
    if ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "[ -d '/usr/local/apache-tomcat-7.0.59' ]"; then
        # Define the new backup directory name with current date and time
        backup_folder="/usr/local/apache-tomcat-7.0.59_BK_$(date +'%d%m%Y_%H%M%S')"

        # Rename the existing Tomcat directory to the backup directory
        ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "mv '/usr/local/apache-tomcat-7.0.59' '$backup_folder'" >/dev/null 2>&1

        if [ $? -eq 0 ]; then
            echo -e "${BIGreen}Renamed${Color_Off} ${BICyan}Existing${Color_Off} ${BIYellow}[Apache - Tomcat]${Color_Off} ${BICyan}Directory To :${Color_Off} ${BIRed}$backup_folder${Color_Off}"
            echo
            return 0
        else
            echo -e "${BIBlue}Error :${Color_Off} ${BIRed}Failed To Rename${Color_Off} ${BICyan}The Existing${Color_Off} ${BIYellow}[Apache - Tomcat]${Color_Off}"
            echo
            return 1
        fi
    else
        echo -e "${BIYellow}[Apache - Tomcat]${Color_Off} ${BIGreen}Not Found${Color_Off} ${BICyan}On The Destination Server.${Color_Off} \n${BICyan}Skipping Backup${Color_Off}"
        echo
        return 0
    fi
}


# Function to check if MongoDB is installed and running on the Destination Server
function check_mongo_status() {
    if ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "command -v mongod > /dev/null" && \
       ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "pgrep -x mongod > /dev/null"; then
        echo -e "${BIYellow}MongoDB${Color_Off} ${BICyan}Is${Color_Off} ${BIGreen}Installed & Running${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
        echo
        return 0
    else
        echo -e "${BIBlue}Error :${Color_Off} ${BIYellow}MongoDB${Color_Off} ${BICyan}Is${Color_Off} ${BIRed}Not Installed OR Not Running${Color_Off} ${BICyan}On The Destination Server.${Color_Off} \n${BICyan}Trying To Restart${Color_Off} ${BIYellow}MongoDB${Color_Off}"
        echo
        ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "sudo service mongod restart"
        sleep 5 # Wait for MongoDB to restart
        # Check again if MongoDB is running after the restart
        if ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "pgrep -x mongod > /dev/null"; then
            echo -e "${BIYellow}MongoDB${Color_Off} ${BICyan}Has Been${Color_Off} ${BIGreen}Restarted & Running Now${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
            echo
            return 0
        else
            echo -e "${BIBlue}Error :${Color_Off} ${BIYellow}MongoDB${Color_Off} ${BICyan}Could${Color_Off} ${BIRed}Not Be Started${Color_Off} ${BICyan}On The Destination Server.${Color_Off} \n${BICyan}Please Check ${BIYellow}MongoDB${Color_Off} ${BICyan}Installation & Configuration${Color_Off}"
            echo
            return 1
        fi
    fi
}


# Function to close the SSH control socket
function fn_CloseControlSocket() {
    if [ -n "$SSHSOCKET" ]; then
        echo -e "${BIBlue}SOCKET GOING CLOSE${Color_Off}"
        echo
        ssh -S $SSHSOCKET -O exit $ssh_user@$destination_server 2>/dev/null
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
        echo "${BIBlue}Error :${Color_Off} Source file does not exist on the local server."
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
        # Get the file size on the Destination Server
        transferred_size=$(ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "stat -c%s '$destination_folder/$folder_name'" 2>/dev/null)
        if [ -n "$transferred_size" ]; then
            # Convert the size to a human-readable format
            size_human_readable=$(du -h "$folder_name" | awk '{print $1}')
            echo -e "Transfer completed successfully"
            echo "Total transferred data size: $size_human_readable"
        else
            echo "${BIBlue}Error :${Color_Off} Unable to determine the transferred data size."
        fi
    else
        echo "${BIBlue}Error :${Color_Off} File transfer failed"
    fi
}

# Function to transfer the file using rsync in the background
function fn_TransferFile_new_server() {
    source_file="/usr/local/$folder_name"
    destination_folder_location="/usr/local/"

    # Check if the source directory exists
    if [ ! -d "$source_file" ]; then
        echo -e "${BIBlue}Error :${Color_Off} ${BICyan}Source Data${Color_Off} ${BIYellow}[$source_file]${Color_Off} ${BIRed}Does Not Exist${Color_Off} ${BICyan}On The Current Server${Color_Off}"
        echo
        return 1
    fi

    # Check if rsync is installed on the Destination Server and install it if not
    check_rsync_install_rsync || return 1

    # Check MySQL version on the Destination Server
    check_mysql_version || return 1

    # Check if JDK is installed on the Destination Server
    check_jdk_installed || return 1

    # Check MySQL version on the Destination Server
    check_mongo_status || return 1

    # Check if Tomcat is installed on the Destination Server and take a backup if found
    check_tomcat_installed && backup_tomcat || echo -e "${BICyan}Skipping${Color_Off} ${BIYellow}[Apache - Tomcat]${Color_Off} ${BICyan}Backup${Color_Off}"

    echo -e "${BICyan}Transfering Data From Current Server To Destination Server${Color_Off}"
    # Run rsync in the background with progress and stats
    rsync -ah --info=progress2 -e "ssh -p $ssh_port -o ControlPath=$SSHSOCKET" "$source_file" "$ssh_user@$destination_server:$destination_folder_location" 2>/dev/null &
    rsync_pid=$!
    echo

    # Wait for the rsync process to complete
    wait $rsync_pid

    # Check if the rsync process exited successfully
    if [ $? -eq 0 ]; then
        # Calculate the size of the transferred directory on the Destination Server
        transferred_size=$(ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "du -sh '$destination_folder_location/$folder_name'" 2>/dev/null | awk '{print $1}')
        if [ -n "$transferred_size" ]; then
            echo
            echo -e "${BICyan}Transfer${Color_Off}${BIGreen}Completed Successfully${Color_Off}"
            echo
            echo -e "${BIYellow}Warning :${Color_Off} ${BIBlue}Removing Folder From Current Server${Color_Off}${BIRed}[$serverIP]${Color_Off}"
            echo
            rm -rf $source_file
            echo -e "${BICyan}Total Transferred Data Size On The Destination Server :${Color_Off} ${BIRed}$transferred_size${Color_Off}"
            echo
        else
            echo -e "${BIBlue}Error :${Color_Off} ${BIRed}Unable To Determine${Color_Off} ${BICyan}The Transferred Data Size On The Destination Server${Color_Off}"
            echo
        fi
    else
        echo -e "${BIBlue}Error :${Color_Off} ${BICyan}Data Transfer${Color_Off} ${BIRed}Failed${Color_Off}"
        echo
    fi
}


# Function to create databases on the Destination Server
function create_databases() {
    # Check if MySQL version 8 is installed on the Destination Server
    #check_mysql_version || return 1

    # Create the databases
    ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "mysql -u root -e 'CREATE DATABASE IF NOT EXISTS $smsiTel_db_name; CREATE DATABASE IF NOT EXISTS $smsfailed_db_name;'"

    # Check if the databases were created successfully
    if [ $? -eq 0 ]; then
        echo -e "${BIYellow}Databases${Color_Off} ${BIRed}$smsiTel_db_name & $smsfailed_db_name${Color_Off} ${BIGreen}Created Successfully${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
        echo
    else
        echo -e "${BIBlue}Error :${Color_Off} ${BIRed}Failed To Create${Color_Off} ${BIYellow}Databases${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
        echo
        return 1
    fi
}


# Function to run source files for the databases on the Destination Server
function run_source_files() {
    # Check if MySQL version 8 is installed on the Destination Server
    #check_mysql_version || return 1

    # Define the paths to the source SQL files on the Destination Server
    smsiTel_db_sql="/usr/local/$folder_name/$smsiTel_db_name.sql"
    smsfailed_db_sql="/usr/local/$folder_name/$smsfailed_db_name.sql"

    # Check if the source SQL files exist on the Destination Server
    if ! ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "[ -f $smsiTel_db_sql ] && [ -f $smsfailed_db_sql ]"; then
        echo -e "${BIBlue}Error :${Color_Off} ${BIRed}Source${Color_Off} ${BIYellow}SQL File(s)${Color_Off} ${BIRed}Not Found${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
        echo
        return 1
    fi

    # Run the source files to create the databases on the Destination Server
    echo -e "${BIGreen}Running${Color_Off} ${BICyan}The Source${Color_Off} ${BIYellow}SQL File(s)${Color_Off} ${BICyan}On The Destination Server${Color_Off}${BIRed}[$smsiTel_db_name]${Color_Off}"
    echo
    ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "mysql -u root $smsiTel_db_name < $smsiTel_db_sql"
    if [ $? -eq 0 ]; then
        echo -e "${BICyan}Source${Color_Off} ${BIYellow}SQL File(s)${Color_Off} ${BIGreen}Executed Successfully${Color_Off} ${BICyan}For${Color_Off} ${BIRed}[$smsiTel_db_name]${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
        echo
    else
        echo -e "${BIBlue}Error :${Color_Off} ${BIRed}Failed To Execute${Color_Off} ${BICyan}Source${Color_Off} ${BIYellow}SQL File(s)${Color_Off} ${BICyan}For${Color_Off} ${BIRed}[$smsiTel_db_name]${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
        echo
        return 1
    fi

    echo -e "${BIGreen}Running${Color_Off} ${BICyan}The Source${Color_Off} ${BIYellow}SQL File(s)${Color_Off} ${BICyan}On The Destination Server${Color_Off}${BIRed}[$smsfailed_db_name]${Color_Off}"
    echo
    ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "mysql -u root $smsfailed_db_name < $smsfailed_db_sql"
    if [ $? -eq 0 ]; then
        echo -e "${BICyan}Source${Color_Off} ${BIYellow}SQL File(s)${Color_Off} ${BIGreen}Executed Successfully${Color_Off} ${BICyan}For${Color_Off} ${BIRed}[$smsfailed_db_name]${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
        echo
    else
        echo -e "${BIBlue}Error :${Color_Off} ${BIRed}Failed To Execute${Color_Off} ${BICyan}Source${Color_Off} ${BIYellow}SQL File(s)${Color_Off} ${BICyan}For${Color_Off} ${BIRed}[$smsfailed_db_name]${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
        echo
        return 1
    fi
}


# Function to change IP address in Configuration.properties and MySQL database
function ip_change() {
    local destination_server="$1"
    local folder_name="$2"
    local smsAppFolder="$3"
    local smsFolder="$4"

    # Count the number of occurrences of $serverIP in Configuration.properties
    local config_ip_count=$(ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "grep -o "$serverIP" /usr/local/$folder_name/iTelSMSAppServer$smsAppFolder/Configuration.properties" | wc -l)
    
    # Count the number of occurrences of $serverIP in server.cfg
    local server_cfg_ip_count=$(ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "grep -o "$serverIP" /usr/local/$folder_name/WholeSaleSMSServer$smsFolder/config/server.cfg" | wc -l)

    # Count the number of occurrences of $serverIP in server.xml
    local server_xml_ip_count=$(ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "grep -o "$serverIP" /usr/local/$folder_name/apache-tomcat-7.0.59/conf/server.xml" | wc -l)
    

    # Replace $serverIP with $destination_server in Configuration.properties
    ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "sed -i "s/$serverIP/$destination_server/g" /usr/local/$folder_name/iTelSMSAppServer$smsAppFolder/Configuration.properties"
    echo -e "${BIGreen}Replaced${Color_Off} ${BIYellow}IP${Color_Off} ${BICyan}In${Color_Off} ${BIRed}[Configuration.properties]${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
    echo

    # Replace $serverIP with $destination_server in server.cfg
    ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "sed -i 's/$serverIP/$destination_server/g' /usr/local/$folder_name/WholeSaleSMSServer$smsFolder/config/server.cfg"
    echo -e "${BIGreen}Replaced${Color_Off} ${BIYellow}IP${Color_Off} ${BICyan}In${Color_Off} ${BIRed}[server.cfg]${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
    echo

    # Replace $serverIP with $destination_server in server.xml
    ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "sed -i 's/$serverIP/$destination_server/g' /usr/local/$folder_name/apache-tomcat-7.0.59/conf/server.xml"
    echo -e "${BIGreen}Replaced${Color_Off} ${BIYellow}IP${Color_Off} ${BICyan}In${Color_Off} ${BIRed}[server.xml]${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
    echo

    # Define the SQL query to update the IP address in the specified columns of the vbSMSServerInfo table
    local sql_query="UPDATE vbSMSServerInfo SET smsServerIP = '$destination_server', smsSenderListenIP = '$destination_server'"

    # Execute the SQL query on the specified database
    ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "mysql -u root $smsiTel_db_name -e \"$sql_query\""
    echo -e "${BIGreen}Changed${Color_Off} ${BIYellow}IP${Color_Off} ${BICyan}In Database${Color_Off} ${BIYellow}[$smsiTel_db_name]${Color_Off} ${BIRed}[vbSMSServerInfo table columns smsServerIP and smsSenderListenIP]${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
    echo

    # Print the count of IP replacements
    echo "-----------------------------------------------------------"
    echo "| Found \$serverIP Amount (Configuration.properties) : | $config_ip_count                 |"
    echo "-----------------------------------------------------------"
    echo "| Found \$serverIP Amount (server.cfg)               : | $server_cfg_ip_count                 |"
    echo "-----------------------------------------------------------"
    echo "| Found \$serverIP Amount (server.xml)               : | $server_xml_ip_count                 |"
    echo "-----------------------------------------------------------"
    echo
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

# Function to create or clear a backup folder
function create_backup_folder() {
    folder_name="SMS_Backup_$refNo"
    echo -e "${BICyan}Creating Backup Folder :${Color_Off} ${BIRed}[/usr/local/$folder_name]${Color_Off}"
    echo
    # Check if the folder already exists
    if [ ! -d "/usr/local/$folder_name" ]; then
        mkdir "/usr/local/$folder_name"
        echo -e "${BICyan}Created Backup Folder :${Color_Off} ${BIRed}[/usr/local/$folder_name]${Color_Off} ${BIGreen}Successfully${Color_Off}"
        echo
    else
        echo -e "${BICyan}Folder Already Exists :${Color_Off} ${BIRed}[/usr/local/$folder_name]${Color_Off}"
        echo
    fi
}

# Function to dump a iTelSMS database to a SQL file
function dump_iTelSMS_DB() {
    local smsiTel_db_sql="/var/lib/mysql/$smsiTel_db_name.sql"

    echo -e "${BICyan}Dumping Database :${Color_Off} ${BIRed}$smsiTel_db_name${Color_Off}"
    echo

    # Check if the SQL file already exists and remove it
    if [ -f "$smsiTel_db_sql" ]; then
        rm -f "$smsiTel_db_sql"
    fi

    # Start the mysqldump in the background
    mysqldump "$smsiTel_db_name" > "$smsiTel_db_sql" &

    # Get the process ID of mysqldump
    mysqldump_pid=$!

    # Wait for the mysqldump process to complete
    wait "$mysqldump_pid"

    # Check if the dump was successful
    if [ $? -eq 0 ]; then
        echo -e "${BICyan}Database${Color_Off} ${BIRed}$smsiTel_db_name${Color_Off} ${BICyan}Dump${Color_Off} ${BIGreen}Complete${Color_Off}"
        echo

        # Display the file name and its creation time
        echo -e "${BICyan}Server Current Time :${Color_Off} ${BIRed}$(date +'%b %e %H:%M')${Color_Off}"
        echo

        cd /var/lib/mysql
        iTelSMSSQLFile=$(ls -hl "$smsiTel_db_name.sql" | awk '{print $9, $5, $6, $7, $8}')
        echo -e "${BICyan}$smsiTel_db_name.sql File :${Color_Off} ${BIRed}$iTelSMSSQLFile${Color_Off}"
        echo
    else
        echo -e "${BIBlue}Error :${Color_Off} ${BIRed}Failed${Color_Off} ${BICyan}To Dumping${Color_Off} ${BYellow}$smsiTel_db_name${Color_Off} ${BICyan}Database.${Color_Off}"
        echo
    fi
}

# Function to dump a iTelSMSFailed database to a SQL file
function dump_iTelSMSFailed_DB() {
    local smsiTelfailed_db_sql="/var/lib/mysql/$smsfailed_db_name.sql"

    echo -e "${BICyan}Dumping Database :${Color_Off} ${BIRed}$smsfailed_db_name${Color_Off}"
    echo

    # Check if the SQL file already exists and remove it
    if [ -f "$smsiTelfailed_db_sql" ]; then
        rm -f "$smsiTelfailed_db_sql"
    fi

    # Start the mysqldump in the background
    mysqldump -u root $smsfailed_db_name vbSMSPacketLogger $(mysql -u root -N -B -e "show tables like 'vbSMSPacketLogger_%'" $smsfailed_db_name | tail -n 10) > $smsiTelfailed_db_sql &

    # Get the process ID of mysqldump
    mysqldump_pid=$!

    # Wait for the mysqldump process to complete
    wait "$mysqldump_pid"

    # Check if the dump was successful
    if [ $? -eq 0 ]; then
        echo -e "${BICyan}Database${Color_Off} ${BIRed}$smsfailed_db_name${Color_Off} ${BICyan}Dump${Color_Off} ${BIGreen}Complete.${Color_Off}"
        echo

        # Display the file name and its creation time
        echo -e "${BICyan}Server Current Time :${Color_Off} ${BIRed}$(date +'%b %e %H:%M')${Color_Off}"
        echo

        cd /var/lib/mysql
        iTelSMSFAILEDSQLFile=$(ls -hl $smsfailed_db_name.sql | awk '{print $9, $5, $6, $7, $8}')
        echo -e "${BICyan}$smsfailed_db_name.sql File :${Color_Off} ${BIRed}$iTelSMSFAILEDSQLFile${Color_Off}"
        echo
    else
        echo -e "${BIBlue}Error :${Color_Off} ${BIRed}Failed${Color_Off} ${BICyan}To Dumping${Color_Off} ${BYellow}$smsfailed_db_name${Color_Off} ${BICyan}Database.${Color_Off}"
        echo
    fi
}


# Function to dump a SMSCampaigns mongo database to a SQL file
function dump_SMSCampaigns_MONGO_DB() {
    echo -e "${BIYellow}MongoDB${Color_Off}${BCyan}Storing :${Color_Off} ${BRed}$SMSCampaigns_mongodb_name${Color_Off}"
    echo

    cd /usr/local/
    # Start the mongodump in the background
    mongodump --db $SMSCampaigns_mongodb_name -o "/usr/local/$folder_name/" > /dev/null 2>&1 &

    # Get the process ID of mongodump
    mongodump_pid=$!

    # Wait for the mysqldump process to complete
    wait $mongodump_pid

    # Check if the dump was successful
    if [ $? -eq 0 ]; then
        echo -e "${BIYellow}MongoDB${Color_Off} ${BIRed}$SMSCampaigns_mongodb_name${Color_Off} ${BICyan}Store${Color_Off} ${BIGreen}Complete.${Color_Off}"
        echo

        # Display the file name and its creation time
        echo -e "${BICyan}Server Current Time :${Color_Off} ${BIRed}$(date +'%b %e %H:%M')${Color_Off}"
        echo

        mongoDBSMSCampaignsFile=$(cd /usr/local/$folder_name && ls -ld --time-style="+%b %_d %H:%M" /usr/local/$folder_name/$SMSCampaigns_mongodb_name | awk '{print $6, $7, $8, $9}' | sed 's/\/usr\/local\/'$folder_name'\///')
        echo -e "${BIYellow}MongoDB${Color_Off} ${BICyan}File [SMSCampaigns] :${Color_Off} ${BIRed}$mongoDBSMSCampaignsFile${Color_Off}"
        echo
    else
        echo -e "${BIBlue}Error :${Color_Off} ${BIRed}Failed${Color_Off} ${BICyan}To Storing${Color_Off} ${BYellow}$SMSCampaigns_mongodb_name${Color_Off} ${BICyan}Database.${Color_Off}"
        echo
    fi
}

# Function to dump a SMSContacts mongo database to a SQL file
function dump_SMSContacts_MONGO_DB() {
    echo -e "${BIYellow}MongoDB${Color_Off}${BCyan}Storing :${Color_Off} ${BRed}$SMSContacts_mongodb_name${Color_Off}"
    echo

    cd /usr/local/
    # Start the mongodump in the background
    mongodump --db $SMSContacts_mongodb_name -o "/usr/local/$folder_name/" > /dev/null 2>&1 &

    # Get the process ID of mongodump
    mongodump_pid=$!

    # Wait for the mysqldump process to complete
    wait $mongodump_pid

    # Check if the dump was successful
    if [ $? -eq 0 ]; then
        echo -e "${BIYellow}MongoDB${Color_Off} ${BIRed}$SMSContacts_mongodb_name${Color_Off} ${BICyan}Store${Color_Off} ${BIGreen}Complete.${Color_Off}"
        echo

        # Display the file name and its creation time
        echo -e "${BCyan}Server Current Time :${Color_Off} ${BRed}$(date +'%b %e %H:%M')${Color_Off}"
        echo

        mongoDBSMSContactsFile=$(cd /usr/local/$folder_name && ls -ld --time-style="+%b %_d %H:%M" /usr/local/$folder_name/$SMSContacts_mongodb_name | awk '{print $6, $7, $8, $9}' | sed 's/\/usr\/local\/'$folder_name'\///')
        echo -e "${BIYellow}MongoDB${Color_Off} ${BICyan}File [SMSCampaigns] :${Color_Off} ${BIRed}$mongoDBSMSContactsFile${Color_Off}"
        echo
    else
        echo -e "${BIBlue}Error :${Color_Off} ${BIRed}Failed${Color_Off} ${BICyan}To Storing${Color_Off} ${BYellow}$SMSContacts_mongodb_name${Color_Off} ${BICyan}Database.${Color_Off}"
        echo
    fi
}

# Function to remove old logs and move directories
function collect_WholeSaleSMSServer_iTelSMSAppServer() {
    local smsFolder="$1"
    local smsAppFolder="$2"
    local folder_name="$3"

    echo -e "${BICyan}Removing Old Logs${Color_Off} ${BIRed}[WholeSaleSMSServer$smsFolder]${Color_Off}"
    echo

    # Check if the directories exist before removing files
    if [ -d "/usr/local/WholeSaleSMSServer$smsFolder/logs" ]; then
        rm -rf "/usr/local/WholeSaleSMSServer$smsFolder/logs/20*"
        rm -f "/usr/local/WholeSaleSMSServer$smsFolder/SMSServer.log.*"
        echo -e "${BICyan}Removing Old Logs${Color_Off} ${BIGreen}Successfully${Color_Off}"
        echo
    else
        echo -e "${BICyan}Directory${Color_Off} ${BIYellow}[/usr/local/WholeSaleSMSServer$smsFolder/logs]${Color_Off} ${BIRed}Does Not Exist${Color_Off}"
        echo
    fi

    echo -e "${BICyan}Removing Old Logs${Color_Off} ${BIRed}[iTelSMSAppServer$smsAppFolder]${Color_Off}"
    echo

    if [ -d "/usr/local/iTelSMSAppServer$smsAppFolder/logs" ]; then
        rm -rf "/usr/local/iTelSMSAppServer$smsAppFolder/logs/20*"
        echo -e "${BICyan}Removing Old Logs${Color_Off} ${BIGreen}Successfully${Color_Off}"
        echo
    else
        echo -e "${BICyan}Directory${Color_Off} ${BIYellow}[/usr/local/iTelSMSAppServer$smsAppFolder/logs]${Color_Off} ${BIRed}Does Not Exist.${Color_Off}"
        echo
    fi

    echo -e "${BICyan}Moving ${Color_Off}${BIRed}[WholeSaleSMSServer$smsFolder${Color_Off} ${BICyan}&${Color_Off} ${BIRed}iTelSMSAppServer$smsAppFolder]${Color_Off} \n${BICyan}To${Color_Off}${BIGreen} [/usr/local/$folder_name]${Color_Off}"
    echo

    cp -r "WholeSaleSMSServer$smsFolder" "iTelSMSAppServer$smsAppFolder" "/usr/local/$folder_name"
}


# Function to restore MongoDB databases from dump files on the Destination Server
function restore_mongodb_databases() {
    # Define the paths to the MongoDB dump files on the Destination Server
    dump_file_SMSCampaigns="/usr/local/$folder_name/$SMSCampaigns_mongodb_name"
    dump_file_SMSContacts="/usr/local/$folder_name/$SMSContacts_mongodb_name"

    # Check if the MongoDB dump files exist on the Destination Server
    if ! ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "[ -d $dump_file_SMSCampaigns ] && [ -d $dump_file_SMSContacts ]"; then
        echo -e "${BIBlue}Error :${Color_Off} ${BIYellow}MongoDB${Color_Off} ${BICyan}Stored Files${Color_Off} ${BIRed}Not Found${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
        echo
        return 1
    fi

    # Restore the SMSCampaigns MongoDB database
    echo -e "${BICyan}Restoring [SMSCampaigns]${Color_Off} ${BIYellow}MongoDB${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
    echo
    ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "mongorestore --db $SMSCampaigns_mongodb_name $dump_file_SMSCampaigns > /dev/null 2>&1 &"

    # Check the exit code of the previous command
    if [ $? -eq 0 ]; then
        echo -e "${BICyan}Restoration of [SMSCampaigns]${Color_Off} ${BIYellow}MongoDB${Color_Off} ${BICyan}Is${Color_Off} ${BIGreen}Successful${Color_Off}"
        echo
    else
        echo -e "${BIBlue}Error :${Color_Off} ${BIRed}Failed${Color_Off} ${BICyan}To Restore [SMSCampaigns] ${BIYellow}MongoDB${Color_Off}"
        echo
        return 1
    fi

    # Restore the SMSContacts MongoDB database
    echo -e "${BICyan}Restoring [SMSContacts]${Color_Off} ${BIYellow}MongoDB${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
    echo
    ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "mongorestore --db $SMSContacts_mongodb_name $dump_file_SMSContacts > /dev/null 2>&1 &"

    # Check the exit code of the previous command
    if [ $? -eq 0 ]; then
        echo -e "${BICyan}Restoration of [SMSContacts]${Color_Off} ${BIYellow}MongoDB${Color_Off} ${BICyan}Is${Color_Off} ${BIGreen}Successful${Color_Off}"
        echo
    else
        echo -e "${BIBlue}Error :${Color_Off} ${BIRed}Failed${Color_Off} ${BICyan}To Restore [SMSContacts] ${BIYellow}MongoDB${Color_Off}"
        echo
        return 1
    fi

    # If you reach this point, both MongoDB databases were restored successfully
    echo -e "${BIYellow}MongoDB${Color_Off} ${BICyan}Restored${Color_Off} ${BICyan}Successfully${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
    echo
}

# Function to rename folders on the Destination Server if they exist
function backup_destination_folders() {
    local backup_timestamp=$(date +'%Y%m%d_%H%M%S')
    local found_folders=false

    # Keywords to search for in folder names
    local keywords=("iTelSMSAppServer" "WholeSaleSMSServer")

    # List all folders in /usr/local/ on the Destination Server
    local folders=$(ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "find /usr/local/ -maxdepth 1 -type d -printf '%f\n'")

    # Loop through the keywords and check if any folders contain them
    for keyword in "${keywords[@]}"; do
        for folder in $folders; do
            if [[ "$folder" == *"$keyword"* ]]; then
                found_folders=true
                # Rename the folder with a timestamp on the Destination Server
                ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "mv '/usr/local/$folder' '/usr/local/${folder}_BK_$backup_timestamp'"
                echo -e "${BICyan}Backuped ${BIRed}[$folder]${Color_Off} ${BICyan}To${Color_Off} ${BIRed}[${folder}_BK_$backup_timestamp]${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
                echo
            fi
        done
    done

    if ! $found_folders; then
        echo -e "${BIGreen}Not Found${Color_Off} ${BICyan}Any Existing Service${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
        echo
    fi
}


# Function to move folders to /usr/local/ and take backups if necessary
function realocate_data() {
    local destination_server="$1"
    local folder_name="$2"
    local smsAppFolder="$3"
    local smsFolder="$4"
    local folders_to_move=("WholeSaleSMSServer$smsFolder" "iTelSMSAppServer$smsAppFolder" "apache-tomcat-7.0.59")

    # Move the folders to /usr/local/
    for folder_name_to_move in "${folders_to_move[@]}"; do
        ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "mv '/usr/local/$folder_name/$folder_name_to_move' '/usr/local/'"
        echo -e "${BICyan}Moved ${BIRed}[$folder_name_to_move]${Color_Off} ${BICyan}To${Color_Off} ${BIRed}[/usr/local/]${Color_Off}"
        echo
    done

    # Prompt for confirmation before removing the /usr/local/$folder_name directory
    echo -e "${BICyan}Want To Remove${Color_Off} ${BIRed}[$folder_name]${Color_Off} ${BICyan}From Destination Server${Color_Off} ${BIRed}[$destination_server]${Color_Off}${BICyan}?${Color_Off} ${BIGreen}[${Color_Off}${BIRed}Y${Color_Off}${BIGreen}/${Color_Off}${BIRed}N${Color_Off}${BIGreen}]${Color_Off} ${BICyan}:${Color_Off} "
    read confirmation
    echo
    if [ "$confirmation" = "yes" ] || [ "$confirmation" = "y" ] || [ "$confirmation" = "YES" ] || [ "$confirmation" = "Y" ]; then
        ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "rm -rf '/usr/local/$folder_name'"
        echo -e "${BICyan}Removed${Color_Off} ${BIRed}[$folder_name]${Color_Off} ${BICyan}From Destination Server${Color_Off}"
        echo
    else
        echo -e "${BIRed}Folder Removal Canceled${Color_Off}"
        echo
    fi
}

# Define a function to run softlink.sh on the destination server
run_softlink() {
    softlink_wholeSalesSMSServer="/usr/local/WholeSaleSMSServer$smsFolder/softlink.sh"
    softlink_SMSAppServer="/usr/local/iTelSMSAppServer$smsAppFolder/softlink.sh"

    # Check if the softlink file exists in WholeSaleSMSServer directory on the destination server
    if ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "[ -f '$softlink_wholeSalesSMSServer' ]"; then
        echo -e "${BIYellow}Softlink${Color_Off} ${BICyan}File${Color_Off} ${BIGreen}Found${Color_Off} ${BICyan}In${Color_Off} ${BIRed}WholeSaleSMSServer$smsFolder${Color_Off}"
        echo

        # Execute the softlink file for WholeSaleSMSServer
        ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "\
            sh '$softlink_wholeSalesSMSServer'"

        # Check if execution was successful
        if [ $? -eq 0 ]; then
            echo -e "${BICyan}Execution Of${Color_Off} ${BIYellow}Softlink${Color_Off} ${BICyan}File For${Color_Off} ${BIRed}WholeSaleSMSServer$smsFolder${Color_Off} ${BIGreen}Successfully${Color_Off}"
            echo
        else
            echo -e "${BICyan}Execution Of${Color_Off} ${BIYellow}Softlink${Color_Off} ${BICyan}File For${Color_Off} ${BIYellow}WholeSaleSMSServer$smsFolder${Color_Off} ${BIRed}Failed${Color_Off}"
            echo
        fi
    else
        echo -e "${BIBlue}Error :${Color_Off} ${BIYellow}Softlink${Color_Off} ${BICyan}File${Color_Off} ${BIRed}Not Found${Color_Off} ${BICyan}In${Color_Off} ${BIYellow}WholeSaleSMSServer$smsFolder${Color_Off}"
        echo
    fi

    # Check if the softlink file exists in iTelSMSAppServer directory on the destination server
    if ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "[ -f '$softlink_SMSAppServer' ]"; then
        echo -e "${BIYellow}Softlink${Color_Off} ${BICyan}File${Color_Off} ${BIGreen}Found${Color_Off} ${BICyan}In${Color_Off} ${BIRed}iTelSMSAppServer$smsAppFolder${Color_Off}"
        echo

        # Execute the softlink file for iTelSMSAppServer
        ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "\
            sh '$softlink_SMSAppServer'"

        # Check if execution was successful
        if [ $? -eq 0 ]; then
            echo -e "${BICyan}Execution Of${Color_Off} ${BIYellow}Softlink${Color_Off} ${BICyan}File For${Color_Off} ${BIRed}iTelSMSAppServer$smsAppFolder${Color_Off} ${BIGreen}Successfully${Color_Off}"
            echo
        else
            echo -e "${BICyan}Execution Of${Color_Off} ${BIYellow}Softlink${Color_Off} ${BICyan}File For${Color_Off} ${BIYellow}iTelSMSAppServer$smsAppFolder${Color_Off} ${BIRed}Failed${Color_Off}"
            echo
        fi
    else
        echo -e "${BIBlue}Error :${Color_Off} ${BIYellow}Softlink${Color_Off} ${BICyan}File${Color_Off} ${BIRed}Not Found${Color_Off} ${BICyan}In${Color_Off} ${BIYellow}iTelSMSAppServer$smsAppFolder${Color_Off}"
        echo
    fi

    # Check if service files were created successfully
    if ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "[ -f '/etc/init.d/WholeSaleSMSServer$smsFolder' ] && [ -f '/etc/init.d/iTelSMSAppServer$smsAppFolder' ]"; then
        echo -e "${BICyan}Service Files${Color_Off} ${BIGreen}Created successfully${Color_Off}"
        echo
    else
        echo -e "${BIBlue}Error :${Color_Off} ${BICyan}Service Files${Color_Off} ${BIRed}Creation Failed${Color_Off}"
        echo

        # Check if service files exist on the current server
        if [ -f "/etc/init.d/WholeSaleSMSServer$smsFolder" ] && [ -f "/etc/init.d/iTelSMSAppServer$smsAppFolder" ]; then
            # Copy service files from the current server to the destination server
            rsync -ah --no-inc-recursive -e "ssh -p $ssh_port -o ControlPath=$SSHSOCKET" "/etc/init.d/WholeSaleSMSServer$smsFolder" "$ssh_user@$destination_server:/etc/init.d/" >/dev/null 2>&1 &
            rsync -ah --no-inc-recursive -e "ssh -p $ssh_port -o ControlPath=$SSHSOCKET" "/etc/init.d/iTelSMSAppServer$smsAppFolder" "$ssh_user@$destination_server:/etc/init.d/" >/dev/null 2>&1 &

            # Check if the copy was successful
            if [ $? -eq 0 ]; then
                echo -e "${BIYellow}Service Files${Color_Off} ${BIGreen}Copied Successfully${Color_Off} ${BICyan}From Current Server${Color_Off}"
                echo
            else
                echo -e "${BIBlue}Error :${Color_Off} ${BIYellow}Service Files${Color_Off} ${BIRed}Copy Failed${Color_Off}"
                echo
            fi
        else
            echo -e "${BIYellow}No Service Files${Color_Off} ${BICyan}Found on the Current Server to Copy${Color_Off}"
            echo
        fi
    fi
}


# Function to restart Apache Tomcat on a remote server
function restart_apacheTomcat {
    # Function to execute remote commands on the destination server and capture the output
    function execute_remote_command {
        local command="$1"
        local output
        output=$(ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "$command" 2>&1)
        echo "$output"
    }

    # Find the Tomcat service name based on its script content
    service_file=$(execute_remote_command "grep -l 'apache-tomcat-7.0.59' /etc/init.d/*" | head -n 1)
    service_name=$(basename "$service_file")


    # Print the found service file
    echo -e "${BIGreen}Found${Color_Off} ${BIRed}[Apache - Tomcat]${Color_Off} ${BICyan}Service File :${Color_Off} ${BIRed}$service_name${Color_Off}"
    echo

    # Stop Tomcat service three times
    echo -e "${BICyan}Stopping${Color_Off} ${BIYellow}[Apache Tomcat]${Color_Off}"
    echo
    for i in {1..3}; do
        execute_remote_command "service $service_name stop > /dev/null 2>&1 &"
        sleep 1  # Adjust the sleep time if needed
    done

    # Check if Tomcat is still running and kill the process if needed
    if execute_remote_command "pgrep -f 'apache-tomcat-7.0.59' > /dev/null"; then
        echo -e "${BIYellow}[Apache Tomcat]${Color_Off} ${BIRed}Did Not Stop Properly${Color_Off}"
        echo
        echo -e "${BICyan}Now Killing The Process${Color_Off}"
        echo
        execute_remote_command "pkill -f 'apache-tomcat-7.0.59' > /dev/null 2>&1 &"
        
        # Display process information after killing
        processes_info=$(execute_remote_command "ps aux | grep -E 'apache-tomcat-7.0.59' --color=auto | grep -v grep")
        if [ -n "$processes_info" ]; then
            echo -e "${BICyan}Process After Killing${Color_Off}"
            echo
            echo "$processes_info"
            echo
        else
            echo -e "${BIYellow}[Apache - Tomcat]${Color_Off} ${BIGreen}Stop Successfully${Color_Off}"
            echo
        fi
    fi

    # Delete Catalina directory
    echo -e "${BICyan}Deleting Catalina Folder${Color_Off}"
    echo
    execute_remote_command "rm -rf /usr/local/apache-tomcat-7.0.59/work/Catalina > /dev/null 2>&1 &"

    # Delete catalina.out file
    echo -e "${BICyan}Deleting [catalina.out] File${Color_Off}"
    echo
    execute_remote_command "rm -f /usr/local/apache-tomcat-7.0.59/logs/catalina.out > /dev/null 2>&1 &"

    # Start Tomcat service without displaying the "Starting tomcat" message
    echo -e "${BICyan}Starting${Color_Off} ${BIYellow}[Apache Tomcat]${Color_Off}"
    echo
    execute_remote_command "nohup service $service_name start > /dev/null 2>&1 &"

    # Sleep for a few seconds to allow Tomcat to start
    sleep 5

    # Check if Tomcat has started
    if execute_remote_command "pgrep -f 'apache-tomcat-7.0.59' > /dev/null"; then
        echo -e "${BIYellow}[Apache - Tomcat]${Color_Off} ${BIGreen}Started Successfully${Color_Off}"
        echo
    else
        echo -e "${BIYellow}[Apache - Tomcat]${Color_Off} ${BIRed}Failed To Start${Color_Off}"
        echo
    fi

    # Wait for Tomcat to start
    echo -e "${BICyan}Waiting For ${BIRed}SMS Web Billing${Color_Off} ${BICyan}Startup${Color_Off}"
    echo
    while ! execute_remote_command "grep -q 'Server startup in' /usr/local/apache-tomcat-7.0.59/logs/catalina.out > /dev/null 2>&1 &"; do
        sleep 1
    done

    echo -e "${BIRed}SMS Web Billing${Color_Off} ${BICyan}Is${Color_Off} ${BIGreen}Up Now${Color_Off}"
    echo
    echo -e "${BIYellow}[Apache Tomcat]${Color_Off} ${BIGreen}Restarted Successfully${Color_Off}"
    echo
}


restart_diskSpaceChecker() {
    diskSpaceChecker_file_path="/usr/local/DiskSpaceChecker/email_properties"

    # Restart DiskSpaceChecker on the destination server
    echo -e "${BICyan}Restarting DiskSpaceChecker${Color_Off}"
    echo

    # Check if the file exists on the destination server
    if ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "[ -f '$diskSpaceChecker_file_path' ]"; then
        # Extract the current port value
        current_port=$(ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "grep -oP 'MailSeverPort=\K\\d+' '$diskSpaceChecker_file_path'")
        
        # Display the current port value
        echo -e "${BICyan}Current MailServer Port :${Color_Off} ${BIRed}$current_port${Color_Off}"
        echo

        # Set the new port value
        new_port=587
        
        # Replace the existing port value with the new port
        ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "sed -i \"s/MailSeverPort=.*/MailSeverPort=$new_port/\" '$diskSpaceChecker_file_path'"
        
        echo -e "${BICyan}New MailServer Port :${Color_Off} ${BIRed}$new_port${Color_Off}"
        echo
    else
        echo -e "${BIYellow}[email_properties] ${BICyan}File${Color_Off} ${BIRed}Not Found${Color_Off}"
        return 1
    fi

    # Shut down DiskSpaceChecker and suppress nohup messages
    echo -e "${BPurple}DiskSpaceChecker Shutting Down${Color_Off}"
    echo
    ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "\
        (sh /usr/local/DiskSpaceChecker/shutdownDiskSpaceChecker.sh 2>&1 >/dev/null || true) &&
        (sh /usr/local/DiskSpaceChecker/shutdownDiskSpaceChecker.sh 2>&1 >/dev/null || true) &&
        (sh /usr/local/DiskSpaceChecker/shutdownDiskSpaceChecker.sh 2>&1 >/dev/null || true) &
    " 
    sleep 2

    echo -e "${BICyan}Starting DiskSpaceChecker${Color_Off}"
    echo
    ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "nohup sh /usr/local/DiskSpaceChecker/runDiskSpaceChecker.sh >/dev/null 2>&1 &"
    sleep 10
    
    # Check if DiskSpaceChecker is NOT running on the destination server
    if ! ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "ps -C DiskSpaceChecker -o pid= >/dev/null 2>&1"; then
        echo -e "${BIYellow}DiskSpaceChecker${Color_Off} ${BIGreen}Started Successfully${Color_Off}"
        echo
    else
        echo -e "${BIBlue}Error :${Color_Off} ${BIYellow}DiskSpaceChecker${Color_Off} ${BIGreen}Failed To Start${Color_Off}"
        echo
        return 1
    fi
}

start_iTelSMSAppServer() {
    echo -e "${BICyan}Starting iTelSMSAppServer${Color_Off}"
    echo

    # Start iTelSMSAppServer (modify this command according to your actual service start command)
    ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "nohup sh /usr/local/iTelSMSAppServer$smsAppFolder/runiTelSMSAppServer.sh > /dev/null 2>&1 &"

    # Check if iTelSMSAppServer is running (using -f to match the full command line)
    if ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "pgrep -f 'iTelSMSAppServer.jar $smsAppFolder' >/dev/null 2>&1"; then
        echo -e "${BIRed}iTelSMSAppServer$smsAppFolder${Color_Off} ${BIGreen}Started Successfully${Color_Off}"
        echo
    else
        echo -e "${BIBlue}Error :${Color_Off} ${BIGreen}Failed To Start${Color_Off} ${BIYellow}iTelSMSAppServer$smsAppFolder${Color_Off}"
        echo
    fi
}


# Define the function for start WholeSaleSMSServer on the destination server
start_WholeSaleSMSServer() {
    #start wholeSaleSMSServer
    echo -e "${BICyan}Starting WholeSaleSMSServer${Color_Off}"
    echo

    local log_dir="/usr/local/WholeSaleSMSServer$smsFolder"
    local log_files=("$log_dir/iTelSMS.log" "$log_dir/iTelSMSServer.log")
    local existing_log_file=""

    # Find the first existing log file in the directory
    for log_file in "${log_files[@]}"; do
        if ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "[ -f '$log_file' ]"; then
            existing_log_file="$log_file"
            break
        fi
    done

    if [ -z "$existing_log_file" ]; then
        echo -e "${BICyan}Existing Log Files${Color_Off} ${BICyan}Not Found${Color_Off} ${BICyan}In${Color_Off} ${BIYellow}[WholeSaleSMSServer$smsFolder]${Color_Off}"
        echo
        return 1
    fi

    # Restart the application silently
    ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "\
        (nohup sh '/usr/local/WholeSaleSMSServer$smsFolder/runSMS_Server.sh' 2>&1 >/dev/null || true) </dev/null >/dev/null 2>&1 &
    "

    # Continuously monitor the existing log file for the "started successfully" message
    while true; do
        new_lines=$(ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "\
            tail -n +1 '$existing_log_file'")
        if echo "$new_lines" | grep -Fq "started successfully"; then
            echo -e "${BIYellow}WholeSaleSMSServer$smsFolder${Color_Off} ${BIGreen}Started Successfully.${Color_Off}"
            echo
            break
        fi
        sleep 1
    done

    # Check for errors and return non-zero exit status if not successful
    if [[ $? -ne 0 ]]; then
        echo -e "${BIRed}Failed To Start${Color_Off} ${BIYellow}WholeSaleSMSServer$smsFolder${Color_Off}"
        echo
        return 1
    fi
}



# # Define the function for stop WholeSaleSMSServer
stop_WholeSaleSMSServer() {
# Define the paths for potential log files
itel_sms_server_log="/usr/local/WholeSaleSMSServer$smsFolder/iTelSMS.log"
itel_sms_server_log_2="/usr/local/WholeSaleSMSServer$smsFolder/iTelSMSServer.log"

# Variable to store the existing log file
existing_log_file=""

# Check if any of the log files exist on the current server
if [ -f "$itel_sms_server_log" ]; then
    existing_log_file="$itel_sms_server_log"
elif [ -f "$itel_sms_server_log_2" ]; then
    existing_log_file="$itel_sms_server_log_2"
fi

if [ -n "$existing_log_file" ]; then
    echo -e "${BICyan}Stopping${Color_Off} ${BIYellow}WholeSaleSMSServer$smsFolder${Color_Off} ${BICyan}In The Current Server${Color_Off}${BIRed}[$serverIP]${Color_Off}"
    echo
    # Get the current line number in the log before the shutdown
    start_line=$(wc -l < "$existing_log_file")

    for _ in {1..3}; do
        sh "/usr/local/WholeSaleSMSServer$smsFolder/shutdownSMS_Server.sh" >> /dev/null
    done

    # Wait for the "shutting down successfully" message
    while true; do
        if grep -Fq "shutting down successfully" "$existing_log_file"; then
            break
        fi
        sleep 1
    done

    # Extract the latest shutdown time from the log
    shutdown_time=$(grep -oE '^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}' "$existing_log_file" | tail -n 1)
    
    if [[ -n "$shutdown_time" ]]; then
        echo -e "${BIRed}$shutdown_time${Color_Off}${BIYellow} WholeSaleSMSServer$smsFolder${Color_Off} ${BICyan}Stopped${Color_Off} ${BIGreen}Successfully.${Color_Off}"
        echo
    else
        echo -e "${BIYellow}WholeSaleSMSServer$smsFolder${Color_Off} ${BICyan}Did${Color_Off} ${BIRed}Not Stopped${Color_Off}"
        echo
    fi
else
    echo -e "${BIBlue}Warning: ${Color_Off}${BIRed}Not Found${Color_Off}${BICyan} Any Log Files${Color_Off}"
    echo
fi
}

stop_iTelSMSAppServer() {
    echo -e "${BICyan}Stopping${Color_Off} ${BIYellow}iTelSMSAppServer$smsAppFolder${Color_Off} ${BICyan}In The Current Server${Color_Off}${BIRed}[$serverIP]${Color_Off}"
    echo

    # Define the name of the iTelSMSAppServer process
    app_server_process="iTelSMSAppServer$smsAppFolder"

    # Stop the iTelSMSAppServer
    for _ in {1..3}; do
        sh "/usr/local/iTelSMSAppServer$smsAppFolder/runiTelSMSAppServer.sh" >> /dev/null
    done

    # Check if the process is still running
    if pgrep -f "$app_server_process" > /dev/null; then
        echo -e "${BICyan}Did${Color_Off} ${BIRed}Not Stop${Color_Off} ${BIYellow}iTelSMSAppServer$smsAppFolder${Color_Off}"
        echo
    else
        echo -e "${BIYellow}iTelSMSAppServer$smsAppFolder${Color_Off} ${BIGreen}Stopped Successfully.${Color_Off}"
        echo
    fi
}


start_services() {
    # Define the paths for log files
    itel_sms_server_log="/usr/local/WholeSaleSMSServer$smsFolder/iTelSMS.log"
    itel_sms_server_log_2="/usr/local/WholeSaleSMSServer$smsFolder/iTelSMSServer.log"
    itel_sms_app_log="/usr/local/iTelSMSAppServer$smsAppFolder/iTelSMSApp.log"

    # Variable to store the existing log file
    existing_log_file_wholeSalesSMS=""
    existing_log_file_iTelSMSApp=""

    # Check if any of the log files exist on the destination server
    if ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "[ -f '$itel_sms_server_log' ] || [ -f '$itel_sms_server_log_2' ]"; then
        # Find the existing log file
        if ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "[ -f '$itel_sms_server_log' ]"; then
            existing_log_file_wholeSalesSMS="$itel_sms_server_log"
        elif ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "[ -f '$itel_sms_server_log_2' ]"; then
            existing_log_file_wholeSalesSMS="$itel_sms_server_log_2"
        fi

        if ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "[ -f '$itel_sms_app_log' ]"; then
            existing_log_file_iTelSMSApp="$itel_sms_app_log"

            if [ -n "$existing_log_file_wholeSalesSMS" ] && [ -n "$existing_log_file_iTelSMSApp" ]; then
                timestamp=$(date +"%Y%m%d%H%M%S")

                # Backup the existing log files with a timestamp
                log_backup_wholeSaleSMS="${existing_log_file_wholeSalesSMS}.${timestamp}"
                log_backup_iTelSMSApp="${existing_log_file_iTelSMSApp}.${timestamp}"

                # Perform backup and log recreation with error handling
                if ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "mv '$existing_log_file_wholeSalesSMS' '$log_backup_wholeSaleSMS'" &&
                ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "mv '$existing_log_file_iTelSMSApp' '$log_backup_iTelSMSApp'" &&
                ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "touch '$existing_log_file_wholeSalesSMS'" &&
                ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "touch '$existing_log_file_iTelSMSApp'"; then
                    echo -e "${BICyan}Old Main Log Files Backed Up ${BIGreen}Successfully${Color_Off}"
                    echo
                else
                    echo -e "${BIRed}Error: Failed to backup or recreate log files.${Color_Off}"
                    echo
                fi
            else
                echo -e "${BIBlue}Warning: ${Color_Off}${BICyan}Old Main Log Files Not Found${Color_Off} ${BIRed}On The Destination Server${Color_Off}"
                echo
            fi
        else
            echo -e "${BIBlue}Warning: ${Color_Off}${BICyan}No Log Files Found${Color_Off} ${BIRed}On The Destination Server${Color_Off}"
            echo
        fi
    else
        echo -e "${BIBlue}Warning: ${Color_Off}${BICyan}No Log Files Found${Color_Off} ${BIRed}On The Destination Server${Color_Off}"
        echo
    fi


    echo -e "${BIRed}WARNING : ${Color_Off}${BIGreen}PLease Go To The RIMS & Update The IP [${Color_Off}${BIYellow}New IP :${Color_Off} ${BIRed}$destination_server${Color_Off}${BIGreen}] For This${Color_Off} ${BIRed}[$refNo]${Color_Off}"
    echo -e "${BIRed}WARNING : ${Color_Off}${BIGreen}After Update RIMS You Can Start The Services In The New Server${Color_Off}${BIRed}[$destination_server]${Color_Off}"
    echo

    echo -e "${BICyan}Want To ${BIGreen}Start${Color_Off} ${BICyan}Services In The${Color_Off} ${BIYellow}New Server${Color_Off} ${BIRed}[$destination_server]${Color_Off}${BICyan}?${Color_Off} ${BIGreen}[${Color_Off}${BIRed}Y${Color_Off}${BIGreen}/${Color_Off}${BIRed}N${Color_Off}${BIGreen}]${Color_Off} ${BICyan}:${Color_Off} "
    read -r run_services_response
    echo

    if [[ "$run_services_response" =~ ^[Yy][Ee]?[Ss]?$ ]]; then
        #start WholesaleSMSServer
        start_WholeSaleSMSServer
    else
        echo -e "${BICyan}Services Is${Color_Off} ${BIRed}Not Started${Color_Off}"
        echo
        echo -e "${BICyan}Need To${Color_Off} ${BIYellow}Start Manually${Color_Off}"
        echo
    fi

    # start iTelSMSAppServer
    start_iTelSMSAppServer

    # Re - start iTelSMSAppServer
    restart_diskSpaceChecker
    
    # Re - start Apache - Tomcat
    restart_apacheTomcat

    echo -e "${BICyan}Here Is The All Processes Of This Server${Color_Off}"
    echo
    ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "ps aux | grep -E '$smsFolder|$smsAppFolder|apache-tomcat-7.0.59|DiskSpaceChecker' --color=auto | grep -v grep"
    echo
}

stop_services_Current_server() {
    echo -e "${BICyan}Want To ${BIRed}Stop${Color_Off} Services In The ${BIYellow}Current Server${Color_Off} ${BIRed}[$serverIP]${Color_Off}${BICyan}?${Color_Off} ${BIGreen}[${Color_Off}${BIRed}Y${Color_Off}${BIGreen}/${Color_Off}${BIRed}N${Color_Off}${BIGreen}]${Color_Off} ${BICyan}:${Color_Off} "
    read -r stop_services_response
    echo

    if [[ "$stop_services_response" =~ ^[Yy][Ee]?[Ss]?$ ]]; then
        # Call the function for stop WholeSaleSMSServer in the current server
        stop_WholeSaleSMSServer

        #stop iTelSMSAppServer in the current server
        stop_iTelSMSAppServer
    else
        echo -e "${BICyan}Services Is${Color_Off} ${BIRed}Not Stoppted${Color_Off}"
        echo
        echo -e "${BICyan}Need To${Color_Off} ${BIYellow}Stop Manually${Color_Off}"
        echo
    fi
}

client_reply() {
# Execute the MySQL query on the destination server and retrieve the values
query="SELECT smsSMPPPort, smsHTTPPort, smsHTTPSPort FROM vbSMSServerInfo"
result=$(ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "mysql -u root $smsiTel_db_name -e \"$query\"")

# Check for SSH and MySQL errors
if [ $? -eq 0 ]; then
    # Extract the values into separate variables
    smsSMPPPort=$(echo "$result" | awk 'NR==2 {print $2}')
    smsHTTPPort=$(echo "$result" | awk 'NR==2 {print $4}')
    smsHTTPSPort=$(echo "$result" | awk 'NR==2 {print $6}')
else
    echo -e "${BIBlue}Error :${Color_Off} ${BIRed}Executing SSH OR MySQL Command${Color_Off}"
    echo
fi

echo -e "${BICyan}Dear Sir,${Color_Off}"
echo
echo -e "${BIYellow}I Hope You Are Well.${Color_Off}"
echo -e "${BIBlue}As Per Pour Sales Manager's Confirmation, We Have Shifted Your REVE SMS Switch.${Color_Off}"
echo
echo
echo -e "${BIYellow}Here Is The All-New INFO${Color_Off}"
echo
echo -e "${BIBlue}We Have Shifted Your REVE SMS Switch To A [${Color_Off}${BIGreen}New Server${Color_Off} ${BIBlue}:${Color_Off} ${BIRed}$destination_server${Color_Off}${BIBlue}]${Color_Off}"
echo
echo -e "${BIGreen}Billing URL${Color_Off} ${BIBlue}:${Color_Off} ${BIRed}http://$destination_server/$billingName/${Color_Off}
\n${BIGreen}Username/Password${Color_Off} ${BIBlue}:${Color_Off} ${BIYellow}Same As Before${Color_Off}
\n${BIGreen}SMPP IP${Color_Off} ${BIBlue}:${Color_Off} ${BIRed}$destination_server${Color_Off}
\n${BIGreen}SMPP PORT${Color_Off} ${BIBlue}:${Color_Off} $smsSMPPPort${Color_Off}
\n${BIGreen}HTTP PORT${Color_Off} ${BIBlue}:${Color_Off} $smsHTTPPort${Color_Off}
\n${BIGreen}HTTPS PORT${Color_Off} ${BIBlue}:${Color_Off} $smsHTTPSPort${Color_Off}"
echo
echo
echo -e "${BIRed}N:B :${Color_Off} ${BIYellow}Please Inform Your Client About Your New switch IP/PORT The New Billing Link.${Color_Off}"
echo
}

no_need() {
    # Check MySQL version on the Destination Server
    if ! check_mysql_version; then
        echo -e "${BIBlue}Error :${Color_Off} ${BIYellow}MySQL${Color_Off} ${BICyan}Version 8 Is${Color_Off} ${BIRed}Not Installed${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
        echo
        echo -e "${BIBlue}Warning : ${Color_Off}${BICyan}Please Install${Color_Off} ${BIYellow}MySQL${Color_Off} ${BICyan}Version 8 & Ensure It's Running Before Proceeding The Data Transfer${Color_Off}"
        echo
        exit 1
    else
        echo -e "${BIYellow}MySQL${Color_Off} ${BICyan}Version 8${Color_Off} ${BIGreen}Found${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
        echo
    fi

    # Check if rsync is installed on the Destination Server
    if ! ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$destination_server "command -v rsync >/dev/null 2>&1"; then
        echo -e "${BIYellow}Rsync${Color_Off} ${BIRed}Not Found${Color_Off} ${BICyan}On The Destination Server${Color_Off} \n${BIGreen}Installing${Color_Off} ${BIYellow}Rsync${Color_Off}"
        echo
        install_rsync
        if [ $? -eq 0 ]; then
                echo -e "${BIYellow}Rsync${Color_Off} ${BIGreen}Installed Successfully${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
                echo
        else
                echo -e "${BIBlue}Error :${Color_Off} ${BIRed}Failed To Install${Color_Off} ${BIYellow}Rsync${Color_Off} ${BIRed}On The Destination Server${Color_Off} \n${BICyan}File Transfer${Color_Off} ${BIRed}Aborted${Color_Off}"
                echo
                exit 1
        fi
    else
        echo -e "${BIYellow}Rsync${Color_Off} ${BIGreen}Found${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
        echo
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

                echo -e "${BIGreen}Current Server Main IP : ${Color_Off}\n${BIRed}$serverIP${Color_Off}"
                echo

                # Check if saved SSH access exists and load it
                if [ -f ~/.ssh_saved_access ]; then
                source ~/.ssh_saved_access
                fi

                # If saved SSH access is not found, prompt for new server details
                if [ -z "$destination_server" ]; then
                    # Prompt for new server details
                    while true; do
                        echo -e "${BIGreen}Enter New Server IP :${Color_Off}"
                        read new_server_ip
                        echo

                        if [[ -z "$new_server_ip" ]]; then
                            echo -e "${BIBlue}Warning : ${Color_Off}${BIRed}Destination Server IP Cannot Be Empty${Color_Off} \n${BICyan}Please Enter A Valid IP${Color_Off}"
                            echo
                        elif ! validate_ip "$new_server_ip"; then
                            echo -e "${BIBlue}Warning : ${Color_Off}${BIRed}Invalid IP Format${Color_Off} \n${BICyan}Please Enter A Valid IP${Color_Off}"
                            echo
                        else
                            break
                        fi
                    done

                    while true; do
                        echo -e "${BIGreen}Enter New Server SSH PORT ${BIYellow}[Press Enter For Default ${Color_Off}${BIRed}'64246'${Color_Off}${BIYellow}]${Color_Off} ${BIGreen}:${Color_Off}"
                        read new_server_port
                        echo

                        if [[ -z "$new_server_port" ]]; then
                            ssh_port="64246"  # Default SSH port
                            echo -e "${BIGreen}Using Default SSH PORT : ${Color_Off}${BIRed}$ssh_port${Color_Off}"
                            echo
                            break
                        elif ! validate_ssh_port "$new_server_port"; then
                            echo -e "${BIBlue}Warning : ${Color_Off}${BIRed}Invalid SSH PORT${Color_Off} \n${BICyan}Please Enter A Valid Port Number [1-65535]${Color_Off}"
                            echo
                        else
                            ssh_port="$new_server_port"
                            break
                        fi
                    done
                    while true; do
                        echo -e "${BIGreen}Enter New Server User ${BIYellow}[Press Enter For Default ${Color_Off}${BIRed}'root'${Color_Off}${BIYellow}]${Color_Off} ${BIGreen}:${Color_Off}"
                        read new_server_user
                        echo

                        if [[ -z "$new_server_user" ]]; then
                            ssh_user="root"  # Default SSH user
                            echo -e "${BIGreen}Using Default User : ${Color_Off}${BIRed}$ssh_user${Color_Off}"
                            echo
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
                    echo -e "${BIGreen}Using Saved SSH Sccess For Destination Server :${Color_Off} ${BIRed}$destination_server${Color_Off}"
                    echo
                fi

                echo -e "${BCyan}Put The Information Bellow For Transfer Data${Color_Off}"
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
                while [[ -z "$refNo" || ! "$refNo" =~ ^RSMS_[0-9]+$ ]]; do
                    echo
                    echo -e "${BGreen}Enter Reference NO. (${Color_Off}${BYellow}e.g., RSMS_66958${Color_Off}${BGreen}): ${Color_Off}"
                    read refNo

                    if [ -z "$refNo" ]; then
                            echo -e "${BRed}Reference NO. Cannot Be Empty. Please Enter A Valid Reference NO.${Color_Off} ${BYellow}(RSMS_XXXXX)${Color_Off}${BRed}.${Color_Off}"
                            echo
                    elif [[ ! "$refNo" =~ ^RSMS_[0-9]+$ ]]; then
                            echo
                            echo -e "${BRed}Invalid Reference NO. Please Enter A Valid Reference NO.${Color_Off}${BYellow}(RSMS_XXXXX)${Color_Off}${BRed}.${Color_Off}"
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
                echo -e "${BPurple}|----------------[${Color_Off} ${BCyan}New Folder Create For Store Data${Color_Off} ${BPurple}]---------------|${Color_Off}"
                echo
                # Create a new folder for the store data
                create_backup_folder
                echo -e "${BPurple}|-----------------------------[${Color_Off} ${BCyan}FINISH${Color_Off} ${BPurple}]----------------------------|${Color_Off}"
                echo
                #|-------------------------------------------------------------------------------------------------------------------------------------------|


                #|-------------------------------------------------------------------------------------------------------------------------------------------|
                echo -e "${BPurple}|---------------------[${Color_Off} ${BCyan}iTelSMS Database Dump${Color_Off} ${BPurple}]---------------------|${Color_Off}"
                echo
                # iTelSMS database dump
                dump_iTelSMS_DB
                echo -e "${BPurple}|-----------------------------[${Color_Off} ${BCyan}FINISH${Color_Off} ${BPurple}]----------------------------|${Color_Off}"
                echo
                #|-------------------------------------------------------------------------------------------------------------------------------------------|
               

                #|-------------------------------------------------------------------------------------------------------------------------------------------|
                echo -e "${BPurple}|------------------[${Color_Off} ${BCyan}iTelSMSFailed Database Dump${Color_Off} ${BPurple}]------------------|${Color_Off}"
                echo
                # iTelSMSFailed database dump
                dump_iTelSMSFailed_DB
                echo -e "${BPurple}|-----------------------------[${Color_Off} ${BCyan}FINISH${Color_Off} ${BPurple}]----------------------------|${Color_Off}"
                echo
                #|-------------------------------------------------------------------------------------------------------------------------------------------|
                

                #|-------------------------------------------------------------------------------------------------------------------------------------------|
                echo -e "${BPurple}|--------------------------[${Color_Off} ${BCyan}Moving File${Color_Off} ${BPurple}]--------------------------|${Color_Off}"
                echo
                echo -e "${BCyan}Moving [${Color_Off} ${BRed}$smsfailed_db_name.sql${Color_Off} ${BCyan}&${Color_Off} ${BRed}$smsiTel_db_name.sql${Color_Off} ${BCyan}] \nTo ${Color_Off}${BGreen}/usr/local/$folder_name${Color_Off}"
                echo
                mv /var/lib/mysql/$smsfailed_db_name.sql $smsiTel_db_name.sql /usr/local/$folder_name
                echo -e "${BPurple}|-----------------------------[${Color_Off} ${BCyan}FINISH${Color_Off} ${BPurple}]----------------------------|${Color_Off}"
                echo
                #|-------------------------------------------------------------------------------------------------------------------------------------------|


                #|-------------------------------------------------------------------------------------------------------------------------------------------|
                echo -e "${BPurple}|------------------[${Color_Off} ${BCyan}Mongo DB SMSCampaigns Dump${Color_Off} ${BPurple}]-------------------|${Color_Off}"
                echo
                # SMSCampaigns mongo database dump
                dump_SMSCampaigns_MONGO_DB
                echo -e "${BPurple}|-----------------------------[${Color_Off} ${BCyan}FINISH${Color_Off} ${BPurple}]----------------------------|${Color_Off}"
                echo
                #|-------------------------------------------------------------------------------------------------------------------------------------------|


                #|-------------------------------------------------------------------------------------------------------------------------------------------|
                echo -e "${BPurple}|-------------------[${Color_Off} ${BCyan}Mongo DB SMSContacts Dump${Color_Off} ${BPurple}]-------------------|${Color_Off}"
                echo
                # SMSContacts mongo database dump
                dump_SMSContacts_MONGO_DB
                echo -e "${BPurple}|-----------------------------[${Color_Off} ${BCyan}FINISH${Color_Off} ${BPurple}]----------------------------|${Color_Off}"
                echo
                #|-------------------------------------------------------------------------------------------------------------------------------------------|


                #|-------------------------------------------------------------------------------------------------------------------------------------------|
                echo -e "${BPurple}|-----------[${Color_Off} ${BCyan}Collecting WholeSaleSMS & iTelSMSAppServer${Color_Off} ${BPurple}]----------|${Color_Off}"
                echo
                # Collecting WholeSaleSMS & iTelSMSAppServer folders
                collect_WholeSaleSMSServer_iTelSMSAppServer "$smsFolder" "$smsAppFolder" "$folder_name"
                echo -e "${BPurple}|-----------------------------[${Color_Off} ${BCyan}FINISH${Color_Off} ${BPurple}]----------------------------|${Color_Off}"
                echo
                #|-------------------------------------------------------------------------------------------------------------------------------------------|


                #|-------------------------------------------------------------------------------------------------------------------------------------------|
                echo -e "${BPurple}|----------[${Color_Off} ${BCyan}Collecting Full Billing With Apache - Tomcat${Color_Off} ${BPurple}]---------|${Color_Off}"
                echo
                cd /usr/local/
                echo -e "${BCyan}Moving [${Color_Off}${BRed}Apache - Tomcat${Color_Off}${BCyan}] \nTo${Color_Off} ${BGreen}/usr/local/$folder_name${Color_Off}"
                echo
                cp -r "apache-tomcat-7.0.59" "/usr/local/$folder_name"
                echo -e "${BGreen}Apache - Tomcat Moved Successfully.${Color_Off}"
                echo
                echo -e "${BPurple}|-----------------------------[${Color_Off} ${BCyan}FINISH${Color_Off} ${BPurple}]----------------------------|${Color_Off}"
                echo
                #|-------------------------------------------------------------------------------------------------------------------------------------------|


                #|-------------------------------------------------------------------------------------------------------------------------------------------|
                echo -e "${BPurple}|--------------[${Color_Off} ${BCyan}Checking Some Other Necessery Files${Color_Off} ${BPurple}]--------------|${Color_Off}"
                echo
                if [ -d "/home/maahi/" ]; then
                    # Copy the directory to /usr/local/$folder_name
                    echo -e "${BCyan}Found${Color_Off} ${BRed}[/home/maahi/]${Color_Off} ${BCyan}On Current Server.${Color_Off}"
                    echo
                    cp -r /home/maahi/ /usr/local/$folder_name/
                    echo -e "${BCyan}Folder [maahi] Copied To [/usr/local/$folder_name/]${Color_Off}"
                    echo
                else
                    echo -e "${BRed}Folder [maahi] Does Not Exist On The server(${Color_Off}${BYellow}$serverIP${Color_Off}${BRed})${Color_Off}"
                    echo
                fi
                echo -e "${BPurple}|-----------------------------[${Color_Off} ${BCyan}FINISH${Color_Off} ${BPurple}]----------------------------|${Color_Off}"
                echo
                #|-------------------------------------------------------------------------------------------------------------------------------------------|


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


                #|-------------------------------------------------------------------------------------------------------------------------------------------|
                echo -e "${BPurple}|---------------[${Color_Off} ${BCyan}Dependency Check (Current Server)${Color_Off} ${BPurple}]---------------|${Color_Off}"
                echo
                # function for check dependencies in Destination Server
                check_dependency_current_server
                echo -e "${BPurple}|-----------------------------[${Color_Off} ${BCyan}FINISH${Color_Off} ${BPurple}]----------------------------|${Color_Off}"
                echo
                #|-------------------------------------------------------------------------------------------------------------------------------------------|

                #|-------------------------------------------------------------------------------------------------------------------------------------------|
                echo -e "${BPurple}|---------[${Color_Off} ${BCyan}Dependency Check (Destination Server Server)${Color_Off} ${BPurple}]----------|${Color_Off}"
                echo
                # function for check dependencies in Destination Server
                check_dependency_destination_server "$destination_server"
                echo -e "${BPurple}|-----------------------------[${Color_Off} ${BCyan}FINISH${Color_Off} ${BPurple}]----------------------------|${Color_Off}"
                echo
                #|-------------------------------------------------------------------------------------------------------------------------------------------|

                #|-------------------------------------------------------------------------------------------------------------------------------------------| 
                echo -e "${BPurple}|-------------------------[${Color_Off} ${BCyan}Transfer Data${Color_Off} ${BPurple}]-------------------------|${Color_Off}"
                echo

                #No Need Function
                ###no_need
                                    
                # Call the function to transfer the file using rsync
                fn_TransferFile_new_server

                #create database
                create_databases

                #run source files in the database
                run_source_files
                
                #restore mongod database
                restore_mongodb_databases

                # Call the ip_change function with user-provided values
                ip_change "$destination_server" "$folder_name" "$smsAppFolder" "$smsFolder"

                # Call the rename_destination_folders function with the Destination Server as an argument
                backup_destination_folders

                # Call the function to realocate the data
                realocate_data "$destination_server" "$folder_name" "$smsAppFolder" "$smsFolder"

                # Define the function for running softlink.sh and creating service files
                run_softlink

                # Call the start_services function in the destination server
                start_services

                # Call the stop_services function for current server
                stop_services_Current_server


                echo -e "${BPurple}|-----------------------------[${Color_Off} ${BCyan}FINISH${Color_Off} ${BPurple}]----------------------------|${Color_Off}"
                echo

                # Call the function to close the SSH control socket
                fn_CloseControlSocket

                # Call the function for what we send to the client
                client_reply

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