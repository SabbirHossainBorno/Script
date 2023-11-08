#!/bin/bash
	####Replication Checker Installation####


		#No Colors
			NC='\033[0m'              # Text Reset/No Color
		# Regular Colors
			Black='\033[0;100m'       # Black
			Red='\033[0;31m'          # Red
			Green='\033[0;32m'        # Green
			# Bold
			BBlack='\033[1;100m'      # Black
			BRed='\033[1;31m'         # Red
			BGreen='\033[1;32m'       # Green



pattern1="ByteSaverSignalConverter"
pattern2="ByteSaverMediaProxy"
pattern3="iTelSwitchPlusSignaling"
pattern4="iTelSwitchPlusMediaProxy"
pattern5="TopUpServer"
pattern6="SMS"
pattern7="iTelAutoSignUp"
pattern8="DiskSpaceChecker"

read -p "Enter OLD OP: " OLD_IP

while [ -z "${OLD_IP}" ]
		do
			echo -n "Please enter the OLD_IP [Null/Invalid entry not accepted]: "
			read OLD_IP;
		done		

read -p "Enter New IP: " NEW_IP

while [ -z "${NEW_IP}: " ]
		do
			echo -n "Please enter the NEW_IP [Null/Invalid entry not accepted]: "
			read NEW_IP;
			
		done
		
echo "Now Changing Database"
read -p "iTelBilling Database: " iTelDB

if [ ! -z "$iTelDB" ]
then
	mysql -u root $iTelDB -e"update vbSharedSecret set ip='$NEW_IP' where ip='$OLD_IP';"
	mysql -u root $iTelDB -e"update vbRegistrar set regIP='$NEW_IP' where regIP='$OLD_IP';"
	mysql -u root $iTelDB -e"update vbServiceRestarterIP set srServerIp='$NEW_IP' where srServerIp='$OLD_IP';"
	mysql -u root $iTelDB -e"update vbServiceRestarterIP set srEligibleIPs='$NEW_IP' where srEligibleIPs='$OLD_IP';"
	mysql -u root $iTelDB -e"update vbDataBackupServerIP set dbeServerIp='$NEW_IP' where dbeServerIp='$OLD_IP';"
	mysql -u root $iTelDB -e"update vbDataBackupServerIP set dbeEligibleIPs='$NEW_IP' where dbeEligibleIPs='$OLD_IP';"
	mysql -u root $iTelDB -e"update vbTopupServerConfiguration set tsIpAddress='$NEW_IP' where tsIpAddress='$OLD_IP';"
	mysql -u root $iTelDB -e"update vbMoneyTransferServerInfo set mtEligibleIPs='$NEW_IP' where mtEligibleIPs='$OLD_IP';"
	mysql -u root $iTelDB -e"update vbPaymentServer set psServerIp='$NEW_IP', psEligibleIPs='$NEW_IP' where psServerIp='$OLD_IP';"
	mysql -u root $iTelDB -e"update vbWhiteOrBlackListIps set wbIpWithCIDR='$NEW_IP', wbStartIP = (select inet_aton('$NEW_IP')),wbEndIP = (select inet_aton('$NEW_IP')) where wbIpWithCIDR='$OLD_IP';"
fi


for _dir in /usr/local/"${pattern1}"*; do

	if [ -d "${_dir}" ] 
	then
		dir="${_dir}"		
		cd "${dir}"
		echo -e "\n${Black}${BRed} Working On ${_dir}   ${Black}${NC}"  
		
		sed -i "s/$OLD_IP/$NEW_IP/g" server.cfg
		cat server.cfg | grep "dialerBindAddress="
		
	fi
done

for _dir in /usr/local/"${pattern2}"*; do

	if [ -d "${_dir}" ] 
	then
		dir="${_dir}"		
		cd "${dir}"
		echo -e "\n${Black}${BRed} Working On ${_dir}   ${Black}${NC}"  
		
		sed -i "s/$OLD_IP/$NEW_IP/g" rtpProperties.cfg
		
	fi
done

for _dir in /usr/local/"${pattern3}"*; do

	if [ -d "${_dir}" ] 
	then
		dir="${_dir}"		
		cd "${dir}"
		echo -e "\n${Black}${BRed} Working On ${_dir}   ${Black}${NC}"  
		
		sed -i "s/$OLD_IP/$NEW_IP/g" config/server.cfg
		cat config/server.cfg | grep "orgBindIP"
	fi
done

for _dir in /usr/local/"${pattern4}"*; do

	if [ -d "${_dir}" ] 
	then
		dir="${_dir}"		
		cd "${dir}"
		echo -e "\n${Black}${BRed} Working On ${_dir}   ${Black}${NC}"  
		
		sed -i "s/$OLD_IP/$NEW_IP/g" rtpProperties.cfg
		
	fi
done

for _dir in /usr/local/"${pattern5}"*; do

	if [ -d "${_dir}" ] 
	then
		dir="${_dir}"		
		cd "${dir}"
		echo -e "\n${Black}${BRed} Working On ${_dir}   ${Black}${NC}"  
		
		sed -i "s/$OLD_IP/$NEW_IP/g" Configuration.properties
		cat Configuration.properties | grep "bindAddress="
	fi
done

for _dir in /usr/local/"${pattern6}"*; do

	if [ -d "${_dir}" ] 
	then
		dir="${_dir}"		
		cd "${dir}"
		echo -e "\n${Black}${BRed} Working On ${_dir}   ${Black}${NC}"  
		
		sed -i "s/$OLD_IP/$NEW_IP/g" Configuration.txt
		
		cat Configuration.txt | grep "bindAddress="
		
	fi
done

for _dir in /usr/local/"${pattern7}"*; do

	if [ -d "${_dir}" ] 
	then
		dir="${_dir}"		
		cd "${dir}"
		echo -e "\n${Black}${BRed} Working On ${_dir}   ${Black}${NC}"  
		
		sed -i "s/$OLD_IP/$NEW_IP/g" config/SignUp.conf
		cat config/SignUp.conf | grep "localBindIP="
		
	fi
done

for _dir in /usr/local/"${pattern8}"*; do

	if [ -d "${_dir}" ] 
	then
		dir="${_dir}"		
		cd "${dir}"
		echo -e "\n${Black}${BRed} Working On ${_dir}   ${Black}${NC}"  
		
		sed -i "s/$OLD_IP/$NEW_IP/g" email_properties
		
	fi
done



