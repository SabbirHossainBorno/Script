    echo "*----------------Welcome To Byte Saver Updater-------------*"
    echo "Enter Your Oparator Code: "
    read opcode
    sleep 2
    echo "*----------------[ ByteSaver Version Check ]----------------*"
    version = $ (cat /usr/local/ByteSaverSignalConverter$opcode/runByteSaverSignalConverter.sh)
    $version -v
    echo
    echo "Do You Want To Update ByteSaver?"
    read choice
    if [[ $choice == 'y' ]]
    then
    echo "*------------------[ UPDATING BYTE SAVER ]------------------*"
    echo "[ Changing Directory ]----------"
    
    sleep 2
    
    cd /usr/local/ByteSaverSignalConverter$opcode
    
    sleep 2
    
    rm -f ShutDown.jar
    rm -f SignalingProxy.so
    mv ByteSaverSignalConverter.jar ByteSaverSignalConverter.jar_413
    mv ByteSaverSignalConverter.jar  ByteSaverSignalConverter.jar_$(date '+%YYr_%mMon_%dDay_%HHr_%MMin_%SSec')
    wget https://supportresources.revesoft.com:4430/media/Dialer%20Resources/Dialer%20Signaling/ByteSaverSignalConverter_4.2.5.jar --no-check-certificate
    mv ByteSaverSignalConverter_4.2.5.jar ByteSaverSignalConverter.jar
    
    wget https://supportresources.revesoft.com:4430/media/Dialer%20Resources/Dialer%20Signaling/log4j2.properties --no-check-certificate
    wget http://149.20.186.19/resource/Dialer_Resources/Signaling/SignalingProxy.so --no-check-certificate
    wget http://149.20.186.19/resource/Dialer_Resources/Signaling/ShutDown.jar --no-check-certificate
    
    sleep 2
    
    echo "*----------------[ ByteSaver Version Check ]----------------*"
    version = $ (cat /usr/local/ByteSaverSignalConverter$opcode/runByteSaverSignalConverter.sh)
    $version -v
    
    sleep 2
    
    echo "ByteSaverSignalingConverter Shuting Down:"
    sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh
    sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh
    sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh

    sleep 5

    echo "ByteSaverSignalingConverter Restarting:"
    sh /usr/local/ByteSaverSignalConverter$opcode/runByteSaverSignalConverter.sh
    
    sleep 1
    
    ps -aux |grep ByteSaverSignalConverter
    
    
    elif [[ $choice == 'n' ]]
    then
    exit
    
    else
    echo "Somthing Going Wrong, ByteSaver Updating Canceled!!"
    fi
    


    ps -aux |grep ByteSaver