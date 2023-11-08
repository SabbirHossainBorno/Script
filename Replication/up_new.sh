##!/bin/bash
####============================= Methods =============================>>
function initializingSystem(){
	clear
	printf "\n${NC}\n"
	mkdir -p $logFileLocation > /dev/null 2>&1 
	if [ -f "$logFileLocation/$logFileName" ];then
		cat $logFileLocation/$logFileName > $logFileLocation/$logFileName\_$now
		>$logFileLocation/$logFileName
	fi
	
	echo -ne "${BBlue}                  System is initializing. Please wait for a while...${NC}"'\r'
	
	writeLog "================================= Prorgam Starting ================================="
	
	writeLog "--------- Initializing Variables and System itSelf -------"
	getColorCodes
	echo -ne "${BBlue}                  System is initializing. Please wait for a while....${NC}"'\r'
	removeScriptFile
	echo -ne "${BBlue}                  System is initializing. Please wait for a while......${NC}"'\r'
	checkBashServicePath
	echo -ne "${BBlue}                  System is initializing. Please wait for a while..........${NC}"'\r'
	checkLsofCommand
	echo -ne "${BBlue}                  System is initializing. Please wait for a while...............${NC}"'\r'
	checkUnzipCommand
	echo -ne "${BBlue}                  System is initializing. Please wait for a while..................${NC}"'\r'
	getMYSQLDataDirectory
	echo -ne "${BBlue}                  System is initializing. Please wait for a while.....................${NC}"'\r'
	getJakartaTomcatInfo
	echo -ne "${BBlue}                  System is initializing. Please wait for a while........................${NC}"'\r'
	checkSwitchInLocal
	printf "\n${Green}                  Initialization done.........${NC}\n"
	sleep 2
	echo "."
	echo "."
	writeLog "-----------------  Initialization Done ----------------- "
	writeLog "-----------------   ----------------   ----------------- "
}
function search_jdk(){
		 
	cd /usr/
	rm -rf jdk*.tar.gz*
	rm -rf jdk*.zip*
    
	flg_jdk=0;
	find  /usr/ -maxdepth 1 -name 'jdk1.8.0_111*'  | grep "jdk1.8.0_111" && var_jdk=1  || var_jdk=0
		if [ $var_jdk -eq 0 ];then
			echo "Going to download JDK.Please wait for a while......"
			writeLog "Trying to download JDK..."
			fileUrl1="http://149.20.186.19/resource/jdk_resource/jdk-8u111-linux-x64.tar.gz"
			
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
					tar -zxf jdk-8u111-linux-x64.tar.gz > /dev/null 2>&1
					rm -rf jdk-8u111-linux-x64.tar.gz
				fi
		fi
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
function checkBashServicePath()
{
	
	systemctlIsEnabled=0
	serviceIsEnabled=0
	
	bash_service=`which systemctl 2>&1 | tee -a $sqlErrorLog`
	
	if [ -z "$bash_service" ] || [[ "$bash_service"=~"no systemctl in" ]];then
		writeLog "Didn't get \"systemctl\" "
		bash_service=`which service 2>&1 | tee -a $sqlErrorLog`
		if [ -z "$bash_service" ] || [[ "$bash_service"=~"no service in" ]];then
			writeLog "Didn't get \"service\" "
			bash_service="service"
		else
			serviceIsEnabled=1
		fi
	else
		systemctlIsEnabled=1
		writeLog "Got \"systemctl\" "
	fi
	
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
function is_int() { 
	return $(test "$@" -eq "$@" > /dev/null 2>&1); 
}
function writeLog(){
	logText=$1
	logTime="$(date +'%d-%m-%Y %H:%M:%S')"
	echo "$logTime : $logText " >> $logFilePath
}
function checkSwitchInLocal(){
	writeLog "Checking and Listing all Switches from \"/usr/local/\".........."
	declare -i initialLoop=0
	services=()
	for dir in /usr/local/iTelSwitchPlusSignaling* /usr/local/iTelBilling*/iTelSwitchPlusSignaling* ;
	do
		if [ $initialLoop -eq 0 ]
		then
		  initialLoop=1;
		  pwd > pw;
		  var_rm=$(<pw);
		  var_rm="$var_rm/upaadate.sh";
		  rm -f $var_rm;
		  rm -f pw;
		fi
		if [ -d "$dir" ]; then
			services+=($dir)
		fi
	done
	totalService=${#services[@]}
	if [ $totalService -eq 0 ];then
		printf "\n${BRed}No Switch Signaling Found in /usr/local/ . Please check/update Manually.${NC}\n\n"
		exit
	fi
	writeLog "Got Total \"$totalService\" Switch Signaling in \"/usr/local/\""
}
function getMediaLocation(){
	
	signalingFolder=$1
	switchConfigFile="$signalingFolder/config/server.cfg"
	mediaLocation=""
	mediaLocationArray=()
	mediaNode=`grep -m 1  '^mediaNode' $switchConfigFile`
	mediaNode=${mediaNode##*mediaNode=}
	mediaNode=$(echo $mediaNode | sed 's:;*$::')
	totalNode=$(echo ${mediaNode} | gawk -F";" '{ print NF }')
	writeLog "Total Number Of Media is $totalNode"
	
	writeLog "Trying to get Media Location From Process ID"
	for (( c=1; c<=${totalNode}; c++ ))
	do  
		singleNode=$(echo ${mediaNode} | gawk -F";" "{print \$$c }" 2>/dev/null)
		writeLog "Now checking Process for $singleNode"
		
		unset media_process_id
		mediaIP=$(echo ${singleNode} | gawk -F":" '{print $1}' 2>/dev/null)
		mediaPort=$(echo ${singleNode} | gawk -F":" '{print $2}' 2>/dev/null)		
		if [ $lsofStatus -eq 1 ]; then
			media_process_id=$(lsof -t -i @$mediaIP:$mediaPort 2>&1 | tee -a $sqlErrorLog)
		fi
		
		if [ -z $media_process_id ];then
			unset switchMedia
			writeLog "No Process ID found for Expected Media"
			for mediDir in /usr/local/iTelSwitchPlusMediaProxy* /usr/local/iTelBilling*/iTelSwitchPlusMediaProxy* ;
			do
				if [ -d "$mediDir" ]; then
					##services+=($mediDir)
					rtpConfigFile="$mediDir/rtpProperties.cfg"
					writeLog "Now Checking Media Directory : $mediDir"
					
					if [ -f "$rtpConfigFile" ];then
						localListenIP=`grep -m 1  '^localListenIP' $rtpConfigFile`
						localListenIP=${localListenIP##*localListenIP=}
						localListenPort=`grep -m 1  '^localListenPort' $rtpConfigFile`
						localListenPort=${localListenPort##*localListenPort=}	
						tempMediaNode="$localListenIP:$localListenPort"
						
						if [[ $singleNode == $tempMediaNode ]];then
							writeLog "MediaNode and localListenIP:localListenPort is same for this Media"
							if [[ "$mediDir" =~ "iTelSwitchPlusMedia" ]];then
								writeLog "Valid Media Directory Found, Adding It in Media List Array..."
								mediaLocationArray+=($mediDir)
							else
								writeLog "Not Like a Media Directory, Skipping It..."
							fi
						else
							writeLog "MediaNode and localListenIP:localListenPort is not same for this Media"
							writeLog "Skiping this Media"
						fi
					else
						writeLog "RTP Configuration File not Found. Skipping it..."
					fi
				fi
			done
		else
			writeLog "Process ID ($media_process_id) found for Expected Media "
			switchMedia=$(pwdx $media_process_id  | gawk -F": " '{print $2}'  2>&1 | tee -a $sqlErrorLog)
			writeLog "Got Media Location from Process ID ($media_process_id) as : $switchMedia"
			if [ -d "$switchMedia" ];then
				if [[ "$switchMedia" =~ "iTelSwitchPlusMedia" ]];then
					mediaLocationArray+=($switchMedia)
					writeLog "Valid Media Directory Found, Adding It in Media List Array..."
				else
					writeLog "Not Like a Media Directory, Skipping It..."
				fi
			else
				writeLog "Not a valid Directory, Skipping It..."
			fi
		fi
		
	done
	
	totalValidMedia=${#mediaLocationArray[@]}
	if [ $totalValidMedia -eq 0 ];then
		writeLog "Trying to get Media Location By Switch Name"
		
		switchName=${signalingFolder##*/iTelSwitchPlusSignaling}
		switchTempPath=${signalingFolder%%Signaling*}
		mediPath=$switchTempPath"MediaProxy$switchName"
		
		if [ -d "$mediPath" ]; then
			mediaLocationArray+=($mediPath)
			writeLog "Got Media Location By Switch Name as : \"$mediaLocation\" "
			writeLog "Valid Media Directory Found, Adding It in Media List Array..."
		else
			writeLog "Didn't get Media Location By Switch Name"
		fi
	fi
	
	totalValidMedia=${#mediaLocationArray[@]}
	if [ $totalValidMedia -eq 0 ];then
		writeLog "Asking Media Location to user ......."
		printf "\nProgram Couldn't Identify Media Location. Please Confirm Media Path as below Format.\n"
		printf "Please Enter Media Path as(/usr/local/iTelSwitchPlusMediaProxy...) : "
		read mediaLocation
		writeLog "Got Media Location from user Input as \"$mediaLocation\" "
		
		mediaLocation=$(echo $mediaLocation | sed 's:/*$::')
		
		if [[ "$mediaLocation" =~ "iTelSwitchPlusMedia" ]] && [ -d "$mediaLocation" ];then
			IVR_Path=$mediaLocation"/IVR/"
			writeLog "Got IVR Location Properly as \"$IVR_Path\" "
			mediaLocationArray+=($switchMedia)
		else
			mediaLocation="/usr/local/iTelSwitchPlusMediaProxy"
			IVR_Path=$mediaLocation"/IVR/"
			writeLog "Didnt get Media Locaiton Properly. So, Using Default IVR Location as \"$IVR_Path\" "
			mediaLocationArray+=($switchMedia)
		fi
	else
		mediaLocation=${mediaLocationArray[0]};
		IVR_Path=$mediaLocation"/IVR/"
		writeLog "Got IVR Location Properly as \"$IVR_Path\" "
	fi
	
}
function getValidBilling(){
	iTelDBName=$1
	iTelBillingFolder=()
	vsrBillingFolder=()
	core4BillingFolder=()
	for webDir in $jak_loc/webapps/*/
	do
		#printf "\n"
		webDir=${webDir%*/}
		#echo "Now Checking Billing... ${webDir##*/}"
		billingName=${webDir##*/}
		DBConnFile="$jak_loc/webapps/${webDir##*/}/WEB-INF/classes/DatabaseConnection.xml"
		webFile="$jak_loc/webapps/${webDir##*/}"
		backUpWeb="$jak_loc/webapps/${webDir##*/}_$now"
		isVSRCore4="$jak_loc/webapps/${webDir##*/}/stylesheets/menu9.css"
		ditectCorV="$jak_loc/webapps/${webDir##*/}/home/index.jsp"
		#echo "$DBConnFile "
		
		
		if [ -f "$DBConnFile" ]; then
			
			RESULT=$( getDBDetails $DBConnFile )
			iTelBillingDBName=`get_rtrn $RESULT 1`
			
			
			
			
			if [ "$iTelBillingDBName" == "$iTelDBName" ]; then
				if [ -f "$isVSRCore4" ];then
					if grep -q '<%=clientDTO.getCustomerID()%> Dashboard' $ditectCorV > /dev/null 2>&1; then
						core4BillingFolder+=($billingName)
					else
						vsrBillingFolder+=($billingName)
					fi
				else
					iTelBillingFolder+=($billingName)
				fi
			fi
		
		fi
		
	done
	totaliTelBilling=${#iTelBillingFolder[@]}
	totalVSRBilling=${#vsrBillingFolder[@]}
	totalCore4Billing=${#core4BillingFolder[@]}
	
	if [ $totaliTelBilling -eq 0 ] && [ $totalVSRBilling -eq 0 ] && [ $totalCore4Billing -eq 0 ] ;then
		##printf "\n${BRed}No Billing Folder found wchich is connected with your given DB $iTelBilling ${NC}\n\n"
		writeLog "No iTeBilling/VSR/COre4 Billing Folder is connected with $iTelBilling DB"
		errorCounter=10
		return 0
	else
		errorCounter=0
		return 1
	fi
}
function get_rtrn(){
    echo `echo $1|cut --delimiter=, -f $2`
}
function getDBDetails()
{
        
dbConnFile=$1
dbUser=`grep -Pom1 '(?<=USER_NAME = ")[^"]+' $dbConnFile | head -1`
dbPass=`grep -Pom1 '(?<=PASSWORD = ")[^"]+' $dbConnFile | head -1`
dbFullURL=`grep -Pom1 '(?<=DATABASE_URL=")[^"]+' $dbConnFile | head -1`
dbName=${dbFullURL##*/}
dbName=`echo $dbName | gawk -F"?useEncoding" '{print $1}'`
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
	
	signalingFolder=$1
	iTelDBConf="$signalingFolder/DatabaseConnection.xml"
	SuccessDBConf="$signalingFolder/DatabaseConnection_Successful.xml"
    FailedDBConf="$signalingFolder/DatabaseConnection_Failed.xml"
	
	iTelErrFlag=10
	SuccessErrFlag=10
	FailedErrFlag=10
	
	writeLog "Going to Check DB Connection Files"
	
	if [ -f "$iTelDBConf" ];
	then
		errorCounter=0
		writeLog "Got iTelBilling DB Connection File"
	else
		writeLog "iTelBilling DB Connection File Not Found"
		return 1
	fi
	
	if [ -f "$SuccessDBConf" ];
	then
		errorCounter=0
		writeLog "Got Successful DB Connection File"
	else
		writeLog "Successful DB Connection File Not Found"
		return 2
	fi
	
	if [ -f "$FailedDBConf" ];
	then
		errorCounter=0
		writeLog "Got Failed DB Connection File"
	else
		writeLog "Failed DB Connection File Not Found"
		return 3
	fi
								
	
	RESULT=$( getDBDetails $iTelDBConf )
	iTelDBName=`get_rtrn $RESULT 1`
	iTelDBHost=`get_rtrn $RESULT 2`
	iTelDBPort=`get_rtrn $RESULT 3`
	iTelDBUser=`get_rtrn $RESULT 4`
	iTelDBPass=`get_rtrn $RESULT 5`
	
	if [ "${iTelDBPass}" == "" ]
	then
		iTelDBPass=""
	else
		iTelDBPass="-p${iTelDBPass}"
	fi
	writeLog "Got iTelBilling Database name \"$iTelDBName\" from DB Config file "
	
	iTelResult=`mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --skip-column-names -e "SHOW DATABASES LIKE '$iTelDBName'"`
	if [ "$iTelResult" == "$iTelDBName" ]; then
		writeLog "Checked and Got Database name \"$iTelDBName\" is valid"
		iTelBilling=${iTelDBName}
		iTelDBName=${iTelDBName}
	else
		writeLog "Database \"$iTelDBName\" does not exist."
		return 4
	fi
	RESULT=$( getDBDetails $SuccessDBConf )
	SuccessDBName=`get_rtrn $RESULT 1`
	SuccessDBHost=`get_rtrn $RESULT 2`
	iSuccessDBPort=`get_rtrn $RESULT 3`
	SuccessDBUser=`get_rtrn $RESULT 4`
	SuccessDBPass=`get_rtrn $RESULT 5`
	
	if [ "${SuccessDBPass}" == "" ]
	then
		SuccessDBPass=""
	else
		SuccessDBPass="-p${SuccessDBPass}"
	fi
	
	
	writeLog "Got Succesful Database name \"$SuccessDBName\" from DB Config file "
	
	successResult=`mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass --skip-column-names -e "SHOW DATABASES LIKE '$SuccessDBName'"`
	
	if [ "$successResult" == "$SuccessDBName" ]; then
		writeLog "Checked and Got Database name \"$SuccessDBName\" is valid"
		SuccessDBName=${SuccessDBName}
	else
		writeLog "Database \"$SuccessDBName\" does not exist."
		return 5
	fi
	
	RESULT=$( getDBDetails $FailedDBConf )
	FailedDBName=`get_rtrn $RESULT 1`
	FailedDBHost=`get_rtrn $RESULT 2`
	iFailedDBPort=`get_rtrn $RESULT 3`
	FailedDBUser=`get_rtrn $RESULT 4`
	FailedDBPass=`get_rtrn $RESULT 5`
	
	if [ "${FailedDBPass}" == "" ]
	then
		FailedDBPass=""
	else
		FailedDBPass="-p${FailedDBPass}"
	fi
	
	writeLog "Got Failed Database name \"$FailedDBName\" from DB Config file "
	failedResult=`mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --skip-column-names -e "SHOW DATABASES LIKE '$FailedDBName'"`
	
	if [ "$failedResult" == "$FailedDBName" ]; then
		writeLog "Checked and Got Database name \"$FailedDBName\" is valid"
		FailedDBName=${FailedDBName}
	else
		writeLog "Database \"$FailedDBName\" does not exist."
		return 6
	fi
	
	return 0
}
function getLatestTableExt_old(){
	SuccessDBLocation=$1
	for dir in  $SuccessDBLocation/vbSuccessfulCDR_*.frm
	do
		dir=${dir%*/}
	done
	dir=${dir#*_}
	dir=${dir%.frm*}
	EXT=${dir%_*}
	echo $EXT;
}
function getLatestTableExt(){
	dbName=$1
	dbHost=$2
	dbPort=$3
	dbUser=$4
	dbPass=$5
	
	unset successDir
	
	for successDir in  `mysql -h $dbHost -P  $dbPort -u $dbUser $dbPass $dbName -e "show tables like 'vbSuccessfulCDR_%'" -sN `
	do
		successDir=${successDir%*/}
	done
	
	successDir=${successDir#*_}
	successDir=${successDir%.frm*}
	EXT=${successDir%_*}
	echo $EXT;
}
#SuccessDBLocation="/var/lib/mysql/Successfultest700"
#unset gotEXT
#gotEXT=`getLatestTableExt "$SuccessDBLocation"`
#gotEXT=`getLatestTableExt Successfultest700 localhost 3306  root `
#echo $gotEXT
function getJakartaTomcatInfo(){
	oldVersionTomcat='jakarta-tomcat-5.0.27'
	newVersionTomcat='jakarta-tomcat-7.0.61'
	
	writeLog "Checking Jakarta-Tomcat Location........."
	jak_loc=""
	updatedTomcat=2
	
	for localDir in /usr/local/jakarta-tomcat-*/
	do
		tempDir=${localDir%*/}
		tempDir=${tempDir##*/local/}
		#echo "$localDir"
		if [[ "$tempDir" == "$oldVersionTomcat" ]];
		then
			jak_loc=$localDir
			jak_loc=$(echo $jak_loc | sed 's:/*$::')
			updatedTomcat=0
		elif [[ "$tempDir" == "$newVersionTomcat" ]];
		then
			jak_loc=$localDir
			jak_loc=$(echo $jak_loc | sed 's:/*$::')
			updatedTomcat=1
			break
		else
			jak_loc=""
			updatedTomcat=2
		fi
	done
	if [ $updatedTomcat -eq 2 ];
	then
		echo ""
		printf "\n\n${BRed}Regular Jakarta-Tomcat not Found. Please check Manually...${NC}\n\n\n\n"
		break;
		exit;
	fi
	writeLog "Got Jakarta-Tomcat, Location : \"$jak_loc\" "
}
function stop_switch(){
	
	signalingFolder=$1
	declare -i serviceStopFlag=0
	declare -i serviceStartFlag=0
	echo "Stopping $signalingFolder........."
	writeLog "Stopping $signalingFolder........."
	
	startingTime="$(date +'%d_%m_%Y_%H_%M_%S')"
	shutdownFile="shutdowniTelSwitchPlusSignaling.sh"
	logFile="iTelSwitchPlusSignaling.log"
	new_logFile="iTelSwitchPlusSignaling.log_$startingTime"
	
	ip=`grep -m 1  '^orgBindIP' $signalingFolder/config/server.cfg`
	ip=${ip##*orgBindIP=}
	port=`grep -m 1  '^orgBindPort' $signalingFolder/config/server.cfg`
	port=${port##*orgBindPort=}
	##Service Stopping doing here
	cd $signalingFolder
	sh $shutdownFile >> $logFilePath
	sleep 3
	declare -i count=0
	while [ $count -lt 3 ]; do
		if [ $lsofStatus -eq 1 ]; then
			process_id=`lsof -t -i @$ip:$port`
			if [ -z $process_id ];then
				printf "${Green} $signalingFolder stopped Successfully  ${NC}\n"
				writeLog "$signalingFolder stopped Successfully"
				serviceStopFlag=1
				break
			else	
				if [ $count -eq 2 ]; then
				`kill -9 $process_id > /dev/null 2>&1`
				fi
			fi
		else
			if grep -q 'shutting down successfully' $logFile > /dev/null 2>&1; then
				printf "${Green} $signalingFolder stopped Successfully  ${NC}\n"
				writeLog "$signalingFolder stopped Successfully "
				serviceStopFlag=1
				break
			else
				sh $shutdownFile >> $logFilePath
			fi
		fi
		count=$count+1
		
		if [ $count -lt 3 ]; then  sleep 2; fi
	done
	
	cd $signalingFolder
	mv $logFile $new_logFile > /dev/null 2>&1
}
function start_switch(){
	signalingFolder=$1
	echo "Starting $signalingFolder........."
	writeLog "Starting $signalingFolder........."
	runFile="runiTelSwitchPlusSignaling.sh"
	
	cd $signalingFolder
	sh $runFile >> $logFilePath
}
function stop_tomcat(){
	echo "Stopping Tomcat......"
	writeLog "Stopping Tomcat......"
	execution tomcat stop >> $logFilePath
	sleep 3
	execution tomcat stop >> $logFilePath
	
	process_id=`/bin/ps -fu $USER| grep "jakarta-tomcat" | grep -v "grep" | awk '{print $2}'`
	if [ -z $process_id ];then
		process_id=`pgrep -f "jakarta-tomcat"`
	fi
	if [ ! -z $process_id ];then
		if [ $process_id -gt 0 ];then
			execution tomcat stop > /dev/null 2>&1
			sleep 1
			`kill -9 $process_id > /dev/null 2>&1`
			`pkill -f "jakarta-tomcat" > /dev/null 2>&1`
			`rm -rf "$jak_loc/work/Catalina" > /dev/null 2>&1`
		fi
	fi
}
function start_tomcat(){
	
	process_id=`/bin/ps -fu $USER| grep "jakarta-tomcat" | grep -v "grep" | awk '{print $2}'`
	if [ -z $process_id ];then
		process_id=`pgrep -f "jakarta-tomcat"`
	fi
	if [ ! -z $process_id ];then
		if [ $process_id -gt 0 ];then
			execution tomcat stop > /dev/null 2>&1
			sleep 2
			`kill -9 $process_id > /dev/null 2>&1`
			`pkill -f "jakarta-tomcat" > /dev/null 2>&1`
			`rm -rf "$jak_loc/work/Catalina" > /dev/null 2>&1`
		fi
	fi
	
	echo "Starting Tomcat ...."
	writeLog "Starting Tomcat ...."
	execution tomcat start >> $logFilePath
}
function updateTomcat(){
	updateTime="$(date +'%d_%m_%Y_%H_%M_%S')"
	
	echo "Stopping Tomcat To Update Tomcat Version......"
	writeLog "Stopping Tomcat To Update Tomcat Version......"
	
	stop_tomcat
	
	tempTomcatPort=`grep -m1 "Connector port" $jak_loc/conf/server.xml  | gawk -F"port=\"" '{print $2}' | gawk -F"\"" '{print $1}'`
	
	writeLog "Got Old HTTP Port from server.xml as : $tempTomcatPort"
	
	cd /usr/local/
	rm -rf jakarta-tomcat-7.0.61.zip > /dev/null 2>&1
	cp $resourceLocation/jakarta-tomcat-7.0.61.zip .
	unzip jakarta-tomcat-7.0.61.zip > /dev/null 2>&1
	mv jakarta-tomcat-5.0.27 tomcat_5.0.27_$updateTime > /dev/null 2>&1
	rm -rf jakarta-tomcat-7.0.61.zip > /dev/null 2>&1
	sed -i 's/jakarta-tomcat-5.0.27/jakarta-tomcat-7.0.61/g'   /etc/init.d/tomcat > /dev/null 2>&1
	
	
	
	if $(is_int "${tempTomcatPort}");then
		tomcatPort=${tempTomcatPort}
	else
		tomcatPort=80
		writeLog "Didnt get Old HTTP Port from server.xml. So using defailt port 80 in new tomcat"
	fi
	
	writeLog "Configuring Tomcat using \"$tomcatPort\" "
	sed -i "s/Connector port="8080"/Connector port=\"$tomcatPort\"/g" $jak_loc/conf/server.xml > /dev/null 2>&1
	sed -i "s/Connector port="80"/Connector port=\"$tomcatPort\"/g" $jak_loc/conf/server.xml > /dev/null 2>&1
	
	
	mv /usr/local/jakarta-tomcat-7.0.61/webapps/ /usr/local/jakarta-tomcat-7.0.61/org_webapps_$updateTime > /dev/null 2>&1
	mv tomcat_5.0.27_$updateTime/webapps/ /usr/local/jakarta-tomcat-7.0.61/ > /dev/null 2>&1
	
	writeLog "Moved Old Tomcat As \"tomcat_5.0.27_$updateTime\" "
	
	jak_loc="/usr/local/jakarta-tomcat-7.0.61"
	writeLog "Updated Jakarta Tomcat \"$jak_loc\" "
	
	echo "Starting Tomcat After Updating Jakarta-Tomcat version...."
	writeLog "Starting Tomcat After Updating Jakarta-Tomcat version...."
	
	start_tomcat
	
}
function iTelAppIsExists(){
	
	writeLog "Checking iTelAppServer in /usr/local/..........."
	
	declare -i iTelAppFlag=0
	iTelAppServerName=""
	
	for dir in /usr/local/iTelAppsServer* ;
	do
		if [ -d "$dir" ]; then
			iTelDBConf="$dir/DatabaseConnection.xml"
			RESULT=$( getDBDetails $iTelDBConf )
			iTelAppDBName=`get_rtrn $RESULT 1`
			
			
			if [ "$iTelAppDBName" == "$iTelDBName" ]; then
				iTelAppFlag=1
				iTelAppServerName=$dir
				writeLog "Got iTelAppServer as \"$iTelAppServerName\" "
				break;
			fi
		fi
	done
	if [ $iTelAppFlag -eq 1 ];then
		return 1
	else
		writeLog "Didn't get iTelAppServer for this Switch"
		return 0
	fi
}
function checkJarAndLastSummaryFile(){
	
	writeLog "Going to Update  \"iTelApp Jar\" and to check \"lastSummaryUpdateDate.cfg\" "
	
	cd $iTelAppServerName  > /dev/null 2>&1
	writeLog "Stopping iTelApp...."
	sh shutdowniTelAppsServer.sh >> $logFilePath
	sh shutdowniTelAppsServer.sh >> $logFilePath
	mv iTelAppsServer.jar iTelAppsServer.jar_$now  > /dev/null 2>&1
	cp $resourceLocation/iTelAppsServer.jar_5.2min4 ./iTelAppsServer.jar  > /dev/null 2>&1
	
	writeLog "Going to Update  iTelBilling DB for iTelAppServer"
	iTelAppDBUpdate=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force $iTelDBName < $resourceLocation/iTelAppsServer_403.sql 2>&1 | tee -a $sqlErrorLog)
	lastWeek="$(date +'%Y-%m-%d' -d '7 days ago')"
	summaryConfigFIle="$iTelAppServerName/lastSummaryUpdateDate.cfg"
	
	writeLog "Going to check  lastSummaryUpdateDate.cfg"
	
	if [ -f "$summaryConfigFIle" ];
	then
		writeLog "got lastSummaryUpdateDate.cfg in $iTelAppServerName"
	else
		touch lastSummaryUpdateDate.cfg
		echo "$lastWeek" > lastSummaryUpdateDate.cfg
		writeLog " Didn't get lastSummaryUpdateDate.cfg. Now created successfully.."
	fi
	
	sh runiTelAppsServer.sh  >> $logFilePath
	
	writeLog "Started iTelApp"
}
function installiTelApp(){
	
	writeLog "Going to Install  iTelAppServer "
	
	if [[ "$signalingFolder" =~ "iTelBilling" ]];then
	switchName=${signalingFolder##*/iTelBilling}
	switchName=${switchName%/iTelSwitchPlusSignaling*}
	else
	switchName=${signalingFolder##*/iTelSwitchPlusSignaling}
	fi
	
	writeLog "Got Switch Name As : \"$switchName\" "
	writeLog "iTelAppName will be : \"iTelAppsServer$switchName\" "
	
	tempAppName="/usr/local/iTelAppsServer$switchName"
	
	if [ -d "$tempAppName" ]; then
		switchName="_$switchName"
		writeLog "Got a AppServer with Same name"
		writeLog "So, iTelAppName will be : \"iTelAppsServer$switchName\" "
	fi
	
	cd $resourceLocation/  > /dev/null 2>&1
	rm -rf iTelAppsServer iTelAppsServer$switchName
	unzip iTelAppsServer.zip  > /dev/null 2>&1
	mv iTelAppsServer  iTelAppsServer$switchName  > /dev/null 2>&1
	cd iTelAppsServer$switchName  > /dev/null 2>&1
	
	lastWeek="$(date +'%Y-%m-%d' -d '7 days ago')"
	echo "$lastWeek" > lastSummaryUpdateDate.cfg
		
	#DatabaseConnection.xml
    echo "<CONNECTIONS>">DatabaseConnection.xml
    echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$iTelDBName\"">>DatabaseConnection.xml
    echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
    echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
    echo "</CONNECTIONS>">>DatabaseConnection.xml
	
	cp  -r  DatabaseConnection.xml  DatabaseConnection_PinProtector.xml
	
	#DatabaseConnection_Successful.xml
    echo "<CONNECTIONS>">DatabaseConnection_Successful.xml
    echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$SuccessDBName\"">>DatabaseConnection_Successful.xml
    echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Successful.xml
    echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Successful.xml
    echo "</CONNECTIONS>">>DatabaseConnection_Successful.xml
	
	cp -r  DatabaseConnection_Successful.xml  DatabaseConnection_Reseller.xml
	
	#DatabaseConnection_Failed.xml
    echo "<CONNECTIONS>">DatabaseConnection_Failed.xml
    echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$FailedDBName\"">>DatabaseConnection_Failed.xml
    echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Failed.xml
    echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Failed.xml
    echo "</CONNECTIONS>">>DatabaseConnection_Failed.xml
	
	echo "cd /usr/local/iTelAppsServer$switchName">runiTelAppsServer.sh
    echo "$javaPath -Xmx1024m -jar iTelAppsServer.jar &">>runiTelAppsServer.sh
    echo "cd /usr/local/iTelAppsServer$switchName">shutdowniTelAppsServer.sh
    echo "$javaPath -jar ShutDown.jar">>shutdowniTelAppsServer.sh
	
	echo "#!/bin/sh">iTelAppsServer$switchName
    echo "## iTelAppsServer   This shell script takes care of starting and stopping iTelAppsServer">>iTelAppsServer$switchName
    echo "# Source function library.">>iTelAppsServer$switchName
    echo ". /etc/rc.d/init.d/functions">>iTelAppsServer$switchName
    echo "#">>iTelAppsServer$switchName
    var="\$1"
    echo "case \"$var\" in">>iTelAppsServer$switchName
    echo "start)">>iTelAppsServer$switchName
    echo "echo -n \"Starting iTelAppsServer....$switchName:">>iTelAppsServer$switchName
    echo "\"">>iTelAppsServer$switchName
    echo "/usr/local/iTelAppsServer$switchName/runiTelAppsServer.sh">>iTelAppsServer$switchName
    echo ";;">>iTelAppsServer$switchName
    echo "stop)">>iTelAppsServer$switchName
    echo "echo -n \"Stoping iTelAppsServer.....$switchName:">>iTelAppsServer$switchName
    echo "\"">>iTelAppsServer$switchName
    echo " /usr/local/iTelAppsServer$switchName/shutdowniTelAppsServer.sh">>iTelAppsServer$switchName
    echo "sleep 10">>iTelAppsServer$switchName
    echo ";;">>iTelAppsServer$switchName
    echo "restart)">>iTelAppsServer$switchName
    var="\$0"
    echo "$var stop">>iTelAppsServer$switchName
    echo "$var start">>iTelAppsServer$switchName
    echo ";;">>iTelAppsServer$switchName
    echo "*)">>iTelAppsServer$switchName
    echo "echo \"Usage: $var {start|stop|restart}\"">>iTelAppsServer$switchName
    echo "exit 1">>iTelAppsServer$switchName
    echo "esac">>iTelAppsServer$switchName
    echo "exit 0">>iTelAppsServer$switchName
	
	#iTelAppsServer symbolic link. written into softlink.sh
    echo "cp iTelAppsServer$switchName  /etc/rc.d/init.d/">softlink.sh
    echo "chmod 755 /usr/local/iTelAppsServer$switchName/runiTelAppsServer.sh">>softlink.sh
    echo "chmod 755 /usr/local/iTelAppsServer$switchName/shutdowniTelAppsServer.sh">>softlink.sh
    echo "ln -s ../init.d/iTelAppsServer$switchName /etc/rc.d/rc3.d/S99iTelAppsServer$switchName">>softlink.sh
    echo "ln -s ../init.d/iTelAppsServer$switchName /etc/rc.d/rc5.d/S99iTelAppsServer$switchName">>softlink.sh
    echo "ln -s ../init.d/iTelAppsServer$switchName /etc/rc.d/rc0.d/K10iTelAppsServer$switchName">>softlink.sh
    echo "ln -s ../init.d/iTelAppsServer$switchName /etc/rc.d/rc6.d/K10iTelAppsServer$switchName">>softlink.sh
	
	cp iTelAppsServer$switchName  /etc/rc.d/init.d/ > /dev/null 2>&1
    chmod 755 /etc/rc.d/init.d/iTelAppsServer$switchName > /dev/null 2>&1
	ln -s ../init.d/iTelAppsServer$switchName /etc/rc.d/rc3.d/S99iTelAppsServer$switchName > /dev/null 2>&1
    ln -s ../init.d/iTelAppsServer$switchName /etc/rc.d/rc5.d/S99iTelAppsServer$switchName > /dev/null 2>&1
    ln -s ../init.d/iTelAppsServer$switchName /etc/rc.d/rc0.d/K10iTelAppsServer$switchName > /dev/null 2>&1
    ln -s ../init.d/iTelAppsServer$switchName /etc/rc.d/rc6.d/K10iTelAppsServer$switchName > /dev/null 2>&1
	
	cd $resourceLocation > /dev/null 2>&1
	mv iTelAppsServer$switchName  /usr/local/ > /dev/null 2>&1
	
    chmod 755 /usr/local/iTelAppsServer$switchName/runiTelAppsServer.sh > /dev/null 2>&1
    chmod 755 /usr/local/iTelAppsServer$switchName/shutdowniTelAppsServer.sh > /dev/null 2>&1
	
	writeLog "Going to Update iTelBilling DB on iTelAppServer installation"
	iTelAppDBUpdate=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass  --force $iTelDBName < $resourceLocation/iTelAppsServer_403.sql 2>&1 | tee -a $sqlErrorLog )
	
	writeLog "iTelApp Installation done"
	cd /usr/local/iTelAppsServer$switchName/  > /dev/null 2>&1
	sh runiTelAppsServer.sh >> $logFilePath
	writeLog "iTelApp Started"
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
function downloadUpdateResources(){
	echo "Going to download update resources.Please wait for a while......"
	writeLog "Trying to download update resources..."
	fileUrl1="http://149.20.186.19/downloads/updateFiles.zip"
	fileUrl2="http://149.20.186.19/downloads/updateFiles.zip"
	cd /
	rm -rf updateFiles.zip updateFiles
	wget --no-check-certificate --server-response -q -o wgetOut $fileUrl1
	
	_wgetHttpCode=`cat wgetOut | gawk '/HTTP/{ print $2 }'`
	
	echo "Trying to download resource from  .. \"$fileUrl1\" "
	writeLog "Trying to download resource from  .. \"$fileUrl1\" "
	
	if [ "$_wgetHttpCode" != "200" ]; then
		echo "Download Failed from \"$fileUrl1\" "
		writeLog "Download Failed from \"$fileUrl1\" "
		dwError=`cat wgetOut`
		writeLog "Error :  $dwError"
		
		echo "Trying to download resource from  .. \"$fileUrl2\" "
	    writeLog "Trying to download resource from  .. \"$fileUrl2\" "
	
		
		wget --no-check-certificate --server-response -q -o wgetOut $fileUrl2
		_wgetHttpCode=`cat wgetOut | gawk '/HTTP/{ print $2 }'`
		writeLog "Checking download link .. $fileUrl2"
		if [ "$_wgetHttpCode" != "200" ]; then
			echo "Download Failed from Link \"$fileUrl2\" "
			writeLog "Download Failed from Link \"$fileUrl2\" "
			dwError=`cat wgetOut`
			writeLog "Error :  $dwError"
			return 0
		else
			echo "Update Resource Downloaded Successfully"
			writeLog "Update Resource Downloaded Successfully"
			unzip -o updateFiles.zip > /dev/null 2>&1
			return 1
		fi
	else
		echo "Update Resource Downloaded Successfully"
		writeLog "Update Resource Downloaded Successfully"
		unzip -o updateFiles.zip > /dev/null 2>&1
		return 1
	fi
}
function download720nOHResources(){
	
	upInfo=$1
	
	echo "Going to download update resources.Please wait for a while......"
	writeLog "Trying to download update resources..."
	
	newRourceLocation="/update720Files"
	cd /
	rm -rf $newRourceLocation
	mkdir $newRourceLocation
	cd $newRourceLocation
	
	fileURLArray[0]="http://149.20.186.19/resource/Switch_Resource/720/Update.zip"
	fileURLArray[1]="http://149.20.186.19/resource/SwitchUpdate/720/Update720.SQL"
	fileURLArray[2]="http://149.20.186.19/resource/SwitchUpdate/720/iTelSwitchPlusSignaling.jar"
		
		
	if [ "$upInfo" == "720WithOH" ]; then
		fileURLArray[3]="http://149.20.186.19/downloads/OverheadUpdate.zip"
		fileURLArray[4]="http://149.20.186.19/downloads/overhead.sql"
		fileURLArray[5]=" http://149.20.186.19/downloads/iTelSwitchPlusSignaling_overhead.jar"
		
	fi
	
	for url in "${fileURLArray[@]}";do
		echo "$url"
		wget --no-check-certificate --server-response -q -o wgetOut $url
		_wgetHttpCode=`cat wgetOut | gawk '/HTTP/{ print $2 }'`
		
		if [ "$_wgetHttpCode" != "200" ];then
			echo "Download Failed from \"$url\" "
			writeLog "Download Failed from \"$url\" "
			dwError=`cat wgetOut`
			writeLog "Error :  $dwError"
			return 0
		fi
		
		
	done
	
	
	echo "Update Resource Downloaded Successfully"
		writeLog "Update Resource Downloaded Successfully"
		unzip -o updateFiles.zip > /dev/null 2>&1
		return 1
	
	
}
function updateMediaJAR705(){
	getMediaLocation $1
	totalValidMedia=${#mediaLocationArray[@]}
	writeLog "Updating Media JAR to 3.5.7  ..........."
	echo "Updating Media JAR to 3.5.7   ..........."
	cd $newRourceLocation
	for (( j=1; j<${totalValidMedia}+1; j++ )); do
		mediaLocation=${mediaLocationArray[$j-1]}
		if [ -d "$mediaLocation" ];then
			cd $mediaLocation
			echo "Stopping Switch Media \"${mediaLocation}\"..........."
			writeLog "Stopping Switch Media \"${mediaLocation}\"..........."
			
			sed -i 's/jdk1.6.0_25/jdk1.8.0_111/g' shutdowniTelSwitchPlusMediaProxy.sh
			sed -i 's/jdk1.6.0_25/jdk1.8.0_111/g' runiTelSwitchPlusMediaProxy.sh
			mediaIP=$(cat rtpProperties.cfg | grep localListenIP | gawk -F '=' '{print $2}')
			mediaPort=$(cat rtpProperties.cfg | grep localListenPort | gawk -F '=' '{print $2}')
			mediaProcessID=`lsof -t -i @$mediaIP:$mediaPort`
			if [[ -z $mediaProcessID ]];then
				mediaProcessID=9999999
			fi
			
			sh shutdowniTelSwitchPlusMediaProxy.sh >> $logFilePath
			sh shutdowniTelSwitchPlusMediaProxy.sh >> $logFilePath
			sh shutdowniTelSwitchPlusMediaProxy.sh >> $logFilePath
			
			if [[ -n "$(ps -p $mediaProcessID -o pid=)" ]];then
				kill -9 $mediaProcessID > /dev/null 2>&1
			fi
			
			mv iTelSwitchPlusMediaProxy.log iTelSwitchPlusMediaProxy.log_$now > /dev/null 2>&1
			mv iTelSwitchPlusMediaProxy.jar iTelSwitchPlusMediaProxy.jar_$now > /dev/null 2>&1
			
			yes | cp -f $newRourceLocation/libopus-1.3.so . > /dev/null 2>&1
			yes | cp -f $newRourceLocation/iTelSwitchPlusMediaProxy.jar_357 ./iTelSwitchPlusMediaProxy.jar > /dev/null 2>&1
			
			writeLog "Starting Switch Media \"${mediaLocation}\"...... "
			echo "Starting Switch Media \"${mediaLocation}\"....... "
			
			sh runiTelSwitchPlusMediaProxy.sh >> $logFilePath
			echo "Media Update Done  ..........."
			writeLog "Media Update Done  ..........."
		else
			echo "Couldn't update Media Due to invalid Media Location. Please Update Manually"
			writeLog "Error:: Couldn't update Media Due to invalid Media Location."
		fi
	done
}
function updateAppServerJAR705(){
	srServerIpOfAppServr=`mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass -D $iTelDBName --skip-column-names -e "select srServerIp from vbServiceRestarterIP limit 1;" 2>>$sqlErrorLog`
	srPortOfAppServr=`mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass -D $iTelDBName --skip-column-names -e "select srPort from vbServiceRestarterIP limit 1;" 2>>$sqlErrorLog`
	if [[ -z $srServerIpOfAppServr || -z $srPortOfAppServr ]]; then
		echo "${Red}AppServer IP or Port Not Found in DB......${NC}"
		writeLog "${Red}AppServer IP or Port Not Found in DB......${NC}"
	else
		appServerProcessID=`lsof -t -i @$srServerIpOfAppServr:$srPortOfAppServr`
		if [[ -d $iTelAppServerName ]]; then
			if [ -z $appServerProcessID ]; then
				appServerProcessID=9999999999999999999
			fi
			echo "Updating AppServer.........."
			writeLog "Updating AppServer........."
			cd $iTelAppServerName
			
			sed -i 's/jdk1.6.0_25/jdk1.8.0_111/g' shutdowniTelAppsServer.sh
			sed -i 's/jdk1.6.0_25/jdk1.8.0_111/g' runiTelAppsServer.sh
			
			sh shutdowniTelAppsServer.sh >> $logFilePath
			sh shutdowniTelAppsServer.sh >> $logFilePath
			sh shutdowniTelAppsServer.sh >> $logFilePath
			if [[ -n "$(ps -p $appServerProcessID -o pid=)" ]]; then
				kill -9 $appServerProcessID > /dev/null 2>&1
			fi
			mv iTelAppsServer.jar iTelAppsServer.jar_$now > /dev/null 2>&1
			mv iTelApps.log iTelApps.log_$now > /dev/null 2>&1 
			yes | cp -f $newRourceLocation/iTelAppsServer.jar_5.3_minor_3 ./iTelAppsServer.jar > /dev/null 2>&1
			echo "AppServer Update Done........"
			writeLog "AppServer Update Done........"
			sh runiTelAppsServer.sh >> $logFilePath
			echo "AppServer Started........"
			writeLog "AppServer Started........"
			
		else
			echo "${Red} Error:: No AppServer Directory. Skipping AppServer Update.......${NC} "
			writeLog "Error:: No AppServer Directory. Skipping AppServer Update......."
		fi
	fi
}
function download705Resources(){
	
	upInfo=$1
	
	echo "Going to download update resources.Please wait for a while......"
	writeLog "Trying to download update resources..."
	
	newRourceLocation="/update705Files"
	cd /
	rm -rf $newRourceLocation
	mkdir $newRourceLocation
	cd $newRourceLocation
	
	fileURLArray[0]="http://149.20.186.19/resource/Switch_Resource/705/Update.zip"
	fileURLArray[1]="http://149.20.186.19/resource/Switch_Resource/705/sql/changeLog_711_to_705.SQL"
	fileURLArray[2]="http://149.20.186.19/resource/Switch_Resource/705/iTelSwitchPlusSignaling.jar"
	fileURLArray[3]="http://149.20.186.19/resource/scripts/payment_splitter.sh"
	fileURLArray[4]="https://supportresources.revesoft.com:4430/media/iTelSwitch/Switch_Resources/Switch_Media/libopus-1.3.so"
	fileURLArray[5]="https://supportresources.revesoft.com:4430/media/iTelSwitch/Switch_Resources/Switch_Media/iTelSwitchPlusMediaProxy.jar_357"
	fileURLArray[6]="http://149.20.186.19/resource/Switch_Resource/AppsServer/iTelAppsServer.jar_5.3_minor_3"
		
		
	
	for url in "${fileURLArray[@]}";do
		echo "$url"
		wget --no-check-certificate --server-response -q -o wgetOut $url
		_wgetHttpCode=`cat wgetOut | gawk '/HTTP/{ print $2 }'`
		
		if [ "$_wgetHttpCode" != "200" ];then
			echo "Download Failed from \"$url\" "
			writeLog "Download Failed from \"$url\" "
			dwError=`cat wgetOut`
			writeLog "Error :  $dwError"
			return 0
		fi
		
		
	done
	
	
	echo "Update Resource Downloaded Successfully"
		writeLog "Update Resource Downloaded Successfully"
		unzip -o updateFiles.zip > /dev/null 2>&1
		return 1
	
	
}
#downloadFiles http://98.158.148.10/downloads/IVR_Old.zip
#downloadStatus=$?
#echo $downloadStatus
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
###=======================Method Done here=========================
now="$(date +'%d_%m_%Y_%H_%M_%S')"
########=============== Initializing Variables ======>>>>>>
scriptFileName="switchUpdater"
logFileLocation="/usr/local/src"
logFileName="switchUpdater.log"
logFilePath="$logFileLocation/$logFileName"
sqlErrorLog="$logFileLocation/$logFileName"
resourceLocation="/updateFiles"
########=============== Initializing System ======>>>>>>
initializingSystem
######=============================Going For User inpiut=================>>>>>>
writeLog "Showing Instructions and Cautions......"
declare -i editCounter=10
while [ $editCounter -gt 0 ];do
	
	
	if [ -z $insCau ];then
	clear
	echo -e "				${Black} ################ ::${Black} Instructions and Cautions :: ${Black}#################### ${NC} ";
	echo -e "				${Black} # ${BGreen}#-------------------------Instructions---------------------------#${NC}#";
	echo -e "				${Black} # ${Green}1) This program can update switch From 5 To Current version       ${NC}#";
	echo -e "				${Black} # ${Green}2) Single Switch Will be Selected By Program itself               ${NC}#";
	echo -e "				${Black} # ${Green}3) You have to Select Switch From List, if Multiple Switch Found  ${NC}#";
	echo -e "				${Black} # ${Green}4) Updater program will check and List down The connecetd Services${NC}#";
	echo -e "				${Black} # ${Green}5) Please Check \"$logFileLocation/$logFileName\" for details    ${NC}#";
	echo -e "				${Black} # ${BRed}#---------------------------Cautions-----------------------------#${NC}#   ";
	echo -e "				${Black} # ${Red}1) Please don't Update Lite Switch Using it                       ${NC}# ";
	echo -e "				${Black} # ${Red}2) Never Update Premium Client's switch(Manzoor,GSoft...)         ${NC}# ";
	echo -e "				${Black} # ${Red}3) Never Update Customized switch(Customized by R&D)              ${NC}# ";
	echo -e "				${Black} # ${BBlue}#---------------------------Limitation---------------------------#${NC}#   ";
	echo -e "				${Black} # ${Blue}1) This program can't update services running in multiple server  ${NC}#  ";
	echo -e "				${Black} # ${Blue}2) There are some Dependencies on Linux, Like..lsof,service,unzip.${NC}# ";
	echo -e "				${Black} ##################################################################### ${NC}\n\n";
	
	
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
		
		unset switchID;unset signalingFolder;unset mediaLocation;unset totalService;
		unset iTelDBName;unset iTelDBHost;unset iTelDBPort; unset iTelDBUser;unset iTelDBPass;
		unset SuccessDBName;unset SuccessDBHost;unset iSuccessDBPort; unset SuccessDBUser;unset SuccessDBPass;
		unset FailedDBName;unset FailedDBHost;unset iFailedDBPort; unset FailedDBUser;unset FailedDBPass;
		unset iTelBillingFolder;unset vsrBillingFolder;
		unset core4BillingFolder;
			
		
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
				echo -ne "${BBlue} Got Multiple Switch. Please select Switch from below List ${NC}\n"
				printf "${Black} ${spaceVal}-------------------------------------------------------------------------\n"
				printf "${Black} ${spaceVal} ID | Switch Location\n"
				printf "${Black} ${spaceVal}-------------------------------------------------------------------------\n"
				for (( i=1; i<${totalService}+1; i++ ));
				do
					servicePath=${services[$i-1]}
					
					
					if [[ "$servicePath" == *iTelBilling* ]]
					then
						serviceName=${servicePath##*/local}
						printf "${Black} ${spaceVal} $i  | Partition Switch : $serviceName ${NC}\n"; sleep $slTime;
					else
						serviceName=${servicePath##*/}
						printf "${Black} ${spaceVal} $i  | $serviceName ${NC}\n"; sleep $slTime;
					fi
				done
				echo "-------------------------------------------------------------------------"
				printf "${Purple} Please select Switch By ID (from 1 to $totalService) to update it : ${NC} "
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
		signalingFolder=${services[$switchID-1]};
		
		
		
		if [ $totalService -eq 1 ];then
			printf "\n\n\n${BBlue}Only One Switch \"$signalingFolder\" is Found in \"/usr/local/\" ${NC}"
			writeLog "Only One Switch \"$signalingFolder\" is Found in \"/usr/local/\" "
		else
			printf "\n\n\n${BBlue}You have selectted \"$signalingFolder\" ${NC}"
			writeLog "You have selectted \"$signalingFolder\" "
		fi
		
		
		if [ -d "$signalingFolder" ];then
			errorCounter=0
			writeLog "Signaling Directory is Perfect.."
		else
			errorCounter=10
			printf "\n\${BRed}This Switch Path is not valid. Please check Manually ${NC}"
			writeLog "This Switch Path is not valid. Please check Manually"
			sleep 3;
			unset insCau
			continue
		fi
		
		checkAndGetDBName $signalingFolder
		dbCheckingFlag=$?
		if [ $dbCheckingFlag -gt 0 ]; then
			printf "\n${BRed}Couldn't Update This switch. ${NC}"
			printf "\n${Red}Cause : There is a problem in Dtabase Connection file or Database name ${NC}"
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
		
		getValidBilling $iTelDBName
		validBillingFlag=$?
		
		if [ $validBillingFlag -eq 0 ]; then
			printf "\n${BRed}Couldn't Update This switch.${NC}"
			printf "\n${Red}Cause : No iTeBilling/VSR/COre4 Billing Folder is connected with Same DB of $signalingFolder ${NC}"
			writeLog "Couldn't Update chosen switch.."
			writeLog "No iTeBilling/VSR/COre4 Billing Folder is connected with Same DB"
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
		
	done
	
	
	
	
###============================Printing Listed Services===========================
	
	jarFile="$signalingFolder/iTelSwitchPlusSignaling.jar"
	runFile="$signalingFolder/runiTelSwitchPlusSignaling.sh"
	tempPath=`sed -n 2p $runFile`
	javaPath=${tempPath%-Xmx*}
	#echo $javaPath
	currentSignalingVersion=$($javaPath -jar $jarFile -v  2>&1 | tee -a $sqlErrorLog)
	writeLog "current Signaling Version : $currentSignalingVersion"
	#echo "Signaling Version : $currentSignalingVersion"
	liteJarFile="$signalingFolder/iTelSwitchPlusSignalingLite.jar"
	
	if [ "$currentSignalingVersion" != *"iTelSwitchPlus Version"* ] && [[ "$currentSignalingVersion" =~ "iTelSwitchPlusLite Version" ]]; then
		printf "\n${BRed}This is a Lite Switch. Please don't try to update a Lite Switch using this program ${NC}\n\n\n"
		writeLog "This is a Lite Switch...."
		editCounter=10
		unset insCau
		sleep 5
		continue
	fi
		
	
	currentBillingVersion=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force -D $iTelDBName --skip-column-names -e "SELECT webVersion FROM vbVersionInfo limit 1;")
	writeLog "Current Billing Version : $currentBillingVersion"
	writeLog "Going to show Service list to user ..............."
	
	getMediaLocation $signalingFolder
	totalValidMedia=${#mediaLocationArray[@]}
	iTelAppIsExists
	
	testSleepTime=0.3
	errorCounter=10
	while [ $errorCounter -gt 0 ];
	do
		clear
		if [ $totalService -eq 1 ];then
			echo "############# :: Got Only One Switch in /usr/local/. Detailed Info Given below :: ############"
		else
			echo "############## :: Detailed Informaiton of your Selected Switch is Given below :: #############"
		fi
		
		echo "#  Signaling Name               : $signalingFolder"
		sleep $testSleepTime
		
		mediaString=""
		for (( j=1; j<${totalValidMedia}+1; j++ ));
		do
			tempName=${mediaLocationArray[$j-1]}
			if [ $j -eq 1 ];then
				mediaString="$tempName"
			else
				mediaString="$mediaString , $tempName"
			fi
		done
		
		echo "#  Media Name                   : $mediaString"
		sleep $testSleepTime
		echo "#  iTelAppServer                : $iTelAppServerName"
		sleep $testSleepTime
		echo "#  Jakarta location             : $jak_loc"
		sleep $testSleepTime
		echo "#  DataBase (iTeBilling)        : $iTelDBName"
		sleep $testSleepTime
		echo "#  DataBase (Successful)        : $SuccessDBName"
		sleep $testSleepTime
		echo "#  DataBase (Failed)            : $FailedDBName"
		sleep $testSleepTime
		if [ ${totaliTelBilling} -gt 0 ]; then
			
			billingString=""
			for (( j=1; j<${totaliTelBilling}+1; j++ ));
			do
				tempName=${iTelBillingFolder[$j-1]}
				if [ $j -eq 1 ];then
					billingString="$tempName"
				else
					billingString="$billingString , $tempName"
				fi
			done
			echo "#  Valid iTel Billing Name      : $billingString"
			sleep $testSleepTime
		fi
		
		if [ ${totalVSRBilling} -gt 0 ]; then
			
			vsrString=""
			for (( j=1; j<${totalVSRBilling}+1; j++ ));
			do
				tempName=${vsrBillingFolder[$j-1]}
				if [ $j -eq 1 ];then
					vsrString="$tempName"
				else
					vsrString="$vsrString , $tempName"
				fi
			done
			echo "#  Valid VSR Billing Name       : $vsrString"
			sleep $testSleepTime
		fi
		
		if [ ${totalCore4Billing} -gt 0 ]; then
			
			core4String=""
			for (( j=1; j<${totalCore4Billing}+1; j++ ));
			do
				tempCore4Name=${core4BillingFolder[$j-1]}
				if [ $j -eq 1 ];then
					core4String="$tempCore4Name"
				else
					core4String="$core4String , $tempCore4Name"
				fi
			done
			
			echo "#  Valid Core4 Billing Name     : $core4String"
			sleep $testSleepTime
		fi
		
		echo "#  Current Signaling Version    : $currentSignalingVersion"
		echo "#  Current Billing Version      : $currentBillingVersion"
		
		
		echo "#############################################################################################"
		
		writeLog "Asking for cleint Confirmation as above info is correct"
		printf "\nDo you Think Above Information is correct and want to update this switch ? (y/n) "
		
		allCorrect=""
		read allCorrect
		
		printf "\n\n"
		
		writeLog "Got User Input \"$allCorrect\" "
		
		if [[ "$allCorrect" == "y" ]];then
			editCounter=0
			errorCounter=0
			goForUpdate=200
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
#####==============If All Above are OK then need to update switch and got to update now============>>>>
if [ $goForUpdate -eq 200 ];then
	needToCheckiTelApp=1
	goForNextUpdate=0
	switchUpdateStatus=""
	updateOnlyOH=0
	
	newWebVersion=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force --skip-column-names -e "SELECT webVersion FROM $iTelDBName.vbVersionInfo limit 1;" 2>&1 | tee -a $sqlErrorLog)
	newSignaling=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force --skip-column-names -e "SELECT signalingVersion FROM $iTelDBName.vbVersionInfo limit 1;" 2>&1 | tee -a $sqlErrorLog)
	
	
	if [[ "$currentSignalingVersion" == *"iTelSwitchPlus Version 7.0.5"* ]] && [[ "$currentBillingVersion" == *"7.0.5"* ]];then
		
			
			downloadUpdateResources
			downloadStatus=$?
			printf "\n${BRed}Switch is already updated in 7.0.5 .${NC}\n"
			printf "\n${BRed}Couldn't update further....${NC}\n"
	
	elif [[ "$currentSignalingVersion" == *"iTelSwitchPlus Version 7.0.1.3"* ]] && [[ "$currentBillingVersion" == *"7.2.0"* ]];then
		
		downloadUpdateResources
		downloadStatus=$?
		switchUpdateStatus="\n${BRed}Switch is in 7.2.0 and going for next update${NC}\n"
		goForNextUpdate=1
		updateOnlyOH=1
	elif [[ "$currentSignalingVersion" == *"iTelSwitchPlus Version 7.0.1.2"* ]] && [[ "$currentBillingVersion" == *"7.2.0"* ]];then
		
			downloadUpdateResources
			downloadStatus=$?
			switchUpdateStatus="\n${BRed}Switch is already updated in 720 without OverHead. Going to next Step...${NC}\n"
			goForNextUpdate=1
			updateOnlyOH=1
		
	elif [[ "$currentSignalingVersion" == *"iTelSwitchPlus Version 7.0.1.1"* ]];then
		
		downloadUpdateResources
		downloadStatus=$?
		switchUpdateStatus="\n${BRed}Switch is already updated in 720 without OverHead. Going to next Step...${NC}\n"
		goForNextUpdate=1
		updateOnlyOH=1
	elif [[ "$currentSignalingVersion" == *"iTelSwitchPlus Version 7.0.1  minor 3"* ]] && [[ "$currentBillingVersion" == *"7.1.1"* ]];then
		
		downloadUpdateResources
		downloadStatus=$?
		
		switchUpdateStatus="\n${BRed}Switch is already updated in 7.1.1, Going to next Step ${NC}"
		goForNextUpdate=1
	
	elif [[ "$currentSignalingVersion" == *"iTelSwitchPlus Version 7.0.1  minor 3"* ]] && [[ "$currentBillingVersion" != *"7.1.1"* ]];then
		
		##Trying to download update resources......
		downloadUpdateResources
		downloadStatus=$?
		if [ $downloadStatus -eq 0 ]; then
			printf "\n${BRed}Couldn't Download Update Resource. Please check log ${NC}\n\n"
			exit
		fi
		
		##need to update billing only.......
		mkdir -p $jak_loc/backUpWebApps > /dev/null 2>&1
		
		echo "Going to Update Billing...."
		writeLog "Going to Update Billing...."
		
		stop_tomcat
		for (( j=1; j<${totaliTelBilling}+1; j++ ));
		do
			billingName=${iTelBillingFolder[$j-1]}
			billingLocation="$jak_loc/webapps/$billingName"
			
			writeLog "Now Updating......$billingName"
			
			newBillingLocation="$jak_loc/backUpWebApps/$billingName"_"$now"
			cp -r $billingLocation $newBillingLocation  > /dev/null 2>&1
			writeLog "Backup taken on \"$newBillingLocation\" "
			cd $billingLocation  > /dev/null 2>&1
			rm -rf Update_2.zip  > /dev/null 2>&1
			cp $resourceLocation/710_to_711/Update_2.zip .  > /dev/null 2>&1
			unzip -o Update_2.zip  > /dev/null 2>&1
		done
		
		echo "Billing Update Done...."
		writeLog "Billing Update Done...."
		
		
		oldWebVersion=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force --skip-column-names -e "SELECT webVersion FROM $iTelDBName.vbVersionInfo limit 1")
		updateVersion=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force -e "update $iTelDBName.vbVersionInfo set webVersion='7.1.1'")
		newWebVersion=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force --skip-column-names -e "SELECT webVersion FROM $iTelDBName.vbVersionInfo limit 1")
		
		start_tomcat
		
		switchUpdateStatus="\n${Green}Switch Update Done : ${NC}"
		switchUpdateStatus+="\n${Purple}From Billing version $oldWebVersion to $newWebVersion ${NC}\n\n"
		goForNextUpdate=1
	
	elif [[ "$currentSignalingVersion" != *"iTelSwitchPlus Version 7.0.1  minor 3"* ]] && [[ "$currentSignalingVersion" == *"iTelSwitchPlus Version 7.0.1"* ]] && [[ "$currentBillingVersion" == *"7.1.1"* ]];then
		
		downloadUpdateResources
		downloadStatus=$?
		
		if [ $downloadStatus -eq 0 ]; then
			printf "\n${BRed}Couldn't Download Update Resources. Please check log${NC}\n\n"
			exit
		fi
		
		##need to update Signaling only.......
		echo "Going to Update Signaling...."
		writeLog "Going to Update Signaling...."
		
		
		stop_switch $signalingFolder
		cd $signalingFolder
		rm -f iTelSwitchPlusSignaling.jar_701m3
		mv  iTelSwitchPlusSignaling.jar iTelSwitchPlusSignaling.jar_$now > /dev/null 2>&1
		cp $resourceLocation/iTelSwitchPlusSignaling.jar_701m3 .  > /dev/null 2>&1
		mv iTelSwitchPlusSignaling.jar_701m3 iTelSwitchPlusSignaling.jar > /dev/null 2>&1
		
		echo "Signaling Update Done...."
		writeLog "Signaling Update Done...."
		
		oldSignaling=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force --skip-column-names -e "SELECT signalingVersion FROM $iTelDBName.vbVersionInfo limit 1")
		updateSignaling=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force -e "update $iTelDBName.vbVersionInfo set signalingVersion='7.0.1 min3'")
		newSignaling=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force --skip-column-names -e "SELECT signalingVersion FROM $iTelDBName.vbVersionInfo limit 1")
			
		start_switch $signalingFolder
		
		switchUpdateStatus="\n${Green}Switch Update Done : ${NC}"
		switchUpdateStatus+="\n${Purple}Switch Update Done From Signaling version $currentSignalingVersion to $newSignaling...${NC}\n\n"
		goForNextUpdate=1
		
	elif [[ "$currentSignalingVersion" != *"iTelSwitchPlus Version 7.0.1  minor 3"* ]] && [[ "$currentSignalingVersion" == *"iTelSwitchPlus Version 7.0.1"* ]] && [[ "$currentBillingVersion" == *"7.1.0"* ]];then	
		
		downloadUpdateResources
		downloadStatus=$?
		
		if [ $downloadStatus -eq 0 ]; then
			printf "\n${BRed}Couldn't Download Update Resources. Please update manually${NC}\n\n"
			exit
		fi
		
		echo "Going to Update Billing...."
		writeLog "Going to Update Billing...."
		
		mkdir -p $jak_loc/backUpWebApps   > /dev/null 2>&1
		
		stop_tomcat
		
		for (( j=1; j<${totaliTelBilling}+1; j++ ));
		do
			billingName=${iTelBillingFolder[$j-1]}
			billingLocation="$jak_loc/webapps/$billingName"
			writeLog "Now Updating......$billingName"
			newBillingLocation="$jak_loc/backUpWebApps/$billingName"_"$now"
			cp -r $billingLocation $newBillingLocation  > /dev/null 2>&1
			
			writeLog "Taken Billing BackUp on \"$newBillingLocation\" "
			
			cd $billingLocation  > /dev/null 2>&1
			rm -rf Update_2.zip  > /dev/null 2>&1
			cp $resourceLocation/710_to_711/Update_2.zip .  > /dev/null 2>&1
			unzip -o Update_2.zip  > /dev/null 2>&1
		
		done
		
		echo "Billing Update Done...."
		writeLog "Billing Update Done...."
		
		
		oldWebVersion=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force --skip-column-names -e "SELECT webVersion FROM $iTelDBName.vbVersionInfo limit 1")
		updateVersion=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force -e "update $iTelDBName.vbVersionInfo set webVersion='7.1.1'")
		newWebVersion=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force --skip-column-names -e "SELECT webVersion FROM $iTelDBName.vbVersionInfo limit 1")
		
		
	
		echo "Going to Update Signaling \"$signalingFolder\"........."
		writeLog "Going to Update Signaling \"$signalingFolder\"........."
		
		stop_switch $signalingFolder
		cd $signalingFolder
		rm -f iTelSwitchPlusSignaling.jar_701m3
		mv  iTelSwitchPlusSignaling.jar iTelSwitchPlusSignaling.jar_$now > /dev/null 2>&1
		cp $resourceLocation/iTelSwitchPlusSignaling.jar_701m3 .  > /dev/null 2>&1
		mv iTelSwitchPlusSignaling.jar_701m3 iTelSwitchPlusSignaling.jar > /dev/null 2>&1
		
		echo "Signaling Update Done....."
		writeLog "Signaling Update Done....."
		
		oldSignaling=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force --skip-column-names -e "SELECT signalingVersion FROM $iTelDBName.vbVersionInfo limit 1")
		updateSignaling=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force -e "update $iTelDBName.vbVersionInfo set signalingVersion='7.0.1 min3'")
		newSignaling=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force --skip-column-names -e "SELECT signalingVersion FROM $iTelDBName.vbVersionInfo limit 1")
			
		start_switch $signalingFolder
		
		switchUpdateStatus="\n${Green}Switch Update Done : ${NC}"
		switchUpdateStatus+="\n${Purple}Switch Update Done From billing version $oldWebVersion to $newWebVersion...${NC}\n\n"
		switchUpdateStatus+="\n${Purple}Switch Update Done From Signaling version $currentSignalingVersion to $newSignaling...${NC}\n\n"
		goForNextUpdate=1
		
		start_tomcat
		
	elif [[ "$currentSignalingVersion" == *"iTelSwitchPlus Version 7.0.0"* ]] || [[ "$currentSignalingVersion" == *"iTelSwitchPlus Version 6.0"* ]] || [[ "$currentSignalingVersion" == *"iTelSwitchPlus Version 3.3."* ]] ;then	
		
		downloadUpdateResources
		downloadStatus=$?
		
		if [ $downloadStatus -eq 0 ]; then
			printf "\n${BRed}Couldn't Download Update Resources. Please check log....${NC}\n\n"
			exit
		fi
		
		if [ $updatedTomcat -eq 0 ]; then
			echo "Got Older 5 Version Tomcat. Going to update 7 version"
			writeLog "Got Older 5 Version Tomcat. Going to update 7 version"
			updateTomcat
		fi
			
		echo "Going to Update Billing, switch & DB...."
		
		mkdir -p $jak_loc/backUpWebApps   > /dev/null 2>&1
		
		stop_tomcat
		stop_switch $signalingFolder
		
		echo "Going to update Billing Now....."
		writeLog "Going to update Billing ....."
		
		for (( j=1; j<${totaliTelBilling}+1; j++ ));
		do
			billingName=${iTelBillingFolder[$j-1]}
			billingLocation="$jak_loc/webapps/$billingName"
			
			writeLog "Now Updating......$billingName"
			
			newBillingLocation="$jak_loc/backUpWebApps/$billingName"_"$now"
			cp -r $billingLocation $newBillingLocation  > /dev/null 2>&1
			cd $billingLocation  > /dev/null 2>&1
			
			writeLog "Taken Billing BackUp on \"$newBillingLocation\" "
		
			rm -rf Update.zip
			cp $resourceLocation/5_6_to7/7.0.0/Update.zip .  > /dev/null 2>&1
			unzip -o Update.zip  > /dev/null 2>&1
			rm -rf Update_700m1.zip
			cp $resourceLocation/700min1/Update_700m1.zip .  > /dev/null 2>&1
			unzip -o Update_700m1.zip  > /dev/null 2>&1
			rm -rf WEB-INF/classes/org/  > /dev/null 2>&1
			
			rm -rf Update.zip  > /dev/null 2>&1
			cp $resourceLocation/710/Update.zip .  > /dev/null 2>&1
			unzip -o Update.zip  > /dev/null 2>&1
			rm -rf Update_2.zip  > /dev/null 2>&1
			cp $resourceLocation/710_to_711/Update_2.zip .  > /dev/null 2>&1
			unzip -o Update_2.zip  > /dev/null 2>&1
		
		done
		
		echo "Billing Update Done....."
		writeLog "Billing Update Done....."
		
		echo "Going to update Switch Signaling"
		writeLog "Going to update Switch Signaling"
		
		cd $signalingFolder
		rm -f iTelSwitchPlusSignaling.jar_701m3
		mv  iTelSwitchPlusSignaling.jar iTelSwitchPlusSignaling.jar_$now > /dev/null 2>&1
		cp $resourceLocation/iTelSwitchPlusSignaling.jar_701m3 .  > /dev/null 2>&1
		mv iTelSwitchPlusSignaling.jar_701m3 iTelSwitchPlusSignaling.jar > /dev/null 2>&1
		
		echo "Signaling Update Done....."
		writeLog "Signaling Update Done....."
		
		
		echo "Going to update \"$iTelDBName\" Database ........"
		writeLog "Going to update \"$iTelDBName\" Database ........"
		writeLog "Going to take a backup of \"$iTelDBName\" Database "
		
		cd $dataDir  > /dev/null 2>&1
		cp -r $iTelDBName $iTelDBName\_$now  > /dev/null 2>&1
		
		if [ -d $iTelDBName\_$now ];then
			writeLog "Backup taken Successfully for \"$iTelDBName\" "
			writeLog "Backup location \"$dataDir/$iTelDBName\_$now\" "
		else
			writeLog "Couldn't Take backUp of \"$iTelDBName\" Database "
		fi
		
		alterVersionTable=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force -D $iTelDBName  -e "alter table vbVersionInfo modify column signalingVersion varchar(30);" 2>&1 | tee -a $sqlErrorLog)
		
		oldWebVersion=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force --skip-column-names -e "SELECT webVersion FROM $iTelDBName.vbVersionInfo limit 1" 2>&1 | tee -a $sqlErrorLog)
		oldSignaling=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force --skip-column-names -e "SELECT signalingVersion FROM $iTelDBName.vbVersionInfo limit 1" 2>&1 | tee -a $sqlErrorLog)
			
		
		iTelDBUpdate1=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force $iTelDBName < $resourceLocation/5_6_to7/7.0.0/SQL/changeLog.SQL  2>&1 | tee -a $sqlErrorLog)
		iTelDBUpdate1=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force $iTelDBName < $resourceLocation/5_6_to7/7.0.0/SQL/Country.SQL  2>&1 | tee -a $sqlErrorLog)
		iTelDBUpdate1=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force $iTelDBName < $resourceLocation/5_6_to7/7.0.0/SQL/GroupChat.SQL  2>&1 | tee -a $sqlErrorLog)
		iTelDBUpdate1=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force $iTelDBName < $resourceLocation/5_6_to7/7.0.0/SQL/IMBroadCast.SQL  2>&1 | tee -a $sqlErrorLog)
		iTelDBUpdate1=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force $iTelDBName < $resourceLocation/5_6_to7/7.0.0/SQL/Package.SQL  2>&1 | tee -a $sqlErrorLog)
		iTelDBUpdate1=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force $iTelDBName < $resourceLocation/5_6_to7/7.0.0/SQL/Portability.SQL  2>&1 | tee -a $sqlErrorLog)
		iTelDBUpdate1=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force $iTelDBName < $resourceLocation/5_6_to7/7.0.0/SQL/Extra.SQL  2>&1 | tee -a $sqlErrorLog)
		iTelDBUpdate1=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force $iTelDBName < $resourceLocation/700min1/changeLog.SQL  2>&1 | tee -a $sqlErrorLog)
		iTelDBUpdate1=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force $iTelDBName < $resourceLocation/700min1/Country.SQL  2>&1 | tee -a $sqlErrorLog)
		
		iTelDBUpdate2=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force -D $iTelDBName  -e "create table vbPushNotificationLog(pnID int not null primary key,pnFromUser varchar(30),pnToUser varchar(30),pnURL varchar(400),pnMessage varchar(500),pnType tinyint,pnTerCallID varchar(100),pnStatus tinyint default 0,pnExpirationTime int unsigned);"  2>&1 | tee -a $sqlErrorLog)
		iTelDBUpdate3=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force -D $iTelDBName  -e "insert into vbSequencer values('vbPushNotificationLog',1,0);create index pnExpirationTime_index on vbPushNotificationLog(pnExpirationTime);"    2>&1 | tee -a $sqlErrorLog)
		iTelDBUpdate4=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force -D $iTelDBName  -e "create index pnStatus_index on vbPushNotificationLog(pnStatus);alter table vbPendingSubscriberList drop index slPinNO_index;"    2>&1 | tee -a $sqlErrorLog)
		iTelDBUpdate5=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force -D $iTelDBName  -e "create index slSubscriberID_index on vbPendingSubscriberList(slSubscriberID);"   2>&1 | tee -a $sqlErrorLog)
		
		iTelDBUpdate6=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force $iTelDBName < $resourceLocation/710/Update.SQL  2>&1 | tee -a $sqlErrorLog)
		iTelDBUpdate6=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force $iTelDBName < $resourceLocation/710/MoneyTransfer.SQL  2>&1 | tee -a $sqlErrorLog)
		
		
		updateVersion=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force -e "update $iTelDBName.vbVersionInfo set webVersion='7.1.1';"  2>&1 | tee -a $sqlErrorLog)
		newWebVersion=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force --skip-column-names -e "SELECT webVersion FROM $iTelDBName.vbVersionInfo limit 1;" 2>&1 | tee -a $sqlErrorLog)
		
		updateSignaling=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force -e "update $iTelDBName.vbVersionInfo set signalingVersion='7.0.1 min3';" 2>&1 | tee -a $sqlErrorLog)
		newSignaling=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force --skip-column-names -e "SELECT signalingVersion FROM $iTelDBName.vbVersionInfo limit 1;" 2>&1 | tee -a $sqlErrorLog)
		
		
		echo "iTelBilling DB Update Done....."
		writeLog "iTelBilling DB Update Done....."
		
		##########If switch version is 5 then Execute below condition============================
		if [[ "$currentSignalingVersion" == *"iTelSwitchPlus Version 3.3."* ]]; then
			
			writeLog "it's a 5 version switch"
			writeLog "Going to check NAS Port"
			
			orgBindPort=`grep -m 1  '^orgBindPort' $signalingFolder/config/server.cfg`
			orgBindPort=${orgBindPort##*orgBindPort=}
			if $(is_int "${orgBindPort}");then
				nasPort=${orgBindPort}
			else
				nasPort=5060
			fi
			
			writeLog "Got NAS Port \"$nasPort\" "
			
			writeLog "Going to check Media Location "		
			
			getMediaLocation $signalingFolder
			totalValidMedia=${#mediaLocationArray[@]}
			
			writeLog "Got Total \"$totalValidMedia Media\" "
			
			for (( j=1; j<${totalValidMedia}+1; j++ )); do
			mediaLocation=${mediaLocationArray[$j-1]}
			
				if [ -d "$mediaLocation" ];then
					cd $mediaLocation
					writeLog "Stopping switch Media to update IVR Files.."
					sh shutdowniTelSwitchPlusMediaProxy.sh >> $logFilePath
					sh shutdowniTelSwitchPlusMediaProxy.sh >> $logFilePath
					mv iTelSwitchPlusMediaProxy.log iTelSwitchPlusMediaProxy.log_$now > /dev/null 2>&1
					mv IVR IVR_$now > /dev/null 2>&1
					cp $resourceLocation/IVR_new.zip . > /dev/null 2>&1
					unzip -o IVR_new.zip > /dev/null 2>&1
					rm -f IVR_new.zip
					writeLog "Starting switch Media after updating IVR Files.."
					sh runiTelSwitchPlusMediaProxy.sh >> $logFilePath
					
				else
					writeLog "Couldn't update IVR Due to invalid Media Location."
				fi
			done
			writeLog "Updating IVR Files Location and NAS Port in Database.."
			updateNAPPort=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force -D $iTelDBName  -e "update vbSharedSecret set nasPort=$nasPort;" 2>&1 | tee -a $sqlErrorLog)
			updateIVRLoca=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force -D $iTelDBName  -e "update vbRadiusConfiguration set configurationValue='$IVR_Path' where configurationID=43;" 2>&1 | tee -a $sqlErrorLog)
	
		fi
		
		##########If switch version is 5 then Execute above condition============================
		
		echo "Going to update \"$FailedDBName\" Database ........"
		writeLog "Going to update \"$FailedDBName\" Database ........"
		
		FailedDBUpdate1=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName < $resourceLocation/5_6_to7/7.0.0/SQL/SummaryTable_Failed.SQL 2>&1 | tee -a $sqlErrorLog)
		FailedDBUpdate2=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName < $resourceLocation/710/FailedUpdate.sql 2>&1 | tee -a $sqlErrorLog)
	    
		echo "Failed DB Update Done....."
		writeLog "Failed DB Update Done....."
		
		echo "Going to update \"$SuccessDBName\" Database ........"
		writeLog "Going to update \"$SuccessDBName\" Database ........"
		
		SuccessDBUpdate1=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName < $resourceLocation/5_6_to7/7.0.0/SQL/SummaryTable_Success.SQL  2>&1 | tee -a $sqlErrorLog)
		SuccessDBUpdate2=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName < $resourceLocation/710/SuccessUpdate.sql  2>&1 | tee -a $sqlErrorLog)
		
		echo "Successful DB Update Done....."
		writeLog "Successful DB Update Done....."
		
		start_switch $signalingFolder
		
		switchUpdateStatus="\n${Green}Switch Update Done : ${NC}"
		switchUpdateStatus+="\n${Purple}From Billing version $oldWebVersion to $newWebVersion${NC}"
		switchUpdateStatus+="\n${Purple}From Signaling version $currentSignalingVersion to $newSignaling${NC}"
		goForNextUpdate=1
		start_tomcat
	else
		switchUpdateStatus="\n\n${BRed} Older/Unknown Signaling ${NC}"
		switchUpdateStatus+="\n${BRed} Signaling Version : $currentSignalingVersion ${NC}"
		switchUpdateStatus+="\n${BRed} Plase Update Manually...... ${NC}\n\n"
		
		writeLog "Older/Unknown Signaling"
		writeLog "Signaling Version : $currentSignalingVersion"
		writeLog "Plase Update Manually......"
		
		switchVersion=0
		goForNextUpdate=0
		needToCheckiTelApp=0
	fi
	
	clear
	if [ $needToCheckiTelApp -eq 1 ];then
		
		echo "Going to check iTelApp..."
		writeLog "Going to check iTelApp..."
	
		iTelAppIsExists
		iTelAppFlag=$?
		if [ $iTelAppFlag -eq 0 ];then
			installiTelApp
		elif [ $iTelAppFlag -eq 1 ];then
			checkJarAndLastSummaryFile
		fi
		
		echo "iTelAll Checking Done"
		writeLog "iTelAll Checking Done"
	
	fi
	
	
	
	clear
	
	if [ $goForNextUpdate -eq 0 ];then
		printf "\n\n${switchUpdateStatus}\n\n"
		writeStatus=`printf "${switchUpdateStatus}"`
		writeLog "${writeStatus}"
	elif [ $goForNextUpdate -eq 1 ];then
		
		while [ -z $newInput ]; do
			now="$(date +'%d_%m_%Y_%H_%M_%S')"
			clear
			printf "\n${switchUpdateStatus}\n"
			printf "${Black} ${spaceVal}-------------------------------------------------------------------------\n"
			printf "${Black} ${spaceVal} Action ID | Action Name\n"
			printf "${Black} ${spaceVal}-------------------------------------------------------------------------\n"
			printf "${Black} ${spaceVal} 1 | Update to 720 without OverHead\n"
			printf "${Black} ${spaceVal} 2 | Update to 720 with OverHead\n"
			printf "${Black} ${spaceVal} 3 | Update to 7.0.5\n"
			printf "${Black} ${spaceVal} e | Exit\n"
			
			echo "${spaceVal} -------------------------------------------------------------------------"
			printf "${Purple} Please Select Action by ID  : ${NC} "
			read newInput;
			
			if [ -z $newInput ];then
				printf "${Red} Null Input ${NC}\n";sleep 1;errorCounter=10;
			elif [ "$newInput" == "e" ] || [ "$newInput" == "E" ];then
				echo -ne "Got E/e"
				errorCounter=10
			elif [[ $newInput -eq 1 ]];then
				echo "Got 1"
			elif [[ $newInput -eq 2 ]];then
				echo "Got 2"
			elif [[ $newInput -eq 3 ]];then
				echo "Got 3"
			else
				unset newInput
				errorCounter=0
			fi
		
		done
		clear
		
		search_jdk;
		
		if [[ $newInput -eq 1 ]];then
			
			echo "Going to Update Billing, switch & DB...."
			
			writeStatus=`printf "${switchUpdateStatus}"`
			
			download720nOHResources "only720"
			downloadStatus=$?
			
			if [ $downloadStatus -eq 0 ]; then
				printf "\n${BRed}Couldn't Download 720 Update Resource. Please check log ${NC}\n\n"
				exit
			fi
			
			
			echo "Going to Update Billing...."
			writeLog "Going to Update Billing...."
			
			mkdir -p $jak_loc/backUpWebApps   > /dev/null 2>&1
			
			stop_tomcat
			stop_switch $signalingFolder
			
			for (( j=1; j<${totaliTelBilling}+1; j++ ));
			do
				billingName=${iTelBillingFolder[$j-1]}
				billingLocation="$jak_loc/webapps/$billingName"
				writeLog "Now Updating......$billingName"
				newBillingLocation="$jak_loc/backUpWebApps/$billingName"_"$now"
				cp -r $billingLocation $newBillingLocation  > /dev/null 2>&1
				
				writeLog "Taken Billing BackUp on \"$newBillingLocation\" "
				
				cd $billingLocation  > /dev/null 2>&1
				rm -rf Update.zip  > /dev/null 2>&1
				cp $newRourceLocation/Update.zip .  > /dev/null 2>&1
				unzip -o Update.zip  > /dev/null 2>&1
			
			done
			
			echo "Billing Update Done...."
			writeLog "Billing Update Done...."
			
			echo "Going to update Switch Signaling"
			writeLog "Going to update Switch Signaling"
			
			cd $signalingFolder
			mv  iTelSwitchPlusSignaling.jar iTelSwitchPlusSignaling.jar_$now > /dev/null 2>&1
			cp $newRourceLocation/iTelSwitchPlusSignaling.jar .  > /dev/null 2>&1
			
			sed -i "s/jdk1.6.0_25/jdk1.8.0_111/g" runiTelSwitchPlusSignaling.sh
			sed -i "s/jdk1.6.0_25/jdk1.8.0_111/g" shutdowniTelSwitchPlusSignaling.sh
			
			#mv iTelSwitchPlusSignaling.jar_701m3 iTelSwitchPlusSignaling.jar > /dev/null 2>&1
			
			echo "Signaling Update Done....."
			writeLog "Signaling Update Done....."
			
			echo "Going to update \"$iTelDBName\" Database ........"
			writeLog "Going to update \"$iTelDBName\" Database ........"
			writeLog "Going to take a backup of \"$iTelDBName\" Database "
			
			cd $dataDir  > /dev/null 2>&1
			cp -r $iTelDBName $iTelDBName\_$now  > /dev/null 2>&1
			
			if [ -d $iTelDBName\_$now ];then
				writeLog "Backup taken Successfully for \"$iTelDBName\" "
				writeLog "Backup location \"$dataDir/$iTelDBName\_$now\" "
			else
				writeLog "Couldn't Take backUp of \"$iTelDBName\" Database "
			fi
			
			iTelDBUpdate1=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force $iTelDBName < $newRourceLocation/Update720.SQL  2>&1 | tee -a $sqlErrorLog)
			
			echo "iTelBilling DB Update Done....."
			writeLog "iTelBilling DB Update Done....."
		
			start_switch $signalingFolder
			start_tomcat
			
			
			switchUpdateStatus="\n ${Green}Switch Update Done. ${NC}"
			switchUpdateStatus+="\n ${Purple}From Billing version 711 to 720 without OverHead ${NC}"
			
			
		elif [[ $newInput -eq 2 ]];then
		
			echo "Going to Update Billing, switch & DB...."
		
			writeStatus=`printf "${switchUpdateStatus}"`
			
			download720nOHResources "720WithOH"
			downloadStatus=$?
			
			if [ $downloadStatus -eq 0 ]; then
				printf "\n${BRed}Couldn't Download OverHead Update Resource. Please check log ${NC}\n\n"
				exit
			fi
			
			
			echo "Going to Update Billing...."
			writeLog "Going to Update Billing...."
			
			mkdir -p $jak_loc/backUpWebApps   > /dev/null 2>&1
			
			stop_tomcat
			stop_switch $signalingFolder
			
			for (( j=1; j<${totaliTelBilling}+1; j++ ));
			do
				billingName=${iTelBillingFolder[$j-1]}
				billingLocation="$jak_loc/webapps/$billingName"
				writeLog "Now Updating......$billingName"
				newBillingLocation="$jak_loc/backUpWebApps/$billingName"_"$now"
				cp -r $billingLocation $newBillingLocation  > /dev/null 2>&1
				
				writeLog "Taken Billing BackUp on \"$newBillingLocation\" "
				
				cd $billingLocation  > /dev/null 2>&1
				rm -rf Update.zip OverheadUpdate.zip  > /dev/null 2>&1
				cp $newRourceLocation/Update.zip .  > /dev/null 2>&1
				cp $newRourceLocation/OverheadUpdate.zip .  > /dev/null 2>&1
				unzip -o Update.zip  > /dev/null 2>&1
				unzip -o OverheadUpdate.zip  > /dev/null 2>&1
			
			done
			
			echo "Billing Update Done...."
			writeLog "Billing Update Done...."
			
			echo "Going to update Switch Signaling"
			writeLog "Going to update Switch Signaling"
			
			cd $signalingFolder
			mv  iTelSwitchPlusSignaling.jar iTelSwitchPlusSignaling.jar_$now > /dev/null 2>&1
			cp $newRourceLocation/iTelSwitchPlusSignaling_overhead.jar iTelSwitchPlusSignaling.jar  > /dev/null 2>&1
			
			sed -i "s/jdk1.6.0_25/jdk1.8.0_111/g" runiTelSwitchPlusSignaling.sh
			sed -i "s/jdk1.6.0_25/jdk1.8.0_111/g" shutdowniTelSwitchPlusSignaling.sh
			
			echo "Signaling Update Done....."
			writeLog "Signaling Update Done....."
			
			
			echo "Going to update \"$iTelDBName\" Database ........"
			writeLog "Going to update \"$iTelDBName\" Database ........"
			writeLog "Going to take a backup of \"$iTelDBName\" Database "
			
			cd $dataDir  > /dev/null 2>&1
			cp -r $iTelDBName $iTelDBName\_$now  > /dev/null 2>&1
			
			if [ -d $iTelDBName\_$now ];then
				writeLog "Backup taken Successfully for \"$iTelDBName\" "
				writeLog "Backup location \"$dataDir/$iTelDBName\_$now\" "
			else
				writeLog "Couldn't Take backUp of \"$iTelDBName\" Database "
			fi
			
			iTelDBUpdate1=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force $iTelDBName < $newRourceLocation/Update720.SQL  2>&1 | tee -a $sqlErrorLog)
			iTelDBUpdate2=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force $iTelDBName < $newRourceLocation/overhead.sql  2>&1 | tee -a $sqlErrorLog)
			
					
			echo "iTelBilling DB Update Done....."
			writeLog "iTelBilling DB Update Done....."
			
			
			echo "Going to update \"$SuccessDBName\" Database ........"
			writeLog "Going to update \"$SuccessDBName\" Database ........"
			
			unset currentEXT;
			currentEXT=`getLatestTableExt $SuccessDBName $SuccessDBHost $iSuccessDBPort  $SuccessDBUser $SuccessDBPass`
			
			writeLog "Got Current ETX..... $currentEXT"
			
			SuccessDBDefault=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR add column callType tinyint default 0;alter table vbSuccessfulCDR add column originalSrcIP decimal(18,0);alter table vbSuccessfulCDR add column originalSrcPort int;alter table vbSuccessfulCDR add column overheadBillDuration int;alter table vbSuccessfulCDR add column overheadBillAmount double;alter table vbSuccessfulCDR add column overheadChargeDetails   varchar(200);alter table vbResellerCDR add column overheadBillDuration int;alter table vbResellerCDR add column overheadBillAmount double;alter table vbResellerCDR add column overheadChargeDetails   varchar(200);alter table vbSuccessfulCDR change overheadBillDuration overheadBillDuration int after callType;alter table vbSuccessfulCDR change overheadBillAmount overheadBillAmount double after overheadBillDuration;alter table vbSuccessfulCDR change overheadChargeDetails overheadChargeDetails varchar(200) after overheadBillAmount;alter table vbSuccessfulCDR change originalSrcIP  originalSrcIP decimal(18,0) after overheadChargeDetails;alter table vbSuccessfulCDR change originalSrcPort  originalSrcPort int after originalSrcIP;" 2>&1 | tee -a $sqlErrorLog)
			
			if [ -z "$currentEXT" ];then
				echo "Didint get Current Sucessful CDR Table"
			else
				SuccessDBCurrent=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$currentEXT add column callType tinyint default 0;alter table vbSuccessfulCDR_$currentEXT add column originalSrcIP decimal(18,0);alter table vbSuccessfulCDR_$currentEXT add column originalSrcPort int;alter table vbSuccessfulCDR_$currentEXT add column overheadBillDuration int;alter table vbSuccessfulCDR_$currentEXT add column overheadBillAmount double;alter table vbSuccessfulCDR_$currentEXT add column overheadChargeDetails   varchar(200);alter table vbResellerCDR_$currentEXT add column overheadBillDuration int;alter table vbResellerCDR_$currentEXT add column overheadBillAmount double;alter table vbResellerCDR_$currentEXT add column overheadChargeDetails   varchar(200);alter table vbSuccessfulCDR_$currentEXT change overheadBillDuration overheadBillDuration int after callType; alter table vbSuccessfulCDR_$currentEXT change overheadBillAmount overheadBillAmount double after overheadBillDuration;alter table vbSuccessfulCDR_$currentEXT change overheadChargeDetails overheadChargeDetails varchar(200) after overheadBillAmount;alter table vbSuccessfulCDR_$currentEXT change originalSrcIP  originalSrcIP decimal(18,0) after overheadChargeDetails;alter table vbSuccessfulCDR_$currentEXT change originalSrcPort  originalSrcPort int after originalSrcIP;" 2>&1 | tee -a $sqlErrorLog)
			fi
			
			echo "Successful DB Update Done..... "
			writeLog "Successful DB Update Done..... "
		
			echo "Going to update \"$FailedDBName\" Database ........"
			writeLog "Going to update \"$FailedDBName\" Database ........"
			
			FailedDBDefault=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName -e "alter table vbFailedCDR add column callType tinyint default 0;alter table vbFailedCDR add column originalSrcIP decimal(18,0);alter table vbFailedCDR add column originalSrcPort int;" 2>&1 | tee -a $sqlErrorLog)
			if [ -z "$currentEXT" ];then
				echo "Didint get Current Failed CDR Table"
			else
				FailedDBCurrent=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName -e "alter table vbFailedCDR_$currentEXT add column callType tinyint default 0;alter table vbFailedCDR_$currentEXT add column originalSrcIP decimal(18,0);alter table vbFailedCDR_$currentEXT add column originalSrcPort int;" 2>&1 | tee -a $sqlErrorLog)
			fi
			
			
			echo "Failed DB Update Done....."
			writeLog "Failed DB Update Done....."
			
			
			start_switch $signalingFolder
			start_tomcat
			
			echo "Switch and Tomcat Started"
			writeLog "Switch and Tomcat Started "
			
			if [ -z "$currentEXT" ];then
				echo "No Old CDR Table to update"
			else
				echo "Going To Update old CDR tables..."
				writeLog "Going To Update old CDR tables....."
				
				olderExts=$((currentEXT -1))
				failedCounter=0
				
				for (( c=${olderExts}; c > ${olderExts}-10; c-- ))
				do  
					SuccessDBOld=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$c add column callType tinyint default 0;alter table vbSuccessfulCDR_$c add column originalSrcIP decimal(18,0);alter table vbSuccessfulCDR_$c add column originalSrcPort int;alter table vbSuccessfulCDR_$c add column overheadBillDuration int;alter table vbSuccessfulCDR_$c add column overheadBillAmount double;alter table vbSuccessfulCDR_$c add column overheadChargeDetails   varchar(200);alter table vbResellerCDR_$c add column overheadBillDuration int;alter table vbResellerCDR_$c add column overheadBillAmount double;alter table vbResellerCDR_$c add column overheadChargeDetails   varchar(200);" 2>&1 | tee -a $sqlErrorLog)
					if [ ${failedCounter} -lt 3  ];then
						FailedDBOld=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName -e "alter table vbFailedCDR_$c add column callType tinyint default 0;alter table vbFailedCDR_$c add column originalSrcIP decimal(18,0);alter table vbFailedCDR_$c add column originalSrcPort int;" 2>&1 | tee -a $sqlErrorLog)
					fi
				failedCounter=$((failedCounter + 1))
				
				done
				
				echo "Old CDR tables update Done..."
				writeLog "Old CDR tables update Done..."
				
				switchUpdateStatus="\n ${Green}Switch Update Done. ${NC}"
				switchUpdateStatus+="\n ${Purple}From Billing version 711 to 720 with OverHead ${NC}"
			
			fi
			
