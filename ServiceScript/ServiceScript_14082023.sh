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
echo
echo -e "${BIRed}SERVICE SCRIPT(2.6.1)${Color_Off}"
echo -e "${BIYellow}*-----------------------------------------------------------------------*${Color_Off}"
echo -e "${BRed}TODAY                : ${Color_Off}${BYellow}`date +"%d-%m-%Y"` ${Color_Off}"
echo -e "${BRed}LAST UPDATE          : ${Color_Off}${BYellow}09-08-2023 ${Color_Off}"
echo -e "${BRed}PREVIOUS IMPLEMENTED : ${Color_Off}${BYellow}SBC All Service Restart + SMS V4 ${Color_Off}"
echo -e "${BRed}LAST IMPLEMENTED     : ${Color_Off}${BYellow}All Services(Restart) + Installer Updater Added${Color_Off}"
echo -e "${BIYellow}*-----------------------------------------------------------------------*${Color_Off}"
echo -e "${BRed}IMPLEMENTED BY MD. SABBIR HOSSAIN BORNO ${Color_Off}"
echo -e "${BRed}SOFTWARE SUPPORT ENGINEER ${Color_Off}"
echo -e "${BRed}REVE SYSTEMS ${Color_Off}"



echo
echo
echo -e "${BCyan}*************************************************************${Color_Off}${BYellow}[ DETAILS---USR->LOCAL ]${Color_Off}${BCyan}*******************************************************************${Color_Off}"
echo
cd /usr/local/
ls
echo 
echo -e "${BCyan}***********************************************************************${Color_Off}${BYellow}[ END ]${Color_Off}${BCyan}**************************************************************************${Color_Off}"

script_timeout_duration=60



while true; do
echo
echo -e "*${BCyan}-------------------------${Color_Off}${URed}RESTART${Color_Off}${BCyan}--------------------------${Color_Off}*"
echo -e "*${BIPurple}Which Service Do You Want To Restart???${Color_Off}                   *"
echo -e "*${BBlue}[1]${Color_Off}--------${BGreen}ByteSaver${Color_Off}                                      *"
echo -e "*${BBlue}[BS]${Color_Off}${White}----------${Color_Off}${BGreen}Singnal${Color_Off}                                     *"
echo -e "*${BBlue}[BM]${Color_Off}${White}----------${Color_Off}${BGreen}Media${Color_Off}                                       *"
echo -e "*${BBlue}[2]${Color_Off}--------${BGreen}Switch${Color_Off}                                         *"
echo -e "*${BBlue}[SS]${Color_Off}${White}----------${Color_Off}${BGreen}Singnal${Color_Off}                                     *"
echo -e "*${BBlue}[SM]${Color_Off}${White}----------${Color_Off}${BGreen}Media${Color_Off}                                       *"
echo -e "*${BBlue}[3]${Color_Off}--------${BGreen}Jakarta Tomcat${Color_Off}                                 *"
echo -e "*${BBlue}[4]${Color_Off}--------${BGreen}Apache Tomcat${Color_Off}                                  *"
echo -e "*${BBlue}[5]${Color_Off}--------${BGreen}ALL SERVICES${Color_Off}                                   *"
echo -e "*${BBlue}[SBC]${Color_Off}------${BGreen}SBC All Services Restart${Color_Off}                       *"
echo -e "*${BBlue}[HR]${Color_Off}-------${BGreen}Hard Restart${Color_Off}                                   *"
echo -e "*${BCyan}-------------------------${Color_Off}${URed}CHECK${Color_Off}${BCyan}----------------------------${Color_Off}*"
echo -e "*${BIPurple}What You Wnat To Check???${Color_Off}                                 *"
echo -e "*${BBlue}[6]${Color_Off}--------${BGreen}Memory check${Color_Off}                                   *"
echo -e "*${BBlue}[7]${Color_Off}--------${BGreen}HDD Check${Color_Off}                                      *"
echo -e "*${BBlue}[8]${Color_Off}--------${BGreen}CPU Usage Check${Color_Off}                                *"
echo -e "*${BBlue}[9]${Color_Off}--------${BGreen}Running Call Check${Color_Off}                             *"
echo -e "*${BBlue}[10]${Color_Off}-------${BGreen}Running Proccess${Color_Off}                               *"
echo -e "*${BBlue}[11]${Color_Off}-------${BGreen}Memory Free${Color_Off}                                    *"
echo -e "*${BBlue}[12]${Color_Off}-------${BGreen}HDD Space Reduce${Color_Off}                               *"
echo -e "*${BBlue}[13]${Color_Off}-------${BGreen}Billing Password Change${Color_Off}                        *"
echo -e "*${BBlue}[14]${Color_Off}-------${BGreen}Max Call Limite Change${Color_Off}                         *"
echo -e "*${BBlue}[15]${Color_Off}-------${BGreen}Pin Expire Time${Color_Off}                                *"
echo -e "*${BCyan}------------------------${Color_Off}${URed}Installer${Color_Off}${BCyan}-------------------------${Color_Off}*"
echo -e "*${BBlue}[I]${Color_Off}-------${BGreen}All Installer${Color_Off}                                   *"
echo -e "*${BCyan}-------------------------${Color_Off}${BRed}******${Color_Off}${BCyan}---------------------------${Color_Off}*"
echo -e "${BCyan}--------------------${Color_Off}${BIPurple}PRESS [e] FOR EXIT${Color_Off}${BCyan}----------------------${Color_Off}"
echo 
echo -e "${BCyan}---------------${Color_Off}${BIPurple}PRESS [SH] FOR SERVER HEALTH${Color_Off}${BCyan}-----------------${Color_Off}"
echo
echo -e "${BCyan}PRESS & ENTER PLEASE:${Color_Off} " 
echo
read -t $script_timeout_duration option || true

if [[ -z "$option" ]]; then

echo
echo -e "${On_IRed}Timeout Reached. Script Is Exiting...${Color_Off}"
echo
        break
    fi

echo

