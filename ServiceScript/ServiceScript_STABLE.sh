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
echo -e "${BIRed}SERVICE SCRIPT(2.3.0)${Color_Off}"
echo -e "${BRed}TODAY                : ${Color_Off}${BYellow}`date +"%d-%m-%Y"` ${Color_Off}"
echo -e "${BRed}LAST UPDATE          : ${Color_Off}${BYellow}24-10-2022 ${Color_Off}"
echo -e "${BRed}PREVIOUS IMPLEMENTED : ${Color_Off}${BYellow}HDD REDUCE ${Color_Off}"
echo -e "${BRed}LAST IMPLEMENTED     : ${Color_Off}${BYellow}BILLING ACCESS CHANGE ${Color_Off}"
echo -e "${BRed}IMPLEMENTED BY MD. SABBIR HOSSAIN BORNO ${Color_Off}"
echo -e "${BRed}SOFTWARE SUPPORT ENGINEER ${Color_Off}"
echo -e "${BRed}REVE SYSTEMS ${Color_Off}"



echo
echo
echo -e "${BCyan}*************************************************************${Color_Off}${BYellow}[ DETAILS---USR->LOCAL ]${Color_Off}${BCyan}**********************************************************************${Color_Off}"
echo
cd /usr/local/
ls
echo 
echo -e "${BCyan}***********************************************************************${Color_Off}${BYellow}[ END ]${Color_Off}${BCyan}*****************************************************************************${Color_Off}"
echo  
echo
until [[ $option == e ]]
do

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
echo -e "*${BBlue}[5]${Color_Off}--------${BGreen}ALL SERVICES (ByteSaver,Switch,Tomcat)${Color_Off}         *"
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
echo -e "*${BCyan}------------------------${Color_Off}${URed}UPCOMING${Color_Off}${BCyan}--------------------------${Color_Off}*"
echo -e "*${BRed}[*]${Color_Off}--------${BRed}Demo ByteSaver Installation${Color_Off}                    *"
echo -e "*${BRed}[*]${Color_Off}--------${BRed}Replication Broken${Color_Off}                             *"
echo -e "*${BCyan}-------------------------${Color_Off}${URed}UPDATER${Color_Off}${BCyan}--------------------------${Color_Off}*"
echo -e "*${BIPurple}What You Wnat To Update???${Color_Off}                                *"
echo -e "*${BRed}[*]${Color_Off}--------${BRed}ByteSaver 2.4.5${Color_Off}                                *"
echo -e "*${BCyan}-------------------------${Color_Off}${BRed}******${Color_Off}${BCyan}---------------------------${Color_Off}*"
echo -e "${BCyan}--------------------${Color_Off}${BIPurple}PRESS [e] FOR EXIT${Color_Off}${BCyan}----------------------${Color_Off}"
echo 
echo -e "${BCyan}---------------${Color_Off}${BIPurple}PRESS [SH] FOR SERVER HEALTH${Color_Off}${BCyan}-----------------${Color_Off}"
echo
echo -e "${BCyan}PRESS & ENTER PLEASE:${Color_Off} " 
echo
read option

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
    echo -e "${BPurple}iTelSwitchPlusSignaling Shuting Down:${Color_Off}"
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh
    echo

    sleep 2

    sh /usr/local/iTelSwitchPlusSignaling$sname/runiTelSwitchPlusSignaling.sh
    echo

    sleep 5
    echo
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
    echo -e "${BGreen}Restarting All Services${Color_Off}"
    echo
    echo -e "${BCyan}Restarting Service--(ByteSaver)${Color_Off}"
    echo
    echo -e "${BGreen}Enter Your Oparator Code: ${Color_Off}"
    read opcode
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
    echo -e "${BGreen}Enter Your iTelSwitchPlus Name: ${Color_Off}"
    read sname
    echo

    echo -e "${BPurple}iTelSwitchPlusSignaling Shuting Down:${Color_Off}"
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh   
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh
    echo

    sleep 5

    sh /usr/local/iTelSwitchPlusSignaling$sname/runiTelSwitchPlusSignaling.sh
    echo

    sleep 5
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
    
    echo -e "${BYellow}Checking Server Startup Time.......${Color_Off}"
    echo
    
    cd /usr/local/jakarta-tomcat-7.0.61/logs
    tail -f catalina.out | grep 'Server startup'
    echo

    else
    echo -e "${BRed}Failed------${Color_Off}"
    fi
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
    echo "---------------------------HDD Reduce-----------------------"
    echo -e "${BGreen}Enter Your Oparator Code: ${Color_Off}"
    read opcode
    echo -e "${BGreen}Enter Your iTelSwitchPlus Name: ${Color_Off}"
    read sname
    echo
    echo -e "${BGreen}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
    echo
    echo -e "${BGreen}Deleting ByteSaver Log File.......... ${Color_Off}"
    cd /usr/local/ByteSaverSignalConverter$opcode/
    rm -f SignalingProxy.log.*
    cd /usr/local/ByteSaverSignalConverter$opcode/logs/
    rm -rf `date "+%Y"`*
    cd /usr/local/ByteSaverMediaProxy$opcode/
    rm -f MediaProxy.log.*
    cd /usr/local/ByteSaverMediaProxy$opcode/logs/
    rm -rf `date "+%Y"`*
    echo -e "${BGreen}Deleted ByteSaver Log File Done. ${Color_Off}"
    
    sleep 3
    
    
    echo
    echo -e "${BGreen}Deleting iTelSwitch Log File......... ${Color_Off}"
    cd /usr/local/iTelSwitchPlusSignaling$sname/
    rm -f iTelSwitchPlusSignaling.log.*
    cd /usr/local/iTelSwitchPlusMediaProxy$sname/
    rm -f iTelSwitchPlusMediaProxy.log.*
    echo -e "${BGreen}Deleted iTelSwitch Log File Done. ${Color_Off}"
  
    sleep 3
    
    echo
    echo -e "${BGreen}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
    echo
    echo -e "${BGreen}Want To GZIP From (var/lib/mysql)? [y/n]${Color_Off}"
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
    echo -e "${BGreen}Please Enter mysql-bin-serial${Color_Off}"
    read serial
    gzip $serial
    
    echo
    echo -e "${BGreen}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
    else
    echo -e "${BGreen}Thanks For Your Choice!!${Color_Off}"
    echo
    echo -e "${BGreen}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
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
    *)
    echo -e "${BRed}Please Enter Valid Serial NO.${Color_Off}"
    ;;
    #-----------------------------------------------------------------------------------------------------------------
    
esac

done
