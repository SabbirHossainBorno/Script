#!/bin/sh
SCRIPT_FILE_NAME=server_free.sh
AUTHOR_NAME="# Mirza Golam Abbas Shahneel"
VERSION_DATE='02/06/2020 1820';
VERSION='1.0.0'
SCRIPT_RUN_DATE=($(date +"%F %s"))

#TODO: 
# 1) Enlist all services and modules - Done
# 2) For iTel Switch ask how many CDRs to keep - Done
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 3) For REVE SMS take MongoDB backups
# 4) Clear all softlinks and service files
# 5) Remove "/" from listofshift enlistment
# 6) Check "BackUp Location" starts with "/" or not 
# 7) Tomcat details loading - 

# lastModifications=""

########=============== Initializing Variables ======>>>>>>
scrptLoc=$(pwd);
now="$(date +'%d_%m_%Y_%H_%M_%S')"
# scriptFileName="$SCRIPT_FILE_NAME"
logFileLocation="/home"
logFileName="server_free.log"
logFilePath="$logFileLocation/$logFileName"
sqlErrorLog="$logFileLocation/$logFileName"
# resourceLocation="/updateFiles"
# logDate="date +%F_%T"
localPath="/usr/local/"
resourcePath="$localPath/src/server_free"
mkdir -p $resourcePath
listofshift="$resourcePath/listofshift";
logBackUpLoc=$localPath/logBackUp_$(date +%F)
softlinkBackUpLoc=$localPath/softlinkBackUp_$(date +%F)
mkdir -p $logBackUpLoc
mkdir -p $softlinkBackUpLoc
# serviceFileName="$resourcePath/serviceFileName";
# cmprsList="$resourcePath/cmprsList"
proCss="$resourcePath/proCss"
dbs="$resourcePath/dbs"
dbsListMySQL="$resourcePath/dbsListMySQL"
dbsListMongoDB="$resourcePath/dbsListMongoDB"
mysqlPass="mysql -u root";
cRntMnth=$($mysqlPass --skip-column-name -e"select unix_timestamp(now())/(60*60*24*30) as thisMonth;" | cut -f1 | gawk -F. '{print $1}');
declare -a suffixForSuccessfulCDR=();
declare -a tempTomcatDetails=();
declare -a tomcatServiceIDs=();
declare -a softlinkFileList=();

# logWrtng="/home/server_free.log"
>$listofshift;>$dbs;>$dbsListMySQL;>$dbsListMongoDB;
########=============== Initializing Variables Done ======>>>>>>
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
	# removeScriptFile
	echo -ne "${BBlue}                  System is initializing. Please wait for a while......${NC}"'\r'
	checkBashServicePath
	echo -ne "${BBlue}                  System is initializing. Please wait for a while..........${NC}"'\r'
	checkLsofCommand
	echo -ne "${BBlue}                  System is initializing. Please wait for a while...............${NC}"'\r'
	checkZipCommand
	checkUnzipCommand
	echo -ne "${BBlue}                  System is initializing. Please wait for a while..................${NC}"'\r'
	getMYSQLDataDirectory
	echo -ne "${BBlue}                  System is initializing. Please wait for a while.....................${NC}"'\r'
	getJakartaTomcatInfo
	echo -ne "${BBlue}                  System is initializing. Please wait for a while........................${NC}"'\r'
	# checkSwitchInLocal
	printf "\n${Green}                  Initialization done.........${NC}\n"
	sleep 2
	echo "."
	echo "."
	writeLog "${Green}-----------------  Initialization Done ----------------- ${NC}"
	writeLog "${Green}-----------------   ----------------   ----------------- ${NC}"
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

function is_int() { 
	return $(test "$@" -eq "$@" > /dev/null 2>&1); 
}

function writeLog(){
	logText=$1
	logTime="$(date +'%d-%m-%Y %H:%M:%S')"
	echo -e "$logTime : $logText " >> $logFilePath
}

