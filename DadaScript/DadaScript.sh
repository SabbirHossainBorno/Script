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
echo -e "${BCyan}*************************************************************${Color_Off}${BYellow}[ All Switch & ByteSaver In This Server ]${Color_Off}${BCyan}**************************************************${Color_Off}"
echo
echo -e "${BGreen}iTelSwitch List: ${Color_Off}"
cd /usr/local/ && ls | grep -e iTelSwitchPlus
echo
echo -e "${BGreen}ByteSaver List: ${Color_Off}"
cd /usr/local/ && ls | grep -e ByteSaver
echo 
echo -e "${BCyan}***********************************************************************${Color_Off}${BYellow}[ END ]${Color_Off}${BCyan}**************************************************************************${Color_Off}"



#----------------------------------------------------Function-------------------------------------------------------------
        # Define the function for shutting down and restarting iTelSwitchPlusSignaling
        restart_iTelSwitchPlusSignaling() {
            echo
            echo -e "${BPurple}iTelSwitchPlusSignaling Shutting Down:${Color_Off}"
            for _ in {1..3}; do
                sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh
                sleep 2
            done
            echo
            nohup sh /usr/local/iTelSwitchPlusSignaling$sname/runiTelSwitchPlusSignaling.sh >> /dev/null 2>&1 &
            sleep 8
            echo
        }
        # Define the function for shutting down and restarting iTelSwitchPlusMediaProxy
        restart_iTelSwitchPlusMediaProxy() {
            echo
            echo -e "${BPurple}iTelSwitchPlusMediaProxy Shutting Down:${Color_Off}"
            for _ in {1..3}; do
                sh /usr/local/iTelSwitchPlusMediaProxy$sname/shutdowniTelSwitchPlusMediaProxy.sh
                sleep 2
            done
            echo
            nohup sh /usr/local/iTelSwitchPlusMediaProxy$sname/runiTelSwitchPlusMediaProxy.sh >> /dev/null 2>&1 &

            sleep 5
            echo
        }
        # Define the function for Server Security
        server_security() {
            echo
            echo
            cd
            rm -rf ServerSecurity.sh
            wget http://149.20.188.102:70/ServerSecurity.sh
            chmod a+x ServerSecurity.sh
            sh ServerSecurity.sh
            echo
            echo
        }
        # Function to gracefully handle termination
        cleanup() {
        echo "Script is terminating..."
        # ... Implement cleanup actions, such as stopping services ...
        exit 0
        }
        # Function to view log file for 10 seconds and then exit
        view_log() {
        log_file_signaling="/usr/local/iTelSwitchPlusSignaling$sname/iTelSwitchPlusSignaling.log"
        log_file_media="/usr/local/iTelSwitchPlusMediaProxy$sname/iTelSwitchPlusMediaProxy.log"
        
        echo -e "${BCyan}Viewing Log Both Sigmaling And Media For 10 Seconds...${Color_Off}"
        echo
        echo
        timeout 10 tail -f "$log_file_signaling"
        echo -e "${BCyan}\nExiting Signaling Log...${Color_Off}"
        echo
        timeout 10 tail -f "$log_file_media"
        echo -e "${BCyan}\nExiting Media Log...${Color_Off}"
        echo
        }


#----------------------------------------------------QUIT-------------------------------------------------------------


timeout_duration=60  # Timeout in seconds


