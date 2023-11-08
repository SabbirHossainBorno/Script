#!/bin/bash
# Author Name: Fuad Khan
# 1st Update : 11:38 PM 25/08/2022
# last Update : 12:00 PM 26/01/2023


now="$(date +'%d_%m_%Y_%H_%M_%S')"
########=============== Initializing Variables ======>>>>>>
scriptFileName="SMSSwitchUpdater"
logFileLocation="/usr/local/src"
logFileName="SMSSwitchUpdater.log"
logFilePath="$logFileLocation/$logFileName"
sqlErrorLog="$logFileLocation/$logFileName"
resourceLocation="/SMSUpdateFiles"
newRourceLocation="/SMSLatestDownloadsResource"

latestVersionOfSignaling="3.2.3"
latestVersionOfBilling="3.1.8"
latestAppServerVersion="2.0.5"

####============================= Methods =============================>>
###=======================Method Done here=========================
function writeLog(){
	logText=$1
	logTime="$(date +'%d-%m-%Y %H:%M:%S')"
	echo "$logTime : $logText " >> $logFilePath
}

function getColorCodes(){
	
	writeLog "Loading Colour codes......."
	#No Colors
	NC='\033[0m'              # Text Reset/No Color
	# Regular Colors
	Black='\033[0;30m'        # Black
	Red='\033[0;31m'          # Red
	Green='\033[0;32m'        # Green
	Yellow='\033[0;33m'       # Yellowecho
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
	spaceVal='  '
}
function removeScriptFile(){
	currentDir=$(pwd)
	scriptFilePath="$currentDir/$scriptFileName"
	writeLog "Trying To Remove Default Script File \"$scriptFilePath\"........."
	rm -f $scriptFilePath > /dev/null 2>&1
	
	thisFile=$(basename $(readlink -nf $0))
	thisFilePath="$currentDir/$thisFile"
	
	if [ -f "$thisFilePath" ];then
		rm -f $thisFilePath > /dev/null 2>&1
		writeLog "Current Script File \"$thisFilePath\" Removed"
	else
		writeLog "Default Script File \"$scriptFilePath\" Removed"
	fi
}
function checkLsofCommand(){
        
	writeLog "Checking lsof Status......."
	lsofFlag=0
	lsofStat=`rpm -qa | grep lsof`
	if [ -z $lsofStat ];then
		`yum -y install lsof > /dev/null 2>&1`
		lsofStat=`rpm -qa | grep lsof`
		if [ -z $lsofStat ]; then
			lsofFlag=0
		else
			lsofFlag=1
		fi
	else
			lsofFlag=1
	fi
	
	lsofStatus=$lsofFlag
	if [[ $lsofStat == 0 ]];then
		echo -ne "${Blue} [*] Please Install lsof Manually ${NC}"'\r'
		writeLog "[*] Please Install lsof Manually"
	fi
	writeLog "Got lsof Status as \"$lsofStatus\" "
}
function checkUnzipCommand(){
	
	writeLog "Checking unzip Command........."
	declare -i unzipFlag=0
	unzipStat=`rpm -qa | grep ununzip`
	
	if [ -z $unzipStat ];then
		`yum -y install unzip > /dev/null 2>&1`
		unzipStat=`rpm -qa | grep unzip`
		if [ -z $unzipStat ]; then
			unzipFlag=0
		else
			unzipFlag=1
		fi
	else
			unzipFlag=1
	fi
	#return $unzipFlag
	writeLog "Unzip Status is \"$unzipFlag\" "
	
	if [ $unzipFlag -eq 0 ];then
		printf "\n${BRed} bash Command 'unzip'  not Found. ${NC}\n\n"
		printf "\n${BRed} Please install unzip  Manually then it again.${NC}\n\n"
		exit
	fi
	
}
function getMYSQLDataDirectory(){
	writeLog "Checking mysql Data Directory ..."
	
	dataDir=$(mysql --force -ss -N -e 'select VARIABLE_VALUE from information_schema.global_variables where VARIABLE_NAME = "DATADIR"' )
	if [ -z $dataDir ];then
		writeLog "Didnt get Mysql Data Directory from information_schema."
		dataDir=`grep -m 1  '^datadir' /etc/my.cnf > /dev/null 2>&1`
		dataDir=${dataDir#*=}
		if [ -z $dataDir ];then
			writeLog "Didnt get Mysql Data Directory from /etc/my.cnf "
			dataDir="/var/lib/mysql"
			writeLog "Using default Data Directory $dataDir"
		fi
	fi
	
	writeLog "Got Mysql Data Directory $dataDir"
}
function checkBashServicePath(){
	systemctlIsEnabled=0
	serviceIsEnabled=0
	
	bash_service=`which service 2>&1 | tee -a $logFilePath`
	
	if [[ -z "$bash_service" ||  "$bash_service" =~ "no service in" ]];then
		writeLog "Didn't get \"service\" "
		bash_service=`which systemctl 2>&1 | tee -a $logFilePath`
		if [[ -z "$bash_service" ]] || [[ "$bash_service" =~ "no systemctl in" ]];then
			writeLog "Didn't get \"systemctl\" "
			bash_service="service"
		else
			serviceIsEnabled=1
		fi
	else
		systemctlIsEnabled=1
		writeLog "Got \"systemctl\" "
	fi
}
function search_jdk(){
		 
	cd /usr/
	rm -rf jdk*.tar.gz*
	rm -rf jdk*.zip*
    
	flg_jdk="";
	
	find  /usr/ -maxdepth 1 -name 'jdk1.8.0_161*' | grep "jdk1.8.0_161" && var_jdk="jdk1.8.0_161" && is_jdk=1  || is_jdk=0
	if [[ $is_jdk -eq "0" ]];then
		echo "Going to download JDK.Please wait for a while......"
		writeLog "Trying to download JDK..."
		fileUrl1="http://149.20.186.19/downloads/jdk1.8.0_161.zip"
		
		cd /usr/
		
		wget --no-check-certificate --server-response -q -o wgetOut $fileUrl1
		_wgetHttpCode=`cat wgetOut | gawk '/HTTP/{ print $2 }'`
		
		echo "Trying to download resource from  .. \"$fileUrl1\" "
		writeLog "Trying to download resource from  .. \"$fileUrl1\" "
			if [ "$_wgetHttpCode" != "200" ]; then
				echo "Download Failed from \"$fileUrl1\" "
				writeLog "Download Failed from \"$fileUrl1\" "
				dwError=`cat wgetOut`
				writeLog "Error :  $dwError"
			else
				echo "JDK Downloaded Successfully"
				writeLog "JDK Downloaded Successfully"
				unzip jdk1.8.0_161.zip > /dev/null 2>&1
				rm -rf jdk1.8.0_161.zip
			fi
	fi
}
function getJakartaTomcatInfo(){
	newVersionTomcat='apache-tomcat-7.0.59'
	writeLog "Checking tomcat web Location........."
	updatedTomcat=2
	
	for localDir in /usr/local/apache-tomcat-*
	do
		tempDir=${localDir%*/}
		tempDir=${tempDir##*/local/}
		#echo "$localDir"
		if [[ "$tempDir" == "$newVersionTomcat" ]];
		then
			jak_loc=$localDir
			jak_loc=$(echo $jak_loc | sed 's:/*$::')
			updatedTomcat=1
			return 1
		fi
		
	done

	if [[ "$updatedTomcat" == 2 ]]
	then
		echo ""
		echo -e "${BRed}[*] Regular apache7 web not Found. Please check Manually...${NC}"
		writeLog "[*] Regular apache7 web not Found. Please check Manually..."
		exit;
	fi
	
	writeLog "Got Jakarta-Tomcat, Location : \"$jak_loc\" "
}

function execution()
{
	serviceName=$1
	exeCMD=$2
	
	if [ $systemctlIsEnabled -eq 1 ];then
		${bash_service} $exeCMD $serviceName > /dev/null 2>&1
	else
		${bash_service} $serviceName $exeCMD > /dev/null 2>&1
	fi
}
> /dev/null 2>&1
function stop_tomcat(){
	echo -e "${Blue}[*] Stopping Tomcat......${NC}"
	writeLog "Stopping Tomcat......"
	cd /etc/rc.d/init.d/
	tomcat_service_file=$(grep -IRl ${jak_loc##*/} | grep -m 1 "apache\|tomcat")
	service $tomcat_service_file stop >> $logFilePath
	sleep 3
	service $tomcat_service_file stop >> $logFilePath
	
	process_id=`/bin/ps -fu $USER| grep "$jak_loc" | grep -v "grep" | awk '{print $2}'`
	if [ -z $process_id ];then
		process_id=`pgrep -f "$jak_loc"`
	fi
	if [ ! -z $process_id ];then
		if [ $process_id -gt 0 ];then
			service $tomcat_service_file stop > /dev/null 2>&1
			sleep 1
			`kill -9 $process_id > /dev/null 2>&1`
			`pkill -f "$jak_loc" > /dev/null 2>&1`
			`rm -rf "$jak_loc/work/Catalina"   > /dev/null 2>&1`
		fi
	fi
}
function start_tomcat(){
	cd /etc/rc.d/init.d/
	tomcat_service_file=$(grep -IRl ${jak_loc##*/} | grep -m 1 "apache\|tomcat")
	
	process_id=`/bin/ps -fu $USER| grep "$jak_loc" | grep -v "grep" | awk '{print $2}'`
	if [ -z $process_id ];then
		process_id=`pgrep -f "$jak_loc"`
	fi
	if [ ! -z $process_id ];then
		if [ $process_id -gt 0 ];then
			service $tomcat_service_file stop > /dev/null 2>&1
			sleep 2
			`kill -9 $process_id > /dev/null 2>&1`
			`pkill -f "jakarta-tomcat" > /dev/null 2>&1`
			`rm -rf "$jak_loc/work/Catalina" > /dev/null 2>&1`
		fi
	fi
	
	echo -e "${Blue}[*] Starting Tomcat ....${NC}"
	writeLog "Starting Tomcat ...."
	service $tomcat_service_file start >> $logFilePath
}
#Need to modify
function stop_switch(){
	
	SMSsignalingFolder=$1
	declare -i serviceStopFlag=0
	declare -i serviceStartFlag=0
	echo -e "${Blue}[*] Stopping $SMSsignalingFolder.........${NC}"
	writeLog "Stopping $SMSsignalingFolder........."
	
	now=$(date +'%d_%m_%Y_%H_%M_%S')
	shutdownFile="shutdownSMS_Server.sh"
	
	if [[ -e "$SMSsignalingFolder/log4j.properties" ]]; then
		log_properties="$SMSsignalingFolder/log4j.properties"
		logFile=$(cat $log_properties | grep '.log$' | gawk -F '=' '{print $2}'|gawk -F '\r' '{print $1}')
		
	else
		log_properties="$SMSsignalingFolder/log4j2.xml"
		logFile=$(cat $log_properties | grep -Pom1 '(?<=fileName=")[^"]+' | gawk -F '\r' '{print $1}')
	fi
	new_logFile="${logFile}_${now}"
	getSwitchSMPPPort
	getSwitchIP
	##Service Stopping doing here
	cd $SMSsignalingFolder
	sh $shutdownFile >> $logFilePath
	sh $shutdownFile >> $logFilePath
	sh $shutdownFile >> $logFilePath
	sleep 5
	process_id=`lsof -t -i @${SMSSwitchIP}:${SMSSwitchSMPPPort}`
	regex='TelRetailSMSServer .* shutting down successfully.'
	
	if [[ -e "${SMSsignalingFolder}/${logFile}" ]];then
		timeout 30 tail -f $SMSsignalingFolder/$logFile | while read line; do
			if [[ $line =~ $regex ]]; then
				echo -e "${Green}[*] $SMSsignalingFolder stopped Successfully ${NC}\n"
				writeLog "$SMSsignalingFolder stopped Successfully"
				serviceStopFlag=1
				pkill tail;
				break
			fi
		done
		if [[ ! -z "$process_id" ]];then
			`kill -9 $process_id > /dev/null 2>&1`
			printf "${Green}[*] $SMSsignalingFolder killed Successfully  ${NC}\n"
			writeLog "$SMSsignalingFolder killed Successfully"
		fi
	fi

	cd $SMSsignalingFolder
	mv $logFile $new_logFile > /dev/null 2>&1
}

function start_switch(){
	signalingFolder=$1
	echo -e "${Blue}[*] Starting $signalingFolder......... ${NC}"
	writeLog "Starting $signalingFolder........."
	runFile="runSMS_Server.sh"
	
	cd $SMSsignalingFolder
	sh $runFile >> $logFilePath
	
	regex='iTelRetailSMSServer .*  started successfully.'
	if [[ -e "$SMSsignalingFolder/log4j.properties" ]]; then
		log_properties="$SMSsignalingFolder/log4j.properties"
		logFile=$(cat $log_properties | grep '.log$' | gawk -F '=' '{print $2}'|gawk -F '\r' '{print $1}')
		
	else
		log_properties="$SMSsignalingFolder/log4j2.xml"
		logFile=$(cat $log_properties | grep -Pom1 '(?<=fileName=")[^"]+' | gawk -F '\r' '{print $1}')
	fi
	declare -i start_switch_flag=0
	sleep 10
	
	if [[ -e "${SMSsignalingFolder}/${logFile}" ]]; then
		timeout 30 tail -f $SMSsignalingFolder/$logFile | while read line; do
			if [[ $line =~ $regex ]]; then
				start_switch_flag=1;
				echo -e "${Green}[*] $SMSsignalingFolder started Successfully. ${NC}\n"
				writeLog "$SMSsignalingFolder started Successfully."
				pkill tail;
				break
			fi
		done
	fi
	
	process_id=`lsof -t -i @${SMSSwitchIP}:${SMSSwitchSMPPPort}`
	if [[ ( $start_switch_flag -ne 1 ) || ( -z "$process_id" ) ]]; then
		echo -e "${Red}[*] $SMSsignalingFolder started But need to check manually.${NC}\n"
		writeLog "$SMSsignalingFolder started But need to check manually. "
	fi
}

function stopSMSAppServer(){
	SMSAppServerFolder=$1
	echo -e "${Blue}[*] Stopping $SMSAppServerFolder.........${NC}"
	writeLog "Stopping $SMSAppServerFolder........."
	
	now="$(date +'%d_%m_%Y_%H_%M_%S')"
	
	shutdownFile="shutdowniTelSMSAppServer.sh"
	
	billing=${iTelSMSDBName##*iTelSMS}
	logFile=$(cat $SMSAppServerFolder/log4j.properties | grep '.log$' | gawk -F '=' '{print $2}'|gawk -F '\r' '{print $1}')
	
	new_logFile="${logFile}_${now}"
	
	#Stopping iTelSMSAppServer 
	cd $SMSAppServerFolder
	sh $shutdownFile >> $logFilePath
	sh $shutdownFile >> $logFilePath
	sh $shutdownFile >> $logFilePath
	declare -i count=0
	regex='Going To ShutDown At'
	
	
	if [[ -e "$SMSAppServerFolder/$logFile" ]];then
		timeout 30 tail -f $SMSAppServerFolder/$logFile | while read line; do
			if [ $lsofStatus -eq 1 ]; then
				if [[ $line =~ $regex ]]; then
					unset process_array_app_server;
					declare -a process_array_app_server=($(ps -axu | grep iTelSMSAppServer.jar | grep -v grep | gawk -F ' ' 'BEGIN{ORS=" "}{print $2}'))
					if [[ ${#process_array_app_server[@]} -gt 0 ]];then
						for i in "${process_array_app_server[@]}"; do
							process_folder=$(pwdx $i | gawk -F ": " '{print $2}')
							if [[ $SMSAppServerFolder =~ "$process_folder" ]];then
								app_server_process_id=$i
								kill -9 $i 2>&1
								break
							fi
						done
					fi
					pkill tail;
				fi
			fi	
		done
		echo -e "${Green}[*] $SMSAppServerFolder stopped Successfully  ${NC}\n"
		writeLog "$SMSAppServerFolder stopped Successfully"
		serviceStopFlag=1
	fi
	
	mv $logFile $new_logFile > /dev/null 2>&1
}
function startSMSAppServer(){
	SMSAppServerFolder=$1
	echo -e "${Blue}[*] Starting $SMSAppServerFolder.........${NC}"
	writeLog "Starting $SMSAppServerFolder........."
	
	now="$(date +'%d_%m_%Y_%H_%M_%S')"
	
	runFile="runiTelSMSAppServer.sh"
	
	billing=${iTelSMSDBName##*iTelSMS}
	logFile=$(cat $SMSAppServerFolder/log4j.properties | grep '.log$' | gawk -F '=' '{print $2}'|gawk -F '\r' '{print $1}')
	new_logFile="${logFile}_${now}"
	
	##Starting iTelSMSAppServer doing here
	cd $SMSAppServerFolder
	sh $runFile >> $logFilePath
	sleep 5
}
function getDBDetails()
{
        
	dbConnFile=$1
	dbUser=`grep -Pom1 '(?<=USER_NAME = ")[^"]+' $dbConnFile | head -1`
	dbPass=`grep -Pom1 '(?<=PASSWORD = ")[^"]+' $dbConnFile | head -1`
	dbFullURL=`grep -Pom1 '(?<=DATABASE_URL=")[^"]+' $dbConnFile | head -1`
	dbName=${dbFullURL##*/}
	is_diff_config=$(echo $dbName| grep "useEncoding")
	if [[ -z "$is_diff_config" ]];then
		dbName=`echo $dbName | gawk -F"?useUnicode" '{print $1}'`
	else
		dbName=`echo $dbName | gawk -F"?useEncoding" '{print $1}'`
	fi
	is_diff_config2=$(echo $dbName | grep "useSSL")
	if [[ ! -z "$is_diff_config2" ]]; then
		dbName=`echo $dbName | gawk -F"?useSSL" '{print $1}'`
	fi
	dbURL=${dbFullURL##*://}
	dbIpPort=${dbURL%%/*}
	var=$(echo $dbIpPort | awk -F":" '{print $1,$2}')
	set -- $var
	if [ -z $1 ];then
		dbHost='localhost'
	else
		dbHost=$1
	fi  
	if [ -z $2 ];then
		dbPort=3306
	else
		dbPort=$2
	fi  
	echo "$dbName,$dbHost,$dbPort,$dbUser,$dbPass"
	
}
function getDBDetailsAppServer()
{
	dbConnFile=$1
	dbUser=`grep -Pom1 '(?<=USER_NAME = ")[^"]+' $dbConnFile | head -1`
	dbPass=`grep -Pom1 '(?<=PASSWORD = ")[^"]+' $dbConnFile | head -1`
	dbFullURL=`grep -Pom1 '(?<=DATABASE_URL=")[^"]+' $dbConnFile | head -1`
	dbName=${dbFullURL##*/}
	is_diff_config=$(echo $dbName | grep "useSSL")
	
	if [[ -z "$is_diff_config" ]];then
		dbName=`echo $dbName | gawk -F"?useUnicode" '{print $1}'`
	else
		dbName=`echo $dbName | gawk -F"?useSSL" '{print $1}'`
	fi
	is_diff_config2=$(echo $dbName | grep "useEncoding")
	if [[ ! -z "$is_diff_config2" ]];then
		dbName=`echo $dbName | gawk -F"?useEncoding" '{print $1}'`
	fi
	dbURL=${dbFullURL##*://}
	dbIpPort=${dbURL%%/*}
	var=$(echo $dbIpPort | awk -F":" '{print $1,$2}')
	set -- $var
	if [ -z $1 ];then
		dbHost='localhost'
	else
		dbHost=$1
	fi  
	if [ -z $2 ];then
		dbPort=3306
	else
		dbPort=$2
	fi  
	echo "$dbName,$dbHost,$dbPort,$dbUser,$dbPass"
	
}
function checkAndGetDBName(){
	
	SMSsignalingFolder=$1
	iTelSMSDBConf="$SMSsignalingFolder/DatabaseConnection.xml"


	
	writeLog "Going to Check DB Connection Files"
	
	if [ -f "$iTelSMSDBConf" ];
	then
		errorCounter=0
		writeLog "Got iTelSMS DB Connection File"
	else
		writeLog "iTelSMS DB Connection File Not Found"
		return 1
	fi						
	
	RESULT=$( getDBDetails $iTelSMSDBConf )
	iTelSMSDBName=`get_rtrn $RESULT 1`
	iTelSMSDBHost=`get_rtrn $RESULT 2`
	iTelSMSDBPort=`get_rtrn $RESULT 3`
	iTelSMSDBUser=`get_rtrn $RESULT 4`
	iTelSMSDBPass=`get_rtrn $RESULT 5`
	
	if [ "${iTelSMSDBPass}" == "" ]
	then
		iTelSMSDBPass=""
	else
		iTelSMSDBPass="-p${iTelSMSDBPass}"
	fi
	writeLog "Got iTelSMSBilling Database name \"$iTelSMSDBName\" from DB Config file "
	
	iTelSMSResult=`mysql -h $iTelSMSDBHost -P $iTelSMSDBPort -u$iTelSMSDBUser $iTelSMSDBPass --skip-column-names -e "SHOW DATABASES LIKE '$iTelSMSDBName'"`
	if [ "$iTelSMSResult" == "$iTelSMSDBName" ]; then
		writeLog "Checked and Got Database name \"$iTelSMSDBName\" is valid"
		iTelSMSDBName=${iTelSMSDBName}
	else
		writeLog "Database \"$iTelSMSDBName\" does not exist."
		return 4
	fi

	return 0
}

function checkAndGetFailedDBName(){
	
	SMSsignalingFolder=$1
	iTelSMSDBConf="$SMSsignalingFolder/DatabaseConnection_Failed.xml"


	
	writeLog "Going to Check DB Connection Files"
	
	if [ -f "$iTelSMSDBConf" ];
	then
		errorCounter=0
		writeLog "Got iTelSMSFailed DB Connection File"
	else
		writeLog "iTelSMSFailed DB Connection File Not Found"
		exit
		return 1
	fi						
	
	RESULT=$( getDBDetails $iTelSMSDBConf )
	iTelSMSFailedDBName=`get_rtrn $RESULT 1`
	iTelSMSDBHost=`get_rtrn $RESULT 2`
	iTelSMSDBPort=`get_rtrn $RESULT 3`
	iTelSMSDBUser=`get_rtrn $RESULT 4`
	iTelSMSDBPass=`get_rtrn $RESULT 5`
	
	if [ "${iTelSMSDBPass}" == "" ]
	then
		iTelSMSDBPass=""
	else
		iTelSMSDBPass="-p${iTelSMSDBPass}"
	fi
	writeLog "Got iTelSMSFailedBilling Database name \"$iTelSMSFailedDBName\" from DB Config file "
	
	iTelSMSResult=`mysql -h $iTelSMSDBHost -P $iTelSMSDBPort -u$iTelSMSDBUser $iTelSMSDBPass --skip-column-names -e "SHOW DATABASES LIKE '$iTelSMSFailedDBName'"`
	if [ "$iTelSMSResult" == "$iTelSMSFailedDBName" ]; then
		writeLog "Checked and Got Database name \"$iTelSMSFailedDBName\" is valid"
		iTelSMSFailedDBName=${iTelSMSFailedDBName}
	else
		writeLog "Database \"$iTelSMSFailedDBName\" does not exist."
		return 4
	fi

	return 0
}

function checkOSProfile(){
	OS=`lowercase \`uname\``
	KERNEL=`uname -r`
	MACH=`uname -m`

	if [ "${OS}" == "windowsnt" ]; then
		OS=windows
	elif [ "${OS}" == "darwin" ]; then
		OS=mac
	else
		OS=`uname`
		if [ "${OS}" = "SunOS" ] ; then
			OS=Solaris
			ARCH=`uname -p`
			OSSTR="${OS} ${REV}(${ARCH} `uname -v`)"
		elif [ "${OS}" = "AIX" ] ; then
			OSSTR="${OS} `oslevel` (`oslevel -r`)"
		elif [ "${OS}" = "Linux" ] ; then
			if [ -f /etc/redhat-release ] ; then
				DistroBasedOn='RedHat'
				DIST=`cat /etc/redhat-release |sed s/\ release.*//`
				PSUEDONAME=`cat /etc/redhat-release | sed s/.*\(// | sed s/\)//`
				REV=`cat /etc/redhat-release | sed s/.*release\ // | sed s/\ .*//`
			elif [ -f /etc/SuSE-release ] ; then
				DistroBasedOn='SuSe'
				PSUEDONAME=`cat /etc/SuSE-release | tr "\n" ' '| sed s/VERSION.*//`
				REV=`cat /etc/SuSE-release | tr "\n" ' ' | sed s/.*=\ //`
			elif [ -f /etc/mandrake-release ] ; then
				DistroBasedOn='Mandrake'
				PSUEDONAME=`cat /etc/mandrake-release | sed s/.*\(// | sed s/\)//`
				REV=`cat /etc/mandrake-release | sed s/.*release\ // | sed s/\ .*//`
			elif [ -f /etc/debian_version ] ; then
				DistroBasedOn='Debian'
				if [ -f /etc/lsb-release ] ; then
			        	DIST=`cat /etc/lsb-release | grep '^DISTRIB_ID' | awk -F=  '{ print $2 }'`
			                PSUEDONAME=`cat /etc/lsb-release | grep '^DISTRIB_CODENAME' | awk -F=  '{ print $2 }'`
			                REV=`cat /etc/lsb-release | grep '^DISTRIB_RELEASE' | awk -F=  '{ print $2 }'`
            			fi
			fi
			if [ -f /etc/UnitedLinux-release ] ; then
				DIST="${DIST}[`cat /etc/UnitedLinux-release | tr "\n" ' ' | sed s/VERSION.*//`]"
			fi
			OS=`lowercase $OS`
			DIST=`lowercase $DIST`
			DistroBasedOn=`lowercase $DistroBasedOn`
		 	readonly OS
		 	readonly DIST
			readonly DistroBasedOn
		 	readonly PSUEDONAME
		 	readonly REV
		 	readonly KERNEL
		 	readonly MACH
		fi

	fi
}
function downloadSMSUpdateResources(){
	
	upInfo=$1
	
	echo -e "${Blue}[*] Going to download update resources.Please wait for a while......${NC}"
	writeLog "Trying to download update resources..."
	
	newRourceLocation="/SMSLatestDownloadsResource"
	cd /
	rm -rf $newRourceLocation
	mkdir $newRourceLocation
	cd $newRourceLocation
	
	fileURLArray[0]="https://supportresources.revesoft.com:4430/media/SMS%20Switch/SMS%20Update%20Script%20Resources/SMSUpdateResources.zip"
	fileURLArray[1]="https://supportresources.revesoft.com:4430/media/SMS%20Switch/SMS%20Switch%20Resources/updatebilling317to318.zip"
	
	fileURLArray[2]="https://supportresources.revesoft.com:4430/media/SMS%20Switch/SMS%20AppServer%20jar/iTelSMSAppServer.jar"
	
	for url in "${fileURLArray[@]}";do
		echo "$url"
		wget --no-check-certificate --server-response -q -o wgetOut $url
		_wgetHttpCode=`cat wgetOut | gawk '/HTTP/{ print $2 }'`
		
		if [ "$_wgetHttpCode" != "200" ];then
			echo "Download Failed from \"$url\" "
			writeLog "Download Failed from \"$url\" "
			dwError=`cat wgetOut`
			writeLog "Error :  $dwError"
			exit
			return 0
		fi
		
		
	done
	
	
	echo -e "${Blue}[*] Update Resource Downloaded Successfully${NC}"
	writeLog "Update Resource Downloaded Successfully"
	unzip -o SMSUpdateResources.zip > /dev/null 2>&1
	return 1	
}
function checkSMSSwitchInLocal(){
	writeLog "Checking and Listing all WholeSaleSMSServer Switches from \"/usr/local/\".........."
	declare -i initialLoop=0
	services=()
	for dir in /usr/local/WholeSaleSMSServer*  ;
	do
		if [ $initialLoop -eq 0 ]
		then
		  initialLoop=1;
		  pwd > pw;
		  var_rm=$(<pw);
		  var_rm="$var_rm/upadate.sh";
		  rm -f $var_rm;
		  rm -f pw;
		fi
		if [ -d "$dir" ]; then
			services+=($dir)
		fi
	done
	totalService=${#services[@]}
	if [ $totalService -eq 0 ];then
		printf "\n${BRed}No Switch WholeSaleSMSServer Signaling Found in /usr/local/ . Please check/update Manually.${NC}\n\n"
		writeLog "No Switch WholeSaleSMSServer Signaling Found in /usr/local/ . Please check/update Manually."
		exit
	fi
	writeLog "Got Total \"$totalService\" WholeSaleSMSServer Signaling in \"/usr/local/\""
}
function iTelSMSAppIsExists(){
	
	writeLog "Checking iTelSMSAppServer in /usr/local/..........."
	
	declare -i iTelAppFlag=0
	iTelSMSAppServerName=""
	
	for dir in /usr/local/iTelSMSAppS* ;
	do
		if [ -d "$dir" ]; then
			iTelSMSDBConf="$dir/DatabaseConnection.xml"
			RESULT=$( getDBDetailsAppServer $iTelSMSDBConf )
			iTelAppDBName=`get_rtrn $RESULT 1`
			
			if [ "$iTelAppDBName" == "$iTelSMSDBName" ]; then
				iTelAppFlag=1
				iTelSMSAppServerName=$dir
				writeLog "Got iTelSMSAppServer as \"$iTelSMSAppServerName\" "
				break;
			fi
		fi
	done
	if [ $iTelAppFlag -eq 1 ];then
		return 1
	else
		writeLog "Didn't get iTelSMSAppServer for this Switch"
		return 0
	fi
}

function getValidSMSBilling(){
	iTelSMSDBName=$1
	SMSBillingFolder=()

	for webDir in $jak_loc/webapps/*
	do
		#printf "\n"
		webDir=${webDir%*/}
		#echo "Now Checking Billing... ${webDir##*/}"
		billingName=${webDir##*/}
		DBConnFile="$jak_loc/webapps/${webDir##*/}/WEB-INF/classes/DatabaseConnection.xml"
		
		if [ -f "$DBConnFile" ]; then
			
			RESULT=$( getDBDetails $DBConnFile )
			SMSDBName=`get_rtrn $RESULT 1`
			
			if [ "$SMSDBName" == "$iTelSMSDBName" ]; then
				SMSBillingFolder+=($billingName)
			fi
		fi
	
	done
	totaliTelSMSBilling=${#SMSBillingFolder[@]}
	if [ $totaliTelSMSBilling -eq 0 ];then
		writeLog "No Valid Billing Folder is connected with $SMSDBName DB"
		errorCounter=10
		return 0
	else
		errorCounter=0
		return 1
	fi
	totaliSMSBilling=${#SMSBillingFolder[@]}
}



function get_rtrn(){
    echo `echo $1|cut --delimiter=, -f $2`
}

function getTodaySMSHistoryTable(){
	unset smsHistoryTable
	day=`mysql --skip-column-names -h $iTelSMSDBHost -P  $iTelSMSDBPort -u $iTelSMSDBUser $iTelSMSDBPass $iTelSMSDBName -e "select lpad(day(now()),2,0);"`
	month=`mysql --skip-column-names -h $iTelSMSDBHost -P  $iTelSMSDBPort -u $iTelSMSDBUser $iTelSMSDBPass $iTelSMSDBName -e "select lpad(month(now()),2,0);"`
	year=`mysql --skip-column-names -h $iTelSMSDBHost -P  $iTelSMSDBPort -u $iTelSMSDBUser $iTelSMSDBPass $iTelSMSDBName -e "select year(now());"`
	smsHistoryTable=`mysql --skip-column-names -h $iTelSMSDBHost -P  $iTelSMSDBPort -u $iTelSMSDBUser $iTelSMSDBPass $iTelSMSDBName -e "show tables like 'vbSMSHistory_${year}_${month}_${day}';"`

}
function getTodaySMSPacketLoggerTable(){
	unset smsPacketLoggerTable
	day=`mysql --skip-column-names -h $iTelSMSDBHost -P  $iTelSMSDBPort -u $iTelSMSDBUser $iTelSMSDBPass $iTelSMSDBName -e "select lpad(day(now()),2,0);"`
	month=`mysql --skip-column-names -h $iTelSMSDBHost -P  $iTelSMSDBPort -u $iTelSMSDBUser $iTelSMSDBPass $iTelSMSDBName -e "select lpad(month(now()),2,0);"`
	year=`mysql --skip-column-names -h $iTelSMSDBHost -P  $iTelSMSDBPort -u $iTelSMSDBUser $iTelSMSDBPass $iTelSMSDBName -e "select year(now());"`
	smsPacketLoggerTable=`mysql --skip-column-names -h $iTelSMSDBHost -P  $iTelSMSDBPort -u $iTelSMSDBUser $iTelSMSDBPass $iTelSMSDBName -e "show tables like 'vbSMSPacketLogger_${year}_${month}_${day}';"`
	
}
function getAllSMSResellerHistoryTables(){
	SMSResellerHistorTables=()
	for tables in `mysql --skip-column-names -h $iTelSMSDBHost -P  $iTelSMSDBPort -u $iTelSMSDBUser $iTelSMSDBPass $iTelSMSDBName -e "show tables like 'vbSMSResellerHistory_2%';"`;do
		SMSResellerHistorTables+=($tables);
	done

}
function getAllSMSHistoryTables(){
	SMSHistoryTables=()
	for tables in `mysql --skip-column-names -h $iTelSMSDBHost -P  $iTelSMSDBPort -u $iTelSMSDBUser $iTelSMSDBPass $iTelSMSDBName -e "show tables like 'vbSMSHistory_2%';"`;do
		SMSHistoryTables+=($tables);
	done

}
function getAllPacketLoggerTablesFromiTelSMSDB(){
	PacketLoggerTables=()
	for tables in `mysql --skip-column-names -h $iTelSMSDBHost -P  $iTelSMSDBPort -u $iTelSMSDBUser $iTelSMSDBPass $iTelSMSDBName -e "show tables like 'vbSMSPacketLogger%';"`;do
		PacketLoggerTables+=($tables);
	done

}
########=============== Initializing System ======>>>>>>
function initializingSystem(){
	clear
	printf "\n${NC}\n"
	mkdir -p $logFileLocation > /dev/null 2>&1 
	if [ -f "$logFileLocation/$logFileName" ];then
		cat $logFileLocation/$logFileName > $logFileLocation/$logFileName\_$now
		>$logFileLocation/$logFileName
	fi
	
	echo -ne "${Blue}                  System is initializing. Please wait for a while...${NC}"'\r'
	
	writeLog "================================= Prorgam Starting ================================="
	
	writeLog "--------- Initializing Variables and System itSelf -------"
	getColorCodes
	clear
	echo -ne "${Blue}                  System is initializing. Please wait for a while....${NC}"'\r'
	removeScriptFile
	clear
	echo -ne "${Blue}                  System is initializing. Please wait for a while......${NC}"'\r'
	checkBashServicePath
	clear
	echo -ne "${Blue}                  System is initializing. Please wait for a while..........${NC}"'\r'
	checkLsofCommand
	clear
	echo -ne "${Blue}                  System is initializing. Please wait for a while...............${NC}"'\r'
	checkUnzipCommand
	clear
	echo -ne "${Blue}                  System is initializing. Please wait for a while..................${NC}"'\r'
	getMYSQLDataDirectory
	clear
	echo -ne "${Blue}                  System is initializing. Please wait for a while.....................${NC}"'\r'
	getJakartaTomcatInfo
	clear
	echo -ne "${Blue}                  System is initializing. Please wait for a while........................${NC}"'\r'
	search_jdk
	clear
	echo -ne "${Blue}                  System is initializing. Please wait for a while........................${NC}"'\r'
	checkSMSSwitchInLocal
	clear
	
	printf "\n${Green}                  Initialization done.........${NC}\n"
	sleep 2
	echo "."
	echo "."
	writeLog "-----------------  Initialization Done ----------------- "
	writeLog "-----------------   ----------------   ----------------- "
}

function updateSQLSMSWholesaleServer301to306(){
	echo -e "${Blue}[*] Updating SQL for 306....${NC}"
	writeLog "Updating SQL for 306...."
	# SQL Updates
	sqlCommand="mysql -h $iTelSMSDBHost -P $iTelSMSDBPort -u$iTelSMSDBUser $iTelSMSDBPass --force -D $iTelSMSDBName -e "
	sql1="drop table vbSMSPacketLogger;"
	sql2="CREATE TABLE vbSMSPacketLogger (spReferenceID decimal(15,0) NOT NULL,spSenderID decimal(18,0) DEFAULT NULL,spRequestTime bigint(20) NOT NULL,spSessionID varchar(50) COLLATE utf8_unicode_ci NOT NULL,spSMData text COLLATE utf8_unicode_ci NOT NULL,spProtocolType decimal(4,0) DEFAULT NULL,spPacketDirection decimal(4,0) DEFAULT NULL,spReceiverID decimal(18,0) DEFAULT NULL,spSmsServer varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL, PRIMARY KEY (spReferenceID)) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;"
	sql3="INSERT into vbMenu values (125, 42, 'Live SMS Log', 'link', 'Live SMS Log',0);"
	sql4="INSERT into vbPermission (prPermissionID, prRoleID, prMenuID, prType) values (125, 1, 125, 3);"
	sql5="insert into vbMenu values(163, 21, 'System Alert','link','System Alert',0);"
	sql6="insert into vbMenu values(165, 163, 'Alarm Configuration','link','Alarm Configuration',0);"
	sql7="INSERT INTO vbPermission (prPermissionID, prRoleID, prMenuID, prType) VALUES (163, 1, 163, 3);"
	sql8="INSERT INTO vbPermission (prPermissionID, prRoleID, prMenuID, prType) VALUES (165, 1, 165, 3);"
	sql9="ALTER table vbSMSProviderCredentials add spcMessageIdType tinyInt not null default 0 after spcProviderPassword;"
	writeLog "SQL Running: $sql1"
	sqlUpdate306_2=$($sqlCommand "$sql1"   2>&1 | tee -a $sqlErrorLog)
	writeLog "SQL Running: $sql2"
	sqlUpdate306_2=$($sqlCommand "$sql2"   2>&1 | tee -a $sqlErrorLog)
	writeLog "SQL Running: $sql3"
	sqlUpdate306_3=$($sqlCommand "$sql3"   2>&1 | tee -a $sqlErrorLog)
	writeLog "SQL Running: $sql4"
	sqlUpdate306_4=$($sqlCommand "$sql4"   2>&1 | tee -a $sqlErrorLog)
	writeLog "SQL Running: $sql5"
	sqlUpdate306_5=$($sqlCommand "$sql5"   2>&1 | tee -a $sqlErrorLog)
	writeLog "SQL Running: $sql6"
	sqlUpdate306_6=$($sqlCommand "$sql6"   2>&1 | tee -a $sqlErrorLog)
	writeLog "SQL Running: $sql7"
	sqlUpdate306_7=$($sqlCommand "$sql7"   2>&1 | tee -a $sqlErrorLog)
	writeLog "SQL Running: $sql8"
	sqlUpdate306_8=$($sqlCommand "$sql8"   2>&1 | tee -a $sqlErrorLog)
	writeLog "SQL Running: $sql9"
	sqlUpdate306_9=$($sqlCommand "$sql9"   2>&1 | tee -a $sqlErrorLog)
	getTodaySMSPacketLoggerTable
	
	if [[ ! -z "$smsPacketLoggerTable" ]]; then
		sql10="alter table $smsPacketLoggerTable add column spProtocolType decimal(4,0) DEFAULT NULL after spSMData;"
		writeLog "SQL Running: $sql10"
		sqlUpdate306_10=$($sqlCommand "$sql10"   2>&1 | tee -a $sqlErrorLog)
		sql11="alter table $smsPacketLoggerTable add column spPacketDirection decimal(4,0) DEFAULT NULL after spProtocolType;"
		writeLog "SQL Running: $sql11"
		sqlUpdate306_11=$($sqlCommand "$sql11"   2>&1 | tee -a $sqlErrorLog)
		sql12="alter table $smsPacketLoggerTable add column spSmsServer varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL;"
		writeLog "SQL Running: $sql12"
		sqlUpdate306_12=$($sqlCommand "$sql12"   2>&1 | tee -a $sqlErrorLog)
		
	fi
	getAllPacketLoggerTablesFromiTelSMSDB
	for table in ${PacketLoggerTables[@]};do
		sql13="alter table $iTelSMSDBName.$table add column spProtocolType decimal(4,0) DEFAULT NULL after spSMData;"
		writeLog "SQL Running: $sql13"
		up_sql1=$($sqlCommand "$sql13"   2>&1 | tee -a $sqlErrorLog)
		sql14="alter table $iTelSMSDBName.$table add column spPacketDirection decimal(4,0) DEFAULT NULL after spProtocolType;"
		writeLog "SQL Running: $sql14"
		up_sql2=$($sqlCommand "$sql14"   2>&1 | tee -a $sqlErrorLog)
		sql15="alter table $iTelSMSDBName.$table add column spSmsServer varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL;"
		writeLog "SQL Running: $sql15"
		up_sql3=$($sqlCommand "$sql15"   2>&1 | tee -a $sqlErrorLog)
	done
}





function updateSQLSMSWholesaleServer308(){
	echo -e "${Blue}[*] Updating SQL for 308....${NC}"
	writeLog "Updating SQL for 308...."
	
	
	sqlCommand="mysql -h $iTelSMSDBHost -P $iTelSMSDBPort -u$iTelSMSDBUser $iTelSMSDBPass --force -D $iTelSMSDBName -e"
	sql1="alter table vbSMSProviderCredentials modify column spcOrgTON tinyint(4) default -1;"
	writeLog "SQL Running: $sql1"
	sqlUpdate308_1=$($sqlCommand "$sql1"   2>&1 | tee -a $sqlErrorLog)
	
	sql2="alter table vbSMSProviderCredentials modify column spcOrgNPI tinyint(4) default -1;"
	writeLog "SQL Running: $sql2"
	sqlUpdate308_2=$($sqlCommand "$sql2"   2>&1 | tee -a $sqlErrorLog)
	
	sql3="alter table vbSMSProviderCredentials modify column spcDestTON tinyint(4) default -1;"
	writeLog "SQL Running: $sql3"
	sqlUpdate308_3=$($sqlCommand "$sql3"   2>&1 | tee -a $sqlErrorLog)
	
	sql4="alter table vbSMSProviderCredentials modify column spcDestNPI tinyint(4) default -1;"
	writeLog "SQL Running: $sql4"
	sqlUpdate308_4=$($sqlCommand "$sql4"   2>&1 | tee -a $sqlErrorLog)
	
}

function updateSQLSMSWholesaleServer308to313(){
	echo -e "${Blue}[*] Updating SQL for 313....${NC}"
	writeLog "Updating SQL for 313...."
	
	
	sqliTelSMSDBCommand="mysql -h $iTelSMSDBHost -P $iTelSMSDBPort -u$iTelSMSDBUser $iTelSMSDBPass --force -D $iTelSMSDBName -e"
	sqliTelSMSFailedDBCommand="mysql -h $iTelSMSDBHost -P $iTelSMSDBPort -u$iTelSMSDBUser $iTelSMSDBPass --force -e"
	echo -e "${Blue}[*] Updating Database for 313....${NC}"
	writeLog "Updating Database for 313....."
	billingNameForWholealeFolder=${SMSsignalingFolder#*WholeSaleSMSServer}
	failedDBName=iTelSMSFailed${billingNameForWholealeFolder}
	# SQL Updates
	sql1="CREATE INDEX rhSMSHistoryRefID_index ON vbSMSResellerHistory(rhSMSHistoryRefID);"
	sql2="CREATE INDEX rhResellerAccountID_index ON vbSMSResellerHistory(rhResellerAccountID);"
	sql3="ALTER TABLE vbSMSResellerHistory ENGINE=MyISAM;"
	writeLog "SQL Running: $sql1"
	sqlUpdate313_1=$($sqliTelSMSDBCommand "$sql1"   2>&1 | tee -a $sqlErrorLog)
	writeLog "SQL Running: $sql2"
	sqlUpdate313_2=$($sqliTelSMSDBCommand "$sql2"   2>&1 | tee -a $sqlErrorLog)
	writeLog "SQL Running: $sql3"
	sqlUpdate313_3=$($sqliTelSMSDBCommand "$sql3"   2>&1 | tee -a $sqlErrorLog)
	
	#Get All Reseller History Tables
	getAllSMSResellerHistoryTables
	
	
	for table in ${SMSResellerHistorTables[@]};do
		sql4="CREATE INDEX rhSMSHistoryRefID_index ON $table(rhSMSHistoryRefID);"
		sql5="CREATE INDEX rhResellerAccountID_index ON $table(rhResellerAccountID);"
		sql6="ALTER TABLE $table ENGINE=MyISAM;"
		writeLog "SQL Running: $sql4"
		up_sql1=$($sqliTelSMSDBCommand "$sql4"   2>&1 | tee -a $sqlErrorLog)
		writeLog "SQL Running: $sql5"
		up_sql2=$($sqliTelSMSDBCommand "$sql5"   2>&1 | tee -a $sqlErrorLog)
		writeLog "SQL Running: $sql6"
		up_sql3=$($sqliTelSMSDBCommand "$sql6"   2>&1 | tee -a $sqlErrorLog)
		
	done

	
	#Get All History Tables
	getAllSMSHistoryTables
	
	
	for table in ${SMSHistoryTables[@]};do
		sql7="alter table $table drop index shRequestTime_index;"
		sql8="create index shOrgAccountID_index on $table (shOrgAccountID);"
		sql9="create index shTerAccountID_index on $table (shTerAccountID);"
		writeLog "SQL Running: $sql7"
		up_sql1=$($sqliTelSMSDBCommand "$sql7"   2>&1 | tee -a $sqlErrorLog)
		writeLog "SQL Running: $sql8"
		up_sql2=$($sqliTelSMSDBCommand "$sql8"   2>&1 | tee -a $sqlErrorLog)
		writeLog "SQL Running: $sql9"
		up_sql3=$($sqliTelSMSDBCommand "$sql9"   2>&1 | tee -a $sqlErrorLog)
		
	done
	
	sql10="ALTER TABLE vbSMSResellerCampaign ENGINE=MyISAM;"
	sql11="CREATE INDEX rcSMSCampaignID_index on vbSMSResellerCampaign(rcSMSCampaignID);"
	sql12="CREATE INDEX rcResellerAccountID_index on vbSMSResellerCampaign(rcResellerAccountID);"
	sql13="ALTER TABLE vbSMSProviderCredentials ADD spcRequestHeaders VARCHAR(500);"
	sql14="drop table smsStatusCode;"
	sql15="CREATE TABLE smsStatusCode(scID DECIMAL(18,0) PRIMARY KEY,scCode INT NOT NULL UNIQUE,scCodeDescription VARCHAR(500) NOT NULL,scCodeText Varchar(100) not null,scLastModificationTime BIGINT NOT NULL DEFAULT 0);"
	sql16="INSERT INTO smsStatusCode(scID,scCode,scCodeDescription,scCodeText,scLastModificationTime)VALUES(1, -1, 'Org Client Not Found','Authorization Failed', 0),(2, -3, 'Invalid Dest No.','Authorization Failed', 0),(3, -4, 'Insufficient Balance', 'Authorization Failed',0),(4, -5, 'Org Rate Not Found','Authorization Failed', 0),(5, -6, 'Org Blocked','Authorization Failed', 0),(6, -7, 'Invalid Sender ID.','Authorization Failed', 0),(7, -37, 'Submit Response Got Error','Submission Failed', 0),(8, -38, 'Failed Delivery Received By Delivery Report','Delivery Failed', 0),(9, -42, 'Authorization Failed', 'Authorization Failed',0),(10, -43, 'Route not found','Submission Failed', 0),(11, -44, 'ContactNo Blocked', 'Authorization Failed',0),(12, -45, 'ContactNo Blocked by Admin','Authorization Failed', 0),(13, -46, 'Dipping Failed','Authorization Failed', 0),(14, -47, 'Content not Whitelisted','Authorization Failed', 0),(15, -48, 'URL Blocked','Authorization Failed', 0),(16, -49, 'Rejected For SenderID/Text Blocking','Authorization Failed', 0),(17, -52, 'License Limit Exceeded','Authorization Failed', 0),(18, -53, 'Message Queue Full','Submission Failed', 0),(19, -54, 'Sender ID Empty','Authorization Failed', 0),(20, -55, 'Destination ID Empty','Authorization Failed', 0),(21, -56, 'Messsage Content Empty','Authorization Failed', 0),(22, -57, 'Submit Transaction Timeout','Submission Failed', 0),(23, -101, 'Org Client Not Found & Submitted','Authorization Failed', 0),(24, -103, 'Invalid Dest No & Submitted','Authorization Failed', 0),(25, -104, 'Insufficient Balance & Submitted','Authorization Failed', 0),(26, -105, 'Org Rate Not Found & Submitted','Authorization Failed', 0),(27, -106, 'Org Blocked & Submitted','Authorization Failed', 0),(28, -107, 'Invalid Sender ID & Submitted','Authorization Failed', 0),(29, -138, 'Failed Delivery Received By Delivery Report & Submitted','Delivery Failed', 0),(30, -142, 'Authorization Failed & Submitted','Authorization Failed', 0),(31, -143, 'Route not found & Submitted','Submission Failed', 0),(32, -144, 'ContactNo Blocked & Submitted','Authorization Failed', 0),(33, -145, 'ContactNo Blocked by Admin & Submitted','Authorization Failed', 0),(34, -146, 'Dipping Failed & Submitted','Authorization Failed', 0),(35, -147, 'Content not Whitelisted & Submitted','Authorization Failed', 0),(36, -148, 'URL Blocked & Submitted','Authorization Failed', 0),(37, -149, 'Rejected For SenderID/Text Blocking & Submitted','Authorization Failed', 0),(38, -152, 'License Limit Exceeded & Submitted','Authorization Failed', 0),(39, -157, 'Submit Transaction Timeout & Submitted','Submission Failed', 0),(40, 0, 'Submission Failed','Submission Failed', 0),(41, 1, 'Delivery Success','Delivered', 0),(42, 2, 'Pending','Pending', 0),(43, 3, 'Failed','Submission Failed', 0),(44, 4, 'Submitted','Submitted', 0),(45, 5, 'Unparsable Response','Submission Failed', 0),(46, 6, 'Delivery Success & Submitted','Delivered', 0),(47, 7, 'Submission Failed & Submitted','Submission Failed', 0),(48, 8, 'Unathenticated','Pending', 0),(49, 9, 'Pending for Approval','Pending for Approval', 0),(50, 10, 'Waiting for Submit Response','Pending', 0);"
	sql17="alter table vbSMSHistory drop index shRequestTime_index;"
	sql18="create index shOrgAccountID_index on vbSMSHistory(shOrgAccountID);"
	sql19="create index shTerAccountID_index on vbSMSHistory(shTerAccountID);"
	
	sql20="alter table vbSMSCampaign change column  campaignText campaignText text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci not null;"
	sql21="alter table vbSMSHistory change column shContent shContent text CHARACTER set utf8mb4 COLLATE utf8mb4_unicode_ci;"
	sql22="update vbVersionInfo set signalingVersion='$latestVersionOfSignaling',webVersion='$latestVersionOfBilling',mediaVersion='0.0.0';"
	
	
	sql23="alter table vbSMSPacketLogger change column spSMData spSMData text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci not null;"
	writeLog "SQL Running: $sql10"
	sqlUpdate313_4=$($sqliTelSMSDBCommand "$sql10"   2>&1 | tee -a $sqlErrorLog)
	writeLog "SQL Running: $sql11"
	sqlUpdate313_5=$($sqliTelSMSDBCommand "$sql11"   2>&1 | tee -a $sqlErrorLog)
	writeLog "SQL Running: $sql12"
	sqlUpdate313_6=$($sqliTelSMSDBCommand "$sql12"   2>&1 | tee -a $sqlErrorLog)
	writeLog "SQL Running: $sql13"
	sqlUpdate313_7=$($sqliTelSMSDBCommand "$sql13"   2>&1 | tee -a $sqlErrorLog)
	writeLog "SQL Running: $sql14"
	sqlUpdate313_7=$($sqliTelSMSDBCommand "$sql14"  2>&1 | tee -a $sqlErrorLog)
	writeLog "SQL Running: $sql15"
	sqlUpdate313_7=$($sqliTelSMSDBCommand "$sql15"  2>&1 | tee -a $sqlErrorLog)
	writeLog "SQL Running: $sql16"
	sqlUpdate313_8=$($sqliTelSMSDBCommand "$sql16"   2>&1 | tee -a $sqlErrorLog)
	writeLog "SQL Running: $sql17"
	sqlUpdate313_9=$($sqliTelSMSDBCommand "$sql17"   2>&1 | tee -a $sqlErrorLog)
	writeLog "SQL Running: $sql18"
	sqlUpdate313_10=$($sqliTelSMSDBCommand "$sql18"   2>&1 | tee -a $sqlErrorLog)
	writeLog "SQL Running: $sql19"
	sqlUpdate313_11=$($sqliTelSMSDBCommand "$sql19"   2>&1 | tee -a $sqlErrorLog)
	writeLog "SQL Running: $sql20"
	sqlUpdate313_12=$($sqliTelSMSDBCommand "$sql20"   2>&1 | tee -a $sqlErrorLog)
	writeLog "SQL Running: $sql21"
	sqlUpdate313_13=$($sqliTelSMSDBCommand "$sql21"   2>&1 | tee -a $sqlErrorLog)
	writeLog "SQL Running: $sql22"
	updateVersionInfo=$($sqliTelSMSDBCommand "$sql22"   2>&1 | tee -a $sqlErrorLog)
	
	
	
	#failed db Section
	
	writeLog "SQL Running: $sql23"
	sqlUpdate313_14=$($sqliTelSMSDBCommand "$sql23"   2>&1 | tee -a $sqlErrorLog)
	
	mysqlCommNoDB="mysql --skip-column-names -h $iTelSMSDBHost -P $iTelSMSDBPort -u$iTelSMSDBUser $iTelSMSDBPass --force -e"
	
	
	
	sql24="select SCHEMA_NAME from information_schema.schemata where schema_name = '$failedDBName';"
	writeLog "SQL Running: $sql24"
	is_failed_database=$($mysqlCommNoDB "$sql24"   2>&1 | tee -a $sqlErrorLog)
	
	
	while [[ -z "$is_failed_database" ]]; do
		sql25="CREATE DATABASE IF NOT EXISTS $failedDBName;"
		writeLog "SQL Running: $sql25"
		sqlUpdate313_15=$($mysqlCommNoDB "$sql25"   2>&1 | tee -a $sqlErrorLog)
		
		sql26="select SCHEMA_NAME from information_schema.schemata where schema_name = '$failedDBName';"
		writeLog "SQL Running: $sql26"
		is_failed_database=$($mysqlCommNoDB "$sql26"   2>&1 | tee -a $sqlErrorLog)
		
	done
	
	sql27="alter table $iTelSMSDBName.vbSMSPacketLogger rename $failedDBName.vbSMSPacketLogger;"
	writeLog "SQL Running: $sql27"
	sqlUpdate313_16=$($mysqlCommNoDB "$sql27"   2>&1 | tee -a $sqlErrorLog)
	getAllPacketLoggerTablesFromiTelSMSDB
	
	
	
	for table in ${PacketLoggerTables[@]};do
		sql28="alter table $iTelSMSDBName.$table rename $failedDBName.$table;"
		writeLog "SQL Running: $sql28"
		up_sql1=$($mysqlCommNoDB "$sql28"   2>&1 | tee -a $sqlErrorLog)
	done
	
	
	getTodaySMSHistoryTable
	
	if [[ ! -z "$smsHistoryTable" ]]; then
		sql29="alter table $smsHistoryTable change column shContent shContent text CHARACTER set utf8mb4 COLLATE utf8mb4_unicode_ci;"
		writeLog "SQL Running: $sql29"
		sqlUpdate313_29=$($sqliTelSMSDBCommand "$sql29"   2>&1 | tee -a $sqlErrorLog)
	fi
	sql30="ALTER TABLE vbSMSMask CONVERT TO CHARACTER SET utf8mb4 COLLATE UTF8MB4_UNICODE_CI;"
	writeLog "SQL Running: $sql30"
	sqlUpdate313_30=$($sqliTelSMSDBCommand "$sql30"   2>&1 | tee -a $sqlErrorLog)
	sql31="update vbSMSProviderCredentials set spcTps=25 where spcTps=-1;"
	writeLog "SQL Running: $sql31"
	sqlUpdate313_31=$($sqliTelSMSDBCommand "$sql31"   2>&1 | tee -a $sqlErrorLog)
}

function updateSQLAppServer203(){
	if [[ $currentSMSAppServerVersion =~ "2.0.4" ]]; then
		echo -e "${Blue}[*] Update Already Given as per Version...Skiping AppServer mysql update...${NC}"
		writeLog "Update Already Given as per Version...Skiping AppServer mysql update..."
	else
		if [[ ! "$currentSMSAppServerVersion" =~ "2.0.3" ]]; then
			mysqlCommand="mysql -h $iTelSMSDBHost -P $iTelSMSDBPort -u$iTelSMSDBUser $iTelSMSDBPass --force -D $iTelSMSDBName  -e"
			sql1="INSERT INTO vbAlertMailContent VALUES (26, 'ALERT :: Invoice', 'Dear CUSTOMER_ID,<br>Your Auto Invoice is generated from FROM_TIME to TO_TIME. Also file is attached with the mail.<br><br>Regards,<br>iTel App Server Team', '');"
			writeLog "SQL Running: $sql1"
			sqlUpdateApp_1=$($mysqlCommand "$sql1"   2>&1 | tee -a $sqlErrorLog)
		fi
	fi
}

function getSwitchIP(){
	SMSSwitchIP=$(mysql -h $iTelSMSDBHost -P $iTelSMSDBPort -u$iTelSMSDBUser $iTelSMSDBPass --force -N -D $iTelSMSDBName -e "select smsServerIP from vbSMSServerInfo;"   2>&1 | tee -a $sqlErrorLog)
}
function getSwitchSMPPPort(){
	SMSSwitchSMPPPort=$(mysql -h $iTelSMSDBHost -P $iTelSMSDBPort -u$iTelSMSDBUser $iTelSMSDBPass --force -N -D $iTelSMSDBName -e "select smsSMPPPort from vbSMSServerInfo;"   2>&1 | tee -a $sqlErrorLog)
}
function getSwitchHTTPPort(){
	SMSSwitchHTTPPort=$(mysql -h $iTelSMSDBHost -P $iTelSMSDBPort -u$iTelSMSDBUser $iTelSMSDBPass --force -N -D $iTelSMSDBName -e "select smsHTTPPort from vbSMSServerInfo;"   2>&1 | tee -a $sqlErrorLog)
}
function getSwitchHTTPSPort(){
	SMSSwitchHTTPSPort=$(mysql -h $iTelSMSDBHost -P $iTelSMSDBPort -u$iTelSMSDBUser $iTelSMSDBPass --force -N -D $iTelSMSDBName -e "select smsHTTPSPort from vbSMSServerInfo;"   2>&1 | tee -a $sqlErrorLog)
}
function getSwitchsmsSenderListenPort(){
	SMSSwitchSmsSenderListenPort=$(mysql -h $iTelSMSDBHost -P $iTelSMSDBPort -u$iTelSMSDBUser $iTelSMSDBPass --force -N -D $iTelSMSDBName -e "select smsSenderListenPort from vbSMSServerInfo;"   2>&1 | tee -a $sqlErrorLog)
}
function updateSMSWholesaleServer301to306(){
	echo -e "${Blue}[*] Updating for 301 to 306 Configuration...${NC}"
	writeLog "Updating for 301 to 306 Configuration..."
	cd $SMSsignalingFolder
	config_file=$SMSsignalingFolder/Configuration.txt
	if [[ -e "$config_file" ]]; then
		is_old_configuration=1
		echo -e "${Blue}[*] Configuration file exists in $SMSsignalingFolder folder${NC}"
		writeLog "Configuration file exists in $SMSsignalingFolder folder"
		echo -e "${Blue}[*] Updating Configuration file with smsLiveStatusReceivers parameter...${NC}"
		writeLog "Updating Configuration file with smsLiveStatusReceivers parameter..."
		isLiveStatusReceiverAvailable=$(cat $config_file  | grep "^smsLiveStatusReceivers")
		if [[ ! -z "$isLiveStatusReceiverAvailable" ]]; then
			echo -e "${Green}[*] smsLiveStatusReceivers Parameter Found: $isLiveStatusReceiverAvailable${NC}"
			writeLog "smsLiveStatusReceivers Parameter Found: $isLiveStatusReceiverAvailable"
		else
			getSwitchIP
			echo "smsLiveStatusReceivers=$SMSSwitchIP;119.148.4.18;103.169.159.34">>$config_file
			isLiveStatusReceiverAvailable=$(cat $config_file  | grep "^smsLiveStatusReceivers")
			echo -e "${Green}[*] smsLiveStatusReceivers Parameter Updated: $isLiveStatusReceiverAvailable${NC}"
			writeLog "smsLiveStatusReceivers Parameter Updated: $isLiveStatusReceiverAvailable"
		fi
	else
		is_old_configuration=0
		echo -e "${Blue}[*] No Configuration File Found in $SMSsignalingFolder folder${NC}"
		writeLog "No Configuration File Found in $SMSsignalingFolder folder"
	fi
}
function updateSMSWholesaleServer306to308(){
	echo -e "${Blue}[*] Updating for 306 to 308 Configuration...${NC}"
	writeLog "Updating for 301 to 306 Configuration..."
	cd $SMSsignalingFolder
	config_file=$SMSsignalingFolder/Configuration.txt
	if [[ -e "$config_file" ]]; then
		is_old_configuration=1
		echo -e "${Blue}[*] Configuration file exists in $SMSsignalingFolder folder${NC}"
		writeLog "Configuration file exists in $SMSsignalingFolder folder"
		echo -e "${Blue}[*] Updating Configuration file with localConfigListeningPort parameter...${NC}"
		writeLog "Updating Configuration file with localConfigListeningPort parameter..."
		islocalConfigListeningPortAvailable=$(cat $config_file  | grep "^localConfigListeningPort")
		if [[ ! -z "$islocalConfigListeningPortAvailable" ]]; then
			echo -e "${Green}[*] localConfigListeningPort Parameter Found: $islocalConfigListeningPortAvailable${NC}"
			writeLog "localConfigListeningPort Parameter Found: $islocalConfigListeningPortAvailable"
		else
			getSwitchSMPPPort
			getSwitchHTTPPort
			getSwitchHTTPSPort
			#Need A free port
			echo -e "${Blue}[*] Wait a minute. You are lazy. Let me find a free port for you..${NC}"
			writeLog "$Wait a minute. You are lazy. Let me find a free port for you.."
			
			start_brute=0
			echo -e "${Blue}[*] SMPP Port is $SMSSwitchSMPPPort${NC}"
			writeLog "SMPP Port is $SMSSwitchSMPPPort"
		
			
			let start_brute=$SMSSwitchSMPPPort+500
			while true; do
				let start_brute=$start_brute+1
				port_to_user=$(lsof -i :$start_brute)
				if [[ ( $start_brute -ne 80 ) && ( $start_brute -ne 443 ) && ( $start_brute -ne "$SMSSwitchSMPPPort" ) && ( $start_brute -ne "$SMSSwitchHTTPPort" ) && ( $start_brute -ne "$SMSSwitchHTTPSPort" ) && ( $start_brute -ne "$SMSSwitchSmsSenderListenPort" ) && ( -z "$port_to_user" ) ]]; then
					break
				fi
				echo -e "${Blue}[*] Cant use port: $start_brute.${NC}"
			done
			echo -e "${Blue}[*] Got a free port for you: $start_brute ${NC}"
			writeLog "Got a free port for you: $start_brute"
			
			echo "localConfigListeningPort=$start_brute">>$config_file
			islocalConfigListeningPortAvailable=$(cat $config_file  | grep "^localConfigListeningPort")
			echo -e "${Green}[*] localConfigListeningPort Parameter Updated: $islocalConfigListeningPortAvailable${NC}"
			writeLog "localConfigListeningPort Parameter Updated: $islocalConfigListeningPortAvailable"
		fi
	else
		echo -e "${Blue}[*] No Configuration File Found in $SMSsignalingFolder folder${NC}"
		writeLog "No Configuration File Found in $SMSsignalingFolder folder"
		is_old_configuration=0
	fi
}

function updateSMSWholesaleServer308to309(){
	echo -e "${Blue}[*] Updating for 308 to 309 Configuration...${NC}"
	writeLog "Updating for 308 to 309 Configuration..."
	cd $SMSsignalingFolder
	config_file=$SMSsignalingFolder/Configuration.txt
	if [[ -e "$config_file" ]]; then
		echo -e "${Blue}[*] Configuration file exists in $SMSsignalingFolder folder${NC}"
		writeLog "Configuration file exists in $SMSsignalingFolder folder"
		
		echo -e "${Blue}[*] Moving $SMSsignalingFolder/Configuration.txt to $MSsignalingFolder/config/server.cfg Folder${NC}"
		writeLog "Moving $config_file to $SMSsignalingFolder/config Folder"
		mkdir -p $SMSsignalingFolder/config
		yes | mv $config_file $SMSsignalingFolder/config/server.cfg 1>/dev/null
		config_file=$SMSsignalingFolder/config/server.cfg
		
		if [[ -e "$config_file" ]]; then
			echo -e "${Green}[*] Moving $SMSsignalingFolder/Configuration.txt as $SMSsignalingFolder/config/server.cfg Folder Success${NC}"
			writeLog "Moving $SMSsignalingFolder/Configuration.txt as $SMSsignalingFolder/config/server.cfg Folder Success"
		else
			echo -e "${BRed}[*] Moving $SMSsignalingFolder/Configuration.txt as $SMSsignalingFolder/config/server.cfg Failed${NC}"
			writeLog "Moving $SMSsignalingFolder/Configuration.txt as $SMSsignalingFolder/config/server.cfg Failed"
			exit
		fi
		
		
		echo -e "${Blue}[*] Updating Configuration file with orgBindPort parameter...${NC}"
		writeLog "Updating Configuration file with orgBindPort parameter..."
		isOrgBindPortAvailable=$(cat $config_file  | grep "^orgBindPort")
		if [[ ! -z "$isOrgBindPortAvailable" ]]; then
			echo -e "${Green}[*] orgBindPort Parameter Found: $isOrgBindPortAvailable${NC}"
			writeLog "orgBindPort Parameter Found: $isOrgBindPortAvailable"
		else
			getSwitchIP
			sed -i '1s/^/orgBindPort='$SMSSwitchSMPPPort'\n/' $config_file
			isOrgBindPortAvailable=$(cat $config_file  | grep "^orgBindPort")
			echo -e "${Green}[*] orgBindPort Parameter Updated: $isOrgBindPortAvailable${NC}"
			writeLog "orgBindPort Parameter Updated: $isOrgBindPortAvailable"
		fi
		
		
		echo -e "${Blue}[*] Updating Configuration file with orgBindIP parameter...${NC}"
		writeLog "Updating Configuration file with orgBindIP parameter..."
		isOrgBindIPAvailable=$(cat $config_file  | grep "^orgBindIP")

		if [[ ! -z "$isOrgBindIPAvailable" ]]; then
			echo -e "${Green}[*] orgBindIP Parameter Found: $isOrgBindIPAvailable${NC}"
			writeLog "orgBindIP Parameter Found: $isOrgBindIPAvailable"
		else
			getSwitchIP
			sed -i '1s/^/orgBindIP='$SMSSwitchIP'\n/' $config_file
			isOrgBindIPAvailable=$(cat $config_file  | grep "^orgBindIP")
			echo -e "${Green}[*] orgBindIP Parameter Updated: $isOrgBindIPAvailable${NC}"
			writeLog "orgBindIP Parameter Updated: $isOrgBindIPAvailable"
		fi
	else
		is_old_configuration=0
		echo -e "${Blue}[*] No Configuration File Found in $SMSsignalingFolder folder${NC}"
		writeLog "No Configuration File Found in $SMSsignalingFolder folder"
		config_file=$SMSsignalingFolder/config/server.cfg
		
		if [[ -e "$config_file" ]]; then
			echo -e "${Green}[*] server.cfg file Found in $SMSsignalingFolder/config/ folder ${NC}"
			writeLog "server.cfg file Found in $SMSsignalingFolder/config/ folder"
		else
			echo -e "${BRed}[*] No server.cfg found. Check manually.${NC}"
			writeLog "No server.cfg found. Check manually."
			exit
		fi
	fi
}
function updateBilling318If317(){
	webVersion_t=$(mysql -h $iTelSMSDBHost -P $iTelSMSDBPort -u$iTelSMSDBUser $iTelSMSDBPass --force -N -D $iTelSMSDBName -e "select webVersion from vbVersionInfo;"   2>&1 | tee -a $sqlErrorLog)
	
	is_317_bill_update=0
	echo -e "${Blue}[*] Checkig Billing for $latestVersionOfBilling ... ${NC}"
	writeLog "Checkig Billing for $latestVersionOfBilling ..."
	if [[ $currentSignalingVersion =~ "3.1.8" && $webVersion_t =~ "3.1.7" ]]; then
		echo -e "${Blue}[*] Updating Billing 3.1.7 to $latestVersionOfBilling ...${NC}"
		writeLog "Updating Billing 3.1.7 to $latestVersionOfBilling ...."
		stop_tomcat
		for (( j=1; j<${totaliTelSMSBilling}+1; j++ ));
		do
			billingName=${SMSBillingFolder[$j-1]}
			writeLog "Now Updating......$billingName"
			echo -e "${Blue}[*] Now Updating......$billingName"
		
			cp -rf $newRourceLocation/updatebilling317to318.zip  $jak_loc/webapps/${billingName}/
			cd $jak_loc/webapps/${billingName}/
			unzip -u -o updatebilling317to318.zip
			
			echo -e "${Green}[*] $billingName Billing Update Done"
			writeLog "$billingName Billing Update Done"
		done
		
		start_tomcat
		echo -e "${Green}[*] Billing Update Done....${NC}"
		writeLog "Billing Update Done...."
	fi
}

function updateAppServer205IF204(){
	echo -e "${Blue}[*] Checkig AppServer for 205... ${NC}"
	writeLog "Checkig AppServer for 205..."
	now="$(date +'%d_%m_%Y_%H_%M_%S')"
	
	if [[ -d "$iTelSMSAppServerName/lib" ]]; then
			mv $iTelSMSAppServerName/lib $iTelSMSAppServerName/lib_$now
	fi
	
	mv $newRourceLocation/iTelSMSAppServer/lib $iTelSMSAppServerName/lib
	
	if [[ $currentSMSAppServerVersion =~ "2.0.4" ]]; then
		echo -e "${Blue}[*] Updating Appserver 2.0.4 to $latestAppServerVersion...${NC}"
		writeLog "Updating Appserver 2.0.4 to $latestAppServerVersion..."
		stopSMSAppServer $iTelSMSAppServerName
		mv $iTelSMSAppServerName/iTelSMSAppServer.jar $iTelSMSAppServerName/iTelSMSAppServer.jar_$now
		mv $newRourceLocation/iTelSMSAppServer/iTelSMSAppServer.jar $iTelSMSAppServerName/iTelSMSAppServer.jar
		startSMSAppServer $iTelSMSAppServerName
		echo -e "${Green}[*] App Server Updated to $latestAppServerVersion ${NC}"
		writeLog "App Server Updated to $latestAppServerVersion"
		
		
		#configuring run file
		billingNameForAppServerFolder=${SMSsignalingFolder/#*WholeSaleSMSServer}
		
		if [[ -e $iTelSMSAppServerName/runiTelSMSAppServer.sh ]];then
			wholesale_mem=$(cat $iTelSMSAppServerName/runiTelSMSAppServer.sh  |grep -Pom1 '(?<=java -Xmx)[^m]+')
		else
			wholesale_mem=4096
		fi
	
		echo "cd $iTelSMSAppServerName" > $iTelSMSAppServerName/runiTelSMSAppServer.sh
		echo "/usr/$var_jdk/bin/java -Xmx${wholesale_mem}m -jar iTelSMSAppServer.jar $billingNameForWholealeFolder &" >> $iTelSMSAppServerName/runiTelSMSAppServer.sh
	fi
}

function updateSMSWholesaleServer309to311(){
	echo -e "${Blue}[*] Updating for 309 to 311 Configuration...${NC}"
	writeLog "Updating for 309 to 311 Configuration..."
	cd $SMSsignalingFolder
	
	now="$(date +'%d_%m_%Y_%H_%M_%S')"
	
	echo -e "${Blue}[*] Adding smppTransactionTimer parameter${NC}"
	writeLog "Adding smppTransactionTimer parameter"
	config_file=$SMSsignalingFolder/config/server.cfg
	transaction_timer_config=$(cat $config_file | grep  "^smppTransactionTimer")
	
	if [[ ! -z "$transaction_timer_config" ]]; then
		sed -i 's/'$transaction_timer_config'/smppTransactionTimer\=120/g' $config_file
	fi
	
	echo -e "${Blue}[*] Checking Databaseconnection Parameter....${NC}"
	writeLog "Checking Databaseconnection Parameter...."
	
	echo "<CONNECTIONS>">$SMSsignalingFolder/DatabaseConnection.xml
	echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$iTelSMSDBName?useEncoding=true&amp;characterEncoding=UTF-8\"">>$SMSsignalingFolder/DatabaseConnection.xml
	echo " USER_NAME = \"$iTelSMSDBUser\" PASSWORD = \"$iTelSMSDBPass\"">>$SMSsignalingFolder/DatabaseConnection.xml
	echo " IS_DEFAULT = \"TRUE\"/>">>$SMSsignalingFolder/DatabaseConnection.xml
	echo "</CONNECTIONS>">>$SMSsignalingFolder/DatabaseConnection.xml
	
	
	echo -e "${Green}[*] Update Databaseconnection.xml Parameters Done. ${NC}"
	writeLog "Update Databaseconnection.xml Parameters Done."
}


function updateSMSWholesaleServer311to323(){
	echo -e "${Blue}[*] Updating SMSWholesaleServer for $latestVersionOfSignaling Configuration...${NC}"
	writeLog "Updating SMSWholesaleServer for $latestVersionOfSignaling Configuration..."
	
	cd $newRourceLocation
	
	#enable_utf8 in log

	now="$(date +'%d_%m_%Y_%H_%M_%S')"
	config_file=$SMSsignalingFolder/config/server.cfg
	
	echo -e "${Blue}[*] Backing up old WholeSaleSMSServer Folder resource.${NC}"
	writeLog "Backing up old WholeSaleSMSServer Folder resource."
	mv $SMSsignalingFolder/SMSServerWholesale.jar $SMSsignalingFolder/SMSServerWholesale.jar_$now
	mv $SMSsignalingFolder/SMSServer.so $SMSsignalingFolder/SMSServer.so_$now
	
	echo "cacheAgeLimit=25" >> $config_file
	
	
	if [[ -e "$SMSsignalingFolder/log4j.properties" ]]; then
		mv $SMSsignalingFolder/log4j.properties $SMSsignalingFolder/log4j.properties_$now
	fi
	
	if [[ -e "$SMSsignalingFolder/log4j2.xml" ]]; then
		mv $SMSsignalingFolder/log4j2.xml $SMSsignalingFolder/log4j2.xml_$now
	fi
	
	if [[ -d "$SMSsignalingFolder/log4j" ]]; then
		mv $SMSsignalingFolder/log4j $SMSsignalingFolder/log4j_$now
	fi
	
	mv $SMSsignalingFolder/lib $SMSsignalingFolder/lib_$now
	mv $SMSsignalingFolder/ShutDown.jar $SMSsignalingFolder/ShutDown.jar_$now
	
	echo -e "${Blue}[*] Giving New SMS Wholesale Server Resources.${NC}"
	writeLog "Giving New SMS Wholesale Server Resources."
	mv $newRourceLocation/WholeSaleSMSServer/SMSServerWholesale.jar $SMSsignalingFolder/
	mv $newRourceLocation/WholeSaleSMSServer/log4j2.xml $SMSsignalingFolder/log4j2.xml
	mv $newRourceLocation/WholeSaleSMSServer/SMSServer.so $SMSsignalingFolder/
	mv $newRourceLocation/WholeSaleSMSServer/lib $SMSsignalingFolder/
	mv $newRourceLocation/WholeSaleSMSServer/ShutDown.jar $SMSsignalingFolder/ShutDown.jar
	echo -e "${Green}[*] SMS Wholesale Server Resources Update Done${NC}"
	writeLog "SMS Wholesale Server Resources Update Done"
	
	echo -e "${Blue}[*] Checking Failed_Databaseconnection.xml File....${NC}"
	writeLog "Checking Failed_Databaseconnection.xml File...."
	
	billingNameForWholealeFolder=${SMSsignalingFolder#*WholeSaleSMSServer}
	if [[ ! -e $SMSsignalingFolder/DatabaseConnection_Failed.xml ]]; then
		echo "<CONNECTIONS>">$SMSsignalingFolder/DatabaseConnection_Failed.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///iTelSMSFailed${billingNameForWholealeFolder}?useEncoding=true&amp;characterEncoding=UTF-8\"">>$SMSsignalingFolder/DatabaseConnection_Failed.xml
		echo "USER_NAME = \"$iTelSMSDBUser\" PASSWORD = \"$iTelSMSDBPass\"">>$SMSsignalingFolder/DatabaseConnection_Failed.xml
		echo "IS_DEFAULT = \"TRUE\"/>">>$SMSsignalingFolder/DatabaseConnection_Failed.xml
		echo "</CONNECTIONS>">>$SMSsignalingFolder/DatabaseConnection_Failed.xml
	else 
		sed -i 's/$iTelSMSDBName/iTelSMSFailed${billingNameForWholealeFolder}/g' $SMSsignalingFolder/DatabaseConnection_Failed.xml
	fi
	
	#configuring run file
	
	wholesale_mem=$(cat $SMSsignalingFolder/runSMS_Server.sh  |grep -Pom1 '(?<=java -Xmx)[^m]+')
	if [[ -e "$SMSsignalingFolder/runSMS_Server.sh" ]];then
			wholesale_mem=$(cat $SMSsignalingFolder/runSMS_Server.sh  |grep -Pom1 '(?<=java -Xmx)[^m]+')
		else
			wholesale_mem=4096
		fi
	
	echo -e "${Blue}[*] Updating \"runSMS_Server.sh\" Parameters....${NC}"
	writeLog "Updating \"runSMS_Server.sh\" Parameters...."
	
	echo "cd $SMSsignalingFolder/" > $SMSsignalingFolder/runSMS_Server.sh
	echo "/usr/$var_jdk/bin/java -Xmx${wholesale_mem}m -DLog4jContextSelector=org.apache.logging.log4j.core.async.AsyncLoggerContextSelector -jar SMSServerWholesale.jar $billingNameForWholealeFolder &" >> $SMSsignalingFolder/runSMS_Server.sh
	
	echo -e "${Green}[*] Created Failed_Databaseconnection.xml in $SMSsignalingFolder ${NC}"
	writeLog "Created Failed_Databaseconnection.xml in $SMSsignalingFolder "
}

function WholeSaleSMSAppUpdate205(){
	if [[ "$currentSMSAppServerVersion" =~ "$latestAppServerVersion" ]]; then
		echo -e "${Blue}[*] iTelSMSAppServer.jar in $iTelSMSAppServerName Folder Already $latestAppServerVersion Version${NC}"
		writeLog "iTelSMSAppServer.jar in $iTelSMSAppServerName Folder Already $latestAppServerVersion Version"
		#Lib Update Part
		now="$(date +'%d_%m_%Y_%H_%M_%S')"
		if [[ -d "$iTelSMSAppServerName/lib" ]]; then
			mv $iTelSMSAppServerName/lib lib_$now
		fi
		
		
		mv $newRourceLocation/iTelSMSAppServer/lib $iTelSMSAppServerName/lib
		
	else
		now="$(date +'%d_%m_%Y_%H_%M_%S')"
		billing=${iTelSMSDBName##*iTelSMS}
		cd $iTelSMSAppServerName
		
		#DatabaseConnection.xml
		echo "<CONNECTIONS>">DatabaseConnection.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$iTelSMSDBName?useSSL=false&amp;useUnicode=true&amp;characterEncoding=utf-8\"">>DatabaseConnection.xml
		echo " USER_NAME = \"$iTelSMSDBUser\" PASSWORD = \"${iTelSMSDBPass##*-p}\"">>DatabaseConnection.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
		echo "</CONNECTIONS>">>DatabaseConnection.xml
		
		#enable_utf8 in log
		have_utf8_param=$(cat log4j.properties  | grep "^log4j.appender.logfile.encoding")

		if [[ -z "$have_utf8_param" ]];then
			echo "log4j.appender.logfile.encoding=UTF-8">>log4j.properties
		fi
		
		echo -e "${Blue}[*] Searching for iTelSMSAppServer.jar in $iTelSMSAppServerName Folder${NC}"
		writeLog "Searching for iTelSMSAppServer.jar in $iTelSMSAppServerName Folder"
		
		if [[ -e $iTelSMSAppServerName/iTelSMSAppServer.jar ]]; then
			echo -e "${Green}[*] iTelSMSAppServer.jar Found in $iTelSMSAppServerName Folder${NC}"
			writeLog "iTelSMSAppServer.jar Found in $iTelSMSAppServerName Folder"
		else 
			echo -e "${BRed}[*] iTelSMSAppServer.jar not Found in $iTelSMSAppServerName Folder${NC}"
			writeLog "iTelSMSAppServer.jar not Found in $iTelSMSAppServerName Folder"
		fi
		
		
		
		echo -e "${Blue}[*] Giving New SMS Wholesale App Server Resources.${NC}"
		writeLog "Giving New SMS Wholesale Server Resources...."
		
		mv $iTelSMSAppServerName/iTelSMSAppServer.jar $iTelSMSAppServerName/iTelSMSAppServer.jar_$now 
		mv $iTelSMSAppServerName/ShutDown.jar $iTelSMSAppServerName/ShutDown.jar_$now 
		
		if [[ -d "$iTelSMSAppServerName/lib" ]]; then
			mv $iTelSMSAppServerName/lib lib_$now
		fi
		
		if [[ ! -d "$iTelSMSAppServerName/images" ]]; then
			mkdir $iTelSMSAppServerName/images
		fi
		
		if [[ ! -d "$iTelSMSAppServerName/autoInvoice" ]]; then
			mkdir $iTelSMSAppServerName/autoInvoice
		fi
		
		mv $newRourceLocation/iTelSMSAppServer/iTelSMSAppServer.jar $iTelSMSAppServerName/iTelSMSAppServer.jar
		mv $newRourceLocation/iTelSMSAppServer/lib $iTelSMSAppServerName/lib
		mv $newRourceLocation/iTelSMSAppServer/ShutDown.jar $iTelSMSAppServerName/ShutDown.jar
		configuration_file=$iTelSMSAppServerName/Configuration.properties
		if [[ ! -e $configuration_file ]];then
			touch $iTelSMSAppServerName/Configuration.properties
		fi
		
		echo -e "${Blue}[*] Updating SMS App Server Configuration.properties Parameter.${NC}"
		writeLog "Updating SMS App Server Configuration.properties Parameter."
		
		is_LAST_CALL_INFO_TAKEN_DAY_param=$(cat $configuration_file  | grep "^LAST_CALL_INFO_TAKEN_DAY")
		
		
		if [[ -z "$is_LAST_CALL_INFO_TAKEN_DAY_param" ]];then
			echo "LAST_CALL_INFO_TAKEN_DAY=$(date +'%Y-%m-%d')">>$configuration_file
		fi
		
		is_MAIL_SEND_TYPE_param=$(cat $configuration_file  | grep "^MAIL_SEND_TYPE")
		if [[ -z "$is_MAIL_SEND_TYPE_param" ]];then
			echo "MAIL_SEND_TYPE=Default">>$configuration_file
		fi
		getSwitchIP
		is_INVOICE_GENERATION_BASE_URL_param=$(cat $configuration_file  | grep "^INVOICE_GENERATION_BASE_URL")
		if [[ -z "$is_INVOICE_GENERATION_BASE_URL_param" ]];then
			echo "INVOICE_GENERATION_BASE_URL=http://$SMSSwitchIP/$billing/billgeneration/BillDownload.jsp">>$configuration_file
		fi
		#configuring run file
		billingNameForAppServerFolder=${SMSsignalingFolder/#*WholeSaleSMSServer}
		
		if [[ -e $iTelSMSAppServerName/runiTelSMSAppServer.sh ]];then
			wholesale_mem=$(cat $iTelSMSAppServerName/runiTelSMSAppServer.sh  |grep -Pom1 '(?<=java -Xmx)[^m]+')
		else
			wholesale_mem=4096
		fi
	
		echo "cd $iTelSMSAppServerName" > $iTelSMSAppServerName/runiTelSMSAppServer.sh
		echo "/usr/$var_jdk/bin/java -Xmx${wholesale_mem}m -jar iTelSMSAppServer.jar $billingNameForWholealeFolder &" >> $iTelSMSAppServerName/runiTelSMSAppServer.sh
	fi
}

function smsBillingUpdate318(){
	echo -e "${Blue}[*] Going to Give New Billing Resources ( Version $latestVersionOfBilling ) ....${NC}"
	writeLog "Going to Give New Billing Resources ( Version $latestVersionOfBilling ) ...."
	now="$(date +'%d_%m_%Y_%H_%M_%S')"
	if [[ ! -d $jak_loc/backUpWebApps ]];then
		mkdir -p $jak_loc/backUpWebApps   > /dev/null 2>&1
	fi
	cp -rf $jak_loc/webapps $jak_loc/backUpWebApps/webapps_$now
	echo -e "${Blue}[*] Webapps Folder Backup Created....${NC}"
	writeLog "Webapps Folder Backup Created...."
	
	for (( j=1; j<${totaliTelSMSBilling}+1; j++ ));
	do
		billingName=${SMSBillingFolder[$j-1]}
		writeLog "Now Updating......$billingName"
		echo -e "${Blue}[*] Now Updating......$billingName"

		mv $jak_loc/webapps/$billingName $jak_loc/webapps/${billingName}_old_update_script
		cp -rf $newRourceLocation/smsportal  $jak_loc/webapps/${billingName}
		yes | cp -rf $jak_loc/webapps/${billingName}_old_update_script/WEB-INF/classes/*.xml $jak_loc/webapps/$billingName/WEB-INF/classes/
		yes | cp -rf $jak_loc/webapps/${billingName}_old_update_script/WEB-INF/classes/*.properties $jak_loc/webapps/$billingName/WEB-INF/classes/
		yes | cp -rf $jak_loc/webapps/${billingName}_old_update_script/images/* $jak_loc/webapps/$billingName/images/
		rm -rf $jak_loc/webapps/${billingName}_old_update_script
		cd $jak_loc/webapps/${billingName}
		billingNameForAppServerFolder=${SMSsignalingFolder/#*WholeSaleSMSServer}
		cd $jak_loc/webapps/${billingName}/WEB-INF/classes/
		rm -f $jak_loc/webapps/${billingName}/WEB-INF/classes/DatabaseConnection_Failed.xml
		if [[ ! -e "$jak_loc/webapps/${billingName}/WEB-INF/classes/DatabaseConnection_Failed.xml" ]];then	
			echo "<CONNECTIONS>" > DatabaseConnection_Failed.xml
			echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///iTelSMSFailed${billingNameForAppServerFolder}?useUnicode=true&amp;characterEncoding=utf-8\"">>DatabaseConnection_Failed.xml
			echo "USER_NAME = \"$iTelSMSDBUser\" PASSWORD = \"$iTelSMSDBPass\"">>DatabaseConnection_Failed.xml
			echo "IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Failed.xml
			echo "</CONNECTIONS>">>DatabaseConnection_Failed.xml
		else
			sed -i 's/$iTelSMSDBName/iTelSMSFailed${billingNameForWholealeFolder}/g' DatabaseConnection_Failed.xml
		fi
		echo -e "${Green}[*] $billingName Billing Update Done"
		writeLog "$billingName Billing Update Done"
	done

	echo -e "${Green}[*] Billing Update Done....${NC}"
	writeLog "Billing Update Done...."
}
########=============== Initializing System Call ===================================================================================================>>>>>>
initializingSystem
function updateRimsPleaseConfirmation(){
	echo -e "${Blue}[Please Update SMPP IP ($SMSSwitchIP) and SMPP Port ($SMSSwitchSMPPPort) in Rims after that Press Any key and Then Enter] ${NC}"
}



declare -i editCounter=10
while [ $editCounter -gt 0 ]; do
				
	if [ -z $insCau ];then
		clear
		
		echo -e "				${BBlue} ################ :: Instructions and Cautions :: ################################################### ${NC} ";
		echo -e "				${BBlue} #${NC} ${BGreen}#-------------------------Instructions------------------------------------------------------------#${NC}";
		echo -e "				${BBlue} #${NC} ${BRed}1) This program can update sms switch From 3.0.1 To Current version $latestVersionOfSignaling       				   ${NC}";
		echo -e "				${BBlue} #${NC} ${BRed}2) Version Will Be detected from the SMSServer Signaling SMSServerWholesale.jar Version${NC}";
		echo -e "				${BBlue} #${NC} ${BRed}3) You have to Select Switch From List, if Multiple Switch Found  						   ${NC}";
		echo -e "				${BBlue} #${NC} ${BRed}4) Updater program will check and List down The connecetd Services						   ${NC}";
		echo -e "				${BBlue} #${NC} ${BRed}5) Please Check \"$logFileLocation/$logFileName\" for details    						   ${NC}";
		echo -e "				${BBlue} #${NC} ${BRed}6) App Server Version will be detected from iTelSMSAppServer.jar						   ${NC}";
		echo -e "				${BBlue} #${NC} ${BRed}6) Before Update, Make Sure run and shutdown files are with proper name. ${NC}";
		echo -e "				${BBlue} #${NC} ${BRed}7) SMSWholeSaleServer Run File Name:  runSMS_Server.sh ${NC}";
		echo -e "				${BBlue} #${NC} ${BRed}8) SMSWholeSaleServer Shutdown File Name:  shutdownSMS_Server.sh ${NC}";
		echo -e "				${BBlue} #${NC} ${BRed}9) iTelSMSAppServer Run File Name:  runiTelSMSAppServer.sh ${NC}";
		echo -e "				${BBlue} #${NC} ${BRed}10) iTelSMSAppServer Showtdown File Name:  shutdowniTelSMSAppServer.sh ${NC}";
		echo -e "				${BBlue} #${NC} ${BRed}11) In Run file for services, jar names need to be as mentioned, Check this before running the script${NC}";
		echo -e "				${BBlue} #${NC} ${BRed}#---------------------------Cautions--------------------------------------------------------------#${NC}";
		echo -e "				${BBlue} #${NC} ${BRed}1) Never Update Customized switch(Customized by R&D)              							   ${NC}";
		echo -e "				${BBlue} #${NC} ${BBlue}#---------------------------Limitation------------------------------------------------------------#${NC}";
		echo -e "				${BBlue} #${NC} ${Blue}1) This program can't update services running in multiple server  						   ${NC}";
		echo -e "				${BBlue} #${NC} ${Blue}2) There are some Dependencies on Linux, Like..lsof,service,unzip.						   ${NC}";

		
			printf "\n 			   ${Red}If you are using this script for first time then Read \"Instructions and Cautions\" Properly ${NC}"
			printf "\n"
			printf "\n 			           Do you have already Read \"Instructions and Cautions\" ? (y/n) "
		
			#insCau=""
			writeLog "Asking for read Confirmation for Instructions and Cautions"
		
			read insCau
		
			
			#insCau=y
			writeLog "Got user input : \"$insCau\" "
			
			if [ "$insCau" == "y" ] || [ "$insCau" == "yes" ] || [ "$insCau" == "Y" ] || [ "$insCau" == "YES" ] || [ "$insCau" == "Yes" ];then
				editCounter=0
			elif [ "$insCau" == "n" ] || [ "$insCau" == "N" ] || [ "$insCau" == "No" ] || [ "$insCau" == "no" ] || [ "$insCau" == "NO" ]; then
				editCounter=10
				printf "\n${BRed}Please read  Instructions and Cautions to Proceed Next....${NC}\n"
				writeLog "Please read  Instructions and Cautions to Proceed Next......"
				sleep 2
				unset insCau
				continue
			else
				unset insCau
				continue
			fi
		loopCounter=0
	fi
	
	
	
	declare -i errorCounter=10
	while [ $errorCounter -gt 0 ];
	do
		
		unset switchID;unset SMSsignalingFolder;unset totalService;
		unset iTelSMSDBName;unset iTelSMSDBHost;unset iTelSMSDBPort; unset iTelSMSDBUser;unset iTelSMSDBPass;
		unset SMSBillingFolder;unset SMSSwitchHTTPSPort;unset SMSSwitchHTTPPort;unset SMSSwitchSMPPPort;unset SMSSwitchIP;unset iTelSMSAppServerName;
		unset currentSignalingVersion;
		
			
		
		totalService=${#services[@]}
		
		if [ $totalService -eq 0 ];then
			printf "\n\n\n${BRed}No Switch found in /usr/local/ . ${NC}\n\n\n"
			exit
		elif [ $totalService -eq 1 ];then
			showServices=1
			#echo "Single Switch Server"
			switchID=1
			errorCounter=0
		else
			#echo "Multiple Switch Server"
		
			
			while [ -z $switchID ];
			do
				now="$(date +'%d_%m_%Y_%H_%M_%S')"
				printf "\n"
				if [ $loopCounter -eq 0 ]; then slTime=.1; else slTime=0;clear; fi
				loopCounter+=1
				clear
				echo -ne "${Blue} Got Multiple SMS Switch. Please select SMS Switch from below List ${NC}\n"
				printf "${Black} ${spaceVal}-------------------------------------------------------------------------\n"
				printf "${Black} ${spaceVal} ID | Switch Location\n"
				printf "${Black} ${spaceVal}-------------------------------------------------------------------------\n"
				for (( i=1; i<${totalService}+1; i++ ));
				do
					servicePath=${services[$i-1]}
					serviceName=${servicePath##*/}
					printf "${Blue} ${spaceVal} $i  | $serviceName ${NC}\n"; sleep $slTime;
					
				done
				echo "-------------------------------------------------------------------------"
				printf "${Purple} Please select SMS Switch By ID (from 1 to $totalService) to update it : ${NC} "
				read switchID;
				
				if [ -z $switchID ];then
					printf "${Red} Null Input ${NC}\n";sleep 1;errorCounter=10;
				elif [[ $switchID -lt 1 ]] || [[ $switchID -gt $totalService ]];then
					printf "${Red} Wrong Input value ${NC}\n";sleep 1; unset switchID;
					errorCounter=10
				else
					switchID=${switchID}
					errorCounter=0
				fi
			done
		fi	
		
		declare -i dbCheckingFlag=0
		SMSsignalingFolder=${services[$switchID-1]};
		
		
		
		if [ $totalService -eq 1 ];then
			printf "\n\n\n${Blue}Only One SMS Switch \"$SMSsignalingFolder\" is Found in \"/usr/local/\" ${NC}"
			writeLog "Only One SMS Switch \"$SMSsignalingFolder\" is Found in \"/usr/local/\" "
		else
			printf "\n\n\n${Blue}You have selected \"$SMSsignalingFolder\" ${NC}"
			writeLog "You have selected \"$SMSsignalingFolder\" "
		fi
		
		
		if [ -d "$SMSsignalingFolder" ];then
			errorCounter=0
			writeLog "Signaling Directory is Perfect.."
		else
			errorCounter=10
			printf "\n\${BRed}This SMS Switch Path is not valid. Please check Manually ${NC}"
			writeLog "This SMS Switch Path is not valid. Please check Manually"
			sleep 3;
			unset insCau
			continue
		fi
		
		checkAndGetDBName $SMSsignalingFolder
		dbCheckingFlag=$?
		if [ $dbCheckingFlag -gt 0 ]; then
			printf "\n${BRed}Couldn't Update This SMS Switch. ${NC}"
			printf "\n${Red}Cause : There is a problem in Database Connection file or Database name ${NC}"
			printf "\n${Red}Please check log for details......${NC}\n\n\n"
			errorCounter=10
			unset insCau
			if [ $totalService -eq 1 ];then
				exit
			else
				sleep 3;
				continue
			fi
		else
			errorCounter=0
		fi
		
		getValidSMSBilling $iTelSMSDBName
		validBillingFlag=$?
		
		if [ $validBillingFlag -eq 0 ]; then
			printf "\n${BRed}Couldn't Update This switch.${NC}"
			printf "\n${Red}Cause : No SMS Billing Folder is Connected with $SMSsignalingFolder ${NC}"
			writeLog "Couldn't Update chosen switch.."
			writeLog "No SMS Billing Folder is Connected with Same DB"
			printf "\n${Red}Please check log for details......${NC}\n\n\n"
			errorCounter=10
			unset insCau
			if [ $totalService -eq 1 ];then
				exit
			else
				sleep 3;
				continue
			fi
			
		else
			errorCounter=0
		fi
		
		jarFile="$SMSsignalingFolder/SMSServerWholesale.jar"
		runFile="$SMSsignalingFolder/runSMS_Server.sh"
		tempPath=`sed -n 2p $runFile`
		javaPath=${tempPath%-Xmx*}
		#echo $javaPath
		currentSignalingVersion=$($javaPath -jar $jarFile -v  2>&1 | tee -a $sqlErrorLog)
		iTelSMSAppIsExists
		jarFileAppServer=$iTelSMSAppServerName/iTelSMSAppServer.jar
		currentSMSAppServerVersion=$($javaPath -jar $jarFileAppServer -v  2>&1 | tee -a $sqlErrorLog)
		writeLog "current Signaling Version : $currentSignalingVersion"
		writeLog "current SMSAppServer Version : $currentSMSAppServerVersion"
		
			
		
		currentBillingVersion=$(mysql -h $iTelSMSDBHost -P $iTelSMSDBPort -u$iTelSMSDBUser $iTelSMSDBPass --force -D $iTelSMSDBName --skip-column-names -e "SELECT webVersion FROM vbVersionInfo limit 1;")
		writeLog "Current Billing Version : $currentBillingVersion"
		writeLog "Going to show Service list to user ..............."
		
		
		
		
		
		testSleepTime=0.3
		errorCounter=10
		while [ $errorCounter -gt 0 ];
		do
			clear
			if [ $totalService -eq 1 ];then
				echo "############# :: Got Only One Switch in /usr/local/. Detailed Info Given below :: ############"
			else
				echo "############## :: Detailed Informaiton of your Selected SMS Switch is Given below :: #############"
			fi
			
			echo "#  Signaling Name                  : $SMSsignalingFolder"
			sleep $testSleepTime
			echo "#  iTelSMSAppServer                : $iTelSMSAppServerName"
			sleep $testSleepTime
			echo "#  Jakarta location                : $jak_loc"
			sleep $testSleepTime
			echo "#  DataBase (iTeBilling)           : $iTelSMSDBName"
			
			sleep $testSleepTime
			echo "#  DataBase (iTeBilling)           : $iTelSMSDBName"

			#sleep $testSleepTime
			if [ ${totaliTelSMSBilling} -gt 0 ]; then
				
				billingString=""
				for (( j=1; j<${totaliTelSMSBilling}+1; j++ ));
				do
					tempName=${SMSBillingFolder[$j-1]}
					if [ $j -eq 1 ];then
						billingString="$tempName"
					else
						billingString="$billingString , $tempName"
					fi
				done
				echo "#  Valid SMS Billing Name          : $billingString"
				sleep $testSleepTime
			fi
		
			echo "#  Current SMS Signaling Version   : $currentSignalingVersion"
			echo "#  Current SMS Billing Version	   : $currentBillingVersion"
			echo "#  Current SMSAppServer Version	   : $currentSMSAppServerVersion"
			
			
			echo "#############################################################################################"
			
			writeLog "Asking for cleint Confirmation as above info is correct"
			printf "\nDo you Think Above Information is correct and want to update this switch ? (y/n) "
			
			######################## DEBUG ##################################

			#################################################################
			allCorrect=""
			read allCorrect
			
			printf "\n\n"
			
			writeLog "Got User Input \"$allCorrect\" "
			
			if [[ "$allCorrect" == "y" ]];then
				editCounter=0
				errorCounter=0
				downloadSMSUpdateResources
				if [[ "$currentSignalingVersion" =~ "3.0.1" || "$currentSignalingVersion" =~ "3.0.3" || "$currentSignalingVersion" =~ "3.0.4" || "$currentSignalingVersion" =~ "3.0.5" ]]; then
					stop_switch $SMSsignalingFolder
					stop_tomcat
					stopSMSAppServer $iTelSMSAppServerName
					updateSQLSMSWholesaleServer301to306
					updateSQLSMSWholesaleServer308
					updateSMSWholesaleServer301to306
					updateSMSWholesaleServer306to308
					updateSMSWholesaleServer308to309
					updateSMSWholesaleServer309to311
					updateSQLSMSWholesaleServer308to313
					updateSQLAppServer203
					WholeSaleSMSAppUpdate205
					smsBillingUpdate318
					updateSMSWholesaleServer311to323
					start_tomcat
					startSMSAppServer $iTelSMSAppServerName
					updateRimsPleaseConfirmation
					read;
					start_switch $SMSsignalingFolder
					
					
				elif [[ "$currentSignalingVersion" =~ "3.0.6" || "$currentSignalingVersion" =~ "3.0.7.1" ]]; then
					stop_switch $SMSsignalingFolder
					stop_tomcat
					stopSMSAppServer $iTelSMSAppServerName
					updateSQLSMSWholesaleServer308
					updateSMSWholesaleServer306to308
					updateSMSWholesaleServer308to309
					updateSMSWholesaleServer309to311
					updateSQLSMSWholesaleServer308to313
					updateSQLAppServer203
					WholeSaleSMSAppUpdate205
					smsBillingUpdate318
					updateSMSWholesaleServer311to323
					start_tomcat
					startSMSAppServer $iTelSMSAppServerName
					updateRimsPleaseConfirmation
					read;
					start_switch $SMSsignalingFolder					
				elif [[ "$currentSignalingVersion" =~ "3.0.8" ]]; then
					stop_switch $SMSsignalingFolder
					stop_tomcat
					stopSMSAppServer $iTelSMSAppServerName
					updateSMSWholesaleServer308to309
					updateSMSWholesaleServer309to311
					updateSQLSMSWholesaleServer308to313
					updateSQLAppServer203
					WholeSaleSMSAppUpdate205
					updateSMSWholesaleServer311to323
					smsBillingUpdate318
					start_tomcat
					startSMSAppServer $iTelSMSAppServerName
					updateRimsPleaseConfirmation
					read;
					start_switch $SMSsignalingFolder
				elif [[ "$currentSignalingVersion" =~ "3.0.9" ]]; then
					stop_switch $SMSsignalingFolder
					stop_tomcat
					stopSMSAppServer $iTelSMSAppServerName
					updateSMSWholesaleServer309to311
					updateSMSWholesaleServer311to323
					updateSQLSMSWholesaleServer308to313
					updateSQLAppServer203
					WholeSaleSMSAppUpdate205
					smsBillingUpdate318
					start_tomcat
					startSMSAppServer $iTelSMSAppServerName
					start_switch $SMSsignalingFolder
				elif [[ "$currentSignalingVersion" =~ "3.1.0" ]];then
					stop_switch $SMSsignalingFolder
					stop_tomcat
					stopSMSAppServer $iTelSMSAppServerName
					updateSMSWholesaleServer309to311
					updateSQLSMSWholesaleServer308to313
					updateSQLAppServer203
					WholeSaleSMSAppUpdate205
					updateSMSWholesaleServer311to323
					smsBillingUpdate318
					start_tomcat
					startSMSAppServer $iTelSMSAppServerName
					start_switch $SMSsignalingFolder
				elif [[ "$currentSignalingVersion" =~ "3.1.1" || "$currentSignalingVersion" =~ "3.1.2" || "$currentSignalingVersion" =~ "3.1.3" || "$currentSignalingVersion" =~ "3.1.4" || "$currentSignalingVersion" =~ "3.1.5" || "$currentSignalingVersion" =~ "3.1.6" || "$currentSignalingVersion" =~ "3.1.7" || "$currentSignalingVersion" =~ "3.1.8" || "$currentSignalingVersion" =~ "3.1.9" || "$currentSignalingVersion" =~ "3.2.0" || "$currentSignalingVersion" =~ "3.2.2" ]];then
					stop_switch $SMSsignalingFolder
					stop_tomcat
					stopSMSAppServer $iTelSMSAppServerName
					updateSMSWholesaleServer309to311
					updateSQLSMSWholesaleServer308to313
					updateSQLAppServer203
					WholeSaleSMSAppUpdate205
					updateSMSWholesaleServer311to323
					smsBillingUpdate318
					start_tomcat
					startSMSAppServer $iTelSMSAppServerName
					start_switch $SMSsignalingFolder
					exit;
				elif [[ "$currentSignalingVersion" =~ "$latestVersionOfSignaling" ]];then
					updateBilling318If317
					updateAppServer205IF204
					sql1="update vbVersionInfo set signalingVersion='$latestVersionOfSignaling',webVersion='$latestVersionOfBilling',mediaVersion='0.0.0';"
					writeLog "SQL Running: $sql1"
					sqliTelSMSDBCommand="mysql -h $iTelSMSDBHost -P $iTelSMSDBPort -u$iTelSMSDBUser $iTelSMSDBPass --force -D $iTelSMSDBName -e"
					updateVersionInfo=$($sqliTelSMSDBCommand "$sql1"   2>&1 | tee -a $sqlErrorLog)
					echo -e "${Green}[*] SMS Switch Signaling Already at $latestVersionOfSignaling Version....${NC}"
					writeLog "SMS Switch Signaling Already at $latestVersionOfSignaling Version...."
					exit;	
				else 
					echo -e "${Red}[*] Unknown Version Detected. Do manually. Script can only update from 3.0.1 to $latestVersionOfSignaling ${NC}"
					writeLog "Unknown Version Detected. Do manually."
					exit
				fi
			elif [[ "$allCorrect" == "n" ]];then
				editCounter=10
				errorCounter=10
				break
				#echo "Need to Edit..."
			else
				errorCounter=10
				echo "Input not matched"
				writeLog "Input not matched.."
			fi
		done
	done
done