######################new update start here################			
			
			elif [[ $newInput -eq 3 ]];then
			
			echo "Going to Update Billing, switch & DB...."
		
			writeStatus=`printf "${switchUpdateStatus}"`
	
			
			
			download705Resources
			downloadStatus=$?
			
			if [ $downloadStatus -eq 0 ]; then
				printf "\n${BRed}Couldn't Download OverHead Update Resource. Please check log ${NC}\n\n"
				exit
			fi
			
			
			echo "Going to Update Billing...."
			writeLog "Going to Update Billing...."
			
			mkdir -p $jak_loc/backUpWebApps   > /dev/null 2>&1
			
			stop_tomcat
			stop_switch $signalingFolder
			
			for (( j=1; j<${totaliTelBilling}+1; j++ ));
			do
				billingName=${iTelBillingFolder[$j-1]}
				billingLocation="$jak_loc/webapps/$billingName"
				writeLog "Now Updating......$billingName"
				newBillingLocation="$jak_loc/backUpWebApps/$billingName"_"$now"
				cp -r $billingLocation $newBillingLocation  > /dev/null 2>&1
				
				writeLog "Taken Billing BackUp on \"$newBillingLocation\" "
				
				cd $billingLocation  > /dev/null 2>&1
				
				cp $newRourceLocation/Update.zip .  > /dev/null 2>&1
				
				unzip -o Update.zip  > /dev/null 2>&1
				
			
			done
			
			echo "Updating web.xml...."
			writeLog "Updating web.xml...."
			cd /usr/local/jakarta-tomcat-7.0.61/conf
			mv web.xml web.xml_$now
			wget http://149.20.186.19/resource/Switch_Resource/705/web.xml
			
			
			
			echo "Billing Update Done...."
			writeLog "Billing Update Done...."
			
			echo "Going to update Switch Signaling"
			writeLog "Going to update Switch Signaling"
			
			cd $signalingFolder
			mv  iTelSwitchPlusSignaling.jar iTelSwitchPlusSignaling.jar_$now > /dev/null 2>&1
			cp $newRourceLocation/iTelSwitchPlusSignaling.jar iTelSwitchPlusSignaling.jar  > /dev/null 2>&1
			
			sed -i "s/jdk1.6.0_25/jdk1.8.0_111/g" runiTelSwitchPlusSignaling.sh
			sed -i "s/jdk1.6.0_25/jdk1.8.0_111/g" shutdowniTelSwitchPlusSignaling.sh
			
			##Start Finding port
			
			
			echo "Finding free port...."
			port=1230
			maxPort=20000
			
			
			while [ $port -lt $maxPort ]
				do
					var=$(lsof -i :$port)
					if [ -z "${var}" ]
					then
						break;
					else
						port=$((port + 2));
					fi
				done
			
			echo "localConfigListeningPort=$port" >> config/server.cfg
			
		
			echo "Signaling Update Done....."
			writeLog "Signaling Update Done....."
			
			
			echo "Going to update \"$iTelDBName\" Database ........"
			writeLog "Going to update \"$iTelDBName\" Database ........"
			writeLog "Going to take a backup of \"$iTelDBName\" Database "
			
			cd $dataDir  > /dev/null 2>&1
			cp -r $iTelDBName $iTelDBName\_$now  > /dev/null 2>&1
			
			if [ -d $iTelDBName\_$now ];then
				writeLog "Backup taken Successfully for \"$iTelDBName\" "
				writeLog "Backup location \"$dataDir/$iTelDBName\_$now\" "
			else
				writeLog "Couldn't Take backUp of \"$iTelDBName\" Database "
			fi
			
			iTelDBUpdate1=$(mysql -h $iTelDBHost -P $iTelDBPort -u$iTelDBUser $iTelDBPass --force $iTelDBName < $newRourceLocation/changeLog_711_to_705.SQL  2>&1 | tee -a $sqlErrorLog)
			
			
					
			echo "iTelBilling DB Update Done....."
			writeLog "iTelBilling DB Update Done....."
			
			
			echo "Going to update \"$SuccessDBName\" Database ........"
			writeLog "Going to update \"$SuccessDBName\" Database ........"
			
			unset currentEXT;
			currentEXT=`getLatestTableExt $SuccessDBName $SuccessDBHost $iSuccessDBPort  $SuccessDBUser $SuccessDBPass`
			
			writeLog "Got Current ETX..... $currentEXT"
			
			SuccessDBDefault1=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR add column callType tinyint default 0;" 2>&1 | tee -a $sqlErrorLog)
			
			SuccessDBDefault2=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR add column overheadBillDuration int;" 2>&1 | tee -a $sqlErrorLog)
			
			SuccessDBDefault3=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR add column overheadBillAmount double;" 2>&1 | tee -a $sqlErrorLog)
			
			SuccessDBDefault4=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR add column overheadChargeDetails  varchar(200);" 2>&1 | tee -a $sqlErrorLog)
			
			SuccessDBDefault5=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR add column originalSrcIP decimal(18,0);" 2>&1 | tee -a $sqlErrorLog)
			
			SuccessDBDefault6=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR add column originalSrcPort int;" 2>&1 | tee -a $sqlErrorLog)
			
			SuccessDBDefault7=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR change orgPort orgPort  smallint(6) unsigned default 0  after acctSessionID;" 2>&1 | tee -a $sqlErrorLog)
			
			SuccessDBDefault8=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR change terPort terPort  smallint(6) unsigned default 0  after orgPort;" 2>&1 | tee -a $sqlErrorLog)
			
			SuccessDBDefault9=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR change packageID packageID int default -1 after terPort;" 2>&1 | tee -a $sqlErrorLog)
			
			SuccessDBDefault10=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR change callType callType tinyint default 0  after packageID;" 2>&1 | tee -a $sqlErrorLog)
			
			SuccessDBDefault11=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR change overheadBillDuration overheadBillDuration int after callType;" 2>&1 | tee -a $sqlErrorLog)
			
			SuccessDBDefault12=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR change overheadBillAmount overheadBillAmount double after overheadBillDuration;" 2>&1 | tee -a $sqlErrorLog)
			
			SuccessDBDefault13=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR change overheadChargeDetails overheadChargeDetails varchar(200) after overheadBillAmount;" 2>&1 | tee -a $sqlErrorLog)
			
			SuccessDBDefault14=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR change originalSrcIP  originalSrcIP decimal(18,0) after overheadChargeDetails;" 2>&1 | tee -a $sqlErrorLog)
			
			SuccessDBDefault15=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR change originalSrcPort  originalSrcPort int after originalSrcIP;" 2>&1 | tee -a $sqlErrorLog)
			
			SuccessDBDefault16=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR add column  orgMediaIP decimal(18,0) after originalSrcPort;" 2>&1 | tee -a $sqlErrorLog)
			
			SuccessDBDefault17=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR add column  terMediaIP decimal(18,0) after orgMediaIP;" 2>&1 | tee -a $sqlErrorLog)
			
			SuccessDBDefault18=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR add column  isProxyCall tinyint default 1 after terMediaIP;" 2>&1 | tee -a $sqlErrorLog)
			
			
			SuccessDBDefault19=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbResellerCDR add column overheadBillDuration int;" 2>&1 | tee -a $sqlErrorLog)
			
			SuccessDBDefault20=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbResellerCDR add column overheadBillAmount double;" 2>&1 | tee -a $sqlErrorLog)
			
			SuccessDBDefault21=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbResellerCDR add column overheadChargeDetails   varchar(200);" 2>&1 | tee -a $sqlErrorLog)
			
			SuccessDBDefault22=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table  vbSuccessfulSummaryCDR add column terPort int default 0;" 2>&1 | tee -a $sqlErrorLog)
			SuccessDBDefault23=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table  vbSuccessfulSummaryCDR add column orgPort int default 0;" 2>&1 | tee -a $sqlErrorLog)
			
			
			if [ -z "$currentEXT" ];then
				echo "Didint get Current Sucessful CDR Table"
			else
				SuccessDBCurrent1=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$currentEXT add column callType tinyint default 0;" 2>&1 | tee -a $sqlErrorLog)
				
				SuccessDBCurrent2=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$currentEXT add column overheadBillDuration int;" 2>&1 | tee -a $sqlErrorLog)
				
				SuccessDBCurrent3=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$currentEXT add column overheadBillAmount double;" 2>&1 | tee -a $sqlErrorLog)
				
				SuccessDBCurrent4=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$currentEXT add column overheadChargeDetails  varchar(200);" 2>&1 | tee -a $sqlErrorLog)
				
				SuccessDBCurrent5=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$currentEXT add column originalSrcIP decimal(18,0);" 2>&1 | tee -a $sqlErrorLog)
				
				SuccessDBCurrent6=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$currentEXT add column originalSrcPort int;" 2>&1 | tee -a $sqlErrorLog)
				
				SuccessDBCurrent7=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$currentEXT change orgPort orgPort  smallint(6) unsigned default 0  after acctSessionID;" 2>&1 | tee -a $sqlErrorLog)
				
				SuccessDBCurrent8=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$currentEXT change terPort terPort  smallint(6) unsigned default 0  after orgPort;" 2>&1 | tee -a $sqlErrorLog)
				
				SuccessDBCurrent9=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$currentEXT change packageID packageID int default -1 after terPort;" 2>&1 | tee -a $sqlErrorLog)
				
				SuccessDBCurrent10=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$currentEXT change callType callType tinyint default 0  after packageID;" 2>&1 | tee -a $sqlErrorLog)
				
				SuccessDBCurrent11=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$currentEXT change overheadBillDuration overheadBillDuration int after callType;" 2>&1 | tee -a $sqlErrorLog)
				
				SuccessDBCurrent12=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$currentEXT change overheadBillAmount overheadBillAmount double after overheadBillDuration;" 2>&1 | tee -a $sqlErrorLog)
				
				SuccessDBCurrent13=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$currentEXT change overheadChargeDetails overheadChargeDetails varchar(200) after overheadBillAmount;" 2>&1 | tee -a $sqlErrorLog)
				
				SuccessDBCurrent14=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$currentEXT change originalSrcIP  originalSrcIP decimal(18,0) after overheadChargeDetails;" 2>&1 | tee -a $sqlErrorLog)
				
				SuccessDBCurrent15=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$currentEXT change originalSrcPort  originalSrcPort int after originalSrcIP;" 2>&1 | tee -a $sqlErrorLog)
				
				SuccessDBCurrent16=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$currentEXT add column  orgMediaIP decimal(18,0) after originalSrcPort;" 2>&1 | tee -a $sqlErrorLog)
				
				SuccessDBCurrent17=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$currentEXT add column  terMediaIP decimal(18,0) after orgMediaIP;" 2>&1 | tee -a $sqlErrorLog)
				
				SuccessDBCurrent18=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$currentEXT add column  isProxyCall tinyint default 1 after terMediaIP;" 2>&1 | tee -a $sqlErrorLog)
				
				
				SuccessDBCurrent19=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbResellerCDR_$currentEXT add column overheadBillDuration int;" 2>&1 | tee -a $sqlErrorLog)
				
				SuccessDBCurrent20=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbResellerCDR_$currentEXT add column overheadBillAmount double;" 2>&1 | tee -a $sqlErrorLog)
				
				SuccessDBCurrent21=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbResellerCDR_$currentEXT add column overheadChargeDetails   varchar(200);" 2>&1 | tee -a $sqlErrorLog)
			fi
			
			echo "Successful DB Update Done..... "
			writeLog "Successful DB Update Done..... "
		
			echo "Going to update \"$FailedDBName\" Database ........"
			writeLog "Going to update \"$FailedDBName\" Database ........"
			
			FailedDBDefault1=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName -e "alter table vbFailedCDR add column callType tinyint default 0 after acctSessionID;" 2>&1 | tee -a $sqlErrorLog)
			
			FailedDBDefault2=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName -e "alter table vbFailedCDR add column originalSrcIP decimal(18,0) after callType;" 2>&1 | tee -a $sqlErrorLog)
			
			FailedDBDefault3=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName -e "alter table vbFailedCDR add column originalSrcPort int after originalSrcIP;" 2>&1 | tee -a $sqlErrorLog)
			
			FailedDBDefault4=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName -e "alter table vbFailedCDR add column  orgMediaIP decimal(18,0) after originalSrcPort;" 2>&1 | tee -a $sqlErrorLog)
			
			FailedDBDefault5=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName -e "alter table vbFailedCDR add column  terMediaIP decimal(18,0) after orgMediaIP;" 2>&1 | tee -a $sqlErrorLog)
			
			FailedDBDefault6=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName -e "alter table vbFailedCDR add column  isProxyCall tinyint default 1 after terMediaIP;" 2>&1 | tee -a $sqlErrorLog)
			
			FailedDBDefault7=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName -e "alter table  vbFailedSummaryCDR add column terPort int default 0;" 2>&1 | tee -a $sqlErrorLog)
			
			FailedDBDefault8=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName -e "alter table  vbFailedSummaryCDR add column orgPort int default 0;" 2>&1 | tee -a $sqlErrorLog)
			
			
			if [ -z "$currentEXT" ];then
				echo "Didint get Current Failed CDR Table"
			else
				FailedDBCurrent1=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName -e "alter table vbFailedCDR_$currentEXT add column callType tinyint default 0 after acctSessionID;" 2>&1 | tee -a $sqlErrorLog)
			
				FailedDBCurrent2=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName -e "alter table vbFailedCDR_$currentEXT add column originalSrcIP decimal(18,0) after callType;" 2>&1 | tee -a $sqlErrorLog)
							
				FailedDBCurrent3=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName -e "alter table vbFailedCDR_$currentEXT add column originalSrcPort int after originalSrcIP;" 2>&1 | tee -a $sqlErrorLog)
							
				FailedDBCurrent4=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName -e "alter table vbFailedCDR_$currentEXT add column  orgMediaIP decimal(18,0) after originalSrcPort;" 2>&1 | tee -a $sqlErrorLog)
							
				FailedDBCurrent5=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName -e "alter table vbFailedCDR_$currentEXT add column  terMediaIP decimal(18,0) after orgMediaIP;" 2>&1 | tee -a $sqlErrorLog)
							
				FailedDBCurrent6=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName -e "alter table vbFailedCDR_$currentEXT add column  isProxyCall tinyint default 1 after terMediaIP;" 2>&1 | tee -a $sqlErrorLog)
							
				FailedDBCurrent7=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName -e "alter table  vbFailedSummaryCDR_$currentEXT add column terPort int default 0;" 2>&1 | tee -a $sqlErrorLog)
							
				FailedDBCurrent8=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName -e "alter table  vbFailedSummaryCDR_$currentEXT add column orgPort int default 0;" 2>&1 | tee -a $sqlErrorLog)
			fi
			
			
			echo "Failed DB Update Done....."
			writeLog "Failed DB Update Done....."
			
			
			updateMediaJAR705 $signalingFolder
			
			start_switch $signalingFolder
			start_tomcat
			
			echo "Switch and Tomcat Started"
			writeLog "Switch and Tomcat Started "
			
			updateAppServerJAR705
			
			echo "Spliting payment table now..."
			writeLog "Spliting payment table now..."
			
			cd /update705Files
			chmod 755 payment_splitter.sh
			sh payment_splitter.sh;
			cd - > /dev/null 2>&1
			
			
			if [ -z "$currentEXT" ];then
				echo "No Old CDR Table to update"
			else
				echo "Going To Update old CDR tables..."
				writeLog "Going To Update old CDR tables....."
				
				olderExts=$((currentEXT -1))
				failedCounter=0
				
				for (( c=${olderExts}; c > ${olderExts}-10; c-- ))
				do  
					SuccessDBOld1=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$c add column callType tinyint default 0;" 2>&1 | tee -a $sqlErrorLog)
					
					SuccessDBOld2=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$c add column overheadBillDuration int;" 2>&1 | tee -a $sqlErrorLog)
					
					SuccessDBOld3=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$c add column overheadBillAmount double;" 2>&1 | tee -a $sqlErrorLog)
					
					SuccessDBOld4=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$c add column overheadChargeDetails  varchar(200);" 2>&1 | tee -a $sqlErrorLog)
					
					SuccessDBOld5=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$c add column originalSrcIP decimal(18,0);" 2>&1 | tee -a $sqlErrorLog)
					
					SuccessDBOld6=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$c add column originalSrcPort int;" 2>&1 | tee -a $sqlErrorLog)
					
					SuccessDBOld7=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$c change orgPort orgPort  smallint(6) unsigned default 0  after acctSessionID;" 2>&1 | tee -a $sqlErrorLog)
					
					SuccessDBOld8=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$c change terPort terPort  smallint(6) unsigned default 0  after orgPort;" 2>&1 | tee -a $sqlErrorLog)
					
					SuccessDBOld9=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$c change packageID packageID int default -1 after terPort;" 2>&1 | tee -a $sqlErrorLog)
					
					SuccessDBOld10=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$c change callType callType tinyint default 0  after packageID;" 2>&1 | tee -a $sqlErrorLog)
					
					SuccessDBOld11=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$c change overheadBillDuration overheadBillDuration int after callType;" 2>&1 | tee -a $sqlErrorLog)
					
					SuccessDBOld12=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$c change overheadBillAmount overheadBillAmount double after overheadBillDuration;" 2>&1 | tee -a $sqlErrorLog)
					
					SuccessDBOld13=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$c change overheadChargeDetails overheadChargeDetails varchar(200) after overheadBillAmount;" 2>&1 | tee -a $sqlErrorLog)
					
					SuccessDBOld14=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$c change originalSrcIP  originalSrcIP decimal(18,0) after overheadChargeDetails;" 2>&1 | tee -a $sqlErrorLog)
					
					SuccessDBOld15=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$c change originalSrcPort  originalSrcPort int after originalSrcIP;" 2>&1 | tee -a $sqlErrorLog)
					
					SuccessDBOld16=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$c add column  orgMediaIP decimal(18,0) after originalSrcPort;" 2>&1 | tee -a $sqlErrorLog)
					
					SuccessDBOld17=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$c add column  terMediaIP decimal(18,0) after orgMediaIP;" 2>&1 | tee -a $sqlErrorLog)
					
					SuccessDBOld18=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbSuccessfulCDR_$c add column  isProxyCall tinyint default 1 after terMediaIP;" 2>&1 | tee -a $sqlErrorLog)
					
					
					SuccessDBOld19=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbResellerCDR_$c add column overheadBillDuration int;" 2>&1 | tee -a $sqlErrorLog)
					
					SuccessDBOld20=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbResellerCDR_$c add column overheadBillAmount double;" 2>&1 | tee -a $sqlErrorLog)
					
					SuccessDBOld21=$(mysql -h $SuccessDBHost -P $iSuccessDBPort -u$SuccessDBUser $SuccessDBPass  --force $SuccessDBName -e "alter table vbResellerCDR_$c add column overheadChargeDetails   varchar(200);" 2>&1 | tee -a $sqlErrorLog)
			
					if [ ${failedCounter} -lt 3  ];then
						FailedDBOld1=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName -e "alter table vbFailedCDR_$c add column callType tinyint default 0 after acctSessionID;" 2>&1 | tee -a $sqlErrorLog)
			
						FailedDBOld2=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName -e "alter table vbFailedCDR_$c add column originalSrcIP decimal(18,0) after callType;" 2>&1 | tee -a $sqlErrorLog)
									
						FailedDBOld3=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName -e "alter table vbFailedCDR_$c add column originalSrcPort int after originalSrcIP;" 2>&1 | tee -a $sqlErrorLog)
									
						FailedDBOld4=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName -e "alter table vbFailedCDR_$c add column  orgMediaIP decimal(18,0) after originalSrcPort;" 2>&1 | tee -a $sqlErrorLog)
									
						FailedDBOld5=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName -e "alter table vbFailedCDR_$c add column  terMediaIP decimal(18,0) after orgMediaIP;" 2>&1 | tee -a $sqlErrorLog)
									
						FailedDBOld6=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName -e "alter table vbFailedCDR_$c add column  isProxyCall tinyint default 1 after terMediaIP;" 2>&1 | tee -a $sqlErrorLog)
									
						FailedDBOld7=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName -e "alter table  vbFailedSummaryCDR_$c add column terPort int default 0;" 2>&1 | tee -a $sqlErrorLog)
									
						FailedDBOld8=$(mysql -h $FailedDBHost -P $iFailedDBPort -u$FailedDBUser $FailedDBPass --force  $FailedDBName -e "alter table  vbFailedSummaryCDR_$c add column orgPort int default 0;" 2>&1 | tee -a $sqlErrorLog)
					fi
				failedCounter=$((failedCounter + 1))
				
				done
				
				echo "Old CDR tables update Done..."
				writeLog "Old CDR tables update Done..."
			
				
				
			fi
			switchUpdateStatus="\n${Green}Switch Updated to 7.0.5 Done  ${NC}"
			
			
			
		fi
		
		
	fi
	
	
	printf "\n\n${switchUpdateStatus}\n\n"
	
	writeStatus=`printf "${switchUpdateStatus}"`
	writeLog "${writeStatus}"
	
	
	writeLog "======================= Prorgam Completed and Exit Successfully ======================="
	writeLog "==================================****************====================================="
else
	exit
fix