while true; do
echo
echo -e "*-----------${BIPurple}Which Service Do You Want To Perform?${Color_Off}----------*"
echo -e "*${BCyan}-------------------------${Color_Off}${BRed}******${Color_Off}${BCyan}---------------------------${Color_Off}*"
echo -e "*${BBlue}[1]${Color_Off}--------${BGreen}iTelSwitch Modification${Color_Off}                        *"
echo -e "*${BBlue}[2]${Color_Off}--------${BGreen}Server Password Change${Color_Off}                         *"
echo -e "*${BBlue}[3]${Color_Off}--------${BGreen}Check Calls${Color_Off}                                    *"
echo -e "*${BBlue}[4]${Color_Off}--------${BGreen}Check Log${Color_Off}                                      *"
echo -e "*${BCyan}-------------------------${Color_Off}${BRed}******${Color_Off}${BCyan}---------------------------${Color_Off}*"
echo -e "${BCyan}--------------------${Color_Off}${BIPurple}PRESS [e] FOR EXIT${Color_Off}${BCyan}----------------------${Color_Off}"
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
    
    #----------------------------------------------------Switch-------------------------------------------------------------
    1)
    echo -e "${BGreen}iTelSwitch List: ${Color_Off}"
    cd /usr/local/ && ls | grep -e iTelSwitchPlus | sed 's/iTelSwitchPlus//; s/MediaProxy//; s/Signaling//' | sort | uniq | cat -n
    echo
    echo -e "${BCyan}Restarting Service--(iTelSwitchPlus)${Color_Off}"
    echo
    echo -e "${BGreen}Enter Your iTelSwitchPlus Name: ${Color_Off}"
    read sname
    echo
    # Check if the log4j.properties_2023Yr file exists(Signaling)
    cd /usr/local/iTelSwitchPlusSignaling$sname/
    echo -e "${BCyan}iTelSwitchPlus(Signaling)${Color_Off}"
    echo
    echo -e "${BRed}Removing Signaling Log_ _ _ _ _ _ _ ${Color_Off}"
    sleep 1
    rm -rf iTelSwitchPlusSignaling.log.2023-0* iTelSwitchPlusSignaling.log.2022-0*
    sleep 2
    echo
    if ls | grep -q "log4j.properties_2023Yr"; then
        echo -e "${BRed}N.B: Found Backup log4j.properties File.${Color_Off}"
        echo
        echo -e "${BYellow}Skipping Backup & Download For New log4j File.${Color_Off}"
        # Call the function to restart iTelSwitchPlusMediaProxy
        cd /usr/local/
        restart_iTelSwitchPlusSignaling
    else
        # Backup the existing log4j.properties file
        echo -e "${BYellow}Taking Backup Old log4j File.${Color_Off}"
        mv log4j.properties "log4j.properties_$(date '+%YYr_%mMon_%dDay_%HHr_%MMin_%SSec')"
        echo
        echo -e "${BCyan}Backed Up log4j.properties To:${Color_Off}"
        ls | grep -e "log4j.properties_20"
        echo
        sleep 2

        # Download the new log4j.properties file
        echo
        echo -e "${BCyan}Downloading New Log4j File. ${Color_Off}"
        echo
        wget http://149.20.188.7/log4j.properties_signaling
        echo
        echo -e "${BGreen}Re-Naming. ${Color_Off}"
        echo
        mv log4j.properties_signaling log4j.properties
        echo -e "${BCyan}Current Log4j File_ _ _ _ _ _ _ _ _ _ _ _${Color_Off}"
        echo
        ls --time=ctime -l log4j.properties
        echo

        # Call the function to restart iTelSwitchPlusMediaProxy
        cd /usr/local/
        restart_iTelSwitchPlusSignaling
    fi

    # Check if the log4j.properties_2023Yr file exists
    cd /usr/local/iTelSwitchPlusMediaProxy$sname/
    echo -e "${BCyan}iTelSwitchPlus(MediaProxy)${Color_Off}"
    echo
    echo -e "${BRed}Removing Media Log_ _ _ _ _ _ _ ${Color_Off}"
    sleep 1
    rm -rf iTelSwitchPlusMediaProxy.log.2023-0* rm -rf iTelSwitchPlusMediaProxy.log.2022-0*
    sleep 2
    echo
    if ls | grep -q "log4j.properties_2023Yr"; then
        echo -e "${BRed}N.B: Found Backup log4j.properties File.${Color_Off}"
        echo
        echo -e "${BYellow}Skipping Backup & Download For New log4j File.${Color_Off}"
        # Call the function to restart iTelSwitchPlusMediaProxy
        restart_iTelSwitchPlusMediaProxy
    else
        # Backup the existing log4j.properties file
        echo -e "${BYellow}Taking Backup Old log4j File.${Color_Off}"
        mv log4j.properties "log4j.properties_$(date '+%YYr_%mMon_%dDay_%HHr_%MMin_%SSec')"
        echo
        echo -e "${BCyan}Backed Up log4j.properties To:${Color_Off}"
        ls | grep -e "log4j.properties_20"
        echo
        sleep 2

        # Download the new log4j.properties file
        echo
        echo -e "${BCyan}Downloading New Log4j File. ${Color_Off}"
        echo
        wget http://149.20.188.7/log4j.properties_media
        echo
        echo -e "${BGreen}Re-Naming. ${Color_Off}"
        echo
        mv log4j.properties_media log4j.properties
        echo -e "${BCyan}Current Log4j File_ _ _ _ _ _ _ _ _ _ _ _${Color_Off}"
        echo
        ls --time=ctime -l log4j.properties
        echo

        # Call the function to restart iTelSwitchPlusMediaProxy
        restart_iTelSwitchPlusMediaProxy
    fi

    ps -aux |grep iTelSwitchPlus
    echo

    ;;

    #-----------------------------------------------------------------------------------------------------------------
    2)
    server_security
    ;;
    
    #-----------------------------------------------------------------------------------------------------------------
    3)
    #-------------------------------------------------------RunningCall-----------------------------------------------------
    echo
    echo -e "${BGreen}---------Running Calls & Connected Calls---------${Color_Off}"
    cd /usr/local/ && ls | grep -e iTelSwitchPlus | sed 's/iTelSwitchPlus//; s/MediaProxy//; s/Signaling//' | sort | uniq | cat -n
    echo
    echo -e "${BGreen}Enter Switch Name:${Color_Off}"
    read sname
    echo
    cd /usr/local/jakarta-tomcat-7.0.61/webapps/ && ls
    echo
    echo -e "${BGreen}Enter Billing Name : ${Color_Off}"
    read billingname
    echo
    cat /usr/local/jakarta-tomcat-7.0.61/webapps/$billingname/WEB-INF/classes/*.xml
    echo
    echo -e "${BGreen}Enter Database Name : ${Color_Off}"
    read dbname
    echo
    # SQL query to retrieve the count
    SQL_QUERY="SELECT COUNT(*) FROM vbRunningCall WHERE connectTime > 1;"

    for ((i = 1; i <= 10; i++)); do
        query_result=$(mysql -u root -D"$dbname" -s -N -e "$SQL_QUERY")
        #echo -e "${BGreen}--------- Checking Time $i ---------${Color_Off}"
        echo -e "${BGreen}-----Checking Total Running Calls------${Color_Off}"
        echo
        echo -e "${BYellow}Total Connected Calls: ${Color_Off} ${BRed}$query_result${Color_Off}"
        echo
        sleep 1  # Wait for 1 seconds before the next iteration
    done
    echo -e "${BGreen}-----Checking Total Running Calls------${Color_Off}"
    echo
    timeout 10s tail -f /usr/local/iTelSwitchPlusSignaling$sname/iTelSwitchPlusSignaling.log | grep --color=auto 'Total Running' -i
    echo
    ;;
    #---------------------------------------------------------Finish--------------------------------------------------------    
    
    #----------------------------------------------------ByteSaver-------------------------------------------------------------
    T)  
    echo
    echo
    echo -e "${BGreen}ByteSaver List: ${Color_Off}"
    cd /usr/local/ && ls | grep -e ByteSaver
    echo 
    echo
    echo -e "${BGreen}Enter Your OpCode: ${Color_Off}"
    echo
    read opcode
    echo
    cd /usr/local/ByteSaverSignalConverter$opcode/logs
    echo -e "${BRed}Removing Signaling Log_ _ _ _ _ _ _ ${Color_Off}"
    sleep 1
    rm -rf 20*
    cd ../
    sleep 2
    echo
    echo -e "${BYellow}Taking Backup Current Log4j File_ _ _ _ _ ${Color_Off}"
    mv log4j2.properties log4j2.properties_$(date '+%YYr_%mMon_%dDay_%HHr_%MMin_%SSec')
    echo
    ls | grep -e log4j2.properties_20
    echo
    sleep 2
    echo
    echo -e "${BCyan}Downloading New Log4j File_ _ _ _ _ _ _ ${Color_Off}"
    echo
    wget http://149.20.188.7/log4j2.properties_BS_siganling
    echo
    echo -e "${BGreen}Renaming_ _ _ _ _ _ _ ${Color_Off}"    
    echo
    mv log4j2.properties_BS_siganling log4j2.properties
    echo -e "${BCyan}Current Log4j File_ _ _ _ _ _ _ ${Color_Off}"
    echo
    ls --time=ctime -l log4j2.properties
    sleep 2
    echo
    
    config_file="/usr/local/ByteSaverSignalConverter$opcode/server.cfg"
    
    # Check if the file exists
    if [ -f "$config_file" ]; then
    # Update the debug value to 1
    sed -i 's/debug=0/debug=1/' "$config_file"
    echo -e "${BGreen}Debug Value Updated To 1. ${Color_Off}"
    echo
    else
    echo
    echo "${BRed}Error: server.cfg File Does Not Exist.${Color_Off}"
    echo
    fi
    
 
    cd /usr/local/
    echo -e "${BCyan}Restarting ByteSaverSignaling${Color_Off}"
    echo
    echo -e "${BPurple}ByteSaverSignaling Shuting Down:${Color_Off}"
    echo
    sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh
    sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh
    sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh
    echo

    sleep 2

    sh /usr/local/ByteSaverSignalConverter$opcode/runByteSaverSignalConverter.sh
    echo

    sleep 5

    echo

    ps -aux|grep ByteSaverSignalConverter
    
    echo
    echo
    
    sleep 3
    
    echo -e "${BRed}Running ByteSaverSignaling Log (For 10s)_ _ _ _ _ _ _ ${Color_Off}"
    
    cd /usr/local/ByteSaverSignalConverter$opcode/
    
    timeout 10s tail -f SignalingProxy.log
    
    echo
    echo

    ;;
    #-----------------------------------------------------------------------------------------------------------------
    4)
    echo -e "${BGreen}iTelSwitch List: ${Color_Off}"
    cd /usr/local/ && ls | grep -e iTelSwitchPlus | sed 's/iTelSwitchPlus//; s/MediaProxy//; s/Signaling//' | sort | uniq | cat -n
    echo
    echo -e "${BGreen}Enter Your iTelSwitchPlus Name: ${Color_Off}"
    read sname
    echo
    view_log
    ;;

    e)
      #-----------------------------------------------------------------------------------------------------------------
      echo
      echo -e "*${BRed}------------* THANKS FOR USING THIS SCRIPT *--------------${Color_Off}*"
      echo
      echo -e "*${BRed}-------------------------${Color_Off}${BYellow}EXIT${Color_Off}${BRed}-----------------------------${Color_Off}*"
      echo
      break
      ;;
    *)
    echo -e "${BRed}Please Enter Valid Serial NO.${Color_Off}"
    ;;
    #-----------------------------------------------------------------------------------------------------------------
    
esac

done
