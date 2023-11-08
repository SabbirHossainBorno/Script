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

if [[ $option = '1' ]]
then
echo "Restarting Service--(ByteSaver)"
echo "Enter Your Oparator Code: "
read opcode

sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh
sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh
sh /usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh

ps -aux |grep jar

else
echo Faild------- 
fi

echo "Want To Run ByteSaverSignalConverter? [Y/N]"
read rs

if [[ $rs = 'y' ]]
then

sh /usr/local/ByteSaverSignalConverter$opcode/runByteSaverSignalConverter.sh

ps -aux |grep jar

sh /usr/local/ByteSaverMediaProxy$opcode/shutdownByteSaverMediaProxy.sh
sh /usr/local/ByteSaverMediaProxy$opcode/shutdownByteSaverMediaProxy.sh
sh /usr/local/ByteSaverMediaProxy$opcode/shutdownByteSaverMediaProxy.sh


ps -aux |grep jar
else
return 0
fi

echo "Want To Run ByteSaverMediaProxy? [Y/N]"
read rm

if [[ $rm = 'y' ]]
then
sh /usr/local/ByteSaverMediaProxy$opcode/runByteSaverMediaProxy.sh
else
echo Failed--------
fi 

if [[ $option = '2' ]]
then
echo Coming Soo..... Please Stay With Us
else
echo Failed--------
fi

if [[ $option = '3' ]]
then
echo Tomcat Restarting.......
echo Please Wait for a while......
service tomcat stop
service tomcat stop
service tomcat stop

ps -aux |grep tomcat

echo Want To Kill Process?
read kp

elif [[ $kp = 'y' ]]
then
echo Please Enter Proccess ID:
read pid
kill -9 $pid


elif [[ $kp = 'n' ]]
then

echo Do You Wnat To  Start Tomcat?[Y/N]
read tom

elif [[ $tom = 'y' ]]
then 
service tomcat start

else
echo Failed------




#echo Here Is Your $find Package Path:$(find / -name $find)
#echo Thanks For With Us......
#exit
#else
#echo Nothing Found Anything Like $find
#fi

#echo "Wanna Install $find (y/n)"
#read ans
#if [[ $ans = 'y' ]]
#then
#echo Installing...... $find
#yum install $find
#find / -name "$find" | read
#echo Install $find Successfully
#elif [[ $ans = 'n' ]]
#then
#echo Ok Let It Go!!! Thanks For with Us......
#else
#echo Install $find Filled.....
#fi
