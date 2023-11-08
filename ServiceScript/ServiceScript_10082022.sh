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
echo
echo -e "${BCyan}**************************************************************${Color_Off}${BYellow}[ DETAILS---USR->LOCAL ]${Color_Off}${BCyan}************************************************************************${Color_Off}"
echo
cd /usr/local/
ls
echo 
echo -e "${BCyan}************************************************************************${Color_Off}${BYellow}[ END ]${Color_Off}${BCyan}*******************************************************************************${Color_Off}"
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
echo -e "*${BCyan}------------------------${Color_Off}${URed}UPCOMING${Color_Off}${BCyan}--------------------------${Color_Off}*"
echo -e "*${BRed}[*]${Color_Off}--------${BRed}Storage Space Reduce${Color_Off}                           *"
echo -e "*${BRed}[*]${Color_Off}--------${BRed}Memory Free${Color_Off}                                    *"
echo -e "*${BRed}[*]${Color_Off}--------${BRed}Billing Password Change${Color_Off}                        *"
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
    1)
    echo "Restarting Service--(ByteSaver)"
    echo "Enter Your Oparator Code: "
    read opcode

    echo "ByteSaverSignalingConverter Shuting Down:"
    sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh
    sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh
    sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh

    sleep 5

    sh /usr/local/ByteSaverSignalConverter$opcode/runByteSaverSignalConverter.sh

    sleep 5

    echo "ByteSaverMediaProxy Shuting Down:"
    sh /usr/local/ByteSaverMediaProxy$opcode/shutdownByteSaverMediaProxy.sh
    sh /usr/local/ByteSaverMediaProxy$opcode/shutdownByteSaverMediaProxy.sh
    sh /usr/local/ByteSaverMediaProxy$opcode/shutdownByteSaverMediaProxy.sh

    sleep 2

    sh /usr/local/ByteSaverMediaProxy$opcode/runByteSaverMediaProxy.sh

    sleep 8

    ps -aux |grep ByteSaver
    ;;

    BS)
    echo "Restarting Service--(ByteSaverSignalConverter)"
    echo "Enter Your Oparator Code: "
    read opcode

    echo "ByteSaverSignalingConverter Shuting Down:"
    sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh
    sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh    
    sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh

    sleep 2
    
    sh /usr/local/ByteSaverSignalConverter$opcode/runByteSaverSignalConverter.sh
    
    sleep 8

    ps -aux |grep ByteSaverSignalConverter
    ;;

    BM)
    echo "Restarting Service--(ByteSaverMediaProxy)"
    echo "Enter Your Oparator Code: "
    read opcode

    echo "ByteSaverMediaProxy Shuting Down:"
    sh /usr/local/ByteSaverMediaProxy$opcode/shutdownByteSaverMediaProxy.sh
    sh /usr/local/ByteSaverMediaProxy$opcode/shutdownByteSaverMediaProxy.sh
    sh /usr/local/ByteSaverMediaProxy$opcode/shutdownByteSaverMediaProxy.sh

    sleep 2

    sh /usr/local/ByteSaverMediaProxy$opcode/runByteSaverMediaProxy.sh

    sleep 8

    ps -aux |grep ByteSaverMediaProxy
    ;;

    2)
    echo "Restarting Service--(iTelSwitchPlus)"
    echo "Enter Your iTelSwitchPlus Name: "
    read sname

    echo "iTelSwitchPlusSignaling Shuting Down:"
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh

    sleep 2

    sh /usr/local/iTelSwitchPlusSignaling$sname/runiTelSwitchPlusSignaling.sh

    sleep 5

    echo "iTelSwitchPlusMediaProxy Shuting Down:"
    sh /usr/local/iTelSwitchPlusMediaProxy$sname/shutdowniTelSwitchPlusMediaProxy.sh
    sh /usr/local/iTelSwitchPlusMediaProxy$sname/shutdowniTelSwitchPlusMediaProxy.sh
    sh /usr/local/iTelSwitchPlusMediaProxy$sname/shutdowniTelSwitchPlusMediaProxy.sh

    sleep 2

    sh /usr/local/iTelSwitchPlusMediaProxy$sname/runiTelSwitchPlusMediaProxy.sh

    sleep 8

    ps -aux |grep iTelSwitchPlus

    ;;

    SS)
    echo "Restarting Service--(iTelSwitchPlusSignaling)"
    echo "Enter Your iTelSwitchPlus Name: "
    read sname

    echo "iTelSwitchPlusSignaling Shuting Down:"
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh

    sleep 2

    sh /usr/local/iTelSwitchPlusSignaling$sname/runiTelSwitchPlusSignaling.sh

    sleep 8

    ps -aux |grep iTelSwitchPlus
    ;;

    SM)
    echo "Restarting Service--(iTelSwitchPlusSignaling)"
    echo "Enter Your Switch Name: "
    read sname

    echo "iTelSwitchPlusMediaProxy Shuting Down:"
    sh /usr/local/iTelSwitchPlusMediaProxy$sname/shutdowniTelSwitchPlusMediaProxy.sh
    sh /usr/local/iTelSwitchPlusMediaProxy$sname/shutdowniTelSwitchPlusMediaProxy.sh
    sh /usr/local/iTelSwitchPlusMediaProxy$sname/shutdowniTelSwitchPlusMediaProxy.sh

    sleep 2

    sh /usr/local/iTelSwitchPlusMediaProxy$sname/runiTelSwitchPlusMediaProxy.sh
    
    sleep 8

    ps -aux |grep iTelSwitchPlus
    ;;

    3)
    
    
    
    
    echo "Tomcat Restarting......."
    echo "Please Wait for a while......"
    service tomcat stop
    service tomcat stop
    service tomcat stop

    sleep 1

    ps -aux |grep jar

    sleep 5
    
    echo "Deleting Catalina ......."
    
    cd /usr/local/jakarta-tomcat-9.0.17/work  
    cd /usr/local/jakarta-tomcat-7.0.61/work
    rm -rf Catalina
    
    sleep 3

    echo "Want To Kill Process?"
    read kp

    if [[ $kp == 'y' ]]
    then
    echo "Please Enter Proccess ID:"
    read pid
    kill -9 $pid
    
    sleep 3
    
    echo $pid "Kill Done!"
    
    sleep 1
    
    ps -aux |grep jar

	  sleep 3

    echo "Starting Tomcat......"
    
    sleep 1
    
    service tomcat start

    ps -aux |grep jar

    echo "Tomcat Restart Successfully!!!!!"


    elif [[ $kp == 'n' ]]
    then
    
    sleep 2

    echo "Starting Tomcat......"
    
    sleep 1
    
    service tomcat start

    ps -aux |grep jar
    echo     
    sleep 2
    
    echo "Tomcat Restart Successfully!!!!!"
    
    echo "Checking Server Startup Time......."
    
    cd /usr/local/jakarta-tomcat-7.0.61/logs
    cd /usr/local/jakarta-tomcat-9.0.17/logs
    tail -f catalina.out | grep 'Server startup'
    
    sleep 5
    
    echo "45454"

    else
    echo Failed------
    fi
    ;;
    
    4)
    echo "Apache Restarting......."
    echo "Please Wait for a while......"
    service apache stop
    service apache stop
    service apache stop

    sleep 5

    ps -aux |grep jar

    sleep 5

    echo "Want To Kill Process?"
    read kp

    if [[ $kp == 'y' ]]
    then
    echo "Please Enter Proccess ID:"
    read pid
    kill -9 $pid

    sleep 5

    echo $pid "Kill Done!"
    
    sleep 1
    
    ps -aux |grep jar

	  sleep 2

    echo "Starting Apache......"
    
    sleep 1
    
    service apache start
    
    sleep 2
    
    echo "Apache Restart Successfully!!!!!"
    
    sleep 2

    ps -aux |grep jar

    
    elif [[ $kp == 'n' ]]
    then

    sleep 3

    echo "Starting Apache......"
    
    sleep 1
    
    service apache start

    ps -aux |grep jar

    echo "Apache Restart Successfully!!!!!"

    else
    echo Failed------
    fi
    ;;


    5)
    #-----------------------------------------------------------------------------------------------------------------
    echo "Restarting All Services"
    echo "Restarting Service--(ByteSaver)"
    echo "Enter Your Oparator Code: "
    read opcode

    sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh
    sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh
    echo "ByteSaverSignalingConverter Shuting Down:"
    sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh

    sleep 5

    sh /usr/local/ByteSaverSignalConverter$opcode/runByteSaverSignalConverter.sh

    sleep 5

    sh /usr/local/ByteSaverMediaProxy$opcode/shutdownByteSaverMediaProxy.sh
    sh /usr/local/ByteSaverMediaProxy$opcode/shutdownByteSaverMediaProxy.sh
    echo "ByteSaverMediaProxy Shuting Down:"
    sh /usr/local/ByteSaverMediaProxy$opcode/shutdownByteSaverMediaProxy.sh

    sleep 5

    sh /usr/local/ByteSaverMediaProxy$opcode/runByteSaverMediaProxy.sh

    sleep 5

    #-----------------------------------------------------------------------------------------------------------------

    echo "Restarting Service--(iTelSwitchPlus)"
    echo "Enter Your iTelSwitchPlus Name: "
    read sname

    echo "iTelSwitchPlusSignaling Shuting Down:"
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh   
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh

    sleep 5

    sh /usr/local/iTelSwitchPlusSignaling$sname/runiTelSwitchPlusSignaling.sh

    sleep 5
    echo "iTelSwitchPlusMediaProxy Shuting Down:"
    sh /usr/local/iTelSwitchPlusMediaProxy$sname/shutdowniTelSwitchPlusMediaProxy.sh
    sh /usr/local/iTelSwitchPlusMediaProxy$sname/shutdowniTelSwitchPlusMediaProxy.sh
    sh /usr/local/iTelSwitchPlusMediaProxy$sname/shutdowniTelSwitchPlusMediaProxy.sh

    sleep 5

    sh /usr/local/iTelSwitchPlusMediaProxy$sname/runiTelSwitchPlusMediaProxy.sh

    sleep 5

    #-----------------------------------------------------------------------------------------------------------------

    echo "Tomcat Restarting......."
    echo "Please Wait for a while......"
    service tomcat stop
    service tomcat stop
    service tomcat stop

    sleep 1

    ps -aux |grep jar

    sleep 5
    
    echo "Deleting Catalina ......."
    
    cd /usr/local/jakarta-tomcat-9.0.17/work  
    cd /usr/local/jakarta-tomcat-7.0.61/work
    rm -rf Catalina
    
    sleep 3

    echo "Want To Kill Process?"
    read kp

    if [[ $kp == 'y' ]]
    then
    echo "Please Enter Proccess ID:"
    read pid
    kill -9 $pid
    
    sleep 3
    
    echo "Deleting Catalina ......."
    
    cd /usr/local/jakarta-tomcat-9.0.17/work  
    cd /usr/local/jakarta-tomcat-7.0.61/work
    rm -rf Catalina

    sleep 1

    echo $pid "Kill Done!"
    
    sleep 1
    
    ps -aux |grep jar

	  sleep 3

    echo "Starting Tomcat......"
    
    sleep 1
    
    service tomcat start

    ps -aux |grep jar

    echo "Tomcat Restart Successfully!!!!!"


    elif [[ $kp == 'n' ]]
    then
    
    sleep 2

    echo "Starting Tomcat......"
    
    sleep 1
    
    service tomcat start

    ps -aux |grep jar
    echo     
    sleep 2
    
    echo "Tomcat Restart Successfully!!!!!"
    
    echo "Checking Server Startup Time......."
    
    cd /usr/local/jakarta-tomcat-7.0.61/logs
    cd /usr/local/jakarta-tomcat-9.0.17/logs
    tail -f catalina.out | grep 'Server startup'

    else
    echo Failed------
    fi
    #-----------------------------------------------------------------------------------------------------------------
    ;;
    6)
    echo "---------Checking Memory---------"
    free -m
    ;;
    7)
    echo "---------Checking Storage---------"
    df -hT
    ;;
    8)
    echo "---------Checking CPU---------"
    top
    ;;
    9)
    echo "Enter Switch Name:"
    echo
    read sname
    echo
    echo "--------------------Checking Running Call-------------------"
    tail -f /usr/local/iTelSwitchPlusSignaling$sname/iTelSwitchPlusSignaling.log | grep 'Total Running' -i
    sleep 1
    echo "Done"
    ;; 
    10)
    echo
    echo "--------------------Checking Running Proccess---------------"
    ps -aux|grep jar
    sleep 5
    ;;    
    e)
    echo -e "*${BRed}------------------------${Color_Off}${BYellow}EXIT${Color_Off}${BRed}------------------------------${Color_Off}*"
    echo
    ;;
    SH)
    echo "*---------------CHECKING SERVER HEALTH---------------------*"
    echo
    echo "---------Checking Memory---------"
    free -m
    sleep 2
    echo "---------Checking Storage--------"
    df -hT
    sleep 2
    echo "----------Checking CPU-----------"
    top
    ;;    
    *)
    echo "Please Enter Valid Serial NO."
    ;;

esac

done