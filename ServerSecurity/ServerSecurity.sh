#!/bin/bash

# Constants
LOG_FILE="/ServerSecurity.log"
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

# Get the directory of the script
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Full path to the main script
main_script="$script_dir/ServerSecurity.sh"

# Function to log messages
log_message() {
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] $1" >> "$LOG_FILE"
}


# Password Generator
generate_password() {
    local length=$((10 + RANDOM % 12))
    local chars=("0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z" "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" "?" "/" "}" "{" "]" "[" "+" "-" "=" "!" "@" "#" "$" "%" "^" "&")
    local max=${#chars[@]}
    local password=""
    for ((i = 1; i <= length; i++)); do
        local rand=$((RANDOM % max))
        password="${password}${chars[$rand]}"
    done
    echo "$password"
}




# Function to perform IP restriction
configure_ip_restriction() {

log_message "Configuring IP Restriction."

        officeIP1="127.0.0.1"
        officeIP2="182.75.128.74"
        officeIP3="203.122.7.10"
        officeIP4="202.4.122.50"
        officeIP5="103.169.159.35"
        officeIP6="119.148.4.18"
        officeIP7="119.148.4.19"

        serverIP=`ip route get 8.8.8.8 | sed -n '/src/{s/.*src *\([^ ]*\).*/\1/p;q}'`

        echo
        echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
        echo -e "${BCyan}Server Security Service--${Color_Off}${BRed}(IP Restiction)${Color_Off}"
        echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
        echo

        echo -e "${BICyan}Server Main IP = ${Color_Off}${BIRed}$serverIP${Color_Off}"
        log_message "Server Main IP = $serverIP"
        echo -e "${BICyan}Office IP1     = ${Color_Off}${BIRed}$officeIP1${Color_Off}"
        log_message "Office IP1 = $officeIP1"
        echo -e "${BICyan}Office IP2     = ${Color_Off}${BIRed}$officeIP2${Color_Off}"
        log_message "Office IP2 = $officeIP2"
        echo -e "${BICyan}Office IP3     = ${Color_Off}${BIRed}$officeIP3${Color_Off}"
        log_message "Office IP3 = $officeIP3"
        echo -e "${BICyan}Office IP4     = ${Color_Off}${BIRed}$officeIP4${Color_Off}"
        log_message "Office IP4 = $officeIP4"
        echo -e "${BICyan}Office IP5     = ${Color_Off}${BIRed}$officeIP5${Color_Off}"
        log_message "Office IP5 = $officeIP5"
        echo -e "${BICyan}Office IP6     = ${Color_Off}${BIRed}$officeIP6${Color_Off}"
        log_message "Office IP6 = $officeIP6"
        echo -e "${BICyan}Office IP7     = ${Color_Off}${BIRed}$officeIP7${Color_Off}"
        log_message "Office IP7 = $officeIP7"
        echo

        > /etc/hosts.allow
        > /etc/hosts.deny
        echo -e "${BIRed}Truncated${Color_Off} ${BIGreen}[ hosts.allow & hosts.deny ] Files${Color_Off}"
        log_message "Truncated (hosts.allow & hosts.deny)"
        echo
        echo -e "${BIGreen}Allowing IP [ hosts.allow ]${Color_Off}"

        echo "ALL: $serverIP" >/etc/hosts.allow
        log_message "Allowed $serverIP"
        echo "ALL: $officeIP1" >>/etc/hosts.allow
        log_message "Allowed $officeIP1"
        echo "ALL: $officeIP2" >>/etc/hosts.allow
        log_message "Allowed $officeIP2"
        echo "ALL: $officeIP3" >>/etc/hosts.allow
        log_message "Allowed $officeIP3"
        echo "ALL: $officeIP4" >>/etc/hosts.allow
        log_message "Allowed $officeIP4"
        echo "ALL: $officeIP5" >>/etc/hosts.allow
        log_message "Allowed $officeIP5"
        echo "ALL: $officeIP6" >>/etc/hosts.allow
        log_message "Allowed $officeIP6"
        echo "ALL: $officeIP7" >>/etc/hosts.allow
        log_message "Allowed $officeIP7"
        echo

        cat /etc/hosts.allow
        echo

        echo -e "${BIRed}Denying All Others IP [ hosts.deny ]${Color_Off}"
        log_message "Denying all others IP and set ALL:ALL in (hosts.deny)"

        echo "ALL:ALL">/etc/hosts.deny

        cat /etc/hosts.deny
        echo

}

# Function to change server password
change_server_password() {
    echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
    echo -e "${BCyan}Server Security Service--${Color_Off}${BRed}(Password Change)${Color_Off}"
    echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
    echo
    echo -e "${BYellow}Do You Want To Change Server Password?${Color_Off} ${BGreen}[${Color_Off}${BRed}y${Color_Off}${BYellow}/${Color_Off}${BRed}n${Color_Off}${BGreen}]${Color_Off}${BYellow}:${Color_Off}"
    read -r choice
    echo
    if [[ $choice == y ]]; then
        echo -e "${BRed}BE CAREFUL !!!!"
        echo -e "${BRed} 1. At least 12 characters long but 14 or more is better.${Color_Off}"
        echo -e "${BRed} 2. A combination of uppercase letters, lowercase letters, numbers, and symbols.${Color_Off}"
        echo -e "${BRed} 3. Not a word that can be found in a dictionary or the name of a person, character, product, or organization.${Color_Off}"
        echo -e "${BRed} 4. Significantly different from your previous passwords.${Color_Off}"
        echo -e "${BRed} 5. Easy for you to remember but difficult for others to guess. Consider using a memorable phrase like (${Color_Off}${BGreen}$password${Color_Off}${BRed}).${Color_Off}"
        echo
        echo -n "Enter "
        new_password=$(passwd)
        echo

        # Log the new password
        log_message "Password Changed"
        log_message "New Password: $new_password"
        echo -e "${BGreen}Password Changed${Color_Off}"
        echo
    else
        echo -e "${BPurple}Password Remains Unchanged${Color_Off}"
        echo
    fi
}

# Function to change SSH port
change_ssh_port() {
    echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
    echo -e "${BCyan}Server Security Service--${Color_Off}${BRed}(SSH PORT Change)${Color_Off}"
    echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
    echo

    local current_port=$(awk '/^[Pp]ort/ && !/^#/ {print $2}' /etc/ssh/sshd_config)

    echo -e "${BYellow}Do You Want To Change Server SSH Port?${Color_Off} ${BGreen}[${Color_Off}${BRed}y${Color_Off}${BYellow}/${Color_Off}${BRed}n${Color_Off}${BGreen}]${Color_Off}${BYellow}:${Color_Off}"
    read -r choice
    echo
    if [[ $choice == y ]]; then
        echo -e "${BRed}BE CAREFUL !!!!"
        echo -e "${BYellow}The SSH Port Must Be ${Color_Off}${BRed}64246${Color_Off}${BYellow}.${Color_Off}"
        echo

        echo -e "${BGreen}The Current SSH Port Is: ${Color_Off}${BRed}$current_port${Color_Off}"
        echo
        echo -e "${BGreen}Enter The New SSH Port: ${Color_Off}"
        read -r new_port
        echo

        backup_file="/etc/ssh/sshd_config_$(date +"%Y%m%d_%H%M%S")"

        cp /etc/ssh/sshd_config $backup_file
        log_message "Backuped sshd_config file to $backup_file"

        sed -i "s/^#\?Port .*/Port $new_port/" /etc/ssh/sshd_config
        service sshd restart
        sleep 2
        new_ssh_port=$(awk '/^[Pp]ort/ && !/^#/ {print $2}' /etc/ssh/sshd_config)
        echo
        echo -e "${BGreen}The New SSH Port Is: ${Color_Off}${BRed}$new_ssh_port${Color_Off}"
        echo

        # Log the new SSH port
        log_message "Changed SSH Port from $current_port to $new_ssh_port"
    else
        echo -e "${BPurple}SSH Port Remains Unchanged.${Color_Off}"
        echo
    fi
}

# Main Script

# Initialize log file
> "$LOG_FILE"

log_message "Starting The Script For Server Security"

# Password Generation
password=$(generate_password)
log_message "Generated Password: $password"

# IP Restriction
configure_ip_restriction

# Change Server Password
change_server_password

# Change SSH Port
change_ssh_port

echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
echo -e "${BGreen}                  Server Security Modified                 ${Color_Off}"
echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
echo
echo
echo -e "${BIYellow}*-*-*-*-*-*-*-*-*[ Current Login Session ]*-*-*-*-*-*-*-*-*${Color_Off}"
echo
w
echo
echo -e "${BIYellow}*-*-*-*-*-*-*-*[ Checking Additional Users ]*-*-*-*-*-*-*-*${Color_Off}"
echo
getent passwd {1000..60000}
echo
echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
echo -e "${BBlue}                            FINISH                         ${Color_Off}"
echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"

#----------------------------END----------------------------|

log_message "Ending The Script For Server Security"
log_message "Deleted Server Security Script File From Server"
rm -- "$main_script"
