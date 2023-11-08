#!/bin/bash
script="postShift"
author_name="# Mirza Golam Abbas Shahneel"
version="# 1.0.4.4"
modified="# Modified_28012019_1531";
lastModifications="
#Restarter added
#Task - CDR & Bill folder shifting will be done at the end of all tasks
#Task - After shifting database switch will be started and delivery mail will be prompted
#Task - script will remove all password less authentications from both servers.
#Task - changed Eligiable IP for Databackup server IP.
#Task - Need to check why asking for password - 562
#Task - Need to check why asking for password - 634
#Task - Need to check why asking for password - 639
";
#Need to test this script finaly
###################################################
#Variables
#Search tasks to be done with "Task" string
#Works in existing switch server only
###################################################
#No Colors
NC='\033[0m'			  # Text Reset/No Color
# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White
# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White
# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White
# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White
# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White
var_jdk="/usr/java/jdk1.6.0_13";
var_tomcat="8.0.1";
flg_jdk=0;
localPath='/usr/local'
scrptLoc="$localPath/src/postShift"
mkdir -p $localPath/src/ServiceShifting
resourcePath="$localPath/src/ServiceShifting"
dlvryMail="/home/swp/deliveryEmail.cfg"
#rm -f $resourcePath/postShift_Restarter
#wget -O $resourcePath/postShift_Restarter http://149.20.186.19/downloads/shifT/postShift_Restarter  >>/dev/null 2>&1
#chmod a+x $resourcePath/postShift_Restarter
rsTrtr=$resourcePath/rsTrtr
tmctRstrter=$resourcePath/tmctRstrter
>$tmctRstrter
echo -e "cd $resourcePath/
rm -f postShift_Restarter
wget -q http://149.20.186.19/downloads/shifT/postShift_Restarter 
chmod a+x postShift_Restarter
./postShift_Restarter" > $rsTrtr
chmod a+x $rsTrtr
####Need to remove below information
#oSrvrPrt=64555
#oSrvrUsr=root
#oSrvrIP=191.96.12.50
#{nSrvr[2]}=22
#{nSrvr[1]}=root
#{nSrvr[0]}=98.158.148.10
####Need to remove above information
echo $(date +%s) >$resourcePath/dumptm
dbs_date=$(cat $resourcePath/dumptm);
logDate="date +%Y_%m_%d_%H_%M_%S"
dbsRdable=$($logDate);
#touch $resourcePath/configNewIP.sh
dbs="$resourcePath/dbs"
listofshift="$resourcePath/listofshift"
configNewIP="$resourcePath/configNewIP.sh"
tomcatBckUp="$resourcePath/tomcatBckUp"
varList="$resourcePath/varList"
keepOldTables="$resourcePath/keepOldTables"
dbShIPConf="$resourcePath/dbShIPConf"
dbCpDir='/home/db_Backup'
declare -i tmStClr="";
declare -i dbChkClear="";
declare -i srvChkClear="";
declare -a partitionServices=(iTelSwitchPlusMediaProxy iTelSwitchPlusSignaling);
newMysqlPass="$(grep newMysqlPass $varList | gawk -F: '{print $2}')";
mysqlPass="$(grep mysqlPass $varList | gawk -F: '{print $2}')";
logWrtng="/home/postShifting.log"
oldMySQLDir=$(grep oldMySQLDir $varList | gawk -F: '{print $2}')
newMySQLDir=$(grep newMySQLDir $varList | gawk -F: '{print $2}')
oSrvr=($(grep oSrvr $varList | gawk -F: '{print $2}'))
nSrvr=($(grep nSrvr $varList | gawk -F: '{print $2}'))
jktLocOld=($(grep jktLocOld $varList | gawk -F: '{print $2}'))
varBilling=($(grep varBilling $varList | gawk -F: '{print $2}'))
var_sales_email=($(grep var_sales_email $varList | gawk -F: '{print $2}'))
email=($(grep email $varList | gawk -F: '{print $2}'))
echo -e "$newMysqlPass\n$mysqlPass\n$logWrtng\n$oldMySQLDir\n$newMySQLDir\n${oSrvr[@]}\n${nSrvr[@]}\n$jktLocOld\n$varBilling\n$var_sales_email\n$email" >>$logWrtng 2>&1;
SSHSOCKET=~/.ssh/teeCon
#rSncPort="ssh -p ${nSrvr[2]}"
rSncPort="ssh -o ControlPath=$SSHSOCKET -p ${nSrvr[2]}"
######################################################
echo -e "update vbSharedSecret set ip='${nSrvr[0]}';
update vbRegistrar set regIP='${nSrvr[0]}';
update vbTopupServerConfiguration set tsIpAddress='${nSrvr[0]}';
update vbServiceRestarterIP set srServerIp = '${nSrvr[0]}',srEligibleIPs='${nSrvr[0]}' where srServerIp='${oSrvr[0]}';
update vbDataBackupServerIP set dbeServerIp = '${nSrvr[0]}',dbeEligibleIPs='${nSrvr[0]}',dbCopyDirectory='$dbCpDir' where dbeServerIp='${oSrvr[0]}';
update vbDataBackupServerIP set dbeEligibleIPs='${nSrvr[0]}' where dbeServerIp='${oSrvr[0]}';
update vbSwitchManagerConfiguration set smServerIP='${nSrvr[0]}' where smServerIP='${oSrvr[0]}';
update vbPartitionManagement set pmSipServerName='${nSrvr[0]}',pmSipServerIP='${nSrvr[0]}',pmLoginURL = REPLACE(pmLoginURL, '${oSrvr[0]}', '${nSrvr[0]}') WHERE pmLoginURL LIKE '%${oSrvr[0]}%' or pmSipServerIP='${oSrvr[0]}';
update vbWhiteOrBlackListIps set wbIpWithCIDR='${nSrvr[0]}',wbStartIP = (select inet_aton('${nSrvr[0]}')),wbEndIP = (select inet_aton('${nSrvr[0]}')) where wbIpWithCIDR='${oSrvr[0]}';
update vbPaymentServer set psServerIp='${nSrvr[0]}', psEligibleIPs='${nSrvr[0]}' where psServerIp='${oSrvr[0]}'
" >>$dbShIPConf
dbIPChng=$(cat $dbShIPConf)
trap ctrl_c INT
function ctrl_c() {
        echo "** Exiting the script as you pressed CTRL-C"; echo "** Exiting the script as you pressed CTRL-C" >>$logWrtng 2>&1
		history -c
		echo $scrptLoc  >>$logWrtng 2>&1
		rm -f $scrptLoc
		
		#ssh -S $SSHSOCKET -O exit -p $nSrvrPrt $nSrvrUsr@$nSrvrIP >>$logWrtng 2>&1
		ssh -S $SSHSOCKET -O exit -p ${nSrvr[2]} ${nSrvr[1]}@${nSrvr[0]} >>$logWrtng 2>&1
		
		ls ~/.ssh/ >>$logWrtng 2>&1
		
		exit 1;
}
function fn_Con(){
		conSuccssfl="";
		#${nSrvr[2]} ${nSrvr[1]}@${nSrvr[0]}
		echo "${nSrvr[2]} ${nSrvr[1]}@${nSrvr[0]}"
		echo "${nSrvr[2]} ${nSrvr[1]}@${nSrvr[0]}" >>$logWrtng 2>&1
		SSHSOCKET=~/.ssh/teeCon
		ssh -M -f -N -o ControlPath=$SSHSOCKET -p ${nSrvr[2]} ${nSrvr[1]}@${nSrvr[0]}
		ssh -o ControlPath=$SSHSOCKET -p ${nSrvr[2]} ${nSrvr[1]}@${nSrvr[0]} "ls $resourcePath" && conSuccssfl=1 || conSuccssfl=0
		if [ $conSuccssfl -eq 1 ];then
			echo -e "${BPurple}$($logDate) Public Key configuration successfull${NC}" >>$logWrtng 2>&1
			echo -e "${BPurple}$($logDate) Public Key configuration successfull${NC}"
		else
			echo -e "${BRed}$($logDate) Public Key configuration was not successfull${NC}" >>$logWrtng 2>&1
			echo -e "${BRed}$($logDate) Public Key configuration was not successfull${NC}" >>$logWrtng 2>&1
			exit
		fi						
}
fn_Con
function newTomcatStrt(){
	echo "dbsRdable=\$(date +%Y_%m_%d_%H_%M_%S)" >> $tmctRstrter
	echo "jktLoc=\$(find $localPath/ -name jakarta* | grep -m 1 "$localPath/jakarta")" >> $tmctRstrter
	echo "if [ -z \$jktLoc ];then" >> $tmctRstrter
	echo "	echo \"No Tomcat Found\"" >> $tmctRstrter
	echo "else" >> $tmctRstrter
	echo "	service tomcat stop" >> $tmctRstrter
	echo "	service tomcat stop" >> $tmctRstrter
	echo "	kill -9 \$(lsof -i :80 -t)" >> $tmctRstrter
	echo "	service tomcat start" >> $tmctRstrter
	echo "fi" >> $tmctRstrter
	ssh -o ControlPath=$SSHSOCKET -p ${nSrvr[2]} ${nSrvr[1]}@${nSrvr[0]} "bash -s" -- < $tmctRstrter >>$logWrtng 2>&1;
}
function fn_delivery()
{
mblExist=$(grep -m1 MobileBilling $listofshift)
if [ -z $mblExist ];then
	mbAppIP="None"
	mbAppPort="None"
else
	mbAppIP=$(ssh -o ControlPath=$SSHSOCKET -p ${nSrvr[2]} ${nSrvr[1]}@${nSrvr[0]} "grep bindAddress /usr/local/$mblExist/Configuration.properties" | gawk -F= '{ print $2 }');
	mbAppPort=$(ssh -o ControlPath=$SSHSOCKET -p ${nSrvr[2]} ${nSrvr[1]}@${nSrvr[0]} "grep bindPort /usr/local/$mblExist/Configuration.properties" | gawk -F= '{ print $2 }');
fi
switchExist=$(grep -m1 iTelSwitchPlusSignaling $listofshift);
if [ -z $switchExist ];then
	orgBIP="None"
	orgBPort="None"
else
	orgBIP=$(ssh -o ControlPath=$SSHSOCKET -p ${nSrvr[2]} ${nSrvr[1]}@${nSrvr[0]} "grep orgBindIP /usr/local/$switchExist/config/server.cfg" | gawk -F= '{ print $2 }');
	orgBPort=$(ssh -o ControlPath=$SSHSOCKET -p ${nSrvr[2]} ${nSrvr[1]}@${nSrvr[0]} "grep orgBindPort /usr/local/$switchExist/config/server.cfg" | gawk -F= '{ print $2 }');
	mkdir -p /home/swp
	#switch delivery email
	echo "billing=$varBilling">$dlvryMail
	echo "salesEmail=$var_sales_email">>$dlvryMail
	echo "customerEmail=$email">>$dlvryMail
	echo "supportEmail=support@itelbilling.com">>$dlvryMail
	echo "billingURL=http://${nSrvr[0]}/$varBilling">>$dlvryMail
	#echo "switchIP=${nSrvr[0]}">>$dlvryMail
	echo "switchIP=$orgBIP">>$dlvryMail
	echo "switchPORT=$orgBPort">>$dlvryMail
	echo "IVRExt=101">>$dlvryMail
	echo "balanceLink=http://${nSrvr[0]}/$varBilling/getclientbalance.do?pin=REPLACE">>$dlvryMail
	echo "mobileBillingIP=$mbAppIP">>$dlvryMail
	echo "mobileBillingPORT=$mbAppPort">>$dlvryMail
	clear;
	echo "";
	echo "Below summary will add into delivery email." >>$logWrtng 2>&1
	echo "Below summary will add into delivery email.";
	echo "-------------------------------------------";
	echo "";
	echo "";
		echo -e "\tDear Sir,\n\n\tHope you are well.\n\tAs per your sales manager confirmation, We have shifted your switch.\n\n\tHere is the all new info:\n"
		echo -e "\tBilling URL: http://${nSrvr[0]}/$varBilling"
		echo -e "\tUsername/Password: Same as before"
		echo -e "\tSIP IP :$orgBIP"
		echo -e "\tSIP Port: $orgBPort"
		echo -e "\tBalance URL: http://${nSrvr[0]}/$varBilling/getclientbalance.do?pin=REPLACE"
		echo -e "\tIVR Extension: 101\n"
		echo -e "\tMobile Billing IP: $mbAppIP"
		echo -e "\tMobile Billing Port: $mbAppPort\n"
		echo -e "\tPlease inform your originating Client and terminating Client about your new switch IP/port and inform reseller and Pin client about the new Billing Link.\n"
	echo "";
	echo "";
	cat $dlvryMail >>$logWrtng 2>&1
	cat $dlvryMail
	echo "";
	echo -n "Do you want to send email? y/n: " >>$logWrtng 2>&1
	echo -n "Do you want to send email? y/n: ";
	read yorn;
	if [ $yorn == y ];then
		clear;
		echo "";
		echo "Sending email...Please wait..." >>$logWrtng 2>&1
		echo "Sending email...Please wait...";
		cd /usr/local/src/ >>$logWrtng 2>&1
		wget http://191.96.12.50:90/downloads/others/installerjar.zip >>$logWrtng 2>&1
		unzip -o installerjar.zip >>$logWrtng 2>&1
		cd /usr/local/src/installerjar >>$logWrtng 2>&1
		sh runSwitchDelivery.sh >>$logWrtng 2>&1
	else
		echo "Email Sending skipped." >>$logWrtng 2>&1
		echo "Email Sending skipped.";
	fi
fi
}
function postShiftProc(){
###########Tomcat Stop
#Task - Need to check when process is already killed
tmctProcID=$(pgrep -f "$jktLocOld")
service tomcat stop >>$logWrtng 2>&1;
#service tomcat stop >>$logWrtng 2>&1;
#service tomcat stop >>$logWrtng 2>&1;
tmctProcChk=$(lsof -tp $tmctProcID) >>$logWrtng 2>&1;
if [ -z $tmctProcChk ];then
	echo "Tomcat stopped successfully..." >>$logWrtng 2>&1;
else
	kill -9 $tmctProcID >>$logWrtng 2>&1;
fi
###########Service Stop
for srvStp in $( cat $listofshift ); do
	echo $srvStp >>$logWrtng 2>&1;
	if [[ "$srvStp" =~ ^iTelBilling ]];then
		echo $srvStp >>$logWrtng 2>&1;
			for prtService in ${partitionServices[@]};do
				echo $srvStp/$prtService >>$logWrtng 2>&1;
				sh $localPath/$srvStp/$prtService/shutdown*.sh >>$logWrtng 2>&1;
				sh $localPath/$srvStp/$prtService/shutdown*.sh >>$logWrtng 2>&1;
				sh $localPath/$srvStp/$prtService/shutdown*.sh >>$logWrtng 2>&1;
				#Task - Need to check when process is already killed
				srvcProcID=$(ps -fu $USER| grep "$srvStp/$prtService" | grep "grep" | gawk '{print $2}')
				if [[ -z "$srvcProcID" ]]; then
					echo "$srvStp/$prtService stopped successfully..." >>$logWrtng 2>&1;
				else
					#srvcProcChk=$(lsof -tp $srvcProcID)
					kill -9 $srvcProcID >>$logWrtng 2>&1;
				fi
				rm -f $localPath/$srvStp/$prtService/*.log_* && echo "Removing logs from $srvStp/$prtService" >>$logWrtng 2>&1
				rm -f $localPath/$srvStp/$prtService/*.log.* && echo "Removing logs from $srvStp/$prtService" >>$logWrtng 2>&1;
			done
	else
		echo $srvStp;
			sh $localPath/$srvStp/shutdown*.sh && echo "stopping $srvStp" >>$logWrtng 2>&1;
			sh $localPath/$srvStp/shutdown*.sh && echo "stopping $srvStp" >>$logWrtng 2>&1;
			sh $localPath/$srvStp/shutdown*.sh && echo "stopping $srvStp" >>$logWrtng 2>&1;
			srvcProcID=$(ps -fu $USER| grep "$srvStp" | grep "grep" | gawk '{print $2}')
			if [ -z $srvcProcID ];then
				echo "$srvStp stopped successfully..." >>$logWrtng 2>&1;
			else
				#srvcProcChk=$(lsof -tp $srvcProcID)
				kill -9 $srvcProcID >>$logWrtng 2>&1;
			fi
			
			rm -f $localPath/$srvStp/*.log.* && echo "Removing logs from $srvStp" >>$logWrtng 2>&1;
			rm -f $localPath/$srvStp/*.log_* && echo "Removing logs from $srvStp" >>$logWrtng 2>&1;
	fi
done
#Task - Rest of the database shifting - Done
#Task - Failed current month if previously cdr kept
#Successful current month, iTelBilling and Successful
########
cRntMnth=$($mysqlPass --skip-column-name -e"select unix_timestamp(now())/(60*60*24*30) as thisMonth;" | cut -f1 | gawk -F. '{print $1}');
	for dbSList in $(cat $dbs);do
		#echo $dbSList;
		#echo ${nSrvr[2]} $oldMySQLDir$dbSList  ${nSrvr[1]}@${nSrvr[0]}:$newMySQLDir
		if [[ $dbSList =~ ^Failed ]]; 
			then 
				OldFldTables=$(cat $keepOldTables$dbSList)
				if [ $OldFldTables == 1 ];then
					echo -e "$(date +%Y_%m_%d_%H_%M_%S) ${BRed}Shifting Current Failed CDR${NC}" >>$logWrtng 2>&1;
					echo -e "${BRed}Shifting Current Failed CDR${NC}";
					#echo 0 > $keepOldTables$dbSList;
					declare -i rSyncFldDB=1;
					while [ $rSyncFldDB -ne 0 ];do
						echo $($logDate) $rSncPort >>$logWrtng 2>&1;
						rsync -chavzPq --update -vv --log-file=$resourcePath/rSyncDB$dbSList.log -e "$rSncPort" $oldMySQLDir/$dbSList/ ${nSrvr[1]}@${nSrvr[0]}:$newMySQLDir/$dbSList >>$logWrtng 2>&1 &
						echo $! > $resourcePath/proCess;
						prcsID=$(cat $resourcePath/proCess);
						#Checking if processes are still running or completed
						prcsAlive=$(lsof -tp $prcsID) >>$logWrtng 2>&1 ;
						until [ -z $prcsAlive ];do
							#echo "The process $prcsAlive is still going on"
							echo "$($logDate) The process $prcsAlive is still going on" >>$logWrtng 2>&1
							sleep 5;
							prcsAlive=$(lsof -tp $prcsID) >>$logWrtng 2>&1 ;
						done
						rSyncStatus=$(tail -n 1 $resourcePath/rSyncDB$dbSList.log | grep "_exit_cleanup" | gawk -F"about to call exit[(]" '{print $2}' | gawk -F"[)]" '{print $1}')
						echo $($logDate) $rSyncStatus >>$logWrtng 2>&1
						if [ $rSyncStatus -eq 0 ];then
							declare -i prMssnDB=0
							while [ $prMssnDB == 0 ];do 
								ssh -o ControlPath=$SSHSOCKET -p ${nSrvr[2]} ${nSrvr[1]}@${nSrvr[0]} "chown -R mysql:mysql $newMySQLDir/$dbSList;chgrp mysql $newMySQLDir/$dbSList" >>$logWrtng 2>&1 && prMssnDB=1 || prMssnDB=0
							done
							echo -e "${BPurple}$($logDate) Shifting of $dbSList database is successful${NC}" >>$logWrtng 2>&1;
							echo -e "${BPurple}Shifting of $dbSList database is successful${NC}";
							rSyncFldDB=0
						else
							echo -e "${BRed}$($logDate) Shifting of $dbSList database was unsuccessful${NC}" >>$logWrtng 2>&1;
							echo -e "${BRed}Shifting of $dbSList database was unsuccessful${NC}";
							rSyncFldDB=1
						fi
					done
				fi
		elif [[ "$dbSList" == *Reseller ]] || [[ "$dbSList" == *Successful* ]]; #Task Need to check iTelBilling shifts or not - Done
			then
			#scp -rP ${nSrvr[2]} $oldMySQLDir/$dbSList  ${nSrvr[1]}@${nSrvr[0]}:$newMySQLDir/
			#ssh -p ${nSrvr[2]} ${nSrvr[1]}@${nSrvr[0]} "chown -R mysql:mysql $newMySQLDir$dbSList;chgrp mysql $newMySQLDir/$dbSList"
			declare -i rSyncSccsDB=1;
			while [ $rSyncSccsDB -ne 0 ];do
				echo $($logDate) $rSncPort >>$logWrtng 2>&1;
				rsync -chavzPq --update --include "vb*_$cRntMnth*" --exclude '*' -vv --log-file=$resourcePath/rSyncDB$dbSList.log -e "$rSncPort" $oldMySQLDir/$dbSList/ ${nSrvr[1]}@${nSrvr[0]}:$newMySQLDir/$dbSList >>$logWrtng 2>&1 &
				#rsync -chavzPq --update -vv --log-file=$resourcePath/rSyncDB$dbSList.log -e "$rSncPort" $oldMySQLDir/$dbSList/ ${nSrvr[1]}@${nSrvr[0]}:$newMySQLDir/$dbSList >>$logWrtng 2>&1 &
				echo $! > $resourcePath/proCess;
				prcsID=$(cat $resourcePath/proCess) >>$logWrtng 2>&1 ;
				#Checking if processes are still running or completed
				prcsAlive=$(lsof -tp $prcsID) >>$logWrtng 2>&1 ;
				until [ -z $prcsAlive ];do
					#echo "The process $prcsAlive is still going on"
					echo "$($logDate) The process $prcsAlive is still going on" >>$logWrtng 2>&1
					sleep 5;
					prcsAlive=$(lsof -tp $prcsID) >>$logWrtng 2>&1 ;
				done
				rSyncStatus=$(tail -n 1 $resourcePath/rSyncDB$dbSList.log | grep "_exit_cleanup" | gawk -F"about to call exit[(]" '{print $2}' | gawk -F"[)]" '{print $1}')
				echo $rSyncStatus >>$logWrtng 2>&1
				if [ $rSyncStatus -eq 0 ];then
					declare -i prMssnDB=0
					while [ $prMssnDB == 0 ];do 
						ssh -o ControlPath=$SSHSOCKET -p ${nSrvr[2]} ${nSrvr[1]}@${nSrvr[0]} "chown -R mysql:mysql $newMySQLDir/$dbSList;chgrp mysql $newMySQLDir/$dbSList" >>$logWrtng 2>&1 && prMssnDB=1 || prMssnDB=0
					done
					echo -e "${BPurple}$($logDate) Shifting of $dbSList database is successful${NC}" >>$logWrtng 2>&1;
					echo -e "${BPurple}Shifting of $dbSList database is successful${NC}";
					rSyncSccsDB=0
				else
					echo -e "${BRed}$($logDate) Shifting of $dbSList database was unsuccessful${NC}" >>$logWrtng 2>&1;
					echo -e "${BRed}Shifting of $dbSList database was unsuccessful${NC}";
					rSyncSccsDB=1
				fi
			done		
		elif [[ "$dbSList" =~ ^iTelBilling ]] || [[ "$dbSList" =~ ^SMS ]]; #Task Need to check successful works fine or not. - Done
			then
			declare -i rSynciTelDB=1;
			while [ $rSynciTelDB -ne 0 ];do
				echo $rSncPort >>$logWrtng 2>&1;
				rsync -chavzPq --update -vv --log-file=$resourcePath/rSyncDB$dbSList.log -e "$rSncPort" $oldMySQLDir/$dbSList/ ${nSrvr[1]}@${nSrvr[0]}:$newMySQLDir/$dbSList >>$logWrtng 2>&1 &
				echo $! > $resourcePath/proCess;
				prcsID=$(cat $resourcePath/proCess) >>$logWrtng 2>&1 ;
				#Checking if processes are still running or completed
				prcsAlive=$(lsof -tp $prcsID) >>$logWrtng 2>&1 ;
				until [ -z $prcsAlive ];do
					echo "$($logDate) The process $prcsAlive is still going on" >>$logWrtng 2>&1
					sleep 5;
					prcsAlive=$(lsof -tp $prcsID) >>$logWrtng 2>&1 ;
				done
				rSyncStatus=$(tail -n 1 $resourcePath/rSyncDB$dbSList.log | grep "_exit_cleanup" | gawk -F"about to call exit[(]" '{print $2}' | gawk -F"[)]" '{print $1}')
				echo $rSyncStatus >>$logWrtng 2>&1
				if [ $rSyncStatus -eq 0 ];then
				#Task - Need to check if ssh exchnage fails
					declare -i prMssnDB=0
					declare -i ipUpdtd=0
					while [ $prMssnDB == 0 ] && [ $ipUpdtd == 0 ];do 
						ssh -o ControlPath=$SSHSOCKET -p ${nSrvr[2]} ${nSrvr[1]}@${nSrvr[0]} "chown -R mysql:mysql $newMySQLDir/$dbSList;chgrp mysql $newMySQLDir/$dbSList" >>$logWrtng 2>&1 && prMssnDB=1 || prMssnDB=0
						ssh -o ControlPath=$SSHSOCKET -p ${nSrvr[2]} ${nSrvr[1]}@${nSrvr[0]} "$newMysqlPass -D $dbSList -e\"$dbIPChng\" -vv" >>$logWrtng 2>&1 && ipUpdtd=1 || ipUpdtd=0
					done
					echo -e "${BPurple}$($logDate) Shifting of $dbSList database is successful${NC}" >>$logWrtng 2>&1;
					echo -e "${BPurple}Shifting of $dbSList database is successful${NC}";
					rSynciTelDB=0
				else
					echo -e "${BRed}$($logDate) Shifting of $dbSList database was unsuccessful${NC}" >>$logWrtng 2>&1;
					echo -e "${BRed}Shifting of $dbSList database was unsuccessful${NC}";
					rSynciTelDB=1
				fi
			done
		else
			echo -e "$($logDate) ${BRed}$($logDate) Not taking $dbSList database${NC}" >>$logWrtng 2>&1
			echo -e "${BRed}Not taking $dbSList database${NC}"
		fi
	done
	rm -f $resourcePath/rSync*.log
	
	#Task - Need to push restarter remotely
	#Task - Need to check service starts after database shift or not 
	#ssh -o ControlPath=$SSHSOCKET -p ${nSrvr[2]} ${nSrvr[1]}@${nSrvr[0]} "cd $resourcePath/;rm -f postShift_Restarter;wget http://191.96.12.50:90/downloads/shifT/postShift_Restarter;chmod a+x postShift_Restarter;./postShift_Restarter"
	
	#Task - Need to check if delivery prompt comes - 
	#fn_delivery;
	
	#Task - bill & other folder updates in the signaling dir
	###################RSync Service Starts############
	declare -a procServices=();
	declare -a procIDS=();
	##########################
	#Including services into array
	procServices=($(cat $listofshift ))
	echo ${procServices[@]} 
	echo $($logDate) ${#procServices[@]} >>$logWrtng 2>&1
	rSncPort="ssh -o ControlPath=$SSHSOCKET -p ${nSrvr[2]}"
	#Syncing files 
	while [ ${#procServices[@]} -ne 0 ];do
		echo ${#procServices[@]};
		for (( i=0; i<${#procServices[@]}; i++ ));do
			if [ -z ${procServices[i]} ];then
				echo "Nothing to shift"
				echo "$($logDate) Nothing to shift" >>$logWrtng 2>&1
			elif [[ "${procServices[i]}" =~ ^iTelSwitchPlusSignaling ]];then
				echo $rSncPort >>$logWrtng 2>&1;
				echo $($logDate) ${procServices[i]} >>$logWrtng 2>&1;
				rsync -chavzPq --ignore-existing -vv --exclude '*.log.*' --exclude '*.sh' --exclude 'config/server.cfg' --log-file=$resourcePath/rSync${procServices[i]}.log -e "$rSncPort" $localPath/${procServices[i]} ${nSrvr[1]}@${nSrvr[0]}:$localPath/ >>$logWrtng 2>&1 &
				echo $! > $resourcePath/proCess;
				procIDS+=($(cat $resourcePath/proCess));
			elif [[ "${procServices[i]}" =~ ^iTelBilling ]];then
				echo $rSncPort >>$logWrtng 2>&1;
				echo $($logDate) ${procServices[i]}/${partitionServices[2]} >>$logWrtng 2>&1;
				rsync -chavzPq --ignore-existing -vv --exclude '*.log.*' --log-file=$resourcePath/rSync${procServices[i]}.log -e "$rSncPort" $localPath/${procServices[i]}/${partitionServices[2]}/ ${nSrvr[1]}@${nSrvr[0]}:$localPath/${procServices[i]}/ >>$logWrtng 2>&1 &
				echo $! > $resourcePath/proCess;
				procIDS+=($(cat $resourcePath/proCess));
			else
				echo "Nothing more to shift"
				echo "$($logDate) more Nothing to shift" >>$logWrtng 2>&1
			fi
		done
		#Checking if processes are still running or completed
		for prcsID in ${procIDS[@]};do
			#echo $prcsID;
			prcsAlive=$(lsof -tp $prcsID);
			until [ -z $prcsAlive ];do
				#echo "The process $prcsAlive is still going on"
				echo "$($logDate) The process $prcsAlive is still going on" >>$logWrtng 2>&1
				sleep 5;
				prcsAlive=$(lsof -tp $prcsID);
			done
		done
		unset procServices;
		for i in $(ls $resourcePath/rSync*.log);do
			rSyncStatus=$(tail -n 1 $i | grep "_exit_cleanup" | gawk -F"about to call exit[(]" '{print $2}' | gawk -F"[)]" '{print $1}')
			serviceName=$(echo $i | gawk -F"/rSync" '{print $2}' | gawk -F. '{print $1}')
			echo $($logDate) $rSyncStatus >>$logWrtng 2>&1
			if [ $rSyncStatus -eq 0 ];then
					echo -e "${BPurple}$($logDate) Shifting of $serviceName service is successful${NC}" >>$logWrtng 2>&1;
					echo -e "${BPurple}Shifting of $serviceName service is successful${NC}";
					>$i;
					#mv $resourcePath/$i $resourcePath/$i$(date +%s)	#Task need to remove this
				else
					echo -e "${BRed}$($logDate) Shifting of $serviceName service was unsuccessful${NC}" >>$logWrtng 2>&1;
					echo -e "${BRed}Shifting of $serviceName service was unsuccessful${NC}";
					procServices+=($serviceName);
			fi
		done
	done
	echo ${#procServices[@]}
	rm -f rSync*.log
	declare -i rSyncRsrc=1;
	while [ $rSyncRsrc -ne 0 ];do
			echo $($logDate) $rSncPort >>$logWrtng 2>&1;
			echo -e "rsync -chavzPq --update -vv --exclude '*.log' --log-file=$resourcePath/rSyncServiceShifting.log -e \"$rSncPort\" $resourcePath/ ${nSrvr[1]}@${nSrvr[0]}:$resourcePath/ >>$logWrtng 2>&1 &" >>$logWrtng 2>&1
			
			#Task - Need to check why asking for password - 562
			rsync -chavzPq --update -vv --log-file=$resourcePath/rSyncServiceShifting.log -e "$rSncPort" $resourcePath/ ${nSrvr[1]}@${nSrvr[0]}:$resourcePath/ >>$logWrtng 2>&1 &
			echo $! > $resourcePath/proCess;
			prcsID=$(cat $resourcePath/proCess);
			prcsAlive=$(lsof -tp $prcsID);
			until [ -z $prcsAlive ];do
					echo "$($logDate) The process ServiceShifting $prcsAlive is still going on" >>$logWrtng 2>&1
					sleep 5;
					prcsAlive=$(lsof -tp $prcsID);
			done
			echo -e "rSyncStatus=$(tail -n 1 $resourcePath/rSyncServiceShifting.log | grep "_exit_cleanup" | gawk -F"about to call exit[(]" '{print $2}' | gawk -F"[)]" '{print $1}')"
			rSyncStatus=$(tail -n 1 $resourcePath/rSyncServiceShifting.log | grep "_exit_cleanup" | gawk -F"about to call exit[(]" '{print $2}' | gawk -F"[)]" '{print $1}')
			echo $($logDate) $rSyncStatus >>$logWrtng 2>&1
			if [ $rSyncStatus -eq 0 ];then
					echo -e "${BPurple}$($logDate) Shifting of ServiceShifting is successful${NC}" >>$logWrtng 2>&1;
					echo -e "${BPurple}Shifting of ServiceShifting is successful${NC}";
					rSyncRsrc=0
			else
					echo -e "${BRed}$($logDate) Shifting of ServiceShifting was unsuccessful${NC}" >>$logWrtng 2>&1;
					echo -e "${BRed}Shifting of ServiceShifting was unsuccessful${NC}";
					rSyncRsrc=1
			fi
	done
#Last job
history -c & echo "$(date +%Y_%m_%d_%H_%M_%S) Clearing history " >>$logWrtng 2>&1;
#ssh -p ${nSrvr[2]} ${nSrvr[1]}@${nSrvr[0]} "cd /root/.ssh/ && cat known_hosts && sed -i '$ d' known_hosts && rm -f id_rsa id_rsa.pub && service sshd restart" >>$logWrtng 2>&1;
#cd /root/.ssh/ && cat known_hosts >>$logWrtng 2>&1;
#sed -i '$ d' known_hosts && rm -f id_rsa id_rsa.pub && service sshd restart
}
echo -e "${Blue}---------------------------${NC}"
echo -e "${Blue}List of Services${NC}"
echo -e "${Blue}---------------------------${NC}"
availableService=($(cat $listofshift));
for i in ${availableService[@]};do
	echo -e "${Blue}$i${NC}";
done
echo -e "${Blue}---------------------------${NC}"
echo -e "${Blue}List of Services${NC}"
echo -e "${Blue}---------------------------${NC}"
arrayListOfDBs=($(cat $dbs));
for i in ${arrayListOfDBs[@]};do
	echo -e "${Blue}$i${NC}";
done
echo -e "${Blue}---------------------------${NC}"
echo -e "${Green}Will the above services be shifted?${NC}";
read yorn;
if [[ "$yorn" == "y" ]] || [[ "$yorn" == "Y" ]] || [[ "$yorn" == "YES" ]] || [[ "$yorn" == "yes" ]];then
	echo -e "${Purple}Continueing with the shifting and post shift jobs...${NC}" >>$logWrtng 2>&1
	echo -e "${Purple}Continueing with the shifting and post shift jobs...${NC}"
	postShiftProc;
	#Restarter promoted to postShiftProc
	#ssh -p ${nSrvr[2]} ${nSrvr[1]}@${nSrvr[0]} "cd $resourcePath/;rm -f postShift_Restarter;wget http://149.20.186.19/downloads/shifT/postShift_Restarter;chmod a+x postShift_Restarter;./postShift_Restarter" 
	#>>$logWrtng 2>&1
	#ssh -p ${nSrvr[2]} ${nSrvr[1]}@${nSrvr[0]}: "bash -s" -- < .$rsTrtr >>$logWrtng 2>&1
	#fn_delivery
	
	
	#Task - Need to push restarter remotely
	#Task - Need to check service starts after database shift or not 
	#Task - Need to check why asking for password - 634
	echo -e "${Blue}Do you want to restart the services now?${NC}";
	read yorn;
	if [ $yorn == y ] || [ $yorn == Y ] || [ $yorn == YES ] || [ $yorn == yes ];then
		ssh -o ControlPath=$SSHSOCKET -p ${nSrvr[2]} ${nSrvr[1]}@${nSrvr[0]} "cd $resourcePath/;rm -f postShift_Restarter;wget http://149.20.186.19/downloads/shifT/postShift_Restarter;chmod a+x postShift_Restarter;./postShift_Restarter";
		echo -e "${Purple}Proceeding to restart the services...${NC}";
	else
		echo -e "${Purple}I respect your decision :)${NC}";
	fi
		
	#Task - Need to check if delivery prompt comes - 
	#Task - Need to check why asking for password - 639
	fn_delivery;
	history -c
	echo $scrptLoc  >>$logWrtng 2>&1
	rm -f $scrptLoc
	
	ssh -S $SSHSOCKET -O exit -p ${nSrvr[2]} ${nSrvr[1]}@${nSrvr[0]} >>$logWrtng 2>&1
	ls ~/.ssh/ >>$logWrtng 2>&1
else
	echo -e "${BRed}Please run the 'Pre-Shifting' task first${NC}" >>$logWrtng 2>&1
	echo -e "${BRed}Please run the 'Pre-Shifting' task first${NC}"
	ssh -S $SSHSOCKET -O exit -p ${nSrvr[2]} ${nSrvr[1]}@${nSrvr[0]} >>$logWrtng 2>&1
	exit;
fi