function findDBMSType(){
	dbType=$1
	if [ $dbType == '1' ];then
		dbmsName='MySQL';
		databaseFile=$dbsListMySQL;
	elif [ $dbType == '2' ];then
		dbmsName='MongoDB';
		databaseFile=$dbsListMongoDB;
	else
		echo -e "${BRed}Database type not valid${NC}";
		writeLog "${BRed}Database type not valid${NC}";
	fi
	echo $dbmsName $databaseFile
}

function checkBashServicePath()
{
	
	systemctlIsEnabled=0
	serviceIsEnabled=0
	
	bash_service=`which systemctl 2>&1 | tee -a $sqlErrorLog`
	
	if [ -z "$bash_service" ] || [[ "$bash_service" =~ "no systemctl in" ]];then
		writeLog "${BRed}Didn't get \"systemctl\" ${NC}"
		bash_service=`which service 2>&1 | tee -a $sqlErrorLog`
		if [ -z "$bash_service" ] || [[ "$bash_service" =~ "no service in" ]];then
			writeLog "${BRed}Didn't get \"service\" ${NC}"
			bash_service="service"
		else
			writeLog "${Green}Got \"service\" ${NC}"
			serviceIsEnabled=1
			bash_service="service"
		fi
	else
		systemctlIsEnabled=1
		writeLog "${Green}Got \"systemctl\" ${NC}"
	fi
	
}

