#!/bin/bash

# Define colors
Color_Off='\033[0m'
BPurple='\033[1;35m'



echo -e "${BCyan}Restarting Service--(iTelSwitchPlus)${Color_Off}"
            echo
            echo -e "${BGreen}Enter Your iTelSwitchPlus Name: ${Color_Off}"
            read sname
            echo



# Define the function for shutting down and restarting iTelSwitchPlusMediaProxy
restart_iTelSwitchPlusMediaProxy() {
    echo
    cd /usr/local/
    echo -e "${BPurple}iTelSwitchPlusMediaProxy Shutting Down:${Color_Off}"
    for _ in {1..3}; do
        sh /usr/local/iTelSwitchPlusMediaProxy$sname/shutdowniTelSwitchPlusMediaProxy.sh
        sleep 1
    done
    echo

    sleep 5

    sh /usr/local/iTelSwitchPlusMediaProxy$sname/runiTelSwitchPlusMediaProxy.sh
    echo
}

# Define the function for shutting down and restarting iTelSwitchPlusSignaling
restart_iTelSwitchPlusSignaling() {
    echo
    cd /usr/local/
    echo -e "${BPurple}iTelSwitchPlusSignaling Shutting Down:${Color_Off}"
    for _ in {1..3}; do
        sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh
        sleep 1
    done
    echo

    sleep 5

    sh /usr/local/iTelSwitchPlusSignaling$sname/runiTelSwitchPlusSignaling.sh
    echo
}

# Check if the log4j.properties_2023Yr file exists
cd /usr/local/iTelSwitchPlusMediaProxy$sname/
if ls | grep -q "log4j.properties_2023Yr"; then
    echo -e "${BCyan}Found log4j.properties_2023Yr file. Skipping backup and download.${Color_Off}"
    # Call the function to restart iTelSwitchPlusMediaProxy
    restart_iTelSwitchPlusMediaProxy
else
    # Backup the existing log4j.properties file
    mv log4j.properties "log4j.properties_$(date '+%YYr_%mMon_%dDay_%HHr_%MMin_%SSec')"
    echo
    echo "Backed up log4j.properties to:"
    ls | grep -e "log4j.properties_20"
    echo
    sleep 2

    # Download the new log4j.properties file
    echo
    echo -e "${BCyan}Downloading New Log4j File_ _ _ _ _ _ _ _ ${Color_Off}"
    echo
    wget http://149.20.188.7/log4j.properties_media
    echo
    echo -e "${BGreen}Re-Naming_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ ${Color_Off}"
    echo
    mv log4j.properties_media log4j.properties

    # Call the function to restart iTelSwitchPlusMediaProxy
    restart_iTelSwitchPlusMediaProxy
fi

# Perform other actions (if applicable)
# echo "Other actions"




# Check if the log4j.properties_2023Yr file exists
cd /usr/local/iTelSwitchPlusSignaling$sname/
if ls | grep -q "log4j.properties_2023Yr"; then
    echo -e "${BCyan}Found log4j.properties_2023Yr file. Skipping backup and download.${Color_Off}"
    # Call the function to restart iTelSwitchPlusMediaProxy
    restart_iTelSwitchPlusMediaProxy
else
    # Backup the existing log4j.properties file
    mv log4j.properties "log4j.properties_$(date '+%YYr_%mMon_%dDay_%HHr_%MMin_%SSec')"
    echo
    echo "Backed up log4j.properties to:"
    ls | grep -e "log4j.properties_20"
    echo
    sleep 2

    # Download the new log4j.properties file
    echo
    echo -e "${BCyan}Downloading New Log4j File_ _ _ _ _ _ _ _ ${Color_Off}"
    echo
    wget http://149.20.188.7/log4j.properties_signaling
    echo
    echo -e "${BGreen}Re-Naming_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ ${Color_Off}"
    echo
    mv log4j.properties_signaling log4j.properties

    # Call the function to restart iTelSwitchPlusMediaProxy
    restart_iTelSwitchPlusMediaProxy
fi

# Perform other actions (if applicable)
# echo "Other actions"
