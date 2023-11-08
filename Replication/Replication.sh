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
echo -e "${BIRed}REPLICATION SCRIPT(1.0.1)${Color_Off}"
echo -e "${BIYellow}*-------------------------------------------------------------------*${Color_Off}"
echo -e "${BRed}TODAY                   : ${Color_Off}${BYellow}`date +"%d-%m-%Y"` ${Color_Off}"
echo -e "${BRed}LAST UPDATE             : ${Color_Off}${BYellow}XX-XX-202X ${Color_Off}"
echo -e "${BRed}PREVIOUS IMPLEMENTED    : ${Color_Off}${BYellow}UNDER PROCESS ${Color_Off}"
echo -e "${BRed}LAST IMPLEMENTED        : ${Color_Off}${BYellow}UNDER PROCESS${Color_Off}"
echo -e "${BIYellow}*-------------------------------------------------------------------*${Color_Off}"
echo -e "${BRed}IMPLEMENTED BY MD. SABBIR HOSSAIN BORNO ${Color_Off}"
echo -e "${BRed}SOFTWARE SUPPORT ENGINEER ${Color_Off}"
echo -e "${BRed}REVE SYSTEMS ${Color_Off}"
echo
}


# Call the function
devloper_INFO


#-----------------------------------------------------EXIT------------------------------------------------------------
# Function to establish an SSH connection
function fn_Connect() {
    conSuccssfl=""

    # Set up SSH control socket
    SSHSOCKET=~/.ssh_connection
    ssh -M -f -N -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$SlaveServerIP

    if [ $? -eq 0 ]; then
        conSuccssfl=1
        echo
        echo -e "${BIRed}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
        echo -e "${BIRed}|${Color_Off}   ${BICyan}Connection Establishment${Color_Off} ${BIGreen}Successful${Color_Off}   ${BIRed}|${Color_Off}"
        echo -e "${BIRed}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
        echo

        # Save the SSH access for future use
        echo "ssh_user=$ssh_user" > ~/.ssh_saved_access
        echo "ssh_port=$ssh_port" >> ~/.ssh_saved_access
        echo "SlaveServerIP=$SlaveServerIP" >> ~/.ssh_saved_access
        echo "SSHSOCKET=$SSHSOCKET" >> ~/.ssh_saved_access
    else
        echo
        echo -e "${BIGreen}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
        echo -e "${BIGreen}|${Color_Off}    ${BICyan}Connection Establishment${Color_Off} ${BIRed}Failed${Color_Off}     ${BIGreen}|${Color_Off}"
        echo -e "${BIGreen}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
        echo
        exit
    fi
}