function getMYSQLDataDirectory(){
	writeLog "${BBlue}Checking mysql Data Directory ... ${NC}"
	
	dataDir=$(mysql --force -ss -N -e 'select VARIABLE_VALUE from information_schema.global_variables where VARIABLE_NAME = "DATADIR"' )
	if [ -z $dataDir ];then
		writeLog "${BRed}Didnt get Mysql Data Directory from information_schema. ${NC}"
		dataDir=`grep -m 1  '^datadir' /etc/my.cnf > /dev/null 2>&1`
		dataDir=${dataDir#*=}
		if [ -z $dataDir ];then
			writeLog "${BRed}Didnt get Mysql Data Directory from /etc/my.cnf ${NC}"
			dataDir="/var/lib/mysql"
			writeLog "${BRed}Using default Data Directory $dataDir ${NC}"
		fi
	fi
	
	writeLog "${Green}Got Mysql Data Directory $dataDir ${NC}"
}

function getJakartaTomcatInfo(){
    declare -a tempTomcatInfo=();
    tmct5='jakarta-tomcat-5.0.27'
    tmct7='jakarta-tomcat-7.0.61'
    tmct9='jakarta-tomcat-9.0.17'
    
    # writeLog "Checking Jakarta-Tomcat Location........."
    writeLog "Checking Jakarta-Tomcat Location........."
    
    for localDir in /usr/local/jakarta-tomcat-*/ ;do
        tempDir=${localDir%*/}
        tempDir=${tempDir##*/local/}
        if [[ "$tempDir" == "$tmct5" ]];then
            jak_version="t5";
        elif [[ "$tempDir" == "$tmct7" ]];then
            jak_version="t7";
        elif [[ "$tempDir" == "$tmct9" ]];then
            jak_version="t9";
        else
            jak_version="";
            break;
        fi        
        jak_loc=$localDir
        jak_loc=$(echo $jak_loc | sed 's:/*$::')
		tomcatDiskUsage=$(du -sh $jak_loc | gawk '{print $1}')
        # tempTomcatInfo+=("'$jak_loc'")
        tempTomcatPort=`grep -m1 "Connector port" $jak_loc/conf/server.xml  | gawk -F"port=\"" '{print $2}' | gawk -F"\"" '{print $1}'`
        # tempTomcatInfo+=("'$tempTomcatPort'")
        tempTomcatDetails+=("$jak_version=($jak_loc $tempTomcatPort $tomcatDiskUsage)")
        # echo ${tempTomcatInfo[@]};
        # unset tempTomcatInfo;
    done
    # echo ${tempTomcatDetails[@]}
    # writeLog "Got Jakarta-Tomcat, Location : \"$jak_loc\" "
    # echo -e "Got Jakarta-Tomcat, Location : \n${tempTomcatInfo[@]}"
    for elt in "${tempTomcatDetails[@]}";do eval $elt;done
        for ((i=5;i<10;i+=2));do
		if [ $i -eq 5 ];then
			writeLog "t5 ${#t5[@]} ${t5[@]}";
		elif [ $i -eq 7 ];then
			writeLog "t7 ${#t7[@]} ${t7[@]}";
		elif [ $i -eq 9 ];then
			writeLog "t9 ${#t9[@]} ${t9[@]}";
		fi
	done
}

function getDBDetails(){
	dbConnFile=$1
	
	if [[ "$dbConnFile" == *"DatabaseConnectionMongo.xml" ]];then
		dbUser=`grep -Po '(?<=USER_NAME=")[^"]+' $dbConnFile | sort -u`
		dbPass=`grep -Po '(?<=PASSWORD=")[^"]+' $dbConnFile | sort -u`
		dbFullURL=`grep -Po '(?<=DATABASE_URL=")[^"]+' $dbConnFile | sort -u`
		dbName=`grep -Po '(?<=DATABASE=")[^"]+' $dbConnFile | sort -u`
	else
		dbUser=`grep -Pom1 '(?<=USER_NAME = ")[^"]+' $dbConnFile | head -1`
		dbPass=`grep -Pom1 '(?<=PASSWORD = ")[^"]+' $dbConnFile | head -1`
		dbFullURL=`grep -Pom1 '(?<=DATABASE_URL=")[^"]+' $dbConnFile | head -1`
		dbName=${dbFullURL##*/}
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
	# echo "$dbName,$dbHost,$dbPort,$dbUser,$dbPass"
	echo "$dbName"
}

function enlistDBNames(){
	dbType=$1
	dbName=$2
	declare -a dbmsDetails=();
	
	dbmsDetails+=($(findDBMSType $1))
	
	alreadyListed=$(strings ${dbmsDetails[1]} | grep -w $dbName);
	if [ -z $alreadyListed ];then
		echo $dbName >> ${dbmsDetails[1]}
	fi
	echo -e "${BBlue}Including ${dbmsDetails[0]} databases to be removed: $dbName ${NC}";
	writeLog "${BBlue}Including ${dbmsDetails[0]} databases to be removed: $dbName ${NC}"
}

function getDBNameInput(){
	echo -en "${BRed}Any movable database not enlisted above?${NC}. If yes press - \n${spaceVal}${BCyan}1 for MySQL${NC}\n${spaceVal}${BPurple}2 for MongoDB\n${NC}${spaceVal}${Blue}0 for None\n${NC}:";
		read remainDBEnlist;
		while [ $remainDBEnlist == '1' ] || [ $remainDBEnlist == '2' ] || [ $remainDBEnlist == '0' ];do
			if [ $remainDBEnlist == '0' ];then
				break;
			fi
			echo -en "${BRed}Enter the name of database: ${NC}";
			read remainDBName;
			while [ -z "${remainDBName}" ];do
				echo -en "${BRed}Enter the name of database [Null/Invalid entry not accepted]: ${NC}";
				read remainDBName;
			done
			enlistDBNames $remainDBEnlist $remainDBName;
			echo -en "${BRed}Any movable database not enlisted above?${NC}. If yes press - \n${spaceVal}${BCyan}1 for MySQL${NC}\n${spaceVal}${BPurple}2 for MongoDB\n${NC}${spaceVal}${Blue}0 for None\n${NC}:";
			read remainDBEnlist;
		done
}

function findDatabases(){
	# echo "Under Constructions";
	declare -a dbsMySQL=();
	declare -a dbsMySQLUnsorted=();
	declare -a dbsMongoDB=();
	for i in $(cat $listofshift);do
		countDatabaseConnectionXML=$(ls $i/DatabaseConnection*.xml 2>&1);
		if [[ "$countDatabaseConnectionXML" =~ "ls: cannot access" ]];then
			writeLog "${BRed}$i does not have database connection ${NC}"
		else
			writeLog "${Green}$i found database connection ${NC}"
			for j in $(echo $countDatabaseConnectionXML);do
				if [[ "$j" == *"DatabaseConnection.xml" ]] || [[ "$j" == *"DatabaseConnection_Successful.xml" ]] || [[ "$j" == *"DatabaseConnection_Failed.xml" ]] || [[ "$j" == *"DatabaseConnection_Reseller.xml" ]] || [[ "$j" == *"DatabaseConnection_portabilityRemote.xml" ]];then
					RESULT=$( getDBDetails $j )
					writeLog "${Green}$RESULT ${NC}"
					dbsMySQL+=($RESULT);
				elif [[ "$j" == *"DatabaseConnectionMongo.xml" ]];then
					RESULT=$( getDBDetails $j );
					writeLog "${Green}$RESULT ${NC}"
					for k in $RESULT;do
						dbsMongoDB+=($k);
					done
				else
					writeLog "${Green}$j ${NC}"
				fi
			done
		fi
		unset countDatabaseConnectionXML;
	done
	echo -e "${Green}MySQL Databases${NC}";
	for i in ${dbsMySQL[@]};do
		enlistDBNames 1 $i;
	done
	echo -e "${Green}MongoDB Databases${NC}";
	for i in ${dbsMongoDB[@]};do
		enlistDBNames 2 $i;
	done	

	getDBNameInput
}

function compressAndMoveDBs(){
    cd $dataDir;
    if [ ! -z "$(cat $dbsListMySQL)" ];then
		echo -e "${BBlue}Initiating MySQL database movement...${NC}"
		writeLog "${BBlue}Initiating MySQL database movement...${NC}"
        mkdir -p $bckMySQLDataDir
        for i in $(cat $dbsListMySQL);do
			echo -e "${BBlue}Selected: $i..${NC}"
			writeLog "${BBlue}Selected: $i..${NC}"
            if [[ "$i" == "Successful"* ]];then
                toCompressSuccessfulCDR+=("$i/*CDR.*")
                for j in ${suffixForSuccessfulCDR[@]};do
                    toCompressSuccessfulCDR+=("$i/*_$j.*");
                done
                tar -zcf $bckMySQLDataDir/$i.tar.gz ${toCompressSuccessfulCDR[@]} >> $logFilePath 2>&1
			elif [[ "$i" == "Failed"* ]];then
				tar -zcf $bckMySQLDataDir/$i.tar.gz $i --exclude="$i/vb*_*" >> $logFilePath 2>&1
			else
				tar -zcf $bckMySQLDataDir/$i.tar.gz $i >> $logFilePath 2>&1
            fi
			echo -e "${Green}Compressed and Moved: $i..${NC}"
			writeLog "${Green}Compressed and Moved: $i..${NC}"
        done
	else
		echo -e "${BRed}No MySQL databases found...${NC}"
		writeLog "${BRed}No MySQL databases found...${NC}"
    fi
    cd - >> $logFilePath 2>&1; 
	
    if [ ! -z "$(cat $dbsListMongoDB)" ];then
		echo -e "${BBlue}Initiating MongoDB database movement...${NC}"
		writeLog "${BBlue}Initiating MongoDB database movement...${NC}"
        mkdir -p $bckMongoDataDir;
        for i in $(cat $dbsListMongoDB);do
			echo -e "${BBlue}Selected: $i..${NC}"
			writeLog "${BBlue}Selected: $i..${NC}"
            # echo $i;
            mongodump --db $i -o $bckMongoDataDir >> $logFilePath 2>&1
			echo -e "${Green}Compressed and Moved: $i..${NC}"
			writeLog "${Green}Compressed and Moved: $i..${NC}"
        done
	else
		echo -e "${BRed}No MongoDB databases found...${NC}"
		writeLog "${BRed}No MongoDB databases found...${NC}"
    fi
}

function findSoftLinks(){
    softlinkFile=$1
    writeLog $softlinkFile
    for i in $(find /etc/rc.d/ -type l -o -type f | grep "$softlinkFile");do
        writeLog $i;
        softlinkFileList+=($i)
    done
}

function stopListedServices(){
	if [ ! -z $listofshift ];then
		echo -e "${BBlue}Do you want to remove all log files from Signaling, Media and other related folders? (Y/N) ${NC}";
		read removeServiceLogFilesPermission;
		writeLog "${BRed}Log removal permission from user: $removeServiceLogFilesPermission${NC}";
		for localDir in $(cat $listofshift);do
			localDir=$(echo $localDir | sed 's/\/\//\//g')
			serviceName=$localDir
			serviceName=$(echo $serviceName | sed 's/\/usr\/local\///g' | sed 's/\///g')
			processIDofService=$(lsof +D $localDir 2>/dev/null| grep -m1 "DIR" | gawk '{print $2}');
			runFile=$(find $localDir/ -name run*.sh | grep -m1 "run")
			shutDownFile=$(find $localDir/ -name shut*.sh | grep -m1 "shut")
			serviceLogFileName=$(strings $localDir/log4j.properties | grep File | grep ".log$" | gawk -F"=" '{print $2}' | xargs )
			serviceFileName=$(strings $localDir/*.sh | grep "/etc/rc.d/init.d/" -m1 | gawk '{print $3}');
			writeLog "${BGreen}| Service name: $serviceName | PID: $processIDofService | Service File: $serviceFileName | Run File: $runFile | Shutdown File: $shutDownFile | Log: $serviceLogFileName |${NC}";
			while [ ! -z $processIDofService ];do
				$shutDownFile
				$shutDownFile
				$shutDownFile
				processIDofServiceRunning=$(lsof -p $processIDofService)
				writeLog $processIDofServiceRunning
				if [ ! -z $processIDofServiceRunning ];then
					kill -9 $processIDofService;
					writeLog "${BRed}PID: $processIDofService killed for $serviceName";
					processIDofService="";
				else
					writeLog "${Green}$serviceName stopped... ${NC}"
					processIDofService="";
				fi
				writeLog ""
				# if [ $systemctlIsEnabled -eq 1 ];then
					# $bash_service stop $serviceName
				# elif [ $serviceIsEnabled -eq 1 ];then
					# $bash_service $serviceName stop
				# fi
			done
			if [ $removeServiceLogFilesPermission == y ] || [ $removeServiceLogFilesPermission == Y ] || [ $removeServiceLogFilesPermission == YES ] || [ $removeServiceLogFilesPermission == yes ];then
				cd $localDir
				mv $serviceLogFileName* $logBackUpLoc/ >> $logFilePath 2>&1
				cd /usr/local/
			fi
			mv $serviceName $backUpDir >> $logFilePath 2>&1;
			writeLog "${BBlue}Finding softlinks...${NC}";
			findSoftLinks $serviceName;
		done
	else
		echo -e "${BRed}No services enlisted...${NC}";
	fi
}

function removeSoftlinks(){
	echo -e "${Green}${softlinkFileList[@]}${NC}";
	writeLog "${Green}${softlinkFileList[@]}${NC}";
	echo -e "${BBlue}Do you want to remove all softlink files for Signaling, Media and other related folders? (Y/N) ${NC}";
	read removeSoftLinkPermission;
	writeLog "${BRed}Softlink removal permission from user: $removeSoftLinkPermission${NC}";
	if [ $removeSoftLinkPermission == y ] || [ $removeServiceLogFilesPermission == Y ] || [ $removeServiceLogFilesPermission == YES ] || [ $removeServiceLogFilesPermission == yes ];then
		for sftlinkFile in ${softlinkFileList[@]};do
			rm -f $sftlinkFile >> $logFilePath 2>&1
		done
	fi
}


# function fn_lsof(){
	# declare -i lsofFlag=0
	# lsofStat=`rpm -qa | grep lsof`
	# if [ -z $lsofStat ];then
		# `yum -y install lsof >> $logFilePath 2>&1`
		# lsofStat=`rpm -qa | grep lsof`
		# if [ -z $lsofStat ]; then
			# lsofFlag=0
		# else
			# lsofFlag=1
			# instlld+=(lsof);
		# fi
	# else
			# lsofFlag=1
			# instlld+=(lsof);
	# fi
	# return $lsofFlag
# }

# function fn_zip(){
	# declare -i zipFlag=0
	# zipStat=`rpm -qa | grep -w zip`
	# if [ -z $zipStat ];then
		# `yum -y install zip >> $logFilePath 2>&1`
		# zipStat=`rpm -qa | grep -w zip`
		# if [ -z $zipStat ]; then
			# zipFlag=0
			# instlld+=(zip);
		# else
			# zipFlag=1
			# instlld+=(zip);
		# fi
	# else
			# zipFlag=1
	# fi
	# return $zipFlag
# }
# function fn_unzip(){
	# declare -i unzipFlag=0
	# unzipStat=`rpm -qa | grep unzip`
	# if [ -z $unzipStat ];then
		# `yum -y install unzip >> $logFilePath 2>&1`
		# unzipStat=`rpm -qa | grep unzip`
		# if [ -z $unzipStat ]; then
			# unzipFlag=0
		# else
			# unzipFlag=1
			# instlld+=(unzip);
		# fi
	# else
			# unzipFlag=1
			# instlld+=(unzip);
	# fi
	# return $unzipFlag
# }

function checkLsofCommand(){
        
	writeLog "Checking lsof Status......."
	lsofFlag=0
	lsofStat=`rpm -qa | grep lsof`
	if [ -z $lsofStat ];then
		`yum -y install lsof >> $logFilePath 2>&1`
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
	
	if [ $lsofFlag -eq 0 ];then
		printf "\n${BRed} bash Command 'lsof'  not Found. ${NC}\n\n"
		printf "\n${BRed} Please install lsof  Manually then it again.${NC}\n\n"
		exit
	fi
}
function checkUnzipCommand(){
	
	writeLog "Checking unzip Command........."
	declare -i unzipFlag=0
	unzipStat=`rpm -qa | grep unzip`
	
	if [ -z $unzipStat ];then
		`yum -y install unzip >> $logFilePath 2>&1`
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

function checkZipCommand(){
	
	writeLog "Checking zip Command........."
	declare -i zipFlag=0
	zipStat=`rpm -qa | grep zip -w`
	
	if [ -z $zipStat ];then
		`yum -y install zip >> $logFilePath 2>&1`
		zipStat=`rpm -qa | grep zip`
		if [ -z $zipStat ]; then
			zipFlag=0
		else
			zipFlag=1
		fi
	else
			zipFlag=1
	fi
	#return $zipFlag
	writeLog "zip Status is \"$zipFlag\" "
	
	if [ $zipFlag -eq 0 ];then
		printf "\n${BRed} bash Command 'zip'  not Found. ${NC}\n\n"
		printf "\n${BRed} Please install zip  Manually then it again.${NC}\n\n"
		exit
	fi
	
}

function fn_input(){
	echo "----------------------------------------------------------------"
		echo -en "${BBlue}Enter Switch Reference Code: ${NC}";
		read refCode;
		while [ -z "${refCode}" ];do
			echo -n "Please enter Server Tag [Null/Invalid entry not accepted]: "
			read refCode;
		done
	echo "----------------------------------------------------------------"
		echo -en "${BBlue}Enter Server IP: ${NC}";
		read oSrvrIP;
		while [[ ! $oSrvrIP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]];do
			echo -n "Please enter Server IP [Null/Invalid entry not accepted]: "
			read oSrvrIP;
		done
		oSrvrIPDir=$(echo $oSrvrIP | sed 's/\./\_/g');
		backUpDir="$localPath"/backUp_"$refCode"_"$oSrvrIPDir";
		# backUpDirExists=$(ls $localPath | grep $backUpDir)
		cd $localPath
		if [ -d "$backUpDir" ];then
			mv $backUpDir $backUpDir\_$(date +%F_%s)
		fi
		mkdir -p $backUpDir
		bckMySQLDataDir="$backUpDir/MySQL_$(date +%F)";
		bckMongoDataDir="$backUpDir/MongoDB_$(date +%F)";
		#backUpDir="$localPath/backUp_ip_$oSrvrIPDir\_tag_$refCode"
		# echo -e "${BRed}Local BackUp Folder: $backUpDir ${NC}";
		writeLog "${BRed}Local backup location : $backUpDir ${NC}"
		writeLog "${BRed}Local MySQL DB backup location: $bckMySQLDataDir ${NC}"
		writeLog "${BRed}Local MongoDB backup location: $bckMongoDataDir ${NC}"

	echo "----------------------------------------------------------------"
		echo -en "${BBlue}Enter BackUp Server IP: ${NC}";
		read nSrvrIP;
		while [[ ! $nSrvrIP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]];do
			echo -n "Please enter BackUp Server IP [Null/Invalid entry not accepted]: "
			read nSrvrIP;
		done
		# echo -e "${BRed}BackUp Server IP: $nSrvrIP ${NC}";
		writeLog "${BRed}BackUp Server IP: $nSrvrIP ${NC}"
		
	echo "----------------------------------------------------------------"
		echo -en "${BBlue}Enter BackUp Location: ${NC}";
		read nSrvrBackUpLoc;
		while [ -z "${nSrvrBackUpLoc}" ]
		do
			echo -n "Please enter BackUp Location [Null/Invalid entry not accepted]: "
			read nSrvrBackUpLoc;
		done
		nSrvrBackUpLoc="/$nSrvrBackUpLoc/"
		# echo -e "${BRed}BackUp Location: $nSrvrBackUpLoc ${NC}";
		writeLog "${BRed}BackUp Location: $nSrvrBackUpLoc ${NC}"
		
	echo "----------------------------------------------------------------"
		echo -en "${BBlue}How many month's last CDR to keep? ${NC}";
		read cdrMonths;
		while [ -z "${cdrMonths}" ]
		do
			echo -n "How many month's last CDR to keep? [Null/Invalid entry not accepted]: "
			read cdrMonths;
		done

		for i in $(seq $cRntMnth -1 $(($cRntMnth - $cdrMonths + 1)));do
			suffixForSuccessfulCDR+=($i);
		done
		writeLog "${Green}Current Month: $cRntMnth ${NC}"
		writeLog "${BBlue}CDR to keep for last $cdrMonths months${NC}"
		writeLog "${BBlue}CDR suffixes are: ${suffixForSuccessfulCDR[@]} ${NC}";
		
		
		
	# echo "----------------------------------------------------------------"
		# echo -en "${BBlue}Enter all service names: ${NC}";
		# read srvFolders;
		# while [ -z "${srvFolders}" ]
		# do
			# echo -n "Please enter all service names [Null/Invalid entry not accepted]: "
			# read srvFolders;
		# done
		# # echo -e "${BRed}All modules to be removed: $srvFolders ${NC}";
		# writeLog "${BRed}All modules to be removed: $srvFolders ${NC}"
	
	declare -a availableService=();
	for i in $(ls -d $localPath/*/ | grep "BalanceServer\|ByteSaver\|CreditCardServer\|DBHealthChecker\|IPChanger\|iTel\|MobileBilling\|MoneyTransfer\|PaymentServer\|PushSender\|PushNotificationSender\|RadiusServer\|SwitchInstaller\|SMS_Server\|SMSServer\|TopUpServer\|WholeSale") ;do
		# a=$(echo $i | gawk -F"$localPath" '{print $2}')
		# availableService+=($a);
		availableService+=($i);
		totalService=${availableService[@]}
	done

	for i in $(echo ${availableService[@]});do
		echo -e "${BBlue}Including services to be removed: $i ${NC}";
		writeLog "${BBlue}Including services to be removed: $i ${NC}"
		echo $i >> $listofshift;
	done
	# sed 's/\/usr\/local\///g' $listofshift > $serviceFileName;
	# sed -i 's/\///g' $serviceFileName
	
}

########=============== Initializing System ======>>>>>>
initializingSystem
######=============================Going For User inpiut=================>>>>>>
fn_input
findDatabases
stopListedServices
compressAndMoveDBs
removeSoftlinks
writeLog "${Green}All task done... please perform the manual operations...${NC}"
echo -e "${Green}All task done... please perform the manual operations...${NC}"