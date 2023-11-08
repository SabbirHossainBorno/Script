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



#---------------------PASSWORD GENARATOR--------------------|

length=$[ 10 +$[RANDOM % 12]]

char=(0 1 2 3 4 5 6 7 8 9 a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z ? /} /{ /] /[ + - = ! @ \# $ % ^ \&)

max=${#char[*]}
for ((i = 1; i <= $length ; i++))
do

let rand=${RANDOM}%${max}

password="${password}${char[$rand]}"
done


#----------------------------END----------------------------|


#----------------------IP RESTRICTION-----------------------|


officeIP1="127.0.0.1"
officeIP2="182.75.128.74"
officeIP3="203.122.7.10"
officeIP4="103.169.159.34"
officeIP5="103.169.159.35"
officeIP6="119.148.4.18"
officeIP7="119.148.4.19"

serverIP=`ip route get 8.8.8.8 | sed -n '/src/{s/.*src *\([^ ]*\).*/\1/p;q}'`

echo -e "${BIYellow}-------------------Server Security------------------${Color_Off}"
echo

echo "Server Main IP = $serverIP"
echo "Office IP1     = $officeIP1"
echo "Office IP2     = $officeIP2"
echo "Office IP3     = $officeIP3"
echo "Office IP4     = $officeIP4"
echo "Office IP5     = $officeIP5"
echo "Office IP6     = $officeIP6"
echo "Office IP7     = $officeIP7"
echo

> /etc/hosts.allow
> /etc/hosts.deny
echo "Truncate (hosts.allow & hosts.deny)"
echo
echo "Allowing IP"


echo "ALL: $serverIP" >/etc/hosts.allow
echo "ALL: $officeIP1" >>/etc/hosts.allow
echo "ALL: $officeIP2" >>/etc/hosts.allow
echo "ALL: $officeIP3" >>/etc/hosts.allow
echo "ALL: $officeIP4" >>/etc/hosts.allow
echo "ALL: $officeIP5" >>/etc/hosts.allow
echo "ALL: $officeIP6" >>/etc/hosts.allow
echo "ALL: $officeIP7" >>/etc/hosts.allow
echo

cat /etc/hosts.allow

echo "Denying All Others IP"
echo

echo "ALL:ALL">/etc/hosts.deny

cat /etc/hosts.deny

#----------------------------END----------------------------|

#----------------------PASSWORD CHANGE----------------------|

echo

echo "Do You Want To Change Server Password? [y/n] : "
echo
        read choice;
        echo
        if [ $choice == y ]
        then
           echo -e "${BIRed}BE CAREFULL !!!!${Color_Off}"
           echo
           
           echo -e "${BIRed} 1.At least 12 characters long but 14 or more is better.${Color_Off}"

           echo -e "${BIRed} 2.A combination of uppercase letters, lowercase letters, numbers, and symbols.${Color_Off}"

           echo -e "${BIRed} 3.Not a word that can be found in a dictionary or the name of a person, character, product, or organization.${Color_Off}"

           echo -e "${BIRed} 4.Significantly different from your previous passwords.${Color_Off}"

           echo -e "${BIRed} 5.Easy for you to remember but difficult for others to guess. Consider using a memorable phrase like (${Color_Off}${BIGreen}$password${Color_Off}${BIRed}).${Color_Off}"
           echo
           echo "Enter New Password: "
           passwd;
           echo
        else
         echo "Password Remain Unchanged"
        fi


echo -e "${BIYellow}-------------------Security Changed-----------------${Color_Off}"
echo
echo -e "${BIYellow}----------------Current Login Session---------------${Color_Off}"
echo
w
echo
echo -e "${BIYellow}---------------Checking Additional User-------------${Color_Off}"
echo
getent passwd {1000..60000}
echo
echo -e "${BIYellow}-------------------------DONE-----------------------${Color_Off}"

#----------------------------END----------------------------|


#ip -4 addr | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v "^127.\|^10\.\|^192.168.\|^172\.1[6789].\|^172\.2[0-9].\|^172\.3[01]"