# Function to check if rsync is installed on the Destination Server
function check_rsync_installed() {
    if ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$SlaveServerIP "command -v rsync >/dev/null 2>&1"; then
        echo -e "${BIYellow}Rsync${Color_Off} ${BIGreen}Found${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
        echo
        return 0
    else
        echo -e "${BIBlue}Error :${Color_Off} ${BIYellow}Rsync${Color_Off} ${BIRed}Not Found${Color_Off} ${BICyan}On The Destination Server${Color_Off} \n${BIGreen}Installing${Color_Off} ${BIYellow}Rsync${Color_Off}"
        echo
        ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$SlaveServerIP "yum install -y rsync"
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

# Function to close the SSH control socket
function fn_CloseControlSocket() {
    echo -e "${BPurple}|-----------------------[${Color_Off} ${BCyan}Connection Close${Color_Off} ${BPurple}]------------------------|${Color_Off}"
    echo
    if [ -n "$SSHSOCKET" ]; then
        echo -e "${BIBlue}SOCKET GOING CLOSE${Color_Off}"
        echo
        ssh -S $SSHSOCKET -O exit $ssh_user@$SlaveServerIP 2>/dev/null
        rm -f $SSHSOCKET  # Remove the control socket file
        rm -rf ~/.ssh_saved_access
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
    echo -e "${BPurple}|---------------------[${Color_Off} ${BCyan}Checking Dependencies${Color_Off} ${BPurple}]---------------------|${Color_Off}"
    echo

    # Check if rsync is installed on the Destination Server and install it if not
    check_rsync_install_rsync || return 1

    # Check MySQL version on the Destination Server
    check_mysql_version || return 1

    # Check if JDK is installed on the Destination Server
    check_jdk_installed || return 1

    # Check MySQL version on the Destination Server
    check_mongo_status || return 1


    echo -e "${BPurple}|--------------------[${Color_Off} ${BCyan}Checking Tomcat & Backup${Color_Off} ${BPurple}]-------------------|${Color_Off}"
    echo

    # Check if Tomcat is installed on the Destination Server and take a backup if found
    check_tomcat_installed && backup_tomcat || echo -e "${BICyan}Skipping${Color_Off} ${BIYellow}[Apache - Tomcat]${Color_Off} ${BICyan}Backup${Color_Off}"
    
    echo -e "${BPurple}|-------------------------[${Color_Off} ${BCyan}Transfer Data${Color_Off} ${BPurple}]-------------------------|${Color_Off}"
    echo
    echo -e "${BICyan}Transfering Data From Current Server To Destination Server${Color_Off}"
    # Run rsync in the background with progress and stats
    rsync -ah --info=progress2 -e "ssh -p $ssh_port -o ControlPath=$SSHSOCKET" "$source_file" "$ssh_user@$SlaveServerIP:$destination_folder_location" 2>/dev/null &
    rsync_pid=$!
    echo

    # Wait for the rsync process to complete
    wait $rsync_pid

    # Check if the rsync process exited successfully
    if [ $? -eq 0 ]; then
        # Calculate the size of the transferred directory on the Destination Server
        transferred_size=$(ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$SlaveServerIP "du -sh '$destination_folder_location/$folder_name'" 2>/dev/null | awk '{print $1}')
        if [ -n "$transferred_size" ]; then
            echo
            echo -e "${BICyan}Transfer${Color_Off} ${BIGreen}Completed Successfully${Color_Off}"
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

# Function to run source files for the databases on the Destination Server
function run_source_files() {
    echo -e "${BPurple}|--------------------------[${Color_Off} ${BCyan}Source Running${Color_Off} ${BPurple}]-----------------------|${Color_Off}"
    echo
    # Check if MySQL version 8 is installed on the Destination Server
    #check_mysql_version || return 1

    # Define the paths to the source SQL files on the Destination Server
    smsiTel_db_sql="/usr/local/$folder_name/$smsiTel_db_name.sql"
    smsfailed_db_sql="/usr/local/$folder_name/$smsfailed_db_name.sql"

    # Check if the source SQL files exist on the Destination Server
    if ! ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$SlaveServerIP "[ -f $smsiTel_db_sql ] && [ -f $smsfailed_db_sql ]"; then
        echo -e "${BIBlue}Error :${Color_Off} ${BIRed}Source${Color_Off} ${BIYellow}SQL File(s)${Color_Off} ${BIRed}Not Found${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
        echo
        return 1
    fi

    # Run the source files to create the databases on the Destination Server
    echo -e "${BIGreen}Running${Color_Off} ${BICyan}The Source${Color_Off} ${BIYellow}SQL File(s)${Color_Off} ${BICyan}On The Destination Server${Color_Off}${BIRed}[$smsiTel_db_name]${Color_Off}"
    echo
    ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$SlaveServerIP "mysql -u root $smsiTel_db_name < $smsiTel_db_sql"
    if [ $? -eq 0 ]; then
        echo -e "${BICyan}Source${Color_Off} ${BIYellow}SQL File(s)${Color_Off} ${BIGreen}Executed Successfully${Color_Off} ${BICyan}For${Color_Off} ${BIRed}[$smsiTel_db_name]${Color_Off}"
        echo
    else
        echo -e "${BIBlue}Error :${Color_Off} ${BIRed}Failed To Execute${Color_Off} ${BICyan}Source${Color_Off} ${BIYellow}SQL File(s)${Color_Off} ${BICyan}For${Color_Off} ${BIRed}[$smsiTel_db_name]${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
        echo
        return 1
    fi

    echo -e "${BIGreen}Running${Color_Off} ${BICyan}The Source${Color_Off} ${BIYellow}SQL File(s)${Color_Off} ${BICyan}On The Destination Server${Color_Off}${BIRed}[$smsfailed_db_name]${Color_Off}"
    echo
    ssh -o ControlPath=$SSHSOCKET -p $ssh_port $ssh_user@$SlaveServerIP "mysql -u root $smsfailed_db_name < $smsfailed_db_sql"
    if [ $? -eq 0 ]; then
        echo -e "${BICyan}Source${Color_Off} ${BIYellow}SQL File(s)${Color_Off} ${BIGreen}Executed Successfully${Color_Off} ${BICyan}For${Color_Off} ${BIRed}[$smsfailed_db_name]${Color_Off}"
        echo
    else
        echo -e "${BIBlue}Error :${Color_Off} ${BIRed}Failed To Execute${Color_Off} ${BICyan}Source${Color_Off} ${BIYellow}SQL File(s)${Color_Off} ${BICyan}For${Color_Off} ${BIRed}[$smsfailed_db_name]${Color_Off} ${BICyan}On The Destination Server${Color_Off}"
        echo
        return 1
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


MasterServerIP=$(ip route get 8.8.8.8 | sed -n '/src/{s/.*src *\([^ ]*\).*/\1/p;q}')
#echo "$serverIP"
list_itelSwitch=$(cd /usr/local/ && ls | grep -e iTelSwitchPlus | sed 's/iTelSwitchPlus//; s/MediaProxy//; s/Signaling//' | sort | uniq | sed 's/^/-> /')
#echo "$list_itelSwitch"


    timeout_duration=60  # Timeout in seconds

    while true; do
    echo
    echo -e "${BPurple} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
    echo -e "${BPurple}|${Color_Off}${BGreen}               REPLICATION             ${Color_Off}${BPurple}|${Color_Off}"
    echo -e "${BPurple} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
    echo -e "${BPurple}|${Color_Off}                                          ${BPurple}|${Color_Off}"
    echo -e "  ${BCyan}1. Replication Repair${Color_Off}"
    echo -e "${BPurple}|${Color_Off}                                          ${BPurple}|${Color_Off}"
    echo -e "  ${BCyan}2. Replication Creation${Color_Off}"
    echo -e "${BPurple}|${Color_Off}                                          ${BPurple}|${Color_Off}"
    echo -e "${BPurple} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
    echo -e "${BPurple}|${Color_Off}${BGreen}           Press [e] For Exit          ${Color_Off}${BPurple}|${Color_Off}"
    echo -e "${BPurple} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
    echo
    echo -e "${BCyan}Where You Want To Do?${Color_Off}"
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
        #-----------------------------------------------------ReplicationRepair------------------------------------------------------------
        echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
        echo -e "${BCyan}Replication --> ${Color_Off}${BRed}[ REPAIR ]${Color_Off}"
        echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
        echo

        echo -e "${BIGreen}Master Server Main IP : ${Color_Off}\n${BIRed}$MasterServerIP${Color_Off}"
        echo

        # Check if saved SSH access exists and load it
        if [ -f ~/.ssh_saved_access ]; then
        source ~/.ssh_saved_access
        fi

        # If saved SSH access is not found, prompt for new server details
        if [ -z "$SlaveServerIP" ]; then
            # Prompt for new server details
            while true; do
                echo -e "${BIGreen}Enter Slave Server IP :${Color_Off}"
                read new_server_ip
                echo

                if [[ -z "$new_server_ip" ]]; then
                    echo -e "${BIBlue}Warning : ${Color_Off}${BIRed}Slave Server IP Cannot Be Empty${Color_Off} \n${BICyan}Please Enter A Valid IP${Color_Off}"
                    echo
                elif ! validate_ip "$new_server_ip"; then
                    echo -e "${BIBlue}Warning : ${Color_Off}${BIRed}Invalid IP Format${Color_Off} \n${BICyan}Please Enter A Valid IP${Color_Off}"
                    echo
                else
                    break
                fi
            done

            while true; do
                echo -e "${BIGreen}Enter Slave Server SSH PORT ${BIYellow}[Press Enter For Default ${Color_Off}${BIRed}'64246'${Color_Off}${BIYellow}]${Color_Off} ${BIGreen}:${Color_Off}"
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
                echo -e "${BIGreen}Enter Server Server User ${BIYellow}[Press Enter For Default ${Color_Off}${BIRed}'root'${Color_Off}${BIYellow}]${Color_Off} ${BIGreen}:${Color_Off}"
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
            SlaveServerIP="${new_server_ip}"
            ssh_port="${new_server_port:-64246}"
            ssh_user="${new_server_user:-root}"

            # Call the function to establish the connection
            fn_Connect
        else
            echo -e "${BIGreen}Using Saved SSH Sccess For Slave Server :${Color_Off} ${BIRed}$SlaveServerIP${Color_Off}"
            echo
        fi

        itelSwitch=""
        while [[ -z "$itelSwitch" ]]; do
            echo -e "${BYellow}List Of [ iTelSwitch ] :${Color_Off}"
            echo "$list_itelSwitch"
            echo
            echo -e "${BGreen}Enter [ iTelSwitch ] Name : ${Color_Off}"
            read sname

        if [ -z "$itelSwitch" ]; then
                echo -e "${BRed}iTelSwitch Name Cannot Be Empty. Please Enter A Valid iTelSwitch Name.${Color_Off}"
                echo
        elif [ ! -d "/usr/local/iTelSwitchPlusSignaling$sname" ]; then
                echo
                echo -e "${BRed}iTelSwitch${Color_Off} ${BYellow}(/usr/local/iTelSwitchPlusSignaling$sname)${Color_Off} ${BRed}Does Not Exist. Please Enter A Valid iTelSwitch Name.${Color_Off}"
                echo
                itelSwitch=""
        fi
        done

iTelFailedDB=$(grep -o 'jdbc:mysql:///[^?"]*' "/usr/local/iTelSwitchPlusSignaling$sname/DatabaseConnection_Failed.xml" | sed -e 's/.*\/\/\([^?]*\)/\1/')
#echo "$iTelFailedDB"

iTelBillingDB=$(grep -o 'jdbc:mysql:///[^?"]*' "/usr/local/iTelSwitchPlusSignaling$sname/DatabaseConnection.xml" | sed -e 's/.*\/\/\([^?]*\)/\1/')
#echo "$iTelBillingDB"

iTelSuccessfulDB=$(grep -o 'jdbc:mysql:///[^?"]*' "/usr/local/iTelSwitchPlusSignaling$sname/DatabaseConnection_Successful.xml" | sed -e 's/.*\/\/\([^?]*\)/\1/')
#echo "$iTelSuccessfulDB"



echo
echo -e "${BCyan}|-------------------------------------------------------------------|${Color_Off}"
echo -e "${BCyan}|${Color_Off}                       ${BRed}Details For Replication${Color_Off}                     ${BCyan}|${Color_Off}"
echo -e "${BCyan}|-------------------------------------------------------------------|${Color_Off}"
echo -e "${BYellow}  Master Server IP                :${Color_Off}      ${BRed}$MasterServerIP${Color_Off}"
echo -e "${BCyan}|-------------------------------------------------------------------|${Color_Off}"
echo -e "${BYellow}  Slave Server IP                 :${Color_Off}      ${BRed}$SlaveServerIP${Color_Off}"
echo -e "${BCyan}|-------------------------------------------------------------------|${Color_Off}"
echo -e "${BYellow}  Slave Server SSH PORT           :${Color_Off}      ${BRed}$ssh_port${Color_Off}"
echo -e "${BCyan}|-------------------------------------------------------------------|${Color_Off}"
echo -e "${BYellow}  Slave Server USER               :${Color_Off}      ${BRed}$ssh_user${Color_Off}"
echo -e "${BCyan}|-------------------------------------------------------------------|${Color_Off}"
echo -e "${BYellow}  Reference NO                    :${Color_Off}      ${BRed}$refNo${Color_Off}"
echo -e "${BCyan}|-------------------------------------------------------------------|${Color_Off}"
echo -e "${BYellow}  iTelBilling Database            :${Color_Off}      ${BRed}$iTelBillingDB${Color_Off}"
echo -e "${BCyan}|-------------------------------------------------------------------|${Color_Off}"
echo -e "${BYellow}  iTelSuccessful Database         :${Color_Off}      ${BRed}$iTelSuccessfulDB${Color_Off}"
echo -e "${BCyan}|-------------------------------------------------------------------|${Color_Off}"
echo -e "${BYellow}  iTelFailed Database             :${Color_Off}      ${BRed}$iTelFailedDB${Color_Off}"
echo -e "${BCyan}|-------------------------------------------------------------------|${Color_Off}"
echo




cd /var/lib/mysql && ls

rm -rf Faileditelbilling.zip iTelBillingitelbilling.zip Successfulitelbilling.zip && ls

cd Successfulitelbilling && ls

rm -rf *.gz

mysql
reset master;
flush tables with read lock;
reset master;

need to stay the mysql lock and doing this in the mysql lock state

cd /var/lib/mysql/ && ls
mysqldump iTelBillingitelbilling > iTelBillingitelbilling.sql
mysqldump Successfulitelbilling vbResellerCDR_652 vbSuccessfulCDR_652 vbSuccessfulSummaryCDR_652 > Successfulitelbilling_652.sql

When dump done

unlock tables;
grant all privileges on *.* to 'replicationTrain'@'%' identified by 'r3pl!caT!on'; 
flush privileges;
exit

Transfer sql files to replicationTrain server: 

cd /var/lib/mysql
zip -r iTelBillingitelbilling.sql.zip iTelBillingitelbilling.sql
zip -r Successfulitelbilling_652.sql.zip Successfulitelbilling_652.sql
rm -rf /usr/local/jakarta-tomcat-7.0.61/webapps/ROOT/*.zip
mv iTelBillingitelbilling.sql.zip Successfulitelbilling_652.sql.zip /usr/local/jakarta-tomcat-7.0.61/webapps/ROOT/
cd /usr/local/jakarta-tomcat-7.0.61/webapps/ROOT/ && ls

rsync -ah --info=progress2 -e "ssh -p $ssh_port -o ControlPath=$SSHSOCKET" "$source_file" "$ssh_user@$SlaveServerIP:$destination_folder_location" 2>/dev/null &

In Slave server:

cd /usr/local/mysql_REF_1538512_welcome/var
rm -rf /usr/local/mysql_REF_1538512_welcome/*.zip *.sql *.gz
rm -rf /usr/local/mysql_REF_1538512_welcome/var/*.zip *.sql *.gz
wget 185.106.243.160:80/iTelBillingitelbilling.sql.zip
wget 185.106.243.160:80/Successfulitelbilling_652.sql.zip


unzip iTelBillingitelbilling.sql.zip
unzip Successfulitelbilling_652.sql.zip

Step 1:
Go to replication folder
now login to replicationTrain mysql

From Mysql:

cd ../
bin/mysql
use iTelBillingitelbilling;
source /usr/local/mysql_REF_1538512_welcome/var/iTelBillingitelbilling.sql;

use Successfulitelbilling;
source /usr/local/mysql_REF_1538512_welcome/var/Successfulitelbilling_652.sql;


Step 3:


stop slave;
reset slave;
change master to MASTER_HOST='185.106.243.160',MASTER_USER='replicationTrain', MASTER_PASSWORD='r3pl!caT!on', MASTER_PORT=3306;

start slave;
SELECT SLEEP(5);
show slave status\G;

rm -rf /usr/local/mysql_REF_1538512_welcome/var/*.sql *.zip

rm -rf /usr/local/jakarta-tomcat-7.0.61/webapps/ROOT/*.zip
rm -rf /var/lib/mysql/*.sql

==========Restart The Checker Once================
cd /usr/local/ReplicationChecker_mysql_REF_1538512_welcome

sh shutdownReplicationChecker.sh
sh shutdownReplicationChecker.sh
sh shutdownReplicationChecker.sh


sh runReplicationChecker.sh

                # Call the function to close the SSH control socket
                fn_CloseControlSocket

                echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
                echo -e "${BRed}                                [ END ]                               ${Color_Off}"
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