case $option in
    #-----------------------------------------------------------------------------------------------------------------
    1)
    echo -e "${BCyan}Restarting Service--(ByteSaver)${Color_Off}"
    echo
    echo -e "${BGreen}Enter Your Oparator Code: ${Color_Off}"
    read opcode
    echo
    echo -e "${BPurple}ByteSaverSignalingConverter Shuting Down:${Color_Off}"
    echo
    sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh
    sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh
    sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh
    echo

    sleep 5

    sh /usr/local/ByteSaverSignalConverter$opcode/runByteSaverSignalConverter.sh
    echo

    sleep 5

    echo -e "${BPurple}ByteSaverMediaProxy Shuting Down:${Color_Off}"
    echo
    sh /usr/local/ByteSaverMediaProxy$opcode/shutdownByteSaverMediaProxy.sh
    sh /usr/local/ByteSaverMediaProxy$opcode/shutdownByteSaverMediaProxy.sh
    sh /usr/local/ByteSaverMediaProxy$opcode/shutdownByteSaverMediaProxy.sh
    echo

    sleep 2

    sh /usr/local/ByteSaverMediaProxy$opcode/runByteSaverMediaProxy.sh
    echo

    sleep 8

    ps -aux |grep ByteSaver
    ;;
    #-----------------------------------------------------------------------------------------------------------------
    BS)
    echo -e "${BCyan}Restarting Service--(ByteSaverSignalConverter)${Color_Off}"
    echo
    echo -e "${BGreen}Enter Your Oparator Code: ${Color_Off}"
    read opcode
    
    echo
    echo -e "${BPurple}ByteSaverSignalingConverter Shuting Down:${Color_Off}"
    echo
    sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh
    sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh    
    sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh
    echo

    sleep 2
    
    sh /usr/local/ByteSaverSignalConverter$opcode/runByteSaverSignalConverter.sh
    echo
    
    sleep 8

    ps -aux |grep ByteSaverSignalConverter
    ;;
    #-----------------------------------------------------------------------------------------------------------------
    BM)
    echo -e "${BCyan}Restarting Service--(ByteSaverMediaProxy)${Color_Off}"
    echo
    echo -e "${BGreen}Enter Your Oparator Code: ${Color_Off}"
    read opcode
    echo
    echo -e "${BPurple}ByteSaverMediaProxy Shuting Down:${Color_Off}"
    sh /usr/local/ByteSaverMediaProxy$opcode/shutdownByteSaverMediaProxy.sh
    sh /usr/local/ByteSaverMediaProxy$opcode/shutdownByteSaverMediaProxy.sh
    sh /usr/local/ByteSaverMediaProxy$opcode/shutdownByteSaverMediaProxy.sh
    echo

    sleep 2

    sh /usr/local/ByteSaverMediaProxy$opcode/runByteSaverMediaProxy.sh
    echo

    sleep 8

    ps -aux |grep ByteSaverMediaProxy
    ;;
    #-----------------------------------------------------------------------------------------------------------------
    2)
    echo -e "${BCyan}Restarting Service--(iTelSwitchPlus)${Color_Off}"
    echo
    echo -e "${BGreen}Enter Your iTelSwitchPlus Name: ${Color_Off}"
    read sname
    echo
    echo -e "${BCyan}Restarting Service--(iTelSwitchPlus)${Color_Off}"
    echo

    cd /usr/local/iTelSwitchPlusSignaling$sname/
    echo
    echo -e "${BYellow}Taking Backup Current Log4j File ${BRed}(SIGNALING)${Color_Off}${BYellow}_ _ _ _ _ ${Color_Off}"
    mv log4j.properties log4j.properties_$(date '+%YYr_%mMon_%dDay_%HHr_%MMin_%SSec')
    echo
    ls | grep -e log4j.properties_20
    echo
    sleep 2
    echo -e "${BCyan}Downloading New Log4j File_ _ _ _ _ _ _ _ ${Color_Off}"
    echo
    wget http://149.20.188.7/log4j.properties_signaling
    echo -e "${BGreen}Re-Naming_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ ${Color_Off}"    
    echo
    mv log4j.properties_signaling log4j.properties
    echo -e "${BCyan}Current Log4j File_ _ _ _ _ _ _ _ _ _ _ _${Color_Off}"
    echo
    ls --time=ctime -l log4j.properties
    sleep 2
    echo
    cd /usr/local/
    
    echo -e "${BPurple}iTelSwitchPlusSignaling Shuting Down:${Color_Off}"
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh   
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh
    echo

    sleep 2

    sh /usr/local/iTelSwitchPlusSignaling$sname/runiTelSwitchPlusSignaling.sh
    echo

    sleep 8
    
    
    cd /usr/local/iTelSwitchPlusMediaProxy$sname/
    echo
    echo -e "${BYellow}Taking Backup Current Log4j File ${BRed}(MEDIA)${Color_Off}${BYellow}_ _ _ _ _ ${Color_Off}"
    mv log4j.properties log4j.properties_$(date '+%YYr_%mMon_%dDay_%HHr_%MMin_%SSec')
    echo
    ls | grep -e log4j.properties_20
    echo
    sleep 2
    echo
    echo -e "${BCyan}Downloading New Log4j File_ _ _ _ _ _ _ _ ${Color_Off}"
    echo
    wget http://149.20.188.7/log4j.properties_media
    echo
    echo -e "${BGreen}Re-Naming_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ ${Color_Off}"
    echo
    mv log4j.properties_media log4j.properties
    echo -e "${BCyan}Current Log4j File_ _ _ _ _ _ _ _ _ _ _ _${Color_Off}"
    echo
    ls --time=ctime -l log4j.properties
    sleep 2
    echo
    cd /usr/local/
    echo -e "${BPurple}iTelSwitchPlusMediaProxy Shuting Down:${Color_Off}"
    sh /usr/local/iTelSwitchPlusMediaProxy$sname/shutdowniTelSwitchPlusMediaProxy.sh
    sh /usr/local/iTelSwitchPlusMediaProxy$sname/shutdowniTelSwitchPlusMediaProxy.sh
    sh /usr/local/iTelSwitchPlusMediaProxy$sname/shutdowniTelSwitchPlusMediaProxy.sh
    echo

    sleep 2

    sh /usr/local/iTelSwitchPlusMediaProxy$sname/runiTelSwitchPlusMediaProxy.sh
    echo

    sleep 8

    ps -aux |grep iTelSwitchPlus

    ;;
    #-----------------------------------------------------------------------------------------------------------------
    SS)
    echo -e "${BCyan}Restarting Service--(iTelSwitchPlusSignaling)${Color_Off}"
    echo
    echo -e "${BGreen}Enter Your iTelSwitchPlus Name: ${Color_Off}"
    read sname
    echo
    cd /usr/local/iTelSwitchPlusSignaling$sname/
    echo
    echo -e "${BYellow}Taking Backup Current Log4j File ${BRed}(SIGNALING)${Color_Off}${BYellow}_ _ _ _ _ ${Color_Off}"
    mv log4j.properties log4j.properties_$(date '+%YYr_%mMon_%dDay_%HHr_%MMin_%SSec')
    echo
    ls | grep -e log4j.properties_20
    echo
    sleep 2
    echo -e "${BCyan}Downloading New Log4j File_ _ _ _ _ _ _ _ ${Color_Off}"
    echo
    wget http://149.20.188.7/log4j.properties_signaling
    echo -e "${BGreen}Re-Naming_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ ${Color_Off}"    
    echo
    mv log4j.properties_signaling log4j.properties
    echo -e "${BCyan}Current Log4j File_ _ _ _ _ _ _ _ _ _ _ _${Color_Off}"
    echo
    ls --time=ctime -l log4j.properties
    sleep 2
    echo
    cd /usr/local/
    
    echo -e "${BPurple}iTelSwitchPlusSignaling Shuting Down:${Color_Off}"
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh   
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh
    echo

    sleep 2

    sh /usr/local/iTelSwitchPlusSignaling$sname/runiTelSwitchPlusSignaling.sh
    echo

    sleep 8

    ps -aux |grep iTelSwitchPlus
    ;;
    #-----------------------------------------------------------------------------------------------------------------
    SM)
    echo -e "${BCyan}Restarting Service--(iTelSwitchPlusSignaling)${Color_Off}"
    echo
    echo -e "${BGreen}Enter Your Switch Name: ${Color_Off}"
    read sname
    echo
    cd /usr/local/iTelSwitchPlusMediaProxy$sname/
    echo
    echo -e "${BYellow}Taking Backup Current Log4j File ${BRed}(MEDIA)${Color_Off}${BYellow}_ _ _ _ _ ${Color_Off}"
    mv log4j.properties log4j.properties_$(date '+%YYr_%mMon_%dDay_%HHr_%MMin_%SSec')
    echo
    ls | grep -e log4j.properties_20
    echo
    sleep 2
    echo
    echo -e "${BCyan}Downloading New Log4j File_ _ _ _ _ _ _ _ ${Color_Off}"
    echo
    wget http://149.20.188.7/log4j.properties_media
    echo
    echo -e "${BGreen}Re-Naming_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ ${Color_Off}"
    echo
    mv log4j.properties_media log4j.properties
    echo -e "${BCyan}Current Log4j File_ _ _ _ _ _ _ _ _ _ _ _${Color_Off}"
    echo
    ls --time=ctime -l log4j.properties
    sleep 2
    echo
    cd /usr/local/
    echo -e "${BPurple}iTelSwitchPlusMediaProxy Shuting Down:${Color_Off}"
    sh /usr/local/iTelSwitchPlusMediaProxy$sname/shutdowniTelSwitchPlusMediaProxy.sh
    sh /usr/local/iTelSwitchPlusMediaProxy$sname/shutdowniTelSwitchPlusMediaProxy.sh
    sh /usr/local/iTelSwitchPlusMediaProxy$sname/shutdowniTelSwitchPlusMediaProxy.sh
    echo

    sleep 2

    sh /usr/local/iTelSwitchPlusMediaProxy$sname/runiTelSwitchPlusMediaProxy.sh
    echo

    sleep 8

    ps -aux |grep iTelSwitchPlus
    ;;
    #-----------------------------------------------------------------------------------------------------------------
    3)
    echo -e "${BCyan}Tomcat Restarting.......${Color_Off}"
    echo
    echo -e "${BYellow}Please Wait for a while......${Color_Off}"
    echo
    service tomcat stop
    service tomcat stop
    service tomcat stop
    echo

    sleep 1

    ps -aux |grep jar

    sleep 5
    echo
    echo -e "${BRed}Deleting Catalina Folder!${Color_Off}"
    echo
     
    cd /usr/local/jakarta-tomcat-7.0.61/work
    rm -rf Catalina
    
    sleep 3

    echo -e "${BRed}Want To Kill Process?${Color_Off}"
    read kp
    echo

    if [[ $kp == 'y' ]]
    then
    echo -e "${BGreen}Please Enter Proccess ID:${Color_Off}"
    read pid
    echo
    kill -9 $pid
    echo
    
    sleep 3
    
    echo -e $pid "${BGreen}--> Kill Done!${Color_Off}"
    echo
    
    sleep 1
    
    ps -aux |grep jar

	  sleep 3
    echo
    echo -e "${BGreen}Starting Tomcat......${Color_Off}"
    echo
    
    sleep 1
    
    service tomcat start
    echo

    ps -aux |grep jar
    echo     
    sleep 2
    
    echo -e "${BGreen}Tomcat Restart Successfully!!!!!${Color_Off}"
    echo
    
    echo -e "${BYellow}Checking Server Startup Time.......${Color_Off}"
    echo
    
    cd /usr/local/jakarta-tomcat-7.0.61/logs
    tail -f catalina.out | grep 'Server startup'

    echo -e "${BGreen}Tomcat Restart Successfully!!!!!${Color_Off}"


    elif [[ $kp == 'n' ]]
    then
    
    sleep 2

    echo -e "${BCyan}Starting Tomcat......${Color_Off}"
    echo
    
    sleep 1
    
    service tomcat start
    echo

    ps -aux |grep jar
    echo     
    sleep 2
    
    echo -e "${BGreen}Tomcat Restart Successfully!!!!!${Color_Off}"
    echo
    
    echo -e "${BYellow}Checking Server Startup Time.......${Color_Off}"
    echo
    
    cd /usr/local/jakarta-tomcat-7.0.61/logs
    tail -f catalina.out | grep 'Server startup'
    
    else
    echo -e "{BRed}Failed------${Color_Off}"
    fi
    ;;
    #-----------------------------------------------------------------------------------------------------------------
    4)
    cd /etc/rc.d/init.d/
    apache_service_name=$(grep -iRl apache-tomcat-7.0.59)
    
    systemctl daemon-reload

    if [[ -z "$apache_service_name" ]]; then
    
    echo -e "${BRed}Apache Not Found!!${Color_Off}"
    echo
     
    else
    
    echo -e "${BCyan}Apache Restarting.......${Color_Off}"
    echo
      
    echo -e "${BYellow}Please Wait for a while......${Color_Off}"
    service $apache_service_name stop
    service $apache_service_name stop
    service $apache_service_name stop
    echo

    sleep 5

    ps -aux |grep apache-tomcat
    echo

    sleep 5
    
    echo -e "${BRed}Want To Kill Process?${Color_Off}"
    read kp
    echo

    if [[ $kp == 'y' ]]
    then
    echo -e "${BGreen}Please Enter Proccess ID:${Color_Off}"
    read pid
    echo
    kill -9 $pid

    sleep 5
    echo
    echo -e $pid "${BGreen}Kill Done!${Color_Off}"
    echo
    
    sleep 1
    
    ps -aux |grep apache-tomcat
    echo

	  sleep 2

    echo -e "${BGreen}Starting Apache......${Color_Off}"
    echo
    
    sleep 1
    
    service $apache_service_name start
    echo
    
    sleep 2
    
    echo -e "${BGreen}Apache Restart Successfully!!!!!${Color_Off}"
    echo
    
    sleep 2

    ps -aux |grep jar
    echo

    
    elif [[ $kp == 'n' ]]
    then

    sleep 3

    echo -e "${BGreen}Starting Apache......${Color_Off}"
    echo
    
    sleep 2
    
    service $apache_service_name start
    echo
    
    sleep 2

    ps -aux |grep apache-tomcat
    echo

    echo -e "${BGreen}Apache Restart Successfully!!!!!${Color_Off}"
    echo
    
    else 
    
    echo -e "${BRed}Failed------${Color_Off}"
    
    fi
    
    fi
    ;;
    
    
    
    
    #-----------------------------------------------------------------------------------------------------------------
    5)
    echo -e "${BGreen}Restarting All Services & Clear All Unwanted Log Files & Memory Free${Color_Off}"
    echo
    echo -e "${BGreen}Enter Your Oparator Code: ${Color_Off}"
    read opcode
    echo
    echo -e "${BGreen}Enter Your iTelSwitchPlus Name: ${Color_Off}"
    read sname
    echo 
    echo -e "${BGreen}Enter Your DBHealthChacker Name: ${Color_Off}"
    read dbhcname
    echo
    #-----------------------------------------------------------------------------------------------------------------   
    echo
    echo -e "${BYellow}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
    echo
    if [[ -z "$opcode" ]];
    then
    echo -e "${BRed}Skiping ByteSaver Log Delete Process....${Color_Off}"
    echo
    else
    echo -e "${BPurple}Deleting ByteSaver Log File.......... ${Color_Off}"
    echo
    cd /usr/local/ByteSaverSignalConverter$opcode/
    rm -f SignalingProxy.log.*
    cd /usr/local/ByteSaverSignalConverter$opcode/logs/
    rm -rf `date "+%Y"`*
    cd /usr/local/ByteSaverMediaProxy$opcode/
    rm -f MediaProxy.log.*
    cd /usr/local/ByteSaverMediaProxy$opcode/logs/
    rm -rf `date "+%Y"`*
    echo -e "${BRed}Deleted ByteSaver Log File Done. ${Color_Off}"
    fi
    
    sleep 3
    
    if [[ -z "$sname" ]];
    then
    echo -e "${BRed}Skiping Switch Log Delete Process....${Color_Off}"
    else
    echo
    echo -e "${BPurple}Deleting iTelSwitch Log File......... ${Color_Off}"
    echo
    cd /usr/local/iTelSwitchPlusSignaling$sname/
    rm -f iTelSwitchPlusSignaling.log.*
    cd /usr/local/iTelSwitchPlusMediaProxy$sname/
    rm -f iTelSwitchPlusMediaProxy.log.*
    echo -e "${BRed}Deleted iTelSwitch Log File Done. ${Color_Off}"
    fi
  
    sleep 3
    
    echo
    echo -e "${BYellow}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
    echo
    echo 
    
    

    until [[ $choice == e ]]
    do
    
    echo -e "${BGreen}Want To Reduce More? [y/n]${Color_Off}"
    read choice
    echo
    
    case $choice in
    y)
    cd /usr/local/ && ls | grep -e ByteSaver -e iTelSwitchPlus
    echo -e "${BGreen}Enter Another Oparator Code: ${Color_Off}"
    read opcode2
    echo
    echo -e "${BGreen}Enter Another iTelSwitchPlus Name: ${Color_Off}"
    read sname2
    echo   
    echo
    echo -e "${BYellow}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
    echo
    if [[ -z "$opcode2" ]];
    then
    echo -e "${BRed}Skiping ByteSaver Log Delete Process....${Color_Off}"
    echo
    else
    echo -e "${BPurple}Deleting ByteSaver Log File.......... ${Color_Off}"
    echo
    cd /usr/local/ByteSaverSignalConverter$opcode2/
    rm -f SignalingProxy.log.*
    cd /usr/local/ByteSaverSignalConverter$opcode2/logs/
    rm -rf `date "+%Y"`*
    cd /usr/local/ByteSaverMediaProxy$opcode2/
    rm -f MediaProxy.log.*
    cd /usr/local/ByteSaverMediaProxy$opcode2/logs/
    rm -rf `date "+%Y"`*
    echo -e "${BRed}Deleted ByteSaver Log File Done. ${Color_Off}"
    fi
    
    sleep 3
    
    if [[ -z "$sname2" ]];
    then
    echo -e "${BRed}Skiping Switch Log Delete Process....${Color_Off}"
    else
    echo
    echo -e "${BPurple}Deleting iTelSwitch Log File......... ${Color_Off}"
    echo
    cd /usr/local/iTelSwitchPlusSignaling$sname2/
    rm -f iTelSwitchPlusSignaling.log.*
    cd /usr/local/iTelSwitchPlusMediaProxy$sname2/
    rm -f iTelSwitchPlusMediaProxy.log.*
    echo -e "${BRed}Deleted iTelSwitch Log File Done. ${Color_Off}"
    fi
  
    sleep 3
    
    echo
    echo -e "${BGreen}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
    echo
    ;;
    *)
    echo -e "${BGreen}We Are Forward To The Next Step.${Color_Off}"
    echo
    break;
    ;;
    esac

    done
    
    
    #-----------------------------------------------------------------------------------------------------------------
    echo -e "${BCyan}Restarting Service--(ByteSaver)${Color_Off}"
    echo
    echo -e "${BPurple}ByteSaverSignalingConverter Shuting Down:${Color_Off}"
    sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh
    sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh
    sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh
    echo

    sleep 5

    sh /usr/local/ByteSaverSignalConverter$opcode/runByteSaverSignalConverter.sh
    echo

    sleep 5
    
    echo -e "${BPurple}ByteSaverMediaProxy Shuting Down:${Color_Off}"
    sh /usr/local/ByteSaverMediaProxy$opcode/shutdownByteSaverMediaProxy.sh
    sh /usr/local/ByteSaverMediaProxy$opcode/shutdownByteSaverMediaProxy.sh
    sh /usr/local/ByteSaverMediaProxy$opcode/shutdownByteSaverMediaProxy.sh
    echo

    sleep 5

    sh /usr/local/ByteSaverMediaProxy$opcode/runByteSaverMediaProxy.sh
    echo

    sleep 5

    #-----------------------------------------------------------------------------------------------------------------

    echo -e "${BCyan}Restarting Service--(iTelSwitchPlus)${Color_Off}"
    echo

    cd /usr/local/iTelSwitchPlusSignaling$sname/
    echo
    echo -e "${BYellow}Taking Backup Current Log4j File ${BRed}(SIGNALING)${Color_Off}${BYellow}_ _ _ _ _ ${Color_Off}"
    mv log4j.properties log4j.properties_$(date '+%YYr_%mMon_%dDay_%HHr_%MMin_%SSec')
    echo
    ls | grep -e log4j.properties_20
    echo
    sleep 2
    echo -e "${BCyan}Downloading New Log4j File_ _ _ _ _ _ _ _ ${Color_Off}"
    echo
    wget http://149.20.188.7/log4j.properties_signaling
    echo -e "${BGreen}Re-Naming_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ ${Color_Off}"    
    echo
    mv log4j.properties_signaling log4j.properties
    echo -e "${BCyan}Current Log4j File_ _ _ _ _ _ _ _ _ _ _ _${Color_Off}"
    echo
    ls --time=ctime -l log4j.properties
    sleep 2
    echo
    cd /usr/local/
    
    echo -e "${BPurple}iTelSwitchPlusSignaling Shuting Down:${Color_Off}"
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh   
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh
    echo

    sleep 5

    sh /usr/local/iTelSwitchPlusSignaling$sname/runiTelSwitchPlusSignaling.sh
    echo

    sleep 5
    cd /usr/local/iTelSwitchPlusMediaProxy$sname/
    echo
    echo -e "${BYellow}Taking Backup Current Log4j File ${BRed}(MEDIA)${Color_Off}${BYellow}_ _ _ _ _ ${Color_Off}"
    mv log4j.properties log4j.properties_$(date '+%YYr_%mMon_%dDay_%HHr_%MMin_%SSec')
    echo
    ls | grep -e log4j.properties_20
    echo
    sleep 2
    echo
    echo -e "${BCyan}Downloading New Log4j File_ _ _ _ _ _ _ _ ${Color_Off}"
    echo
    wget http://149.20.188.7/log4j.properties_media
    echo
    echo -e "${BGreen}Re-Naming_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ ${Color_Off}"
    echo
    mv log4j.properties_media log4j.properties
    echo -e "${BCyan}Current Log4j File_ _ _ _ _ _ _ _ _ _ _ _${Color_Off}"
    echo
    ls --time=ctime -l log4j.properties
    sleep 2
    echo
    cd /usr/local/
    echo -e "${BPurple}iTelSwitchPlusMediaProxy Shuting Down:${Color_Off}"
    sh /usr/local/iTelSwitchPlusMediaProxy$sname/shutdowniTelSwitchPlusMediaProxy.sh
    sh /usr/local/iTelSwitchPlusMediaProxy$sname/shutdowniTelSwitchPlusMediaProxy.sh
    sh /usr/local/iTelSwitchPlusMediaProxy$sname/shutdowniTelSwitchPlusMediaProxy.sh
    echo

    sleep 5

    sh /usr/local/iTelSwitchPlusMediaProxy$sname/runiTelSwitchPlusMediaProxy.sh
    echo

    sleep 5
    #-------------------------------------------DiskSpaceChecker------------------------------------------------------
    echo
    echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(DiskSpaceChecker)${Color_Off}"
    echo
    echo -e "${BPurple}DiskSpaceChecker Shuting Down:${Color_Off}"
    sh /usr/local/DiskSpaceChecker/shutdownDiskSpaceChecker.sh
    sh /usr/local/DiskSpaceChecker/shutdownDiskSpaceChecker.sh
    sh /usr/local/DiskSpaceChecker/shutdownDiskSpaceChecker.sh
    echo

    sleep 5

    echo
    sh /usr/local/DiskSpaceChecker/runDiskSpaceChecker.sh

    sleep 5

    #-----------------------------------------------------------------------------------------------------------------

    #-------------------------------------------DBHealthChecker------------------------------------------------------
    echo
    echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(DBHealthChecker)${Color_Off}"
    echo
    echo -e "${BPurple}DBHealthChecker Shuting Down:${Color_Off}"
    sh /usr/local/DBHealthChecker$dbhcname/shutdownDBHealthChecker.sh
    sh /usr/local/DBHealthChecker$dbhcname/shutdownDBHealthChecker.sh
    sh /usr/local/DBHealthChecker$dbhcname/shutdownDBHealthChecker.sh
    echo

    sleep 5

    echo

    sh /usr/local/DBHealthChecker$dbhcname/runDBHealthChecker.sh

    sleep 5

    #-----------------------------------------------------------------------------------------------------------------


    #-------------------------------------------AppServer------------------------------------------------------
    echo
    echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(iTelAppsServer)${Color_Off}"
    echo
    echo -e "${BPurple}DBHealthChecker Shuting Down:${Color_Off}"
    sh /usr/local/iTelAppsServer$sname/shutdowniTelAppsServer.sh
    sh /usr/local/iTelAppsServer$sname/shutdowniTelAppsServer.sh
    sh /usr/local/iTelAppsServer$sname/shutdowniTelAppsServer.sh
    echo

    sleep 5

    echo

    sh /usr/local/iTelAppsServer$sname/runiTelAppsServer.sh
    
    sleep 5

    #-----------------------------------------------------------------------------------------------------------------




    #-----------------------------------------------------------------------------------------------------------------
    echo
    echo -e "${BCyan}Tomcat Restarting.......${Color_Off}"
    echo
    echo -e "${BYellow}Please Wait for a while......${Color_Off}"
    echo
    service tomcat stop
    service tomcat stop
    service tomcat stop
    echo

    sleep 1

    ps -aux |grep jar
    echo

    sleep 5
    
    echo -e "${BCyan}Deleting Catalina .......${Color_Off}"
      
    cd /usr/local/jakarta-tomcat-7.0.61/work
    rm -rf Catalina
    
    sleep 3
    echo
    echo -e "${BRed}Want To Kill Process?${Color_Off}"
    read kp
    echo

    if [[ $kp == 'y' ]]
    then
    echo -e "${BGreen}Please Enter Proccess ID:${Color_Off}"
    read pid
    echo
    kill -9 $pid
    
    sleep 3
    
    echo -e "${BCyan}Deleting Catalina .......${Color_Off}"
    echo
  
    cd /usr/local/jakarta-tomcat-7.0.61/work
    rm -rf Catalina

    sleep 1
    echo
    echo -e $pid "${BGreen}Kill Done!${Color_Off}"
    echo
    
    sleep 1
    
    ps -aux |grep jar
    echo

	  sleep 3
    echo
    echo -e "${BGreen}Starting Tomcat......${Color_Off}"
    echo
    
    sleep 1
    
    service tomcat start
    echo

    ps -aux |grep jar
    echo
    
    sleep 2
    
    echo -e "${BGreen}Tomcat Restart Successfully!!!!!${Color_Off}"
    echo
    echo -e "${BYellow}Checking Server Startup Time.......${Color_Off}"
    echo
    
    cd /usr/local/jakarta-tomcat-7.0.61/logs
    tail -f catalina.out | grep 'Server startup'
    echo

    echo -e "${BGreen}Tomcat Restart Successfully!!!!!${Color_Off}"
    echo


    elif [[ $kp == 'n' ]]
    then
    
    sleep 2
    echo
    echo -e "${BGreen}Starting Tomcat......${Color_Off}"
    echo
    sleep 1
    
    service tomcat start
    echo

    ps -aux |grep jar
    echo     
    sleep 2
    
    echo -e "${BGreen}Tomcat Restart Successfully!!!!!${Color_Off}"
    echo
    
    
    echo
    #-----------------------------------------------------------------------------------------------------------------
    echo
    echo -e "${BGreen}----------------------Free Up Memory(RAM)-------------------${Color_Off}"
    free -m
    echo
    echo 1 > /proc/sys/vm/drop_caches
    echo
    echo -e "${BGreen}Memory Free Complete.${Color_Off}"
    echo
    free -m

    else
    echo -e "${BRed}Failed------${Color_Off}"
    fi
    echo
    echo -e "${BYellow}Checking Server Startup Time.......${Color_Off}"
    cd /usr/local/jakarta-tomcat-7.0.61/logs
    echo
    tail -f catalina.out | grep -m 'Server startup'
    echo
    ;;
    #-----------------------------------------------------------------------------------------------------------------
    
    
    
    
    
    6)
    echo -e "${BGreen}---------Checking Memory---------${Color_Off}"
    free -m
    ;;
    #-----------------------------------------------------------------------------------------------------------------
    7)
    echo -e "${BGreen}---------Checking Storage---------${Color_Off}"
    df -hT
    ;;
    #-----------------------------------------------------------------------------------------------------------------
    8)
    echo -e "${BGreen}---------Checking CPU---------${Color_Off}"
    top
    ;;
    #-----------------------------------------------------------------------------------------------------------------
    9)
    echo -e "${BGreen}Enter Switch Name:${Color_Off}"
    echo
    read sname
    echo
    echo -e "${BGreen}--------------------Checking Running Call-------------------${Color_Off}"
    tail -f /usr/local/iTelSwitchPlusSignaling$sname/iTelSwitchPlusSignaling.log | grep 'Total Running' -i
    sleep 1
    echo -e "Done"
    ;; 
    #-----------------------------------------------------------------------------------------------------------------
    10)
    echo
    echo -e "${BGreen}--------------------Checking Running Proccess---------------${Color_Off}"
    echo
    ps -aux|grep jar
    sleep 5
    ;;
    #-----------------------------------------------------------------------------------------------------------------
    11)
    echo
    echo -e "${BGreen}----------------------Free Up Memory(RAM)-------------------${Color_Off}"
    free -m
    echo
    echo 1 > /proc/sys/vm/drop_caches
    echo
    echo -e "${BGreen}Memory Free Complete.${Color_Off}"
    echo
    free -m
    ;;
    #-----------------------------------------------------------------------------------------------------------------
    12)
    echo -e "${BRed}---------------------------HDD Reduce-----------------------${Color_Off}"
    echo -e "${BCyan}Enter Your Oparator Code: ${Color_Off}"
    read opcode
    echo -e "${BCyan}Enter Your iTelSwitchPlus Name: ${Color_Off}"
    read sname
    echo
    echo -e "${BGreen}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
    echo
    if [[ -z "$opcode" ]];
    then
    echo -e "${BRed}Skiping ByteSaver Log Delete Process....${Color_Off}"
    echo
    else
    echo -e "${BYellow}Deleting ByteSaver Log File.......... ${Color_Off}"
    echo
    cd /usr/local/ByteSaverSignalConverter$opcode/
    rm -f SignalingProxy.log.*
    cd /usr/local/ByteSaverSignalConverter$opcode/logs/
    rm -rf `date "+%Y"`*
    cd /usr/local/ByteSaverMediaProxy$opcode/
    rm -f MediaProxy.log.*
    cd /usr/local/ByteSaverMediaProxy$opcode/logs/
    echo
    rm -rf `date "+%Y"`*
    echo -e "${BRed}Deleted ByteSaver Log File Done. ${Color_Off}"
    fi
    
    sleep 3
    
    if [[ -z "$sname" ]];
    then
    echo -e "${BRed}Skiping Switch Log Delete Process....${Color_Off}"
    else
    echo
    echo -e "${BYellow}Deleting iTelSwitch Log File......... ${Color_Off}"
    echo
    cd /usr/local/iTelSwitchPlusSignaling$sname/
    rm -f iTelSwitchPlusSignaling.log.*
    cd /usr/local/iTelSwitchPlusMediaProxy$sname/
    rm -f iTelSwitchPlusMediaProxy.log.*
    echo -e "${BRed}Deleted iTelSwitch Log File Done. ${Color_Off}"
    fi
  
    sleep 3
    
    echo
    echo -e "${BGreen}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
    echo
    
    until [[ $choice == e ]]
    do
    
    echo -e "${BCyan}Want To Reduce More? [y/n]${Color_Off}"
    read choice
    echo
    
    case $choice in
    y)
    cd /usr/local/ && ls | grep -e ByteSaver -e iTelSwitchPlus
    echo
    echo -e "${BCyan}Enter Another Oparator Code: ${Color_Off}"
    read opcode2
    echo
    echo -e "${BCyan}Enter Another iTelSwitchPlus Name: ${Color_Off}"
    read sname2
    echo   
    echo
    echo -e "${BGreen}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
    echo
    if [[ -z "$opcode2" ]];
    then
    echo -e "${BRed}Skiping ByteSaver Log Delete Process....${Color_Off}"
    echo
    else
    echo -e "${BYellow}Deleting ByteSaver Log File.......... ${Color_Off}"
    echo
    cd /usr/local/ByteSaverSignalConverter$opcode2/
    rm -f SignalingProxy.log.*
    cd /usr/local/ByteSaverSignalConverter$opcode2/logs/
    rm -rf `date "+%Y"`*
    cd /usr/local/ByteSaverMediaProxy$opcode2/
    rm -f MediaProxy.log.*
    cd /usr/local/ByteSaverMediaProxy$opcode2/logs/
    rm -rf `date "+%Y"`*
    echo -e "${BRed}Deleted ByteSaver Log File Done. ${Color_Off}"
    fi
    
    sleep 3
    
    if [[ -z "$sname2" ]];
    then
    echo -e "${BRed}Skiping Switch Log Delete Process....${Color_Off}"
    else
    echo
    echo -e "${BYellow}Deleting iTelSwitch Log File......... ${Color_Off}"
    echo
    cd /usr/local/iTelSwitchPlusSignaling$sname2/
    rm -f iTelSwitchPlusSignaling.log.*
    cd /usr/local/iTelSwitchPlusMediaProxy$sname2/
    rm -f iTelSwitchPlusMediaProxy.log.*
    echo -e "${BRed}Deleted iTelSwitch Log File Done. ${Color_Off}"
    fi
  
    sleep 3
    
    echo
    echo -e "${BGreen}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
    echo
    ;;
    *)
    echo -e "${BPurple}We Are Forward To The Next Step.${Color_Off}"
    echo
    break;
    ;;
    esac

    done    
    
    echo -e "${BCyan}Want To GZIP From (var/lib/mysql)? [y/n]${Color_Off}"
    read choice

    if [[ $choice == 'y' ]]
    then
    echo
    echo -e "${BRed}!!!!!!!--------------- BE CAREFUL --------------!!!!!!!${Color_Off}"
    echo
    echo -e "${BRed}!!!!!!!--- Do Not GZIP More Than 50 At A Time ---!!!!!!!${Color_Off}"
    echo
    sleep 5
    cd /var/lib/mysql/ && ls
    echo
    echo -e "${BCyan}Please Enter mysql-bin-serial${Color_Off}"
    read serial
    gzip $serial
    
    echo
    echo -e "${BGreen}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
    else
    echo
    echo -e "${BBlue}Thanks For Your Choice!!${Color_Off}"
    echo
    echo -e "${BGreen}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
    echo  
    fi
    ;; 
    #-----------------------------------------------------------------------------------------------------------------      
    13)
    echo
    echo -e "${BCyan}Choose Your Billing Option.${Color_Off}"
    echo -e "${BBlue}1. iTelBilling${Color_Off}"
    echo -e "${BBlue}2. iTelSMS${Color_Off}"
    echo
    
    echo -e "${BCyan}INPUT: ${Color_Off}"
    read billingOp 
    echo

    if [[ $billingOp == 1 ]]
    then

    echo -e "${BGreen}------------iTelBilling-------------- ${Color_Off}"
    echo
    cd /usr/local/jakarta-tomcat-7.0.61/webapps/ && ls
    echo

    echo -e ${BGreen}"Enter Billing Name : ${Color_Off}"

    read billingname
    echo

    cat /usr/local/jakarta-tomcat-7.0.61/webapps/$billingname/WEB-INF/classes/*.xml

    echo
    echo -e ${BGreen}"Enter Database Name : ${Color_Off}"
    read dbname
    echo

    mysql -u root --force -D $dbname -e "select * from vbUser\G;"
    echo

    echo -e "${BGreen}Please Enter usUserName : ${Color_Off}"
    read usUserName
    echo

    echo -e "${BGreen}Please Enter usUserID : ${Color_Off}"
    read usUserID
    echo

    mysql -u root --force -D $dbname -e "drop table vbUser_`date +"%Y%m%d"`; drop table vbSequencer_`date +"%Y%m%d"`;"

    mysql -u root --force -D $dbname -e "create table vbUser_`date +"%Y%m%d"` like vbUser; insert into vbUser_`date +"%Y%m%d"` (select * from vbUser); create table vbSequencer_`date +"%Y%m%d"` like vbSequencer; insert into vbSequencer_`date +"%Y%m%d"`(select * from vbSequencer);"

    mysql -u root --force -D $dbname -e "update vbUser set usPassword='ld/G0H198wXmukcRhga/xVwZ/fA=' where usUserID=$usUserID; update vbUser set usMaxRetryTime=10,usStatus=0 where usUserID=$usUserID; update vbSequencer set table_LastModificationTime = UNIX_TIMESTAMP(NOW())*1000 where table_name in ('vbUser');"
    echo
    echo -e "${BPurple} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
    echo -e "${BPurple}|${Color_Off}${BGreen}             NEW BILLING ACCESS            ${Color_Off}${BPurple}|${Color_Off}"
    echo -e "${BPurple} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
    echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
    echo -e "  ${BCyan}User Name     : ${Color_Off}${BRed}$usUserName ${Color_Off}"
    echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
    echo -e "  ${BCyan}New  Password : ${Color_Off}${BRed}SystemERROR404${Color_Off}"
    echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
    echo -e "${BPurple} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
    echo



    elif [[ $billingOp == 2 ]]
    then

    echo -e "${BGreen}--------------iTelSMS---------------- ${Color_Off}"
    echo
    cd /usr/local/apache-tomcat-7.0.59/webapps && ls
    echo

    echo -e ${BGreen}"Enter Billing Name : ${Color_Off}"

    read billingname
    echo

    cat /usr/local/apache-tomcat-7.0.59/webapps/$billingname/WEB-INF/classes/*.xml

    echo
    echo -e ${BGreen}"Enter Database Name : ${Color_Off}"
    read dbname
    echo

    mysql -u root --force -D $dbname -e "select * from vbUser\G;"
    echo
    
    
    echo -e "${BGreen}Please Enter usUserName : ${Color_Off}"
    read usUserName
    echo
    echo -e "${BGreen}Please Enter usUserID : ${Color_Off}"
    read usUserID
    echo 
    

    mysql -u root --force -D $dbname -e "drop table vbUser_`date +"%Y%m%d"`; drop table vbSequencer_`date +"%Y%m%d"`;"

    mysql -u root --force -D $dbname -e "create table vbUser_`date +"%Y%m%d"` like vbUser; insert into vbUser_`date +"%Y%m%d"` (select * from vbUser); create table vbSequencer_`date +"%Y%m%d"` like vbSequencer; insert into vbSequencer_`date +"%Y%m%d"` (select * from vbSequencer);"

    mysql -u root --force -D $dbname -e "update vbUser set usPassword='ld/G0H198wXmukcRhga/xVwZ/fA=' where usUserID=$usUserID; update vbUser set usMaxRetryTime=10,usStatus=0 where usUserID=$usUserID; update vbSequencer set table_LastModificationTime = UNIX_TIMESTAMP(NOW())*1000 where table_name in ('vbUser');"
    
    echo
    echo -e "${BPurple} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
    echo -e "${BPurple}|${Color_Off}${BGreen}             NEW BILLING ACCESS            ${Color_Off}${BPurple}|${Color_Off}"
    echo -e "${BPurple} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
    echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
    echo -e "  ${BCyan}User Name     : ${Color_Off}${BRed}$usUserName ${Color_Off}"
    echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
    echo -e "  ${BCyan}New  Password : ${Color_Off}${BRed}SystemERROR404${Color_Off}"
    echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
    echo -e "${BPurple} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
    echo
    else 
    
    echo -e "${BRed}Invalid Billing Option${Color_Off}"
    echo
    fi
    echo -e "${BGreen} Billing Access Changed Successfully.${Color_Off}"
    echo
    echo -e "${BRed}!!--> Please Copy The Billing Access <--!!${Color_Off}"
    echo
    echo
    echo
    sleep 5
    ;;
    #-----------------------------------------------------------------------------------------------------------------      
    14)
    echo
    echo -e "${BGreen}------------INFO - iTelBilling-------------- ${Color_Off}"
    echo
    cd /usr/local/jakarta-tomcat-7.0.61/webapps/ && ls
    echo

    echo -e ${BGreen}"Enter Billing Name : ${Color_Off}"

    read billingname
    echo

    cat /usr/local/jakarta-tomcat-7.0.61/webapps/$billingname/WEB-INF/classes/*.xml

    echo
    echo -e ${BGreen}"Enter Database Name : ${Color_Off}"
    read dbname
    echo
    echo -e "${BCyan}Enter Max-Call Limite : ${Color_Off}"
    read callLim 
    echo
    
    mysql -u root --force -D $dbname -e "drop table vbClient_`date +"%Y%m%d"`; drop table vbSequencer_`date +"%Y%m%d"`;"

    mysql -u root --force -D $dbname -e "create table vbClient_`date +"%Y%m%d"` like vbClient; insert into vbClient_`date +"%Y%m%d"` (select * from vbClient); create table vbSequencer_`date +"%Y%m%d"` like vbSequencer; insert into vbSequencer_`date +"%Y%m%d"` (select * from vbSequencer);"

    
    mysql -u root --force -D $dbname -e "update vbClient set clMaxCalls=$callLim where clAccountID in (select pinAccountID from vbPin);"
    
    echo
    echo -e "${BRed}Set Max-Call Limit :${Color_Off} ${BGreen}$callLim${Color_Off}"
    
    echo
    sleep 3
    echo -e "${BGreen}------------Restarting iTelSwitchPlus-------------- ${Color_Off}"
    echo
    cd /usr/local/ && ls | grep -e iTelSwitchPlus
    echo
    echo -e "${BGreen}Enter iTelSwitchPlus Name: ${Color_Off}"
    read sname
    echo
    
    echo -e "${BPurple}iTelSwitchPlusSignaling Shuting Down:${Color_Off}"
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh   
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh
    echo

    sleep 3

    sh /usr/local/iTelSwitchPlusSignaling$sname/runiTelSwitchPlusSignaling.sh
    echo
    
    sleep 5
    
    echo
    
    echo -e "${BCyan}Tomcat Restarting.......${Color_Off}"
    echo
    echo -e "${BYellow}Please Wait for a while......${Color_Off}"
    echo
    service tomcat stop
    service tomcat stop
    service tomcat stop
    echo

    sleep 1

    ps -aux |grep jar
    echo

    sleep 5
    
    echo -e "${BCyan}Deleting Catalina .......${Color_Off}"
      
    cd /usr/local/jakarta-tomcat-7.0.61/work
    rm -rf Catalina
    
    sleep 3
    echo
    echo -e "${BRed}Want To Kill Process?${Color_Off}"
    read kp
    echo

    if [[ $kp == 'y' ]]
    then
    echo -e "${BGreen}Please Enter Proccess ID:${Color_Off}"
    read pid
    echo
    kill -9 $pid
    
    sleep 3
    
    echo -e "${BCyan}Deleting Catalina .......${Color_Off}"
    echo
  
    cd /usr/local/jakarta-tomcat-7.0.61/work
    rm -rf Catalina

    sleep 1
    echo
    echo -e $pid "${BGreen}Kill Done!${Color_Off}"
    echo
    
    sleep 1
    
    ps -aux |grep jar
    echo

	  sleep 3
    echo
    echo -e "${BGreen}Starting Tomcat......${Color_Off}"
    echo
    
    sleep 1
    
    service tomcat start
    echo

    ps -aux |grep jar
    echo
    
    sleep 2
    
    echo -e "${BGreen}Tomcat Restart Successfully!!!!!${Color_Off}"
    echo
    echo -e "${BYellow}Checking Server Startup Time.......${Color_Off}"
    echo
    
    cd /usr/local/jakarta-tomcat-7.0.61/logs
    tail -f catalina.out | grep 'Server startup'
    echo

    elif [[ $kp == 'n' ]]
    then
    
    sleep 2
    echo
    echo -e "${BGreen}Starting Tomcat......${Color_Off}"
    echo
    sleep 1
    
    service tomcat start
    echo

    ps -aux |grep jar
    echo     
    sleep 2
    
    echo -e "${BGreen}Tomcat Restart Successfully!!!!!${Color_Off}"
    echo
    
    echo -e "${BYellow}Checking Server Startup Time.......${Color_Off}"
    echo
    
    cd /usr/local/jakarta-tomcat-7.0.61/logs
    tail -f catalina.out | grep 'Server startup'

    echo

    else
    echo -e "${BRed}Failed------${Color_Off}"
    fi 
    echo 
    ;;
    #-----------------------------------------------------------------------------------------------------------------
    
    
    #-----------------------------------------------------------------------------------------------------------------      
    15)
    echo
    echo -e "${BGreen}------------INFO - iTelBilling-------------- ${Color_Off}"
    echo
    cd /usr/local/jakarta-tomcat-7.0.61/webapps/ && ls
    echo

    echo -e "${BGreen}Enter Billing Name : ${Color_Off}"

    read billingname
    echo

    cat /usr/local/jakarta-tomcat-7.0.61/webapps/$billingname/WEB-INF/classes/*.xml

    echo
    echo -e ${BGreen}"Enter Database Name : ${Color_Off}"
    echo
    read dbname
    echo

    echo -e "${BGreen}Select The Year.${Color_Off}"
    echo
    echo -e "${BRed}1. 2025${Color_Off}" #1767225599000
    echo -e "${BRed}2. 2026${Color_Off}" #1798761599000
    echo -e "${BRed}3. 2027${Color_Off}" #1830297599000
    echo -e "${BRed}4. 2028${Color_Off}" #1861919999000
    echo -e "${BRed}5. 2029${Color_Off}" #1893455999000
    echo -e "${BRed}6. 2030${Color_Off}" #1924991999000
    echo -e "${BRed}7. Other${Color_Off}"
    echo
    read year
    echo

    if [[ $year == 1 ]]
    then
    mysql -u root --force -D $dbname -e "drop table vbPin_`date +"%Y%m%d"`; drop table vbSequencer_`date +"%Y%m%d"`;"

    mysql -u root --force -D $dbname -e "create table vbPin_`date +"%Y%m%d"` like vbPin; insert into vbPin_`date +"%Y%m%d"` (select * from vbPin); create table vbSequencer_`date +"%Y%m%d"` like vbSequencer; insert into vbSequencer_`date +"%Y%m%d"` (select * from vbSequencer);"

    
    mysql -u root --force -D $dbname -e "update vbPin set pinExpirationTime=1767225599000;"
    
    sleep 3
    echo
    echo -e "${BCyan}All Pin's Expire Time Is Now - 31-12-2025(11:59:59 PM)${Color_Off}"
    echo
    
    elif [[ $year == 2 ]]
    then
    mysql -u root --force -D $dbname -e "drop table vbPin_`date +"%Y%m%d"`; drop table vbSequencer_`date +"%Y%m%d"`;"

    mysql -u root --force -D $dbname -e "create table vbPin_`date +"%Y%m%d"` like vbPin; insert into vbPin_`date +"%Y%m%d"` (select * from vbPin); create table vbSequencer_`date +"%Y%m%d"` like vbSequencer; insert into vbSequencer_`date +"%Y%m%d"` (select * from vbSequencer);"
    
    mysql -u root --force -D $dbname -e "update vbPin set pinExpirationTime=1798761599000;"
    
    sleep 3
    echo
    echo -e "${BCyan}All Pin's Expire Time Is Now - 31-12-2026(11:59:59 PM)${Color_Off}"
    echo
    
    elif [[ $year == 3 ]]
    then
    mysql -u root --force -D $dbname -e "drop table vbPin_`date +"%Y%m%d"`; drop table vbSequencer_`date +"%Y%m%d"`;"

    mysql -u root --force -D $dbname -e "create table vbPin_`date +"%Y%m%d"` like vbPin; insert into vbPin_`date +"%Y%m%d"` (select * from vbPin); create table vbSequencer_`date +"%Y%m%d"` like vbSequencer; insert into vbSequencer_`date +"%Y%m%d"` (select * from vbSequencer);"

    
    mysql -u root --force -D $dbname -e "update vbPin set pinExpirationTime=1830297599000;"
    
    sleep 3
    echo
    echo -e "${BCyan}All Pin's Expire Time Is Now - 31-12-2027(11:59:59 PM)${Color_Off}"
    echo
    
    elif [[ $year == 4 ]]
    then
    mysql -u root --force -D $dbname -e "drop table vbPin_`date +"%Y%m%d"`; drop table vbSequencer_`date +"%Y%m%d"`;"

    mysql -u root --force -D $dbname -e "create table vbPin_`date +"%Y%m%d"` like vbPin; insert into vbPin_`date +"%Y%m%d"` (select * from vbPin); create table vbSequencer_`date +"%Y%m%d"` like vbSequencer; insert into vbSequencer_`date +"%Y%m%d"` (select * from vbSequencer);"

    
    mysql -u root --force -D $dbname -e "update vbPin set pinExpirationTime=1861919999000;"
    
    sleep 3
    echo
    echo -e "${BCyan}All Pin's Expire Time Is Now - 31-12-2028(11:59:59 PM)${Color_Off}"
    echo
    
    elif [[ $year == 5 ]]
    then
    mysql -u root --force -D $dbname -e "drop table vbPin_`date +"%Y%m%d"`; drop table vbSequencer_`date +"%Y%m%d"`;"

    mysql -u root --force -D $dbname -e "create table vbPin_`date +"%Y%m%d"` like vbPin; insert into vbPin_`date +"%Y%m%d"` (select * from vbPin); create table vbSequencer_`date +"%Y%m%d"` like vbSequencer; insert into vbSequencer_`date +"%Y%m%d"` (select * from vbSequencer);"

    
    mysql -u root --force -D $dbname -e "update vbPin set pinExpirationTime=1893455999000;"
    
    sleep 3
    echo
    echo -e "${BCyan}All Pin's Expire Time Is Now - 31-12-2029(11:59:59 PM)${Color_Off}"
    echo
    
    elif [[ $year == 6 ]]
    then
    mysql -u root --force -D $dbname -e "drop table vbPin_`date +"%Y%m%d"`; drop table vbSequencer_`date +"%Y%m%d"`;"

    mysql -u root --force -D $dbname -e "create table vbPin_`date +"%Y%m%d"` like vbPin; insert into vbPin_`date +"%Y%m%d"` (select * from vbPin); create table vbSequencer_`date +"%Y%m%d"` like vbSequencer; insert into vbSequencer_`date +"%Y%m%d"` (select * from vbSequencer);"

    
    mysql -u root --force -D $dbname -e "update vbPin set pinExpirationTime=1924991999000;"
    
    sleep 3
    echo
    echo -e "${BCyan}All Pin's Expire Time Is Now - 31-12-2030(11:59:59 PM)${Color_Off}"
    echo
    
    elif [[ $year == 7 ]]
    then
    echo
    echo -e "${BRed}Please Go To 'https://www.epochconverter.com/' This Website.${Color_Off}"
    echo -e "${BRed}Convert Your Desire Year To "Timestamp in milliseconds:"${Color_Off}"
    echo -e "${BRed}Then Paste It Bellow Section.${Color_Off}"
    sleep 2
    echo
    echo -e "${BGreen}Enter Custom Year : ${Color_Off}"
    read cusYear
    echo
    echo -e "${BGreen}Enter Timestamp In Milliseconds : ${Color_Off}"
    read timestamp
    echo
    mysql -u root --force -D $dbname -e "drop table vbPin_`date +"%Y%m%d"`; drop table vbSequencer_`date +"%Y%m%d"`;"

    mysql -u root --force -D $dbname -e "create table vbPin_`date +"%Y%m%d"` like vbPin; insert into vbPin_`date +"%Y%m%d"` (select * from vbPin); create table vbSequencer_`date +"%Y%m%d"` like vbSequencer; insert into vbSequencer_`date +"%Y%m%d"` (select * from vbSequencer);"

    
    mysql -u root --force -D $dbname -e "update vbPin set pinExpirationTime=$timestamp;"
    
    sleep 3
    echo -e "${BCyan}All Pin's Expire Time Is Now - 31-12-$cusYear(11:59:59 PM)${Color_Off}"
    echo


    else
    echo -e "${BRed}Invalid Option!!${Color_Off}"

    fi

    echo
    sleep 3
    echo -e "${BGreen}------------Restarting iTelSwitchPlus-------------- ${Color_Off}"
    echo
    cd /usr/local/ && ls | grep -e iTelSwitchPlus
    echo
    echo -e "${BGreen}Enter iTelSwitchPlus Name: ${Color_Off}"
    read sname
    echo
    
    echo -e "${BPurple}iTelSwitchPlusSignaling Shuting Down:${Color_Off}"
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh   
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh
    echo

    sleep 3

    sh /usr/local/iTelSwitchPlusSignaling$sname/runiTelSwitchPlusSignaling.sh
    echo
    
    sleep 5
    
    echo
    
    echo -e "${BCyan}Tomcat Restarting.......${Color_Off}"
    echo
    echo -e "${BYellow}Please Wait for a while......${Color_Off}"
    echo
    service tomcat stop
    service tomcat stop
    service tomcat stop
    echo

    sleep 1

    ps -aux |grep jar
    echo

    sleep 5
    
    echo -e "${BCyan}Deleting Catalina .......${Color_Off}"
      
    cd /usr/local/jakarta-tomcat-7.0.61/work
    rm -rf Catalina
    
    sleep 3
    echo
    echo -e "${BRed}Want To Kill Process?${Color_Off}"
    read kp
    echo

    if [[ $kp == 'y' ]]
    then
    echo -e "${BGreen}Please Enter Proccess ID:${Color_Off}"
    read pid
    echo
    kill -9 $pid
    
    sleep 3
    
    echo -e "${BCyan}Deleting Catalina .......${Color_Off}"
    echo
  
    cd /usr/local/jakarta-tomcat-7.0.61/work
    rm -rf Catalina

    sleep 1
    echo
    echo -e $pid "${BGreen}Kill Done!${Color_Off}"
    echo
    
    sleep 1
    
    ps -aux |grep jar
    echo

	  sleep 3
    echo
    echo -e "${BGreen}Starting Tomcat......${Color_Off}"
    echo
    
    sleep 1
    
    service tomcat start
    echo

    ps -aux |grep jar
    echo
    
    sleep 2
    
    echo -e "${BGreen}Tomcat Restart Successfully!!!!!${Color_Off}"
    echo
    echo -e "${BYellow}Checking Server Startup Time.......${Color_Off}"
    echo
    
    cd /usr/local/jakarta-tomcat-7.0.61/logs
    tail -f catalina.out | grep 'Server startup'
    echo

    elif [[ $kp == 'n' ]]
    then
    
    sleep 2
    echo
    echo -e "${BGreen}Starting Tomcat......${Color_Off}"
    echo
    sleep 1
    
    service tomcat start
    echo

    ps -aux |grep jar
    echo     
    sleep 2
    
    echo -e "${BGreen}Tomcat Restart Successfully!!!!!${Color_Off}"
    echo
    
    echo -e "${BYellow}Checking Server Startup Time.......${Color_Off}"
    echo
    
    cd /usr/local/jakarta-tomcat-7.0.61/logs
    tail -f catalina.out | grep 'Server startup'

    echo

    else
    echo -e "${BRed}Failed------${Color_Off}"
    fi 
    echo 
    
    ;;
    #-----------------------------------------------------------------------------------------------------------------
    I)
    installerScript_timeout_duration=30  # Timeout in seconds
    
    
    while true; do
    echo -e "${BPurple} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
    echo -e "${BPurple}|${Color_Off}${BGreen}                 Installer                 ${Color_Off}${BPurple}|${Color_Off}"
    echo -e "${BPurple} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
    echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
    echo -e "  ${BCyan}1. Main Installer${Color_Off}"
    echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
    echo -e "  ${BCyan}2. SMS V4 Installer${Color_Off}"
    echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
    echo -e "  ${BCyan}3. SMS V4 Updater${Color_Off}"
    echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
    echo -e "  ${BCyan}4T. Service Shift${Color_Off}${BRed} - (TEST MODE)${Color_Off}"
    echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
    echo -e "  ${BCyan}5. Dependencey Install${Color_Off}"
    echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
    echo -e "  ${BCyan}6. 2FA Installer${Color_Off}"
    echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
    echo -e "  ${BCyan}7. Repository Update For CentOS 6${Color_Off}"
    echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
    echo -e "${BPurple} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
    echo -e "${BPurple}|${Color_Off}${BGreen}             Pree [e] For Exit             ${Color_Off}${BPurple}|${Color_Off}"
    echo -e "${BPurple} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
    echo
    echo -e "${BCyan}Which Installer You Want To Run?${Color_Off}"
    read -t $installerScript_timeout_duration choice || true
    
    if [[ -z "$choice" ]]; then
        echo
        echo -e "${On_IRed}Timeout Reached. Installer Script Is Exiting...${Color_Off}"
        break
    fi
    echo
    
    case $choice in
    
    1)
    echo -e "${BGreen}---------Main Installer---------${Color_Off}"
    echo
    echo
    rm -f Installer
    wget 'http://149.20.186.19/installerweb/fileurl.do?filepath=installerweb:download:Installer'
    mv  fileurl.do?filepath=installerweb:download:Installer  Installer
    chmod a+x Installer
    ./Installer 
    echo
    echo
    ;;
    
    2)
    echo -e "${BGreen}---------iTelSMS V4 Installer---------${Color_Off}"
    echo
    echo
    rm -rf sms_v4_installer
    wget https://supportresources.revesoft.com:4430/media/Installer/sms_v4_installer --no-check-certificate
    chmod a+x sms_v4_installer
    ./sms_v4_installer
    echo
    echo
    ;;
    3)
    echo -e "${BGreen}---------iTelSMS V4 Updater---------${Color_Off}"
    echo
    echo
    rm -f sms_switch_updatev4.sh 
    wget https://supportresources.revesoft.com:4430/media/Scripts/sms_switch_updatev4.sh --no-check-certificate
    chmod a+x sms_switch_updatev4.sh 
    ./sms_switch_updatev4.sh
    echo
    echo
    ;;
    
    4T)
    echo -e "${BGreen}---------Service Shift---------${Color_Off}"
    echo
    echo -e "${BYellow}---------Checking SCREEN---------${Color_Off}"
    echo

    if ! command -v screen &> /dev/null; then
        echo -e "${BRed}SCREEN Is Not Installed.${Color_Off}"
        echo
        echo -e "${BYellow}Installing SCREEN...${Color_Off}"
        echo
        yum install screen -y
    else
        echo -e "${BCyan}SCREEN Is Already Installed.${Color_Off}"
    fi

    # Check if there are any existing screen sessions with the name "Shifting"
    if screen -ls | grep -q "Shifting"; then
        echo -e "${BCyan}Existing screen session 'Shifting' found.${Color_Off}"
        echo -e "${BCyan}Terminating existing session...${Color_Off}"
        screen -S Shifting -X quit
        sleep 2
    fi

    # Create a new screen session named "Shifting" and execute commands
    echo -e "${BCyan}Creating new screen session 'Shifting'...${Color_Off}"
    screen -dmS Shifting bash -c '
        echo "Inside the new screen session"
        echo "Current working directory: $(pwd)"
        echo "Downloading menuShift..."
        rm -f menuShift
        wget http://training.revesoft.com/downloads/shifT/menuShift
        chmod 755 menuShift
        echo "Executing menuShift..."
        ./menuShift
        echo "Finished executing menuShift"
        sleep 5
        exit
    '

    # Wait for the screen session to finish executing
    sleep 10

    echo
    echo
    ;;



    5)
    echo -e "${BGreen}---------Dpendencey Install---------${Color_Off}"
    echo
    echo
    if ! rpm -q lsof > /dev/null; then
    echo
    echo -e "${BYellow}lsof${Color_Off}${BPurple} package is not installed. Installing...${Color_Off}"
    echo
    yum install lsof -y
    else
    echo
        echo -e "${BYellow}lsof${Color_Off}${BGreen} package is already installed. Skipping...${Color_Off}"
        echo
    fi
    
    sleep 1
    
    if ! rpm -q zip > /dev/null; then
    echo
        echo -e "${BYellow}zip${Color_Off}${BPurple} package is not installed. Installing...${Color_Off}"
        echo
        yum install zip -y
    else
    echo
        echo -e "${BYellow}zip${Color_Off}${BGreen} package is already installed. Skipping...${Color_Off}"
        echo
    fi
    
    sleep 1
    
    if ! rpm -q wget > /dev/null; then
    echo
        echo -e "${BYellow}wget${Color_Off}${BPurple} package is not installed. Installing...${Color_Off}"
        echo
        yum install wget -y
    else
    echo
        echo -e "${BYellow}wget${Color_Off}${BGreen} package is already installed. Skipping...${Color_Off}"
        echo
    fi
    
    sleep 1
    
    if ! rpm -q rsync > /dev/null; then
    echo
        echo -e "${BYellow}rsync${Color_Off}${BPurple} package is not installed. Installing...${Color_Off}"
        echo
        yum install rsync -y
    else
    echo
        echo -e "${BYellow}rsync${Color_Off}${BGreen} package is already installed. Skipping...${Color_Off}"
        echo
    fi
    
    sleep 1
    
    if ! rpm -q screen > /dev/null; then
    echo
        echo -e "${BYellow}screen${Color_Off}${BPurple} package is not installed. Installing...${Color_Off}"
        echo
        yum install screen -y
    else
    echo
        echo -e "${BYellow}screen${Color_Off}${BGreen} package is already installed. Skipping...${Color_Off}"
        echo
    fi

    echo
    echo
    ;;
    6)
    echo -e "${BGreen}---------2FA V2 Installer---------${Color_Off}"
    echo
    echo
    rm -f 2FAInstaller_V2.sh
    wget http://dashboard.revesecure.com/download/v2/2FAInstaller_V2.sh
    chmod a+x 2FAInstaller_V2.sh
    ./2FAInstaller_V2.sh
    echo
    echo
    ;;
    
    
    7)
    echo -e "${BGreen}---------Repository Update For CentOS 6---------${Color_Off}"
    echo
    echo
    yum repo:
    cd /etc/yum.repos.d/
    mv CentOS-Base.repo CentOS-Base.repo_$(date +%F)
    wget http://mirrors.cloud.tencent.com/repo/centos6_base.repo
    mv centos6_base.repo CentOS-Base.repo
    yum makecache
    echo
    echo
    ;;
    
    e)
    echo -e "${BPurple}Thanks${Color_Off}"
    echo
    break;
    ;;
    
    *)
    echo -e "${BRed}Please Enter Valid Serial NO.${Color_Off}"
    ;;
    esac

    done
    echo  
    ;;
    
    
    
    
    
    
    
    
    
   
    #-----------------------------------------------------------------------------------------------------------------
    e)
    echo -e "*${BRed}------------------------${Color_Off}${BYellow}EXIT${Color_Off}${BRed}------------------------------${Color_Off}*"
    echo
    ;;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    #-----------------------------------------------------------------------------------------------------------------
    SH)
    echo -e "${BGreen}*---------------CHECKING SERVER HEALTH---------------------*${Color_Off}"
    echo
    echo -e "${BGreen}---------Checking Memory---------${Color_Off}"
    free -m
    sleep 2
    echo -e "${BGreen}---------Checking Storage--------${Color_Off}"
    df -hT
    sleep 2
    echo -e "${BGreen}----------Checking CPU-----------${Color_Off}"
    top
    ;; 
    #-----------------------------------------------------------------------------------------------------------------
    
    
    
    
    
    
    
    
    
    HR)
    echo -e "${BGreen}Restarting All Services & Clear All Unwanted Log Files & Memory Free${Color_Off}"
    echo
    echo -e "${BGreen}Enter Your Oparator Code: ${Color_Off}"
    read opcode
    echo
    echo -e "${BGreen}Enter Your iTelSwitchPlus Name: ${Color_Off}"
    read sname
    echo 
    #-----------------------------------------------------------------------------------------------------------------   
    echo
    echo -e "${BYellow}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
    echo
    if [[ -z "$opcode" ]];
    then
    echo -e "${BRed}Skiping ByteSaver Log Delete Process....${Color_Off}"
    echo
    else
    echo -e "${BPurple}Deleting ByteSaver Log File.......... ${Color_Off}"
    echo
    cd /usr/local/ByteSaverSignalConverter$opcode/
    rm -f SignalingProxy.log.*
    cd /usr/local/ByteSaverSignalConverter$opcode/logs/
    rm -rf `date "+%Y"`*
    cd /usr/local/ByteSaverMediaProxy$opcode/
    rm -f MediaProxy.log.*
    cd /usr/local/ByteSaverMediaProxy$opcode/logs/
    rm -rf `date "+%Y"`*
    echo -e "${BRed}Deleted ByteSaver Log File Done. ${Color_Off}"
    fi
    
    sleep 3
    
    if [[ -z "$sname" ]];
    then
    echo -e "${BRed}Skiping Switch Log Delete Process....${Color_Off}"
    else
    echo
    echo -e "${BPurple}Deleting iTelSwitch Log File......... ${Color_Off}"
    echo
    cd /usr/local/iTelSwitchPlusSignaling$sname/
    rm -f iTelSwitchPlusSignaling.log.*
    cd /usr/local/iTelSwitchPlusMediaProxy$sname/
    rm -f iTelSwitchPlusMediaProxy.log.*
    echo -e "${BRed}Deleted iTelSwitch Log File Done. ${Color_Off}"
    fi
  
    sleep 3
    
    echo
    echo -e "${BYellow}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
    echo
    echo 
    
    

    until [[ $choice == e ]]
    do
    
    echo -e "${BGreen}Want To Reduce More? [y/n]${Color_Off}"
    read choice
    echo
    
    case $choice in
    y)
    cd /usr/local/ && ls | grep -e ByteSaver -e iTelSwitchPlus
    echo -e "${BGreen}Enter Another Oparator Code: ${Color_Off}"
    read opcode2
    echo
    echo -e "${BGreen}Enter Another iTelSwitchPlus Name: ${Color_Off}"
    read sname2
    echo   
    echo
    echo -e "${BYellow}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
    echo
    if [[ -z "$opcode2" ]];
    then
    echo -e "${BRed}Skiping ByteSaver Log Delete Process....${Color_Off}"
    echo
    else
    echo -e "${BPurple}Deleting ByteSaver Log File.......... ${Color_Off}"
    echo
    cd /usr/local/ByteSaverSignalConverter$opcode2/
    rm -f SignalingProxy.log.*
    cd /usr/local/ByteSaverSignalConverter$opcode2/logs/
    rm -rf `date "+%Y"`*
    cd /usr/local/ByteSaverMediaProxy$opcode2/
    rm -f MediaProxy.log.*
    cd /usr/local/ByteSaverMediaProxy$opcode2/logs/
    rm -rf `date "+%Y"`*
    echo -e "${BRed}Deleted ByteSaver Log File Done. ${Color_Off}"
    fi
    
    sleep 3
    
    if [[ -z "$sname2" ]];
    then
    echo -e "${BRed}Skiping Switch Log Delete Process....${Color_Off}"
    else
    echo
    echo -e "${BPurple}Deleting iTelSwitch Log File......... ${Color_Off}"
    echo
    cd /usr/local/iTelSwitchPlusSignaling$sname2/
    rm -f iTelSwitchPlusSignaling.log.*
    cd /usr/local/iTelSwitchPlusMediaProxy$sname2/
    rm -f iTelSwitchPlusMediaProxy.log.*
    echo -e "${BRed}Deleted iTelSwitch Log File Done. ${Color_Off}"
    fi
  
    sleep 3
    
    echo
    echo -e "${BGreen}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
    echo
    ;;
    *)
    echo -e "${BGreen}We Are Forward To The Next Step.${Color_Off}"
    echo
    break;
    ;;
    esac

    done
    
    
    #-----------------------------------------------------------------------------------------------------------------
    echo -e "${BCyan}Restarting Service--(ByteSaver)${Color_Off}"
    echo
    echo -e "${BPurple}ByteSaverSignalingConverter Shuting Down:${Color_Off}"
    sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh
    sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh
    sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh
    echo

    sleep 5

    sh /usr/local/ByteSaverSignalConverter$opcode/runByteSaverSignalConverter.sh
    echo

    sleep 5
    
    echo -e "${BPurple}ByteSaverMediaProxy Shuting Down:${Color_Off}"
    sh /usr/local/ByteSaverMediaProxy$opcode/shutdownByteSaverMediaProxy.sh
    sh /usr/local/ByteSaverMediaProxy$opcode/shutdownByteSaverMediaProxy.sh
    sh /usr/local/ByteSaverMediaProxy$opcode/shutdownByteSaverMediaProxy.sh
    echo

    sleep 5

    sh /usr/local/ByteSaverMediaProxy$opcode/runByteSaverMediaProxy.sh
    echo

    sleep 5

    #-----------------------------------------------------------------------------------------------------------------

    echo -e "${BCyan}Restarting Service--(iTelSwitchPlus)${Color_Off}"
    echo

    cd /usr/local/iTelSwitchPlusSignaling$sname/
    echo
    echo -e "${BYellow}Taking Backup Current Log4j File ${BRed}(SIGNALING)${Color_Off}${BYellow}_ _ _ _ _ ${Color_Off}"
    mv log4j.properties log4j.properties_$(date '+%YYr_%mMon_%dDay_%HHr_%MMin_%SSec')
    echo
    ls | grep -e log4j.properties_20
    echo
    sleep 2
    echo -e "${BCyan}Downloading New Log4j File_ _ _ _ _ _ _ _ ${Color_Off}"
    echo
    wget http://149.20.188.7/log4j.properties_signaling
    echo -e "${BGreen}Re-Naming_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ ${Color_Off}"    
    echo
    mv log4j.properties_signaling log4j.properties
    echo -e "${BCyan}Current Log4j File_ _ _ _ _ _ _ _ _ _ _ _${Color_Off}"
    echo
    ls --time=ctime -l log4j.properties
    sleep 2
    echo
    cd /usr/local/
    
    echo -e "${BPurple}iTelSwitchPlusSignaling Shuting Down:${Color_Off}"
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh   
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh
    echo

    sleep 5

    sh /usr/local/iTelSwitchPlusSignaling$sname/runiTelSwitchPlusSignaling.sh
    echo

    sleep 5
    cd /usr/local/iTelSwitchPlusMediaProxy$sname/
    echo
    echo -e "${BYellow}Taking Backup Current Log4j File ${BRed}(MEDIA)${Color_Off}${BYellow}_ _ _ _ _ ${Color_Off}"
    mv log4j.properties log4j.properties_$(date '+%YYr_%mMon_%dDay_%HHr_%MMin_%SSec')
    echo
    ls | grep -e log4j.properties_20
    echo
    sleep 2
    echo
    echo -e "${BCyan}Downloading New Log4j File_ _ _ _ _ _ _ _ ${Color_Off}"
    echo
    wget http://149.20.188.7/log4j.properties_media
    echo
    echo -e "${BGreen}Re-Naming_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ ${Color_Off}"
    echo
    mv log4j.properties_media log4j.properties
    echo -e "${BCyan}Current Log4j File_ _ _ _ _ _ _ _ _ _ _ _${Color_Off}"
    echo
    ls --time=ctime -l log4j.properties
    sleep 2
    echo
    cd /usr/local/
    echo -e "${BPurple}iTelSwitchPlusMediaProxy Shuting Down:${Color_Off}"
    sh /usr/local/iTelSwitchPlusMediaProxy$sname/shutdowniTelSwitchPlusMediaProxy.sh
    sh /usr/local/iTelSwitchPlusMediaProxy$sname/shutdowniTelSwitchPlusMediaProxy.sh
    sh /usr/local/iTelSwitchPlusMediaProxy$sname/shutdowniTelSwitchPlusMediaProxy.sh
    echo

    sleep 5

    sh /usr/local/iTelSwitchPlusMediaProxy$sname/runiTelSwitchPlusMediaProxy.sh
    echo

    sleep 5

    #-----------------------------------------------------------------------------------------------------------------
    echo
    echo -e "${BCyan}Tomcat Restarting.......${Color_Off}"
    echo
    echo -e "${BYellow}Please Wait for a while......${Color_Off}"
    echo
    service tomcat stop
    service tomcat stop
    service tomcat stop
    echo

    sleep 1

    ps -aux |grep jar
    echo

    sleep 5
    
    echo -e "${BCyan}Deleting Catalina .......${Color_Off}"
      
    cd /usr/local/jakarta-tomcat-7.0.61/work
    rm -rf Catalina
    
    sleep 3
    echo
    echo -e "${BRed}Want To Kill Process?${Color_Off}"
    read kp
    echo

    if [[ $kp == 'y' ]]
    then
    echo -e "${BGreen}Please Enter Proccess ID:${Color_Off}"
    read pid
    echo
    kill -9 $pid
    
    sleep 3
    
    echo -e "${BCyan}Deleting Catalina .......${Color_Off}"
    echo
  
    cd /usr/local/jakarta-tomcat-7.0.61/work
    rm -rf Catalina

    sleep 1
    echo
    echo -e $pid "${BGreen}Kill Done!${Color_Off}"
    echo
    
    sleep 1
    
    ps -aux |grep jar
    echo

	  sleep 3
    echo
    echo -e "${BGreen}Starting Tomcat......${Color_Off}"
    echo
    
    sleep 1
    
    service tomcat start
    echo

    ps -aux |grep jar
    echo
    
    sleep 2
    
    echo -e "${BGreen}Tomcat Restart Successfully!!!!!${Color_Off}"
    echo
    echo -e "${BYellow}Checking Server Startup Time.......${Color_Off}"
    echo
    
    cd /usr/local/jakarta-tomcat-7.0.61/logs
    tail -f catalina.out | grep 'Server startup'
    echo

    echo -e "${BGreen}Tomcat Restart Successfully!!!!!${Color_Off}"
    echo


    elif [[ $kp == 'n' ]]
    then
    
    sleep 2
    echo
    echo -e "${BGreen}Starting Tomcat......${Color_Off}"
    echo
    sleep 1
    
    service tomcat start
    echo

    ps -aux |grep jar
    echo     
    sleep 2
    
    echo -e "${BGreen}Tomcat Restart Successfully!!!!!${Color_Off}"
    echo
    
    
    echo
    #-----------------------------------------------------------------------------------------------------------------
    echo
    echo -e "${BGreen}----------------------Free Up Memory(RAM)-------------------${Color_Off}"
    free -m
    echo
    echo 1 > /proc/sys/vm/drop_caches
    echo
    echo -e "${BGreen}Memory Free Complete.${Color_Off}"
    echo
    free -m

    else
    echo -e "${BRed}Failed------${Color_Off}"
    fi
    echo
    echo -e "${BYellow}Checking Server Startup Time.......${Color_Off}"
    cd /usr/local/jakarta-tomcat-7.0.61/logs
    echo
    tail -f catalina.out | grep -m 'Server startup'
    echo
    ;;
    #-----------------------------------------------------------------------------------------------------------------
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    #-----------------------------------------------------------------------------------------------------------------
    SBC)
    echo -e "${BGreen}Restarting All Services & Clear All Unwanted Log Files & Memory Free${Color_Off}"
    echo
    echo -e "${BGreen}Enter Your iTelSBC Name: ${Color_Off}"
    read sbcname
    echo 

    #-----------------------------------------------------------------------------------------------------------------  

    if [[ -z "$sbcname" ]];
    then
    echo -e "${BRed}Skiping SBC Log Delete Process....${Color_Off}"
    else
    echo
    echo -e "${BPurple}Deleting iTelSBC Log File......... ${Color_Off}"
    echo
    cd /usr/local/iTelSBCSignaling$sbcname/
    rm -f iTelSwitchPlusSignaling-20*
    cd /usr/local/iTelSBCMediaProxy$sbcname/
    rm -f iTelSwitchPlusMediaProxy.log.*
    echo -e "${BRed}Deleted iTelSBC Log File Done. ${Color_Off}"
    fi
  
    sleep 3
    
    echo
    echo -e "${BYellow}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
    echo
    echo 
    
    

    until [[ $choice == e ]]
    do
    
    echo -e "${BGreen}Want To Reduce More? [y/n]${Color_Off}"
    read choice
    echo
    
    case $choice in
    y)
    cd /usr/local/ && ls | grep -e iTelSBC
    echo
    echo -e "${BGreen}Enter Another iTelSBC Name: ${Color_Off}"
    read sbcname2
    echo   
    echo
    echo -e "${BYellow}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
    echo
 
    if [[ -z "$sbcname2" ]];
    then
    echo -e "${BRed}Skiping SBC Log Delete Process....${Color_Off}"
    else
    echo
    echo -e "${BPurple}Deleting iTelSBC Log File......... ${Color_Off}"
    echo
    cd /usr/local/iTelSBCSignaling$sbcname/
    rm -f iTelSwitchPlusSignaling-20*
    cd /usr/local/iTelSBCMediaProxy$sbcname/
    rm -f iTelSwitchPlusMediaProxy.log.*
    echo -e "${BRed}Deleted iTelSBC Log File Done. ${Color_Off}"
    fi
  
    sleep 3
    
    echo
    echo -e "${BGreen}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
    echo
    ;;
    *)
    echo -e "${BGreen}We Are Forward To The Next Step.${Color_Off}"
    echo
    break;
    ;;
    esac

    done
    
    #-----------------------------------------------------------------------------------------------------------------

    echo -e "${BCyan}Restarting Service--(iTelSBC)${Color_Off}"
    echo
    if [[ -z "$sbcname" ]];
    then
    echo -e "${BRed}Skiping SBC Restart Process....${Color_Off}"
    else
    echo
    echo -e "${BPurple}Restarting iTelSBC......... ${Color_Off}"
    echo
    echo -e "${BPurple}iTelSBCSignaling Shuting Down:${Color_Off}"
    sh /usr/local/iTelSBCSignaling$sbcname/shutdowniTelSBCSignaling.sh
    sh /usr/local/iTelSBCSignaling$sbcname/shutdowniTelSBCSignaling.sh   
    sh /usr/local/iTelSBCSignaling$sbcname/shutdowniTelSBCSignaling.sh
    echo

    sleep 5

    sh /usr/local/iTelSBCSignaling$sbcname/runiTelSBCSignaling.sh
    echo

    sleep 5
    echo -e "${BPurple}iTelSBCMediaProxy Shuting Down:${Color_Off}"
    sh /usr/local/iTelSBCMediaProxy$sbcname/shutdowniTelSBCMediaProxy.sh
    sh /usr/local/iTelSBCMediaProxy$sbcname/shutdowniTelSBCMediaProxy.sh
    sh /usr/local/iTelSBCMediaProxy$sbcname/shutdowniTelSBCMediaProxy.sh
    echo

    sleep 5

    sh /usr/local/iTelSBCMediaProxy$sbcname/runiTelSBCMediaProxy.sh
    echo
    fi

    sleep 5

    #-----------------------------------------------------------------------------------------------------------------
    echo
    echo -e "${BCyan}Tomcat Restarting.......${Color_Off}"
    echo
    echo -e "${BYellow}Please Wait for a while......${Color_Off}"
    echo
    service tomcat stop
    service tomcat stop
    service tomcat stop
    echo

    sleep 1

    ps -aux |grep jar
    echo

    sleep 5
    
    echo -e "${BCyan}Deleting Catalina .......${Color_Off}"
      
    cd /usr/local/jakarta-tomcat-7.0.61/work
    rm -rf Catalina
    
    sleep 3
    echo
    echo -e "${BRed}Want To Kill Process?${Color_Off}"
    read kp
    echo

    if [[ $kp == 'y' ]]
    then
    echo -e "${BGreen}Please Enter Proccess ID:${Color_Off}"
    read pid
    echo
    kill -9 $pid
    
    sleep 3
    
    echo -e "${BCyan}Deleting Catalina .......${Color_Off}"
    echo
  
    cd /usr/local/jakarta-tomcat-7.0.61/work
    rm -rf Catalina

    sleep 1
    echo
    echo -e $pid "${BGreen}Kill Done!${Color_Off}"
    echo
    
    sleep 1
    
    ps -aux |grep jar
    echo

	  sleep 3
    echo
    echo -e "${BGreen}Starting Tomcat......${Color_Off}"
    echo
    
    sleep 1
    
    service tomcat start
    echo

    ps -aux |grep jar
    echo
    
    sleep 2
    
    echo -e "${BGreen}Tomcat Restart Successfully!!!!!${Color_Off}"
    echo
    echo -e "${BYellow}Checking Server Startup Time.......${Color_Off}"
    echo
    
    cd /usr/local/jakarta-tomcat-7.0.61/logs
    tail -f catalina.out | grep 'Server startup'
    echo

    echo -e "${BGreen}Tomcat Restart Successfully!!!!!${Color_Off}"
    echo


    elif [[ $kp == 'n' ]]
    then
    
    sleep 2
    echo
    echo -e "${BGreen}Starting Tomcat......${Color_Off}"
    echo
    sleep 1
    
    service tomcat start
    echo

    ps -aux |grep jar
    echo     
    sleep 2
    
    echo -e "${BGreen}Tomcat Restart Successfully!!!!!${Color_Off}"
    echo
    
    
    echo
    #-----------------------------------------------------------------------------------------------------------------
    echo
    echo -e "${BGreen}----------------------Free Up Memory(RAM)-------------------${Color_Off}"
    free -m
    echo
    echo 1 > /proc/sys/vm/drop_caches
    echo
    echo -e "${BGreen}Memory Free Complete.${Color_Off}"
    echo
    free -m

    else
    echo -e "${BRed}Failed------${Color_Off}"
    fi
    echo
    echo -e "${BYellow}Checking Server Startup Time.......${Color_Off}"
    cd /usr/local/jakarta-tomcat-7.0.61/logs
    echo
    tail -f catalina.out | grep -m 'Server startup'
    echo
    ;;
    #-----------------------------------------------------------------------------------------------------------------

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   

    
    
    
    
    
    
    
    
    #------------------------------------------------------TEST-----------------------------------------------------------
    T)
    echo "---------------------------HDD Reduce-----------------------"
    echo -e "${BGreen}Enter Your Oparator Code: ${Color_Off}"
    read opcode
    cd /usr/local/ByteSaverSignalConverter$opcode
    value=$( grep "Received from switch\|200 OK" /usr/local/ByteSaverSignalConverter$opcode/SignalingProxy.log )
    
    #tail -50 /usr/local/ByteSaverSignalConverter$opcode/SignalingProxy.log|grep 'Received from switch\|200 OK'

    if [[ $value -eq 1 ]]
    then
    echo
    echo -e "${BRed}!!!!!!!--------------- Register Successfully --------------!!!!!!!${Color_Off}"
    
    else
    echo -e "${BGreen}Not Register${Color_Off}"

    fi
    ;; 
    #-----------------------------------------------------------------------------------------------------------------      
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
     
    #-----------------------------------------------------------------------------------------------------------------  
    *)
    echo -e "${BRed}Please Enter Valid Serial NO.${Color_Off}"
    ;;
    #-----------------------------------------------------------------------------------------------------------------
    
esac

done

