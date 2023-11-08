#!/bin/bash

echo "Which Service Do You Want To Restart???"
echo 1. ByteSaver
echo 2. Switch
echo 3. Tomcat
echo "------------------------******---------------------------"
echo "What You Wnat To Check???"
echo 4. Memory check
echo 5. HDD Check
echo 6. CPU Usage Check
echo "------------------------******---------------------------"


read option

case $option in
    1)
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

    ps -aux |grep ByteSaver
    ;;
    2)
    echo "Restarting Service--(Switch)"
    echo "Enter Your Switch Name: "
    read sname

    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh
    echo "ByteSaverSignalingConverter Shuting Down:"
    sh /usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh

    sleep 2

    sh /usr/local/iTelSwitchPlusSignaling$sname/runiTelSwitchPlusSignaling.sh

    sleep 2

    sh /usr/local/iTelSwitchPlusMediaProxy$sname/shutdowniTelSwitchPlusMediaProxy.sh
    sh /usr/local/iTelSwitchPlusMediaProxy$sname/shutdowniTelSwitchPlusMediaProxy.sh
    echo "ByteSaverMediaProxy Shuting Down:"
    sh /usr/local/iTelSwitchPlusMediaProxy$sname/shutdowniTelSwitchPlusMediaProxy.sh

    sleep 2

    sh /usr/local/iTelSwitchPlusMediaProxy$sname/runiTelSwitchPlusMediaProxy.sh
    ;;
    3)
    echo "Tomcat Restarting......."
    echo "Please Wait for a while......"
    service tomcat stop
    service tomcat stop
    service tomcat stop

    sleep 5

    ps -aux |grep jar

    sleep 5

    echo "Want To Kill Process?"
    read kp

    if [[ $kp = 'y' ]]
    then
    echo "Please Enter Proccess ID:"
    read pid
    kill -9 $pid

    sleep 5

    echo $pid "Kill Done!"

    elif [[ $kp = 'n' ]]
    then

    sleep 3

    echo "Starting Tomcat......"
    service tomcat start

    ps -aux |grep jar

    echo "Tomcat Restart Successfully!!!!!"

    else
    echo Failed------
    fi
    ;;
    4)
    echo "---------Checking Memory---------"
    free -m
    ;;
    5)
    echo "---------Checking Storage---------"
    df -hT
    ;;
    6)
    echo "---------Checking CPU---------"
    top
    ;;
    *)
    echo "Unknown"
    ;;

esac