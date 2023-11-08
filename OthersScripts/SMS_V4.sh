author_name="# Moshhud_Ahmed"
version="# 4.0"
modifiedp="# Modified_18_May_2016_1242PM";
modified="# Modified_2022-09-01_0741AM";

#version info
var_media_v="3.5.7";
var_signaling_v="7.0.1  minor 3";
var_web_v="7.1.1";
var_billing_v="7";
var_wsms_web_v="3.1.7"
var_wsms_server_v="3.1.7"
var_wsms_web_v4="4.0.0.0.1"
var_wsms_server_v4="4.0.0"
#installer server ip
var_installer_ip="149.20.186.19";
YUM_CONF='/etc/yum.conf';
MONGODB_REPO='/etc/yum.repos.d/mongodb-org-4.2.repo';
MONGODB_CONF='/etc/mongod.conf';
mongoInstallTrial=0;
OS_IS_7=0;
flg=0;
flg2=0;
flg_mbilling=0;
flg_mtopup=0;
x_64=1;
flg_recycle=0;
var_jdk="/usr/jdk1.6.0_25";
var_tomcat="8.0.1";
flg_jdk=0;
flg_n_sw=0;
flg_sleep=0;
flg_n_md=0;
switch_port=0;
var_web="itelbilling";
var_db_itelbilling="iTelBilling";
var_db_successful="Successful";
var_db_failed_failed="Failed";
flg_mt=0;
flg_mb=0;
flg_sm=0;
flg_DH=0;
service_name="billing"
flg_paid_module="new";
# New Variables
logFileLocation="/usr/local/src/"
logFileName="installer.log"
logFilePath="$logFileLocation/$logFileName"
sqlErrorLog="$logFileLocation/$logFileName"
resource_portal="https://supportresources.revesoft.com:4430"
chmod ug= /usr/local/installer
LOGFILE="/usr/local/src/installer.log"
# -- Color Codes
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
# -- log write / logger / writelog
function writeLog(){
	logText=$1
	logTime="$(date +'%d-%m-%Y %H:%M:%S')"
	echo -e "$logTime : $logText "
	echo -e "$logTime : $logText " >> $logFilePath
}
function writeLogSilent(){
	logText=$1
	logTime="$(date +'%d-%m-%Y %H:%M:%S')"
	echo -e "$logTime : $logText " >> $logFilePath
}
function fn_rocksaw(){
	find  /usr/lib -name 'librocksaw.so'  | grep "librocksaw.so" && var_librocksaw=1  || var_librocksaw=0
	if [ $var_librocksaw == 0 ];then
		cd /usr/lib
		wget http://$var_installer_ip/downloads/librocksaw.so
	fi
}
####################################################################
# Get System Info
####################################################################
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
			#readonly OS
			#readonly DIST
			#readonly DistroBasedOn
			#readonly PSUEDONAME
			#readonly REV
			#readonly KERNEL
			#readonly MACH
		fi
	fi
}
function fn_switch_down(){
	cd /usr/local
	for _dir in /usr/local/iTelSwitchPlusSignaling*/; do
		if [ -d "${_dir}" ];then
			dir="${_dir}"
			billing="$(basename "${dir}")"
			cd "${dir}"
			find  /usr/local/$billing -name MailAlert.jar  | grep "MailAlert.jar" && found=1  || found=0
			if [ $found == 0 ];then
				wget http://$var_installer_ip/downloads/MailAlert.jar
				orgBindIP="$(cat config/server.cfg | grep "orgBindIP" | cut -d "=" -f2)"
				echo "AdditionalToAddress=support@revesoft.com">>config/emailInfo.cfg
				echo "FromAddress=noreply-support@revesoft.com">>config/emailInfo.cfg
				echo "MailServer=mail.revesoft.com">>config/emailInfo.cfg
				echo "MailSeverPort=2525">>config/emailInfo.cfg
				echo "needAuthenticationFromMailServer=yes">>config/emailInfo.cfg
				echo "authenticationEmailAddress=noreply-support@revesoft.com">>config/emailInfo.cfg
				echo "authenticationEmailPassword=ChangeDPasS01032016#">>config/emailInfo.cfg
				echo "MailSubject=Switch Down alert">>config/emailInfo.cfg
				echo "MailContent=Dear Support,\n  Here is the information about Switch Down: \n Switch IP: $orgBindIP \n Signaling Location: /usr/local/$billing \n\nRegards,\niTelSwitchMonitoring Team.">>config/emailInfo.cfg
				echo "Configured /usr/local/$billing"
				echo ""
				sleep 2;
			else
				echo "MailAlert.jar already exist for switch /usr/local/$billing"
				echo ""
				sleep 2;
			fi
		fi
	done
}
function fn_pswitch_down(){
	cd /usr/local
	for _dir in /usr/local/iTelBilling*/; do
		if [ -d "${_dir}" ];then
			dir="${_dir}"
			billing="$(basename "${dir}")"
			cd "${dir}"/iTelSwitchPlusSignaling
			find  /usr/local/$billing/iTelSwitchPlusSignaling/ -name MailAlert.jar  | grep "MailAlert.jar" && found=1  || found=0
			if [ $found == 0 ];then
				wget $resource_portal/media/Installer/MailAlert.jar
				orgBindIP="$(cat config/server.cfg | grep "orgBindIP" | cut -d "=" -f2)"
				echo "AdditionalToAddress=support@revesoft.com">>config/emailInfo.cfg
				echo "FromAddress=noreply-support@revesoft.com">>config/emailInfo.cfg
				echo "MailServer=mail.revesoft.com">>config/emailInfo.cfg
				echo "MailSeverPort=2525">>config/emailInfo.cfg
				echo "needAuthenticationFromMailServer=yes">>config/emailInfo.cfg
				echo "authenticationEmailAddress=noreply-support@revesoft.com">>config/emailInfo.cfg
				echo "authenticationEmailPassword=ChangeDPasS01032016#">>config/emailInfo.cfg
				echo "MailSubject=Switch Down alert">>config/emailInfo.cfg
				echo "MailContent=Dear Support,\n  Here is the information about Switch Down: \n Switch IP: $orgBindIP \n Signaling Location: /usr/local/$billing/iTelSwitchPlusSignaling \n\nRegards,\niTelSwitchMonitoring Team.">>config/emailInfo.cfg
				echo "Configured /usr/local/$billing"
				echo ""
				sleep 2;
			else
				echo "MailAlert.jar already exist for switch /usr/local/$billing"
				echo ""
				sleep 2;
			fi
		fi
	done
}
function fn_service_status(){
	dir1=/usr/local/iTelSwitchPlusMediaProxy$service_name;
	dir2=/usr/local/iTelSwitchPlusSignaling$service_name;
	dir3=/usr/local/iTelAppsServer$service_name;
	dir4=/usr/local/DBHealthChecker$service_name;
	dir5=/usr/local/jakarta-tomcat-7.0.61/logs;
	echo -e "${Blue}###########################################################################";
	echo "#                                                                         #";
	echo "#                          Service Status                                 #";
	echo "#-------------------------------------------------------------------------#";
	if [ -d "${dir1}" ];then
		media="$(cat $dir1/iTelSwitchPlusMediaProxy.log | grep -w "started successfully")"
		if [ ! -z "${media}" ];then
			echo -e "# ${Green}  iTelSwitchPlusMediaProxy  : Started Successfully                       ${Blue}#";
		else
			echo -e "# ${BRed}  iTelSwitchPlusMediaProxy  : Failed                       ${Blue}#";
		fi
	fi
	if [ -d "${dir2}" ];then
		signaling="$(cat $dir2/iTelSwitchPlusSignaling.log | grep -w "started successfully")"
		if [ ! -z "${signaling}" ];then
			echo -e "# ${Green}  iTelSwitchPlusSignaling  : Started Successfully                     ${Blue}#";
		else
			echo -e "#  ${BRed} iTelSwitchPlusSignaling  : Failed                         ${Blue}#";
		fi
	fi
	if [ -d "${dir3}" ];then
		app="$(cat $dir3/iTelApps.log | grep -w "started successfully")"
		if [ ! -z "${app}" ];then
			echo -e "#  ${Green} iTelAppsServer  : Started Successfully                         ${Blue}#";
		else
			echo -e "# ${BRed}  iTelAppsServer  : Failed                         ${Blue}#";
		fi
	fi
	if [ -d "${dir4}" ];then
		health="$(cat $dir4/DBHealthChecker.log | grep -w "Started Successfully")"
		if [ ! -z "${health}" ];then
			echo -e "#  ${Green} DBHealthChecker  : Started Successfully                         ${Blue}#";
		else
			echo -e "#  ${BRed} DBHealthChecker  : Failed                         ${Blue}#";
		fi
	fi
	if [ -d "${dir5}" ];then
		tomcat="$(cat $dir5/catalina.out | grep -w "Server startup")"
		if [ ! -z "${tomcat}" ];then
			echo -e "# ${Green}  Tomcat  : Started Successfully                         ${Blue}#";
		else
			echo -e "# ${BRed}  Tomcat  : Failed                         ${Blue}#";
		fi
	fi
	echo -e "###########################################################################${NC}";
}
function IP_Check(){
	readarray -t IP_List <<< "$(ifconfig |grep -Po 't addr:\K[\d.]+')"
	found="n"
	for elements in "${IP_List[@]}";do
		if [ "${1}" == "${elements}" ];then
			found="y"
		fi
	done
}
function fn_install_switch_lite(){
	 switch_start_time=$(date +%s);
		cd /home/swp
		#initialize
		var_call_capacity=3000;
		var_media_memory=1024;
		var_sig_memory=1024;
		#memory status of server
		fn_server_mem_status;
		echo -n "Memory for Media: ";
		read var_media_memory;
		if [ -z "${var_media_memory}" ]
		 then
			var_media_memory=2048;
		fi
		echo -n "Memory for Signaling: ";
		read var_sig_memory;
		if [ -z "${var_sig_memory}" ]
		 then
			var_sig_memory=2048;
		fi
		echo -n "Switch call volume: ";
		#read var_sw_callvolume
		#while [[ ! $var_sw_callvolume =~ ^[0-9]+$ ]]
		#	do
		#		echo -n "Please enter Switch Call volume [Null/Invalid entry not accepted]: "
		#		read var_sw_callvolume;
		#	done
		echo "----------------------------------------------";
		echo -n "Reference number: ";
		read var_ref;
		while [ -z "${var_ref}" ]
			do
				echo -n "Please enter Reference number [Null/Invalid entry not accepted]: "
				read var_ref;
			done
		#echo -n "Sales executive: ";
		#read var_sales;
		echo -n "Sales executive Email ID: ";
		read var_sales_email;
		while [ -z "${var_sales_email}" ]
			do
				echo -n "Please enter Sales Email [Null/Invalid entry not accepted]: "
				read var_sales_email;
			done
		var_sales=$var_sales_email;
		#echo -n "Switch Installed by: ";
		#read var_installedBy;
		var_installedBy="Installer";
		if [ -z "${var_ref}" ]
		 then
		  var_ref="Demo";
		  echo "Reference number: $var_ref";
		 else
		  echo "Reference number: $var_ref";
		fi
		if [ -z "${var_sales}" ]
		 then
		  var_sales="Demo";
		  echo "Sales executive: $var_sales";
		 else
		  echo "Sales executive: $var_sales";
		fi
		if [ -z "${var_installedBy}" ]
		 then
		  var_installedBy="Demo";
		  echo "Switch Installed by: $var_installedBy";
		 else
		  echo "Switch Installed by: $var_installedBy";
		fi
		echo -n "Enter Customer Email ID: ";
		read email;
		while [ -z "${email}" ]
			do
				echo -n "Please enter Customer Email [Null/Invalid entry not accepted]: "
				read email;
			done
		if [ -z "${email}" ]
		 then
		  #echo "Empty value";
		  email="noreply-support@revesoft.com";
		  echo "Current email id: $email";
		 else
		  #echo "Not empty.";
		  echo "Current email id: $email";
		fi
		echo -n "Enter billing name: ";
		read billing;
		service_name=$billing;
		while [ -z "${billing}" ]
			do
				echo -n "Please enter Billing Name [Null/Invalid entry not accepted]: "
				read billing;
			done
		if [ -z "${billing}" ]
		 then
		  #echo "Empty value";
		  billing="itelbilling";
		  echo "Billing name: $billing";
		 else
		  #echo "Not empty.";
		  echo "Billing name: $billing";
		fi
		echo -n "Administrative User: ";
		read var_user;
		while [ -z "${var_user}" ]
			do
				echo -n "Please enter Administrative User [Null/Invalid entry not accepted]: "
				read var_user;
			done
		echo -n "Administrative password: ";
		read admin_pass;
		while [ -z "${admin_pass}" ]
			do
				echo -n "Please enter Administrative password [Null/Invalid entry not accepted]: "
				read admin_pass;
			done
		if [ -z "${var_user}" ]
		 then
		  var_user="admin";
		  echo "Default User: $var_user";
		 else
		  echo "Default User: $var_user";
		fi
		if [ -z "${admin_pass}" ]
		 then
		  admin_pass="admin";
		  echo "Default password: $admin_pass";
		 else
		  echo "Default password: $admin_pass";
		fi
		var_web=$billing;
		var_db_itelbilling="iTelBilling$billing";
		var_db_successful="Successful$billing";
		var_db_failed_failed="Failed$billing";
		flg_paid_module="new";
		cd /home/swp
		cp -r  itelbilling $billing
		cp -r  iTelSwitchPlusMediaProxy iTelSwitchPlusMediaProxy$billing
		cp -r  iTelSwitchPlusSignaling iTelSwitchPlusSignaling$billing
		cd iTelSwitchPlusMediaProxy$billing
		echo "Version: ">version
		echo "Media: $var_media_v">>version
		echo "Signaling: $var_signaling_v">>version
		echo "Web: $var_web_v">>version
		#MediaProxy configuration
		echo  "configuring rtpProperties.cfg";
		echo "";
		echo "-------------------sample-------------------";
		echo "";
		echo "rtpStartPort=4000"
		echo "rtpEndPort=9000"
		echo "OrgrtpStartPort=9100"
		echo "OrgrtpEndPort=13000"
		echo "localListenIP=192.168.100.10"
		echo "localListenPort=62"
		echo "rtpTimeout=60"
		echo "remoteSignalingIP=192.168.100.10"
		echo "remoteSignalingPort=191"
		echo "disableTerminatingToOriginatingRTPQueue=1"
		echo "#terminatingToOriginatingRTPQueueSize=6"
		echo "terminatingToOriginatingRTPPacketSize=80"
		echo "minimumTerminatingToOriginatingRTPQueue=1"
		echo "duplicateOriginatingPacketSendingCount=0"
		echo "minimumAverageForVAD=500"
		echo "ivrFileFolder=/usr/local/iTelSwitchPlusMediaProxy/IVR"
		echo "#rtpHeader=0x78534734A7B5E274B6C8E6D3282A6D3F"
		echo "#recordmediafolder=/usr/local/iTelSwitchPlusMediaProxy/media/"
		echo "maxCallCapacity=3000"
		echo "supportVideo=1"
		echo "applyorggain=1"
		echo "applytergain=1"
		echo "ivrPlayDuaration=10"
		echo "";
		echo "------------------------------------------";
		echo -n "rtpStartPort: ";
		read rtpStartPort;
		while [[ ! $rtpStartPort =~ ^[0-9]+$ ]]
			do
				echo -n "Please enter rtpStartPort [Null/Invalid entry not accepted]: "
				read rtpStartPort;
			done
		echo -n "rtpEndPort: ";
		read rtpEndPort;
		while [[ ! $rtpEndPort =~ ^[0-9]+$ ]]
			do
				echo -n "Please enter rtpEndPort [Null/Invalid entry not accepted]: "
				read rtpEndPort;
			done
		echo -n "localListenIP: ";
		read localListenIP;
		while [[ ! $localListenIP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]
			do
				echo -n "Please enter localListenIP [Null/Invalid entry not accepted]: "
				read localListenIP;
			done
		echo -n "localListenPort: ";
		read localListenPort;
		while [[ ! $localListenPort =~ ^[0-9]+$ ]]
			do
				echo -n "Please enter localListenPort [Null/Invalid entry not accepted]: "
				read localListenPort;
			done
		echo  "remoteSignalingIP: $localListenIP";
		#read remoteSignalingIP;
		remoteSignalingIP=$localListenIP;
		echo -n "remoteSignalingPort: ";
		read remoteSignalingPort;
		while [[ ! $remoteSignalingPort =~ ^[0-9]+$ ]]
			do
				echo -n "Please enter remoteSignalingPort [Null/Invalid entry not accepted]: "
				read remoteSignalingPort;
			done
		echo "rtpStartPort=$rtpStartPort">rtpProperties.cfg
		echo "rtpEndPort=$rtpEndPort">>rtpProperties.cfg
		echo "#OrgrtpStartPort=9100">>rtpProperties.cfg
		echo "#OrgrtpEndPort=13000">>rtpProperties.cfg
		echo "localListenIP=$localListenIP">>rtpProperties.cfg
		echo "localListenPort=$localListenPort">>rtpProperties.cfg
		echo "rtpTimeout=60">>rtpProperties.cfg
		echo "remoteSignalingIP=$remoteSignalingIP">>rtpProperties.cfg
		echo "remoteSignalingPort=$remoteSignalingPort">>rtpProperties.cfg
		echo "disableTerminatingToOriginatingRTPQueue=1">>rtpProperties.cfg
		echo "#terminatingToOriginatingRTPQueueSize=6">>rtpProperties.cfg
		echo "terminatingToOriginatingRTPPacketSize=80">>rtpProperties.cfg
		echo "minimumTerminatingToOriginatingRTPQueue=1">>rtpProperties.cfg
		echo "duplicateOriginatingPacketSendingCount=0">>rtpProperties.cfg
		echo "minimumAverageForVAD=500">>rtpProperties.cfg
		echo "ivrFileFolder=/usr/local/iTelSwitchPlusMediaProxy$billing/IVR">>rtpProperties.cfg
		echo "#rtpHeader=0x78534734A7B5E274B6C8E6D3282A6D3F">>rtpProperties.cfg
		echo "#recordmediafolder=/usr/local/iTelSwitchPlusMediaProxy/media/">>rtpProperties.cfg
		echo "maxCallCapacity=$var_call_capacity">>rtpProperties.cfg
		echo "supportVideo=1">>rtpProperties.cfg
		echo "applyorggain=1">>rtpProperties.cfg
		echo "applytergain=1">>rtpProperties.cfg
		echo "ivrPlayDuaration=10">>rtpProperties.cfg
		#Mediaproxy service file
		mv iTelSwitchPlusMediaProxy iTelSwitchPlusMediaProxy$billing
		echo "#!/bin/sh">iTelSwitchPlusMediaProxy$billing
		echo "## iTelSwitchPlusMediaProxy   This shell script takes care of starting and stopping iTelSwitchPlusMediaProxy">>iTelSwitchPlusMediaProxy$billing
		echo "# Source function library.">>iTelSwitchPlusMediaProxy$billing
		echo ". /etc/rc.d/init.d/functions">>iTelSwitchPlusMediaProxy$billing
		echo "#">>iTelSwitchPlusMediaProxy$billing
		var="\$1"
		echo "case \"$var\" in">>iTelSwitchPlusMediaProxy$billing
		echo "start)">>iTelSwitchPlusMediaProxy$billing
		echo "echo -n \"Starting iTelSwitchPlus MediaProxy$billing:">>iTelSwitchPlusMediaProxy$billing
		echo "\"">>iTelSwitchPlusMediaProxy$billing
		echo "/usr/local/iTelSwitchPlusMediaProxy$billing/runiTelSwitchPlusMediaProxy.sh">>iTelSwitchPlusMediaProxy$billing
		echo ";;">>iTelSwitchPlusMediaProxy$billing
		echo "stop)">>iTelSwitchPlusMediaProxy$billing
		echo "echo -n \"Stoping iTelSwitchPlus MediaProxy$billing:">>iTelSwitchPlusMediaProxy$billing
		echo "\"">>iTelSwitchPlusMediaProxy$billing
		echo "/usr/local/iTelSwitchPlusMediaProxy$billing/shutdowniTelSwitchPlusMediaProxy.sh">>iTelSwitchPlusMediaProxy$billing
		echo "sleep 10">>iTelSwitchPlusMediaProxy$billing
		echo ";;">>iTelSwitchPlusMediaProxy$billing
		echo "restart)">>iTelSwitchPlusMediaProxy$billing
		var="\$0"
		echo "$var stop">>iTelSwitchPlusMediaProxy$billing
		echo "$var start">>iTelSwitchPlusMediaProxy$billing
		echo ";;">>iTelSwitchPlusMediaProxy$billing
		echo "*)">>iTelSwitchPlusMediaProxy$billing
		echo "echo \"Usage: $var {start|stop|restart}\"">>iTelSwitchPlusMediaProxy$billing
		echo "exit 1">>iTelSwitchPlusMediaProxy$billing
		echo "esac">>iTelSwitchPlusMediaProxy$billing
		echo "exit 0">>iTelSwitchPlusMediaProxy$billing
		#Media start file
		m="m";
		echo "cd /usr/local/iTelSwitchPlusMediaProxy$billing">runiTelSwitchPlusMediaProxy.sh
		echo "$var_jdk/bin/java -Xmx$var_media_memory$m -jar iTelSwitchPlusMediaProxy.jar $billing &">>runiTelSwitchPlusMediaProxy.sh
		#Media stop file
		echo "cd /usr/local/iTelSwitchPlusMediaProxy$billing">shutdowniTelSwitchPlusMediaProxy.sh
		echo "$var_jdk/bin/java -jar ShutDown.jar">>shutdowniTelSwitchPlusMediaProxy.sh
		cp iTelSwitchPlusMediaProxy$billing /etc/rc.d/init.d/
		chmod 755 /etc/rc.d/init.d/iTelSwitchPlusMediaProxy$billing
		#Media symbolic lilnk. writted into softlink.sh
		echo "chmod 755 /usr/local/iTelSwitchPlusMediaProxy$billing/runiTelSwitchPlusMediaProxy.sh">softlink.sh
		echo "chmod 755 /usr/local/iTelSwitchPlusMediaProxy$billing/shutdowniTelSwitchPlusMediaProxy.sh">>softlink.sh
		echo "cp -r iTelSwitchPlusMediaProxy$billing /etc/rc.d/init.d/">>softlink.sh
		echo "ln -s ../init.d/iTelSwitchPlusMediaProxy$billing /etc/rc.d/rc3.d/S99iTelSwitchPlusMediaProxy$billing">>softlink.sh
		echo "ln -s ../init.d/iTelSwitchPlusMediaProxy$billing /etc/rc.d/rc5.d/S99iTelSwitchPlusMediaProxy$billing">>softlink.sh
		echo "ln -s ../init.d/iTelSwitchPlusMediaProxy$billing /etc/rc.d/rc0.d/K10iTelSwitchPlusMediaProxy$billing">>softlink.sh
		echo "ln -s ../init.d/iTelSwitchPlusMediaProxy$billing /etc/rc.d/rc6.d/K10iTelSwitchPlusMediaProxy$billing">>softlink.sh
		cd ../iTelSwitchPlusSignaling$billing
		#Signaling start file
		m="m";
		echo "cd /usr/local/iTelSwitchPlusSignaling$billing">runiTelSwitchPlusSignaling.sh
		echo "$var_jdk/bin/java -Xmx$var_sig_memory$m -jar iTelSwitchPlusSignaling.jar $billing &">>runiTelSwitchPlusSignaling.sh
		#Signaling stop file
		echo "cd /usr/local/iTelSwitchPlusSignaling$billing">shutdowniTelSwitchPlusSignaling.sh
		echo "$var_jdk/bin/java -jar ShutDown.jar">>shutdowniTelSwitchPlusSignaling.sh
		#Signaling service file
		mv iTelSwitchPlusSignaling iTelSwitchPlusSignaling$billing
		echo "#!/bin/sh">iTelSwitchPlusSignaling$billing
		echo "## iTelSwitchPlusSignaling   This shell script takes care of starting and stopping iTelSwitchPlusSignaling">>iTelSwitchPlusSignaling$billing
		echo "# Source function library.">>iTelSwitchPlusSignaling$billing
		echo ". /etc/rc.d/init.d/functions">>iTelSwitchPlusSignaling$billing
		echo "#">>iTelSwitchPlusSignaling$billing
		var="\$1"
		echo "case \"$var\" in">>iTelSwitchPlusSignaling$billing
		echo "start)">>iTelSwitchPlusSignaling$billing
		echo "echo -n \"Starting iTelSwitchPlusSignaling....$billing:">>iTelSwitchPlusSignaling$billing
		echo "\"">>iTelSwitchPlusSignaling$billing
		echo "/usr/local/iTelSwitchPlusSignaling$billing/runiTelSwitchPlusSignaling.sh">>iTelSwitchPlusSignaling$billing
		echo ";;">>iTelSwitchPlusSignaling$billing
		echo "stop)">>iTelSwitchPlusSignaling$billing
		echo "echo -n \"Stoping iTelSwitchPlusSignaling.....$billing:">>iTelSwitchPlusSignaling$billing
		echo "\"">>iTelSwitchPlusSignaling$billing
		echo " /usr/local/iTelSwitchPlusSignaling$billing/shutdowniTelSwitchPlusSignaling.sh">>iTelSwitchPlusSignaling$billing
		echo "sleep 10">>iTelSwitchPlusSignaling$billing
		echo ";;">>iTelSwitchPlusSignaling$billing
		echo "restart)">>iTelSwitchPlusSignaling$billing
		var="\$0"
		echo "$var stop">>iTelSwitchPlusSignaling$billing
		echo "$var start">>iTelSwitchPlusSignaling$billing
		echo ";;">>iTelSwitchPlusSignaling$billing
		echo "*)">>iTelSwitchPlusSignaling$billing
		echo "echo \"Usage: $var {start|stop|restart}\"">>iTelSwitchPlusSignaling$billing
		echo "exit 1">>iTelSwitchPlusSignaling$billing
		echo "esac">>iTelSwitchPlusSignaling$billing
		echo "exit 0">>iTelSwitchPlusSignaling$billing
		cp iTelSwitchPlusSignaling$billing /etc/rc.d/init.d/
		chmod 755 /etc/rc.d/init.d/iTelSwitchPlusSignaling$billing
		#Signailng symbolic link. written into softlink.sh
		echo "chmod 755 /usr/local/iTelSwitchPlusSignaling$billing/runiTelSwitchPlusSignaling.sh">softlink.sh
		echo "chmod 755 /usr/local/iTelSwitchPlusSignaling$billing/shutdowniTelSwitchPlusSignaling.sh">>softlink.sh
		echo "cp -r iTelSwitchPlusSignaling$billing /etc/rc.d/init.d/">>softlink.sh
		echo "ln -s ../init.d/iTelSwitchPlusSignaling$billing /etc/rc.d/rc3.d/S99iTelSwitchPlusSignaling$billing">>softlink.sh
		echo "ln -s ../init.d/iTelSwitchPlusSignaling$billing /etc/rc.d/rc5.d/S99iTelSwitchPlusSignaling$billing">>softlink.sh
		echo "ln -s ../init.d/iTelSwitchPlusSignaling$billing /etc/rc.d/rc0.d/K10iTelSwitchPlusSignaling$billing">>softlink.sh
		echo "ln -s ../init.d/iTelSwitchPlusSignaling$billing /etc/rc.d/rc6.d/K10iTelSwitchPlusSignaling$billing">>softlink.sh
		#DatabaseConnection_Failed.xml
		echo "<CONNECTIONS>">DatabaseConnection_Failed.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///Failed$billing\"">>DatabaseConnection_Failed.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Failed.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Failed.xml
		echo "</CONNECTIONS>">>DatabaseConnection_Failed.xml
		#DatabaseConnection_Successful.xml
		echo "<CONNECTIONS>">DatabaseConnection_Successful.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///Successful$billing\"">>DatabaseConnection_Successful.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Successful.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Successful.xml
		echo "</CONNECTIONS>">>DatabaseConnection_Successful.xml
		#DatabaseConnection_Reseller.xml
		echo "<CONNECTIONS>">DatabaseConnection_Reseller.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///Successful$billing\"">>DatabaseConnection_Reseller.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Reseller.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Reseller.xml
		echo "</CONNECTIONS>">>DatabaseConnection_Reseller.xml
		#DatabaseConnection.xml
		echo "<CONNECTIONS>">DatabaseConnection.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///iTelBilling$billing?useEncoding=true&amp;characterEncoding=UTF-8\"">>DatabaseConnection.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
		echo "</CONNECTIONS>">>DatabaseConnection.xml
		#configuring web part
		rm -f /home/swp/$billing/WEB-INF/classes/*.xml
		cp -r *.xml /home/swp/$billing/WEB-INF/classes/
		#configuring log4j.properties
		rm -f /home/swp/$billing/WEB-INF/classes/log4j.properties
		rm -rf log4j;
		mkdir log4j;
		cd log4j;
		echo "# Define the root logger with appender file">log4j.properties
		echo "log4j.rootLogger = DEBUG, FILE">>log4j.properties
		echo "# Define the file appender">>log4j.properties
		echo "log4j.appender.FILE=org.apache.log4j.DailyRollingFileAppender">>log4j.properties
		echo "# Set the name of the file">>log4j.properties
		echo "log4j.appender.FILE.File=iTelBilling$billing.log">>log4j.properties
		echo "# Set the immediate flush to true (default)">>log4j.properties
		echo "log4j.appender.FILE.ImmediateFlush=true">>log4j.properties
		echo "# Set the threshold to debug mode">>log4j.properties
		echo "log4j.appender.FILE.Threshold=debug">>log4j.properties
		echo "# Set the append to false, should not overwrite">>log4j.properties
		echo "log4j.appender.FILE.Append=true">>log4j.properties
		echo "# Set the DatePattern">>log4j.properties
		echo "log4j.appender.FILE.DatePattern='.'yyyy-MM-dd">>log4j.properties
		echo "# Define the layout for file appender">>log4j.properties
		echo "log4j.appender.FILE.layout=org.apache.log4j.PatternLayout">>log4j.properties
		echo "log4j.appender.FILE.layout.conversionPattern=%m%n">>log4j.properties
		cp -r log4j.properties /home/swp/$billing/WEB-INF/classes/
		cd ..
		#-----------------server.cfg----------------------------------------
		echo  "configuring server.cfg";
		echo "";
		echo "-------------------sample-------------------";
		echo "";
		echo "#       Server.cfg configuration file"
		echo "# ___________________________________________"
		echo "#"
		echo "# ********** Server ***********"
		echo "orgBindIP=192.168.100.10"
		echo "orgBindPort=5060"
		echo "terBindIP=192.168.100.10"
		echo "terBindPort=600"
		echo "isRegistrar=yes"
		echo "doAuthentication=yes"
		echo "registraionSenderBindPort=91"
		echo "registrationReceiverIPList=192.168.100.10"
		echo "sendNotify=yes"
		echo "# ********** RTP & Timeouts  ***********"
		echo "#mediaProxyPublicIP=209.235.214.122";
		echo "mediaNode=192.168.100.10:62;"
		echo "mediaListenIP=192.168.100.10"
		echo "mediaListenPort=191"
		echo "-----------------------------------------------"
		#echo "orgBindIP"
		#read  orgBindIP;
		echo  "orgBindIP=$remoteSignalingIP"
		echo -n "orgBindPort: "
		read orgBindPort;
		while [[ ! $orgBindPort =~ ^[0-9]+$ ]]
			do
				echo -n "Please enter orgBindPort [Null/Invalid entry not accepted]: "
				read orgBindPort;
			done
		switch_port=$orgBindPort;
		echo -n "registraionSenderBindPort: "
		read registraionSenderBindPort;
		while [[ ! $registraionSenderBindPort =~ ^[0-9]+$ ]]
			do
				echo -n "Please enter registraionSenderBindPort [Null/Invalid entry not accepted]: "
				read registraionSenderBindPort;
			done
		echo "#       Proxy Server configuration file">config/server.cfg
		echo "# ___________________________________________">>config/server.cfg
		echo "#"
		echo "# ********** Server ***********">>config/server.cfg
		echo "orgBindIP=$remoteSignalingIP">>config/server.cfg
		echo "orgBindPort=$orgBindPort">>config/server.cfg
		echo "terBindIP=$remoteSignalingIP">>config/server.cfg
		echo "terBindPort=$orgBindPort">>config/server.cfg
		echo "isRegistrar=yes">>config/server.cfg
		echo "doAuthentication=yes">>config/server.cfg
		echo "registraionSenderBindPort=$registraionSenderBindPort">>config/server.cfg
		echo "registrationReceiverIPList=$remoteSignalingIP">>config/server.cfg
		echo "sendNotify=yes">>config/server.cfg
		echo "# ********** RTP & Timeouts  ***********">>config/server.cfg
		echo "#mediaProxyPublicIP=209.235.214.122">>config/server.cfg
		echo "mediaNode=$localListenIP:$localListenPort;">>config/server.cfg
		echo "mediaListenIP=$remoteSignalingIP">>config/server.cfg
		echo "mediaListenPort=$remoteSignalingPort">>config/server.cfg
		echo "pushSendTimeForNoResponseCallInSec=5">>config/server.cfg
		echo "maxNumberOfInviteRetransmissionForPinCall=16">>config/server.cfg
		echo "maxNumberOfMessageRetransmissionTimes=10">>config/server.cfg
		echo "registrationDebug=yes">>config/server.cfg
		cd ..
		if [ $x_64 -eq 1 ]
		 then
		  echo "$x_64: x86_64: configuraing 64-so...";
		  wget http://$var_installer_ip/downloads/SignalingProxy.so_64
		  wget http://$var_installer_ip/downloads/MediaProxy.so_64
		  mv MediaProxy.so_64 MediaProxy.so
		  mv SignalingProxy.so_64 SignalingProxy.so
		  rm -f iTelSwitchPlusMediaProxy$billing/MediaProxy.so
		  rm -f iTelSwitchPlusSignaling$billing/SignalingProxy.so
		  mv MediaProxy.so iTelSwitchPlusMediaProxy$billing
		  mv SignalingProxy.so iTelSwitchPlusSignaling$billing
		 else
		   echo "$x_64: x86_32. configuring 32-so...";
		 fi
		mv iTelSwitchPlusMediaProxy$billing /usr/local/
		mv iTelSwitchPlusSignaling$billing /usr/local/
		mv $billing /usr/local/jakarta-tomcat-$var_tomcat/webapps/
		#Media symbolic lilnk
		chmod 755 /usr/local/iTelSwitchPlusMediaProxy$billing/runiTelSwitchPlusMediaProxy.sh
		chmod 755 /usr/local/iTelSwitchPlusMediaProxy$billing/shutdowniTelSwitchPlusMediaProxy.sh
		ln -s ../init.d/iTelSwitchPlusMediaProxy$billing /etc/rc.d/rc3.d/S99iTelSwitchPlusMediaProxy$billing
		ln -s ../init.d/iTelSwitchPlusMediaProxy$billing /etc/rc.d/rc5.d/S99iTelSwitchPlusMediaProxy$billing
		ln -s ../init.d/iTelSwitchPlusMediaProxy$billing /etc/rc.d/rc0.d/K10iTelSwitchPlusMediaProxy$billing
		ln -s ../init.d/iTelSwitchPlusMediaProxy$billing /etc/rc.d/rc6.d/K10iTelSwitchPlusMediaProxy$billing
		#Signailng symbolic link
		chmod 755 /usr/local/iTelSwitchPlusSignaling$billing/runiTelSwitchPlusSignaling.sh
		chmod 755 /usr/local/iTelSwitchPlusSignaling$billing/shutdowniTelSwitchPlusSignaling.sh
		ln -s ../init.d/iTelSwitchPlusSignaling$billing /etc/rc.d/rc3.d/S99iTelSwitchPlusSignaling$billing
		ln -s ../init.d/iTelSwitchPlusSignaling$billing /etc/rc.d/rc5.d/S99iTelSwitchPlusSignaling$billing
		ln -s ../init.d/iTelSwitchPlusSignaling$billing /etc/rc.d/rc0.d/K10iTelSwitchPlusSignaling$billing
		ln -s ../init.d/iTelSwitchPlusSignaling$billing /etc/rc.d/rc6.d/K10iTelSwitchPlusSignaling$billing
		switch_end_time=$(date +%s);
		time_elapsed=$((switch_end_time - switch_start_time));
		minute=`expr $time_elapsed / 60`;
		sec=`expr $time_elapsed % 60`;
		echo "------Finish> Total time to complete installation process: $minute min $sec secs-------";
		sleep 2;
		#service  iTelSwitchPlusSignaling$billing start
		#service  iTelSwitchPlusMediaProxy$billing start
		cd /usr/local/iTelSwitchPlusSignaling$billing/
		wget http://$var_installer_ip/downloads/MailAlert.jar
		echo "AdditionalToAddress=support@revesoft.com">>config/emailInfo.cfg
		echo "FromAddress=noreply-support@revesoft.com">>config/emailInfo.cfg
		echo "MailServer=mail.revesoft.com">>config/emailInfo.cfg
		echo "MailSeverPort=2525">>config/emailInfo.cfg
		echo "needAuthenticationFromMailServer=yes">>config/emailInfo.cfg
		echo "authenticationEmailAddress=noreply-support@revesoft.com">>config/emailInfo.cfg
		echo "authenticationEmailPassword=ChangeDPasS01032016#">>config/emailInfo.cfg
		echo "MailSubject=Switch Down alert">>config/emailInfo.cfg
		echo "MailContent=Dear Support,\n  Here is the information about Switch Down: \n Switch IP: $remoteSignalingIP \n Signaling Location: /usr/local/iTelSwitchPlusSignaling$billing \n\nRegards,\niTelSwitchMonitoring Team.">>config/emailInfo.cfg
		echo -e "${Blue}###########################################################################";
		echo "#                                                                         #";
		echo "#                          Summary                                        #";
		echo "#-------------------------------------------------------------------------#";
		echo "#   Billing  : http://$remoteSignalingIP/$billing                         #";
		echo "#   User     : $var_user                                                  #";
		echo "#   Password : $admin_pass                                                #";
		echo "#   Switch ip: $remoteSignalingIP                                         #";
		echo "#   Port     : $orgBindPort                                               #";
		echo "#   Media    : iTelSwitchPlusMediaProxy$billing                           #";
		echo "#   Signaling: iTelSwitchPlusSignaling$billing                            #";
		echo "#   Databases: iTelBilling$billing, Successful$billing, Failed$billing    #";
		echo "#                                                                         #";
		echo -e "###########################################################################${NC}";
		#switch delivery email
		echo "billing=$billing">/home/swp/deliveryEmail.cfg
		echo "salesEmail=$var_sales_email">>/home/swp/deliveryEmail.cfg
		echo "customerEmail=$email">>/home/swp/deliveryEmail.cfg
		echo "supportEmail=support@itelbilling.com">>/home/swp/deliveryEmail.cfg
		echo "billingURL=http://$remoteSignalingIP/$billing">>/home/swp/deliveryEmail.cfg
		echo "switchIP=$remoteSignalingIP">>/home/swp/deliveryEmail.cfg
		echo "switchPORT=$orgBindPort">>/home/swp/deliveryEmail.cfg
		echo "IVRExt=101">>/home/swp/deliveryEmail.cfg
		echo "balanceLink=http://$remoteSignalingIP/$billing/getclientbalance.do?pin=REPLACE">>/home/swp/deliveryEmail.cfg
		echo "installedBy=$var_installedBy;">>/home/swp/deliveryEmail.cfg
		#admin_pass="admin";
		echo "iTelBilling$billing;">/home/swp/db.txt
		echo "Successful$billing;">>/home/swp/db.txt
		echo "Failed$billing;">>/home/swp/db.txt
		echo "$remoteSignalingIP;">>/home/swp/db.txt
		echo "$registraionSenderBindPort;">>/home/swp/db.txt
		echo "$var_user;">>/home/swp/db.txt
		echo "$admin_pass;">>/home/swp/db.txt
		echo "$orgBindPort;">>/home/swp/db.txt
		echo "$email;">>/home/swp/db.txt
		echo "$var_billing_v;">>/home/swp/db.txt
		#echo "$var_sw_callvolume;">>/home/swp/db.txt
		echo "$billing;">>/home/swp/db.txt
		echo "iTelSwitchPlusMediaProxy$billing;">>/home/swp/db.txt
		echo "$remoteSignalingIP;">/home/swp/track.txt
		echo "$rtpStartPort;">>/home/swp/track.txt
		echo "$rtpEndPort;">>/home/swp/track.txt
		echo "$orgBindPort;">>/home/swp/track.txt
		echo "$orgBindPort,$registraionSenderBindPort,$localListenPort,$remoteSignalingPort;">>/home/swp/track.txt
		echo "$billing;">>/home/swp/track.txt
		echo "$var_ref;">>/home/swp/track.txt
		echo "$var_sales;">>/home/swp/track.txt
		echo "$var_installedBy;">>/home/swp/track.txt
		echo "$var_media_v;">>/home/swp/track.txt
		echo "$var_signaling_v;">>/home/swp/track.txt
		echo "$var_web_v;">>/home/swp/track.txt
		echo "http://$remoteSignalingIP/$billing;">/home/swp/email.txt
		echo "$remoteSignalingIP;">>/home/swp/email.txt
		echo "$orgBindPort;">>/home/swp/email.txt
		echo "$var_media_v;">>/home/swp/email.txt
		echo "$var_signaling_v;">>/home/swp/email.txt
		echo "$var_web_v;">>/home/swp/email.txt
		echo "$var_ref;">>/home/swp/email.txt
		echo "$var_sales;">>/home/swp/email.txt
		echo "$var_installedBy;">>/home/swp/email.txt
		echo "iTelSwitchPlusMediaProxy$billing;">>/home/swp/email.txt
		echo "iTelSwitchPlusSignaling$billing;">>/home/swp/email.txt
		echo "$var_user;">>/home/swp/email.txt
		echo "$admin_pass;">>/home/swp/email.txt
		if [ $flg_n_sw -eq 0 ]
		 then
		  flg_n_sw=1;
		  cd /usr/
		  fn_6jdk
		  #echo -e "\n\n\n\n\n\n\n\n${Black} ################## ${BRed}:: Installing JDK :: ${Black}################${NC}#";
		  #wget http://$var_installer_ip/downloads/jdk6.0_25.tar.gz
		  #echo "Extracting 1.6.0_25........."
		  #tar -zxf jdk6.0_25.tar.gz
		  echo "Extracted Successfully!!!"
		  rm -rf jdk6.0_25.tar.gz
		  rm -rf /usr/local/installerjar
		  #mkdir /usr/local/installerjar
		  rm -rf  /usr/local/src/installerjar
		  mkdir /usr/local/src/installerjar
		  cd /usr/local/src/installerjar
		  wget http://$var_installer_ip/downloads/newinstaller.jar
		  wget http://$var_installer_ip/downloads/liteswitchdelivery.jar
		  wget http://$var_installer_ip/downloads/rateplan.csv
		  wget http://$var_installer_ip/downloads/Lite_logo.png
		  wget http://$var_installer_ip/downloads/ShutDown.jar
		  #installer start file
		  echo "cd /usr/local/src/installerjar">runInstaller.sh
		  echo "/usr/jdk1.6.0_25/bin/java -Xmx4096m -jar newinstaller.jar &">>runInstaller.sh
		  echo "cd /usr/local/src/installerjar">runSwitchDelivery.sh
		  echo "$var_jdk/bin/java -Xmx400m -jar liteswitchdelivery.jar &">>runSwitchDelivery.sh
		  echo "cd /usr/local/src/installerjar">shutDownInstaller.sh
		  echo "$var_jdk/bin/java -jar ShutDown.jar &">>shutDownInstaller.sh
		  #log4j.properties
		  echo "l#Default log level to ERROR. Other levels are INFO and DEBUG.">log4j.properties
		  echo "log4j.rootLogger=, ROOT">>log4j.properties
		  echo "log4j.appender.ROOT=org.apache.log4j.RollingFileAppender">>log4j.properties
		  echo "log4j.appender.ROOT.File= installer.log">>log4j.properties
		  echo "log4j.appender.ROOT.MaxFileSize=8MB">>log4j.properties
		  echo "#Keep 5 old files around.">>log4j.properties
		  echo "log4j.appender.ROOT.MaxBackupIndex=0">>log4j.properties
		  echo "log4j.appender.ROOT.layout=org.apache.log4j.PatternLayout">>log4j.properties
		  echo "#Format almost same as WebSphere's common log format.">>log4j.properties
		  echo "log4j.appender.ROOT.layout.ConversionPattern=%-4r %-5p [%t] (%x) - %m\n">>log4j.properties
		  echo "#Optionally override log level of individual packages or classes">>log4j.properties
		  echo "#log4j.logger.com.webage.ejbs=INFO">>log4j.properties
		   #DatabaseConnection.xml
		   echo "<CONNECTIONS>">DatabaseConnection.xml
		   echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///mysql\"">>DatabaseConnection.xml
		   echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
		   echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
		   echo "</CONNECTIONS>">>DatabaseConnection.xml
		   chmod a+x runInstaller.sh
		   chmod a+x runSwitchDelivery.sh
		   chmod a+x shutDownInstaller.sh
		   sh runInstaller.sh
		 else
		   cd /usr/local/src/installerjar
		   chmod a+x runInstaller.sh
		   chmod a+x shutDownInstaller.sh
		   sh runInstaller.sh
		fi
		echo "---------------------------------------------------------------------------------------";
		echo "Other module will start now...Please wait...";
		echo "---------------------------------------------------------------------------------------";
		echo "........................................................................................"
		sleep 30;
		clear;
		flg_mb=1;
		#Mobile billing
		echo -n "Do you want to install mobile billing? y/n: "
		read yorn;
		while [ -z "${yorn}" ]
			do
				echo -n "Please enter your Choice [Null/Invalid entry not accepted]: "
				read yorn;
			done
		#yorn=y;
		if [ $yorn == y ]
		  then
		   echo "Installing mobile billing now..."
		   #install mobile billing
		   fn_mobileBilling ;
		else
		 echo "mobile billing skipped"
		fi
		sleep 10;
		clear;
		flg_mt=1;
		yorn=n;
		#Mobile top up
		#echo -n "Do you want to install mobile top up? y/n: "
		#read yorn;
		#sleep 10;
		#rm -f /home/installer.log;
		#cd /usr/local/src/installerjar;
		#mv  installer.log  /home/
		#rm -rf  /usr/local/src/installerjar
		clear;
		echo "------System maintenance installation will start. Please wait...--------";
		sleep 3;
		echo "------System maintenance installation will start. Please wait...--------";
		flg_sm=1;
		fn_system_Maintenance;
		sleep 8;
		echo "------DB Health Checker installation will start. Please wait...--------";
		sleep 2;
		flg_DH=1;
		fn_DBHealthChecker;
		sleep 8;
		clear;
		echo "";
		echo "Below summary will add into delivery email.";
		echo "-------------------------------------------";
		echo "";
		cat /home/swp/deliveryEmail.cfg
		echo "";
		echo -n "Do you want to send email? y/n: ";
		read yorn;
		while [ -z "${yorn}" ]
			do
				echo -n "Please enter your Choice [Null/Invalid entry not accepted]: "
				read yorn;
			done
		if [ $yorn == y ]
		 then
		   clear;
		   echo "";
		   echo "Sending email...Please wait...";
		   cd /usr/local/src/installerjar;
		   sh runSwitchDelivery.sh
		else
		  echo "Email Sending skipped.";
		fi
}
function fn_replication(){
		#!/bin/bash
	####Replication Checker Installation####
		# #No Colors
		# 	NC='${NC}'              # Text Reset/No Color
		# # Regular Colors
		# 	Black='\033[0;100m'       # Black
		# 	Red='\033[0;31m'          # Red
		# 	Green='\033[0;32m'        # Green
		# 	# Bold
		# 	BBlack='\033[1;100m'      # Black
		# 	BRed='\033[1;31m'         # Red
		# 	BGreen='\033[1;32m'       # Green
	echo -e "\n\n\n\n\n\n\n\n${Black} ################## ${BRed}:: Replication Checker Installation :: ${Black}################${NC}#";
	read -p "Slave Server IP: "  SLVAVEIP
	IP_Check $SLVAVEIP;
	read -p "Please provide free port: "  checker_port
	#while [ "$found" != "y" ]
	#do
	#	read -p "Please provide valid slave Server IP: "  SLVAVEIP
	#
	#	IP_Check $SLVAVEIP;
	#done
	read -p "mysql folder name: "  MYSQLFOLDER
	pattern="iTel"
	path="/usr/local/$MYSQLFOLDER/$MYSQLFOLDER.cnf"
	b=$(cat "$path" | grep "port" )
	for _dir in /usr/local/"${MYSQLFOLDER}"/var/"${pattern}"*; do
	[ -d "${_dir}" ] && dir="${_dir}"
		itelDB="$(basename "${dir}")"
	done
	while [ -z "${itelDB}" ]
		do
			echo "Folder name invalid. Provide valid folder"
			read -p "mysql folder name: "  MYSQLFOLDER
			for _dir in /usr/local/"${MYSQLFOLDER}"/var/"${pattern}"*; do
				[ -d "${_dir}" ] && dir="${_dir}"
					itelDB="$(basename "${dir}")"
				done
			path="/usr/local/$MYSQLFOLDER/$MYSQLFOLDER.cnf"
			b=$(cat "$path" | grep "port" )
	done
	SLVAVEPORT=${b#port=} SLVAVEPORT=${SLVAVEPORT%% *}
	#Step 1: Downloading Resource:
	cd /usr/local
	rm -rf ReplicationChecker_mysqlrep_REF.zip
	echo "Downloding Replication checker......"
	wget http://$var_installer_ip/downloads/ReplicationChecker_mysqlrep_REF.zip	>> $LOGFILE
	echo "Replication checker Downloaded!!!"
	echo "Extracting Replication Checker........"
	unzip -q ReplicationChecker_mysqlrep_REF.zip >> $LOGFILE
	echo "Replication Checker Extracted!!"
	#Step 2: Changing folder and file name:
	mv ReplicationChecker_mysqlrep_REF ReplicationChecker_$MYSQLFOLDER
	cd ReplicationChecker_$MYSQLFOLDER
	rm -f email_propertiese
	mv ReplicationChecker_mysqlrep_REF ReplicationChecker_$MYSQLFOLDER
	sed -i "s/iTelBillingmoshhud/$itelDB/g" DatabaseConnection.xml
	sed -i "s/iTelBillingmoshhud/$itelDB/g" DatabaseConnection_PinProtector.xml
	sed -i "s/3308/$SLVAVEPORT/g" DatabaseConnection.xml
	old_DB="$(cat DatabaseConnection.xml | grep 'DATABASE_URL')"
	new_DB="$(echo $old_DB | awk -F"[0-9]/" '{print $2}')"
	database="${new_DB%?}"
	port="$(echo $old_DB | awk -F"127.0.0.1:" '{print $2}' | grep -o '[[:digit:]]*')"
	port="$(echo $port | awk '{print $1}')"
	process="$(lsof -i tcp:$port | grep mysqld | awk '{print $2}' | head -n1)"
	path="$(lsof -p $process | grep cwd | head -n1 | awk '{print $9}')"
	masterIP="$(sed -n '4p' $path/master.info)"
	mysql_user="$(sed -n '5p' $path/master.info)"
	mysql_pass="$(sed -n '6p' $path/master.info)"
	sed -i "s/iTelBillingmoshhud/$database/g" DatabaseConnection_PinProtector.xml
	sed -i "s/moshhud/$mysql_user/g" DatabaseConnection_PinProtector.xml
	sed -i "s/56028Nb/$mysql_pass/g" DatabaseConnection_PinProtector.xml
	sed -i "s/43.240.101.55/$masterIP/g" DatabaseConnection_PinProtector.xml
	sed -i "s/43.240.101.55/$SLVAVEIP/g" config.cfg
	sed -i "s/220/$checker_port/g" config.cfg
	sed -i "s/ReplicationChecker_mysqlrep_REF/ReplicationChecker_$MYSQLFOLDER/g" ReplicationChecker_$MYSQLFOLDER runReplicationChecker.sh shutdownReplicationChecker.sh soft.sh
	sed -i "s/itelbilling/$MYSQLFOLDER/g" runReplicationChecker.sh
	#Step 3: Run softlink and start service
	sh soft.sh
	service ReplicationChecker_$MYSQLFOLDER start
	cd /usr/local
	rm -rf ReplicationChecker_mysqlrep_REF.zip
}
function fn_help(){
 echo "Help???";
}
function time_out(){
	#echo "echo \"timer start\"">/home/timeout
	echo "sleep 3600">/home/timeout
	#echo "echo \"timer stop\"">>/home/timeout
	echo "find / -name installer  >/home/inst">>/home/timeout
	echo "find / -name installerjar  >>/home/inst">>/home/timeout
	echo "find / -name byteSaverTracker  >>/home/inst">>/home/timeout
	echo "find / -name iTelSwitchRecycler  >>/home/inst">>/home/timeout
	echo "var=\$(</home/inst)">>/home/timeout
	echo "rm -rf \$var">>/home/timeout
	chmod a+x /home/timeout;
	cd /home;
	./timeout &
}
function fn_server_info(){
	#!/bin/bash
	os=`cat /etc/redhat-release`
	numCPU=`cat /proc/cpuinfo | grep -c processor`
	numPhys=`cat /proc/cpuinfo | grep "physical id" | sort -n | uniq | wc -l`
	numCores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | awk '{print $NF}'`
	modelName=`cat /proc/cpuinfo | grep "model name" | uniq `
	memory=`free -m | grep Mem | awk '{print $2}'`
	df -hT > /hdd
	HDD=`awk '{for (I=1;I<=NF;I++) if ($I == "ext4") {print $(I+1)};}'   /hdd | head -1`
	#HDD=`df -hT | grep ext | awk '{print $3}' | head -1`
	RAID=`cat /proc/mdstat | grep  Personalities`
	cat /proc/cpuinfo | grep -q "ht"
	isHT=$?
	numThrd=1
	if [ $isHT -eq 0 ];then
		numThrd=2
	fi
	sibs=$(($numCores * $numThrd))
	socks=$(($numCPU / $sibs))
	ARR[1]="Physical sockets: $socks"
	case $numThrd in
		1)
		ARR[2]="Hyperthreading: Disabled"
		;;
		2)
		ARR[2]="Hyperthreading: Enabled"
		;;
	esac
	ARR[3]="Total CPU cores: $numCPU"
	ARR[4]="CPU cores (excepts hyperthreads): $numCores"
	ARR[5]=$modelName
	ARR[6]="RAM: $memory M"
	ARR[7]="HDD: $HDD"
	ARR[8]="RAID: $RAID"
	ARR[9]="OS info: $os"
	for i in $(seq 0 ${#ARR[*]}); do
		echo "${ARR[i]}";
	done
}
function fn_about(){
		date '+%d/%m/%y %H:%M%S'>time
		var_date_time=$(<time);
		date '+%d/%m/%y %H:%M:%S'>time
		var_date_time=$(<time);
		echo -e "\033[34m###########################################################################";
		echo "#                                                                         #";
		echo "#                          About                                          #";
		echo "#-------------------------------------------------------------------------#";
		echo "#   Author                # Moshhud Ahmed                                 #";
		echo "#   Version               $version                                           #";
		echo "#   Modified              $modified                   #";
		echo "#   Updated By            # Mirza Golam Abbas Shahneel                    #";
		echo "#   Current date and time # $var_date_time                             #";
		echo "#                                                                         #";
		echo -e "###########################################################################${NC}";
}
function fn_ipchanger(){
	#check architecture
	#uname -m |  grep x86_64 && x_64=1 || x_64=0
	fn_arch;
	var_interval=10;
	var_lost=25;
	IntervalOnNoLoss=240;
	#unzip
	fn_unzip;
	#jdk
	if [ $flg_jdk -eq 0 ];then
		fn_jdk;
	else
		echo "JDK: $var_jdk"
	fi
	echo -n "Enter operator code: ";
	read opCode;
	while [ -z "${opCode}" ];do
		echo -n "Please enter valid folder [Null/Invalid entry not accepted]: "
		read opCode
	done
	dir=/usr/local/ByteSaverMediaProxy"${opCode}"
	if [ -d "${dir}" ];then
		echo "Sample IP changer properties file: IPChangerProperties.cfg"
		echo "-----------------------------------------------------"
		echo "enableMailSending= 1"
		echo "smtpServer= mail.revesoft.com"
		echo "smtpPort= 2525"
		echo "fromEmail= noreply-support@revesoft.com"
		echo "fromEmailPassword= 123abc"
		echo "toEmail=support@revesoft.com"
		echo "mediaProxyConfigFile= /usr/local/ByteSaverMediaProxy$opCode/rtpProperties.cfg"
		echo "testingTimeInereval=$var_interval"
		echo "packetLossLimitToChangeIP=$var_lost"
		echo "handsetOSList= IPHONE,SYMBIAN,ANDROID"
		echo "voiceListenIPList= 159.253.152.64,159.253.152.65,159.253.152.66,159.253.152.67"
		echo "mediaProxyPublicIPList= 159.253.152.64,159.253.152.65,159.253.152.66,159.253.152.67"
		echo "operatorCodeList=R77140,R96921,R66184"
		echo "-----------------------------------------------------"
		echo -n "Enter IP Changer IP: ";
		read serverIP;
		echo -n "Enter IP Changer Port (Any free port): ";
		read sPort;
		echo -n "Enter voiceListenIPList(separated by comma(,)): ";
		read VLIP;
		echo -n "Enter mediaProxyPublicIPList(separated by comma(,)): ";
		read publicIP;
		echo -n "Enter Server ID: ";
		read serverID;
		#echo -n "Enter Regional operatorCodeList(separated by comma(,)): ";
		#read operatorCodeList
		cd /home/
		rm -rf ipc
		mkdir ipc
		cd ipc
		echo "IPChanger$opCode;">/home/ipc/db.txt;
		echo "ByteSaverSignalConverter$opCode;">>/home/ipc/db.txt;
		wget http://$var_installer_ip/downloads/IPChanger.zip
		unzip IPChanger.zip
		mv IPChanger  IPChanger$opCode
		rm -f IPChanger.zip
		cd IPChanger$opCode
		mv Sql  /home/ipc/
		#sh file configuration
		echo "cd /usr/local/IPChanger$opCode">runAMIPChanger.sh
		echo "$var_jdk/bin/java -Xmx768m -jar -jar AutoMediaIPChanger.jar $opCode &">>runAMIPChanger.sh
		echo "cd /usr/local/IPChanger$opCode">shutdownAMIPChanger.sh
		echo "$var_jdk/bin/java -jar IPCShutdown.jar">>shutdownAMIPChanger.sh
		#DatabaseConnection.xml
		echo "<CONNECTIONS>">DatabaseConnection.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///IPChanger$opCode\"">>DatabaseConnection.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
		echo "</CONNECTIONS>">>DatabaseConnection.xml
		echo "configurationLoaderIp=208.74.76.16">>IPChangerProperties.cfg
		echo "configurationLoaderPort=4444">>IPChangerProperties.cfg
		echo "serverIP=$serverIP">>IPChangerProperties.cfg
		echo "serverPort=$sPort">>IPChangerProperties.cfg
		echo "enableMailSending=0">>IPChangerProperties.cfg
		echo "enableREVEMailServer=1">>IPChangerProperties.cfg
		echo "smtpServer=mail.revesoft.com">>IPChangerProperties.cfg
		echo "smtpPort=2525">>IPChangerProperties.cfg
		echo "fromEmail=test@revesoft.com">>IPChangerProperties.cfg
		echo "fromEmailPassword=test">>IPChangerProperties.cfg
		echo "toEmail=support@revesoft.com">>IPChangerProperties.cfg
		echo "mediaProxyConfigFile=/usr/local/ByteSaverMediaProxy$opCode/rtpProperties.cfg">>IPChangerProperties.cfg
		echo "signalingConfigFile=/usr/local/ByteSaverSignalConverter$opCode/server.cfg">>IPChangerProperties.cfg
		echo "testingTimeInereval=$var_interval">>IPChangerProperties.cfg
		echo "ipChangeIntervalOnNoLoss=$IntervalOnNoLoss">>IPChangerProperties.cfg
		echo "packetLossLimitToChangeIP=$var_lost">>IPChangerProperties.cfg
		echo "handsetOSList=IPHONE,SYMBIAN,ANDROID">>IPChangerProperties.cfg
		echo "voiceListenIPList=$VLIP">>IPChangerProperties.cfg
		echo "mediaProxyPublicIPList=$publicIP">>IPChangerProperties.cfg
		echo "operatorCodeList=R77140,R96921,R66184,R61642,R61674,R78608,R79742">>IPChangerProperties.cfg
		echo "operatorCode=$opCode">>IPChangerProperties.cfg
		echo "serverID=$serverID">>IPChangerProperties.cfg
		##Changing IP Changer status in Signaling
		sed -e  "s/enableIPChanger=0/enableIPChanger=1/g" /usr/local/ByteSaverSignalConverter$opCode/server.cfg
		#rm -f IPChanger.so
		#if [ $x_64 -eq 1 ]
		#     then
		#      echo "$x_64: x86_64: configuraing 64-so...";
		#      mv IPChanger.so_64 IPChanger.so
		#     else
		#       echo "$x_64: x86_32. configuring 32-so...";
		#	   mv IPChanger.so_32 IPChanger.so
		#fi
		#Service file
		echo "#!/bin/sh">IPChanger$opCode
		echo "## IPChanger   This shell script takes care of starting and stopping IPChanger">>IPChanger$opCode
		echo "# Source function library.">>IPChanger$opCode
		echo ". /etc/rc.d/init.d/functions">>IPChanger$opCode
		echo "#">>IPChanger$opCode
		var="\$1"
		echo "case \"$var\" in">>IPChanger$opCode
		echo "start)">>IPChanger$opCode
		echo "echo -n \"Starting IPChanger$opCode: ">>IPChanger$opCode
		echo "\"">>IPChanger$opCode
		echo "/usr/local/IPChanger$opCode/runAMIPChanger.sh">>IPChanger$opCode
		echo ";;">>IPChanger$opCode
		echo "stop)">>IPChanger$opCode
		echo "echo -n \"Stoping IPChanger$opCode:">>IPChanger$opCode
		echo "\"">>IPChanger$opCode
		echo " /usr/local/IPChanger$opCode/shutdownAMIPChanger.sh">>IPChanger$opCode
		echo "sleep 2">>IPChanger$opCode
		echo ";;">>IPChanger$opCode
		echo "restart)">>IPChanger$opCode
		var="\$0"
		echo "$var stop">>IPChanger$opCode
		echo "$var start">>IPChanger$opCode
		echo ";;">>IPChanger$opCode
		echo "*)">>IPChanger$opCode
		echo "echo \"Usage: $var {start|stop|restart}\"">>IPChanger$opCode
		echo "exit 1">>IPChanger$opCode
		echo "esac">>IPChanger$opCode
		echo "exit 0">>IPChanger$opCode
		cp IPChanger$opCode /etc/rc.d/init.d/
		chmod 755 /etc/rc.d/init.d/IPChanger$opCode
		ln -s /etc/rc.d/init.d/IPChanger$opCode /etc/rc.d/rc3.d/S99IPChanger$opCode
		ln -s /etc/rc.d/init.d/IPChanger$opCode /etc/rc.d/rc5.d/S99IPChanger$opCode
		ln -s /etc/rc.d/init.d/IPChanger$opCode /etc/rc.d/rc0.d/K10IPChanger$opCode
		ln -s /etc/rc.d/init.d/IPChanger$opCode /etc/rc.d/rc6.d/K10IPChanger$opCode
		cd /home/ipc
		mv IPChanger$opCode /usr/local/
		#DatabaseConnection.xml
		echo "<CONNECTIONS>">DatabaseConnection.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///IPChanger$opCode\"">>DatabaseConnection.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
		echo "</CONNECTIONS>">>DatabaseConnection.xml
		cp -r DatabaseConnection.xml /usr/local/ByteSaverSignalConverter$opCode/
		chmod 755 /etc/rc.d/init.d/IPChanger$opCode
		service IPChanger$opCode start
		fn_IPChangerDB;
	else
		echo "Byte Saver Media Does not exist"
		echo "Please try with valid Byte Saver media prefix"
		echo "We are exiting installation"
	fi
}
function fn_IPChangerDB(){
	cd /usr/local/src/
	rm -f MediaIPChanger.zip
	rm -rf MediaIPChanger
	wget http://$var_installer_ip/downloads/MediaIPChanger.zip
	unzip MediaIPChanger.zip
	cd MediaIPChanger
	chmod a+x runApps.sh
	fn_6jdk;
	sh runApps.sh
}
function fn_ipchangerdp(){
	#check architecture
	#uname -m |  grep x86_64 && x_64=1 || x_64=0
	fn_arch;
	var_interval=10;
	var_lost=25;
	IntervalOnNoLoss=240;
	#unzip
	fn_unzip;
	#jdk
	if [ $flg_jdk -eq 0 ];then
		fn_jdk;
	else
		echo "JDK: $var_jdk"
	fi
	echo -n "Enter Media Suffix: ";
	read opCode;
	echo -n "Enter voiceListenIPList(separated by comma(,)): ";
	read VLIP;
	echo -n "Enter mediaProxyPublicIPList(separated by comma(,)): ";
	read publicIP;
	cd /home/
	rm -rf ipc
	mkdir ipc
	cd ipc
	echo "IPChanger$opCode;">/home/ipc/db.txt;
	echo "ByteSaverSignalConverter$opCode;">>/home/ipc/db.txt;
	wget http://$var_installer_ip/downloads/IPChanger.zip
	unzip IPChanger.zip
	mv IPChanger  IPChanger$opCode
	rm -f IPChanger.zip
	cd IPChanger$opCode
	mv Sql  /home/ipc/
	#sh file configuration
	echo "cd /usr/local/IPChanger$opCode">runAMIPChanger.sh
	echo "$var_jdk/bin/java -Xmx512m -jar  AutoMediaIPChanger.jar $opCode &">>runAMIPChanger.sh
	echo "cd /usr/local/IPChanger$opCode">shutdownAMIPChanger.sh
	echo "$var_jdk/bin/java -jar IPCShutdown.jar">>shutdownAMIPChanger.sh
	#DatabaseConnection.xml
	echo "<CONNECTIONS>">DatabaseConnection.xml
	echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///IPChanger$opCode\"">>DatabaseConnection.xml
	echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
	echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
	echo "</CONNECTIONS>">>DatabaseConnection.xml
	echo "Sample IP changer properties file: IPChangerProperties.cfg"
	echo "-----------------------------------------------------"
	echo "enableMailSending= 1"
	echo "smtpServer=mail.revesoft.com"
	echo "smtpPort=2525"
	echo "fromEmail=noreply-support@revesoft.com"
	echo "fromEmailPassword=123abc"
	echo "toEmail=support@revesoft.com"
	echo "mediaProxyConfigFile=/usr/local/ByteSaverMediaProxy$opCode/rtpProperties.cfg"
	echo "testingTimeInereval=$var_interval"
	echo "packetLossLimitToChangeIP=$var_lost"
	echo "handsetOSList= SYMBIAN,ANDROID"
	echo "voiceListenIPList= 159.253.152.64,159.253.152.65,159.253.152.66,159.253.152.67"
	echo "operatorCodeList=R77140,R96921,R66184"
	echo "-----------------------------------------------------"
	echo "enableMailSending=1">IPChangerProperties.cfg
	echo "smtpServer=mail.revesoft.com">>IPChangerProperties.cfg
	echo "smtpPort=2525">>IPChangerProperties.cfg
	echo "fromEmail=noreply-support@revesoft.com">>IPChangerProperties.cfg
	echo "fromEmailPassword=EmailNotifY2003#">>IPChangerProperties.cfg
	echo "toEmail=support@revesoft.com">>IPChangerProperties.cfg
	echo "mediaProxyConfigFile=/usr/local/ByteSaverMediaProxy$opCode/rtpProperties.cfg">>IPChangerProperties.cfg
	echo "signalingConfigFile=/usr/local/ByteSaverSignalConverter$opCode/server.cfg">>IPChangerProperties.cfg
	echo "testingTimeInereval=$var_interval">>IPChangerProperties.cfg
	echo "ipChangeIntervalOnNoLoss=$IntervalOnNoLoss">>IPChangerProperties.cfg
	echo "packetLossLimitToChangeIP=$var_lost">>IPChangerProperties.cfg
	echo "handsetOSList=SYMBIAN,ANDROID">>IPChangerProperties.cfg
	echo "voiceListenIPList=$VLIP">>IPChangerProperties.cfg
	echo "mediaProxyPublicIPList=$publicIP">>IPChangerProperties.cfg
	echo "operatorCodeList=R77140,R96921,R66184">>IPChangerProperties.cfg
	echo "serverID=101">>IPChangerProperties.cfg
	rm -f IPChanger.so
	if [ $x_64 -eq 1 ];then
		echo "$x_64: x86_64: configuraing 64-so...";
		mv IPChanger.so_64 IPChanger.so
	else
		echo "$x_64: x86_32. configuring 32-so...";
		mv IPChanger.so_32 IPChanger.so
	fi
	#Service file
	echo "#!/bin/sh">IPChanger$opCode
	echo "## IPChanger   This shell script takes care of starting and stopping IPChanger">>IPChanger$opCode
	echo "# Source function library.">>IPChanger$opCode
	echo ". /etc/rc.d/init.d/functions">>IPChanger$opCode
	echo "#">>IPChanger$opCode
	var="\$1"
	echo "case \"$var\" in">>IPChanger$opCode
	echo "start)">>IPChanger$opCode
	echo "echo -n \"Starting IPChanger$opCode: ">>IPChanger$opCode
	echo "\"">>IPChanger$opCode
	echo "/usr/local/IPChanger$opCode/runAMIPChanger.sh">>IPChanger$opCode
	echo ";;">>IPChanger$opCode
	echo "stop)">>IPChanger$opCode
	echo "echo -n \"Stoping IPChanger$opCode:">>IPChanger$opCode
	echo "\"">>IPChanger$opCode
	echo " /usr/local/IPChanger$opCode/shutdownAMIPChanger.sh">>IPChanger$opCode
	echo "sleep 2">>IPChanger$opCode
	echo ";;">>IPChanger$opCode
	echo "restart)">>IPChanger$opCode
	var="\$0"
	echo "$var stop">>IPChanger$opCode
	echo "$var start">>IPChanger$opCode
	echo ";;">>IPChanger$opCode
	echo "*)">>IPChanger$opCode
	echo "echo \"Usage: $var {start|stop|restart}\"">>IPChanger$opCode
	echo "exit 1">>IPChanger$opCode
	echo "esac">>IPChanger$opCode
	echo "exit 0">>IPChanger$opCode
	cp IPChanger$opCode /etc/rc.d/init.d/
	chmod 755 /etc/rc.d/init.d/IPChanger$opCode
	ln -s /etc/rc.d/init.d/IPChanger$opCode /etc/rc.d/rc3.d/S99IPChanger$opCode
	ln -s /etc/rc.d/init.d/IPChanger$opCode /etc/rc.d/rc5.d/S99IPChanger$opCode
	ln -s /etc/rc.d/init.d/IPChanger$opCode /etc/rc.d/rc0.d/K10IPChanger$opCode
	ln -s /etc/rc.d/init.d/IPChanger$opCode /etc/rc.d/rc6.d/K10IPChanger$opCode
	cd /home/ipc
	mv IPChanger$opCode /usr/local/
	fn_IPChangerDB;
}
function fn_Install_iTelSMSServer(){
	#
	echo -n "Enter Billing name: ";
	read var_billing;
	echo -n "Enter Operator Code: ";
	read var_op_code;
	echo -n "Enter Signaling header: ";
	read var_header;
	echo -n "Enter Signaling Key: ";
	read var_key;
	echo -n "Enter Bind IP: ";
	read var_ip;
	echo -n "Enter Bind Port: ";
	read var_port;
	echo -n "SMS for iTelSwitch? y/n : ";
	read var_yorn;
	if [ $var_yorn == y ];then
		var_yn=1;
		echo -n "Enter Database name(iTelBilling): ";
		read var_db_itel;
		echo -n "Enter Database name(Successful): ";
		read var_db_suc;
		echo -n "Enter Database name(Failed): ";
		read var_db_failed;
	 else
		var_yn=0;
	fi
  echo -n "Enter SMS API URL: ";
  read var_BaseURL;
  echo -n "Enter success message: ";
  read var_SuccessMsg;
  rm -rf /home/isms;
  mkdir /home/isms;
  cd /home/isms;
  wget http://$var_installer_ip/downloads/SMSServer.zip;
  unzip  SMSServer.zip;
  mv SMSServer SMSServer$var_billing;
  cd SMSServer$var_billing;
  echo "ApplicationName=SMSServer$var_billing">Configuration.txt
  echo "bindPort=$var_port">>Configuration.txt
  echo "bindAddress=$var_ip">>Configuration.txt
  echo "isiTelSwitch=$var_yn">>Configuration.txt
  echo "unicodeEncoding=1">>Configuration.txt
  echo "BaseURL=$var_BaseURL">>Configuration.txt
  echo "FailedMsg=Error">>Configuration.txt
  echo "SuccessMsg=$var_SuccessMsg">>Configuration.txt
  echo "Debug=Yes">>Configuration.txt
  echo $var_op_code>AllowedOperatorCodeList.txt
  echo $var_header>SignalingHeaderList.txt
  echo $var_key>SignalingKeysList.txt
  if [ $var_yorn == y ];then
		#DatabaseConnection_Failed.xml
		echo "<CONNECTIONS>">DatabaseConnection_Failed.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$var_db_failed\"">>DatabaseConnection_Failed.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Failed.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Failed.xml
		echo "</CONNECTIONS>">>DatabaseConnection_Failed.xml
		#DatabaseConnection_Successful.xml
		echo "<CONNECTIONS>">DatabaseConnection_Successful.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$var_db_suc\"">>DatabaseConnection_Successful.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Successful.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Successful.xml
		echo "</CONNECTIONS>">>DatabaseConnection_Successful.xml
		#DatabaseConnection_Reseller.xml
		echo "<CONNECTIONS>">DatabaseConnection_Reseller.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$var_db_suc\"">>DatabaseConnection_Reseller.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Reseller.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Reseller.xml
		echo "</CONNECTIONS>">>DatabaseConnection_Reseller.xml
		#DatabaseConnection.xml
		echo "<CONNECTIONS>">DatabaseConnection.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$var_db_itel\"">>DatabaseConnection.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
		echo "</CONNECTIONS>">>DatabaseConnection.xml
  fi
  # run scrip
  echo "cd /usr/local/SMSServer$var_billing">runSMSServer.sh
  echo "$var_jdk/bin/java -Xmx512m -jar SMSServer.jar &">>runSMSServer.sh
  # shutdown scrip
  echo "cd /usr/local/SMSServer$var_billing">shutdownSMSServer.sh
  echo "$var_jdk/bin/java -jar ShutDown.jar">>shutdownSMSServer.sh
  #Database SMSServer service file
	echo "#!/bin/sh">SMSServer$var_billing
	echo "## SMSServer   This shell script takes care of starting and stopping SMSServer">>SMSServer$var_billing
	echo "# Source function library.">>SMSServer$var_billing
	echo ". /etc/rc.d/init.d/functions">>SMSServer$var_billing
	echo "#">>SMSServer$var_billing
	var="\$1"
	echo "case \"$var\" in">>SMSServer$var_billing
	echo "start)">>SMSServer$var_billing
	echo "echo -n \"Starting  SMSServer$var_billing:">>SMSServer$var_billing
	echo "\"">>SMSServer$var_billing
	echo "/usr/local/SMSServer$var_billing/runSMSServer.sh">>SMSServer$var_billing
	echo ";;">>SMSServer$var_billing
	echo "stop)">>SMSServer$var_billing
	echo "echo -n \"Stoping  SMSServer$var_billing:">>SMSServer$var_billing
	echo "\"">>SMSServer$var_billing
	echo "/usr/local/SMSServer$var_billing/shutdownSMSServer.sh">>SMSServer$var_billing
	echo "sleep 10">>SMSServer$var_billing
	echo ";;">>SMSServer$var_billing
	echo "restart)">>SMSServer$var_billing
	var="\$0"
	echo "$var stop">>SMSServer$var_billing
	echo "$var start">>SMSServer$var_billing
	echo ";;">>SMSServer$var_billing
	echo "*)">>SMSServer$var_billing
	echo "echo \"Usage: $var {start|stop|restart}\"">>SMSServer$var_billing
	echo "exit 1">>SMSServer$var_billing
	echo "esac">>SMSServer$var_billing
	echo "exit 0">>SMSServer$var_billing
	# symbolic link
	cp SMSServer$var_billing /etc/rc.d/init.d/
	chmod 755 /etc/rc.d/init.d/SMSServer$var_billing
	ln -s ../init.d/SMSServer$var_billing /etc/rc.d/rc3.d/S99SMSServer$var_billing
	ln -s ../init.d/SMSServer$var_billing /etc/rc.d/rc5.d/S99SMSServer$var_billing
	ln -s ../init.d/SMSServer$var_billing /etc/rc.d/rc0.d/K10SMSServer$var_billing
	ln -s ../init.d/SMSServer$var_billing /etc/rc.d/rc6.d/K10SMSServer$var_billing
  cd /home/isms;
  mv SMSServer$var_billing /usr/local/
  service SMSServer$var_billing start;
  clear;
	echo -e "\033[34m###############################################################################";
	echo "#                                                                              #";
	echo "#                          Summary                                             #";
	echo "#------------------------------------------------------------------------------#";
	echo "#   Billing  	   : $var_billing                                                   #";
	echo "#   Operator Code: $var_op_code                                                       #";
	echo "#   Bind IP      : $var_ip                                             #";
	echo "#   Bind Port    : $var_port                                                       #";
	echo -e "################################################################################${NC}";
}
function fn_vsr_datamigration(){
  echo -n "Enter Database name(iTelBilling): ";
  read var_db_itel;
  #echo -n "Enter VSR Database name(voipswitch): ";
  #read var_db_voipswitch;
  var_db_voipswitch="voipswitch";
  echo -n "Enter VSR Database Server IP: ";
  read var_vsr_db_IP;
  echo -n "Enter VSR Database User: ";
  read var_vsr_db_user;
  echo -n "Enter VSR Database Password: ";
  read var_vsr_db_pass;
  if [ -z "${var_vsr_db_user}" ];then
		var_vsr_db_user="root";
		echo "vsr database user: $var_vsr_db_user";
	fi
  cd /home/
  rm -rf dmg
  mkdir dmg
  cd dmg
  wget http://$var_installer_ip/downloads/iTelVSRDataMigration.zip
  unzip iTelVSRDataMigration.zip
  cd iTelVSRDataMigration
  #DatabaseConnection.xml
  echo "<CONNECTIONS>">DatabaseConnection.xml
  echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$var_db_itel\"">>DatabaseConnection.xml
  echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
  echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
  echo "</CONNECTIONS>">>DatabaseConnection.xml
  #VPSDatabaseConnection.xml
  echo "<CONNECTIONS>">VPSDatabaseConnection.xml
  echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql://$var_vsr_db_IP/$var_db_voipswitch\"">>VPSDatabaseConnection.xml
  echo " USER_NAME = \"$var_vsr_db_user\" PASSWORD = \"$var_vsr_db_pass\"">>VPSDatabaseConnection.xml
  echo " IS_DEFAULT = \"TRUE\"/>">>VPSDatabaseConnection.xml
  echo "</CONNECTIONS>">>VPSDatabaseConnection.xml
  #sh file configuration
  echo "cd /usr/local/iTelVSRDataMigration">runiTelVSRDataMigration.sh
  echo "$var_jdk/bin/java -Xmx1024m -jar  iTelVSRDataMigration.jar $opCode &">>runiTelVSRDataMigration.sh
  #configuration file
  echo "Delete-iTelSwitchPlus-Data=yes">Configuration.txt
  echo "DeleteUnusedRatePlan=no">>Configuration.txt
  echo "Debug=yes">>Configuration.txt
  rm -rf /usr/local/iTelVSRDataMigration
  cd ..
  mv  iTelVSRDataMigration /usr/local/
  cd /usr/local/iTelVSRDataMigration
  chmod a+x runiTelVSRDataMigration.sh
  sh runiTelVSRDataMigration.sh
  cd /home/
  rm -rf dmg
}
function fn_DBHealthChecker(){
	if [ $flg_DH -eq 0 ];then
		echo  "Db Health check installation process started. ";
		echo -n "Enter Billing name: ";
		read var_billing;
		echo -n "Enter Database name(iTelBilling): ";
		read var_db_itel;
		echo -n "Enter Database name(Successful): ";
		read var_db_suc;
		echo -n "Enter Database name(Failed): ";
		read var_db_failed;
	else
		var_billing=$var_web;
		var_db_itel=$var_db_itelbilling;
		var_db_suc=$var_db_successful;
		var_db_failed=$var_db_failed;
	fi
	flg_DH=0;
  rm -rf /home/dbhc;
  mkdir /home/dbhc;
  cd /home/dbhc;
  echo -e "\n\n\n\n\n\n\n\n${Black} ################## ${BRed}:: Installing DBHealthChecker :: ${Black}################${NC}#";
  echo "Downloading DBHealthChecker........"
  wget http://$var_installer_ip/downloads/DBHealthChecker.zip; >> $LOGFILE
  echo "DBHealthChecker Downloaded!!"
  echo "Extracting DBHealthChecker........."
  unzip -q DBHealthChecker.zip; >> $LOGFILE
  echo "DBHealthChecker Extracted!!"
  cd DBHealthChecker;
  # run scrip
  echo "cd /usr/local/DBHealthChecker$var_billing">runDBHealthChecker.sh
  echo "/usr/jdk1.8.0_111/bin/java -Xmx512m -jar DBHealthChecker.jar &">>runDBHealthChecker.sh
  # shutdown scrip
  echo "cd /usr/local/DBHealthChecker$var_billing">shutdownDBHealthChecker.sh
  echo "/usr/jdk1.8.0_111/bin/java -jar ShutDown.jar">>shutdownDBHealthChecker.sh
	#DatabaseConnection_Failed.xml
	echo "<CONNECTIONS>">DatabaseConnection_Failed.xml
	echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$var_db_failed\"">>DatabaseConnection_Failed.xml
	echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Failed.xml
	echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Failed.xml
	echo "</CONNECTIONS>">>DatabaseConnection_Failed.xml
	#DatabaseConnection_Successful.xml
	echo "<CONNECTIONS>">DatabaseConnection_Successful.xml
	echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$var_db_suc\"">>DatabaseConnection_Successful.xml
	echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Successful.xml
	echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Successful.xml
	echo "</CONNECTIONS>">>DatabaseConnection_Successful.xml
	#DatabaseConnection_Reseller.xml
	echo "<CONNECTIONS>">DatabaseConnection_Reseller.xml
	echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$var_db_suc\"">>DatabaseConnection_Reseller.xml
	echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Reseller.xml
	echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Reseller.xml
	echo "</CONNECTIONS>">>DatabaseConnection_Reseller.xml
	#DatabaseConnection.xml
	echo "<CONNECTIONS>">DatabaseConnection.xml
	echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$var_db_itel\"">>DatabaseConnection.xml
	echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
	echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
	echo "</CONNECTIONS>">>DatabaseConnection.xml
	#Database health checker service file
	echo "#!/bin/sh">DBHealthChecker$var_billing
	echo "## DBHealthChecker   This shell script takes care of starting and stopping DBHealthChecker">>DBHealthChecker$var_billing
	echo "# Source function library.">>DBHealthChecker$var_billing
	echo ". /etc/rc.d/init.d/functions">>DBHealthChecker$var_billing
	echo "#">>DBHealthChecker$var_billing
	var="\$1"
	echo "case \"$var\" in">>DBHealthChecker$var_billing
	echo "start)">>DBHealthChecker$var_billing
	echo "echo -n \"Starting  DBHealthChecker$var_billing:">>DBHealthChecker$var_billing
	echo "\"">>DBHealthChecker$var_billing
	echo "/usr/local/DBHealthChecker$var_billing/runDBHealthChecker.sh">>DBHealthChecker$var_billing
	echo ";;">>DBHealthChecker$var_billing
	echo "stop)">>DBHealthChecker$var_billing
	echo "echo -n \"Stoping  DBHealthChecker$var_billing:">>DBHealthChecker$var_billing
	echo "\"">>DBHealthChecker$var_billing
	echo "/usr/local/DBHealthChecker$var_billing/shutdownDBHealthChecker.sh">>DBHealthChecker$var_billing
	echo "sleep 10">>DBHealthChecker$var_billing
	echo ";;">>DBHealthChecker$var_billing
	echo "restart)">>DBHealthChecker$var_billing
	var="\$0"
	echo "$var stop">>DBHealthChecker$var_billing
	echo "$var start">>DBHealthChecker$var_billing
	echo ";;">>DBHealthChecker$var_billing
	echo "*)">>DBHealthChecker$var_billing
	echo "echo \"Usage: $var {start|stop|restart}\"">>DBHealthChecker$var_billing
	echo "exit 1">>DBHealthChecker$var_billing
	echo "esac">>DBHealthChecker$var_billing
	echo "exit 0">>DBHealthChecker$var_billing
	# symbolic link
	cp DBHealthChecker$var_billing /etc/rc.d/init.d/
	chmod 755 /etc/rc.d/init.d/DBHealthChecker$var_billing
	ln -s ../init.d/DBHealthChecker$var_billing /etc/rc.d/rc3.d/S99DBHealthChecker$var_billing
	ln -s ../init.d/DBHealthChecker$var_billing /etc/rc.d/rc5.d/S99DBHealthChecker$var_billing
	ln -s ../init.d/DBHealthChecker$var_billing /etc/rc.d/rc0.d/K10DBHealthChecker$var_billing
	ln -s ../init.d/DBHealthChecker$var_billing /etc/rc.d/rc6.d/K10DBHealthChecker$var_billing
  #check architecture
  fn_arch;
	if [ $x_64 -eq 1 ];then
		echo "$x_64: x86_64: configuraing 64-so...";
	else
		echo "$x_64: x86_32. configuring 32-so...";
		mv HealthChecker.so  HealthChecker.so_64
		mv HealthChecker.so_32  HealthChecker.so
	fi
  cd  /home/dbhc/DBHealthChecker
  cd  ..
  mv  DBHealthChecker DBHealthChecker$var_billing;
  mv DBHealthChecker$var_billing   /usr/local
  service  DBHealthChecker$var_billing  start
  fn_crontab;
  echo "cd /usr/local/DBHealthChecker$var_billing" > /etc/rc.d/init.d/dbHealthchecker$var_billing.sh
  echo "sh shutdownDBHealthChecker.sh" >> /etc/rc.d/init.d/dbHealthchecker$var_billing.sh
  echo "rm -f DBHealthChecker.log" >> /etc/rc.d/init.d/dbHealthchecker$var_billing.sh
  echo "sh runDBHealthChecker.sh" >> /etc/rc.d/init.d/dbHealthchecker$var_billing.sh
  chmod a+x  /etc/rc.d/init.d/dbHealthchecker$var_billing.sh
  sleep 10;
  line="0 0,12 * * *   /etc/rc.d/init.d/dbHealthchecker$var_billing.sh"
  (crontab  -l; echo "$line" ) | crontab
}
function fn_crontab(){
	rpm -qa  crontabs | grep "crontabs"  && ct=1 || ct=0
	if [ $ct -eq 1 ];then
		echo "Crontab  found";
	else
		echo "Installing Crontab";
		cd /home
		rm -f crontab.zip;
		wget http://$var_installer_ip/downloads/crontab.zip
		echo "Extracting crontab.........."
		unzip -q crontab.zip;
		echo "Crontab Extracted!!"
		cd crontab
		rpm -ivh --nodeps cronie-1.4.4-12.el6.x86_64.rpm;
		rpm -ivh --nodeps crontabs-1.10-33.el6.noarch.rpm;
		rpm -ivh cronie-anacron-1.4.4-12.el6.x86_64.rpm;
	fi
}
function fn_arch(){
	uname -m |  grep x86_64 && x_64=1 || x_64=0
	if [ $x_64 -eq 1 ];then
		echo "$x_64: x86_64";
		#jdk
	else
		echo "$x_64: x86_32";
		#jdk-32
	fi
}
function fn_unzip(){
	echo "checking unzip...";
	unzip | grep "Usage: unzip"  && uz=1 || uz=0
	if [[ $uz -eq 1 ]];then
		echo "Unzip already exists.";
	else
		echo "Installing unzip";
		yum install unzip;
	fi
}

function fn_rsync(){
	echo "checking rsync...";
	rsync 2>&1 | grep "rsync  version"  && rsync_exists=1 || rsync_exists=0
	if [[ $rsync_exists -eq 1 ]];then
		echo "rsync already exists.";
	else
		echo "Installing rsync";
		yum install rsync;
	fi
}
function fn_ntpdate(){
	echo "checking ntpdate...";
	ntpdate | grep "no servers can be used"  && ntd=1 || ntd=0
	if [ $ntd -eq 1 ];then
		echo "ntpdate already exists.";
	else
		echo "Installing ntpdate";
		yum install ntpdate;
	fi
}
function fn_wget(){
	wget | grep "Usage: wget"  && wg=1 || wg=0
	if [ $wg -eq 1 ];then
		echo "wget already exists.";
	else
		echo "Installing wget.";
		yum install wget;
	fi
}
function fn_selinux(){
  echo "Disabling selinux...";
  sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
  setenforce 0
  #ip6tables  -F  # issue in rhel 6.6 in the processlist showing this #/sbin/modprobe ip6_tables
  service ip6tables stop
  chkconfig ip6tables off
}
function fn_byte_restarter(){
	echo -e "${Blue}  ______________________________________________"
	echo -e "${Blue} |${Purple}          Byte Saver Restarter${NC}                ${Blue}|"
	echo -e "${Blue} |______________________________________________|"
	echo -e "${Blue} |  [1] iTel Switch available in server         ${Blue}|"
	echo -e "${Blue} |  [2] Install New ByteSaver Restarter         ${Blue}|"
	echo -e "${Blue} |  [3] Add New Services to ByteSaver Restarter ${Blue}|"
	echo -e "${Blue} |______________________________________________|"
	echo -e -n "${Purple}  Select the task [1-2] 'e' for exit: ${NC}"
	read choice
	case $choice in
		1)
		# With iTel Switch
		echo "Under Development";
		read ;;
		2)
		# Without iTel Switch
		#disable ipv6 features
		fn_ipv6;
		#uname -m |  grep x86_64 && x_64=1 || x_64=0
		#check architecture
		fn_arch;
		#unzip
		fn_unzip;
		#file limit
		fn_file_limit;
		#jdk
		if [ $flg_jdk -eq 0 ];then
			fn_jdk;
		else
			echo "JDK: $var_jdk"
		fi
		#jakarta
		fn_jakarta;
		# #my.cnf
		# fn_my_dot_cnf;
		# #mysql
		# fn_mysql;
		fn_mysql_install
		echo "Downloading Resources.."
		cd /usr
		rm -rf restarter
		mkdir restarter
		cd restarter
		wget http://$var_installer_ip/downloads/RestartModule.zip
		echo "Extracting Resources"
		unzip -q RestartModule.zip >> $LOGFILE
		echo "Resource Extracted!!"
		cd RestartModule
		sleep 2;
		#Taking input
		read -p "Enter Restarter Web name: " web_name
		if [ ! -d /usr/local/jakarta-tomcat-7.0.61/webapps/$web_name ] || [ ! -d /usr/local/ServiceRestarter$web_name ];then
			# creating database
			if [ ! -d /var/lib/mysql/iTelServiceRestart$web_name ];then
				sed -i "s/iTelServiceRestart/iTelServiceRestart$web_name/g" iTelServiceRestart.SQL
				cat iTelServiceRestart.SQL | mysql
			fi
			read -p "Enter server IP:" IP
			IP_Check $IP;
			while [ "$found" != "y" ];do
				read -p "Please provide valid Server IP: "  IP
				IP_Check $IP;
			done
			min_port=30000
			port=$((min_port-1000))
			while [ $port -lt $min_port ];do
				var=$(netstat -uanp | grep -w "$IP:$port")
				if [ -z "${var}" ];then
					assign_port=$port;
					break;
				else
					port=$((port + 2));
				fi
			done
			read -p "Enter Byte Saver Service Name:" service_name
			var=`mysql -u root iTelServiceRestart$web_name -e "select max(scID) from vbServiceConfiguration"`
			i=`echo $var | awk '{print $2}'`
			i=$((i+1));
			while [[ ! -z $service_name ]];do
				result=`mysql -u root iTelServiceRestart$web_name -e"select count(*) from vbServiceConfiguration where scServiceRestartFileName='$service_name'"`;
				result=`echo $result | awk '{print $2}'`
				if [ $result == 0 ];then
					if [[ $service_name =~ ^ByteSaverSignalConverter ]];then
						mysql -u root iTelServiceRestart$web_name -e"insert into vbServiceConfiguration values($i,'$service_name', 'ByteSaver Signaling',0,'$service_name','/usr/local/$service_name/SignalingProxy.log',0,0,0);"
						mysql -u root iTelServiceRestart$web_name -e"insert into vbServiceRestarterIP values('$IP', $assign_port,$i,'$IP',0);"
						i=$((i+1));
					fi
					if [[ $service_name =~ ^ByteSaverMediaProxy ]];then
						mysql -u root iTelServiceRestart$web_name -e"insert into vbServiceConfiguration values($i,'$service_name', 'ByteSaver Media',0,'$service_name','/usr/local/$service_name/MediaProxy.log',0,0,0);"
						mysql -u root iTelServiceRestart$web_name -e"insert into vbServiceRestarterIP values('$IP', $assign_port,$i,'$IP',0);"
						i=$((i+1));
					fi
				else
					echo "Service already Exist in database"
				fi
				if [ ! -f /etc/rc.d/init.d/$service_name ];then
					echo "Service File not exist. Creating service file....."
					sleep 2;
					cd /usr/local/$service_name
					sh softlink.sh
				fi
				echo -e -n "Please Enter Next Service name....${Red}If nothing left press enter${NC} :"
				read service_name
			done
			cd /usr/restarter/RestartModule
			mv restarterweb /usr/local/jakarta-tomcat-7.0.61/webapps/$web_name
			mv ServiceRestarter /usr/local/ServiceRestarter$web_name
			sed -i "s/iTelServiceRestart/iTelServiceRestart$web_name/g" /usr/local/jakarta-tomcat-7.0.61/webapps/$web_name/WEB-INF/classes/DatabaseConnection.xml
			sed -i "s/iTelServiceRestart/iTelServiceRestart$web_name/g" /usr/local/jakarta-tomcat-7.0.61/webapps/$web_name/WEB-INF/classes/DatabaseConnection_PinProtector.xml
			sed -i "s/iTelServiceRestart/iTelServiceRestart$web_name/g" /usr/local/ServiceRestarter$web_name/DatabaseConnection.xml
			#Configuring Run and Shutdown file
			cd /usr/local/ServiceRestarter$web_name
			echo "cd /usr/local/ServiceRestarter$web_name">runRestarter.sh
			echo "$var_jdk/bin/java -Xmx2048m -jar BytesaverRestarter.jar  $opCode &">>runRestarter.sh
			echo "cd /usr/local/ServiceRestarter$web_name">shutdownRestarter.sh
			echo "$var_jdk/bin/java -jar ShutDown.jar">>shutdownRestarter.sh
			chmod 755 runRestarter.sh shutdownRestarter.sh
			#creating softlink
			mv ServiceRestarter ServiceRestarter$web_name
			sed -i "s/ServiceRestarter/ServiceRestarter$web_name/g" ServiceRestarter$web_name
			sed -i "s/ServiceRestarter/ServiceRestarter$web_name/g" softlink.sh
			sh softlink.sh
			echo "Installation Completed!!"
			sleep 2;
			echo -e "${Blue}#################################################";
			echo "#                                                  #";
			echo "#                          Summary                 #";
			echo "#--------------------------------------------------#";
			echo "#   URL        : http://$IP/$web_name              #";
			echo "#   User       : iTel                              #";
			echo "#   Password   : admin                             #";
			echo "#                                                  #";
			echo -e "################################################${NC}";
			echo "Starting Restarter Service!!"
			service ServiceRestarter$web_name start;
			sleep 2;
		else
			echo "Web/Restart module exist in same name. Try to install with different name"
		fi
		;;
		3)
		#Add Services to restarter
		#Taking input
		read -p "Enter Restarter Service Name: " process
		while [ -z "${process}" ];do
			echo -n "Please enter valid folder [Null/Invalid entry not accepted]: "
			read process
		done
		dir=/usr/local/"${process}"
		if [ -d "${dir}" ];then
			cd /usr/local/"${process}"
			old_DB="$(cat DatabaseConnection.xml | grep 'DATABASE_URL')"
			new_DB="$(echo $old_DB | awk -F"///" '{print $2}')"
			database="${new_DB%?}"
			if [  -d /var/lib/mysql/$database ];then
				read -p "Enter server IP:" IP
				IP_Check $IP;
				while [ "$found" != "y" ];do
					read -p "Please provide valid Server IP: "  IP
					IP_Check $IP;
				done
				min_port=30000
				port=$((min_port-1000))
				while [ $port -lt $min_port ];do
					var=$(netstat -uanp | grep -w "$IP:$port")
					if [ -z "${var}" ];then
						assign_port=$port;
						break;
					else
						port=$((port + 2));
					fi
				done
				read -p "Enter Byte Saver Service Name:" service_name
				var=`mysql -u root $database -e "select max(scID) from vbServiceConfiguration"`
				i=`echo $var | awk '{print $2}'`
				i=$((i+1));
				while [[ ! -z $service_name ]];do
					result=`mysql -u root $database -e"select count(*) from vbServiceConfiguration where scServiceRestartFileName='$service_name'"`;
					result=`echo $result | awk '{print $2}'`
					if [ $result == 0 ];then
						if [[ $service_name =~ ^ByteSaverSignalConverter ]];then
							mysql -u root $database -e"insert into vbServiceConfiguration values($i,'$service_name', 'ByteSaver Signaling',0,'$service_name','/usr/local/$service_name/SignalingProxy.log',0,0,0);"
							mysql -u root $database -e"insert into vbServiceRestarterIP values('$IP', $assign_port,$i,'$IP',0);"
							i=$((i+1));
						fi
						if [[ $service_name =~ ^ByteSaverMediaProxy ]];then
							mysql -u root $database -e"insert into vbServiceConfiguration values($i,'$service_name', 'ByteSaver Media',0,'$service_name','/usr/local/$service_name/MediaProxy.log',0,0,0);"
							mysql -u root $database -e"insert into vbServiceRestarterIP values('$IP', $assign_port,$i,'$IP',0);"
							i=$((i+1));
						fi
					else
						echo "Service already Exist in database"
					fi
					if [ ! -f /etc/rc.d/init.d/$service_name ];then
						echo "Service File not exist. Creating service file....."
						sleep 2;
						cd /usr/local/$service_name
						sh softlink.sh
					fi
					echo -e -n "Please Enter Next Service name....${Red}If nothing left press enter${NC} :"
					read service_name
				done
				echo "Service Added!!"
				echo "Restarting Restarter Service!!"
				service $process restart;
				sleep 2;
			else
				echo "No database exist for the given Service"
			fi
		else
			echo "No Service folder exist with given name"
		fi
		;;
		e) exit 0 ;;
		*) echo "Please select number between 1 and 3"; read ;;
	esac
}
function fn_file_limit()
{
		 echo "Checkig file limit...";
		 ulimit -c unlimited
		 grep "* - nofile 750000"  /etc/security/limits.conf  && var_limit=1  || var_limit=0
		 if [ $var_limit -eq 1 ]
		  then
		   echo "file limit exists"
		  else
		   echo "configuring file limit..."
		   echo "* - nofile 750000">>/etc/security/limits.conf
		   cat  /proc/sys/fs/file-max
		   echo 750000 > /proc/sys/fs/file-max
		   ulimit -n 750000
		   ulimit -n
		  fi
		 grep "fs.file-max" /etc/sysctl.conf  && var_sysctl=1  || var_sysctl=0
		 if [ $var_sysctl -eq 1 ]
		  then
		   echo "file-max exists"
		 else
		   echo "file-max not exists"
		   echo "fs.file-max =750000">>/etc/sysctl.conf
		   echo 750000 > /proc/sys/fs/file-max
		   ulimit -n 750000
		   ulimit -n
		 fi
}
function fn_time_zone()
{
		echo -n "Do you want to change server time and date? y/n: "
		read yorn;
		if [ $yorn == y ]
		  then
			date '+%d_%m_%y'>/home/time
			current_time=$(</home/time);
			echo -e "\033[34m  ______________________________"
			echo -e "\033[34m |${Purple}  Welcome to Time Zone Change${NC} \033[34m|"
			echo -e "\033[34m |______________________________|"
			echo -e "\033[34m | \033[30m [1] GMT                \033[34m     |"
			echo -e "\033[34m | \033[30m [2] BDT (Bangladesh)   \033[34m     |"
			echo -e "\033[34m | \033[30m [3] IST (India)             \033[34m|"
			echo -e "\033[34m | \033[30m [4] Kuwait    \033[34m              |"
			echo -e "\033[34m | \033[30m [5] KSA \033[34m                    |"
			echo -e "\033[34m | \033[30m [6] UAE             \033[34m        |"
			echo -e "\033[34m | \033[30m [7] Oman             \033[34m       |"
			echo -e "\033[34m | \033[30m [8] Egypt            \033[34m       |"
			echo -e "\033[34m | \033[30m [9] BDST             \033[34m       |"
			echo -e "\033[34m | \033[30m [10] Others           \033[34m      |"
			echo -e "\033[34m |______________________________|"
			echo -e -n "${Purple}  Select the task [1-10] 's' for skip: ${NC}"
			read choose_time
			case $choose_time in
			1)
			#GMT Time Zone
				zone="GMT"
				cd /etc/sysconfig
				mv clock clock_"${current_time}"
				echo "ZONE=$zone">>clock
				echo "UTC=false">>clock
				echo "ARC=false">>clock
				mv /etc/localtime /etc/localtime_"${current_time}"
				ln -s /usr/share/zoneinfo/"${zone}" /etc/localtime
				/usr/sbin/ntpdate 0.uk.pool.ntp.org | grep 'Operation not permitted'  &> /dev/null
				if [ $? == 1 ]
				then
					echo "Time Zone changed!!"
					echo "Current Time: `date`"
				else
					echo "Date operation not permitted. Only Time Zone Changed!!"
					echo "Current Time: `date`"
				fi
				sleep 3;
				;;
			2)
			#Bangladesh Time Zone
				zone="Asia/Dhaka"
				cd /etc/sysconfig
				mv clock clock_"${current_time}"
				echo "ZONE=$zone">>clock
				echo "UTC=false">>clock
				echo "ARC=false">>clock
				mv /etc/localtime /etc/localtime_"${current_time}"
				ln -s /usr/share/zoneinfo/"${zone}" /etc/localtime
				/usr/sbin/ntpdate 0.uk.pool.ntp.org | grep 'Operation not permitted'  &> /dev/null
				if [ $? == 1 ]
				then
					echo "Time Zone changed!!"
					echo "Current Time: `date`"
				else
					echo "Date operation not permitted. Only Time Zone Changed!!"
					echo "Current Time: `date`"
				fi
				sleep 3;
				;;
			3)
			#India Time Zone
				zone="Asia/Kolkata"
				cd /etc/sysconfig
				mv clock clock_"${current_time}"
				echo "ZONE=$zone">>clock
				echo "UTC=false">>clock
				echo "ARC=false">>clock
				mv /etc/localtime /etc/localtime_"${current_time}"
				ln -s /usr/share/zoneinfo/"${zone}" /etc/localtime
				/usr/sbin/ntpdate 0.uk.pool.ntp.org | grep 'Operation not permitted'  &> /dev/null
				if [ $? == 1 ]
				then
					echo "Time Zone changed!!"
					echo "Current Time: `date`"
				else
					echo "Date operation not permitted. Only Time Zone Changed!!"
					echo "Current Time: `date`"
				fi
				sleep 3;
				;;
			4)
			#Kuwait Time Zone
				zone="Asia/Kuwait"
				cd /etc/sysconfig
				mv clock clock_"${current_time}"
				echo "ZONE=$zone">>clock
				echo "UTC=false">>clock
				echo "ARC=false">>clock
				mv /etc/localtime /etc/localtime_"${current_time}"
				ln -s /usr/share/zoneinfo/"${zone}" /etc/localtime
				/usr/sbin/ntpdate 0.uk.pool.ntp.org | grep 'Operation not permitted'  &> /dev/null
				if [ $? == 1 ]
				then
					echo "Time Zone changed!!"
					echo "Current Time: `date`"
				else
					echo "Date operation not permitted. Only Time Zone Changed!!"
					echo "Current Time: `date`"
				fi
				sleep 3;
				;;
			5)
			#KSA Time Zone
				zone="Asia/Riyadh"
				cd /etc/sysconfig
				mv clock clock_"${current_time}"
				echo "ZONE=$zone">>clock
				echo "UTC=false">>clock
				echo "ARC=false">>clock
				mv /etc/localtime /etc/localtime_"${current_time}"
				ln -s /usr/share/zoneinfo/"${zone}" /etc/localtime
				/usr/sbin/ntpdate 0.uk.pool.ntp.org | grep 'Operation not permitted'  &> /dev/null
				if [ $? == 1 ]
				then
					echo "Time Zone changed!!"
					echo "Current Time: `date`"
				else
					echo "Date operation not permitted. Only Time Zone Changed!!"
					echo "Current Time: `date`"
				fi
				sleep 3;
				;;
			6)
			#UAE Time Zone
				zone="Asia/Dubai"
				cd /etc/sysconfig
				mv clock clock_"${current_time}"
				echo "ZONE=$zone">>clock
				echo "UTC=false">>clock
				echo "ARC=false">>clock
				mv /etc/localtime /etc/localtime_"${current_time}"
				ln -s /usr/share/zoneinfo/"${zone}" /etc/localtime
				/usr/sbin/ntpdate 0.uk.pool.ntp.org | grep 'Operation not permitted'  &> /dev/null
				if [ $? == 1 ]
				then
					echo "Time Zone changed!!"
					echo "Current Time: `date`"
				else
					echo "Date operation not permitted. Only Time Zone Changed!!"
					echo "Current Time: `date`"
				fi
				sleep 3;
				;;
			7)
			#Oman Time Zone
				zone="Asia/Muscat"
				cd /etc/sysconfig
				mv clock clock_"${current_time}"
				echo "ZONE=$zone">>clock
				echo "UTC=false">>clock
				echo "ARC=false">>clock
				mv /etc/localtime /etc/localtime_"${current_time}"
				ln -s /usr/share/zoneinfo/"${zone}" /etc/localtime
				/usr/sbin/ntpdate 0.uk.pool.ntp.org | grep 'Operation not permitted'  &> /dev/null
				if [ $? == 1 ]
				then
					echo "Time Zone changed!!"
					echo "Current Time: `date`"
				else
					echo "Date operation not permitted. Only Time Zone Changed!!"
					echo "Current Time: `date`"
				fi
				sleep 3;
				;;
			8)
			#Egypt Time Zone
				zone="Asia/Egypt"
				cd /etc/sysconfig
				mv clock clock_"${current_time}"
				echo "ZONE=$zone">>clock
				echo "UTC=false">>clock
				echo "ARC=false">>clock
				mv /etc/localtime /etc/localtime_"${current_time}"
				ln -s /usr/share/zoneinfo/"${zone}" /etc/localtime
				/usr/sbin/ntpdate 0.uk.pool.ntp.org | grep 'Operation not permitted'  &> /dev/null
				if [ $? == 1 ]
				then
					echo "Time Zone changed!!"
					echo "Current Time: `date`"
				else
					echo "Date operation not permitted. Only Time Zone Changed!!"
					echo "Current Time: `date`"
				fi
				sleep 3;
				;;
			9)
			#BDST Time Zone
				zone="Etc/GMT+2"
				cd /etc/sysconfig
				mv clock clock_"${current_time}"
				echo "ZONE=$zone">>clock
				echo "UTC=false">>clock
				echo "ARC=false">>clock
				mv /etc/localtime /etc/localtime_"${current_time}"
				ln -s /usr/share/zoneinfo/"${zone}" /etc/localtime
				/usr/sbin/ntpdate 0.uk.pool.ntp.org | grep 'Operation not permitted'  &> /dev/null
				if [ $? == 1 ]
				then
					echo "Time Zone changed!!"
					echo "Current Time: `date`"
				else
					echo "Date operation not permitted. Only Time Zone Changed!!"
					echo "Current Time: `date`"
				fi
				sleep 3;
				;;
			10)
			#Other Time Zone
				#From Shahneel........
				tzselect > zone;
				cat zone;
				zone=$(cat zone);
				sleep 1;
				echo $zone;
				sleep 2;
				cd /etc/sysconfig
				mv clock clock_"${current_time}"
				echo "ZONE=$zone">>clock
				echo "UTC=false">>clock
				echo "ARC=false">>clock
				mv /etc/localtime /etc/localtime_"${current_time}"
				ln -s /usr/share/zoneinfo/"${zone}" /etc/localtime
				/usr/sbin/ntpdate 0.uk.pool.ntp.org | grep 'Operation not permitted'  &> /dev/null
				if [ $? == 1 ]
				then
					echo "Time Zone changed!!"
					echo "Current Time: `date`"
				else
					echo "Date operation not permitted. Only Time Zone Changed!!"
					echo "Current Time: `date`"
				fi
				sleep 3;
				;;
				s) echo "Skipping....."
				sleep 2;
				;;
				*) echo "Please select number between 1 and 10"; read ;;
			esac
				   sleep 2;
		 else
		   echo "Date and time remain unchanged."
		 fi
}
function fn_setup_avail()
{
 echo "Check setup";
}
function fn_setup()
{
  setup;
}
function fn_6jdk()
{
	jdk_search_t=$(date +%s);
		 cd /usr/
		 rm -rf jdk*.tar.gz
		 rm -rf jdk*.zip*
		 echo "Searching for jdk. Please wait...";
		 flg_jdk=1;
		 find  /usr/ -maxdepth 1 -name jdk1.6.0_25  | grep jdk1.6.0_25 && var_jdk=1  || var_jdk=0
		  if [ $var_jdk -eq 1 ]
		   then
		   #echo "Java found"
		   #find /usr/java/jdk* > jd ;tail +1 < jd |  head -n1  > jdk ;not supported by rhel 5
		   find  /usr/ -maxdepth 1 -name jdk1.6.0_25 > jd ; head -1 jd > jdk
		   var_jdk=$(<jdk)
		   echo $var_jdk
		   jdk_search_et=$(date +%s)
		   echo "JDK search time: $((jdk_search_et-jdk_search_t)) secs.";
		   rm -f jd jdk;
		 else
		   echo "installing java, please wait..."
		   if [ $x_64 -eq 1 ]
			then
				#jdk-64
				echo -e "\n\n\n\n\n\n\n\n${Black} ################## ${BRed}:: Installing JDK for installer :: ${Black}################${NC}#";
				wget http://$var_installer_ip/downloads/jdk6.0_25.tar.gz
				  echo "Extracting 1.6.0_25........."
				  tar -zxf jdk6.0_25.tar.gz
				  echo "Extracted Successfully!!!"
				echo $var_jdk
			 else
			   #jdk-32
			   echo "Downloading x86_32 jdk... ";
			   cd /usr/
			   echo "Download JDK........"
			   wget http://$var_installer_ip/downloads/jdk6.tar.gz >> $LOGFILE
			   #wget http://$var_installer_ip/downloads/jdk-7u51-linux-i586.tar.gz
			   tar -zxvf jdk6.tar.gz
			   ./jdk-6u13-linux-i586-rpm.bin
			   #tar -zxvf  jdk-7u51-linux-i586.tar.gz
			   var_jdk="/usr/java/jdk1.6.0_13"
			   echo $var_jdk
			 fi
		  fi
}
function fn_jdk()
{
		 jdk_search_t=$(date +%s);
		 cd /usr/
		 rm -rf jdk*.tar.gz*
		 rm -rf jdk*.zip*
		 echo "Searching for jdk. Please wait...";
		 flg_jdk=1;
		 find  /usr/ -maxdepth 1 -name 'jdk1.8.0_111*'  | grep "jdk1.8.0_111" && var_jdk=1  || var_jdk=0
		  if [ $var_jdk -eq 1 ]
		   then
		   #echo "Java found"
		   #find /usr/java/jdk* > jd ;tail +1 < jd |  head -n1  > jdk ;not supported by rhel 5
		   find  /usr/ -maxdepth 1 -name 'jdk1.8.0_111*' > jd ; head -1 jd > jdk
		   var_jdk=$(<jdk)
		   echo $var_jdk
		   jdk_search_et=$(date +%s)
		   echo "JDK search time: $((jdk_search_et-jdk_search_t)) secs.";
		   rm -f jd jdk;
		 else
		   echo "installing java, please wait..."
		   if [ $x_64 -eq 1 ]
			then
				#jdk-64
				echo -e "\n\n\n\n\n\n\n\n${Black} ################## ${BRed}:: Installing JDK :: ${Black}################${NC}#";
				echo "Downloading x86_64 jdk... ";
				cd /usr/
				echo "Download JDK........"
				#wget http://$var_installer_ip/downloads/jdk-6u25-linux-x64.bin >> $LOGFILE
				wget http://$var_installer_ip/downloads/jdk-8u111-linux-x64.tar.gz
				echo "JDK Downloaded"
				#chmod a+x jdk-6u25-linux-x64.bin
				#./jdk-6u25-linux-x64.bin
				echo "Extracting jdk1.8........."
				tar -zxf jdk-8u111-linux-x64.tar.gz
				echo "Extracted Successfully!!!"
				rm -rf jdk-8u111-linux-x64.tar.gz
				var_jdk="/usr/jdk1.8.0_111"
				echo $var_jdk
			 else
			   #jdk-32
			   echo "Downloading x86_32 jdk... ";
			   cd /usr/
			   echo "Download JDK........"
			   wget http://$var_installer_ip/downloads/jdk6.tar.gz >> $LOGFILE
			   #wget http://$var_installer_ip/downloads/jdk-7u51-linux-i586.tar.gz
			   tar -zxvf jdk6.tar.gz
			   ./jdk-6u13-linux-i586-rpm.bin
			   #tar -zxvf  jdk-7u51-linux-i586.tar.gz
			   var_jdk="/usr/java/jdk1.6.0_13"
			   echo $var_jdk
			 fi
		  fi
}
function fn_jdk_8(){
		 jdk_search_t=$(date +%s);
		 cd /usr/
		 rm -rf jdk*.tar.gz*
		 rm -rf jdk*.zip*
		 echo "Searching for jdk. Please wait...";
		 flg_jdk=1;
		 find  /usr/ -maxdepth 1 -name 'jdk1.8.0_161*'  | grep "jdk1.8.0_161" && var_jdk=1  || var_jdk=0
		  if [ $var_jdk -eq 1 ];
		   then
		   #echo "Java found"
		   #find /usr/java/jdk* > jd ;tail +1 < jd |  head -n1  > jdk ;not supported by rhel 5
		   find  /usr/ -maxdepth 1 -name 'jdk1.8.0_161*' > jd ; head -1 jd > jdk
		   var_jdk=$(<jdk)
		   echo $var_jdk
		   jdk_search_et=$(date +%s)
		   echo "JDK search time: $((jdk_search_et-jdk_search_t)) secs.";
		   rm -f jd jdk;
		 else
		   echo "installing java, please wait..."
		   if [ $x_64 -eq 1 ];
			then
				#jdk-64
				echo -e "\n\n\n\n\n\n\n\n${Black} ################## ${BRed}:: Installing JDK :: ${Black}################${NC}#";
				echo "Downloading x86_64 jdk... ";
				cd /usr/
				echo "Download JDK........"
				wget http://$var_installer_ip/downloads/jdk1.8.0_161.zip
				echo "JDK Downloaded"
				echo "Extracting jdk1.8........."
				unzip jdk1.8.0_161.zip
				echo "Extracted Successfully!!!"
				rm -rf jdk-8u111-linux-x64.tar.gz
				var_jdk="/usr/jdk1.8.0_161"
				echo $var_jdk
			 else
			   #jdk-32
			   echo "Downloading x86_32 jdk... ";
			   cd /usr/
			   echo "Download JDK........"
			   wget http://$var_installer_ip/downloads/jdk6.tar.gz >> $LOGFILE
			   #wget http://$var_installer_ip/downloads/jdk-7u51-linux-i586.tar.gz
			   tar -zxvf jdk6.tar.gz
			   ./jdk-6u13-linux-i586-rpm.bin
			   #tar -zxvf  jdk-7u51-linux-i586.tar.gz
			   var_jdk="/usr/java/jdk1.6.0_13"
			   echo $var_jdk
			 fi
		  fi
}
function fn_jdk_8_111(){
		 jdk_search_t=$(date +%s);
		 cd /usr/
		 rm -rf jdk*.tar.gz*
		 rm -rf jdk*.zip*
		 echo "Searching for jdk. Please wait...";
		 flg_jdk=1;
		 find  /usr/ -maxdepth 1 -name 'jdk1.8.0_111*'  | grep "jdk1.8.0_111" && var_jdk=1  || var_jdk=0
		  if [ $var_jdk -eq 1 ]
		   then
		   #echo "Java found"
		   #find /usr/java/jdk* > jd ;tail +1 < jd |  head -n1  > jdk ;not supported by rhel 5
		   find  /usr/ -maxdepth 1 -name 'jdk1.8.0_111*' > jd ; head -1 jd > jdk
		   var_jdk=$(<jdk)
		   echo $var_jdk
		   jdk_search_et=$(date +%s)
		   echo "JDK search time: $((jdk_search_et-jdk_search_t)) secs.";
		   rm -f jd jdk;
		 else
		   echo "installing java, please wait..."
		   if [ $x_64 -eq 1 ]
			then
				#jdk-64
				echo -e "\n\n\n\n\n\n\n\n${Black} ################## ${BRed}:: Installing JDK :: ${Black}################${NC}#";
				echo "Downloading x86_64 jdk... ";
				cd /usr/
				echo "Download JDK........"
				wget http://$var_installer_ip/downloads/jdk-8u111-linux-x64.tar.gz
				echo "JDK Downloaded"
				echo "Extracting jdk1.8........."
				tar -zxf jdk-8u111-linux-x64.tar.gz
				echo "Extracted Successfully!!!"
				rm -rf jdk-8u111-linux-x64.tar.gz
				var_jdk="/usr/jdk1.8.0_111"
				echo $var_jdk
			 else
			   #jdk-32
			   echo "Downloading x86_32 jdk... ";
			   cd /usr/
			   echo "Download JDK........"
			   wget http://$var_installer_ip/downloads/jdk6.tar.gz >> $LOGFILE
			   #wget http://$var_installer_ip/downloads/jdk-7u51-linux-i586.tar.gz
			   tar -zxvf jdk6.tar.gz
			   ./jdk-6u13-linux-i586-rpm.bin
			   #tar -zxvf  jdk-7u51-linux-i586.tar.gz
			   var_jdk="/usr/java/jdk1.6.0_13"
			   echo $var_jdk
			 fi
		  fi
}
function fn_install_jakarta()
{
		echo -e "\n\n\n\n\n\n\n\n${Black} ################## ${BRed}:: Installing Jakarta :: ${Black}################${NC}#";
		 cd /home
		 rm -rf tomct
		 mkdir tomct
		 cd tomct
		 #wget http://$var_installer_ip/downloads/jakarta_linux.zip
		 echo "Downloading Jakarta........."
		 wget http://$var_installer_ip/downloads/jakarta-tomcat-7.0.61.zip  >> $LOGFILE
		 echo "Jakarta Download........."
		 echo "Extracting Jakarta........."
		 unzip -q jakarta-tomcat-7.0.61.zip >> $LOGFILE
		 echo "Jakarta Extracted"
		 mv jakarta-tomcat-$var_tomcat /usr/local/
		 chmod a+x  /usr/local/jakarta-tomcat-$var_tomcat/bin/*.sh
		 echo "#!/bin/sh">tomcat;
		 echo "## Startup script for Tomcat">>tomcat;
		 echo ". /etc/rc.d/init.d/functions">>tomcat;
		 echo "#">>tomcat;
		 var="\$1"
		 echo "case \"$var\" in">>tomcat;
		 echo " start)">>tomcat;
		 echo "echo -n "Starting Tomcat"">>tomcat;
		 echo "JAVA_HOME=\"$var_jdk\" && JAVA_OPTS=\"-Xms1024m -Xmx2048m\"; export JAVA_HOME &&  export JAVA_OPTS &&  /usr/local/jakarta-tomcat-$var_tomcat/bin/startup.sh">>tomcat;
		 echo ";;">>tomcat;
		 echo "stop)">>tomcat;
		 echo "echo -n  "Stopping Tomcat"">>tomcat;
		 echo "JAVA_HOME=\"$var_jdk\" ; export JAVA_HOME && /usr/local/jakarta-tomcat-$var_tomcat/bin/shutdown.sh">>tomcat;
		 echo " ;;">>tomcat;
		 echo " restart)">>tomcat;
		 var="\$0"
		 echo "$var stop">>tomcat;
		 echo "$var start">>tomcat;
		 echo ";;">>tomcat;
		 echo "*)">>tomcat;
		 echo "echo \"Usage: $0 {start|stop|restart}\"">>tomcat;
		 echo "exit 1">>tomcat;
		 echo "esac">>tomcat;
		 echo "exit 0">>tomcat;
		 sed -i 's/Connector port="8080"/Connector port="80"/g' /usr/local/jakarta-tomcat-$var_tomcat/conf/server.xml
		 mv tomcat /etc/rc.d/init.d/
		 chmod a+x /etc/rc.d/init.d/tomcat
		 #symbolic link
		 ln -s ../init.d/tomcat /etc/rc.d/rc3.d/S99tomcat
		 ln -s ../init.d/tomcat /etc/rc.d/rc5.d/S99tomcat
		 ln -s ../init.d/tomcat /etc/rc.d/rc0.d/K10tomcat
		 ln -s ../init.d/tomcat /etc/rc.d/rc6.d/K10tomcat
		 echo "------------------------------------------------------------------"
		 echo "         Define a non-SSL Coyote HTTP/1.1 Connector on port 80"
		 echo "------------------------------------------------------------------"
		 clear;
		 #memory status of server
		 fn_server_mem_status;
		 grep JAVA_OPTS /etc/rc.d/init.d/tomcat | awk '{print $3}' > min
		 grep JAVA_OPTS /etc/rc.d/init.d/tomcat | awk '{print $4}' > max
		 min=$(<min);
		 max=$(<max);
		 opt="$min $max";
		 rm -f min max;
		 echo -n "Enter Minimum tomcat memory(m): ";
		 read var_min;
		 if [ -z "${var_min}" ]
			 then
				   var_min=$min;
		fi
		echo -n "Enter Maximum tomcat memory(m): ";
		read var_max;
		if [ -z "${var_max}" ]
			then
			var_max=$max
		fi
			m="m";
		if [[ $var_min -ge $var_max ]]; then
			var_max=`expr $var_min + 1024`
		fi
		opt2="JAVA_OPTS=\"-Xms$var_min$m -Xmx$var_max$m\";"
		sed -i "s/${opt}/${opt2}/g" /etc/rc.d/init.d/tomcat
		service tomcat start
		#var_tomcat=$var_tomcat;
}
function fn_jakarta()
{
		service httpd stop
		cd /etc/rc.d/init.d/
		chmod a-x httpd
		echo "------------------------------------------------";
		#memory status of server
		fn_server_mem_status;
		echo "------------------------------------------------";
		apache_search_st=$(date +%s)
		var_tomcat="7.0.61";
		#find /usr/local/ -name jakarta-tomcat-$var_tomcat | grep -x  /usr/local/jakarta-tomcat-$var_tomcat  && var_jak=1  || var_jak=0
		find /usr/local/ -name jakarta-tomcat* | grep jakarta-tomcat* && var_jak=1  || var_jak=0
		apache_search_et=$(date +%s)
		echo "Jakarta search time: $((apache_search_et-apache_search_st)) sec.";
		if [ $var_jak -eq 1 ]
		 then
			find /usr/local/ -name jakarta-tomcat*  > t
			tomcat_version=$(<t)
			rm -f t;
			l=${#tomcat_version}
			l2=26
			#c=`expr substr $tomcat_version $l2 $l`
			c=${tomcat_version:l2:l}
			#a=`expr substr $c 1 1`
			a=${c:0:1}
			b=7
			if [  $a -gt $b ]
			  then
				 echo "upper version: $c";
			elif [ $a -lt $b ]
			  then
				 if [ $flg_n_md -eq 2 ]
				 then
				   echo "Using tomcat version: $c";
				   var_tomcat=$c;
				 else
					echo "lower version: $c .  Please install latest version jakarta-tomcat";
					exit 0;
				 fi
			else
				 echo "current version: $c"
				 rm -f library.zip
				 cd /usr/local/jakarta-tomcat-$c/lib
				 wget http://149.20.186.19/downloads/library.zip
				 unzip library.zip
				 rm -f library.zip
				 grep JAVA_OPTS /etc/rc.d/init.d/tomcat | awk '{print $3}' > min
				 grep JAVA_OPTS /etc/rc.d/init.d/tomcat | awk '{print $4}' > max
				 min=$(<min);
				 max=$(<max);
				 opt="$min $max";
				 rm -f min max;
				 echo "Tomcat memory status: $opt"
				 echo -n "Do you want to change memory allocation? y/n: "
				 read stat
				 if [ $stat == y ]
					then
					   echo -n "Enter Minimum value(m): ";
					   read var_min;
					   if [ -z "${var_min}" ]
						then
						   var_min=$min;
					   fi
					   echo -n "Enter Maximum value(m): ";
					   read var_max;
					   if [ -z "${var_max}" ]
						then
						   var_max=$max
					   fi
					   m="m";
					   if [[ $var_min -ge $var_max ]]; then
							var_max=`expr $var_min + 1024`
					   fi
					   opt2="JAVA_OPTS=\"-Xms$var_min$m -Xmx$var_max$m\";"
					   sed -i "s/${opt}/${opt2}/g" /etc/rc.d/init.d/tomcat
					   service tomcat restart
				 fi
			fi
		else
		   echo "Installing tomcat";
		   fn_install_jakarta;
		fi
}
function fn_install_jakarta_SBC()
{
		echo -e "\n\n\n\n\n\n\n\n${Black} ################## ${BRed}:: Installing Jakarta :: ${Black}################${NC}#";
		 cd /home
		 rm -rf tomct
		 mkdir tomct
		 cd tomct
		 #wget http://$var_installer_ip/downloads/jakarta_linux.zip
		 echo "Downloading Jakarta........."
		 wget http://$var_installer_ip/resource/jakarta/jakarta-tomcat-9.0.17.zip  >> $LOGFILE
		 echo "Jakarta Download........."
		 echo "Extracting Jakarta........."
		 unzip -q jakarta-tomcat-9.0.17.zip >> $LOGFILE
		 echo "Jakarta Extracted"
		 mv jakarta-tomcat-$var_tomcat /usr/local/
		 chmod a+x  /usr/local/jakarta-tomcat-$var_tomcat/bin/*.sh
		 echo "#!/bin/sh">tomcat;
		 echo "## Startup script for Tomcat">>tomcat;
		 echo ". /etc/rc.d/init.d/functions">>tomcat;
		 echo "#">>tomcat;
		 var="\$1"
		 echo "case \"$var\" in">>tomcat;
		 echo " start)">>tomcat;
		 echo "echo -n "Starting Tomcat"">>tomcat;
		 echo "JAVA_HOME=\"$var_jdk\" && JAVA_OPTS=\"-Xms1024m -Xmx2048m\"; export JAVA_HOME &&  export JAVA_OPTS &&  /usr/local/jakarta-tomcat-$var_tomcat/bin/startup.sh">>tomcat;
		 echo ";;">>tomcat;
		 echo "stop)">>tomcat;
		 echo "echo -n  "Stopping Tomcat"">>tomcat;
		 echo "JAVA_HOME=\"$var_jdk\" ; export JAVA_HOME && /usr/local/jakarta-tomcat-$var_tomcat/bin/shutdown.sh">>tomcat;
		 echo " ;;">>tomcat;
		 echo " restart)">>tomcat;
		 var="\$0"
		 echo "$var stop">>tomcat;
		 echo "$var start">>tomcat;
		 echo ";;">>tomcat;
		 echo "*)">>tomcat;
		 echo "echo \"Usage: $0 {start|stop|restart}\"">>tomcat;
		 echo "exit 1">>tomcat;
		 echo "esac">>tomcat;
		 echo "exit 0">>tomcat;
		 sed -i 's/Connector port="8080"/Connector port="80"/g' /usr/local/jakarta-tomcat-$var_tomcat/conf/server.xml
		 mv tomcat /etc/rc.d/init.d/
		 chmod a+x /etc/rc.d/init.d/tomcat
		 #symbolic link
		 ln -s ../init.d/tomcat /etc/rc.d/rc3.d/S99tomcat
		 ln -s ../init.d/tomcat /etc/rc.d/rc5.d/S99tomcat
		 ln -s ../init.d/tomcat /etc/rc.d/rc0.d/K10tomcat
		 ln -s ../init.d/tomcat /etc/rc.d/rc6.d/K10tomcat
		 echo "------------------------------------------------------------------"
		 echo "         Define a non-SSL Coyote HTTP/1.1 Connector on port 80"
		 echo "------------------------------------------------------------------"
		 clear;
		 #memory status of server
		 fn_server_mem_status;
		 grep JAVA_OPTS /etc/rc.d/init.d/tomcat | awk '{print $3}' > min
		 grep JAVA_OPTS /etc/rc.d/init.d/tomcat | awk '{print $4}' > max
		 min=$(<min);
		 max=$(<max);
		 opt="$min $max";
		 rm -f min max;
		 echo -n "Enter Minimum tomcat memory(m): ";
		 read var_min;
		 if [ -z "${var_min}" ]
			 then
				   var_min=$min;
		fi
		echo -n "Enter Maximum tomcat memory(m): ";
		read var_max;
		if [ -z "${var_max}" ]
			then
			var_max=$max
		fi
			m="m";
		if [ $(echo "$var_min > $var_max") -ne 0 ]
			then
			var_max=`expr $var_min + 1024`
		fi
		opt2="JAVA_OPTS=\"-Xms$var_min$m -Xmx$var_max$m\";"
		sed -i "s/${opt}/${opt2}/g" /etc/rc.d/init.d/tomcat
		service tomcat start
		#var_tomcat=$var_tomcat;
}
function fn_install_apache_sms(){
	echo -e "\n\n\n\n\n\n\n\n${Black} ################## ${BRed}:: Installing Apache :: ${Black}################${NC}#";
	cd /home
	rm -rf tomct
	mkdir tomct
	cd tomct
	writeLog "Downloading Apache........."
	wget --no-check-certificate $resource_portal/media/Tools/Web%20Server/apache-tomcat-7.0.59.zip  >> $LOGFILE
	writeLog "Apache Download........."
	writeLog "Extracting Apache........."
	unzip -q apache-tomcat-7.0.59.zip >> $LOGFILE
	writeLog "Apache Extracted"
	mv apache-tomcat-$var_tomcat /usr/local/
	chmod a+x  /usr/local/apache-tomcat-$var_tomcat/bin/*.sh
	echo "#!/bin/sh">tomcat;
	echo "## Startup script for Tomcat">>tomcat;
	echo ". /etc/rc.d/init.d/functions">>tomcat;
	echo "#">>tomcat;
	var="\$1"
	echo "case \"$var\" in">>tomcat;
	echo " start)">>tomcat;
	echo "echo -n "Starting Tomcat"">>tomcat;
	echo "JAVA_HOME=\"$var_jdk\" && JAVA_OPTS=\"-Xms1024m -Xmx2048m\"; export JAVA_HOME &&  export JAVA_OPTS &&  /usr/local/apache-tomcat-$var_tomcat/bin/startup.sh">>tomcat;
	echo ";;">>tomcat;
	echo "stop)">>tomcat;
	echo "echo -n  "Stopping Tomcat"">>tomcat;
	echo "JAVA_HOME=\"$var_jdk\" ; export JAVA_HOME && /usr/local/apache-tomcat-$var_tomcat/bin/shutdown.sh">>tomcat;
	echo " ;;">>tomcat;
	echo " restart)">>tomcat;
	var="\$0"
	echo "$var stop">>tomcat;
	echo "$var start">>tomcat;
	echo ";;">>tomcat;
	echo "*)">>tomcat;
	echo "echo \"Usage: $0 {start|stop|restart}\"">>tomcat;
	echo "exit 1">>tomcat;
	echo "esac">>tomcat;
	echo "exit 0">>tomcat;
	sed -i 's/Connector port="8080"/Connector port="80"/g' /usr/local/apache-tomcat-$var_tomcat/conf/server.xml
	mv tomcat /etc/rc.d/init.d/
	chmod a+x /etc/rc.d/init.d/tomcat
	#symbolic link
	ln -s ../init.d/tomcat /etc/rc.d/rc3.d/S99tomcat
	ln -s ../init.d/tomcat /etc/rc.d/rc5.d/S99tomcat
	ln -s ../init.d/tomcat /etc/rc.d/rc0.d/K10tomcat
	ln -s ../init.d/tomcat /etc/rc.d/rc6.d/K10tomcat
	echo "------------------------------------------------------------------"
	echo "         Define a non-SSL Coyote HTTP/1.1 Connector on port 80"
	echo "------------------------------------------------------------------"
	clear;
	#memory status of server
	fn_server_mem_status;
	grep JAVA_OPTS /etc/rc.d/init.d/tomcat | awk '{print $3}' > min
	grep JAVA_OPTS /etc/rc.d/init.d/tomcat | awk '{print $4}' > max
	min=$(<min);
	max=$(<max);
	opt="$min $max";
	rm -f min max;
	echo -n "Enter Minimum tomcat memory(m): ";
	read var_min;
	if [ -z "${var_min}" ];then
		var_min=$min;
	fi
	echo -n "Enter Maximum tomcat memory(m): ";
	read var_max;
	if [ -z "${var_max}" ];then
		var_max=$max
	fi
	m="m";
	if [[ $var_min -ge $var_max ]]; then
		var_max=`expr $var_min + 1024`
	fi
	opt2="JAVA_OPTS=\"-Xms$var_min$m -Xmx$var_max$m\";"
	sed -i "s/${opt}/${opt2}/g" /etc/rc.d/init.d/tomcat
	service tomcat start
	#var_tomcat=$var_tomcat;
}
function fn_apache_sms(){
	service httpd stop
	cd /etc/rc.d/init.d/
	chmod a-x httpd
	echo "------------------------------------------------";
	#memory status of server
	fn_server_mem_status;
	echo "------------------------------------------------";
	apache_search_st=$(date +%s)
	var_tomcat="7.0.59";
	#find /usr/local/ -name jakarta-tomcat-$var_tomcat | grep -x  /usr/local/jakarta-tomcat-$var_tomcat  && var_jak=1  || var_jak=0
	#find /usr/local/ -name jakarta-tomcat* | grep jakarta-tomcat* && var_jak=1  || var_jak=0
	find /usr/local/ -name apache-tomcat-$var_tomcat* | grep apache-tomcat-$var_tomcat* && var_jak=1  || var_jak=0
	apache_search_et=$(date +%s)
	echo "Apache search time: $((apache_search_et-apache_search_st)) sec.";
	if [ $var_jak -eq 1 ];then
		echo "current version: $var_tomcat"
		# rm -f library.zip
		# cd /usr/local/jakarta-tomcat-$var_tomcat/lib
		# wget http://149.20.186.19/downloads/library.zip
		# unzip library.zip
		# rm -f library.zip
		grep JAVA_OPTS /etc/rc.d/init.d/tomcat | awk '{print $3}' > min
		grep JAVA_OPTS /etc/rc.d/init.d/tomcat | awk '{print $4}' > max
		min=$(<min);
		max=$(<max);
		opt="$min $max";
		rm -f min max;
		echo "Tomcat memory status: $opt"
		echo -n "Do you want to change memory allocation? y/n: "
		read stat
		if [[ $stat == "y" ]]; then
			echo -n "Enter Minimum value(m): ";
			read var_min;
			if [ -z "${var_min}" ];then
				var_min=$min;
			fi
			echo -n "Enter Maximum value(m): ";
			read var_max;
			if [ -z "${var_max}" ];then
				var_max=$max
			fi
			m="m";
			if [[ $var_min -ge $var_max ]]; then
				var_max=`expr $var_min + 1024`
			fi
			opt2="JAVA_OPTS=\"-Xms$var_min$m -Xmx$var_max$m\";"
			sed -i "s/${opt}/${opt2}/g" /etc/rc.d/init.d/tomcat
			service tomcat restart
		fi
	else
		echo "Installing tomcat";
		fn_install_apache_sms;
	fi
}
function fn_jakarta_SBC(){
		service httpd stop
		cd /etc/rc.d/init.d/
		chmod a-x httpd
		echo "------------------------------------------------";
		#memory status of server
		fn_server_mem_status;
		echo "------------------------------------------------";
		apache_search_st=$(date +%s)
		var_tomcat="9.0.17";
		#find /usr/local/ -name jakarta-tomcat-$var_tomcat | grep -x  /usr/local/jakarta-tomcat-$var_tomcat  && var_jak=1  || var_jak=0
		#find /usr/local/ -name jakarta-tomcat* | grep jakarta-tomcat* && var_jak=1  || var_jak=0
		find /usr/local/ -name jakarta-tomcat-$var_tomcat* | grep jakarta-tomcat-$var_tomcat* && var_jak=1  || var_jak=0
		apache_search_et=$(date +%s)
		echo "Jakarta search time: $((apache_search_et-apache_search_st)) sec.";
		if [ $var_jak -eq 1 ]
		 then
				 echo "current version: $var_tomcat"
				 rm -f library.zip
				 cd /usr/local/jakarta-tomcat-$var_tomcat/lib
				 wget http://149.20.186.19/downloads/library.zip
				 unzip library.zip
				 rm -f library.zip
				 grep JAVA_OPTS /etc/rc.d/init.d/tomcat | awk '{print $3}' > min
				 grep JAVA_OPTS /etc/rc.d/init.d/tomcat | awk '{print $4}' > max
				 min=$(<min);
				 max=$(<max);
				 opt="$min $max";
				 rm -f min max;
				 echo "Tomcat memory status: $opt"
				 echo -n "Do you want to change memory allocation? y/n: "
				 read stat
				 if [ $stat == y ]
					then
					   echo -n "Enter Minimum value(m): ";
					   read var_min;
					   if [ -z "${var_min}" ]
						then
						   var_min=$min;
					   fi
					   echo -n "Enter Maximum value(m): ";
					   read var_max;
					   if [ -z "${var_max}" ]
						then
						   var_max=$max
					   fi
					   m="m";
					   if [ $(echo "$var_min > $var_max") -ne 0 ]
						 then
							var_max=`expr $var_min + 1024`
					   fi
					   opt2="JAVA_OPTS=\"-Xms$var_min$m -Xmx$var_max$m\";"
					   sed -i "s/${opt}/${opt2}/g" /etc/rc.d/init.d/tomcat
					   service tomcat restart
				 fi
		else
		   echo "Installing tomcat";
		   fn_install_jakarta_SBC;
		fi
}
function fn_my_dot_cnf()
{
	#find /etc -name my.cnf | grep my.cnf && var_mycnf=1 || var_mycnf=0
	find /var/lib  -name mysql | grep mysql && var_mysql=1 || var_mysql=0
	if [ $var_mysql -eq 1 ];then
		echo "mysql exists. Please configure my.cnf"
	else
		echo "configuring my.cnf"
		echo "[mysqld]">/etc/my.cnf
		echo "datadir=/var/lib/mysql">>/etc/my.cnf
		echo "socket=/var/lib/mysql/mysql.sock">>/etc/my.cnf
		echo "user=mysql">>/etc/my.cnf
		echo "# Disabling symbolic-links is recommended to prevent assorted security risks">>/etc/my.cnf
		echo "symbolic-links=0">>/etc/my.cnf
		echo "log-bin">>/etc/my.cnf
		echo "server-id=100">>/etc/my.cnf
		echo "max_connections=1000">>/etc/my.cnf
		echo "max_allowed_packet=20M">>/etc/my.cnf
		echo "default-storage-engine=MyISAM">>/etc/my.cnf
		echo "[mysqld_safe]">>/etc/my.cnf
		echo "log-error=/var/log/mysqld.log">>/etc/my.cnf
		echo "pid-file=/var/run/mysqld/mysqld.pid">>/etc/my.cnf
	fi
	# cat /lib/systemd/system/mysqld.service;
	if [ -z $(grep default-storage-engine /etc/my.cnf) ];then
		sed -i '/\[mysqld\]/a default-storage-engine=MyISAM' /etc/my.cnf
	fi
	if [ -z $(grep max_connections /etc/my.cnf) ];then
		sed -i '/\[mysqld\]/a max_connections=1000' /etc/my.cnf
	fi
	if [ -z $(grep max_allowed_packet /etc/my.cnf) ];then
		sed -i '/\[mysqld\]/a max_allowed_packet=20M' /etc/my.cnf
	fi
	if [ -z $(sed 's/ //g' /etc/my.cnf | grep "^server-id") ];then
		sed -i '/\[mysqld\]/a server-id=100' /etc/my.cnf
	fi
	if [ -z $(sed 's/ //g' /etc/my.cnf | grep "^log-bin") ];then
		sed -i '/\[mysqld\]/a log-bin' /etc/my.cnf
	fi
	if [ $OS_IS_7 -eq 1 ];then
		# sed -i '$a max_connections=1000' /lib/systemd/system/mysqld.service;
		sed -i '$a LimitNOFILE=65535' /lib/systemd/system/mysqld.service;
		sed -i '$a LimitNPROC=65535' /lib/systemd/system/mysqld.service;
		systemctl daemon-reload;
		systemctl restart mysqld.service;
	fi
}
function fn_mysql_7()
{
	find /var/lib  -name mysql | grep mysql && var_mysql=1 || var_mysql=0
	if [[ "$var_mysql" -eq 0 ]];then 
		echo -e "{BBlue}Installing MySQL for 7 version OS${NC}"
		writeLogSilent "Installing MySQL for 7 version OS"
		cd /usr/
		wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
		rpm -ivh mysql-community-release-el7-5.noarch.rpm
		yum clean all
		yum install mysql
		yum install mysql-server
		service mysqld restart
	else
		echo -e "${BGreen}Mysql Already Exists. Skipping Mysql Installation..  ${NC}"
		writeLogSilent "Mysql Already Exists. Skipping Mysql Installation.."
	fi
	
}
function fn_mysql_8()
{	
	checkOSProfile;
	
	echo -e "${BBlue}Your server OS profile:"
	# cat /etc/redhat-release
	echo "OS: $OS"
	echo "DIST: $DIST"
	echo "PSUEDONAME: $PSUEDONAME"
	echo "REV: $REV"
	echo "DistroBasedOn: $DistroBasedOn"
	echo "KERNEL: $KERNEL"
	echo "MACH: $MACH"
	echo -e "========${NC}"
	osMajorVersion=`echo $REV | gawk -F. '{print $1}'`
	osDist=`lowercase $(echo $DIST | sed 's/ //g')`
	
	if [[ "$DIST" == *"redhat"* ]] || [[ "$DIST" == *"centos"* ]]; then
		if [[ "$osMajorVersion" -eq 7 ]]; then
			echo -e "${BBlue}OS is Centos 7.${NC}"
			writeLogSilent "OS is Centos 7."
			find /var/lib  -name mysql | grep mysql && var_mysql=1 || var_mysql=0
			if [[ "$var_mysql" -eq 0 ]];then 
				echo -e "{BBlue}Installing MySQL 8 for 7 version OS${NC}"
				writeLogSilent "Installing MySQL 8 for 7 version OS"
				cd /usr/
				rpm -Uvh https://repo.mysql.com/mysql80-community-release-el7-3.noarch.rpm
				sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/mysql-community.repo
				rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
				yum clean all
				
				yum erase mysql-community-server
				
				yum --enablerepo=mysql80-community install mysql-community-server
				
				
				
				if [[ -e "/etc/my.cnf" ]]; then
					mv /etc/my.cnf /etc/my.cnf_bk_$(date +'%d_%m_%Y_%H_%M_%S')
				fi
				echo -e "[mysqld]\n\n" > /etc/my.cnf
				echo -e "local-infile=1" >> /etc/my.cnf
				echo -e "sql_mode=\"STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION\"" >> /etc/my.cnf
				echo -e "slow_query_log = 0" >> /etc/my.cnf
				echo -e "slow_query_log_file = /var/log/mysql-slow.log" >> /etc/my.cnf
				echo -e "long_query_time = 1" >> /etc/my.cnf
				echo -e "default_storage_engine=MyISAM" >> /etc/my.cnf

				echo -e "sync_binlog=0\n\n" >> /etc/my.cnf
				echo -e "datadir=/var/lib/mysql" >> /etc/my.cnf
				echo -e "socket=/var/lib/mysql/mysql.sock\n\n" >> /etc/my.cnf

				echo -e "log-error=/var/log/mysqld.log" >> /etc/my.cnf
				echo -e "pid-file=/var/run/mysqld/mysqld.pid" >> /etc/my.cnf
				
				if [[ ! -e "/var/lib/mysql-files" ]]; then
					mkdir -p /var/lib/mysql-files
					chown -R mysql:mysql /var/lib/mysql-files
				fi
				
				sudo chkconfig mysqld on
				
				/usr/sbin/mysqld --defaults-file=/etc/my.cnf --initialize-insecure --user=mysql
				
				is_initializing=$(ps -aux | grep 'mysqld' | grep 'initialize-insecure' | gawk -F ' ' '{print $2}')
				
				while [[ ! -z "$is_initializing" ]]; do
					is_initializing=$(ps -aux | grep 'mysqld' | grep 'initialize-insecure' | gawk -F ' ' '{print $2}')
				done
				
				sudo systemctl restart mysqld
				
			else
				mysql_version=$(mysql -V) 2>&1
				echo -e "${BGreen}Mysql Already Exists. Skipping Mysql Installation..  ${NC}"
				writeLogSilent "Mysql Already Exists. Skipping Mysql Installation.."
				if [[ "$mysql_version" =~ "Ver 8.0" ]]; then
					echo -e "${BGreen}Mysql 8 Already Exists. Version: $mysql_version${NC}"
					writeLogSilent "Mysql 8 Already Exists. Version: $mysql_version"
				else
					echo -e "${BGreen}Mysql 8 Not installed. Check Server Manually${NC}"
					writeLogSilent "Mysql 8 Not installed. Check Server Manually"
					exit
				fi
			fi
		else
			echo -e "${BRed} OS Version is unknown. ${NC}"
			writeLogSilent "$OS Version is unknown. "
			exit;
		fi
	else
		echo -e "${BRed}OS Distro is different version${NC}"
		writeLogSilent "${BRed}OS Distro is different version${NC}"
		exit;
	fi
	
	
}
function fn_mysql()
{
		echo -e "\n\n\n\n\n\n\n\n${Black} ################## ${BRed}:: Installing MySQL :: ${Black}################${NC}#";
		cd /
		find /var/lib  -name mysql | grep mysql && var_mysql=1 || var_mysql=0
		if [ $var_mysql -eq 1 ]
		  then
			 echo "mysql exists"
		  else
			if [ $x_64 -eq 1 ]
			then
			 echo "Installing 64-bit mysql...";
			 cd /home/
			 rm -rf mysql-5.1.61.zip mysql-5.1.61
			 #yum erase perl
			 #yum erase mysql-libs
			  rm -f  mysql64bit.zip
			 #wget http://$var_installer_ip/downloads/mysql64bit.zip
			 #unzip mysql64bit.zip
			 #cd mysql64bit
			 #rpm -ivh --nodeps  perl-DBI-1.40-9.x86_64.rpm
			 #rpm -ivh --nodeps MySQL-devel-5.5.19-1.linux2.6.x86_64.rpm
			 #rpm -ivh --nodeps MySQL-client-5.5.19-1.linux2.6.x86_64.rpm
			 #rpm -ivh --nodeps MySQL-server-5.5.19-1.linux2.6.x86_64.rpm
			 #rpm -ivh --nodeps MySQL-devel-standard-4.1.22-0.rhel4.x86_64.rpm
			 #rpm -ivh --nodeps MySQL-client-standard-4.1.22-0.rhel4.x86_64.rpm
			 #rpm -ivh --nodeps MySQL-server-standard-4.1.22-0.rhel3.x86_64.rpm
			 wget http://$var_installer_ip/downloads/mysql-5.1.61.zip
			 echo "Extracting mysql 5.1.61........"
			 unzip -q mysql-5.1.61.zip
			 echo "MySQL extracted!!"
			 cd mysql-5.1.61
			 rpm -ivh --nodeps perl-DBI-1.609-4.el6.x86_64.rpm
			 rpm -ivh --nodeps perl-DBD-MySQL-4.013-3.el6.x86_64.rpm
			 rpm -ivh  mysql-libs-5.1.61-4.el6.x86_64.rpm
			 rpm -ivh --nodeps mysql-5.1.61-4.el6.x86_64.rpm
			 rpm -ivh pkgconfig-0.23-9.1.el6.x86_64.rpm
			 rpm -ivh keyutils-libs-1.4-4.el6.x86_64.rpm
			 rpm -ivh keyutils-libs-devel-1.4-4.el6.x86_64.rpm
			 rpm -ivh libsepol-devel-2.0.41-4.el6.x86_64.rpm
			 rpm -ivh libselinux-2.0.94-5.3.el6.x86_64.rpm
			 rpm -ivh libselinux-devel-2.0.94-5.3.el6.x86_64.rpm
			 rpm -ivh libcom_err-1.41.12-12.el6.x86_64.rpm
			 rpm -ivh libcom_err-devel-1.41.12-12.el6.x86_64.rpm
			 rpm -ivh krb5-libs-1.9-33.el6.x86_64.rpm
			 rpm -ivh krb5-devel-1.9-33.el6.x86_64.rpm
			 rpm -ivh zlib-1.2.3-27.el6.x86_64.rpm
			 rpm -ivh zlib-devel-1.2.3-27.el6.x86_64.rpm
			 rpm -ivh openssl-1.0.0-20.el6_2.5.x86_64.rpm
			 rpm -ivh openssl-devel-1.0.0-20.el6_2.5.x86_64.rpm
			 rpm -ivh mysql-devel-5.1.61-4.el6.x86_64.rpm
			 rpm -ivh --nodeps mysql-server-5.1.61-4.el6.x86_64.rpm
			wget http://$var_installer_ip/downloads/mysqld
			mv /etc/rc.d/init.d/mysqld  /etc/rc.d/init.d/mysqld_back
			mv  mysqld  /etc/rc.d/init.d/
			chmod a+x  /etc/rc.d/init.d/mysqld
			ln -s ../init.d/mysqld /etc/rc.d/rc3.d/S99mysqld
			ln -s ../init.d/mysqld /etc/rc.d/rc5.d/S99mysqld
			ln -s ../init.d/mysqld /etc/rc.d/rc0.d/K10mysqld
			ln -s ../init.d/mysqld /etc/rc.d/rc6.d/K10mysqld
			service mysqld restart;
		   else
			echo "Installing 32-bit mysql...";
			wget http://$var_installer_ip/downloads/perl-DBI-1.40-8.i386.rpm
			wget http://$var_installer_ip/downloads/MySQL-client-standard-5.0.27-0.rhel4.i386.rpm
			wget http://$var_installer_ip/downloads/MySQL-server-standard-5.0.27-0.rhel4.i386.rpm
			rpm -ivh --nodeps perl-DBI-1.40-8.i386.rpm
			rpm -ivh --nodeps MySQL-client-standard-5.0.27-0.rhel4.i386.rpm
			rpm -ivh --nodeps MySQL-server-standard-5.0.27-0.rhel4.i386.rpm
			service mysql restart;
		  fi
		fi
		chkconfig mysqld on;
		chkconfig mysql on;
}
function fn_server_mem_status()
{
  echo "Server memory status: ";
  free -m;
}
function fn_ipv6()
{
  clear;
  echo "Checking IPv6 status: ";
  cat /proc/sys/net/ipv6/conf/all/disable_ipv6 > i
  var_stat=$(<i)
  rm -f i;
  if [ $var_stat -eq 0 ]
   then
	echo "disabling ipv6..."
	echo "net.ipv6.conf.all.disable_ipv6 = 1">>/etc/sysctl.conf
	echo "net.ipv6.conf.default.disable_ipv6 = 1">>/etc/sysctl.conf
	echo "net.ipv6.conf.lo.disable_ipv6 = 1">>/etc/sysctl.conf
	sysctl -p
	echo "disabling iptables..."
	service iptables stop;
	service iptables save;
	service iptables status;
	echo "disabling ip6tables..."
	service ip6tables stop;
	service ip6tables save;
	service ip6tables status;
	echo "disabling firewalld..."
	sudo systemctl stop firewalld
	sudo systemctl disable firewalld
	sudo systemctl mask --now firewalld
	echo "disabling rpcbind..."
	service rpcbind stop
	cd /etc/rc.d/init.d/
	chmod a-x iptables
	chmod a-x ip6tables
	chmod a-x rpcbind
	else
	   echo "IPv6 disabled";
  fi
}
function fn_install_switch()
{
		switch_start_time=$(date +%s);
		cd /home/swp
		#initialize
		var_call_capacity=3000;
		var_media_memory=1024;
		var_sig_memory=1024;
		#memory status of server
		fn_server_mem_status;
		echo -n "Memory for Media: ";
		read var_media_memory;
		if [ -z "${var_media_memory}" ]
		 then
			var_media_memory=2048;
		fi
		echo -n "Memory for Signaling: ";
		read var_sig_memory;
		if [ -z "${var_sig_memory}" ]
		 then
			var_sig_memory=2048;
		fi
		#echo -n "Switch call volume: ";
		#read var_sw_callvolume
		#while [[ ! $var_sw_callvolume =~ ^[0-9]+$ ]]
		#	do
		#		echo -n "Please enter Switch Call volume [Null/Invalid entry not accepted]: "
		#		read var_sw_callvolume;
		#	done
		echo "----------------------------------------------";
		echo -n "Reference number: ";
		read var_ref;
		while [ -z "${var_ref}" ]
			do
				echo -n "Please enter Reference number [Null/Invalid entry not accepted]: "
				read var_ref;
			done
		#echo -n "Sales executive: ";
		#read var_sales;
		echo -n "Sales executive Email ID: ";
		read var_sales_email;
		while [ -z "${var_sales_email}" ]
			do
				echo -n "Please enter Sales Email [Null/Invalid entry not accepted]: "
				read var_sales_email;
			done
		var_sales=$var_sales_email;
		#echo -n "Switch Installed by: ";
		#read var_installedBy;
		var_installedBy="Installer";
		if [ -z "${var_ref}" ]
		 then
		  var_ref="Demo";
		  echo "Reference number: $var_ref";
		 else
		  echo "Reference number: $var_ref";
		fi
		if [ -z "${var_sales}" ]
		 then
		  var_sales="Demo";
		  echo "Sales executive: $var_sales";
		 else
		  echo "Sales executive: $var_sales";
		fi
		if [ -z "${var_installedBy}" ]
		 then
		  var_installedBy="Demo";
		  echo "Switch Installed by: $var_installedBy";
		 else
		  echo "Switch Installed by: $var_installedBy";
		fi
		echo -n "Enter Customer Email ID: ";
		read email;
		while [ -z "${email}" ]
			do
				echo -n "Please enter Customer Email [Null/Invalid entry not accepted]: "
				read email;
			done
		if [ -z "${email}" ]
		 then
		  #echo "Empty value";
		  email="noreply-support@revesoft.com";
		  echo "Current email id: $email";
		 else
		  #echo "Not empty.";
		  echo "Current email id: $email";
		fi
		echo -n "Enter billing name: ";
		read billing;
		service_name=$billing;
		while [ -z "${billing}" ]
			do
				echo -n "Please enter Billing Name [Null/Invalid entry not accepted]: "
				read billing;
			done
		if [ -z "${billing}" ]
		 then
		  #echo "Empty value";
		  billing="itelbilling";
		  echo "Billing name: $billing";
		 else
		  #echo "Not empty.";
		  echo "Billing name: $billing";
		fi
		echo -n "Administrative User: ";
		read var_user;
		while [ -z "${var_user}" ]
			do
				echo -n "Please enter dministrative User [Null/Invalid entry not accepted]: "
				read var_user;
			done
		echo -n "Administrative password: ";
		read admin_pass;
		while [ -z "${admin_pass}" ]
			do
				echo -n "Please enter Administrative password [Null/Invalid entry not accepted]: "
				read admin_pass;
			done
		if [ -z "${var_user}" ]
		 then
		  var_user="admin";
		  echo "Default User: $var_user";
		 else
		  echo "Default User: $var_user";
		fi
		if [ -z "${admin_pass}" ]
		 then
		  admin_pass="admin";
		  echo "Default password: $admin_pass";
		 else
		  echo "Default password: $admin_pass";
		fi
		var_web=$billing;
		var_db_itelbilling="iTelBilling$billing";
		var_db_successful="Successful$billing";
		var_db_failed_failed="Failed$billing";
		flg_paid_module="new";
		paid_module;
		cd /home/swp
		cp -r  itelbilling $billing
		cp -r  iTelSwitchPlusMediaProxy iTelSwitchPlusMediaProxy$billing
		cp -r  iTelSwitchPlusSignaling iTelSwitchPlusSignaling$billing
		cd iTelSwitchPlusMediaProxy$billing
		echo "Version: ">version
		echo "Media: $var_media_v">>version
		echo "Signaling: $var_signaling_v">>version
		echo "Web: $var_web_v">>version
		#MediaProxy configuration
		echo  "configuring rtpProperties.cfg";
		echo "";
		echo "-------------------sample-------------------";
		echo "";
		echo "rtpStartPort=4000"
		echo "rtpEndPort=9000"
		echo "OrgrtpStartPort=9100"
		echo "OrgrtpEndPort=13000"
		echo "localListenIP=192.168.100.10"
		echo "localListenPort=62"
		echo "rtpTimeout=60"
		echo "remoteSignalingIP=192.168.100.10"
		echo "remoteSignalingPort=191"
		echo "disableTerminatingToOriginatingRTPQueue=1"
		echo "#terminatingToOriginatingRTPQueueSize=6"
		echo "terminatingToOriginatingRTPPacketSize=80"
		echo "minimumTerminatingToOriginatingRTPQueue=1"
		echo "duplicateOriginatingPacketSendingCount=0"
		echo "minimumAverageForVAD=500"
		echo "ivrFileFolder=/usr/local/iTelSwitchPlusMediaProxy/IVR"
		echo "#rtpHeader=0x78534734A7B5E274B6C8E6D3282A6D3F"
		echo "#recordmediafolder=/usr/local/iTelSwitchPlusMediaProxy/media/"
		echo "maxCallCapacity=3000"
		echo "supportVideo=1"
		echo "applyorggain=1"
		echo "applytergain=1"
		echo "ivrPlayDuaration=10"
		echo "";
		echo "------------------------------------------";
		echo -n "rtpStartPort: ";
		read rtpStartPort;
		while [[ ! $rtpStartPort =~ ^[0-9]+$ ]]
			do
				echo -n "Please enter rtpStartPort [Null/Invalid entry not accepted]: "
				read rtpStartPort;
			done
		echo -n "rtpEndPort: ";
		read rtpEndPort;
		while [[ ! $rtpEndPort =~ ^[0-9]+$ ]]
			do
				echo -n "Please enter rtpEndPort [Null/Invalid entry not accepted]: "
				read rtpEndPort;
			done
		echo -n "localListenIP: ";
		read localListenIP;
		while [[ ! $localListenIP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]
			do
				echo -n "Please enter localListenIP [Null/Invalid entry not accepted]: "
				read localListenIP;
			done
		echo -n "localListenPort: ";
		read localListenPort;
		while [[ ! $localListenPort =~ ^[0-9]+$ ]]
			do
				echo -n "Please enter localListenPort [Null/Invalid entry not accepted]: "
				read localListenPort;
			done
		echo  "remoteSignalingIP: $localListenIP";
		#read remoteSignalingIP;
		remoteSignalingIP=$localListenIP;
		echo -n "remoteSignalingPort: ";
		read remoteSignalingPort;
		while [[ ! $remoteSignalingPort =~ ^[0-9]+$ ]]
			do
				echo -n "Please enter remoteSignalingPort [Null/Invalid entry not accepted]: "
				read remoteSignalingPort;
			done
		echo "rtpStartPort=$rtpStartPort">rtpProperties.cfg
		echo "rtpEndPort=$rtpEndPort">>rtpProperties.cfg
		echo "#OrgrtpStartPort=9100">>rtpProperties.cfg
		echo "#OrgrtpEndPort=13000">>rtpProperties.cfg
		echo "localListenIP=$localListenIP">>rtpProperties.cfg
		echo "localListenPort=$localListenPort">>rtpProperties.cfg
		echo "rtpTimeout=60">>rtpProperties.cfg
		echo "remoteSignalingIP=$remoteSignalingIP">>rtpProperties.cfg
		echo "remoteSignalingPort=$remoteSignalingPort">>rtpProperties.cfg
		echo "disableTerminatingToOriginatingRTPQueue=1">>rtpProperties.cfg
		echo "#terminatingToOriginatingRTPQueueSize=6">>rtpProperties.cfg
		echo "terminatingToOriginatingRTPPacketSize=80">>rtpProperties.cfg
		echo "minimumTerminatingToOriginatingRTPQueue=1">>rtpProperties.cfg
		echo "duplicateOriginatingPacketSendingCount=0">>rtpProperties.cfg
		echo "minimumAverageForVAD=500">>rtpProperties.cfg
		echo "ivrFileFolder=/usr/local/iTelSwitchPlusMediaProxy$billing/IVR">>rtpProperties.cfg
		echo "#rtpHeader=0x78534734A7B5E274B6C8E6D3282A6D3F">>rtpProperties.cfg
		echo "#recordmediafolder=/usr/local/iTelSwitchPlusMediaProxy/media/">>rtpProperties.cfg
		echo "maxCallCapacity=$var_call_capacity">>rtpProperties.cfg
		echo "supportVideo=1">>rtpProperties.cfg
		echo "applyorggain=1">>rtpProperties.cfg
		echo "applytergain=1">>rtpProperties.cfg
		echo "ivrPlayDuaration=10">>rtpProperties.cfg
		#Mediaproxy service file
		mv iTelSwitchPlusMediaProxy iTelSwitchPlusMediaProxy$billing
		echo "#!/bin/sh">iTelSwitchPlusMediaProxy$billing
		echo "## iTelSwitchPlusMediaProxy   This shell script takes care of starting and stopping iTelSwitchPlusMediaProxy">>iTelSwitchPlusMediaProxy$billing
		echo "# Source function library.">>iTelSwitchPlusMediaProxy$billing
		echo ". /etc/rc.d/init.d/functions">>iTelSwitchPlusMediaProxy$billing
		echo "#">>iTelSwitchPlusMediaProxy$billing
		var="\$1"
		echo "case \"$var\" in">>iTelSwitchPlusMediaProxy$billing
		echo "start)">>iTelSwitchPlusMediaProxy$billing
		echo "echo -n \"Starting iTelSwitchPlus MediaProxy$billing:">>iTelSwitchPlusMediaProxy$billing
		echo "\"">>iTelSwitchPlusMediaProxy$billing
		echo "/usr/local/iTelSwitchPlusMediaProxy$billing/runiTelSwitchPlusMediaProxy.sh">>iTelSwitchPlusMediaProxy$billing
		echo ";;">>iTelSwitchPlusMediaProxy$billing
		echo "stop)">>iTelSwitchPlusMediaProxy$billing
		echo "echo -n \"Stoping iTelSwitchPlus MediaProxy$billing:">>iTelSwitchPlusMediaProxy$billing
		echo "\"">>iTelSwitchPlusMediaProxy$billing
		echo "/usr/local/iTelSwitchPlusMediaProxy$billing/shutdowniTelSwitchPlusMediaProxy.sh">>iTelSwitchPlusMediaProxy$billing
		echo "sleep 10">>iTelSwitchPlusMediaProxy$billing
		echo ";;">>iTelSwitchPlusMediaProxy$billing
		echo "restart)">>iTelSwitchPlusMediaProxy$billing
		var="\$0"
		echo "$var stop">>iTelSwitchPlusMediaProxy$billing
		echo "$var start">>iTelSwitchPlusMediaProxy$billing
		echo ";;">>iTelSwitchPlusMediaProxy$billing
		echo "*)">>iTelSwitchPlusMediaProxy$billing
		echo "echo \"Usage: $var {start|stop|restart}\"">>iTelSwitchPlusMediaProxy$billing
		echo "exit 1">>iTelSwitchPlusMediaProxy$billing
		echo "esac">>iTelSwitchPlusMediaProxy$billing
		echo "exit 0">>iTelSwitchPlusMediaProxy$billing
		#Media start file
		m="m";
		echo "cd /usr/local/iTelSwitchPlusMediaProxy$billing">runiTelSwitchPlusMediaProxy.sh
		echo "$var_jdk/bin/java -Xmx$var_media_memory$m -jar iTelSwitchPlusMediaProxy.jar $billing &">>runiTelSwitchPlusMediaProxy.sh
		#Media stop file
		echo "cd /usr/local/iTelSwitchPlusMediaProxy$billing">shutdowniTelSwitchPlusMediaProxy.sh
		echo "$var_jdk/bin/java -jar ShutDown.jar">>shutdowniTelSwitchPlusMediaProxy.sh
		cp iTelSwitchPlusMediaProxy$billing /etc/rc.d/init.d/
		chmod 755 /etc/rc.d/init.d/iTelSwitchPlusMediaProxy$billing
		#Media symbolic lilnk. writted into softlink.sh
		echo "chmod 755 /usr/local/iTelSwitchPlusMediaProxy$billing/runiTelSwitchPlusMediaProxy.sh">softlink.sh
		echo "chmod 755 /usr/local/iTelSwitchPlusMediaProxy$billing/shutdowniTelSwitchPlusMediaProxy.sh">>softlink.sh
		echo "cp -r iTelSwitchPlusMediaProxy$billing /etc/rc.d/init.d/">>softlink.sh
		echo "ln -s ../init.d/iTelSwitchPlusMediaProxy$billing /etc/rc.d/rc3.d/S99iTelSwitchPlusMediaProxy$billing">>softlink.sh
		echo "ln -s ../init.d/iTelSwitchPlusMediaProxy$billing /etc/rc.d/rc5.d/S99iTelSwitchPlusMediaProxy$billing">>softlink.sh
		echo "ln -s ../init.d/iTelSwitchPlusMediaProxy$billing /etc/rc.d/rc0.d/K10iTelSwitchPlusMediaProxy$billing">>softlink.sh
		echo "ln -s ../init.d/iTelSwitchPlusMediaProxy$billing /etc/rc.d/rc6.d/K10iTelSwitchPlusMediaProxy$billing">>softlink.sh
		cd ../iTelSwitchPlusSignaling$billing
		#Signaling start file
		m="m";
		echo "cd /usr/local/iTelSwitchPlusSignaling$billing">runiTelSwitchPlusSignaling.sh
		echo "$var_jdk/bin/java -Xmx$var_sig_memory$m -jar iTelSwitchPlusSignaling.jar $billing &">>runiTelSwitchPlusSignaling.sh
		#Signaling stop file
		echo "cd /usr/local/iTelSwitchPlusSignaling$billing">shutdowniTelSwitchPlusSignaling.sh
		echo "$var_jdk/bin/java -jar ShutDown.jar">>shutdowniTelSwitchPlusSignaling.sh
		#Signaling service file
		mv iTelSwitchPlusSignaling iTelSwitchPlusSignaling$billing
		echo "#!/bin/sh">iTelSwitchPlusSignaling$billing
		echo "## iTelSwitchPlusSignaling   This shell script takes care of starting and stopping iTelSwitchPlusSignaling">>iTelSwitchPlusSignaling$billing
		echo "# Source function library.">>iTelSwitchPlusSignaling$billing
		echo ". /etc/rc.d/init.d/functions">>iTelSwitchPlusSignaling$billing
		echo "#">>iTelSwitchPlusSignaling$billing
		var="\$1"
		echo "case \"$var\" in">>iTelSwitchPlusSignaling$billing
		echo "start)">>iTelSwitchPlusSignaling$billing
		echo "echo -n \"Starting iTelSwitchPlusSignaling....$billing:">>iTelSwitchPlusSignaling$billing
		echo "\"">>iTelSwitchPlusSignaling$billing
		echo "/usr/local/iTelSwitchPlusSignaling$billing/runiTelSwitchPlusSignaling.sh">>iTelSwitchPlusSignaling$billing
		echo ";;">>iTelSwitchPlusSignaling$billing
		echo "stop)">>iTelSwitchPlusSignaling$billing
		echo "echo -n \"Stoping iTelSwitchPlusSignaling.....$billing:">>iTelSwitchPlusSignaling$billing
		echo "\"">>iTelSwitchPlusSignaling$billing
		echo " /usr/local/iTelSwitchPlusSignaling$billing/shutdowniTelSwitchPlusSignaling.sh">>iTelSwitchPlusSignaling$billing
		echo "sleep 10">>iTelSwitchPlusSignaling$billing
		echo ";;">>iTelSwitchPlusSignaling$billing
		echo "restart)">>iTelSwitchPlusSignaling$billing
		var="\$0"
		echo "$var stop">>iTelSwitchPlusSignaling$billing
		echo "$var start">>iTelSwitchPlusSignaling$billing
		echo ";;">>iTelSwitchPlusSignaling$billing
		echo "*)">>iTelSwitchPlusSignaling$billing
		echo "echo \"Usage: $var {start|stop|restart}\"">>iTelSwitchPlusSignaling$billing
		echo "exit 1">>iTelSwitchPlusSignaling$billing
		echo "esac">>iTelSwitchPlusSignaling$billing
		echo "exit 0">>iTelSwitchPlusSignaling$billing
		cp iTelSwitchPlusSignaling$billing /etc/rc.d/init.d/
		chmod 755 /etc/rc.d/init.d/iTelSwitchPlusSignaling$billing
		#Signailng symbolic link. written into softlink.sh
		echo "chmod 755 /usr/local/iTelSwitchPlusSignaling$billing/runiTelSwitchPlusSignaling.sh">softlink.sh
		echo "chmod 755 /usr/local/iTelSwitchPlusSignaling$billing/shutdowniTelSwitchPlusSignaling.sh">>softlink.sh
		echo "cp -r iTelSwitchPlusSignaling$billing /etc/rc.d/init.d/">>softlink.sh
		echo "ln -s ../init.d/iTelSwitchPlusSignaling$billing /etc/rc.d/rc3.d/S99iTelSwitchPlusSignaling$billing">>softlink.sh
		echo "ln -s ../init.d/iTelSwitchPlusSignaling$billing /etc/rc.d/rc5.d/S99iTelSwitchPlusSignaling$billing">>softlink.sh
		echo "ln -s ../init.d/iTelSwitchPlusSignaling$billing /etc/rc.d/rc0.d/K10iTelSwitchPlusSignaling$billing">>softlink.sh
		echo "ln -s ../init.d/iTelSwitchPlusSignaling$billing /etc/rc.d/rc6.d/K10iTelSwitchPlusSignaling$billing">>softlink.sh
		#DatabaseConnection_Failed.xml
		echo "<CONNECTIONS>">DatabaseConnection_Failed.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///Failed$billing\"">>DatabaseConnection_Failed.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Failed.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Failed.xml
		echo "</CONNECTIONS>">>DatabaseConnection_Failed.xml
		#DatabaseConnection_Successful.xml
		echo "<CONNECTIONS>">DatabaseConnection_Successful.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///Successful$billing\"">>DatabaseConnection_Successful.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Successful.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Successful.xml
		echo "</CONNECTIONS>">>DatabaseConnection_Successful.xml
		#DatabaseConnection_Reseller.xml
		echo "<CONNECTIONS>">DatabaseConnection_Reseller.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///Successful$billing\"">>DatabaseConnection_Reseller.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Reseller.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Reseller.xml
		echo "</CONNECTIONS>">>DatabaseConnection_Reseller.xml
		#DatabaseConnection.xml
		echo "<CONNECTIONS>">DatabaseConnection.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///iTelBilling$billing?useEncoding=true&amp;characterEncoding=UTF-8\"">>DatabaseConnection.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
		echo "</CONNECTIONS>">>DatabaseConnection.xml
		#configuring web part
		rm -f /home/swp/$billing/WEB-INF/classes/*.xml
		cp -r *.xml /home/swp/$billing/WEB-INF/classes/
		#configuring log4j.properties
		rm -f /home/swp/$billing/WEB-INF/classes/log4j.properties
		rm -rf log4j;
		mkdir log4j;
		cd log4j;
		echo "# Define the root logger with appender file">log4j.properties
		echo "log4j.rootLogger = DEBUG, FILE">>log4j.properties
		echo "# Define the file appender">>log4j.properties
		echo "log4j.appender.FILE=org.apache.log4j.DailyRollingFileAppender">>log4j.properties
		echo "# Set the name of the file">>log4j.properties
		echo "log4j.appender.FILE.File=iTelBilling$billing.log">>log4j.properties
		echo "# Set the immediate flush to true (default)">>log4j.properties
		echo "log4j.appender.FILE.ImmediateFlush=true">>log4j.properties
		echo "# Set the threshold to debug mode">>log4j.properties
		echo "log4j.appender.FILE.Threshold=debug">>log4j.properties
		echo "# Set the append to false, should not overwrite">>log4j.properties
		echo "log4j.appender.FILE.Append=true">>log4j.properties
		echo "# Set the DatePattern">>log4j.properties
		echo "log4j.appender.FILE.DatePattern='.'yyyy-MM-dd">>log4j.properties
		echo "# Define the layout for file appender">>log4j.properties
		echo "log4j.appender.FILE.layout=org.apache.log4j.PatternLayout">>log4j.properties
		echo "log4j.appender.FILE.layout.conversionPattern=%m%n">>log4j.properties
		cp -r log4j.properties /home/swp/$billing/WEB-INF/classes/
		cd ..
		#-----------------server.cfg----------------------------------------
		echo  "configuring server.cfg";
		echo "";
		echo "-------------------sample-------------------";
		echo "";
		echo "#       Server.cfg configuration file"
		echo "# ___________________________________________"
		echo "#"
		echo "# ********** Server ***********"
		echo "orgBindIP=192.168.100.10"
		echo "orgBindPort=5060"
		echo "terBindIP=192.168.100.10"
		echo "terBindPort=600"
		echo "isRegistrar=yes"
		echo "doAuthentication=yes"
		echo "registraionSenderBindPort=91"
		echo "registrationReceiverIPList=192.168.100.10"
		echo "sendNotify=yes"
		echo "# ********** RTP & Timeouts  ***********"
		echo "#mediaProxyPublicIP=209.235.214.122";
		echo "mediaNode=192.168.100.10:62;"
		echo "mediaListenIP=192.168.100.10"
		echo "mediaListenPort=191"
		echo "-----------------------------------------------"
		#echo "orgBindIP"
		#read  orgBindIP;
		echo  "orgBindIP=$remoteSignalingIP"
		echo -n "orgBindPort: "
		read orgBindPort;
		while [[ ! $orgBindPort =~ ^[0-9]+$ ]]
			do
				echo -n "Please enter orgBindPort [Null/Invalid entry not accepted]: "
				read orgBindPort;
			done
		switch_port=$orgBindPort;
		echo -n "registraionSenderBindPort: "
		read registraionSenderBindPort;
		while [[ ! $registraionSenderBindPort =~ ^[0-9]+$ ]]
			do
				echo -n "Please enter registraionSenderBindPort [Null/Invalid entry not accepted]: "
				read registraionSenderBindPort;
			done
		echo -n "localConfigListeningPort: "
		read localConfigListeningPort;
		while [[ ! $localConfigListeningPort =~ ^[0-9]+$ ]]
			do
				echo -n "Please enter localConfigListeningPort [Null/Invalid entry not accepted]: "
				read localConfigListeningPort;
			done
		echo "#       Proxy Server configuration file">config/server.cfg
		echo "# ___________________________________________">>config/server.cfg
		echo "#"
		echo "# ********** Server ***********">>config/server.cfg
		echo "orgBindIP=$remoteSignalingIP">>config/server.cfg
		echo "orgBindPort=$orgBindPort">>config/server.cfg
		echo "terBindIP=$remoteSignalingIP">>config/server.cfg
		echo "terBindPort=$orgBindPort">>config/server.cfg
		echo "isRegistrar=yes">>config/server.cfg
		echo "doAuthentication=yes">>config/server.cfg
		echo "registraionSenderBindPort=$registraionSenderBindPort">>config/server.cfg
		echo "registrationReceiverIPList=$remoteSignalingIP">>config/server.cfg
		echo "sendNotify=yes">>config/server.cfg
		echo "# ********** RTP & Timeouts  ***********">>config/server.cfg
		echo "#mediaProxyPublicIP=209.235.214.122">>config/server.cfg
		echo "mediaNode=$localListenIP:$localListenPort;">>config/server.cfg
		echo "mediaListenIP=$remoteSignalingIP">>config/server.cfg
		echo "mediaListenPort=$remoteSignalingPort">>config/server.cfg
		echo "pushSendTimeForNoResponseCallInSec=5">>config/server.cfg
		echo "maxNumberOfInviteRetransmissionForPinCall=16">>config/server.cfg
		echo "maxNumberOfMessageRetransmissionTimes=10">>config/server.cfg
		echo "registrationDebug=yes">>config/server.cfg
		echo "enableCodecConversion=no">>config/server.cfg
		echo "localConfigListeningPort=$localConfigListeningPort">>config/server.cfg
		cd ..
		if [ $x_64 -eq 1 ]
		 then
		  echo "$x_64: x86_64: configuraing 64-so...";
		  wget http://$var_installer_ip/downloads/SignalingProxy.so_64
		  wget http://$var_installer_ip/downloads/MediaProxy.so_64
		  mv MediaProxy.so_64 MediaProxy.so
		  mv SignalingProxy.so_64 SignalingProxy.so
		  rm -f iTelSwitchPlusMediaProxy$billing/MediaProxy.so
		  rm -f iTelSwitchPlusSignaling$billing/SignalingProxy.so
		  mv MediaProxy.so iTelSwitchPlusMediaProxy$billing
		  mv SignalingProxy.so iTelSwitchPlusSignaling$billing
		 else
		   echo "$x_64: x86_32. configuring 32-so...";
		 fi
		mv iTelSwitchPlusMediaProxy$billing /usr/local/
		mv iTelSwitchPlusSignaling$billing /usr/local/
		mv $billing /usr/local/jakarta-tomcat-$var_tomcat/webapps/
		#Media symbolic lilnk
		chmod 755 /usr/local/iTelSwitchPlusMediaProxy$billing/runiTelSwitchPlusMediaProxy.sh
		chmod 755 /usr/local/iTelSwitchPlusMediaProxy$billing/shutdowniTelSwitchPlusMediaProxy.sh
		ln -s ../init.d/iTelSwitchPlusMediaProxy$billing /etc/rc.d/rc3.d/S99iTelSwitchPlusMediaProxy$billing
		ln -s ../init.d/iTelSwitchPlusMediaProxy$billing /etc/rc.d/rc5.d/S99iTelSwitchPlusMediaProxy$billing
		ln -s ../init.d/iTelSwitchPlusMediaProxy$billing /etc/rc.d/rc0.d/K10iTelSwitchPlusMediaProxy$billing
		ln -s ../init.d/iTelSwitchPlusMediaProxy$billing /etc/rc.d/rc6.d/K10iTelSwitchPlusMediaProxy$billing
		#Signailng symbolic link
		chmod 755 /usr/local/iTelSwitchPlusSignaling$billing/runiTelSwitchPlusSignaling.sh
		chmod 755 /usr/local/iTelSwitchPlusSignaling$billing/shutdowniTelSwitchPlusSignaling.sh
		ln -s ../init.d/iTelSwitchPlusSignaling$billing /etc/rc.d/rc3.d/S99iTelSwitchPlusSignaling$billing
		ln -s ../init.d/iTelSwitchPlusSignaling$billing /etc/rc.d/rc5.d/S99iTelSwitchPlusSignaling$billing
		ln -s ../init.d/iTelSwitchPlusSignaling$billing /etc/rc.d/rc0.d/K10iTelSwitchPlusSignaling$billing
		ln -s ../init.d/iTelSwitchPlusSignaling$billing /etc/rc.d/rc6.d/K10iTelSwitchPlusSignaling$billing
		switch_end_time=$(date +%s);
		time_elapsed=$((switch_end_time - switch_start_time));
		minute=`expr $time_elapsed / 60`;
		sec=`expr $time_elapsed % 60`;
		echo "------Finish> Total time to complete installation process: $minute min $sec secs-------";
		sleep 2;
		#service  iTelSwitchPlusSignaling$billing start
		#service  iTelSwitchPlusMediaProxy$billing start
		cd /usr/local/iTelSwitchPlusSignaling$billing/
		wget http://$var_installer_ip/downloads/MailAlert.jar
		echo "AdditionalToAddress=support@revesoft.com">>config/emailInfo.cfg
		echo "FromAddress=noreply-support@revesoft.com">>config/emailInfo.cfg
		echo "MailServer=mail.revesoft.com">>config/emailInfo.cfg
		echo "MailSeverPort=2525">>config/emailInfo.cfg
		echo "needAuthenticationFromMailServer=yes">>config/emailInfo.cfg
		echo "authenticationEmailAddress=noreply-support@revesoft.com">>config/emailInfo.cfg
		echo "authenticationEmailPassword=ChangeDPasS01032016#">>config/emailInfo.cfg
		echo "MailSubject=Switch Down alert">>config/emailInfo.cfg
		echo "MailContent=Dear Support,\n  Here is the information about Switch Down: \n Switch IP: $remoteSignalingIP \n Signaling Location: /usr/local/iTelSwitchPlusSignaling$billing \n\nRegards,\niTelSwitchMonitoring Team.">>config/emailInfo.cfg
		echo -e "\033[34m################################################################################";
		echo "#                                                                                         #";
		echo "#                              Summary                                                    #";
		echo "#-----------------------------------------------------------------------------------------#";
		echo "#   Billing      : http://$remoteSignalingIP/$billing                                     #";
		echo "#   User         : $var_user                                                              #";
		echo "#   Password     : $admin_pass                                                            #";
		echo "#   Switch ip    : $remoteSignalingIP                                                     #";
		echo "#   Port         : $orgBindPort                                                           #";
		echo "#   Balance Link : http://$remoteSignalingIP/$billing/getclientbalance.do?pin=REPLACE     #";
		echo "#   Media        : iTelSwitchPlusMediaProxy$billing                                       #";
		echo "#   Signaling    : iTelSwitchPlusSignaling$billing                                        #";
		echo "#   Databases    : iTelBilling$billing, Successful$billing, Failed$billing                #";
		echo "#                                                                                         #";
		echo -e "#########################################################################################${NC}";
		#switch delivery email
		echo "billing=$billing">/home/swp/deliveryEmail.cfg
		echo "salesEmail=$var_sales_email">>/home/swp/deliveryEmail.cfg
		echo "customerEmail=$email">>/home/swp/deliveryEmail.cfg
		echo "supportEmail=support@itelbilling.com">>/home/swp/deliveryEmail.cfg
		echo "billingURL=http://$remoteSignalingIP/$billing">>/home/swp/deliveryEmail.cfg
		echo "switchIP=$remoteSignalingIP">>/home/swp/deliveryEmail.cfg
		echo "switchPORT=$orgBindPort">>/home/swp/deliveryEmail.cfg
		echo "IVRExt=101">>/home/swp/deliveryEmail.cfg
		echo "balanceLink=http://$remoteSignalingIP/$billing/getclientbalance.do?pin=REPLACE">>/home/swp/deliveryEmail.cfg
		echo "installedBy=$var_installedBy;">>/home/swp/deliveryEmail.cfg
		#admin_pass="admin";
		echo "iTelBilling$billing;">/home/swp/db.txt
		echo "Successful$billing;">>/home/swp/db.txt
		echo "Failed$billing;">>/home/swp/db.txt
		echo "$remoteSignalingIP;">>/home/swp/db.txt
		echo "$registraionSenderBindPort;">>/home/swp/db.txt
		echo "$var_user;">>/home/swp/db.txt
		echo "$admin_pass;">>/home/swp/db.txt
		echo "$orgBindPort;">>/home/swp/db.txt
		echo "$email;">>/home/swp/db.txt
		echo "$var_billing_v;">>/home/swp/db.txt
		#echo "$var_sw_callvolume;">>/home/swp/db.txt
		echo "$billing;">>/home/swp/db.txt
		echo "iTelSwitchPlusMediaProxy$billing;">>/home/swp/db.txt
		echo "$remoteSignalingIP;">/home/swp/track.txt
		echo "$rtpStartPort;">>/home/swp/track.txt
		echo "$rtpEndPort;">>/home/swp/track.txt
		echo "$orgBindPort;">>/home/swp/track.txt
		echo "$orgBindPort,$registraionSenderBindPort,$localListenPort,$remoteSignalingPort;">>/home/swp/track.txt
		echo "$billing;">>/home/swp/track.txt
		echo "$var_ref;">>/home/swp/track.txt
		echo "$var_sales;">>/home/swp/track.txt
		echo "$var_installedBy;">>/home/swp/track.txt
		echo "$var_media_v;">>/home/swp/track.txt
		echo "$var_signaling_v;">>/home/swp/track.txt
		echo "$var_web_v;">>/home/swp/track.txt
		echo "http://$remoteSignalingIP/$billing;">/home/swp/email.txt
		echo "$remoteSignalingIP;">>/home/swp/email.txt
		echo "$orgBindPort;">>/home/swp/email.txt
		echo "$var_media_v;">>/home/swp/email.txt
		echo "$var_signaling_v;">>/home/swp/email.txt
		echo "$var_web_v;">>/home/swp/email.txt
		echo "$var_ref;">>/home/swp/email.txt
		echo "$var_sales;">>/home/swp/email.txt
		echo "$var_installedBy;">>/home/swp/email.txt
		echo "iTelSwitchPlusMediaProxy$billing;">>/home/swp/email.txt
		echo "iTelSwitchPlusSignaling$billing;">>/home/swp/email.txt
		echo "$var_user;">>/home/swp/email.txt
		echo "$admin_pass;">>/home/swp/email.txt
		if [ $flg_n_sw -eq 0 ]
		 then
		  flg_n_sw=1;
		  cd /usr/
		  fn_6jdk;
		  #echo -e "\n\n\n\n\n\n\n\n${Black} ################## ${BRed}:: Installing JDK :: ${Black}################${NC}#";
		  #wget http://$var_installer_ip/downloads/jdk6.0_25.tar.gz
		  #echo "Extracting 1.6.0_25........."
		  #tar -zxf jdk6.0_25.tar.gz
		  #echo "Extracted Successfully!!!"
		  rm -rf /usr/local/installerjar
		  #mkdir /usr/local/installerjar
		  rm -rf  /usr/local/src/installerjar
		  mkdir /usr/local/src/installerjar
		  cd /usr/local/src/installerjar
		  wget http://$var_installer_ip/downloads/newinstaller.jar
		  wget http://$var_installer_ip/downloads/switchdelivery.jar
		  wget http://$var_installer_ip/downloads/rateplan.csv
		  wget http://$var_installer_ip/downloads/logo.png
		  wget http://$var_installer_ip/downloads/ShutDown.jar
		  #installer start file
		  echo "cd /usr/local/src/installerjar">runInstaller.sh
		  echo "/usr/jdk1.6.0_25/bin/java -Xmx4096m -jar newinstaller.jar &">>runInstaller.sh
		  echo "cd /usr/local/src/installerjar">runSwitchDelivery.sh
		  echo "/usr/jdk1.6.0_25/bin/java -Xmx400m -jar switchdelivery.jar &">>runSwitchDelivery.sh
		  echo "cd /usr/local/src/installerjar">shutDownInstaller.sh
		  echo "/usr/jdk1.6.0_25/bin/java -jar ShutDown.jar &">>shutDownInstaller.sh
		  #log4j.properties
		  echo "l#Default log level to ERROR. Other levels are INFO and DEBUG.">log4j.properties
		  echo "log4j.rootLogger=, ROOT">>log4j.properties
		  echo "log4j.appender.ROOT=org.apache.log4j.RollingFileAppender">>log4j.properties
		  echo "log4j.appender.ROOT.File= installer.log">>log4j.properties
		  echo "log4j.appender.ROOT.MaxFileSize=8MB">>log4j.properties
		  echo "#Keep 5 old files around.">>log4j.properties
		  echo "log4j.appender.ROOT.MaxBackupIndex=0">>log4j.properties
		  echo "log4j.appender.ROOT.layout=org.apache.log4j.PatternLayout">>log4j.properties
		  echo "#Format almost same as WebSphere's common log format.">>log4j.properties
		  echo "log4j.appender.ROOT.layout.ConversionPattern=%-4r %-5p [%t] (%x) - %m\n">>log4j.properties
		  echo "#Optionally override log level of individual packages or classes">>log4j.properties
		  echo "#log4j.logger.com.webage.ejbs=INFO">>log4j.properties
		   #DatabaseConnection.xml
		   echo "<CONNECTIONS>">DatabaseConnection.xml
		   echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///mysql\"">>DatabaseConnection.xml
		   echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
		   echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
		   echo "</CONNECTIONS>">>DatabaseConnection.xml
		   chmod a+x runInstaller.sh
		   chmod a+x runSwitchDelivery.sh
		   chmod a+x shutDownInstaller.sh
		   sh runInstaller.sh
		 else
		   cd /usr/local/src/installerjar
		   chmod a+x runInstaller.sh
		   chmod a+x shutDownInstaller.sh
		   sh runInstaller.sh
		fi
		echo "---------------------------------------------------------------------------------------";
		echo "Other module will start now...Please wait...";
		echo "---------------------------------------------------------------------------------------";
		echo "........................................................................................"
		sleep 30;
		clear;
		flg_mb=1;
		#Mobile billing
		echo -n "Do you want to install mobile billing? y/n: "
		read yorn;
		while [ -z "${yorn}" ]
			do
				echo -n "Please enter your Choice [Null/Invalid entry not accepted]: "
				read yorn;
			done
		#yorn=y;
		if [ $yorn == y ]
		  then
		   echo "Installing mobile billing now..."
		   #install mobile billing
		   fn_mobileBilling ;
		else
		 echo "mobile billing skipped"
		fi
		sleep 10;
		clear;
		flg_mt=1;
		yorn=n;
		#Mobile top up
		#echo -n "Do you want to install mobile top up? y/n: "
		#read yorn;
		if [ $yorn == y ]
		  then
		   echo "Installing mobile top up now..."
		   #Install mobile top up
		   fn_mobileTopUP;
		else
		 echo "mobile top up skipped"
		fi
		#sleep 10;
		#rm -f /home/installer.log;
		#cd /usr/local/src/installerjar;
		#mv  installer.log  /home/
		#rm -rf  /usr/local/src/installerjar
		clear;
		echo "------System maintenance installation will start. Please wait...--------";
		sleep 3;
		echo "------System maintenance installation will start. Please wait...--------";
		flg_sm=1;
		fn_system_Maintenance;
		sleep 8;
		echo "------DB Health Checker installation will start. Please wait...--------";
		sleep 2;
		flg_DH=1;
		fn_DBHealthChecker;
		sleep 8;
		clear;
		echo "";
		echo "Below summary will add into delivery email.";
		echo "-------------------------------------------";
		echo "";
		cat /home/swp/deliveryEmail.cfg
		echo "";
		echo -n "Do you want to send email? y/n: ";
		read yorn;
		while [ -z "${yorn}" ]
			do
				echo -n "Please enter your Choice [Null/Invalid entry not accepted]: "
				read yorn;
			done
		if [ $yorn == y ]
		 then
		   clear;
		   echo "";
		   echo "Sending email...Please wait...";
		   cd /usr/local/src/installerjar;
		   sh runSwitchDelivery.sh
		else
		  echo "Email Sending skipped.";
		fi
}
function fn_install_Wholesale()
{
		switch_start_time=$(date +%s);
		cd /home/swp
		#initialize
		var_call_capacity=3000;
		var_media_memory=1024;
		var_sig_memory=1024;
		#memory status of server
		fn_server_mem_status;
		echo -n "Memory for Media: ";
		read var_media_memory;
		if [ -z "${var_media_memory}" ]
		 then
			var_media_memory=2048;
		fi
		echo -n "Memory for Signaling: ";
		read var_sig_memory;
		if [ -z "${var_sig_memory}" ]
		 then
			var_sig_memory=2048;
		fi
		echo -n "Switch call volume: ";
		#read var_sw_callvolume
		#while [[ ! $var_sw_callvolume =~ ^[0-9]+$ ]]
		#	do
		#		echo -n "Please enter Switch Call volume [Null/Invalid entry not accepted]: "
		#		read var_sw_callvolume;
		#	done
		echo "----------------------------------------------";
		echo -n "Reference number: ";
		read var_ref;
		while [ -z "${var_ref}" ]
			do
				echo -n "Please enter Reference number [Null/Invalid entry not accepted]: "
				read var_ref;
			done
		#echo -n "Sales executive: ";
		#read var_sales;
		echo -n "Sales executive Email ID: ";
		read var_sales_email;
		while [ -z "${var_sales_email}" ]
			do
				echo -n "Please enter Sales Email [Null/Invalid entry not accepted]: "
				read var_sales_email;
			done
		var_sales=$var_sales_email;
		#echo -n "Switch Installed by: ";
		#read var_installedBy;
		var_installedBy="Installer";
		if [ -z "${var_ref}" ]
		 then
		  var_ref="Demo";
		  echo "Reference number: $var_ref";
		 else
		  echo "Reference number: $var_ref";
		fi
		if [ -z "${var_sales}" ]
		 then
		  var_sales="Demo";
		  echo "Sales executive: $var_sales";
		 else
		  echo "Sales executive: $var_sales";
		fi
		if [ -z "${var_installedBy}" ]
		 then
		  var_installedBy="Demo";
		  echo "Switch Installed by: $var_installedBy";
		 else
		  echo "Switch Installed by: $var_installedBy";
		fi
		echo -n "Enter Customer Email ID: ";
		read email;
		while [ -z "${email}" ]
			do
				echo -n "Please enter Customer Email [Null/Invalid entry not accepted]: "
				read email;
			done
		if [ -z "${email}" ]
		 then
		  #echo "Empty value";
		  email="noreply-support@revesoft.com";
		  echo "Current email id: $email";
		 else
		  #echo "Not empty.";
		  echo "Current email id: $email";
		fi
		echo -n "Enter billing name: ";
		read billing;
		service_name=$billing;
		while [ -z "${billing}" ]
			do
				echo -n "Please enter Billing Name [Null/Invalid entry not accepted]: "
				read billing;
			done
		if [ -z "${billing}" ]
		 then
		  #echo "Empty value";
		  billing="itelbilling";
		  echo "Billing name: $billing";
		 else
		  #echo "Not empty.";
		  echo "Billing name: $billing";
		fi
		echo -n "Administrative User: ";
		read var_user;
		while [ -z "${var_user}" ]
			do
				echo -n "Please enter dministrative User [Null/Invalid entry not accepted]: "
				read var_user;
			done
		echo -n "Administrative password: ";
		read admin_pass;
		while [ -z "${admin_pass}" ]
			do
				echo -n "Please enter Administrative password [Null/Invalid entry not accepted]: "
				read admin_pass;
			done
		if [ -z "${var_user}" ]
		 then
		  var_user="admin";
		  echo "Default User: $var_user";
		 else
		  echo "Default User: $var_user";
		fi
		if [ -z "${admin_pass}" ]
		 then
		  admin_pass="abc1";
		  echo "Default password: $admin_pass";
		 else
		  echo "Default password: $admin_pass";
		fi
		var_web=$billing;
		var_db_itelbilling="iTelBilling$billing";
		var_db_successful="Successful$billing";
		var_db_failed_failed="Failed$billing";
		flg_paid_module="new";
		cd /home/swp
		cp -r  itelbilling $billing
		cp -r  iTelSBCMediaProxy iTelSBCMediaProxy$billing
		cp -r  iTelSBCSignaling iTelSBCSignaling$billing
		cd iTelSBCMediaProxy$billing
		echo "Version: ">version
		echo "Media: $var_media_v">>version
		echo "Signaling: $var_signaling_v">>version
		echo "Web: $var_web_v">>version
		#MediaProxy configuration
		echo  "configuring rtpProperties.cfg";
		echo "";
		echo "-------------------sample-------------------";
		echo "";
		echo "rtpStartPort=4000"
		echo "rtpEndPort=9000"
		echo "OrgrtpStartPort=9100"
		echo "OrgrtpEndPort=13000"
		echo "localListenIP=192.168.100.10"
		echo "localListenPort=62"
		echo "rtpTimeout=60"
		echo "remoteSignalingIP=192.168.100.10"
		echo "remoteSignalingPort=191"
		echo "disableTerminatingToOriginatingRTPQueue=1"
		echo "#terminatingToOriginatingRTPQueueSize=6"
		echo "terminatingToOriginatingRTPPacketSize=80"
		echo "minimumTerminatingToOriginatingRTPQueue=1"
		echo "duplicateOriginatingPacketSendingCount=0"
		echo "minimumAverageForVAD=500"
		echo "ivrFileFolder=/usr/local/iTelSBCMediaProxy/IVR"
		echo "#rtpHeader=0x78534734A7B5E274B6C8E6D3282A6D3F"
		echo "#recordmediafolder=/usr/local/iTelSBCMediaProxy/media/"
		echo "maxCallCapacity=3000"
		echo "supportVideo=1"
		echo "applyorggain=1"
		echo "applytergain=1"
		echo "ivrPlayDuaration=10"
		echo "";
		echo "------------------------------------------";
		echo -n "rtpStartPort: ";
		read rtpStartPort;
		while [[ ! $rtpStartPort =~ ^[0-9]+$ ]]
			do
				echo -n "Please enter rtpStartPort [Null/Invalid entry not accepted]: "
				read rtpStartPort;
			done
		echo -n "rtpEndPort: ";
		read rtpEndPort;
		while [[ ! $rtpEndPort =~ ^[0-9]+$ ]]
			do
				echo -n "Please enter rtpEndPort [Null/Invalid entry not accepted]: "
				read rtpEndPort;
			done
		echo -n "localListenIP: ";
		read localListenIP;
		while [[ ! $localListenIP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]
			do
				echo -n "Please enter localListenIP [Null/Invalid entry not accepted]: "
				read localListenIP;
			done
		echo -n "localListenPort: ";
		read localListenPort;
		while [[ ! $localListenPort =~ ^[0-9]+$ ]]
			do
				echo -n "Please enter localListenPort [Null/Invalid entry not accepted]: "
				read localListenPort;
			done
		echo  "remoteSignalingIP: $localListenIP";
		#read remoteSignalingIP;
		remoteSignalingIP=$localListenIP;
		echo -n "remoteSignalingPort: ";
		read remoteSignalingPort;
		while [[ ! $remoteSignalingPort =~ ^[0-9]+$ ]]
			do
				echo -n "Please enter remoteSignalingPort [Null/Invalid entry not accepted]: "
				read remoteSignalingPort;
			done
		echo "rtpStartPort=$rtpStartPort">rtpProperties.cfg
		echo "rtpEndPort=$rtpEndPort">>rtpProperties.cfg
		echo "voiceListenIP=$localListenIP">>rtpProperties.cfg
		echo "#terListenIP=$localListenIP">>rtpProperties.cfg
		echo "localListenIP=$localListenIP">>rtpProperties.cfg
		echo "localListenPort=$localListenPort">>rtpProperties.cfg
		echo "rtpTimeout=60">>rtpProperties.cfg
		echo "remoteSignalingIP=$remoteSignalingIP">>rtpProperties.cfg
		echo "remoteSignalingPort=$remoteSignalingPort">>rtpProperties.cfg
		echo "maxCallCapacity=10000">>rtpProperties.cfg
		echo "#debug=0">>rtpProperties.cfg
		#Mediaproxy service file
		mv iTelSBCMediaProxy iTelSBCMediaProxy$billing
		echo "#!/bin/sh">iTelSBCMediaProxy$billing
		echo "## iTelSBCMediaProxy   This shell script takes care of starting and stopping iTelSBCMediaProxy">>iTelSBCMediaProxy$billing
		echo "# Source function library.">>iTelSBCMediaProxy$billing
		echo ". /etc/rc.d/init.d/functions">>iTelSBCMediaProxy$billing
		echo "#">>iTelSBCMediaProxy$billing
		var="\$1"
		echo "case \"$var\" in">>iTelSBCMediaProxy$billing
		echo "start)">>iTelSBCMediaProxy$billing
		echo "echo -n \"Starting iTelSwitchPlus MediaProxy$billing:">>iTelSBCMediaProxy$billing
		echo "\"">>iTelSBCMediaProxy$billing
		echo "/usr/local/iTelSBCMediaProxy$billing/runiTelSBCMediaProxy.sh">>iTelSBCMediaProxy$billing
		echo ";;">>iTelSBCMediaProxy$billing
		echo "stop)">>iTelSBCMediaProxy$billing
		echo "echo -n \"Stoping iTelSwitchPlus MediaProxy$billing:">>iTelSBCMediaProxy$billing
		echo "\"">>iTelSBCMediaProxy$billing
		echo "/usr/local/iTelSBCMediaProxy$billing/shutdowniTelSBCMediaProxy.sh">>iTelSBCMediaProxy$billing
		echo "sleep 10">>iTelSBCMediaProxy$billing
		echo ";;">>iTelSBCMediaProxy$billing
		echo "restart)">>iTelSBCMediaProxy$billing
		var="\$0"
		echo "$var stop">>iTelSBCMediaProxy$billing
		echo "$var start">>iTelSBCMediaProxy$billing
		echo ";;">>iTelSBCMediaProxy$billing
		echo "*)">>iTelSBCMediaProxy$billing
		echo "echo \"Usage: $var {start|stop|restart}\"">>iTelSBCMediaProxy$billing
		echo "exit 1">>iTelSBCMediaProxy$billing
		echo "esac">>iTelSBCMediaProxy$billing
		echo "exit 0">>iTelSBCMediaProxy$billing
		#Media start file
		m="m";
		echo "cd /usr/local/iTelSBCMediaProxy$billing">runiTelSBCMediaProxy.sh
		echo "/usr/jdk1.8.0_161/bin/java -Xmx$var_media_memory$m -jar iTelSBCMediaProxy.jar $billing &">>runiTelSBCMediaProxy.sh
		#Media stop file
		echo "cd /usr/local/iTelSBCMediaProxy$billing">shutdowniTelSBCMediaProxy.sh
		echo "/usr/jdk1.8.0_161/bin/java -jar ShutDown.jar">>shutdowniTelSBCMediaProxy.sh
		cp iTelSBCMediaProxy$billing /etc/rc.d/init.d/
		chmod 755 /etc/rc.d/init.d/iTelSBCMediaProxy$billing
		#Media symbolic lilnk. writted into softlink.sh
		echo "chmod 755 /usr/local/iTelSBCMediaProxy$billing/runiTelSBCMediaProxy.sh">softlink.sh
		echo "chmod 755 /usr/local/iTelSBCMediaProxy$billing/shutdowniTelSBCMediaProxy.sh">>softlink.sh
		echo "cp -r iTelSBCMediaProxy$billing /etc/rc.d/init.d/">>softlink.sh
		echo "ln -s ../init.d/iTelSBCMediaProxy$billing /etc/rc.d/rc3.d/S99iTelSBCMediaProxy$billing">>softlink.sh
		echo "ln -s ../init.d/iTelSBCMediaProxy$billing /etc/rc.d/rc5.d/S99iTelSBCMediaProxy$billing">>softlink.sh
		echo "ln -s ../init.d/iTelSBCMediaProxy$billing /etc/rc.d/rc0.d/K10iTelSBCMediaProxy$billing">>softlink.sh
		echo "ln -s ../init.d/iTelSBCMediaProxy$billing /etc/rc.d/rc6.d/K10iTelSBCMediaProxy$billing">>softlink.sh
		cd ../iTelSBCSignaling$billing
		#Signaling start file
		m="m";
		echo "cd /usr/local/iTelSBCSignaling$billing">runiTelSBCSignaling.sh
		echo "/usr/jdk1.8.0_161/bin/java -Xmx$var_sig_memory$m -jar iTelSBC.jar $billing &">>runiTelSBCSignaling.sh
		#Signaling stop file
		echo "cd /usr/local/iTelSBCSignaling$billing">shutdowniTelSBCSignaling.sh
		echo "/usr/jdk1.8.0_161/bin/java -jar ShutDown.jar">>shutdowniTelSBCSignaling.sh
		#Signaling service file
		mv iTelSBCSignaling iTelSBCSignaling$billing
		echo "#!/bin/sh">iTelSBCSignaling$billing
		echo "## iTelSBCSignaling   This shell script takes care of starting and stopping iTelSBCSignaling">>iTelSBCSignaling$billing
		echo "# Source function library.">>iTelSBCSignaling$billing
		echo ". /etc/rc.d/init.d/functions">>iTelSBCSignaling$billing
		echo "#">>iTelSBCSignaling$billing
		var="\$1"
		echo "case \"$var\" in">>iTelSBCSignaling$billing
		echo "start)">>iTelSBCSignaling$billing
		echo "echo -n \"Starting iTelSBCSignaling....$billing:">>iTelSBCSignaling$billing
		echo "\"">>iTelSBCSignaling$billing
		echo "/usr/local/iTelSBCSignaling$billing/runiTelSBCSignaling.sh">>iTelSBCSignaling$billing
		echo ";;">>iTelSBCSignaling$billing
		echo "stop)">>iTelSBCSignaling$billing
		echo "echo -n \"Stoping iTelSBCSignaling.....$billing:">>iTelSBCSignaling$billing
		echo "\"">>iTelSBCSignaling$billing
		echo " /usr/local/iTelSBCSignaling$billing/shutdowniTelSBCSignaling.sh">>iTelSBCSignaling$billing
		echo "sleep 10">>iTelSBCSignaling$billing
		echo ";;">>iTelSBCSignaling$billing
		echo "restart)">>iTelSBCSignaling$billing
		var="\$0"
		echo "$var stop">>iTelSBCSignaling$billing
		echo "$var start">>iTelSBCSignaling$billing
		echo ";;">>iTelSBCSignaling$billing
		echo "*)">>iTelSBCSignaling$billing
		echo "echo \"Usage: $var {start|stop|restart}\"">>iTelSBCSignaling$billing
		echo "exit 1">>iTelSBCSignaling$billing
		echo "esac">>iTelSBCSignaling$billing
		echo "exit 0">>iTelSBCSignaling$billing
		cp iTelSBCSignaling$billing /etc/rc.d/init.d/
		chmod 755 /etc/rc.d/init.d/iTelSBCSignaling$billing
		#Signailng symbolic link. written into softlink.sh
		echo "chmod 755 /usr/local/iTelSBCSignaling$billing/runiTelSBCSignaling.sh">softlink.sh
		echo "chmod 755 /usr/local/iTelSBCSignaling$billing/shutdowniTelSBCSignaling.sh">>softlink.sh
		echo "cp -r iTelSBCSignaling$billing /etc/rc.d/init.d/">>softlink.sh
		echo "ln -s ../init.d/iTelSBCSignaling$billing /etc/rc.d/rc3.d/S99iTelSBCSignaling$billing">>softlink.sh
		echo "ln -s ../init.d/iTelSBCSignaling$billing /etc/rc.d/rc5.d/S99iTelSBCSignaling$billing">>softlink.sh
		echo "ln -s ../init.d/iTelSBCSignaling$billing /etc/rc.d/rc0.d/K10iTelSBCSignaling$billing">>softlink.sh
		echo "ln -s ../init.d/iTelSBCSignaling$billing /etc/rc.d/rc6.d/K10iTelSBCSignaling$billing">>softlink.sh
		#DatabaseConnection_Failed.xml
		echo "<CONNECTIONS>">DatabaseConnection_Failed.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///Failed$billing\"">>DatabaseConnection_Failed.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Failed.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Failed.xml
		echo "</CONNECTIONS>">>DatabaseConnection_Failed.xml
		#DatabaseConnection_Successful.xml
		echo "<CONNECTIONS>">DatabaseConnection_Successful.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///Successful$billing\"">>DatabaseConnection_Successful.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Successful.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Successful.xml
		echo "</CONNECTIONS>">>DatabaseConnection_Successful.xml
		#DatabaseConnection_Reseller.xml
		echo "<CONNECTIONS>">DatabaseConnection_Reseller.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///Successful$billing\"">>DatabaseConnection_Reseller.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Reseller.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Reseller.xml
		echo "</CONNECTIONS>">>DatabaseConnection_Reseller.xml
		#DatabaseConnection.xml
		echo "<CONNECTIONS>">DatabaseConnection.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///iTelBilling$billing?useEncoding=true&amp;characterEncoding=UTF-8\"">>DatabaseConnection.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
		echo "</CONNECTIONS>">>DatabaseConnection.xml
		#configuring web part
		rm -f /home/swp/$billing/WEB-INF/classes/*.xml
		cp -r *.xml /home/swp/$billing/WEB-INF/classes/
		#configuring log4j.properties
		rm -f /home/swp/$billing/WEB-INF/classes/log4j.properties
		rm -rf log4j;
		mkdir log4j;
		cd log4j;
		echo "# Define the root logger with appender file">log4j.properties
		echo "log4j.rootLogger = DEBUG, FILE">>log4j.properties
		echo "# Define the file appender">>log4j.properties
		echo "log4j.appender.FILE=org.apache.log4j.DailyRollingFileAppender">>log4j.properties
		echo "# Set the name of the file">>log4j.properties
		echo "log4j.appender.FILE.File=iTelBilling$billing.log">>log4j.properties
		echo "# Set the immediate flush to true (default)">>log4j.properties
		echo "log4j.appender.FILE.ImmediateFlush=true">>log4j.properties
		echo "# Set the threshold to debug mode">>log4j.properties
		echo "log4j.appender.FILE.Threshold=debug">>log4j.properties
		echo "# Set the append to false, should not overwrite">>log4j.properties
		echo "log4j.appender.FILE.Append=true">>log4j.properties
		echo "# Set the DatePattern">>log4j.properties
		echo "log4j.appender.FILE.DatePattern='.'yyyy-MM-dd">>log4j.properties
		echo "# Define the layout for file appender">>log4j.properties
		echo "log4j.appender.FILE.layout=org.apache.log4j.PatternLayout">>log4j.properties
		echo "log4j.appender.FILE.layout.conversionPattern=%m%n">>log4j.properties
		cp -r log4j.properties /home/swp/$billing/WEB-INF/classes/
		cd ..
		#-----------------server.cfg----------------------------------------
		echo  "configuring server.cfg";
		echo "";
		echo "-------------------sample-------------------";
		echo "";
		echo "#       Server.cfg configuration file"
		echo "# ___________________________________________"
		echo "#"
		echo "# ********** Server ***********"
		echo "orgBindIP=192.168.100.10"
		echo "orgBindPort=5060"
		echo "terBindIP=192.168.100.10"
		echo "terBindPort=600"
		echo "isRegistrar=yes"
		echo "doAuthentication=yes"
		echo "registraionSenderBindPort=91"
		echo "registrationReceiverIPList=192.168.100.10"
		echo "sendNotify=yes"
		echo "# ********** RTP & Timeouts  ***********"
		echo "#mediaProxyPublicIP=209.235.214.122";
		echo "mediaNode=192.168.100.10:62;"
		echo "mediaListenIP=192.168.100.10"
		echo "mediaListenPort=191"
		echo "-----------------------------------------------"
		#echo "orgBindIP"
		#read  orgBindIP;
		echo  "orgBindIP=$remoteSignalingIP"
		echo -n "orgBindPort: "
		read orgBindPort;
		while [[ ! $orgBindPort =~ ^[0-9]+$ ]]
			do
				echo -n "Please enter orgBindPort [Null/Invalid entry not accepted]: "
				read orgBindPort;
			done
		switch_port=$orgBindPort;
		echo -n "registraionSenderBindPort: "
		read registraionSenderBindPort;
		while [[ ! $registraionSenderBindPort =~ ^[0-9]+$ ]]
			do
				echo -n "Please enter registraionSenderBindPort [Null/Invalid entry not accepted]: "
				read registraionSenderBindPort;
			done
		echo -n "activeSessionSenderBindPort: "
		read activeSessionSenderBindPort;
		while [[ ! $activeSessionSenderBindPort =~ ^[0-9]+$ ]]
			do
				echo -n "Please enter orgBindPort [Null/Invalid entry not accepted]: "
				read activeSessionSenderBindPort;
			done
		echo "#       Proxy Server configuration file">config/server.cfg
		echo "# ___________________________________________">>config/server.cfg
		echo "#"
		echo "# ********** Server ***********">>config/server.cfg
		echo "orgBindIP=$remoteSignalingIP">>config/server.cfg
		echo "orgBindPort=$orgBindPort">>config/server.cfg
		echo "isRegistrar=yes">>config/server.cfg
		echo "doAuthentication=yes">>config/server.cfg
		echo "registraionSenderBindPort=$registraionSenderBindPort">>config/server.cfg
		echo "registrationReceiverIPList=$remoteSignalingIP">>config/server.cfg
		echo "sendNotify=yes">>config/server.cfg
		echo "# ********** RTP & Timeouts  ***********">>config/server.cfg
		echo "#mediaProxyPublicIP=209.235.214.122">>config/server.cfg
		echo "mediaNode=$localListenIP:$localListenPort;">>config/server.cfg
		echo "mediaListenIP=$remoteSignalingIP">>config/server.cfg
		echo "mediaListenPort=$remoteSignalingPort">>config/server.cfg
		echo "pushSendTimeForNoResponseCallInSec=5">>config/server.cfg
		echo "maxNumberOfInviteRetransmissionForPinCall=16">>config/server.cfg
		echo "maxNumberOfMessageRetransmissionTimes=10">>config/server.cfg
		echo "registrationDebug=yes">>config/server.cfg
		echo "keepLiveCallLog=no">>config/server.cfg
		echo "enableCodecConversion=yes">>config/server.cfg
		echo "writeDelayedCDRToDB=yes">>config/server.cfg
		echo "activeSessionSenderBindPort=$activeSessionSenderBindPort">>config/server.cfg
		echo "activeSessionReceiverIPList=$remoteSignalingIP">>config/server.cfg
		port=9000
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
		#New entry for backup.cfg
		echo "terBindIP=$remoteSignalingIP">>config/backup.cfg
		echo "terBindPort=$orgBindPort">>config/backup.cfg
		echo "local_ip=127.0.0.1">>config/backup.cfg
		echo "local_port=$port">>config/backup.cfg
		echo "remote_ip=172.0.0.2">>config/backup.cfg
		echo "remote_port=9903">>config/backup.cfg
		echo "public_ip=$remoteSignalingIP">>config/backup.cfg
		echo "public_port=$orgBindPort">>config/backup.cfg
		echo "remote_signaling_ip=104.10.10.20">>config/backup.cfg
		echo "remote_signaling_port=5060">>config/backup.cfg
		echo "remote_mediaListen_port=$remoteSignalingPort">>config/backup.cfg
		echo "my_priority=2">>config/backup.cfg
		echo "remote_priority=1">>config/backup.cfg
		echo "packet_sending_interval_in_sec=5">>config/backup.cfg
		echo "response_timeout_to_change_master_slave_in_sec=15">>config/backup.cfg
		cd ..
		if [ $x_64 -eq 1 ]
		 then
		  echo "$x_64: x86_64: configuraing 64-so...";
		  wget http://$var_installer_ip/downloads/SignalingProxy.so_64
		  wget http://$var_installer_ip/downloads/MediaProxy.so_64
		  mv MediaProxy.so_64 MediaProxy.so
		  mv SignalingProxy.so_64 SignalingProxy.so
		  rm -f iTelSBCMediaProxy$billing/MediaProxy.so
		  rm -f iTelSBCSignaling$billing/SignalingProxy.so
		  mv MediaProxy.so iTelSBCMediaProxy$billing
		  mv SignalingProxy.so iTelSBCSignaling$billing
		 else
		   echo "$x_64: x86_32. configuring 32-so...";
		 fi
		mv iTelSBCMediaProxy$billing /usr/local/
		mv iTelSBCSignaling$billing /usr/local/
		mv $billing /usr/local/jakarta-tomcat-$var_tomcat/webapps/
		#Media symbolic lilnk
		chmod 755 /usr/local/iTelSBCMediaProxy$billing/runiTelSBCMediaProxy.sh
		chmod 755 /usr/local/iTelSBCMediaProxy$billing/shutdowniTelSBCMediaProxy.sh
		ln -s ../init.d/iTelSBCMediaProxy$billing /etc/rc.d/rc3.d/S99iTelSBCMediaProxy$billing
		ln -s ../init.d/iTelSBCMediaProxy$billing /etc/rc.d/rc5.d/S99iTelSBCMediaProxy$billing
		ln -s ../init.d/iTelSBCMediaProxy$billing /etc/rc.d/rc0.d/K10iTelSBCMediaProxy$billing
		ln -s ../init.d/iTelSBCMediaProxy$billing /etc/rc.d/rc6.d/K10iTelSBCMediaProxy$billing
		#Signailng symbolic link
		chmod 755 /usr/local/iTelSBCSignaling$billing/runiTelSBCSignaling.sh
		chmod 755 /usr/local/iTelSBCSignaling$billing/shutdowniTelSBCSignaling.sh
		ln -s ../init.d/iTelSBCSignaling$billing /etc/rc.d/rc3.d/S99iTelSBCSignaling$billing
		ln -s ../init.d/iTelSBCSignaling$billing /etc/rc.d/rc5.d/S99iTelSBCSignaling$billing
		ln -s ../init.d/iTelSBCSignaling$billing /etc/rc.d/rc0.d/K10iTelSBCSignaling$billing
		ln -s ../init.d/iTelSBCSignaling$billing /etc/rc.d/rc6.d/K10iTelSBCSignaling$billing
		switch_end_time=$(date +%s);
		time_elapsed=$((switch_end_time - switch_start_time));
		minute=`expr $time_elapsed / 60`;
		sec=`expr $time_elapsed % 60`;
		echo "------Finish> Total time to complete installation process: $minute min $sec secs-------";
		sleep 2;
		#service  iTelSBCSignaling$billing start
		#service  iTelSBCMediaProxy$billing start
		cd /usr/local/iTelSBCSignaling$billing/
		wget http://$var_installer_ip/downloads/MailAlert.jar
		echo "AdditionalToAddress=support@revesoft.com">>config/emailInfo.cfg
		echo "FromAddress=noreply-support@revesoft.com">>config/emailInfo.cfg
		echo "MailServer=mail.revesoft.com">>config/emailInfo.cfg
		echo "MailSeverPort=2525">>config/emailInfo.cfg
		echo "needAuthenticationFromMailServer=yes">>config/emailInfo.cfg
		echo "authenticationEmailAddress=noreply-support@revesoft.com">>config/emailInfo.cfg
		echo "authenticationEmailPassword=ChangeDPasS01032016#">>config/emailInfo.cfg
		echo "MailSubject=Switch Down alert">>config/emailInfo.cfg
		echo "MailContent=Dear Support,\n  Here is the information about Switch Down: \n Switch IP: $remoteSignalingIP \n Signaling Location: /usr/local/iTelSBCSignaling$billing \n\nRegards,\niTelSwitchMonitoring Team.">>config/emailInfo.cfg
		echo -e "\033[34m################################################################################";
		echo "#                                                                                         #";
		echo "#                              Summary                                                    #";
		echo "#-----------------------------------------------------------------------------------------#";
		echo "#   Billing      : http://$remoteSignalingIP/$billing                                     #";
		echo "#   User         : $var_user                                                              #";
		echo "#   Password     : $admin_pass                                                            #";
		echo "#   Switch ip    : $remoteSignalingIP                                                     #";
		echo "#   Port         : $orgBindPort                                                           #";
		echo "#   Balance Link : http://$remoteSignalingIP/$billing/getclientbalance.do?pin=REPLACE     #";
		echo "#   Media        : iTelSBCMediaProxy$billing                                       #";
		echo "#   Signaling    : iTelSBCSignaling$billing                                        #";
		echo "#   Databases    : iTelBilling$billing, Successful$billing, Failed$billing                #";
		echo "#                                                                                         #";
		echo -e "#########################################################################################${NC}";
		#switch delivery email
		echo "billing=$billing">/home/swp/deliveryEmail.cfg
		echo "salesEmail=$var_sales_email">>/home/swp/deliveryEmail.cfg
		echo "customerEmail=$email">>/home/swp/deliveryEmail.cfg
		echo "supportEmail=support@itelbilling.com">>/home/swp/deliveryEmail.cfg
		echo "billingURL=http://$remoteSignalingIP/$billing">>/home/swp/deliveryEmail.cfg
		echo "switchIP=$remoteSignalingIP">>/home/swp/deliveryEmail.cfg
		echo "switchPORT=$orgBindPort">>/home/swp/deliveryEmail.cfg
		echo "IVRExt=101">>/home/swp/deliveryEmail.cfg
		echo "balanceLink=http://$remoteSignalingIP/$billing/getclientbalance.do?pin=REPLACE">>/home/swp/deliveryEmail.cfg
		echo "installedBy=$var_installedBy;">>/home/swp/deliveryEmail.cfg
		#admin_pass="admin";
		echo "iTelBilling$billing;">/home/swp/db.txt
		echo "Successful$billing;">>/home/swp/db.txt
		echo "Failed$billing;">>/home/swp/db.txt
		echo "$remoteSignalingIP;">>/home/swp/db.txt
		echo "$activeSessionSenderBindPort;">>/home/swp/db.txt
		echo "$var_user;">>/home/swp/db.txt
		echo "$admin_pass;">>/home/swp/db.txt
		echo "$orgBindPort;">>/home/swp/db.txt
		echo "$email;">>/home/swp/db.txt
		echo "$var_billing_v;">>/home/swp/db.txt
		#echo "$var_sw_callvolume;">>/home/swp/db.txt
		echo "$billing;">>/home/swp/db.txt
		echo "iTelSwitchPlusMediaProxy$billing;">>/home/swp/db.txt
		echo "$remoteSignalingIP;">/home/swp/track.txt
		echo "$rtpStartPort;">>/home/swp/track.txt
		echo "$rtpEndPort;">>/home/swp/track.txt
		echo "$orgBindPort;">>/home/swp/track.txt
		echo "$orgBindPort,$registraionSenderBindPort,$localListenPort,$remoteSignalingPort;">>/home/swp/track.txt
		echo "$billing;">>/home/swp/track.txt
		echo "$var_ref;">>/home/swp/track.txt
		echo "$var_sales;">>/home/swp/track.txt
		echo "$var_installedBy;">>/home/swp/track.txt
		echo "$var_media_v;">>/home/swp/track.txt
		echo "$var_signaling_v;">>/home/swp/track.txt
		echo "$var_web_v;">>/home/swp/track.txt
		echo "http://$remoteSignalingIP/$billing;">/home/swp/email.txt
		echo "$remoteSignalingIP;">>/home/swp/email.txt
		echo "$orgBindPort;">>/home/swp/email.txt
		echo "$var_media_v;">>/home/swp/email.txt
		echo "$var_signaling_v;">>/home/swp/email.txt
		echo "$var_web_v;">>/home/swp/email.txt
		echo "$var_ref;">>/home/swp/email.txt
		echo "$var_sales;">>/home/swp/email.txt
		echo "$var_installedBy;">>/home/swp/email.txt
		echo "iTelSBCMediaProxy$billing;">>/home/swp/email.txt
		echo "iTelSBCSignaling$billing;">>/home/swp/email.txt
		echo "$var_user;">>/home/swp/email.txt
		echo "$admin_pass;">>/home/swp/email.txt
		if [ $flg_n_sw -eq 0 ]
		 then
		  flg_n_sw=1;
		  cd /usr/
		  fn_6jdk;
		  #echo -e "\n\n\n\n\n\n\n\n${Black} ################## ${BRed}:: Installing JDK :: ${Black}################${NC}#";
		  #wget http://$var_installer_ip/downloads/jdk6.0_25.tar.gz
		  #echo "Extracting 1.6.0_25........."
		  #tar -zxf jdk6.0_25.tar.gz
		  #echo "Extracted Successfully!!!"
		  rm -rf /usr/local/installerjar
		  #mkdir /usr/local/installerjar
		  rm -rf  /usr/local/src/installerjar
		  mkdir /usr/local/src/installerjar
		  cd /usr/local/src/installerjar
		  wget http://$var_installer_ip/downloads/WholeSaleInstaller.jar
		  wget http://$var_installer_ip/downloads/WholesaleDelivery.jar
		  wget http://$var_installer_ip/downloads/Wholesale_logo.png
		  wget http://$var_installer_ip/downloads/ShutDown.jar
		  #installer start file
		  echo "cd /usr/local/src/installerjar">runInstaller.sh
		  echo "/usr/jdk1.6.0_25/bin/java -Xmx4096m -jar WholeSaleInstaller.jar &">>runInstaller.sh
		  echo "cd /usr/local/src/installerjar">runSwitchDelivery.sh
		  echo "/usr/jdk1.6.0_25/bin/java -Xmx400m -jar WholesaleDelivery.jar &">>runSwitchDelivery.sh
		  echo "cd /usr/local/src/installerjar">shutDownInstaller.sh
		  echo "/usr/jdk1.6.0_25/bin/java -jar ShutDown.jar &">>shutDownInstaller.sh
		 #log4j.properties
		  echo "l#Default log level to ERROR. Other levels are INFO and DEBUG.">log4j.properties
		  echo "log4j.rootLogger=, ROOT">>log4j.properties
		  echo "log4j.appender.ROOT=org.apache.log4j.RollingFileAppender">>log4j.properties
		  echo "log4j.appender.ROOT.File= installer.log">>log4j.properties
		  echo "log4j.appender.ROOT.MaxFileSize=8MB">>log4j.properties
		  echo "#Keep 5 old files around.">>log4j.properties
		  echo "log4j.appender.ROOT.MaxBackupIndex=0">>log4j.properties
		  echo "log4j.appender.ROOT.layout=org.apache.log4j.PatternLayout">>log4j.properties
		  echo "#Format almost same as WebSphere's common log format.">>log4j.properties
		  echo "log4j.appender.ROOT.layout.ConversionPattern=%-4r %-5p [%t] (%x) - %m\n">>log4j.properties
		  echo "#Optionally override log level of individual packages or classes">>log4j.properties
		  echo "#log4j.logger.com.webage.ejbs=INFO">>log4j.properties
		   #DatabaseConnection.xml
		   echo "<CONNECTIONS>">DatabaseConnection.xml
		   echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///mysql\"">>DatabaseConnection.xml
		   echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
		   echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
		   echo "</CONNECTIONS>">>DatabaseConnection.xml
		   chmod a+x runInstaller.sh
		   chmod a+x runSwitchDelivery.sh
		   chmod a+x shutDownInstaller.sh
		   sh runInstaller.sh
		 else
		   cd /usr/local/src/installerjar
		   chmod a+x runInstaller.sh
		   chmod a+x shutDownInstaller.sh
		   sh runInstaller.sh
		fi
		sleep 5;
		echo "Installing App Server"
		WholeSaleApp;
		echo "Installation Done!!"
		clear;
		echo "";
		echo "Below summary will add into delivery email.";
		echo "-------------------------------------------";
		echo "";
		cat /home/swp/deliveryEmail.cfg
		echo "";
		echo -n "Do you want to send email? y/n: ";
		read yorn;
		while [ -z "${yorn}" ]
			do
				echo -n "Please enter your Choice [Null/Invalid entry not accepted]: "
				read yorn;
			done
		if [ $yorn == y ]
		 then
		   clear;
		   echo "";
		   echo "Sending email...Please wait...";
		   cd /usr/local/src/installerjar;
		   sh runSwitchDelivery.sh
		else
		  echo "Email Sending skipped.";
		fi
}
function fn_mysql_install(){
	checkOSProfile
	echo -e "${BBlue}Your server OS profile:"
	# cat /etc/redhat-release
	echo "OS: $OS"
	echo "DIST: $DIST"
	echo "PSUEDONAME: $PSUEDONAME"
	echo "REV: $REV"
	echo "DistroBasedOn: $DistroBasedOn"
	echo "KERNEL: $KERNEL"
	echo "MACH: $MACH"
	echo -e "========${NC}"
	osMajorVersion=`echo $REV | gawk -F. '{print $1}'`
	osDist=`lowercase $(echo $DIST | sed 's/ //g')`
	echo "OS Major Version: $osMajorVersion"
	# if [[ "$DIST" == *"Red Hat"* ]] || [[ "$DIST" == *"CentOS"* ]]; then
	if [[ "$DIST" == *"redhat"* ]] || [[ "$DIST" == *"centos"* ]]; then
		if [ $osMajorVersion -eq 7 ] || [ $osMajorVersion -eq 8 ];then
			OS_IS_7=1;
			#my.cnf
			fn_mysql_7;
			echo "MySQL Installation Done. Configuring conf and service file"
			fn_my_dot_cnf;
		elif [ $osMajorVersion -eq 6 ];then
			#mysql
			OS_IS_7=0;
			#my.cnf
			fn_mysql;
			fn_my_dot_cnf;
		else
			echo "OS Version is unknown"
		fi
	else
		echo "OS Distro is different version"
	fi
	# echo -n "Are you preparing CentOS/Red-Hat 7?(y/n)"
	# read yorn;
	# if [ $yorn == y ];then
		# OS_IS_7=1;
		# #my.cnf
		# fn_mysql_7;
		# echo "MySQL Installation Done. Configuring conf and service file"
		# fn_my_dot_cnf;
	# else
		# #mysql
		# OS_IS_7=0;
		# #my.cnf
		# fn_mysql;
		# fn_my_dot_cnf;
	# fi
}
lowercase(){
	echo "$1" > /home/a.txt
	echo "$1" | sed "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/"
}

#SMS Server by Shahneel Starts
function fn_mongodb_yum(){
	sed -i '/exclude=mongodb-org,mongodb-org-server,mongodb-org-shell,mongodb-org-mongos,mongodb-org-tools/d' $YUM_CONF
	echo "[mongodb-org-4.2]" > $MONGODB_REPO
	echo "name=MongoDB Repository" >> $MONGODB_REPO
	echo "baseurl=https://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/4.2/x86_64/" >> $MONGODB_REPO
	echo "gpgcheck=1" >> $MONGODB_REPO
	echo "enabled=1" >> $MONGODB_REPO
	echo "gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc" >> $MONGODB_REPO
	sudo yum install -y mongodb-org
	chkMongoExclusionYum=$(cat $YUM_CONF | grep mongo);
	if [ -z $chkMongoExclusionYum ];then
		echo "exclude=mongodb-org,mongodb-org-server,mongodb-org-shell,mongodb-org-mongos,mongodb-org-tools" >> $YUM_CONF
		echo "DISABLED AUTO UPDATE FOR MongoDB";
	else
		echo "FOUND $chkMongoExclusionYum";
		echo "NO CHANGES DONE $YUM_CONF";
	fi
	sudo service mongod start
	sudo chkconfig mongod on
	# TODO: Check if mongod installed if not prompt user
	mongo --eval "printjson(db.serverStatus().version)";
	# mongoInstallTrial=1;
}
function fn_mongodb_rpm(){
	rm -rf /home/mongo_resource
	mkdir /home/mongo_resource
	cd /home/mongo_resource
	wget -q http://$var_installer_ip/downloads/mongodb/mongodb-org-4.2.6-1.el6.x86_64.rpm
	wget -q http://$var_installer_ip/downloads/mongodb/mongodb-org-mongos-4.2.6-1.el6.x86_64.rpm
	wget -q http://$var_installer_ip/downloads/mongodb/mongodb-org-server-4.2.6-1.el6.x86_64.rpm
	wget -q http://$var_installer_ip/downloads/mongodb/mongodb-org-shell-4.2.6-1.el6.x86_64.rpm
	wget -q http://$var_installer_ip/downloads/mongodb/mongodb-org-tools-4.2.6-1.el6.x86_64.rpm
	rpm -ivh mongodb-org-server-4.2.6-1.el6.x86_64.rpm
	rpm -ivh mongodb-org-mongos-4.2.6-1.el6.x86_64.rpm
	rpm -ivh mongodb-org-shell-4.2.6-1.el6.x86_64.rpm
	rpm -ivh mongodb-org-tools-4.2.6-1.el6.x86_64.rpm
	rpm -ivh mongodb-org-4.2.6-1.el6.x86_64.rpm
	sudo service mongod start
	sudo chkconfig mongod on
	mongo --eval "printjson(db.serverStatus().version)";
	# mongoInstallTrial=1;
	cd -
}
function fn_mongo_install_menu(){
	while :
	  do
		clear
		# if [ $flg_sleep -eq 0 ]
			# then
			  # flg_sleep=1;
			  # #time_out;
			  # pwd > pw;
			  # var_rm=$(<pw);
			  # var_rm="$var_rm/binstaller";
			  # rm -f $var_rm;
			  # rm -f pw;
		# fi
		#echo -e " "
		echo -e "\033[34m  _____________________________________";
		echo -e "\033[34m |${Purple}           Install MongoDB          ${NC} \033[34m|";
		echo -e "\033[34m |_____________________________________|";
		echo -e "\033[34m | ${Green} [1] Install with YUM (v4.2+)  \033[34m     |";
		echo -e "\033[34m | ${Green} [2] Install with RPM (v4.2.6) \033[34m     |";
		if [ $mongoInstallTrial -eq 1 ]; then
			echo -e "\033[34m | ${Red} [0] Exit/Stop                 \033[34m     |"
		fi
		echo -e "\033[34m |_____________________________________|"
		if [ $mongoInstallTrial -eq 1 ]; then
			echo -e -n "${Purple}  Select the task [1 or 2] or '0' for exit: ${NC}"
		else
			echo -e -n "${Purple}  Select the task [1 or 2] ${NC}"
		fi
		read installMethod;
		case $installMethod in
		1)
			fn_mongodb_yum;
			mongoInstallTrial=1;
		echo "Press enter to exit."
		read
		;;
		2)
			fn_mongodb_rpm;
			mongoInstallTrial=1;
		echo "Press enter to exit."
		read
		;;
		0) break ;;
			*) echo "Please select number at least one option"; read ;;
	   esac
	done
}
function fn_mongod_cnf(){
	find /etc -name mongod.conf | grep mongod.conf && var_MONGODB_CONF=1 || var_MONGODB_CONF=0;
	find /var/lib  -name mongo | grep mongo && var_mongo=1 || var_mongo=0;
	if [ $var_mongo -eq 1 ] && [ $var_MONGODB_CONF -eq 1 ];then
		MongoDB_v=$(mongo --eval "printjson(db.serverStatus().version)" | grep "server version" | gawk -F: '{print $2}');
		echo "MongoDB $MongoDB_v exists";
	elif [ $var_mongo -eq 1 ] && [ $var_MONGODB_CONF -eq 0 ];then
		MongoDB_v=$(mongo --eval "printjson(db.serverStatus().version)" | grep "server version" | gawk -F: '{print $2}');
		echo "MongoDB $MongoDB_v exists! Please configure $MONGODB_CONF";
	elif [ $var_mongo -eq 0 ];then
		echo "Installing MongoDB";
		fn_mongo_install_menu;
	else
		echo "Configuring $MONGODB_CONF";
	fi
}
function WholeSaleSMSApp(){
	#jdk
	flg_jdk=0
	if [ $flg_jdk -eq 0 ];then
		fn_jdk_8;
	else
		echo "JDK: $var_jdk"
	fi
	find /usr/local/  -name iTelSMSAppServer$billing | grep iTelSMSAppServer$billing && var_apps=1 || var_apps=0
	if [ $var_apps -eq 1 ];then
		echo "iTelSMSAppServer$billing exists"
	else
		echo "Configuring iTelSMSAppServer$billing ..."
		rm -rf /home/appwsms;
		mkdir  /home/appwsms;
		cd /home/appwsms;
		wget --no-check-certificate $resource_portal/media/Installer/iTelSMSAppServer.zip
		echo "Extracting iTelSMSAppServer........"
		unzip -q iTelSMSAppServer.zip
		echo "iTelSMSAppServer Extracted!!"
		mv iTelSMSAppServer  iTelSMSAppServer$billing;
		cd iTelSMSAppServer$billing;
		#mv iTelSMSAppServer$billing  /usr/local
		#cd /usr/local/iTelSMSAppServer$billing
		rm -f *.xml
		#DatabaseConnection.xml
		echo "<CONNECTIONS>">DatabaseConnection.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///iTelSMS$billing?useSSL=false&amp;useUnicode=true&amp;characterEncoding=utf-8\"">>DatabaseConnection.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
		echo "</CONNECTIONS>">>DatabaseConnection.xml
		mongoDBContacts=$billing"SMSContacts";
		mongoDBCampaigns=$billing"SMSCampaigns";
		echo $"use $mongoDBContacts\ndb" | mongo
		echo $"use $mongoDBContacts\ndb" | mongo >> $LOGFILE
		echo $"use $mongoDBCampaigns\ndb" | mongo
		echo $"use $mongoDBCampaigns\ndb" | mongo >> $LOGFILE
		echo -e "<CONNECTIONS>" > DatabaseConnectionMongo.xml
		echo -e "\t<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mongodb.client.MongoClient\"" >> DatabaseConnectionMongo.xml
		echo -e "\t\tDATABASE_URL=\"mongodb://127.0.0.1:27017\" DATABASE=\"$mongoDBContacts\"" >> DatabaseConnectionMongo.xml
		echo -e "\t\tUSER_NAME=\"root\" PASSWORD=\"\" IS_DEFAULT=\"TRUE\" DATABASE_TYPE=\"CONTACT\"/>" >> DatabaseConnectionMongo.xml
		echo -e "\t<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mongodb.client.MongoClient\"" >> DatabaseConnectionMongo.xml
		echo -e "\t\tDATABASE_URL=\"mongodb://127.0.0.1:27017\" DATABASE=\"$mongoDBCampaigns\"" >> DatabaseConnectionMongo.xml
		echo -e "\t\tUSER_NAME=\"root\" PASSWORD=\"\" IS_DEFAULT=\"TRUE\" DATABASE_TYPE=\"CAMPAIGN\"/>" >> DatabaseConnectionMongo.xml
		echo -e "</CONNECTIONS>" >> DatabaseConnectionMongo.xml
		echo "# Define the root logger with appender file">log4j.properties
		echo "log4j.rootLogger = DEBUG, FILE">>log4j.properties
		echo "# Define the file appender">>log4j.properties
		echo "log4j.appender.FILE=org.apache.log4j.DailyRollingFileAppender">>log4j.properties
		echo "# Set the name of the file">>log4j.properties
		echo "log4j.appender.FILE.File=iTelSMSAppServer$billing.log">>log4j.properties
		echo "# Set the immediate flush to true (default)">>log4j.properties
		echo "log4j.appender.FILE.ImmediateFlush=true">>log4j.properties
		echo "# Set the threshold to debug mode">>log4j.properties
		echo "log4j.appender.FILE.Threshold=debug">>log4j.properties
		echo "# Set the append to false, should not overwrite">>log4j.properties
		echo "log4j.appender.FILE.Append=true">>log4j.properties
		echo "# Set the DatePattern">>log4j.properties
		echo "log4j.appender.FILE.DatePattern='.'yyyy-MM-dd">>log4j.properties
		echo "# Define the layout for file appender">>log4j.properties
		echo "log4j.appender.FILE.layout=org.apache.log4j.PatternLayout">>log4j.properties
		echo "log4j.appender.FILE.layout.conversionPattern=%d{yyyy-MM-dd HH:mm:ss} %-5p %c{1}:%L - %m%n">>log4j.properties
		rm -f runSMS_Server.sh shutdownSMS_Server.sh softlink.sh shutdown.sh
		echo "cd /usr/local/iTelSMSAppServer$billing">runiTelSMSAppServer.sh
		echo "$var_jdk/bin/java -Xmx1024m -jar iTelSMSAppServer.jar $billing &">>runiTelSMSAppServer.sh
		echo "cd /usr/local/iTelSMSAppServer$billing">shutdowniTelSMSAppServer.sh
		echo "$var_jdk/bin/java -jar ShutDown.jar">>shutdowniTelSMSAppServer.sh
		echo "#!/bin/sh">iTelSMSAppServer$billing
		echo "## iTelSMSAppServer   This shell script takes care of starting and stopping iTelSMSAppServer">>iTelSMSAppServer$billing
		echo "# Source function library.">>iTelSMSAppServer$billing
		echo ". /etc/rc.d/init.d/functions">>iTelSMSAppServer$billing
		echo "#">>iTelSMSAppServer$billing
		var="\$1"
		echo "case \"$var\" in">>iTelSMSAppServer$billing
		echo "start)">>iTelSMSAppServer$billing
		echo "echo -n \"Starting iTelSMSAppServer....$billing:">>iTelSMSAppServer$billing
		echo "\"">>iTelSMSAppServer$billing
		echo "/usr/local/iTelSMSAppServer$billing/runiTelSMSAppServer.sh">>iTelSMSAppServer$billing
		echo ";;">>iTelSMSAppServer$billing
		echo "stop)">>iTelSMSAppServer$billing
		echo "echo -n \"Stoping iTelSMSAppServer.....$billing:">>iTelSMSAppServer$billing
		echo "\"">>iTelSMSAppServer$billing
		echo "/usr/local/iTelSMSAppServer$billing/shutdowniTelSMSAppServer.sh">>iTelSMSAppServer$billing
		echo "sleep 10">>iTelSMSAppServer$billing
		echo ";;">>iTelSMSAppServer$billing
		echo "restart)">>iTelSMSAppServer$billing
		var="\$0"
		echo "$var stop">>iTelSMSAppServer$billing
		echo "$var start">>iTelSMSAppServer$billing
		echo ";;">>iTelSMSAppServer$billing
		echo "*)">>iTelSMSAppServer$billing
		echo "echo \"Usage: $var {start|stop|restart}\"">>iTelSMSAppServer$billing
		echo "exit 1">>iTelSMSAppServer$billing
		echo "esac">>iTelSMSAppServer$billing
		echo "exit 0">>iTelSMSAppServer$billing
		#iTelSMSAppServer symbolic link. written into softlink.sh
		echo "chmod 755 /usr/local/iTelSMSAppServer$billing/runiTelSMSAppServer.sh">softlink.sh
		echo "chmod 755 /usr/local/iTelSMSAppServer$billing/shutdowniTelSMSAppServer.sh">>softlink.sh
		echo "ln -s ../init.d/iTelSMSAppServer$billing /etc/rc.d/rc3.d/S99iTelSMSAppServer$billing">>softlink.sh
		echo "ln -s ../init.d/iTelSMSAppServer$billing /etc/rc.d/rc5.d/S99iTelSMSAppServer$billing">>softlink.sh
		echo "ln -s ../init.d/iTelSMSAppServer$billing /etc/rc.d/rc0.d/K10iTelSMSAppServer$billing">>softlink.sh
		echo "ln -s ../init.d/iTelSMSAppServer$billing /etc/rc.d/rc6.d/K10iTelSMSAppServer$billing">>softlink.sh
		cp iTelSMSAppServer$billing  /etc/rc.d/init.d/
		chmod 755 /etc/rc.d/init.d/iTelSMSAppServer$billing
		ln -s ../init.d/iTelSMSAppServer$billing /etc/rc.d/rc3.d/S99iTelSMSAppServer$billing
		ln -s ../init.d/iTelSMSAppServer$billing /etc/rc.d/rc5.d/S99iTelSMSAppServer$billing
		ln -s ../init.d/iTelSMSAppServer$billing /etc/rc.d/rc0.d/K10iTelSMSAppServer$billing
		ln -s ../init.d/iTelSMSAppServer$billing /etc/rc.d/rc6.d/K10iTelSMSAppServer$billing
		cd /home/appwsms;
		mv iTelSMSAppServer$billing  /usr/local
		chmod 755 /usr/local/iTelSMSAppServer$billing/runiTelSMSAppServer.sh
		chmod 755 /usr/local/iTelSMSAppServer$billing/shutdowniTelSMSAppServer.sh
		cd /usr/local/iTelSMSAppServer$billing
		echo "MAIL_SEND_TYPE=Default">Configuration.properties
		echo "LAST_CALL_INFO_TAKEN_DAY=$(date +%F)">>Configuration.properties
		echo "INVOICE_GENERATION_BASE_URL=http://$smsServerIP/$billing/billgeneration/BillDownload.jsp">>Configuration.properties
		service iTelSMSAppServer$billing start
	fi
}


function WholeSaleSMSApp4(){
	#jdk
	flg_jdk=0
	if [ $flg_jdk -eq 0 ];then
		fn_jdk_8;
	else
		echo "JDK: $var_jdk"
	fi
	find /usr/local/  -name iTelSMSAppServer$billing | grep iTelSMSAppServer$billing && var_apps=1 || var_apps=0
	if [ $var_apps -eq 1 ];then
		echo "iTelSMSAppServer$billing exists"
	else
		echo "Configuring iTelSMSAppServer$billing ..."
		rm -rf /home/appwsms;
		mkdir  /home/appwsms;
		cd /home/appwsms;
		wget --no-check-certificate $resource_portal/media/Installer/iTelSMSAppServer4.zip
		echo "Extracting iTelSMSAppServer........"
		unzip -q iTelSMSAppServer4.zip
		echo "iTelSMSAppServer Extracted!!"
		mv iTelSMSAppServer  iTelSMSAppServer$billing;
		cd iTelSMSAppServer$billing;
		#mv iTelSMSAppServer$billing  /usr/local
		#cd /usr/local/iTelSMSAppServer$billing
		rm -f *.xml
		#DatabaseConnection.xml
		echo "<CONNECTIONS>">DatabaseConnection.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.cj.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///iTelSMS$billing?useSSL=false&amp;useUnicode=true&amp;characterEncoding=utf-8\"">>DatabaseConnection.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
		echo "</CONNECTIONS>">>DatabaseConnection.xml
		mongoDBContacts=$billing"SMSContacts";
		mongoDBCampaigns=$billing"SMSCampaigns";
		echo $"use $mongoDBContacts\ndb" | mongo
		echo $"use $mongoDBContacts\ndb" | mongo >> $LOGFILE
		echo $"use $mongoDBCampaigns\ndb" | mongo
		echo $"use $mongoDBCampaigns\ndb" | mongo >> $LOGFILE
		echo -e "<CONNECTIONS>" > DatabaseConnectionMongo.xml
		echo -e "\t<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mongodb.client.MongoClient\"" >> DatabaseConnectionMongo.xml
		echo -e "\t\tDATABASE_URL=\"mongodb://127.0.0.1:27017\" DATABASE=\"$mongoDBContacts\"" >> DatabaseConnectionMongo.xml
		echo -e "\t\tUSER_NAME=\"root\" PASSWORD=\"\" IS_DEFAULT=\"TRUE\" DATABASE_TYPE=\"CONTACT\"/>" >> DatabaseConnectionMongo.xml
		echo -e "\t<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mongodb.client.MongoClient\"" >> DatabaseConnectionMongo.xml
		echo -e "\t\tDATABASE_URL=\"mongodb://127.0.0.1:27017\" DATABASE=\"$mongoDBCampaigns\"" >> DatabaseConnectionMongo.xml
		echo -e "\t\tUSER_NAME=\"root\" PASSWORD=\"\" IS_DEFAULT=\"TRUE\" DATABASE_TYPE=\"CAMPAIGN\"/>" >> DatabaseConnectionMongo.xml
		echo -e "</CONNECTIONS>" >> DatabaseConnectionMongo.xml
		echo "# Define the root logger with appender file">log4j.properties
		echo "log4j.rootLogger = DEBUG, FILE">>log4j.properties
		echo "# Define the file appender">>log4j.properties
		echo "log4j.appender.FILE=org.apache.log4j.DailyRollingFileAppender">>log4j.properties
		echo "# Set the name of the file">>log4j.properties
		echo "log4j.appender.FILE.File=iTelSMSAppServer$billing.log">>log4j.properties
		echo "# Set the immediate flush to true (default)">>log4j.properties
		echo "log4j.appender.FILE.ImmediateFlush=true">>log4j.properties
		echo "# Set the threshold to debug mode">>log4j.properties
		echo "log4j.appender.FILE.Threshold=debug">>log4j.properties
		echo "# Set the append to false, should not overwrite">>log4j.properties
		echo "log4j.appender.FILE.Append=true">>log4j.properties
		echo "# Set the DatePattern">>log4j.properties
		echo "log4j.appender.FILE.DatePattern='.'yyyy-MM-dd">>log4j.properties
		echo "# Define the layout for file appender">>log4j.properties
		echo "log4j.appender.FILE.layout=org.apache.log4j.PatternLayout">>log4j.properties
		echo "log4j.appender.FILE.layout.conversionPattern=%d{yyyy-MM-dd HH:mm:ss} %-5p %c{1}:%L - %m%n">>log4j.properties
		rm -f runSMS_Server.sh shutdownSMS_Server.sh softlink.sh shutdown.sh
		echo "cd /usr/local/iTelSMSAppServer$billing">runiTelSMSAppServer.sh
		echo "$var_jdk/bin/java -Xmx1024m -jar iTelSMSAppServer.jar $billing &">>runiTelSMSAppServer.sh
		echo "cd /usr/local/iTelSMSAppServer$billing">shutdowniTelSMSAppServer.sh
		echo "$var_jdk/bin/java -jar ShutDown.jar">>shutdowniTelSMSAppServer.sh
		echo "#!/bin/sh">iTelSMSAppServer$billing
		echo "## iTelSMSAppServer   This shell script takes care of starting and stopping iTelSMSAppServer">>iTelSMSAppServer$billing
		echo "# Source function library.">>iTelSMSAppServer$billing
		echo ". /etc/rc.d/init.d/functions">>iTelSMSAppServer$billing
		echo "#">>iTelSMSAppServer$billing
		var="\$1"
		echo "case \"$var\" in">>iTelSMSAppServer$billing
		echo "start)">>iTelSMSAppServer$billing
		echo "echo -n \"Starting iTelSMSAppServer....$billing:">>iTelSMSAppServer$billing
		echo "\"">>iTelSMSAppServer$billing
		echo "/usr/local/iTelSMSAppServer$billing/runiTelSMSAppServer.sh">>iTelSMSAppServer$billing
		echo ";;">>iTelSMSAppServer$billing
		echo "stop)">>iTelSMSAppServer$billing
		echo "echo -n \"Stoping iTelSMSAppServer.....$billing:">>iTelSMSAppServer$billing
		echo "\"">>iTelSMSAppServer$billing
		echo "/usr/local/iTelSMSAppServer$billing/shutdowniTelSMSAppServer.sh">>iTelSMSAppServer$billing
		echo "sleep 10">>iTelSMSAppServer$billing
		echo ";;">>iTelSMSAppServer$billing
		echo "restart)">>iTelSMSAppServer$billing
		var="\$0"
		echo "$var stop">>iTelSMSAppServer$billing
		echo "$var start">>iTelSMSAppServer$billing
		echo ";;">>iTelSMSAppServer$billing
		echo "*)">>iTelSMSAppServer$billing
		echo "echo \"Usage: $var {start|stop|restart}\"">>iTelSMSAppServer$billing
		echo "exit 1">>iTelSMSAppServer$billing
		echo "esac">>iTelSMSAppServer$billing
		echo "exit 0">>iTelSMSAppServer$billing
		#iTelSMSAppServer symbolic link. written into softlink.sh
		echo "chmod 755 /usr/local/iTelSMSAppServer$billing/runiTelSMSAppServer.sh">softlink.sh
		echo "chmod 755 /usr/local/iTelSMSAppServer$billing/shutdowniTelSMSAppServer.sh">>softlink.sh
		echo "ln -s ../init.d/iTelSMSAppServer$billing /etc/rc.d/rc3.d/S99iTelSMSAppServer$billing">>softlink.sh
		echo "ln -s ../init.d/iTelSMSAppServer$billing /etc/rc.d/rc5.d/S99iTelSMSAppServer$billing">>softlink.sh
		echo "ln -s ../init.d/iTelSMSAppServer$billing /etc/rc.d/rc0.d/K10iTelSMSAppServer$billing">>softlink.sh
		echo "ln -s ../init.d/iTelSMSAppServer$billing /etc/rc.d/rc6.d/K10iTelSMSAppServer$billing">>softlink.sh
		cp iTelSMSAppServer$billing  /etc/rc.d/init.d/
		chmod 755 /etc/rc.d/init.d/iTelSMSAppServer$billing
		ln -s ../init.d/iTelSMSAppServer$billing /etc/rc.d/rc3.d/S99iTelSMSAppServer$billing
		ln -s ../init.d/iTelSMSAppServer$billing /etc/rc.d/rc5.d/S99iTelSMSAppServer$billing
		ln -s ../init.d/iTelSMSAppServer$billing /etc/rc.d/rc0.d/K10iTelSMSAppServer$billing
		ln -s ../init.d/iTelSMSAppServer$billing /etc/rc.d/rc6.d/K10iTelSMSAppServer$billing
		cd /home/appwsms;
		mv iTelSMSAppServer$billing  /usr/local
		chmod 755 /usr/local/iTelSMSAppServer$billing/runiTelSMSAppServer.sh
		chmod 755 /usr/local/iTelSMSAppServer$billing/shutdowniTelSMSAppServer.sh
		cd /usr/local/iTelSMSAppServer$billing
		echo "MAIL_SEND_TYPE=Default">Configuration.properties
		echo "LAST_CALL_INFO_TAKEN_DAY=$(date +%F)">>Configuration.properties
		echo "INVOICE_GENERATION_BASE_URL=http://$smsServerIP/$billing/billgeneration/BillDownload.jsp">>Configuration.properties
		service iTelSMSAppServer$billing start
	fi
}
function fn_install_WholesaleSMS(){
	switch_start_time=$(date +%s);
	cd /home/wsms
	#initialize
	var_wsms_memory=1024;
	#memory status of server
	fn_server_mem_status;
	echo -n "Memory for WholesaleSMS: ";
	read var_wsms_memory;
	if [ -z "${var_wsms_memory}" ];then
		var_wsms_memory=2048;
	fi
	echo "----------------------------------------------";
	echo -n "Reference number: ";
	read var_ref;
	while [ -z "${var_ref}" ];do
		echo -n "Please enter Reference number [Null/Invalid entry not accepted]: "
		read var_ref;
	done
	#echo -n "Sales executive: ";
	#read var_sales;
	echo -n "Sales executive Email ID: ";
	read var_sales_email;
	while [ -z "${var_sales_email}" ];do
		echo -n "Please enter Sales Email [Null/Invalid entry not accepted]: "
		read var_sales_email;
	done
  var_sales=$var_sales_email;
  var_installedBy="Installer";
	if [ -z "${var_ref}" ];then
		var_ref="Demo";
		echo "Reference number: $var_ref";
	else
		echo "Reference number: $var_ref";
	fi
	if [ -z "${var_sales}" ];then
		var_sales="Demo";
		echo "Sales executive: $var_sales";
	else
		echo "Sales executive: $var_sales";
	fi
	if [ -z "${var_installedBy}" ];then
		var_installedBy="Demo";
		echo "Switch Installed by: $var_installedBy";
	else
		echo "Switch Installed by: $var_installedBy";
	fi
	echo -n "Enter Customer Email ID: ";
	read email;
	while [ -z "${email}" ];do
		echo -n "Please enter Customer Email [Null/Invalid entry not accepted]: "
		read email;
	done
	if [ -z "${email}" ];then
		email="noreply-support@revesoft.com";
		echo "Current email id: $email";
	else
		echo "Current email id: $email";
	fi
	echo -n "Enter billing name: ";
	read billing;
	service_name=$billing;
	while [ -z "${billing}" ];do
		echo -n "Please enter Billing Name [Null/Invalid entry not accepted]: "
		read billing;
	done
	if [ -z "${billing}" ];then
		billing="SMSPortal";
		echo "Billing name: $billing";
	else
		echo "Billing name: $billing";
	fi
	echo -n "Administrative User: ";
	read var_user;
	while [ -z "${var_user}" ];do
		echo -n "Please enter dministrative User [Null/Invalid entry not accepted]: "
		read var_user;
	done
	echo -n "Administrative password: ";
	read admin_pass;
	while [ -z "${admin_pass}" ];do
		echo -n "Please enter Administrative password [Null/Invalid entry not accepted]: "
		read admin_pass;
	done
	if [ -z "${var_user}" ];then
		var_user="admin";
		echo "Default User: $var_user";
	else
		echo "Default User: $var_user";
	fi
	if [ -z "${admin_pass}" ];then
		admin_pass="abc1";
		echo "Default password: $admin_pass";
	else
		echo "Default password: $admin_pass";
	fi
	var_web=$billing;
	var_db_itelbilling="iTelSMS$billing";
	flg_paid_module="new";
	cd /home/wsms
	mv smsportal $billing
	mv WholeSaleSMSServer WholeSaleSMSServer$billing
	cd WholeSaleSMSServer$billing
	echo "Version: ">version
	echo "SMS Server: $var_wsms_server_v">>version
	echo "Web: $var_wsms_web_v">>version
	echo -n "smsServerIP: ";
	read smsServerIP;
	while [[ ! $smsServerIP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]];do
		echo -n "Please enter smsServerIP [Null/Invalid entry not accepted]: "
		read smsServerIP;
	done
	echo -n "smsSMPPPort: ";
	read smsSMPPPort;
	while [[ ! $smsSMPPPort =~ ^[0-9]+$ ]];do
		echo -n "Please enter smsSMPPPort [Null/Invalid entry not accepted]: "
		read smsSMPPPort;
	done
	echo -n "smsHTTPPort: ";
	read smsHTTPPort;
	while [[ ! $smsHTTPPort =~ ^[0-9]+$ ]];do
		echo -n "Please enter smsHTTPPort [Null/Invalid entry not accepted]: "
		read smsHTTPPort;
	done
	echo -n "smsHTTPSPort: ";
	read smsHTTPSPort;
	while [[ ! $smsHTTPSPort =~ ^[0-9]+$ ]];do
		echo -n "Please enter smsHTTPSPort [Null/Invalid entry not accepted]: "
		read smsHTTPSPort;
	done
	smsServerSystemID=100;
	smsServerPassword='asdf1234';
	echo -n "smsSenderListenIP: ";
	read smsSenderListenIP;
	while [[ ! $smsSenderListenIP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]];do
		echo -n "Please enter smsSenderListenIP [Null/Invalid entry not accepted]: "
		read smsSenderListenIP;
	done
	echo -n "smsSenderListenPort: ";
	read smsSenderListenPort;
	while [[ ! $smsSenderListenPort =~ ^[0-9]+$ ]];do
		echo -n "Please enter smsSenderListenPort [Null/Invalid entry not accepted]: "
		read smsSenderListenPort;
	done
	echo -n "localConfigListeningPort: ";
	read localConfigListeningPort;
	while [[ ! $localConfigListeningPort =~ ^[0-9]+$ ]];do
		echo -n "Please enter localConfigListeningPort [Null/Invalid entry not accepted]: "
		read localConfigListeningPort;
	done
	dbCreate=$(mysql -e "CREATE DATABASE iTelSMS$billing");
	dbCreateFailed=$(mysql -e "CREATE DATABASE iTelSMSFailed$billing");
	if [[ -z "$dbCreate" &&  -z "$dbCreateFailed" ]];then
		echo -e "DATABASE iTelSMS$billing CREATED";
		echo -e "DATABASE iTelSMSFailed$billing CREATED";
		echo "mysql -u root;" > /home/wsms/sql.txt
		echo "use iTelSMS$billing;" >> /home/wsms/sql.txt
		echo "source /Sql/iTelSMS.sql;" >> /home/wsms/sql.txt
		echo "source /Sql/vbLanguageText.sql;" >> /home/wsms/sql.txt
		echo "source /Sql/iTelSMS.sql;" > /home/wsms/wsms_full.sql
		echo "source /Sql/vbLanguageText.sql;" >> /home/wsms/wsms_full.sql
		echo "source /Sql/iTelSMSFailed.sql;" > /home/wsms/iTelSMSFailed.sql
		
		mysql iTelSMS$billing < /home/wsms/wsms_full.sql;
		mysql iTelSMSFailed$billing < /home/wsms/iTelSMSFailed.sql;
	else
		echo -e "ERROR: COULD NOT CREATE iTelSMS$billing";
	fi
	cd /home/wsms/WholeSaleSMSServer$billing
	echo "orgBindIP=${smsServerIP}" > Configuration.txt;
	echo "orgBindPort=$smsSMPPPort" >> Configuration.txt;
	echo "referralSMSCostFree=yes" >> Configuration.txt;
	echo "isWholesale=true" >> Configuration.txt;
	echo "fromFieldFixedValue=4122" >> Configuration.txt;
	echo "defaultMask=1234567890" >> Configuration.txt;
	echo "printDLRQueue=true" >> Configuration.txt;
	echo "DlrQueuePrintDelay=1800" >> Configuration.txt;
	echo "cacheLoadLimit=90000" >> Configuration.txt;
	echo "smppTransactionTimer=120" >> Configuration.txt;
	echo "systemType=smpp" >> Configuration.txt;
	echo "#ssl=1" >> Configuration.txt;
	echo "#jksFileName=" >> Configuration.txt;
	echo "#jksPassword=" >> Configuration.txt;
	echo "maxSmsProcessors=120" >> Configuration.txt;	
	echo "localConfigListeningPort=$localConfigListeningPort" >> Configuration.txt;	
	echo "smsLiveStatusReceivers=$smsServerIP;119.148.4.18;103.169.159.34" >> Configuration.txt;
	
	mkdir config
	mv Configuration.txt config/server.cfg
	
	
	#enable_utf8 in log
	have_utf8_param=$(cat log4j.properties  | grep "^log4j.appender.logfile.encoding")
	
	if [[ -z "$have_utf8_param" ]];then
		echo "log4j.appender.logfile.encoding=UTF-8">>log4j.properties
	fi
	
	#Service file Config service file
	mv WholeSaleSMSServer WholeSaleSMSServer$billing
	echo "#!/bin/sh">WholeSaleSMSServer$billing
	echo "## WholeSaleSMSServer   This shell script takes care of starting and stopping WholeSaleSMSServer">>WholeSaleSMSServer$billing
	echo "# Source function library.">>WholeSaleSMSServer$billing
	echo ". /etc/rc.d/init.d/functions">>WholeSaleSMSServer$billing
	echo "#">>WholeSaleSMSServer$billing
	var="\$1"
	echo "case \"$var\" in">>WholeSaleSMSServer$billing
	echo "start)">>WholeSaleSMSServer$billing
	echo "echo -n \"Starting WholeSaleSMSServer$billing:">>WholeSaleSMSServer$billing
	echo "\"">>WholeSaleSMSServer$billing
	echo "/usr/local/WholeSaleSMSServer$billing/runSMS_Server.sh">>WholeSaleSMSServer$billing
	echo ";;">>WholeSaleSMSServer$billing
	echo "stop)">>WholeSaleSMSServer$billing
	echo "echo -n \"Stoping WholeSaleSMSServer$billing:">>WholeSaleSMSServer$billing
	echo "\"">>WholeSaleSMSServer$billing
	echo "/usr/local/WholeSaleSMSServer$billing/shutdownSMS_Server.sh">>WholeSaleSMSServer$billing
	echo "sleep 10">>WholeSaleSMSServer$billing
	echo ";;">>WholeSaleSMSServer$billing
	echo "restart)">>WholeSaleSMSServer$billing
	var="\$0"
	echo "$var stop">>WholeSaleSMSServer$billing
	echo "$var start">>WholeSaleSMSServer$billing
	echo ";;">>WholeSaleSMSServer$billing
	echo "*)">>WholeSaleSMSServer$billing
	echo "echo \"Usage: $var {start|stop|restart}\"">>WholeSaleSMSServer$billing
	echo "exit 1">>WholeSaleSMSServer$billing
	echo "esac">>WholeSaleSMSServer$billing
	echo "exit 0">>WholeSaleSMSServer$billing
	echo -e "JDK: ${BBlue}$var_jdk${NC}"
	#start file
	m="m";
	echo "cd /usr/local/WholeSaleSMSServer$billing">runSMS_Server.sh
	echo "$var_jdk/bin/java -Xmx$var_wsms_memory$m -jar SMSServerWholesale.jar $billing &">>runSMS_Server.sh
	#stop file
	echo "cd /usr/local/WholeSaleSMSServer$billing">shutdownSMS_Server.sh
	echo "$var_jdk/bin/java -jar ShutDown.jar">>shutdownSMS_Server.sh
	cp WholeSaleSMSServer$billing /etc/rc.d/init.d/
	chmod 755 /etc/rc.d/init.d/WholeSaleSMSServer$billing
	#symbolic lilnk. writted into softlink.sh
	echo "chmod 755 /usr/local/WholeSaleSMSServer$billing/runSMS_Server.sh">softlink.sh
	echo "chmod 755 /usr/local/WholeSaleSMSServer$billing/shutdownSMS_Server.sh">>softlink.sh
	echo "cp -r WholeSaleSMSServer$billing /etc/rc.d/init.d/">>softlink.sh
	echo "ln -s ../init.d/WholeSaleSMSServer$billing /etc/rc.d/rc3.d/S99WholeSaleSMSServer$billing">>softlink.sh
	echo "ln -s ../init.d/WholeSaleSMSServer$billing /etc/rc.d/rc5.d/S99WholeSaleSMSServer$billing">>softlink.sh
	echo "ln -s ../init.d/WholeSaleSMSServer$billing /etc/rc.d/rc0.d/K10WholeSaleSMSServer$billing">>softlink.sh
	echo "ln -s ../init.d/WholeSaleSMSServer$billing /etc/rc.d/rc6.d/K10WholeSaleSMSServer$billing">>softlink.sh
	#DatabaseConnection.xml
	echo "<CONNECTIONS>">DatabaseConnection.xml
	echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///iTelSMS$billing?useEncoding=true&amp;characterEncoding=UTF-8\"">>DatabaseConnection.xml
	echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
	echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
	echo "</CONNECTIONS>">>DatabaseConnection.xml
	mongoDBContacts=$billing"SMSContacts";
	mongoDBCampaigns=$billing"SMSCampaigns";
	echo $"use $mongoDBContacts\ndb" | mongo
	echo $"use $mongoDBContacts\ndb" | mongo >> $LOGFILE
	echo $"use $mongoDBCampaigns\ndb" | mongo
	echo $"use $mongoDBCampaigns\ndb" | mongo >> $LOGFILE
	echo -e "<CONNECTIONS>" > DatabaseConnectionMongo.xml
	echo -e "\t<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mongodb.client.MongoClient\"" >> DatabaseConnectionMongo.xml
	echo -e "\t\tDATABASE_URL=\"mongodb://127.0.0.1:27017\" DATABASE=\"$mongoDBContacts\"" >> DatabaseConnectionMongo.xml
	echo -e "\t\tUSER_NAME=\"root\" PASSWORD=\"\" IS_DEFAULT=\"TRUE\" DATABASE_TYPE=\"CONTACT\"/>" >> DatabaseConnectionMongo.xml
	echo -e "\t<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mongodb.client.MongoClient\"" >> DatabaseConnectionMongo.xml
	echo -e "\t\tDATABASE_URL=\"mongodb://127.0.0.1:27017\" DATABASE=\"$mongoDBCampaigns\"" >> DatabaseConnectionMongo.xml
	echo -e "\t\tUSER_NAME=\"root\" PASSWORD=\"\" IS_DEFAULT=\"TRUE\" DATABASE_TYPE=\"CAMPAIGN\"/>" >> DatabaseConnectionMongo.xml
	echo -e "</CONNECTIONS>" >> DatabaseConnectionMongo.xml
	
	#configuring web part
	rm -f /home/wsms/$billing/WEB-INF/classes/*.xml
	cp -r *.xml /home/wsms/$billing/WEB-INF/classes/
	
	#configuring log4j.properties
	rm -f /home/wsms/$billing/WEB-INF/classes/log4j.properties
	rm -rf log4j;
	mkdir log4j;
	cd log4j;
	
	echo "log4j.rootCategory=, A1, stdout">>log4j.properties
	echo "log4j.appender.A1=org.apache.log4j.FileAppender">>log4j.properties
	echo "log4j.appender.A1.File=iTelSMS${billing}.log">>log4j.properties
	echo "log4j.appender.A1.layout=org.apache.log4j.PatternLayout">>log4j.properties
	echo "log4j.appender.A1.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss} %-5p %c{1}:%L - %m%n">>log4j.properties
	echo "# Direct log messages to stdout">>log4j.properties
	echo "log4j.appender.stdout=org.apache.log4j.ConsoleAppender">>log4j.properties
	echo "log4j.appender.logfile.encoding=UTF-8">>log4j.properties
	echo "log4j.appender.stdout.Target=System.out">>log4j.properties
	echo "log4j.appender.stdout.layout=org.apache.log4j.PatternLayout">>log4j.properties
	echo "log4j.appender.stdout.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss} %-5p %c{1}:%L - %m%n">>log4j.properties
	
	# Constructing of DatabaseConnection_Failed.xml
	rm -f /home/wsms/$billing/WEB-INF/classes/DatabaseConnection_Failed.xml
	echo "<CONNECTIONS>" > /home/wsms/$billing/WEB-INF/classes/DatabaseConnection_Failed.xml
	echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///iTelSMSFailed$billing?useUnicode=true&amp;characterEncoding=utf-8\"">>/home/wsms/$billing/WEB-INF/classes/DatabaseConnection_Failed.xml
	echo "USER_NAME = \"root\" PASSWORD = \"\"">>/home/wsms/$billing/WEB-INF/classes/DatabaseConnection_Failed.xml
	echo "IS_DEFAULT = \"TRUE\"/>">>/home/wsms/$billing/WEB-INF/classes/DatabaseConnection_Failed.xml
	echo "</CONNECTIONS>">>/home/wsms/$billing/WEB-INF/classes/DatabaseConnection_Failed.xml
	
	
	
	# DatabaseConnection_Failed.xml for WholeSaleSMSServer
	cp -r /home/wsms/$billing/WEB-INF/classes/DatabaseConnection_Failed.xml /home/wsms/WholeSaleSMSServer$billing/
	
	cp -r log4j.properties /home/wsms/$billing/WEB-INF/classes/
	cd ..
	writeLog "apache-tomcat-$var_tomcat"
	writeLog "1: $(pwd)"
	cd /home/wsms/
	mv WholeSaleSMSServer$billing /usr/local/
	mv $billing /usr/local/apache-tomcat-$var_tomcat/webapps/
	cp /usr/local/WholeSaleSMSServer$billing/WholeSaleSMSServer$billing /etc/rc.d/init.d/
	
	#Media symbolic lilnk
	chmod 755 /etc/rc.d/init.d/WholeSaleSMSServer$billing
	chmod 755 /usr/local/WholeSaleSMSServer$billing/runSMS_Server.sh
	chmod 755 /usr/local/WholeSaleSMSServer$billing/shutdownSMS_Server.sh
	ln -s ../init.d/WholeSaleSMSServer$billing /etc/rc.d/rc3.d/S99WholeSaleSMSServer$billing
	ln -s ../init.d/WholeSaleSMSServer$billing /etc/rc.d/rc5.d/S99WholeSaleSMSServer$billing
	ln -s ../init.d/WholeSaleSMSServer$billing /etc/rc.d/rc0.d/K10WholeSaleSMSServer$billing
	ln -s ../init.d/WholeSaleSMSServer$billing /etc/rc.d/rc6.d/K10WholeSaleSMSServer$billing
	switch_end_time=$(date +%s);
	time_elapsed=$((switch_end_time - switch_start_time));
	minute=`expr $time_elapsed / 60`;
	sec=`expr $time_elapsed % 60`;
	echo "------Finish> Total time to complete installation process: $minute min $sec secs-------";
	sleep 2;
	echo -e "\033[34m################################################################################";
	echo "#                                                                                         #";
	echo "#                              Summary                                                    #";
	echo "#-----------------------------------------------------------------------------------------#";
	echo "#   SMS Portal   : http://$smsServerIP/$billing                                           #";
	echo "#   User         : $var_user                                                              #";
	echo "#   Password     : $admin_pass                                                            #";
	echo "#   SMS IP       : $smsServerIP                                                           #";
	echo "#   SMPP Port    : $smsSMPPPort                                                           #";
	echo "#   HTTP Port    : $smsHTTPPort                                                           #";
	echo "#   HTTPS Port    : $smsHTTPSPort                                                         #";
	echo "#   SMS Server   : WholeSaleSMSServer$billing                                             #";
	echo "#   Databases    : iTelSMS$billing                                                        #";
	echo "#   MongoDB Contacts DB   : $mongoDBContacts                                                #";
	echo "#   MongoDB Campaigns DB  : $mongoDBCampaigns                                               #";
	echo "#                                                                                         #";
	echo -e "#########################################################################################${NC}";
	
	#switch delivery email
	echo "billing=$billing">/home/wsms/deliveryEmail.cfg
	echo "salesEmail=$var_sales_email">>/home/wsms/deliveryEmail.cfg
	echo "customerEmail=$email">>/home/wsms/deliveryEmail.cfg
	echo "supportEmail=support@itelbilling.com">>/home/wsms/deliveryEmail.cfg
	echo "billingURL=http://$smsServerIP/$billing">>/home/wsms/deliveryEmail.cfg
	echo "switchIP=$smsServerIP">>/home/wsms/deliveryEmail.cfg
	echo "switchPORT=$smsSMPPPort">>/home/wsms/deliveryEmail.cfg
	
	# echo "IVRExt=101">>/home/wsms/deliveryEmail.cfg
	# echo "balanceLink=http://$smsServerIP/$billing/getclientbalance.do?pin=REPLACE">>/home/wsms/deliveryEmail.cfg
	echo "installedBy=$var_installedBy;">>/home/wsms/deliveryEmail.cfg
	
	#admin_pass="admin";
	echo "iTelSMS$billing;">/home/wsms/db.txt
	echo "$smsServerIP;">>/home/wsms/db.txt
	echo "$smsSMPPPort;">>/home/wsms/db.txt
	echo "$smsHTTPPort;">>/home/wsms/db.txt
	echo "$smsServerSystemID;">>/home/wsms/db.txt
	echo "$smsServerPassword;">>/home/wsms/db.txt
	echo "$smsSenderListenIP;">>/home/wsms/db.txt
	echo "$smsSenderListenPort;">>/home/wsms/db.txt
	echo "$var_user;">>/home/wsms/db.txt
	echo "$admin_pass;">>/home/wsms/db.txt
	echo "$email;">>/home/wsms/db.txt
	echo "$var_wsms_web_v;">>/home/wsms/db.txt
	echo "$var_wsms_server_v;">>/home/wsms/db.txt
	echo "$billing;">>/home/wsms/db.txt
	echo "WholeSaleSMSServer$billing;">>/home/wsms/db.txt
	echo "$smsHTTPSPort;">>/home/wsms/db.txt
	echo "iTelSMSFailed$billing;">>/home/wsms/db.txt
	echo "$smsServerIP;">/home/wsms/track.txt
	echo "$smsSMPPPort;">>/home/wsms/track.txt
	echo "$smsHTTPPort;">>/home/wsms/track.txt
	echo "$smsSenderListenPort;">>/home/wsms/track.txt
	echo "$smsServerSystemID">>/home/wsms/track.txt
	echo "$billing;">>/home/wsms/track.txt
	echo "$var_ref;">>/home/wsms/track.txt
	echo "$var_sales;">>/home/wsms/track.txt
	echo "$var_installedBy;">>/home/wsms/track.txt
	echo "$var_wsms_server_v;">>/home/wsms/track.txt
	echo "$var_wsms_web_v;">>/home/wsms/track.txt
	echo "$smsHTTPSPort;">>/home/wsms/track.txt
	echo "http://$smsServerIP/$billing;">/home/wsms/email.txt
	echo "$smsServerIP;">>/home/wsms/email.txt
	echo "$smsSMPPPort;">>/home/wsms/email.txt
	echo "$smsHTTPPort;">>/home/wsms/email.txt
	echo "$var_wsms_server_v;">>/home/wsms/email.txt
	echo "$var_wsms_web_v;">>/home/wsms/email.txt
	echo "$var_ref;">>/home/wsms/email.txt
	echo "$var_sales;">>/home/wsms/email.txt
	echo "$var_installedBy;">>/home/wsms/email.txt
	echo "WholeSaleSMSServer$billing">>/home/wsms/email.txt
	echo "$var_user;">>/home/wsms/email.txt
	echo "$admin_pass;">>/home/wsms/email.txt
	echo "$smsHTTPSPort;">>/home/wsms/email.txt
	if [ $flg_n_sw -eq 0 ];then
		flg_n_sw=1;
		cd /usr/
		fn_6jdk;
		#echo -e "\n\n\n\n\n\n\n\n${Black} ################## ${BRed}:: Installing JDK :: ${Black}################${NC}#";
		#wget http://$var_installer_ip/downloads/jdk6.0_25.tar.gz
		#echo "Extracting 1.6.0_25........."
		#tar -zxf jdk6.0_25.tar.gz
		#echo "Extracted Successfully!!!"
		rm -rf /usr/local/installerjar
		#mkdir /usr/local/installerjar
		rm -rf  /usr/local/src/installerjar
		mkdir /usr/local/src/installerjar
		cd /usr/local/src/installerjar
		wget http://$var_installer_ip/downloads/WholeSaleSMSInstaller.jar
		wget http://$var_installer_ip/downloads/ShutDown.jar
		#installer start file
		echo "cd /usr/local/src/installerjar">runInstaller.sh
		echo "/usr/jdk1.6.0_25/bin/java -Xmx4096m -jar WholeSaleSMSInstaller.jar &">>runInstaller.sh
		# echo "cd /usr/local/src/installerjar">runSwitchDelivery.sh
		# echo "/usr/jdk1.6.0_25/bin/java -Xmx400m -jar WholesaleDelivery.jar &">>runSwitchDelivery.sh
		echo "cd /usr/local/src/installerjar">shutDownInstaller.sh
		echo "/usr/jdk1.6.0_25/bin/java -jar ShutDown.jar &">>shutDownInstaller.sh
		#log4j.properties
		echo "l#Default log level to ERROR. Other levels are INFO and DEBUG.">log4j.properties
		echo "log4j.rootLogger=, ROOT">>log4j.properties
		echo "log4j.appender.ROOT=org.apache.log4j.RollingFileAppender">>log4j.properties
		echo "log4j.appender.ROOT.File= installer.log">>log4j.properties
		echo "log4j.appender.ROOT.MaxFileSize=8MB">>log4j.properties
		echo "#Keep 5 old files around.">>log4j.properties
		echo "log4j.appender.ROOT.MaxBackupIndex=0">>log4j.properties
		echo "log4j.appender.ROOT.layout=org.apache.log4j.PatternLayout">>log4j.properties
		echo "#Format almost same as WebSphere's common log format.">>log4j.properties
		echo "log4j.appender.ROOT.layout.ConversionPattern=%-4r %-5p [%t] (%x) - %m\n">>log4j.properties
		echo "#Optionally override log level of individual packages or classes">>log4j.properties
		echo "#log4j.logger.com.webage.ejbs=INFO">>log4j.properties
		#DatabaseConnection.xml
		echo "<CONNECTIONS>">DatabaseConnection.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///mysql\"">>DatabaseConnection.xml
		echo "USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
		echo "IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
		echo "</CONNECTIONS>">>DatabaseConnection.xml
		cd /usr/local/src/installerjar
		chmod a+x runInstaller.sh
		# chmod a+x runSwitchDelivery.sh
		chmod a+x shutDownInstaller.sh
		sh runInstaller.sh
	else
		cd /usr/local/src/installerjar
		chmod a+x runInstaller.sh
		chmod a+x shutDownInstaller.sh
		sh runInstaller.sh
	fi
	sleep 5;
	echo -e "${BBlue}[Please Update SMPP IP and Port in Rims after that Press Enter] ${NC}"
	read
	service WholeSaleSMSServer$billing stop
	service WholeSaleSMSServer$billing start
	#WholesaleSMS AppsServer installation
	WholeSaleSMSApp
	cd /usr/local/src/installerjar
	chmod a+x shutDownInstaller.sh
	sh shutDownInstaller.sh
}
#SMS Server by Shahneel Ends
function fn_install_WholesaleSMS4(){
	switch_start_time=$(date +%s);
	cd /home/wsms
	#initialize
	var_wsms_memory=1024;
	#memory status of server
	fn_server_mem_status;
	echo -n "Memory for WholesaleSMS: ";
	read var_wsms_memory;
	if [ -z "${var_wsms_memory}" ];then
		var_wsms_memory=2048;
	fi
	echo "----------------------------------------------";
	echo -n "Reference number: ";
	read var_ref;
	while [ -z "${var_ref}" ];do
		echo -n "Please enter Reference number [Null/Invalid entry not accepted]: "
		read var_ref;
	done
	#echo -n "Sales executive: ";
	#read var_sales;
	echo -n "Sales executive Email ID: ";
	read var_sales_email;
	while [ -z "${var_sales_email}" ];do
		echo -n "Please enter Sales Email [Null/Invalid entry not accepted]: "
		read var_sales_email;
	done
	var_sales=$var_sales_email;
	var_installedBy="Installer";
	if [ -z "${var_ref}" ];then
		var_ref="Demo";
		echo "Reference number: $var_ref";
	else
		echo "Reference number: $var_ref";
	fi
	if [ -z "${var_sales}" ];then
		var_sales="Demo";
		echo "Sales executive: $var_sales";
	else
		echo "Sales executive: $var_sales";
	fi
	if [ -z "${var_installedBy}" ];then
		var_installedBy="Demo";
		echo "Switch Installed by: $var_installedBy";
	else
		echo "Switch Installed by: $var_installedBy";
	fi
	echo -n "Enter Customer Email ID: ";
	read email;
	while [ -z "${email}" ];do
		echo -n "Please enter Customer Email [Null/Invalid entry not accepted]: "
		read email;
	done
	if [ -z "${email}" ];then
		email="noreply-support@revesoft.com";
		echo "Current email id: $email";
	else
		echo "Current email id: $email";
	fi
	echo -n "Enter billing name: ";
	read billing;
	service_name=$billing;
	while [ -z "${billing}" ];do
		echo -n "Please enter Billing Name [Null/Invalid entry not accepted]: "
		read billing;
	done
	if [ -z "${billing}" ];then
		billing="SMSPortal";
		echo "Billing name: $billing";
	else
		echo "Billing name: $billing";
	fi
	echo -n "Administrative User: ";
	read var_user;
	while [ -z "${var_user}" ];do
		echo -n "Please enter dministrative User [Null/Invalid entry not accepted]: "
		read var_user;
	done
	echo -n "Administrative password: ";
	read admin_pass;
	while [ -z "${admin_pass}" ];do
		echo -n "Please enter Administrative password [Null/Invalid entry not accepted]: "
		read admin_pass;
	done
	if [ -z "${var_user}" ];then
		var_user="admin";
		echo "Default User: $var_user";
	else
		echo "Default User: $var_user";
	fi
	if [ -z "${admin_pass}" ];then
		admin_pass="abc1";
		echo "Default password: $admin_pass";
	else
		echo "Default password: $admin_pass";
	fi
	var_web=$billing;
	var_db_itelbilling="iTelSMS$billing";
	flg_paid_module="new";
	cd /home/wsms
	mv smsportal $billing
	mv WholeSaleSMSServer WholeSaleSMSServer$billing
	cd WholeSaleSMSServer$billing
	echo "Version: ">version
	echo "SMS Server: $var_wsms_server_v4">>version
	echo "Web: $var_wsms_web_v4">>version
	echo -n "smsServerIP: ";
	read smsServerIP;
	while [[ ! $smsServerIP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]];do
		echo -n "Please enter smsServerIP [Null/Invalid entry not accepted]: "
		read smsServerIP;
	done
	echo -n "smsSMPPPort: ";
	read smsSMPPPort;
	while [[ ! $smsSMPPPort =~ ^[0-9]+$ ]];do
		echo -n "Please enter smsSMPPPort [Null/Invalid entry not accepted]: "
		read smsSMPPPort;
	done
	echo -n "smsHTTPPort: ";
	read smsHTTPPort;
	while [[ ! $smsHTTPPort =~ ^[0-9]+$ ]];do
		echo -n "Please enter smsHTTPPort [Null/Invalid entry not accepted]: "
		read smsHTTPPort;
	done
	echo -n "smsHTTPSPort: ";
	read smsHTTPSPort;
	while [[ ! $smsHTTPSPort =~ ^[0-9]+$ ]];do
		echo -n "Please enter smsHTTPSPort [Null/Invalid entry not accepted]: "
		read smsHTTPSPort;
	done
	smsServerSystemID=100;
	smsServerPassword='asdf1234';
	echo -n "smsSenderListenIP: ";
	read smsSenderListenIP;
	while [[ ! $smsSenderListenIP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]];do
		echo -n "Please enter smsSenderListenIP [Null/Invalid entry not accepted]: "
		read smsSenderListenIP;
	done
	echo -n "smsSenderListenPort: ";
	read smsSenderListenPort;
	while [[ ! $smsSenderListenPort =~ ^[0-9]+$ ]];do
		echo -n "Please enter smsSenderListenPort [Null/Invalid entry not accepted]: "
		read smsSenderListenPort;
	done
	echo -n "localConfigListeningPort: ";
	read localConfigListeningPort;
	while [[ ! $localConfigListeningPort =~ ^[0-9]+$ ]];do
		echo -n "Please enter localConfigListeningPort [Null/Invalid entry not accepted]: "
		read localConfigListeningPort;
	done
	dbCreate=$(mysql -e "CREATE DATABASE iTelSMS$billing");
	dbCreateFailed=$(mysql -e "CREATE DATABASE iTelSMSFailed$billing");
	if [[ -z "$dbCreate" &&  -z "$dbCreateFailed" ]];then
		echo -e "DATABASE iTelSMS$billing CREATED";
		echo -e "DATABASE iTelSMSFailed$billing CREATED";
		echo "mysql -u root;" > /home/wsms/sql.txt
		echo "use iTelSMS$billing;" >> /home/wsms/sql.txt
		echo "source /Sql/iTelSMS.sql;" >> /home/wsms/sql.txt
		echo "source /Sql/vbLanguageText.sql;" >> /home/wsms/sql.txt
		echo "source /Sql/iTelSMS.sql;" > /home/wsms/wsms_full.sql
		echo "source /Sql/vbLanguageText.sql;" >> /home/wsms/wsms_full.sql
		echo "source /Sql/iTelSMSFailed.sql;" > /home/wsms/iTelSMSFailed.sql
		
		mysql iTelSMS$billing < /home/wsms/wsms_full.sql;
		mysql iTelSMSFailed$billing < /home/wsms/iTelSMSFailed.sql;
	else
		echo -e "ERROR: COULD NOT CREATE iTelSMS$billing";
	fi
	sms_server_info_sql="insert into vbSMSServerInfo values(1,'${smsServerIP}','${smsSMPPPort}','${smsHTTPPort}','${smsHTTPSPort}',100,'asdf1234',NULL,'${smsSenderListenIP}','${smsSenderListenPort}',NULL,NULL);"
	writeLogSilent "Running SQL-> $sms_server_info_sql";
	
	mysql -D iTelSMS$billing -e "$sms_server_info_sql" 2>&1 | writeLogSilent
	
	cd /home/wsms/WholeSaleSMSServer$billing
	echo "orgBindIP=${smsServerIP}" > Configuration.txt;
	echo "orgBindPort=$smsSMPPPort" >> Configuration.txt;
	echo "isWholesale=true" >> Configuration.txt;
	echo "defaultMask=1234567890" >> Configuration.txt;
	echo "smppTransactionTimer=120" >> Configuration.txt;
	echo "#ssl=1" >> Configuration.txt;
	echo "#jksFileName=" >> Configuration.txt;
	echo "#jksPassword=" >> Configuration.txt;
	echo "smsLiveStatusReceivers=$smsServerIP;119.148.4.18;103.169.159.34" >> Configuration.txt;
	echo "localConfigListeningPort=$localConfigListeningPort" >> Configuration.txt;	
	echo "campaignLoadMaxQueue=2000" >> Configuration.txt;	
	
	mkdir config
	mv Configuration.txt config/server.cfg
	
	#enable_utf8 in log
	have_utf8_param=$(cat log4j.properties  | grep "^log4j.appender.logfile.encoding" )
	
	if [[ -z "$have_utf8_param" ]];then
		echo "log4j.appender.logfile.encoding=UTF-8" >> log4j.properties
	fi
	
	#Service file Config service file
	mv WholeSaleSMSServer WholeSaleSMSServer$billing
	echo "#!/bin/sh">WholeSaleSMSServer$billing
	echo "## WholeSaleSMSServer   This shell script takes care of starting and stopping WholeSaleSMSServer">>WholeSaleSMSServer$billing
	echo "# Source function library.">>WholeSaleSMSServer$billing
	echo ". /etc/rc.d/init.d/functions">>WholeSaleSMSServer$billing
	echo "#">>WholeSaleSMSServer$billing
	var="\$1"
	echo "case \"$var\" in">>WholeSaleSMSServer$billing
	echo "start)">>WholeSaleSMSServer$billing
	echo "echo -n \"Starting WholeSaleSMSServer$billing:">>WholeSaleSMSServer$billing
	echo "\"">>WholeSaleSMSServer$billing
	echo "/usr/local/WholeSaleSMSServer$billing/runSMS_Server.sh">>WholeSaleSMSServer$billing
	echo ";;">>WholeSaleSMSServer$billing
	echo "stop)">>WholeSaleSMSServer$billing
	echo "echo -n \"Stoping WholeSaleSMSServer$billing:">>WholeSaleSMSServer$billing
	echo "\"">>WholeSaleSMSServer$billing
	echo "/usr/local/WholeSaleSMSServer$billing/shutdownSMS_Server.sh">>WholeSaleSMSServer$billing
	echo "sleep 10">>WholeSaleSMSServer$billing
	echo ";;">>WholeSaleSMSServer$billing
	echo "restart)">>WholeSaleSMSServer$billing
	var="\$0"
	echo "$var stop">>WholeSaleSMSServer$billing
	echo "$var start">>WholeSaleSMSServer$billing
	echo ";;">>WholeSaleSMSServer$billing
	echo "*)">>WholeSaleSMSServer$billing
	echo "echo \"Usage: $var {start|stop|restart}\"">>WholeSaleSMSServer$billing
	echo "exit 1">>WholeSaleSMSServer$billing
	echo "esac">>WholeSaleSMSServer$billing
	echo "exit 0">>WholeSaleSMSServer$billing
	echo -e "JDK: ${BBlue}$var_jdk${NC}"
	#start file
	m="m";
	echo "cd /usr/local/WholeSaleSMSServer$billing">runSMS_Server.sh
	echo "$var_jdk/bin/java -Xmx$var_wsms_memory$m -jar SMSServerWholesale.jar $billing &">>runSMS_Server.sh
	#stop file
	echo "cd /usr/local/WholeSaleSMSServer$billing">shutdownSMS_Server.sh
	echo "$var_jdk/bin/java -jar ShutDown.jar">>shutdownSMS_Server.sh
	cp WholeSaleSMSServer$billing /etc/rc.d/init.d/
	chmod 755 /etc/rc.d/init.d/WholeSaleSMSServer$billing
	#symbolic lilnk. writted into softlink.sh
	echo "chmod 755 /usr/local/WholeSaleSMSServer$billing/runSMS_Server.sh">softlink.sh
	echo "chmod 755 /usr/local/WholeSaleSMSServer$billing/shutdownSMS_Server.sh">>softlink.sh
	echo "cp -r WholeSaleSMSServer$billing /etc/rc.d/init.d/">>softlink.sh
	echo "ln -s ../init.d/WholeSaleSMSServer$billing /etc/rc.d/rc3.d/S99WholeSaleSMSServer$billing">>softlink.sh
	echo "ln -s ../init.d/WholeSaleSMSServer$billing /etc/rc.d/rc5.d/S99WholeSaleSMSServer$billing">>softlink.sh
	echo "ln -s ../init.d/WholeSaleSMSServer$billing /etc/rc.d/rc0.d/K10WholeSaleSMSServer$billing">>softlink.sh
	echo "ln -s ../init.d/WholeSaleSMSServer$billing /etc/rc.d/rc6.d/K10WholeSaleSMSServer$billing">>softlink.sh
	#DatabaseConnection.xml
	echo "<CONNECTIONS>">DatabaseConnection.xml
	echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.cj.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///iTelSMS$billing?useEncoding=true&amp;characterEncoding=UTF-8\"">>DatabaseConnection.xml
	echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
	echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
	echo "</CONNECTIONS>">>DatabaseConnection.xml
	mongoDBContacts=$billing"SMSContacts";
	mongoDBCampaigns=$billing"SMSCampaigns";
	echo $"use $mongoDBContacts\ndb" | mongo
	echo $"use $mongoDBContacts\ndb" | mongo >> $LOGFILE
	echo $"use $mongoDBCampaigns\ndb" | mongo
	echo $"use $mongoDBCampaigns\ndb" | mongo >> $LOGFILE
	echo -e "<CONNECTIONS>" > DatabaseConnectionMongo.xml
	echo -e "\t<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mongodb.client.MongoClient\"" >> DatabaseConnectionMongo.xml
	echo -e "\t\tDATABASE_URL=\"mongodb://127.0.0.1:27017\" DATABASE=\"$mongoDBContacts\"" >> DatabaseConnectionMongo.xml
	echo -e "\t\tUSER_NAME=\"root\" PASSWORD=\"\" IS_DEFAULT=\"TRUE\" DATABASE_TYPE=\"CONTACT\"/>" >> DatabaseConnectionMongo.xml
	echo -e "\t<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mongodb.client.MongoClient\"" >> DatabaseConnectionMongo.xml
	echo -e "\t\tDATABASE_URL=\"mongodb://127.0.0.1:27017\" DATABASE=\"$mongoDBCampaigns\"" >> DatabaseConnectionMongo.xml
	echo -e "\t\tUSER_NAME=\"root\" PASSWORD=\"\" IS_DEFAULT=\"TRUE\" DATABASE_TYPE=\"CAMPAIGN\"/>" >> DatabaseConnectionMongo.xml
	echo -e "</CONNECTIONS>" >> DatabaseConnectionMongo.xml
	#configuring web part
	rm -f /home/wsms/$billing/WEB-INF/classes/*.xml
	cp -r *.xml /home/wsms/$billing/WEB-INF/classes/
	#configuring log4j.properties
	rm -f /home/wsms/$billing/WEB-INF/classes/log4j.properties
	rm -rf log4j;
	mkdir log4j;
	
	cd log4j;
	echo "log4j.rootCategory=, A1, stdout">>log4j.properties
	echo "log4j.appender.A1=org.apache.log4j.FileAppender">>log4j.properties
	echo "log4j.appender.A1.File=iTelSMS${billing}.log">>log4j.properties
	echo "log4j.appender.A1.layout=org.apache.log4j.PatternLayout">>log4j.properties
	echo "log4j.appender.A1.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss,SSS} %-5p %c{1}:%L - %m%n">>log4j.properties
	echo "# Direct log messages to stdout">>log4j.properties
	echo "log4j.appender.stdout=org.apache.log4j.ConsoleAppender">>log4j.properties
	echo "log4j.appender.logfile.encoding=UTF-8">>log4j.properties
	echo "log4j.appender.stdout.Target=System.out">>log4j.properties
	echo "log4j.appender.stdout.layout=org.apache.log4j.PatternLayout">>log4j.properties
	echo "log4j.appender.stdout.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss,SSS} %-5p %c{1}:%L - %m%n">>log4j.properties
	
	# Constructing of DatabaseConnection_Failed.xml
	rm -f /home/wsms/$billing/WEB-INF/classes/DatabaseConnection_Failed.xml
	echo "<CONNECTIONS>" > /home/wsms/$billing/WEB-INF/classes/DatabaseConnection_Failed.xml
	echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.cj.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///iTelSMSFailed$billing?useUnicode=true&amp;characterEncoding=utf-8\"">>/home/wsms/$billing/WEB-INF/classes/DatabaseConnection_Failed.xml
	echo "USER_NAME = \"root\" PASSWORD = \"\"">>/home/wsms/$billing/WEB-INF/classes/DatabaseConnection_Failed.xml
	echo "IS_DEFAULT = \"TRUE\"/>">>/home/wsms/$billing/WEB-INF/classes/DatabaseConnection_Failed.xml
	echo "</CONNECTIONS>">>/home/wsms/$billing/WEB-INF/classes/DatabaseConnection_Failed.xml
	
	
	
	# DatabaseConnection_Failed.xml for WholeSaleSMSServer
	cp -r /home/wsms/$billing/WEB-INF/classes/DatabaseConnection_Failed.xml /home/wsms/WholeSaleSMSServer$billing/
	
	cp -r log4j.properties /home/wsms/$billing/WEB-INF/classes/
	cd ..
	writeLog "apache-tomcat-$var_tomcat"
	writeLog "1: $(pwd)"
	cd /home/wsms/
	mv WholeSaleSMSServer$billing /usr/local/
	mv $billing /usr/local/apache-tomcat-$var_tomcat/webapps/
	cp /usr/local/WholeSaleSMSServer$billing/WholeSaleSMSServer$billing /etc/rc.d/init.d/
	#Media symbolic lilnk
	chmod 755 /etc/rc.d/init.d/WholeSaleSMSServer$billing
	chmod 755 /usr/local/WholeSaleSMSServer$billing/runSMS_Server.sh
	chmod 755 /usr/local/WholeSaleSMSServer$billing/shutdownSMS_Server.sh
	ln -s ../init.d/WholeSaleSMSServer$billing /etc/rc.d/rc3.d/S99WholeSaleSMSServer$billing
	ln -s ../init.d/WholeSaleSMSServer$billing /etc/rc.d/rc5.d/S99WholeSaleSMSServer$billing
	ln -s ../init.d/WholeSaleSMSServer$billing /etc/rc.d/rc0.d/K10WholeSaleSMSServer$billing
	ln -s ../init.d/WholeSaleSMSServer$billing /etc/rc.d/rc6.d/K10WholeSaleSMSServer$billing
	switch_end_time=$(date +%s);
	time_elapsed=$((switch_end_time - switch_start_time));
	minute=`expr $time_elapsed / 60`;
	sec=`expr $time_elapsed % 60`;
	echo "------Finish> Total time to complete installation process: $minute min $sec secs-------";
	sleep 2;
	echo -e "\033[34m################################################################################";
	echo "#                                                                                         #";
	echo "#                              Summary                                                    #";
	echo "#-----------------------------------------------------------------------------------------#";
	echo "#   SMS Portal   : http://$smsServerIP/$billing                                           #";
	echo "#   User         : $var_user                                                              #";
	echo "#   Password     : $admin_pass                                                            #";
	echo "#   SMS IP       : $smsServerIP                                                           #";
	echo "#   SMPP Port    : $smsSMPPPort                                                           #";
	echo "#   HTTP Port    : $smsHTTPPort                                                           #";
	echo "#   HTTPS Port    : $smsHTTPSPort                                                         #";
	echo "#   SMS Server   : WholeSaleSMSServer$billing                                             #";
	echo "#   Databases    : iTelSMS$billing                                                        #";
	echo "#   MongoDB Contacts DB   : $mongoDBContacts                                                #";
	echo "#   MongoDB Campaigns DB  : $mongoDBCampaigns                                               #";
	echo "#                                                                                         #";
	echo -e "#########################################################################################${NC}";
	#switch delivery email
	echo "billing=$billing">/home/wsms/deliveryEmail.cfg
	echo "salesEmail=$var_sales_email">>/home/wsms/deliveryEmail.cfg
	echo "customerEmail=$email">>/home/wsms/deliveryEmail.cfg
	echo "supportEmail=support@itelbilling.com">>/home/wsms/deliveryEmail.cfg
	echo "billingURL=http://$smsServerIP/$billing">>/home/wsms/deliveryEmail.cfg
	echo "switchIP=$smsServerIP">>/home/wsms/deliveryEmail.cfg
	echo "switchPORT=$smsSMPPPort">>/home/wsms/deliveryEmail.cfg
	# echo "IVRExt=101">>/home/wsms/deliveryEmail.cfg
	# echo "balanceLink=http://$smsServerIP/$billing/getclientbalance.do?pin=REPLACE">>/home/wsms/deliveryEmail.cfg
	echo "installedBy=$var_installedBy;">>/home/wsms/deliveryEmail.cfg
	#admin_pass="admin";
	echo "iTelSMS$billing;">/home/wsms/db.txt
	echo "$smsServerIP;">>/home/wsms/db.txt
	echo "$smsSMPPPort;">>/home/wsms/db.txt
	echo "$smsHTTPPort;">>/home/wsms/db.txt
	echo "$smsServerSystemID;">>/home/wsms/db.txt
	echo "$smsServerPassword;">>/home/wsms/db.txt
	echo "$smsSenderListenIP;">>/home/wsms/db.txt
	echo "$smsSenderListenPort;">>/home/wsms/db.txt
	echo "$var_user;">>/home/wsms/db.txt
	echo "$admin_pass;">>/home/wsms/db.txt
	echo "$email;">>/home/wsms/db.txt
	echo "$var_wsms_web_v4;">>/home/wsms/db.txt
	echo "$var_wsms_server_v4;">>/home/wsms/db.txt
	echo "$billing;">>/home/wsms/db.txt
	echo "WholeSaleSMSServer$billing;">>/home/wsms/db.txt
	echo "$smsHTTPSPort;">>/home/wsms/db.txt
	echo "iTelSMSFailed$billing;">>/home/wsms/db.txt
	echo "$smsServerIP;">/home/wsms/track.txt
	echo "$smsSMPPPort;">>/home/wsms/track.txt
	echo "$smsHTTPPort;">>/home/wsms/track.txt
	echo "$smsSenderListenPort;">>/home/wsms/track.txt
	echo "$smsServerSystemID">>/home/wsms/track.txt
	echo "$billing;">>/home/wsms/track.txt
	echo "$var_ref;">>/home/wsms/track.txt
	echo "$var_sales;">>/home/wsms/track.txt
	echo "$var_installedBy;">>/home/wsms/track.txt
	echo "$var_wsms_server_v4;">>/home/wsms/track.txt
	echo "$var_wsms_web_v4;">>/home/wsms/track.txt
	echo "$smsHTTPSPort;">>/home/wsms/track.txt
	echo "http://$smsServerIP/$billing;">/home/wsms/email.txt
	echo "$smsServerIP;">>/home/wsms/email.txt
	echo "$smsSMPPPort;">>/home/wsms/email.txt
	echo "$smsHTTPPort;">>/home/wsms/email.txt
	echo "$var_wsms_server_v4;">>/home/wsms/email.txt
	echo "$var_wsms_web_v4;">>/home/wsms/email.txt
	echo "$var_ref;">>/home/wsms/email.txt
	echo "$var_sales;">>/home/wsms/email.txt
	echo "$var_installedBy;">>/home/wsms/email.txt
	echo "WholeSaleSMSServer$billing">>/home/wsms/email.txt
	echo "$var_user;">>/home/wsms/email.txt
	echo "$admin_pass;">>/home/wsms/email.txt
	echo "$smsHTTPSPort;">>/home/wsms/email.txt
	
	rm -f PassEncrypter.jar
	wget http://149.20.186.19/PassEncrypter.jar
	
	encryptedPassword=$(/usr/jdk1.8.0_111/bin/java -jar PassEncrypter.jar $admin_pass)
	
	
	user_update_sql="update vbUser set usUsername='$var_user',usPassword='$encryptedPassword' where usUserID=1;"
	
	writeLogSilent "Running SQL->$user_update_sql";
	mysql -D iTelSMS$billing -e "$user_update_sql" 2>&1 | writeLogSilent;
	
	sleep 5;
	echo -e "${BBlue}[Please Update SMPP IP and Port in Rims after that Press Enter] ${NC}"
	read
	service WholeSaleSMSServer$billing stop
	service WholeSaleSMSServer$billing start
	#WholesaleSMS AppsServer installation
	WholeSaleSMSApp4
	
}

function fn_diskChecker()
{
   echo -e "\n\n\n\n\n\n\n\n${Black} ################## ${BRed}:: Installing DiskSpaceChecker :: ${Black}################${NC}#";
   find /usr/local -name DiskSpaceChecker | grep "/usr/local/DiskSpaceChecker" && var_dsc=1  || var_dsc=0
   if [ $var_dsc -eq 1 ]
	 then
	   echo "DiskSpaceChecker already exists.";
	 else
	   echo "Installing DiskSpaceChecker...";
	   rm -rf /home/dsc
	   mkdir /home/dsc
	   cd /home/dsc
	   wget http://$var_installer_ip/downloads/DiskSpaceChecker.zip
	   echo "Extracting DiskSpaceChecker........."
	   unzip -q DiskSpaceChecker.zip
	   echo "DiskSpaceChecker Extracted!!"
	   cd DiskSpaceChecker
	   echo "cd /usr/local/DiskSpaceChecker">runDiskSpaceChecker.sh
	   echo "/usr/jdk1.8.0_111/bin/java  -jar DiskSpaceChecker.jar &">>runDiskSpaceChecker.sh
	   echo "cd /usr/local/DiskSpaceChecker">shutdownDiskSpaceChecker.sh
	   echo "/usr/jdk1.8.0_111/bin/java -jar ShutDown.jar">>shutdownDiskSpaceChecker.sh
	   chmod a+x *.sh;
		echo -n "Enter Server IP: "
	   read var_IP;
	   echo "Email Properties remain unchanged."
	   echo "MailServer=mail.revesoft.com">email_properties
	   echo "AdditionalToAddress=support@revesoft.com">>email_properties
	   echo "MailSubject=Limit Exceeded, Server: $var_IP">>email_properties
	   echo "AlertGapDuration=1">>email_properties
	   echo "RepeatGapDuration=2">>email_properties
	   echo "MailSeverPort=2525">>email_properties
	   echo "needAuthenticationFromMailServer=yes">>email_properties
	   echo "AlertAtPercentage=80">>email_properties
	   echo "MailContent=Dear Sir,\n  your disk usage is: CURRENT_USAGE \n please free some spaces  to avoid inturruption in service\n\nRegards,\niTelSwitchDiskSpaceChecker Team.">>email_properties
	   #service file
		echo "#!/bin/sh">DiskSpaceChecker
		echo "## DiskSpaceChecker   This shell script takes care of starting and stopping DiskSpaceChecker">>DiskSpaceChecker
		echo "# Source function library.">>DiskSpaceChecker
		echo ". /etc/rc.d/init.d/functions">>DiskSpaceChecker
		echo "#">>DiskSpaceChecker
		var="\$1"
		echo "case \"$var\" in">>DiskSpaceChecker
		echo "start)">>DiskSpaceChecker
		echo "echo -n \"Starting DiskSpaceChecker: ">>DiskSpaceChecker
		echo "\"">>DiskSpaceChecker
		echo "/usr/local/DiskSpaceChecker/runDiskSpaceChecker.sh">>DiskSpaceChecker
		echo ";;">>DiskSpaceChecker
		echo "stop)">>DiskSpaceChecker
		echo "echo -n \"Stoping DiskSpaceChecker:">>DiskSpaceChecker
		echo "\"">>DiskSpaceChecker
		echo " /usr/local/DiskSpaceChecker/shutdownDiskSpaceChecker.sh">>DiskSpaceChecker
		echo "sleep 2">>DiskSpaceChecker
		echo ";;">>DiskSpaceChecker
		echo "restart)">>DiskSpaceChecker
		var="\$0"
		echo "$var stop">>DiskSpaceChecker
		echo "$var start">>DiskSpaceChecker
		echo ";;">>DiskSpaceChecker
		echo "*)">>DiskSpaceChecker
		echo "echo \"Usage: $var {start|stop|restart}\"">>DiskSpaceChecker
		echo "exit 1">>DiskSpaceChecker
		echo "esac">>DiskSpaceChecker
		echo "exit 0">>DiskSpaceChecker
	   #softlink
		cp DiskSpaceChecker /etc/rc.d/init.d/
		chmod 755 /etc/rc.d/init.d/DiskSpaceChecker
		ln -s /etc/rc.d/init.d/DiskSpaceChecker /etc/rc.d/rc3.d/S99DiskSpaceChecker
		ln -s /etc/rc.d/init.d/DiskSpaceChecker /etc/rc.d/rc5.d/S99DiskSpaceChecker
		ln -s /etc/rc.d/init.d/DiskSpaceChecker /etc/rc.d/rc0.d/K10DiskSpaceChecker
		ln -s /etc/rc.d/init.d/DiskSpaceChecker /etc/rc.d/rc6.d/K10DiskSpaceChecker
	   cd ..
	   mv DiskSpaceChecker /usr/local
	   service DiskSpaceChecker start
  fi
}

function fn_passwd()
{
	echo -n "Do you want to change server password? y/n: "
	read yorn;
	if [ $yorn == y ]
	  then
	   echo "Enter password: "
	   passwd;
	else
	 echo "Password remain unchanged"
	fi
}
function fn_reboot()
{
		echo -n "Do you want to reboot the server? y/n: "
		read yorn;
		if [ $yorn == y ]
		  then
		   echo "Server is going to reboot now..."
		   reboot;
		else
		 echo "Reboot cancelled"
		fi
}
function fn_BalanceServerInfo(){
		rm -rf /usr/local/src/balanceserver
		mkdir /usr/local/src/balanceserver
		cd /usr/local/src/balanceserver
		#wget http://$var_installer_ip/downloads/balanceserver.SQL
		wget http://$var_installer_ip/downloads/balanceserver.jar
		#installer start file
		echo "cd /usr/local/src/balanceserver">runbalanceserver.sh
		echo "$var_jdk/bin/java -Xmx1024m -jar balanceserver.jar">>runbalanceserver.sh
		#log4j.properties
		echo "l#Default log level to ERROR. Other levels are INFO and DEBUG.">log4j.properties
		echo "log4j.rootLogger=, ROOT">>log4j.properties
		echo "log4j.appender.ROOT=org.apache.log4j.RollingFileAppender">>log4j.properties
		echo "log4j.appender.ROOT.File= balance.log">>log4j.properties
		echo "log4j.appender.ROOT.MaxFileSize=5MB">>log4j.properties
		echo "#Keep 5 old files around.">>log4j.properties
		echo "log4j.appender.ROOT.MaxBackupIndex=0">>log4j.properties
		echo "log4j.appender.ROOT.layout=org.apache.log4j.PatternLayout">>log4j.properties
		echo "#Format almost same as WebSphere's common log format.">>log4j.properties
		echo "log4j.appender.ROOT.layout.ConversionPattern=%-4r %-5p [%t] (%x) - %m\n">>log4j.properties
		echo "#Optionally override log level of individual packages or classes">>log4j.properties
		echo "#log4j.logger.com.webage.ejbs=INFO">>log4j.properties
		#DatabaseConnection.xml
		echo "<CONNECTIONS>">DatabaseConnection.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///mysql\"">>DatabaseConnection.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
		echo "</CONNECTIONS>">>DatabaseConnection.xml
		chmod a+x runbalanceserver.sh
		sh runbalanceserver.sh
		sleep 8;
		rm -f /home/balance.log
		mv balance.log /home/
		rm -rf /usr/local/src/balanceserver
}
function fn_BalanceServer(){
	echo -e "\n\n\n\n\n\n\n\n${Black} ################## ${BRed}:: Installing BalanceServer :: ${Black}################${NC}#";
   rm -rf /home/blnc;
   mkdir /home/blnc;
   cd /home/blnc;
   wget http://$var_installer_ip/downloads/BalanceServer.zip
   echo "Extracting BalanceServer........."
   unzip -q BalanceServer.zip
   echo "BalanceServer Extracted!!"
   cd BalanceServer;
   var_db="BalanceServer";
   #DatabaseConnection.xml
   echo "<CONNECTIONS>">DatabaseConnection.xml
   echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$var_db\"">>DatabaseConnection.xml
   echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
   echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
   echo "</CONNECTIONS>">>DatabaseConnection.xml
   #softlink
   rm -f /etc/rc.d/init.d/BalanceServer
   cp BalanceServer /etc/rc.d/init.d/
   chmod 755 /etc/rc.d/init.d/BalanceServer
   ln -s /etc/rc.d/init.d/BalanceServer /etc/rc.d/rc3.d/S99BalanceServer
   ln -s /etc/rc.d/init.d/BalanceServer /etc/rc.d/rc5.d/S99BalanceServer
   ln -s /etc/rc.d/init.d/BalanceServer /etc/rc.d/rc0.d/K10BalanceServer
   ln -s /etc/rc.d/init.d/BalanceServer /etc/rc.d/rc6.d/K10BalanceServer
   echo "cd /usr/local/BalanceServer">runBalance.sh
   echo "$var_jdk/bin/java -Xmx1536m -jar BalanceServer.jar &">>runBalance.sh
   echo "cd /usr/local/BalanceServer">shutdownBalanceServer.sh
   echo "$var_jdk/bin/java -jar ShutDown.jar">>shutdownBalanceServer.sh
   chmod a+x *.sh
   cd ../
   mv  BalanceServer  /usr/local/BalanceServer;
}
function fn_system_Maintenance()
{
	echo -e "\n\n\n\n\n\n\n\n${Black} ################## ${BRed}:: Installing iTelAppServer :: ${Black}################${NC}#";
	if [ $flg_sm -eq 0 ]
		then
			echo -n "Enter Billing name: ";
			read billing;
			#echo -n "Enter Billing version (put 5 or 6): ";
			#read billing_version;
			echo -n "Enter Web server ip: ";
			read web_server_ip;
			echo -n "Enter server ip: ";
			read server_ip;
			while [[ ! $server_ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]
			do
				echo -n "Please enter server IP: [Null/Invalid entry not accepted]: "
				read server_ip;
			done
			echo -n "Enter server port [Any free port] : "
			read server_port;
			while [[ ! $server_port =~ ^[0-9]+$ ]]
			do
				echo -n "Please enter server port [Null/Invalid entry not accepted]: "
				read server_port;
			done
			echo -n "Enter Switch port: ";
			read nas_port;
			echo -n "Enter Media name: ";
			read var_media;
			echo -n "Enter Signaling name: ";
			read var_sigling;
			echo -n "Enter Database name(iTelBilling): ";
			read var_db_itel;
			echo -n "Enter Database name(Successful): ";
			read var_db_successful;
			echo -n "Enter Database name(Failed): ";
			read var_db_failed;
		else
			billing=$var_web;
			echo -n "Enter server IP: ";
			read server_ip;
			while [[ ! $server_ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]
			do
				echo -n "Please enter server IP: [Null/Invalid entry not accepted]: "
				read server_ip;
			done
			web_server_ip=$server_ip;
			echo -n "Enter server port [Any free port] : "
			read server_port;
			while [[ ! $server_port =~ ^[0-9]+$ ]]
			do
				echo -n "Please enter server port [Null/Invalid entry not accepted]: "
				read server_port;
			done
			nas_port=$switch_port;
			var_media="iTelSwitchPlusMediaProxy$billing";
			var_sigling="iTelSwitchPlusSignaling$billing";
			var_db_itel=$var_db_itelbilling;
			var_db_successful=$var_db_successful;
			var_db_failed=$var_db_failed_failed;
		fi
	flg_sm=0;
	find /usr/local/  -name iTelAppsServer$billing | grep iTelAppsServer$billing && var_apps=1 || var_apps=0
   if [ $var_apps -eq 1 ]
	  then
		echo "iTelAppsServer$billing exists"
		#echo "Lets insert data for system maintenance..."
		#fn_insert_system_maintenance_data;
		rm -rf /SQL;
		cp -r SQL  /
		cd /
		#wget http://$var_installer_ip/downloads/SQL.zip
   else
	echo "Configuring iTelAppsServer$billing ..."
	rm -rf /home/smtn;
	mkdir  /home/smtn;
	cd /home/smtn;
	wget http://$var_installer_ip/downloads/iTelAppsServer.zip
	echo "Extracting iTelAppsServer........"
	unzip -q iTelAppsServer.zip
	echo "iTelAppsServer Extracted!!"
	mv iTelAppsServer  iTelAppsServer$billing;
	cd iTelAppsServer$billing;
	#mv iTelAppsServer$billing  /usr/local
	#cd /usr/local/iTelAppsServer$billing
	rm -rf /SQL;
	cp -r SQL  /
	rm -f *.xml
	#DatabaseConnection.xml
	echo "<CONNECTIONS>">DatabaseConnection.xml
	echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$var_db_itel\"">>DatabaseConnection.xml
	echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
	echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
	echo "</CONNECTIONS>">>DatabaseConnection.xml
	cp  -r  DatabaseConnection.xml  DatabaseConnection_PinProtector.xml
	#DatabaseConnection_Successful.xml
	echo "<CONNECTIONS>">DatabaseConnection_Successful.xml
	echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$var_db_successful\"">>DatabaseConnection_Successful.xml
	echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Successful.xml
	echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Successful.xml
	echo "</CONNECTIONS>">>DatabaseConnection_Successful.xml
	cp -r  DatabaseConnection_Successful.xml  DatabaseConnection_Reseller.xml
	#DatabaseConnection_Failed.xml
	echo "<CONNECTIONS>">DatabaseConnection_Failed.xml
	echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$var_db_failed\"">>DatabaseConnection_Failed.xml
	echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Failed.xml
	echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Failed.xml
	echo "</CONNECTIONS>">>DatabaseConnection_Failed.xml
	echo "cd /usr/local/iTelAppsServer$billing">runiTelAppsServer.sh
	echo "/usr/jdk1.8.0_111/bin/java -Xmx1024m -jar iTelAppsServer.jar &">>runiTelAppsServer.sh
	echo "cd /usr/local/iTelAppsServer$billing">shutdowniTelAppsServer.sh
	echo "/usr/jdk1.8.0_111/bin/java -jar ShutDown.jar">>shutdowniTelAppsServer.sh
	echo "#!/bin/sh">iTelAppsServer$billing
	echo "## iTelAppsServer   This shell script takes care of starting and stopping iTelAppsServer">>iTelAppsServer$billing
	echo "# Source function library.">>iTelAppsServer$billing
	echo ". /etc/rc.d/init.d/functions">>iTelAppsServer$billing
	echo "#">>iTelAppsServer$billing
	var="\$1"
	echo "case \"$var\" in">>iTelAppsServer$billing
	echo "start)">>iTelAppsServer$billing
	echo "echo -n \"Starting iTelAppsServer....$billing:">>iTelAppsServer$billing
	echo "\"">>iTelAppsServer$billing
	echo "/usr/local/iTelAppsServer$billing/runiTelAppsServer.sh">>iTelAppsServer$billing
	echo ";;">>iTelAppsServer$billing
	echo "stop)">>iTelAppsServer$billing
	echo "echo -n \"Stoping iTelAppsServer.....$billing:">>iTelAppsServer$billing
	echo "\"">>iTelAppsServer$billing
	echo " /usr/local/iTelAppsServer$billing/shutdowniTelAppsServer.sh">>iTelAppsServer$billing
	echo "sleep 10">>iTelAppsServer$billing
	echo ";;">>iTelAppsServer$billing
	echo "restart)">>iTelAppsServer$billing
	var="\$0"
	echo "$var stop">>iTelAppsServer$billing
	echo "$var start">>iTelAppsServer$billing
	echo ";;">>iTelAppsServer$billing
	echo "*)">>iTelAppsServer$billing
	echo "echo \"Usage: $var {start|stop|restart}\"">>iTelAppsServer$billing
	echo "exit 1">>iTelAppsServer$billing
	echo "esac">>iTelAppsServer$billing
	echo "exit 0">>iTelAppsServer$billing
	#iTelAppsServer symbolic link. written into softlink.sh
	echo "chmod 755 /usr/local/iTelAppsServer$billing/runiTelAppsServer.sh">softlink.sh
	echo "chmod 755 /usr/local/iTelAppsServer$billing/shutdowniTelAppsServer.sh">>softlink.sh
	echo "ln -s ../init.d/iTelAppsServer$billing /etc/rc.d/rc3.d/S99iTelAppsServer$billing">>softlink.sh
	echo "ln -s ../init.d/iTelAppsServer$billing /etc/rc.d/rc5.d/S99iTelAppsServer$billing">>softlink.sh
	echo "ln -s ../init.d/iTelAppsServer$billing /etc/rc.d/rc0.d/K10iTelAppsServer$billing">>softlink.sh
	echo "ln -s ../init.d/iTelAppsServer$billing /etc/rc.d/rc6.d/K10iTelAppsServer$billing">>softlink.sh
	cp iTelAppsServer$billing  /etc/rc.d/init.d/
	chmod 755 /etc/rc.d/init.d/iTelAppsServer$billing
	ln -s ../init.d/iTelAppsServer$billing /etc/rc.d/rc3.d/S99iTelAppsServer$billing
	ln -s ../init.d/iTelAppsServer$billing /etc/rc.d/rc5.d/S99iTelAppsServer$billing
	ln -s ../init.d/iTelAppsServer$billing /etc/rc.d/rc0.d/K10iTelAppsServer$billing
	ln -s ../init.d/iTelAppsServer$billing /etc/rc.d/rc6.d/K10iTelAppsServer$billing
	cd /home/smtn;
	mv iTelAppsServer$billing  /usr/local
	chmod 755 /usr/local/iTelAppsServer$billing/runiTelAppsServer.sh
	chmod 755 /usr/local/iTelAppsServer$billing/shutdowniTelAppsServer.sh
  fi
  echo "Lets insert data for system maintenance..."
  echo "$var_db_itel;">/home/smtn/db.txt
  echo "$var_db_successful;">>/home/smtn/db.txt
  echo "$var_db_failed;">>/home/smtn/db.txt
  echo "$var_media;">>/home/smtn/db.txt
  echo "$var_sigling;">>/home/smtn/db.txt
  echo "$billing;">>/home/smtn/db.txt
  echo "$web_server_ip;">>/home/smtn/db.txt
  echo "$server_ip;">>/home/smtn/db.txt
  echo "$server_port;">>/home/smtn/db.txt;
  echo "$nas_port;">>/home/smtn/db.txt;
  fn_insert_system_maintenance_data;
}
function WholeSaleApp()
{
	find /usr/local/  -name iTelAppsServerlSBC$billing | grep iTelAppsServerlSBC$billing && var_apps=1 || var_apps=0
   if [ $var_apps -eq 1 ]
	  then
		echo "iTelAppsServerlSBC$billing exists"
		#echo "Lets insert data for system maintenance..."
		#fn_insert_system_maintenance_data;
		#wget http://$var_installer_ip/downloads/SQL.zip
   else
	echo "Configuring iTelAppsServerlSBC$billing ..."
	rm -rf /home/smtn;
	mkdir  /home/smtn;
	cd /home/smtn;
	wget http://$var_installer_ip/downloads/iTelAppsServerlSBC.zip
	echo "Extracting iTelAppsServerlSBC........"
	unzip -q iTelAppsServerlSBC.zip
	echo "iTelAppsServerlSBC Extracted!!"
	mv iTelAppsServerlSBC  iTelAppsServerlSBC$billing;
	cd iTelAppsServerlSBC$billing;
	#mv iTelAppsServerlSBC$billing  /usr/local
	#cd /usr/local/iTelAppsServerlSBC$billing
	rm -f *.xml
	#DatabaseConnection.xml
	echo "<CONNECTIONS>">DatabaseConnection.xml
	echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///iTelBilling$billing\"">>DatabaseConnection.xml
	echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
	echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
	echo "</CONNECTIONS>">>DatabaseConnection.xml
	cp  -r  DatabaseConnection.xml  DatabaseConnection_PinProtector.xml
	#DatabaseConnection_Successful.xml
	echo "<CONNECTIONS>">DatabaseConnection_Successful.xml
	echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///Successful$billing\"">>DatabaseConnection_Successful.xml
	echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Successful.xml
	echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Successful.xml
	echo "</CONNECTIONS>">>DatabaseConnection_Successful.xml
	cp -r  DatabaseConnection_Successful.xml  DatabaseConnection_Reseller.xml
	#DatabaseConnection_Failed.xml
	echo "<CONNECTIONS>">DatabaseConnection_Failed.xml
	echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///Failed$billing\"">>DatabaseConnection_Failed.xml
	echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Failed.xml
	echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Failed.xml
	echo "</CONNECTIONS>">>DatabaseConnection_Failed.xml
	echo "cd /usr/local/iTelAppsServerlSBC$billing">runiTelAppsServerlSBC.sh
	echo "/usr/jdk1.8.0_111/bin/java -Xmx1024m -jar iTelWholesaleAppServer.jar $billing &">>runiTelAppsServerlSBC.sh
	echo "cd /usr/local/iTelAppsServerlSBC$billing">shutdowniTelAppsServerlSBC.sh
	echo "/usr/jdk1.8.0_111/bin/java -jar ShutDown.jar">>shutdowniTelAppsServerlSBC.sh
	echo "#!/bin/sh">iTelAppsServerlSBC$billing
	echo "## iTelAppsServerlSBC   This shell script takes care of starting and stopping iTelAppsServerlSBC">>iTelAppsServerlSBC$billing
	echo "# Source function library.">>iTelAppsServerlSBC$billing
	echo ". /etc/rc.d/init.d/functions">>iTelAppsServerlSBC$billing
	echo "#">>iTelAppsServerlSBC$billing
	var="\$1"
	echo "case \"$var\" in">>iTelAppsServerlSBC$billing
	echo "start)">>iTelAppsServerlSBC$billing
	echo "echo -n \"Starting iTelAppsServerlSBC....$billing:">>iTelAppsServerlSBC$billing
	echo "\"">>iTelAppsServerlSBC$billing
	echo "/usr/local/iTelAppsServerlSBC$billing/runiTelAppsServerlSBC.sh">>iTelAppsServerlSBC$billing
	echo ";;">>iTelAppsServerlSBC$billing
	echo "stop)">>iTelAppsServerlSBC$billing
	echo "echo -n \"Stoping iTelAppsServerlSBC.....$billing:">>iTelAppsServerlSBC$billing
	echo "\"">>iTelAppsServerlSBC$billing
	echo " /usr/local/iTelAppsServerlSBC$billing/shutdowniTelAppsServerlSBC.sh">>iTelAppsServerlSBC$billing
	echo "sleep 10">>iTelAppsServerlSBC$billing
	echo ";;">>iTelAppsServerlSBC$billing
	echo "restart)">>iTelAppsServerlSBC$billing
	var="\$0"
	echo "$var stop">>iTelAppsServerlSBC$billing
	echo "$var start">>iTelAppsServerlSBC$billing
	echo ";;">>iTelAppsServerlSBC$billing
	echo "*)">>iTelAppsServerlSBC$billing
	echo "echo \"Usage: $var {start|stop|restart}\"">>iTelAppsServerlSBC$billing
	echo "exit 1">>iTelAppsServerlSBC$billing
	echo "esac">>iTelAppsServerlSBC$billing
	echo "exit 0">>iTelAppsServerlSBC$billing
	#iTelAppsServerlSBC symbolic link. written into softlink.sh
	echo "chmod 755 /usr/local/iTelAppsServerlSBC$billing/runiTelAppsServerlSBC.sh">softlink.sh
	echo "chmod 755 /usr/local/iTelAppsServerlSBC$billing/shutdowniTelAppsServerlSBC.sh">>softlink.sh
	echo "ln -s ../init.d/iTelAppsServerlSBC$billing /etc/rc.d/rc3.d/S99iTelAppsServerlSBC$billing">>softlink.sh
	echo "ln -s ../init.d/iTelAppsServerlSBC$billing /etc/rc.d/rc5.d/S99iTelAppsServerlSBC$billing">>softlink.sh
	echo "ln -s ../init.d/iTelAppsServerlSBC$billing /etc/rc.d/rc0.d/K10iTelAppsServerlSBC$billing">>softlink.sh
	echo "ln -s ../init.d/iTelAppsServerlSBC$billing /etc/rc.d/rc6.d/K10iTelAppsServerlSBC$billing">>softlink.sh
	cp iTelAppsServerlSBC$billing  /etc/rc.d/init.d/
	chmod 755 /etc/rc.d/init.d/iTelAppsServerlSBC$billing
	ln -s ../init.d/iTelAppsServerlSBC$billing /etc/rc.d/rc3.d/S99iTelAppsServerlSBC$billing
	ln -s ../init.d/iTelAppsServerlSBC$billing /etc/rc.d/rc5.d/S99iTelAppsServerlSBC$billing
	ln -s ../init.d/iTelAppsServerlSBC$billing /etc/rc.d/rc0.d/K10iTelAppsServerlSBC$billing
	ln -s ../init.d/iTelAppsServerlSBC$billing /etc/rc.d/rc6.d/K10iTelAppsServerlSBC$billing
	cd /home/smtn;
	mv iTelAppsServerlSBC$billing  /usr/local
	chmod 755 /usr/local/iTelAppsServerlSBC$billing/runiTelAppsServerlSBC.sh
	chmod 755 /usr/local/iTelAppsServerlSBC$billing/shutdowniTelAppsServerlSBC.sh
	cd /usr/local/iTelAppsServerlSBC$billing
	echo "MAIL_SEND_TYPE=Default">Configuration.properties
	echo "LAST_CALL_INFO_TAKEN_DAY=2020-01-09">>Configuration.properties
	echo "INVOICE_GENERATION_BASE_URL=http://$remoteSignalingIP/$billing/billgeneration/BillDownload.jsp">>Configuration.properties
  fi
}
function fn_insert_system_maintenance_data(){
		rm -rf /usr/local/src/SystemMaintenance
		rm -f /usr/local/src/SystemMaintenance.zip
		cd /usr/local/src/
		wget http://$var_installer_ip/downloads/SystemMaintenance.zip
		unzip SystemMaintenance.zip
		rm -f  SystemMaintenance.zip;
		cd /usr/local/src/SystemMaintenance
		#installer start file
		echo "cd /usr/local/src/SystemMaintenance">runInstaller.sh
		echo "/usr/jdk1.6.0_25/bin/java -Xmx1024m -jar SystemMaintenance.jar">>runInstaller.sh
		#installer stop file
		echo "cd /usr/local/src/SystemMaintenance">shutDownInstaller.sh
		echo "/usr/jdk1.6.0_25/bin/java -Xmx1024m -jar ShutDown.jar">>shutDownInstaller.sh
		chmod a+x runInstaller.sh
		sh runInstaller.sh
		sleep 5;
		service tomcat stop
		cd /usr/local/jakarta-tomcat-7.0.61/work/
		sleep 5;
		rm -rf Catalina
		cd /usr/local/jakarta-tomcat-7.0.61/logs
		rm -rf catalina.out
		service tomcat start
}
function callshop()
{
		echo "Configuring callshop...";
		echo "use iTelBilling;">>/home/swp/sql.txt;
		echo "source /Sql/CallShopPermission.SQL;">>/home/swp/sql.txt
}
function enable_Promo()
{
	echo "Activating Promotional features...";
	echo "use iTelBilling;">>/home/swp/sql.txt;
	echo "source /Sql/PromotionalOffer.sql;">>/home/swp/sql.txt
}
function enable_Referral()
{
	echo "Activating Referral features...";
	echo "use iTelBilling;">>/home/swp/sql.txt;
	echo "source /Sql/ReferralDB_DDL.sql;">>/home/swp/sql.txt
}
function enable_DID()
{
	echo "Activating DID...";
	echo "use iTelBilling;">>/home/swp/sql.txt;
	echo "source /Sql/DIDPermission.SQL;">>/home/swp/sql.txt
}
function enable_MTU()
{
	echo "Activating MTU...";
	echo "use iTelBilling;">>/home/swp/sql.txt;
	echo "source /Sql/MTUPermission.SQL;">>/home/swp/sql.txt
}
function enable_MT()
{
	echo "Activating Money Transfer...";
	echo "use iTelBilling;">>/home/swp/sql.txt;
	echo "source /Sql/Moneytransfer.sql;">>/home/swp/sql.txt
}
function reseller_partition()
{
		echo "Configuring reseller partition...";
		echo "use iTelBilling;">>/home/swp/sql.txt;
		echo "source /Sql/ResellerPartitionMenuPermission.SQL;">>/home/swp/sql.txt
}
function switch_partition()
{
	echo -n "Enter server ip: ";
	read server_ip;
	echo -n "Enter server Port: ";
	read server_port;
	echo -n "Enter MediaProxy End Port: ";
	read media_end_port;
	sql="insert into vbSwitchManagerConfiguration values(1,'$server_ip',$server_port,$media_end_port);";
	if [ $flg_paid_module == "new" ]
	 then
		echo "Configuring switch partition...";
		echo "use iTelBilling;">>/home/swp/sql.txt;
		echo "source /Sql/SwitchPartition.SQL;">>/home/swp/sql.txt
		echo "$sql">>/Sql/SwitchPartition.SQL
	else
	   echo "Configuring switch partition...";
	   echo "use iTelBilling;">>/home/update_db/updatesql.txt
	   echo "source /home/update_db/updateSQL/SwitchPartition.SQL;">>/home/update_db/updatesql.txt
	   echo "$sql">>/home/update_db/updateSQL/SwitchPartition.SQL
	fi
	billing=$var_web;
	db_itel=$var_db_itelbilling;
	db_suc=$var_db_successful;
	db_failed=$var_db_failed_failed;
	#var_jdk
	cd /home
	rm -rf swInstaller;
	mkdir swInstaller;
	cd swInstaller
	wget http://$var_installer_ip/downloads/SwitchInstaller.zip
	unzip SwitchInstaller.zip;
	mv SwitchInstaller SwitchInstaller$billing
	cd SwitchInstaller$billing
	#DatabaseConnection_Failed.xml
		echo "<CONNECTIONS>">DatabaseConnection_Failed.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$db_failed\"">>DatabaseConnection_Failed.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Failed.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Failed.xml
		echo "</CONNECTIONS>">>DatabaseConnection_Failed.xml
		#DatabaseConnection_Successful.xml
		echo "<CONNECTIONS>">DatabaseConnection_Successful.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$db_suc\"">>DatabaseConnection_Successful.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Successful.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Successful.xml
		echo "</CONNECTIONS>">>DatabaseConnection_Successful.xml
		#DatabaseConnection_Reseller.xml
		echo "<CONNECTIONS>">DatabaseConnection_Reseller.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$db_suc\"">>DatabaseConnection_Reseller.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Reseller.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Reseller.xml
		echo "</CONNECTIONS>">>DatabaseConnection_Reseller.xml
		#DatabaseConnection.xml
		echo "<CONNECTIONS>">DatabaseConnection.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$db_itel\"">>DatabaseConnection.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
		echo "</CONNECTIONS>">>DatabaseConnection.xml
		echo "cd /usr/local/SwitchInstaller$billing">runSwitchInstaller.sh
		echo "$var_jdk/bin/java -Xmx1024m -jar SwitchInstaller.jar &">>runSwitchInstaller.sh
		echo "cd /usr/local/SwitchInstaller$billing">shutdownSwitchInstaller.sh
		echo "$var_jdk/bin/java  -jar ShutDown.jar &">>shutdownSwitchInstaller.sh
		# service file
		echo "#!/bin/sh">SwitchInstaller$billing
		echo "## SwitchInstaller   This shell script takes care of starting and stopping SwitchInstaller">>SwitchInstaller$billing
		echo "# Source function library.">>SwitchInstaller$billing
		echo ". /etc/rc.d/init.d/functions">>SwitchInstaller$billing
		echo "#">>SwitchInstaller$billing
		var="\$1"
		echo "case \"$var\" in">>SwitchInstaller$billing
		echo "start)">>SwitchInstaller$billing
		echo "echo -n \"Starting SwitchInstaller....$billing:">>SwitchInstaller$billing
		echo "\"">>SwitchInstaller$billing
		echo "/usr/local/SwitchInstaller$billing/runSwitchInstaller.sh">>SwitchInstaller$billing
		echo ";;">>SwitchInstaller$billing
		echo "stop)">>SwitchInstaller$billing
		echo "echo -n \"Stoping SwitchInstaller.....$billing:">>SwitchInstaller$billing
		echo "\"">>SwitchInstaller$billing
		echo " /usr/local/SwitchInstaller$billing/shutdownSwitchInstaller.sh">>SwitchInstaller$billing
		echo "sleep 10">>SwitchInstaller$billing
		echo ";;">>SwitchInstaller$billing
		echo "restart)">>SwitchInstaller$billing
		var="\$0"
		echo "$var stop">>SwitchInstaller$billing
		echo "$var start">>SwitchInstaller$billing
		echo ";;">>SwitchInstaller$billing
		echo "*)">>SwitchInstaller$billing
		echo "echo \"Usage: $var {start|stop|restart}\"">>SwitchInstaller$billing
		echo "exit 1">>SwitchInstaller$billing
		echo "esac">>SwitchInstaller$billing
		echo "exit 0">>SwitchInstaller$billing
		cp SwitchInstaller$billing /etc/rc.d/init.d/
		chmod 755 /etc/rc.d/init.d/SwitchInstaller$billing
		#symbolic lilnk
		chmod 755 /usr/local/SwitchInstaller$billing/runSwitchInstaller.sh
		chmod 755 /usr/local/SwitchInstaller$billing/shutdownSwitchInstaller.sh
		ln -s ../init.d/SwitchInstaller$billing /etc/rc.d/rc3.d/S99SwitchInstaller$billing
		ln -s ../init.d/SwitchInstaller$billing /etc/rc.d/rc5.d/S99SwitchInstaller$billing
		ln -s ../init.d/SwitchInstaller$billing /etc/rc.d/rc0.d/K10SwitchInstaller$billing
		ln -s ../init.d/SwitchInstaller$billing /etc/rc.d/rc6.d/K10SwitchInstaller$billing
		#rm -rf installationfiles
		#mkdir installationfiles
		cd installationfiles
		#wget http://$var_installer_ip/downloads/itelswplus3.3.zip
		#unzip itelswplus3.3.zip
		#rm -rf itelbilling  itelswplus3.3.zip  Sql  sql.txt
		cd iTelSwitchPlusSignaling
		echo "cd /usr/local/iTelSwitchPlusSignaling">runiTelSwitchPlusSignaling.sh
		echo "$var_jdk/bin/java -Xmx1024m -jar iTelSwitchPlusSignaling.jar &">>runiTelSwitchPlusSignaling.sh
		echo "cd /usr/local/iTelSwitchPlusSignaling">shutdowniTelSwitchPlusSignaling.sh
		echo "$var_jdk/bin/java  -jar ShutDown.jar &">>shutdowniTelSwitchPlusSignaling.sh
		cd ../iTelSwitchPlusMediaProxy/
		echo "cd /usr/local/iTelSwitchPlusMediaProxy">runiTelSwitchPlusMediaProxy.sh
		echo "$var_jdk/bin/java -Xmx1024m -jar iTelSwitchPlusMediaProxy.jar &">>runiTelSwitchPlusMediaProxy.sh
		echo "cd /usr/local/iTelSwitchPlusMediaProxy">shutdowniTelSwitchPlusMediaProxy.sh
		echo "$var_jdk/bin/java  -jar ShutDown.jar &">>shutdowniTelSwitchPlusMediaProxy.sh
		cd ../
		if [ $x_64 -eq 1 ]
		 then
		  echo "$x_64: x86_64: configuraing 64-so...";
		 else
		   echo "$x_64: x86_32. configuring 32-so...";
		   wget http://$var_installer_ip/downloads/SignalingProxy.so_32
		   wget http://$var_installer_ip/downloads/MediaProxy.so_32
		   mv MediaProxy.so_32 MediaProxy.so
		   mv SignalingProxy.so_32 SignalingProxy.so
		   rm -f iTelSwitchPlusSignaling/SignalingProxy.so
		   rm -f iTelSwitchPlusMediaProxy/MediaProxy.so
		   mv MediaProxy.so iTelSwitchPlusMediaProxy
		   mv SignalingProxy.so iTelSwitchPlusSignaling
		 fi
		cd /home/swInstaller
		mv SwitchInstaller$billing /usr/local/
}
function paid_module(){
  echo -n "Enable Callshop? y/n: ";
  read var_callshop;
  echo -n "Enable reseller Partition? y/n: ";
  read var_res_partition;
  echo -n "Enable switch Partition? y/n: ";
  read var_sw_partition;
  echo -n "Enable DID? y/n: ";
  read var_DID;
  echo -n "Enable MTU? y/n: ";
  read var_MTU;
  echo -n "Enable Money Transfer? y/n: ";
  read var_MT;
  echo -n "Enable Promotional Feature? y/n: ";
  read var_Promo;
  echo -n "Enable Referral Feature? y/n: ";
  read var_Reff;
  if [ -z "${var_MTU}" ]
	 then
		#echo "Empty value";
		var_MTU="n";
  fi
  if [ -z "${var_Promo}" ]
	 then
		#echo "Empty value";
		var_Promo="n";
  fi
  if [ $var_MTU == y ]
   then
	 echo "Activating MTU...";
	 enable_MTU;
   else
	echo "Skipping MTU";
  fi
  if [ -z "${var_MT}" ]
	 then
		#echo "Empty value";
		var_MT="n";
  fi
  if [ $var_MT == y ]
   then
	 echo "Activating MoneyTransfer...";
	 enable_MT;
	 else
	echo "Skipping Money Transfer";
  fi
  if [ $var_Promo == y ]
   then
	 echo "Activating Promotional offer...";
	 enable_Promo;
	 else
	echo "Skipping Promotional features";
  fi
  if [ $var_Reff == y ]
   then
	 echo "Activating Referral offer...";
	 enable_Referral;
	 else
	echo "Skipping Referral features";
  fi
  if [ -z "${var_DID}" ]
	 then
		#echo "Empty value";
		var_DID="n";
  fi
  if [ $var_DID == y ]
   then
	 echo "Activating DID...";
	 enable_DID;
   else
	echo "Skipping DID";
  fi
  if [ -z "${var_callshop}" ]
	 then
		#echo "Empty value";
		var_callshop="n";
  fi
  if [ $var_callshop == y ]
   then
	 echo "Configuring callshop...";
	 callshop;
   else
	echo "Skipping callshop module";
  fi
  if [ -z "${var_res_partition}" ]
	 then
		#echo "Empty value";
		var_res_partition="n";
  fi
  if [ $var_res_partition == y ]
   then
	 echo "Configuring reseller partition...";
	 reseller_partition;
   else
	echo "Skipping reseller partition";
  fi
  if [ -z "${var_sw_partition}" ]
	 then
		#echo "Empty value";
		var_sw_partition="n";
  fi
  if [ $var_sw_partition == y ]
   then
	 echo "Configuring switch partition...";
	 switch_partition;
   else
	echo "Skipping switch partition";
  fi
}
function fn_update(){
  web_v="5.0.7.7";
  media_v="3.0.8"
  signaling_v="3.3.5 minor version 1.0";
  echo -n "Enter Billing name: ";
  read var_org_billing;
  echo -n "Enter Media name: ";
  read var_media;
  echo -n "Enter Signaling name: ";
  read var_sigling;
  echo -n "Enter Database name(iTelBilling): ";
  read var_db_itel;
  echo -n "Enter Database name(Successful): ";
  read var_db_suc;
  echo -n "Enter Database name(Failed): ";
  read var_db_failed;
  var_web=$var_org_billing;
  var_db_itelbilling=$var_db_itel;
  var_db_successful=$var_db_suc;
  var_db_failed_failed=$var_db_failed;
  #service iTelSwitchPlusMediaProxy stop
  #service iTelSwitchPlusSignaling stop
  #service tomcat stop
  #backup web and download new web
  #date '+billing%d_%m_%y_%H_%M_%S';
  date '+_%d_%m_%y_%H_%M_%S'>time
  var_date_time=$(<time);
  var_backup=$var_org_billing$var_date_time;
  var_sw_m=$var_date_time;
  echo "$var_backup";
  #service tomcat stop
  cd /usr/local/jakarta-tomcat-$var_tomcat/webapps/
  echo "taking backup for $var_org_billing"
  mv  $var_org_billing $var_backup;
  rm -rf temp_billing
  mkdir temp_billing
  cd temp_billing;
  #wget http://$var_installer_ip/downloads/itelbilling_5_0_4.zip
  #wget http://$var_installer_ip/downloads/itelbilling_5_0_4_1.zip
  #wget http://$var_installer_ip/downloads/itelbilling_5_0_5.zip
  #wget http://$var_installer_ip/downloads/itelbilling_5_0_6.zip
  #wget http://$var_installer_ip/downloads/itelbilling_5_0_7.zip
  #wget http://$var_installer_ip/downloads/itelbilling_5_0_7_1.zip
  #wget http://$var_installer_ip/downloads/itelbilling_5_0_7_6.zip
  wget http://$var_installer_ip/downloads/itelbilling_5_0_7_7.zip
  unzip itelbilling_5_0_7_7.zip;
  mv  itelbilling $var_org_billing;
  mv $var_org_billing  /usr/local/jakarta-tomcat-$var_tomcat/webapps/
  cd /usr/local/jakarta-tomcat-$var_tomcat/webapps/$var_org_billing/WEB-INF/classes;
  rm -f *.xml
  cd /usr/local/$var_sigling;
  sh shutdowniTelSwitchPlusSignaling.sh
  rm -f *.log;
  cp -r *.xml /usr/local/jakarta-tomcat-$var_tomcat/webapps/$var_org_billing/WEB-INF/classes/
  rm -f SignalingProxy.so;
  
  if [ $x_64 -eq 1 ]
	then
	echo "$x_64: x86_64: configuring 64-so...";
	wget http://$var_installer_ip/downloads/SignalingProxy.so_64
	mv SignalingProxy.so_64 SignalingProxy.so
   else
	echo "$x_64: x86_32. configuring 32-so...";
	wget http://$var_installer_ip/downloads/SignalingProxy.so_32
	mv SignalingProxy.so_64 SignalingProxy.so
   fi
  mv iTelSwitchPlusSignaling.jar  iTelSwitchPlusSignaling.jar_$var_sw_m;
  rm -f iTelSwitchPlusSignaling.jar
  
  #version: 3.3.2 . prev: 3.3.0
  #version: 3.3.4 minor version 4,  3.3.4 minor version 1,  3.3.2
  #version: 3.3.5 minor v 1 web: 5.0.7, 3.3.4 minor v 5 web: 5.0.6
  #version: 3.3.5 minor v 1 web: 5.0.7.1
  #version: 3.3.5 minor v 1 web: 5.0.7.3
  
  wget  http://$var_installer_ip/downloads/iTelSwitchPlusSignaling.jar
  cd /usr/local/$var_media
  echo "Version: ">version
  echo "web: $web_v">>version
  echo "Media: $media_v">>version
  echo "Signaling: $signaling_v">>version
  sh shutdowniTelSwitchPlusMediaProxy.sh
  rm -f *.log;
  rm -f MediaProxy.so;
  
  if [ $x_64 -eq 1 ]
	then
	echo "$x_64: x86_64: configuring 64-so...";
	wget http://$var_installer_ip/downloads/MediaProxy.so_64
	mv MediaProxy.so_64 MediaProxy.so
   else
	echo "$x_64: x86_32. configuring 32-so...";
	wget http://$var_installer_ip/downloads/MediaProxy.so_32
	mv MediaProxy.so_64 MediaProxy.so
   fi
   
  mv iTelSwitchPlusMediaProxy.jar iTelSwitchPlusMediaProxy.jar_$var_sw_m;
  rm -f iTelSwitchPlusMediaProxy.jar_3_0_7
  
  # version: 3.0.8 . prev: 3.0.7
  wget http://$var_installer_ip/downloads/iTelSwitchPlusMediaProxy.jar
  mv  iTelSwitchPlusMediaProxy.jar_3_0_7  iTelSwitchPlusMediaProxy.jar
  rm -f IVR_503.zip;
  
  #wget  http://$var_installer_ip/downloads/IVR_503.zip
  wget  http://$var_installer_ip/downloads/IVR.zip
  mv IVR IVR_$var_sw_m;
  unzip   IVR.zip;
  rm -rf /home/update_db
  mkdir /home/update_db
  cd  /home/update_db
  wget http://$var_installer_ip/downloads/updatesql.txt
  wget http://$var_installer_ip/downloads/updateSQL.zip
  unzip updateSQL.zip
  echo "$var_db_itel;">/home/update_db/db.txt
  echo "$var_db_suc;">>/home/update_db/db.txt
  echo "$var_db_failed;">>/home/update_db/db.txt
  echo "/usr/local/$var_sigling;">>/home/update_db/db.txt
  flg_paid_module="update";
  paid_module;
  cd  /home/update_db
  #download update jar
  rm -rf /usr/local/updaterjar
  #mkdir /usr/local/updaterjar
  rm -rf  /usr/local/src/updaterjar
  mkdir /usr/local/src/updaterjar
  cd /usr/local/src/updaterjar
  wget http://$var_installer_ip/downloads/updater.jar
  #installer start file
  echo "cd /usr/local/src/updaterjar">runInstaller.sh
  echo "$var_jdk/bin/java -Xmx1024m -jar updater.jar &">>runInstaller.sh
  #log4j.properties
  echo "l#Default log level to ERROR. Other levels are INFO and DEBUG.">log4j.properties
  echo "log4j.rootLogger=, ROOT">>log4j.properties
  echo "log4j.appender.ROOT=org.apache.log4j.RollingFileAppender">>log4j.properties
  echo "log4j.appender.ROOT.File= updater.log">>log4j.properties
  echo "log4j.appender.ROOT.MaxFileSize=5MB">>log4j.properties
  echo "#Keep 5 old files around.">>log4j.properties
  echo "log4j.appender.ROOT.MaxBackupIndex=0">>log4j.properties
  echo "log4j.appender.ROOT.layout=org.apache.log4j.PatternLayout">>log4j.properties
  echo "#Format almost same as WebSphere's common log format.">>log4j.properties
  echo "log4j.appender.ROOT.layout.ConversionPattern=%-4r %-5p [%t] (%x) - %m\n">>log4j.properties
  echo "#Optionally override log level of individual packages or classes">>log4j.properties
  echo "#log4j.logger.com.webage.ejbs=INFO">>log4j.properties
  #DatabaseConnection.xml
  echo "<CONNECTIONS>">DatabaseConnection.xml
  echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///mysql\"">>DatabaseConnection.xml
  echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
  echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
  echo "</CONNECTIONS>">>DatabaseConnection.xml
  cd /usr/local/src/updaterjar
  chmod a+x runInstaller.sh
  sh runInstaller.sh
  service tomcat restart
  service $var_media start
  sleep 5;
  service $var_sigling start
  sleep 10;
}
function fn_recycle_iTelSwitch(){
  start="n";
  date '+_%d%m%y%H%M%S'>time
  var_date_time=$(<time);
  echo -n "Recycle for a Single switch? y/n : ";
  read yorn;
  if [ $yorn == y ]
   then
	  echo -n "Enter Database name(iTelBilling): ";
	  read var_db_itel;
	  echo -n "Enter Database name(Successful): ";
	  read var_db_suc;
	  echo -n "Enter Database name(Failed): ";
	  read var_db_failed;
	  echo -n "Enter Administrative User: ";
	  read var_admin_user;
	  echo -n "Enter Admin Password: ";
	  read var_admin_pass;
	  start="y";
   else
	  echo "========================================================="
	  echo "Please prapare a csv into directory /home/data.csv";
	  echo "column: iTelBilling, Successful, Failed, Admin User, Admin Password";
	  echo "=========================================================";
	  sleep 3;
	  echo -n "Ready to Start Recycle? y/n : ";
	  read start;
   fi
   if [ $start == n ]
	 then
	  echo "Skipping multiple recycle process.";
   else
	 echo "Starting recycle process.";
	 #cd /var/lib/mysql/
	 #tar -cvf db_$var_db_itel$var_date_time.tar  $var_db_itel  $var_db_suc
	rm -rf /home/recycle/
	mkdir /home/recycle/
	cd  /home/recycle/
	echo "$yorn;">/home/recycle/info.txt
	echo "$var_date_time;">/home/recycle/db.txt
	echo "$var_db_itel;">>/home/recycle/db.txt
	echo "$var_db_suc;">>/home/recycle/db.txt
	echo "$var_db_failed;">>/home/recycle/db.txt
	echo "$var_admin_user;">>/home/recycle/db.txt
	echo "$var_admin_pass;">>/home/recycle/db.txt
	if [ $flg_recycle -eq 0 ]
	then
	#download iTelSwitchRecycler jar
	rm -rf /usr/local/iTelSwitchRecycler
	#mkdir /usr/local/iTelSwitchRecycler
	rm -rf /usr/local/src/iTelSwitchRecycler
	mkdir  /usr/local/src/iTelSwitchRecycler
	cd /usr/local/src/iTelSwitchRecycler
	wget http://$var_installer_ip/downloads/iTelSwitchRecycler720.jar
	#iTelSwitchRecycler start file
	echo "cd /usr/local/src/iTelSwitchRecycler">runiTelSwitchRecycler.sh
	echo "$var_jdk/bin/java -Xmx1024m -jar iTelSwitchRecycler720.jar &">>runiTelSwitchRecycler.sh
	#log4j.properties
	echo "l#Default log level to ERROR. Other levels are INFO and DEBUG.">log4j.properties
	echo "log4j.rootLogger=, ROOT">>log4j.properties
	echo "log4j.appender.ROOT=org.apache.log4j.RollingFileAppender">>log4j.properties
	echo "log4j.appender.ROOT.File= iTelSwitchRecycler.log">>log4j.properties
	echo "log4j.appender.ROOT.MaxFileSize=5MB">>log4j.properties
	echo "#Keep 5 old files around.">>log4j.properties
	echo "log4j.appender.ROOT.MaxBackupIndex=0">>log4j.properties
	echo "log4j.appender.ROOT.layout=org.apache.log4j.PatternLayout">>log4j.properties
	echo "#Format almost same as WebSphere's common log format.">>log4j.properties
	echo "log4j.appender.ROOT.layout.ConversionPattern=%-4r %-5p [%t] (%x) - %m\n">>log4j.properties
	echo "#Optionally override log level of individual packages or classes">>log4j.properties
	echo "#log4j.logger.com.webage.ejbs=INFO">>log4j.properties
	#DatabaseConnection.xml
	echo "<CONNECTIONS>">DatabaseConnection.xml
	echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///mysql\"">>DatabaseConnection.xml
	echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
	echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
	echo "</CONNECTIONS>">>DatabaseConnection.xml
	fi
	flg_recycle=1;
	cd /usr/local/src/iTelSwitchRecycler
	chmod a+x runiTelSwitchRecycler.sh
	sh runiTelSwitchRecycler.sh
  fi
}
function fn_mobileBilling(){
		echo -e "\n\n\n\n\n\n\n\n${Black} ################## ${BRed}:: Installing MobileBilling :: ${Black}################${NC}#";
	  if [ $flg_mb -eq 0 ]
		then
			echo -n "Enter Billing name: ";
			read var_billing;
			echo -n "Enter Database name(iTelBilling): ";
			read var_db_itel;
			echo -n "Enter Database name(Successful): ";
			read var_db_suc;
			echo -n "Enter Database name(Failed): ";
			read var_db_failed;
		else
			var_billing=$var_web;
			var_db_itel=$var_db_itelbilling;
			var_db_suc=$var_db_successful;
			var_db_failed=$var_db_failed_failed;
	  fi
	  flg_mb=0;
	  #Configure Configuration.properties
	  echo "Sample configuration.";
	  echo "-------------------------------------------"
	  echo "bindAddress=98.158.148.10"
	  echo "bindPort=301"
	  #echo "latestVersion=1.01"
	  echo "-------------------------------------------"
	  echo -n "Enter bindAddress: ";
	  read var_bindAddress;
	  echo -n "Enter bindPort: ";
	  read var_bindPort;
	  echo "mobileBillingIP=$var_bindAddress">>/home/swp/deliveryEmail.cfg
	  echo "mobileBillingPORT=$var_bindPort">>/home/swp/deliveryEmail.cfg
	  if [ $flg_mbilling -eq 0 ]
		 then
		 # echo "IF FLG: $flg";
		  rm -rf /home/mbilling
		  mkdir /home/mbilling
		  cd /home/mbilling
		  wget  http://$var_installer_ip/downloads/MobileBilling.zip
	  fi
	  flg_mbilling=1;
	  cd /home/mbilling
	  echo "Extacting MobileBilling..........."
	  unzip -q MobileBilling.zip;
	  echo "MobileBilling Extracted!!"
	  mv  MobileBilling  MobileBilling$var_billing;
	  cd MobileBilling$var_billing;
	  echo "bindAddress=$var_bindAddress">Configuration.properties
	  echo "bindPort=$var_bindPort" >>Configuration.properties
	  echo "Version=1.01" >>Configuration.properties
	  echo "cd /usr/local/MobileBilling$var_billing">runSwitchWizard.sh
	  echo "$var_jdk/bin/java -Xmx1024m -jar MobileBilling.jar &">>runSwitchWizard.sh
	  echo "cd /usr/local/MobileBilling$var_billing">shutdownSwitchWizard.sh
	  echo "$var_jdk/bin/java -jar ShutDown.jar">>shutdownSwitchWizard.sh
	  #DatabaseConnection_Failed.xml
		echo "<CONNECTIONS>">DatabaseConnection_Failed.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$var_db_failed\"">>DatabaseConnection_Failed.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Failed.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Failed.xml
		echo "</CONNECTIONS>">>DatabaseConnection_Failed.xml
		#DatabaseConnection_Successful.xml
		echo "<CONNECTIONS>">DatabaseConnection_Successful.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$var_db_suc\"">>DatabaseConnection_Successful.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Successful.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Successful.xml
		echo "</CONNECTIONS>">>DatabaseConnection_Successful.xml
		#DatabaseConnection_Reseller.xml
		echo "<CONNECTIONS>">DatabaseConnection_Reseller.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$var_db_suc\"">>DatabaseConnection_Reseller.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Reseller.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Reseller.xml
		echo "</CONNECTIONS>">>DatabaseConnection_Reseller.xml
		#DatabaseConnection.xml
		echo "<CONNECTIONS>">DatabaseConnection.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$var_db_itel\"">>DatabaseConnection.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
		echo "</CONNECTIONS>">>DatabaseConnection.xml
	   #Mobile Billing service file
		echo "#!/bin/sh">MobileBilling$var_billing
		echo "## MobileBilling   This shell script takes care of starting and stopping MobileBilling">>MobileBilling$var_billing
		echo "# Source function library.">>MobileBilling$var_billing
		echo ". /etc/rc.d/init.d/functions">>MobileBilling$var_billing
		echo "#">>MobileBilling$var_billing
		var="\$1"
		echo "case \"$var\" in">>MobileBilling$var_billing
		echo "start)">>MobileBilling$var_billing
		echo "echo -n \"Starting  MobileBilling$var_billing:">>MobileBilling$var_billing
		echo "\"">>MobileBilling$var_billing
		echo "/usr/local/MobileBilling$var_billing/runSwitchWizard.sh">>MobileBilling$var_billing
		echo ";;">>MobileBilling$var_billing
		echo "stop)">>MobileBilling$var_billing
		echo "echo -n \"Stoping  MobileBilling$var_billing:">>MobileBilling$var_billing
		echo "\"">>MobileBilling$var_billing
		echo "/usr/local/MobileBilling$var_billing/shutdownSwitchWizard.sh">>MobileBilling$var_billing
		echo "sleep 10">>MobileBilling$var_billing
		echo ";;">>MobileBilling$var_billing
		echo "restart)">>MobileBilling$var_billing
		var="\$0"
		echo "$var stop">>MobileBilling$var_billing
		echo "$var start">>MobileBilling$var_billing
		echo ";;">>MobileBilling$var_billing
		echo "*)">>MobileBilling$var_billing
		echo "echo \"Usage: $var {start|stop|restart}\"">>MobileBilling$var_billing
		echo "exit 1">>MobileBilling$var_billing
		echo "esac">>MobileBilling$var_billing
		echo "exit 0">>MobileBilling$var_billing
		cp MobileBilling$var_billing /etc/rc.d/init.d/
		chmod 755 /etc/rc.d/init.d/MobileBilling$var_billing
		ln -s ../init.d/MobileBilling$var_billing /etc/rc.d/rc3.d/S99MobileBilling$var_billing
		ln -s ../init.d/MobileBilling$var_billing /etc/rc.d/rc5.d/S99MobileBilling$var_billing
		ln -s ../init.d/MobileBilling$var_billing /etc/rc.d/rc0.d/K10MobileBilling$var_billing
		ln -s ../init.d/MobileBilling$var_billing /etc/rc.d/rc6.d/K10MobileBilling$var_billing
		cd ..
		mv   MobileBilling$var_billing /usr/local/
		chmod 755 /usr/local/MobileBilling$var_billing/runSwitchWizard.sh
		chmod 755 /usr/local/MobileBilling$var_billing/shutdownSwitchWizard.sh
		/sbin/service   MobileBilling$var_billing start
		sleep 3;
}
function fn_mobileTopUP(){
		echo -e "\n\n\n\n\n\n\n\n${Black} ################## ${BRed}:: Installing Topup Server :: ${Black}################${NC}#";
	  if [ $flg_mt -eq 0 ]
		then
			echo -n "Enter Billing name: ";
			read var_billing;
			echo -n "Enter Database name(iTelBilling): ";
			read var_db_itel;
		else
			var_billing=$var_web;
			var_db_itel=$var_db_itelbilling;
	  fi
	  flg_mt=0;
	  #Configure Configuration.properties
	  echo "Sample configuration.";
	  echo "-------------------------------------------"
	  echo "webListeningPort=90"
	  echo "deviceListeningPort=94"
	  echo "bindAddress=208.74.77.51"
	  echo "pendingRequestProcessInterval=3600"
	  echo "webAddress=208.74.77.51"
	  echo "TransferTo=CDAB;XYZA;"
	  echo "RechargeNow=CDEF;"
	  echo "Mobikwik=abc@abc.com;"
	  echo "Ezetop=384abbb2-398f-422a-a332-3ff9abac0f51;"
	  echo "Debug=Yes"
	  echo "-------------------------------------------"
	  echo -n "Enter webListeningPort: ";
	  read var_webListeningPort;
	  echo -n "Enter deviceListeningPort: ";
	  read var_deviceListeningPort;
	  echo -n "Enter bindAddress: ";
	  read var_bindAddress;
	  echo -n "Enter webAddress: ";
	  read var_webAddress;
	  if [ $flg_mtopup -eq 0 ]
		 then
		 # echo "IF FLG: $flg";
		  rm -rf /home/mtopup
		  mkdir /home/mtopup
		  cd /home/mtopup
		  wget  http://$var_installer_ip/downloads/TopUpServer.zip
	  fi
	  flg_mtopup=1;
	  cd /home/mtopup
	  echo "Extracting Topup Server.........."
	  unzip -q TopUpServer.zip;
	  echo "Topup Server Extracted!!"
	  mv  TopUpServer  TopUpServer$var_billing;
	  cd TopUpServer$var_billing;
	  echo "webListeningPort=$var_webListeningPort">Configuration.properties
	  echo "deviceListeningPort=$var_deviceListeningPort">>Configuration.properties
	  echo "bindAddress=$var_bindAddress">>Configuration.properties
	  echo "pendingRequestProcessInterval=3600">>Configuration.properties
	  echo "webAddress=$var_webAddress">>Configuration.properties
	  echo "TransferTo=CDAB;XYZA;">>Configuration.properties
	  echo "RechargeNow=CDEF;">>Configuration.properties
	  echo "Mobikwik=abc@abc.com;">>Configuration.properties
	  echo "Ezetop=384abbb2-398f-422a-a332-3ff9abac0f51;">>Configuration.properties
	  echo "Debug=Yes">>Configuration.properties
	  echo "requestClearTimeInMin=60">>Configuration.properties
	  echo "cd /usr/local/TopUpServer$var_billing">runTopUpServer.sh
	  echo "$var_jdk/bin/java -Xmx1024m -jar TopUpServer.jar &">>runTopUpServer.sh
	  echo "cd /usr/local/TopUpServer$var_billing">shutdownTopUpServer.sh
	  echo "$var_jdk/bin/java -jar ShutDown.jar">>shutdownTopUpServer.sh
	  #DatabaseConnection.xml
		echo "<CONNECTIONS>">DatabaseConnection.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$var_db_itel\"">>DatabaseConnection.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
		echo "</CONNECTIONS>">>DatabaseConnection.xml
		#Mobile Top Up service file
		echo "#!/bin/sh">TopUpServer$var_billing
		echo "## TopUpServer This shell script takes care of starting and stopping TopUpServer">>TopUpServer$var_billing
		echo "# Source function library.">>TopUpServer$var_billing
		echo ". /etc/rc.d/init.d/functions">>TopUpServer$var_billing
		echo "#">>TopUpServer$var_billing
		var="\$1"
		echo "case \"$var\" in">>TopUpServer$var_billing
		echo "start)">>TopUpServer$var_billing
		echo "echo -n \"Starting  TopUpServer$var_billing:">>TopUpServer$var_billing
		echo "\"">>TopUpServer$var_billing
		echo "/usr/local/TopUpServer$var_billing/runTopUpServer.sh">>TopUpServer$var_billing
		echo ";;">>TopUpServer$var_billing
		echo "stop)">>TopUpServer$var_billing
		echo "echo -n \"Stoping  TopUpServer$var_billing:">>TopUpServer$var_billing
		echo "\"">>TopUpServer$var_billing
		echo "/usr/local/TopUpServer$var_billing/shutdownTopUpServer.sh">>TopUpServer$var_billing
		echo "sleep 10">>TopUpServer$var_billing
		echo ";;">>TopUpServer$var_billing
		echo "restart)">>TopUpServer$var_billing
		var="\$0"
		echo "$var stop">>TopUpServer$var_billing
		echo "$var start">>TopUpServer$var_billing
		echo ";;">>TopUpServer$var_billing
		echo "*)">>TopUpServer$var_billing
		echo "echo \"Usage: $var {start|stop|restart}\"">>TopUpServer$var_billing
		echo "exit 1">>TopUpServer$var_billing
		echo "esac">>TopUpServer$var_billing
		echo "exit 0">>TopUpServer$var_billing
		cp TopUpServer$var_billing /etc/rc.d/init.d/
		chmod 755 /etc/rc.d/init.d/TopUpServer$var_billing
		ln -s ../init.d/TopUpServer$var_billing /etc/rc.d/rc3.d/S99TopUpServer$var_billing
		ln -s ../init.d/TopUpServer$var_billing /etc/rc.d/rc5.d/S99TopUpServer$var_billing
		ln -s ../init.d/TopUpServer$var_billing /etc/rc.d/rc0.d/K10TopUpServer$var_billing
		ln -s ../init.d/TopUpServer$var_billing /etc/rc.d/rc6.d/K10TopUpServer$var_billing
		cd ..
		mv   TopUpServer$var_billing /usr/local/
		chmod 755 /usr/local/TopUpServer$var_billing/runTopUpServer.sh
		chmod 755 /usr/local/TopUpServer$var_billing/shutdownTopUpServer.sh
		#need jar to insert topserver ip and port
		echo "$var_db_itel;">/home/mtopup/serverConfig.txt
		echo "$var_bindAddress;">>/home/mtopup/serverConfig.txt
		echo "$var_webListeningPort;">>/home/mtopup/serverConfig.txt
		rm -rf /usr/local/mtujar
		#mkdir /usr/local/mtujar
		rm -rf /usr/local/src/mtujar
		mkdir /usr/local/src/mtujar
		cd /usr/local/src/mtujar
		wget http://$var_installer_ip/downloads/mtu.jar
		#installer start file
		echo "cd /usr/local/src/mtujar">runMTU.sh
		echo "$var_jdk/bin/java -Xmx1024m -jar mtu.jar &">>runMTU.sh
		#log4j.properties
		echo "l#Default log level to ERROR. Other levels are INFO and DEBUG.">log4j.properties
		echo "log4j.rootLogger=, ROOT">>log4j.properties
		echo "log4j.appender.ROOT=org.apache.log4j.RollingFileAppender">>log4j.properties
		echo "log4j.appender.ROOT.File= mtu.log">>log4j.properties
		echo "log4j.appender.ROOT.MaxFileSize=5MB">>log4j.properties
		echo "#Keep 5 old files around.">>log4j.properties
		echo "log4j.appender.ROOT.MaxBackupIndex=0">>log4j.properties
		echo "log4j.appender.ROOT.layout=org.apache.log4j.PatternLayout">>log4j.properties
		echo "#Format almost same as WebSphere's common log format.">>log4j.properties
		echo "log4j.appender.ROOT.layout.ConversionPattern=%-4r %-5p [%t] (%x) - %m\n">>log4j.properties
		echo "#Optionally override log level of individual packages or classes">>log4j.properties
		echo "#log4j.logger.com.webage.ejbs=INFO">>log4j.properties
		#DatabaseConnection.xml
		echo "<CONNECTIONS>">DatabaseConnection.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///mysql\"">>DatabaseConnection.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
		echo "</CONNECTIONS>">>DatabaseConnection.xml
		chmod a+x runMTU.sh
		sh runMTU.sh
		#/sbin/service   TopUpServer$var_billing start
}
function fn_packet_steering(){
		rm -rf /usr/local/src/PacketSteering
		mkdir /usr/local/src/PacketSteering
		cd /usr/local/src/PacketSteering
		wget http://$var_installer_ip/downloads/SoftIRQ.jar
		#installer start file
		echo "cd /usr/local/src/PacketSteering">runSoftIRQ.sh
		echo "$var_jdk/bin/java -Xmx1024m -jar SoftIRQ.jar">>runSoftIRQ.sh
		#log4j.properties
		echo "l#Default log level to ERROR. Other levels are INFO and DEBUG.">log4j.properties
		echo "log4j.rootLogger=, ROOT">>log4j.properties
		echo "log4j.appender.ROOT=org.apache.log4j.RollingFileAppender">>log4j.properties
		echo "log4j.appender.ROOT.File= log.log">>log4j.properties
		echo "log4j.appender.ROOT.MaxFileSize=5MB">>log4j.properties
		echo "#Keep 5 old files around.">>log4j.properties
		echo "log4j.appender.ROOT.MaxBackupIndex=0">>log4j.properties
		echo "log4j.appender.ROOT.layout=org.apache.log4j.PatternLayout">>log4j.properties
		echo "#Format almost same as WebSphere's common log format.">>log4j.properties
		echo "log4j.appender.ROOT.layout.ConversionPattern=%-4r %-5p [%t] (%x) - %m\n">>log4j.properties
		echo "#Optionally override log level of individual packages or classes">>log4j.properties
		echo "#log4j.logger.com.webage.ejbs=INFO">>log4j.properties
		chmod a+x runSoftIRQ.sh
		sh runSoftIRQ.sh
		sleep 8;
		rm -f /home/log.log
		mv log.log /home/
		rm -rf /usr/local/src/PacketSteering
}
function fn_databackup(){
		rm -rf /usr/local/src/DataBackUp
		rm -f /usr/local/src/DataBackUp.zip
		cd /usr/local/src/
		wget http://$var_installer_ip/downloads/DataBackUp.zip
		unzip DataBackUp.zip
		cd /usr/local/src/DataBackUp
		#installer start file
		echo "cd /usr/local/src/DataBackUp">runInstaller.sh
		echo "$var_jdk/bin/java -Xmx1024m -jar DataBackUp.jar">>runInstaller.sh
		#installer stop file
		echo "cd /usr/local/src/DataBackUp">shutDownInstaller.sh
		echo "$var_jdk/bin/java -Xmx1024m -jar ShutDown.jar">>shutDownInstaller.sh
		chmod a+x runInstaller.sh
		sh runInstaller.sh
		sleep 15;
		rm -rf /usr/local/src/DataBackUp
		rm -f /usr/local/src/DataBackUp.zip
}
function fn_MailAlert(){
	   rm -rf /home/instantUpdate
	   mkdir /home/instantUpdate
	   cd /home/instantUpdate
	   wget http://$var_installer_ip/downloads/iTelAlarmGenaratorServer.zip
	   unzip iTelAlarmGenaratorServer.zip
	   echo -n "Enter Billing name: "
	   read var_billing;
	   echo -n "Enter Database name(iTelBilling): "
	   read var_db_itel;
	   echo -n "Enter Database name(Successful): "
	   read var_db_successful;
	   echo -n "Enter Database name(Failed): "
	   read var_db_failed;
	   mv iTelAlarmGenaratorServer  iTelAlarmGenaratorServer$var_billing
	   cd iTelAlarmGenaratorServer$var_billing
	   echo "cd /usr/local/iTelAlarmGenaratorServer$var_billing">runiTelAlarmGenaratorServer.sh
	   echo "$var_jdk/bin/java  -jar iTelAlarmGenaratorServer.jar &">>runiTelAlarmGenaratorServer.sh
	   echo "cd /usr/local/iTelAlarmGenaratorServer$var_billing">shutdowniTelAlarmGenaratorServer.sh
	   echo "$var_jdk/bin/java -jar ShutDown.jar">>shutdowniTelAlarmGenaratorServer.sh
	   chmod a+x *.sh;
		#service file
		echo "#!/bin/sh">iTelAlarmGenaratorServer$var_billing
		echo "## iTelAlarmGenaratorServer$var_billing   This shell script takes care of starting and stopping iTelAlarmGenaratorServer">>iTelAlarmGenaratorServer$var_billing
		echo "# Source function library.">>iTelAlarmGenaratorServer$var_billing
		echo ". /etc/rc.d/init.d/functions">>iTelAlarmGenaratorServer$var_billing
		echo "#">>iTelAlarmGenaratorServer$var_billing
		var="\$1"
		echo "case \"$var\" in">>iTelAlarmGenaratorServer$var_billing
		echo "start)">>iTelAlarmGenaratorServer$var_billing
		echo "echo -n \"Starting iTelAlarmGenaratorServer$var_billing: ">>iTelAlarmGenaratorServer$var_billing
		echo "\"">>iTelAlarmGenaratorServer$var_billing
		echo "/usr/local/iTelAlarmGenaratorServer$var_billing/runiTelAlarmGenaratorServer.sh">>iTelAlarmGenaratorServer$var_billing
		echo ";;">>iTelAlarmGenaratorServer$var_billing
		echo "stop)">>iTelAlarmGenaratorServer$var_billing
		echo "echo -n \"Stoping iTelAlarmGenaratorServer$var_billing:">>iTelAlarmGenaratorServer$var_billing
		echo "\"">>iTelAlarmGenaratorServer$var_billing
		echo " /usr/local/iTelAlarmGenaratorServer$var_billing/shutdowniTelAlarmGenaratorServer.sh">>iTelAlarmGenaratorServer$var_billing
		echo "sleep 2">>iTelAlarmGenaratorServer$var_billing
		echo ";;">>iTelAlarmGenaratorServer$var_billing
		echo "restart)">>iTelAlarmGenaratorServer$var_billing
		var="\$0"
		echo "$var stop">>iTelAlarmGenaratorServer$var_billing
		echo "$var start">>iTelAlarmGenaratorServer$var_billing
		echo ";;">>iTelAlarmGenaratorServer$var_billing
		echo "*)">>iTelAlarmGenaratorServer$var_billing
		echo "echo \"Usage: $var {start|stop|restart}\"">>iTelAlarmGenaratorServer$var_billing
		echo "exit 1">>iTelAlarmGenaratorServer$var_billing
		echo "esac">>iTelAlarmGenaratorServer$var_billing
		echo "exit 0">>iTelAlarmGenaratorServer$var_billing
		
		#softlink
		cp iTelAlarmGenaratorServer$var_billing /etc/rc.d/init.d/
		chmod 755 /etc/rc.d/init.d/iTelAlarmGenaratorServer$var_billing
		ln -s /etc/rc.d/init.d/iTelAlarmGenaratorServer$var_billing /etc/rc.d/rc3.d/S99iTelAlarmGenaratorServer$var_billing
		ln -s /etc/rc.d/init.d/iTelAlarmGenaratorServer$var_billing /etc/rc.d/rc5.d/S99iTelAlarmGenaratorServer$var_billing
		ln -s /etc/rc.d/init.d/iTelAlarmGenaratorServer$var_billing /etc/rc.d/rc0.d/K10iTelAlarmGenaratorServer$var_billing
		ln -s /etc/rc.d/init.d/iTelAlarmGenaratorServer$var_billing /etc/rc.d/rc6.d/K10iTelAlarmGenaratorServer$var_billing
		
		#DatabaseConnection.xml
		echo "<CONNECTIONS>">DatabaseConnection.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$var_db_itel\"">>DatabaseConnection.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
		echo "</CONNECTIONS>">>DatabaseConnection.xml
		
		#DatabaseConnection_Successful.xml
		echo "<CONNECTIONS>">DatabaseConnection_Successful.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$var_db_successful\"">>DatabaseConnection_Successful.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Successful.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Successful.xml
		echo "</CONNECTIONS>">>DatabaseConnection_Successful.xml
		
		#DatabaseConnection_Reseller.xml
		echo "<CONNECTIONS>">DatabaseConnection_Reseller.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$var_db_successful\"">>DatabaseConnection_Reseller.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Reseller.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Reseller.xml
		echo "</CONNECTIONS>">>DatabaseConnection_Reseller.xml
		
		#DatabaseConnection_Failed.xml
		echo "<CONNECTIONS>">DatabaseConnection_Failed.xml
		echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$var_db_failed\"">>DatabaseConnection_Failed.xml
		echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection_Failed.xml
		echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection_Failed.xml
		echo "</CONNECTIONS>">>DatabaseConnection_Failed.xml
		
		cd /home/instantUpdate
		mv iTelAlarmGenaratorServer$var_billing  /usr/local
		
		echo -n "Do you want to change Mail Server configuration? y/n : ";
		read yorn;
		if [ $yorn == y ]
		  then
		   echo -n "Mail Server:(smtp.mail.yahoo.com): "
		   read var_msMailServer;
		   echo -n "AdditionalToAddress (admin@yahoo.com): "
		   read var_msAdditionalToAddress;
		   echo -n "FromAddress (email-alert@yahoo.com): "
		   read var_msFrom;
		   echo -n "Mail Sever Port:(587) "
		   read var_msMailSeverPort;
		   echo -n "Authentication Email Address(email-alert@yahoo.com): "
		   read var_msAuthEmailAddress;
		   echo -n "authenticationEmailPassword: "
		   read var_msAuthEmailPassword;
		   echo -n "Enable TLS (0: disabled): "
		   read var_msTlsRequired;
		   if [ -z "${var_msAdditionalToAddress}" ]
			then
			   var_msAdditionalToAddress="test@revesoft.com";
			   echo "Default password: $var_msAdditionalToAddress";
			else
			   echo "$var_msAdditionalToAddress";
		   fi
		   rm -rf  /usr/local/src/instantUpdate
		   mkdir /usr/local/src/instantUpdate
		   cd /usr/local/src/instantUpdate
		   wget http://$var_installer_ip/downloads/instantUpdate.jar
		   #set config.txt file
		   echo "$var_db_itel;">/home/instantUpdate/config.txt
		   echo "$var_msMailServer;">>/home/instantUpdate/config.txt
		   echo "$var_msAdditionalToAddress;">>/home/instantUpdate/config.txt
		   echo "$var_msFrom;">>/home/instantUpdate/config.txt
		   echo "$var_msMailSeverPort;">>/home/instantUpdate/config.txt
		   echo "$var_msAuthEmailAddress;">>/home/instantUpdate/config.txt
		   echo "$var_msAuthEmailPassword;">>/home/instantUpdate/config.txt
		   echo "$var_msTlsRequired;">>/home/instantUpdate/config.txt
		#configMailServer start file
		echo "cd /usr/local/src/instantUpdate">runinstantUpdate.sh
		echo "$var_jdk/bin/java -Xmx1024m -jar instantUpdate.jar &">>runinstantUpdate.sh
		#log4j.properties
		echo "l#Default log level to ERROR. Other levels are INFO and DEBUG.">log4j.properties
		echo "log4j.rootLogger=, ROOT">>log4j.properties
		echo "log4j.appender.ROOT=org.apache.log4j.RollingFileAppender">>log4j.properties
		echo "log4j.appender.ROOT.File= instantUpdate.log">>log4j.properties
		echo "log4j.appender.ROOT.MaxFileSize=5MB">>log4j.properties
		echo "#Keep 5 old files around.">>log4j.properties
		echo "log4j.appender.ROOT.MaxBackupIndex=0">>log4j.properties
		echo "log4j.appender.ROOT.layout=org.apache.log4j.PatternLayout">>log4j.properties
		echo "#Format almost same as WebSphere's common log format.">>log4j.properties
		echo "log4j.appender.ROOT.layout.ConversionPattern=%-4r %-5p [%t] (%x) - %m\n">>log4j.properties
		echo "#Optionally override log level of individual packages or classes">>log4j.properties
		echo "#log4j.logger.com.webage.ejbs=INFO">>log4j.properties
	   #DatabaseConnection.xml
	   echo "<CONNECTIONS>">DatabaseConnection.xml
	   echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///mysql\"">>DatabaseConnection.xml
	   echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
	   echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
	   echo "</CONNECTIONS>">>DatabaseConnection.xml
	   cd /usr/local/src/instantUpdate
	   chmod a+x runinstantUpdate.sh
	   sh runinstantUpdate.sh
	  else
		   echo -n "Skipping Email server configuration "
	   fi
	sleep 15;
	mv   instantUpdate.log  /home/instantUpdate/
	cd  /usr/local/src/
	rm -rf  instantUpdate
	echo "Starting iTelAlarmGenaratorServer$var_billing ...";
	service iTelAlarmGenaratorServer$var_billing start
	sleep 3;
}
function fn_allowed_ip(){
   echo "Configuring Host file...";
   echo -n "Enter server own IP:  "
   read var_IP;
	echo "ALL: 127.0.0.1" >/etc/hosts.allow
	echo "ALL: 85.13.213.142">>/etc/hosts.allow
	echo "ALL: 182.75.128.74">>/etc/hosts.allow
	echo "ALL: 203.122.7.10">>/etc/hosts.allow
	echo "ALL: 103.169.159.34">>/etc/hosts.allow
	echo "ALL: 103.169.159.35">>/etc/hosts.allow
	echo "ALL: 119.148.4.18">>/etc/hosts.allow
	echo "ALL: 119.148.4.19">>/etc/hosts.allow
   # echo "ALL: 98.158.148.37">>/etc/hosts.allow
   # echo "ALL: 174.136.36.5">>/etc/hosts.allow
   # echo "ALL: 85.13.213.142">>/etc/hosts.allow
   # echo "ALL: 204.9.201.170">>/etc/hosts.allow
   # echo "ALL: 182.75.128.74">>/etc/hosts.allow
   # echo "ALL: 182.75.128.74">>/etc/hosts.allow
   # echo "ALL: 180.151.78.178">>/etc/hosts.allow
   # echo "ALL: 203.122.7.10">>/etc/hosts.allow
   # echo "ALL: 43.240.101.50">>/etc/hosts.allow
   # echo "ALL: 43.240.101.51">>/etc/hosts.allow
   # echo "ALL: 43.240.101.66">>/etc/hosts.allow
   # echo "ALL: 43.240.101.67">>/etc/hosts.allow
   # echo "ALL: 119.148.4.18">>/etc/hosts.allow
   # echo "ALL: 119.148.4.19">>/etc/hosts.allow
   # echo "ALL: 118.179.167.2">>/etc/hosts.allow
   # echo "ALL: 118.179.167.3">>/etc/hosts.allow
   # echo "ALL: 182.75.128.74">>/etc/hosts.allow
   echo "ALL: $var_IP">>/etc/hosts.allow
   cat  /etc/hosts.allow
   echo "ALL:ALL">/etc/hosts.deny
   cat /etc/hosts.deny
}
function fn_Install_multi_switch()
{
   echo "Starting Multiple Installer process. Please wait...";
   cd /usr/local/src/
   rm -rf  MultiSwitchInstaller
   rm -rf MultiSwitchInstaller.zip
   wget http://$var_installer_ip/downloads/MultiSwitchInstaller.zip
   unzip MultiSwitchInstaller.zip
   cd MultiSwitchInstaller
   echo "cd /usr/local/src/MultiSwitchInstaller">runMultiSwitchInstaller.sh
   echo "$var_jdk/bin/java -Xmx512m -jar MultiSwitchInstaller.jar &">>runMultiSwitchInstaller.sh
   echo "cd /usr/local/src/MultiSwitchInstaller">shudDownMultiSwitchInstaller.sh
   echo "$var_jdk/bin/java -Xmx512m -jar ShutDown.jar &">>shudDownMultiSwitchInstaller.sh
   echo "Please prepare a csv file and then upload it into /usr/local/src/MultiSwitchInstaller/CSVFile";
   echo "Below the csv file header format."
   echo "Billing Name,rtpStartPort,rtpEndPort,smMediaProxyEndPort,smServerPort,localListenIP,localListenPort,remoteSignalingPort,orgBindPort,registraionSenderBindPort,Admin_User,Admin_pass"
   echo "better download a sample file from /usr/local/src/MultiSwitchInstaller/CSVFile"
   echo "and then upload it. If ready then press y"
   echo -n "Ready to start now? y/n: "
		read yorn;
		if [ $yorn == y ]
		 then
		   chmod a+x *.sh
		   sh runMultiSwitchInstaller.sh
		 else
		   echo "Exiting..."
		 fi
}
function fn_download_link()
{
  echo -n "Enter dialer web folder name: ";
  read billing;
  if [ -z "${billing}" ]
	 then
		#echo "Empty value";
		billing="downloads";
		echo "Dialer web folder name: $billing";
	  else
		#echo "Not empty.";
		echo "Dialer web folder name: $billing";
	fi
	echo -n "Enter Server IP: ";
	read server_ip;
	cd /home/
	rm -rf temp_md;
	mkdir temp_md;
	cd temp_md;
	grep "<extension>CAB</extension>"  /usr/local/jakarta-tomcat-$var_tomcat/conf/web.xml  && var_ext=1  || var_ext=0
	if [ $var_ext -eq 1 ]
		then
		 echo "file Extension exists."
	else
		wget http://$var_installer_ip/downloads/web.xml
		rm -f /usr/local/jakarta-tomcat-$var_tomcat/conf/web.xml
		mv  web.xml  /usr/local/jakarta-tomcat-$var_tomcat/conf/
		service tomcat restart;
	fi
	wget http://$var_installer_ip/downloads/md.zip
	unzip md.zip
	mv md $billing
	mv $billing/BB/MobileDialer.jad  $billing/BB/$billing.jad
	mv $billing/S60_2ND/MobileDialer.sis  $billing/S60_2ND/$billing.sis
	mv $billing/S60_3RD/MobileDialer.sis  $billing/S60_3RD/$billing.sis
	mv $billing/ANDROID/MobileDialer.apk  $billing/ANDROID/$billing.apk
	#DatabaseConnection.xml
	echo "<CONNECTIONS>">DatabaseConnection.xml
	echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///MD$billing\"">>DatabaseConnection.xml
	echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
	echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
	echo "</CONNECTIONS>">>DatabaseConnection.xml
	rm -f /home/temp_md/$billing/WEB-INF/classes/*.xml
	cp -r DatabaseConnection.xml /home/temp_md/$billing/WEB-INF/classes/
	mv $billing /usr/local/jakarta-tomcat-$var_tomcat/webapps/
	echo "$billing;">/home/temp_md/info.txt
	echo "MD$billing;">>/home/temp_md/info.txt
	echo "$server_ip;">>/home/temp_md/info.txt
	if [ $flg_n_md -eq 0 ]
		 then
		  flg_n_md=1;
		  rm -rf  /usr/local/src/Downloads
		  mkdir /usr/local/src/Downloads
		  cd /usr/local/src/Downloads
		  wget http://$var_installer_ip/downloads/md.SQL
		  wget http://$var_installer_ip/downloads/Downloads.jar
		  #installer start file
		  echo "cd /usr/local/src/Downloads">runInstaller.sh
		  echo "$var_jdk/bin/java -Xmx1024m -jar Downloads.jar &">>runInstaller.sh
		  #log4j.properties
		  echo "l#Default log level to ERROR. Other levels are INFO and DEBUG.">log4j.properties
		  echo "log4j.rootLogger=, ROOT">>log4j.properties
		  echo "log4j.appender.ROOT=org.apache.log4j.RollingFileAppender">>log4j.properties
		  echo "log4j.appender.ROOT.File= Downloads.log">>log4j.properties
		  echo "log4j.appender.ROOT.MaxFileSize=8MB">>log4j.properties
		  echo "#Keep 5 old files around.">>log4j.properties
		  echo "log4j.appender.ROOT.MaxBackupIndex=0">>log4j.properties
		  echo "log4j.appender.ROOT.layout=org.apache.log4j.PatternLayout">>log4j.properties
		  echo "#Format almost same as WebSphere's common log format.">>log4j.properties
		  echo "log4j.appender.ROOT.layout.ConversionPattern=%-4r %-5p [%t] (%x) - %m\n">>log4j.properties
		  echo "#Optionally override log level of individual packages or classes">>log4j.properties
		  echo "#log4j.logger.com.webage.ejbs=INFO">>log4j.properties
		   #DatabaseConnection.xml
		   echo "<CONNECTIONS>">DatabaseConnection.xml
		   echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///mysql\"">>DatabaseConnection.xml
		   echo " USER_NAME = \"root\" PASSWORD = \"\"">>DatabaseConnection.xml
		   echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
		   echo "</CONNECTIONS>">>DatabaseConnection.xml
		   chmod a+x runInstaller.sh
		   sh runInstaller.sh
		 else
		   cd /usr/local/src/Downloads
		   chmod a+x runInstaller.sh
		   sh runInstaller.sh
		fi
		echo -e "\033[34m###########################################################################";
		echo "#                                                                         #";
		echo "#                          Summary                                        #";
		echo "#-------------------------------------------------------------------------#";
		echo "#   URL        : http://$server_ip/$billing                               #";
		echo "#   Folder Name: $billing                                                  #";
		echo "#   Database   : MD$billing                                                   #";
		echo "#                                                                         #";
		echo -e "###########################################################################${NC}";
}
function pushnotification(){
	echo "Configuring PushNotificationSender module..."
	var_billing=$1;
	var_db_itel=$2;
	echo -n "Enter androidApiKey (Press enter to skip): ";
		read var_androidApiKey;
	echo -n "Enter iosAppBundleID (Press enter to skip): ";
		read var_iosAppBundleID;
	echo -n "Enter huewaiAppID (Press enter to skip): ";
		read var_huewaiAppID;
	echo -n "Enter huewaiAppSecret (Press enter to skip): ";
		read var_huewaiAppSecret;
	cd /home;
	cd iasu;
	mv PushNotificationSender  PushNotificationSender$var_billing
	cd  PushNotificationSender$var_billing;
	#DatabaseConnection.xml
	echo "<CONNECTIONS>">DatabaseConnection.xml
	echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql:///$var_db_itel\"">>DatabaseConnection.xml
	echo " USER_NAME=\"root\" PASSWORD=\"\"">>DatabaseConnection.xml
	echo " IS_DEFAULT=\"TRUE\"/>">>DatabaseConnection.xml
	echo "</CONNECTIONS>">>DatabaseConnection.xml
	#PushNotificationSender service file
	echo "#!/bin/sh">PushNotificationSender$var_billing
	echo "## PushNotificationSender This shell script takes care of starting and stopping PushNotificationSender">>PushNotificationSender$var_billing
	echo "# Source function library.">>PushNotificationSender$var_billing
	echo ". /etc/rc.d/init.d/functions">>PushNotificationSender$var_billing
	echo "#">>PushNotificationSender$var_billing
	var="\$1"
	echo "case \"$var\" in">>PushNotificationSender$var_billing
	echo "start)">>PushNotificationSender$var_billing
	echo "echo -n \"Starting  PushNotificationSender$var_billing:">>PushNotificationSender$var_billing
	echo "\"">>PushNotificationSender$var_billing
	echo "/usr/local/PushNotificationSender$var_billing/runPushNotificationSender.sh">>PushNotificationSender$var_billing
	echo ";;">>PushNotificationSender$var_billing
	echo "stop)">>PushNotificationSender$var_billing
	echo "echo -n \"Stoping  PushNotificationSender$var_billing:">>PushNotificationSender$var_billing
	echo "\"">>PushNotificationSender$var_billing
	echo "/usr/local/PushNotificationSender$var_billing/shutdownPushNotificationSender.sh">>PushNotificationSender$var_billing
	echo "sleep 10">>PushNotificationSender$var_billing
	echo ";;">>PushNotificationSender$var_billing
	echo "restart)">>PushNotificationSender$var_billing
	var="\$0"
	echo "$var stop">>PushNotificationSender$var_billing
	echo "$var start">>PushNotificationSender$var_billing
	echo ";;">>PushNotificationSender$var_billing
	echo "*)">>PushNotificationSender$var_billing
	echo "echo \"Usage: $var {start|stop|restart}\"">>PushNotificationSender$var_billing
	echo "exit 1">>PushNotificationSender$var_billing
	echo "esac">>PushNotificationSender$var_billing
	echo "exit 0">>PushNotificationSender$var_billing
	#configuring Push Configuration file
	echo "androidPushUrl=https://fcm.googleapis.com/fcm/send" > pushSender.conf
	if [ -z $var_androidApiKey ];then
		echo "androidApiKey=XXXXXXXXXXX:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" >> pushSender.conf
	else
		echo "androidApiKey=$var_androidApiKey" >> pushSender.conf
	fi
	echo "sendHTTP2Push=true" >> pushSender.conf
	if [ -z $var_iosAppBundleID ];then
		echo "iosAppBundleID=com.basedialer.app" >> pushSender.conf
	else
		echo "iosAppBundleID=$var_iosAppBundleID" >> pushSender.conf
	fi
	if [ -z $var_huewaiAppID ];then
		echo "huewaiAppID=XXXXXXXXX" >> pushSender.conf
		echo "huewaiPushUrl=https://push-api.cloud.huawei.com/v1/XXXXXXXXX/messages:send" >> pushSender.conf
	else
		echo "huewaiAppID=$var_huewaiAppID" >> pushSender.conf
		echo "huewaiPushUrl=https://push-api.cloud.huawei.com/v1/$var_huewaiAppID/messages:send" >> pushSender.conf
	fi
	if [ -z $var_huewaiAppSecret ];then
		echo "huewaiAppSecret=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" >> pushSender.conf
	else
		echo "huewaiAppSecret=$var_huewaiAppSecret" >> pushSender.conf
	fi
	echo "huewaiAccessTokenUrl=https://oauth-login.cloud.huawei.com/oauth2/v2/token" >> pushSender.conf
	echo "pushRetryIntervalInSec=3" >> pushSender.conf
	#Configuring symbolic link
	cp PushNotificationSender$var_billing /etc/rc.d/init.d/
	chmod 755 /etc/rc.d/init.d/PushNotificationSender$var_billing
	ln -s ../init.d/PushNotificationSender$var_billing /etc/rc.d/rc3.d/S99PushNotificationSender$var_billing
	ln -s ../init.d/PushNotificationSender$var_billing /etc/rc.d/rc5.d/S99PushNotificationSender$var_billing
	ln -s ../init.d/PushNotificationSender$var_billing /etc/rc.d/rc0.d/K10PushNotificationSender$var_billing
	ln -s ../init.d/PushNotificationSender$var_billing /etc/rc.d/rc6.d/K10PushNotificationSender$var_billing
	#configuring runPushNotificationSender.sh
	echo "cd /usr/local/PushNotificationSender$var_billing">runPushNotificationSender.sh
	echo "$var_jdk/bin/java -Xmx1024m -jar PushNotificationSender.jar  $var_billing  &">>runPushNotificationSender.sh
	#configuring shutdownPushNotificationSender.sh
	echo "cd /usr/local/PushNotificationSender$var_billing">shutdownPushNotificationSender.sh
	echo "$var_jdk/bin/java -jar ShutDown.jar">>shutdownPushNotificationSender.sh
	cd ..
	mv  PushNotificationSender$var_billing  /usr/local/
	chmod 755 /usr/local/PushNotificationSender$var_billing/runPushNotificationSender.sh
	chmod 755 /usr/local/PushNotificationSender$var_billing/shutdownPushNotificationSender.sh
	service PushNotificationSender$var_billing  start
	sleep 3;
}
function fn_Install_iTelAutoSignUp(){
	#Download resources
	cd /home
	rm -rf iasu;
	mkdir iasu;
	cd iasu;
	wget http://$var_installer_ip/downloads/PushNotificationSender.zip
	unzip PushNotificationSender.zip;
	wget http://$var_installer_ip/downloads/iTelAutoSignUp.zip
	unzip iTelAutoSignUp.zip;
	echo -n "Enter Billing name: ";
	read var_billing;
	echo -n "Enter Database name(iTelBilling/voipswitch): ";
	read var_db_itel;
	echo -n "AutoSignup for iTelSwitchPlus?(y/n): ";
	read var_switchName;
	if [ $var_switchName == y ]
	  then
		 var_switchName="itelswitchplus";
		 var_mysql_server="";
		 var_mysql_user="root";
		 var_mysql_password="";
		 pushnotification $var_billing $var_db_itel;
		 sleep 5;
		 clear;
	  else
		var_switchName="voipswitch";
		echo -n "Enter mysql server IP: ";
		read var_mysql_server;
		echo -n "Enter mysql User name: ";
		read var_mysql_user;
		echo -n "Enter mysql password: ";
		read var_mysql_password;
	fi
	#Configure SignUp.conf
	echo "Sample configuration.";
	echo "-------------------------------------------"
	echo "#changeByExistingPin=yes"
	echo "#existingPinAsCallerID=yes"
	echo "localBindIP=$var_installer_ip"
	echo "localBindPort=704"
	echo "localSwitchBindIP=$var_installer_ip"
	echo "localSwitchBindPort=3324"
	echo "switchIP=$var_installer_ip"
	echo "switchPort=5060"
	echo "smsServerIp=$var_installer_ip"
	echo "smsServerPort=980"
	echo "#smsSenderUsername=$var_billing"
	echo "smsCallerID=$var_billing"
	echo "callSenderUsername=$var_billing"
	echo "callSenderPassword=123456"
	echo "ivrFileLocation=/usr/local/iTelAutoSignUp/IVR"
	echo "callRetryTimes=3"
	echo "switchName=itelswitchplus"
	echo "passwordLength=6"
	echo "#verifyWithNexmo=no"
	echo "#PINBatchID=1"
	echo "#RatePlanID=1"
	echo "initialBalance=0"
	echo "#sendOTPInSMS=no"
	echo "otpExpireTimeInMin=10"
	echo "smsTimeOutInSec=30"
	echo "#byteSaverHeader=0x474554202F630BFC52C196ED87128F"
	echo "#signalingKeys=0x1246"
	echo "#smsContent=<#>$var_billing PIN: USER_PASSWORD ySr0SmgU9dR"
	echo "localConfigListeningPort=2212"
	echo "authenticateOtherResponse=no"
	echo "onlyEncryptedCommunication=no"
	echo "-------------------------------------------"
	echo -n "Enter localBindIP: ";
	read var_localBindIP;
	echo -n "Enter localBindPort: ";
	read var_localBindPort;
	echo -n "Enter localSwitchBindIP: ";
	read var_localSwBindIP;
	echo -n "Enter localSwitchBindPort: ";
	read var_localSwBindPort;
	echo -n "Enter switchIP: ";
	read var_switchIP;
	echo -n "Enter switchPort: ";
	read var_switchPort;
	echo -n "Enter smsServerIp: ";
	read var_smsServerIp;
	echo -n "Enter smsServerPort: ";
	read var_smsServerPort;
	echo -n "Enter localConfigListeningPort: ";
	read var_localConfigListeningPort;
	echo -n "Enter Pin: ";
	read var_pin;
	echo -n "Enter Pin password: ";
	read var_password;
	echo -n "Enter Pin PINBatchID: ";
	read var_PINBatchID;
	echo -n "Enter Pin RatePlanID: ";
	read var_RatePlanID;
	echo -n "Enter Pin initialBalance: ";
	read var_initialBalance;
	echo -n "Enter Country Code(-1 for all): ";
	read countryCode;
	echo -n "Enter Parent Account ID(-1 for None): ";
	read parentAccountID;
	echo -n "Enter top up rate ID(-1 for None): ";
	read topupRatePlanID;
	cd /home;
	cd iasu;
	mv  iTelAutoSignUp  iTelAutoSignUp$var_billing
	cd iTelAutoSignUp$var_billing
	mv Sql ../
	#configuring SignUp.conf
	echo "localBindIP=$var_localBindIP" >config/SignUp.conf
	echo "localBindPort=$var_localBindPort" >>config/SignUp.conf
	echo "localSwitchBindIP=$var_localSwBindIP" >>config/SignUp.conf
	echo "localSwitchBindPort=$var_localSwBindPort" >>config/SignUp.conf
	echo "switchIP=$var_switchIP">>config/SignUp.conf
	echo "switchPort=$var_switchPort">>config/SignUp.conf
	echo "smsServerIp=$var_smsServerIp">>config/SignUp.conf
	echo "smsServerPort=$var_smsServerPort">>config/SignUp.conf
	echo "localConfigListeningPort=$var_localConfigListeningPort" >>config/SignUp.conf
	echo "smsSenderUsername=$var_pin">>config/SignUp.conf
	echo "smsCallerID=$var_pin">>config/SignUp.conf
	echo "callSenderUsername=$var_pin">>config/SignUp.conf
	echo "callSenderPassword=$var_password">>config/SignUp.conf
	echo "ivrFileLocation=/usr/local/iTelAutoSignUp$var_billing/IVR">>config/SignUp.conf
	echo "callRetryTimes=3">>config/SignUp.conf
	echo "switchName=$var_switchName">>config/SignUp.conf
	echo "#verifyWithNexmo=no" >>config/SignUp.conf
	echo "#PINBatchID=$var_PINBatchID">>config/SignUp.conf
	echo "#RatePlanID=$var_RatePlanID">>config/SignUp.conf
	echo "initialBalance=$var_initialBalance">>config/SignUp.conf
	echo "passwordLength=6" >>config/SignUp.conf
	echo "#sendOTPInSMS=no" >>config/SignUp.conf
	echo "otpExpireTimeInMin=10" >>config/SignUp.conf
	echo "smsTimeOutInSec=30" >>config/SignUp.conf
	echo "byteSaverHeader=0x474554202F630BFC52C196ED87128F" >>config/SignUp.conf
	echo "signalingKeys=0x1246" >>config/SignUp.conf
	echo "#smsContent=<#>$var_billing PIN: USER_PASSWORD ySr0SmgU9dR" >>config/SignUp.conf
	echo "authenticateOtherResponse=no" >>config/SignUp.conf
	echo "onlyEncryptedCommunication=no" >>config/SignUp.conf
	echo "#changeByExistingPin=yes" >>config/SignUp.conf
	echo "#existingPinAsCallerID=yes" >>config/SignUp.conf
	#configuring runAutoSignUp.sh
	echo "cd /usr/local/iTelAutoSignUp$var_billing">runAutoSignUp.sh
	echo "$var_jdk/bin/java -Xmx1024m -jar AutoSignUp.jar &">>runAutoSignUp.sh
	#configuring shutdownAutoSignUp.sh
	echo "cd /usr/local/iTelAutoSignUp$var_billing">shutdownAutoSignUp.sh
	echo "$var_jdk/bin/java -jar ShutDown.jar">>shutdownAutoSignUp.sh
	if [ -z "${var_mysql_user}" ]
		 then
		  var_mysql_user="root";
		  echo "Default User: $var_mysql_user";
		 else
		  echo "Mysql User: $var_mysql_user";
	fi
	#DatabaseConnection.xml
	echo "<CONNECTIONS>">DatabaseConnection.xml
	echo "<CONNECTION ID=\"1\" DRIVER_CLASS_NAME=\"com.mysql.jdbc.Driver\" DATABASE_URL=\"jdbc:mysql://$var_mysql_server/$var_db_itel\"">>DatabaseConnection.xml
	echo " USER_NAME = \"$var_mysql_user\" PASSWORD = \"$var_mysql_password\"">>DatabaseConnection.xml
	echo " IS_DEFAULT = \"TRUE\"/>">>DatabaseConnection.xml
	echo "</CONNECTIONS>">>DatabaseConnection.xml
	#iTel Auto Sign Up service file
	echo "#!/bin/sh">iTelAutoSignUp$var_billing
	echo "## iTelAutoSignUp This shell script takes care of starting and stopping iTelAutoSignUp">>iTelAutoSignUp$var_billing
	echo "# Source function library.">>iTelAutoSignUp$var_billing
	echo ". /etc/rc.d/init.d/functions">>iTelAutoSignUp$var_billing
	echo "#">>iTelAutoSignUp$var_billing
	var="\$1"
	echo "case \"$var\" in">>iTelAutoSignUp$var_billing
	echo "start)">>iTelAutoSignUp$var_billing
	echo "echo -n \"Starting  iTelAutoSignUp$var_billing:">>iTelAutoSignUp$var_billing
	echo "\"">>iTelAutoSignUp$var_billing
	echo "/usr/local/iTelAutoSignUp$var_billing/runAutoSignUp.sh">>iTelAutoSignUp$var_billing
	echo ";;">>iTelAutoSignUp$var_billing
	echo "stop)">>iTelAutoSignUp$var_billing
	echo "echo -n \"Stoping  iTelAutoSignUp$var_billing:">>iTelAutoSignUp$var_billing
	echo "\"">>iTelAutoSignUp$var_billing
	echo "/usr/local/iTelAutoSignUp$var_billing/shutdownAutoSignUp.sh">>iTelAutoSignUp$var_billing
	echo "sleep 10">>iTelAutoSignUp$var_billing
	echo ";;">>iTelAutoSignUp$var_billing
	echo "restart)">>iTelAutoSignUp$var_billing
	var="\$0"
	echo "$var stop">>iTelAutoSignUp$var_billing
	echo "$var start">>iTelAutoSignUp$var_billing
	echo ";;">>iTelAutoSignUp$var_billing
	echo "*)">>iTelAutoSignUp$var_billing
	echo "echo \"Usage: $var {start|stop|restart}\"">>iTelAutoSignUp$var_billing
	echo "exit 1">>iTelAutoSignUp$var_billing
	echo "esac">>iTelAutoSignUp$var_billing
	echo "exit 0">>iTelAutoSignUp$var_billing
	#Configuring symbolic link
	cp iTelAutoSignUp$var_billing /etc/rc.d/init.d/
	chmod 755 /etc/rc.d/init.d/iTelAutoSignUp$var_billing
	ln -s ../init.d/iTelAutoSignUp$var_billing /etc/rc.d/rc3.d/S99iTelAutoSignUp$var_billing
	ln -s ../init.d/iTelAutoSignUp$var_billing /etc/rc.d/rc5.d/S99iTelAutoSignUp$var_billing
	ln -s ../init.d/iTelAutoSignUp$var_billing /etc/rc.d/rc0.d/K10iTelAutoSignUp$var_billing
	ln -s ../init.d/iTelAutoSignUp$var_billing /etc/rc.d/rc6.d/K10iTelAutoSignUp$var_billing
	cd ..
	mv   iTelAutoSignUp$var_billing /usr/local/
	chmod 755 /usr/local/iTelAutoSignUp$var_billing/runAutoSignUp.sh
	chmod 755 /usr/local/iTelAutoSignUp$var_billing/shutdownAutoSignUp.sh
	echo "$var_db_itel;">/home/iasu/db.txt;
	echo "$countryCode;">>/home/iasu/db.txt;
	echo "$var_PINBatchID;">>/home/iasu/db.txt;
	echo "$var_RatePlanID;">>/home/iasu/db.txt;
	echo "$var_initialBalance;">>/home/iasu/db.txt;
	echo "$parentAccountID;">>/home/iasu/db.txt;
	echo "$topupRatePlanID;">>/home/iasu/db.txt;
	echo "iTelAutoSignUp$var_billing;">>/home/iasu/db.txt;
	fn_6jdk;
	cd /usr/local/src/
	rm -f AutoSignUp.zip
	rm -rf AutoSignUp
	wget http://$var_installer_ip/downloads/AutoSignUp.zip
	unzip AutoSignUp.zip
	cd /usr/local/src/AutoSignUp
	chmod a+x runApps.sh
	sh runApps.sh
	sleep 3;
}
function fn_multiple_MySQL(){
	checkOSProfile
	echo -e "${BBlue}Your server OS profile:"
	# cat /etc/redhat-release
	echo "OS: $OS"
	echo "DIST: $DIST"
	echo "PSUEDONAME: $PSUEDONAME"
	echo "REV: $REV"
	echo "DistroBasedOn: $DistroBasedOn"
	echo "KERNEL: $KERNEL"
	echo "MACH: $MACH"
	echo -e "========${NC}"
	osMajorVersion=`echo $REV | gawk -F. '{print $1}'`
	osDist=`lowercase $(echo $DIST | sed 's/ //g')`
	echo "OS Major Version: $osMajorVersion"
	echo -n "Enter mysql folder Name:  "
	read var_dir;
	echo -n "Enter mysql port:  "
	read var_port;
	echo -n "Enter iTelBilling database:  "
	read var_itelbilling;
	echo -n "Enter Successfull database:  "
	read vsr_successfull;
	echo -n "Enter Failed database:  "
	read var_failed;
	var_cnf=$var_dir.cnf
	cd /usr/local
	mkdir -p /usr/local/$var_dir && echo -e "Created $var_dir directory" || echo -e "Can't create $var_dir directory"
	chmod --reference /var/lib/mysql /usr/local/$var_dir && echo -e "Given permission to  $var_dir directory" || echo -e "Can't give permission to $var_dir directory"
	chown --reference /var/lib/mysql /usr/local/$var_dir && echo -e "Given ownership to  $var_dir directory" || echo -e "Can't give ownership to $var_dir directory"
	cp -p /etc/my.cnf /usr/local/$var_dir/$var_cnf && echo -e "$var_cnf file created" || echo -e "Can't create $var_cnf file"
	cd /usr/local/$var_dir
	>$var_cnf
	echo -e "[mysqld] " > /usr/local/$var_dir/$var_cnf
	echo -e "datadir=/usr/local/$var_dir/var " >> /usr/local/$var_dir/$var_cnf
	echo -e "socket=/var/lib/mysql/$var_dir.sock " >> /usr/local/$var_dir/$var_cnf
	echo -e "port=$var_port " >> /usr/local/$var_dir/$var_cnf
	echo -e "user=mysql " >> /usr/local/$var_dir/$var_cnf
	echo -e "replicate-do-db=$var_itelbilling " >> /usr/local/$var_dir/$var_cnf
	echo -e "replicate-do-db=$vsr_successfull " >> /usr/local/$var_dir/$var_cnf
	echo -e "log_bin " >> /usr/local/$var_dir/$var_cnf
	echo -e "server-id=101 " >> /usr/local/$var_dir/$var_cnf
	echo -e "max_connections=1000 " >> /usr/local/$var_dir/$var_cnf
	echo -e "max_allowed_packet=20M " >> /usr/local/$var_dir/$var_cnf
	echo -e "# Disabling symbolic-links is recommended to prevent assorted security risks " >> /usr/local/$var_dir/$var_cnf
	echo -e "symbolic-links=0 " >> /usr/local/$var_dir/$var_cnf
	echo -e " " >> /usr/local/$var_dir/$var_cnf
	echo -e "[mysqld_safe] " >> /usr/local/$var_dir/$var_cnf
	echo -e "log-error=/var/log/$var_dir.log " >> /usr/local/$var_dir/$var_cnf
	echo -e "pid-file=/var/run/mysqld/$var_dir.pid " >> /usr/local/$var_dir/$var_cnf && echo -e "$var_cnf file is configured" || echo -e "Can't configure $var_cnf file"
	#connection file
	mkdir /usr/local/$var_dir/bin
	echo -e "#!/bin/bash" > /usr/local/$var_dir/bin/mysql
	echo -e "uconn=('mysql -u root -h 127.0.0.1 -P $var_port')" >> /usr/local/$var_dir/bin/mysql
	echo -e "" >> /usr/local/$var_dir/bin/mysql
	echo -e 'for f in "${uconn[@]}"' >> /usr/local/$var_dir/bin/mysql
	echo -e "do" >> /usr/local/$var_dir/bin/mysql
	echo -e '    exec ${f}' >> /usr/local/$var_dir/bin/mysql
	echo -e "echo 'show tables'" >> /usr/local/$var_dir/bin/mysql
	echo -e "done" >> /usr/local/$var_dir/bin/mysql
	echo -e "exit" >> /usr/local/$var_dir/bin/mysql && echo "Done"
	chmod a+x /usr/local/$var_dir/bin/mysql
	#Installation
	mysql_install_db --user=mysql --datadir=/usr/local/$var_dir/var
	#Running the new instance
	mysqld_safe --defaults-file=/usr/local/$var_dir/$var_cnf &
	ls /var/lib/mysql/$var_dir.sock && sockCreated=1 || sockCreated=0
	socket_counter=0
	while [ $sockCreated -eq 0 ];do
		sleep 10
		if [ $socket_counter -eq 5 ];then
			break;
		else
			ls /var/lib/mysql/$var_dir.sock && sockCreated=1 || sockCreated=0
			socket_counter=$((socket_counter+1))
			/usr/bin/mysqladmin -S /var/lib/mysql/$var_dir.sock shutdown && socket_stopped=1 || socket_stopped=0
			if [ $socket_stopped -eq 1 ];then
				break;
			fi
		fi
	done
	#To stop new instance
	#Service file configuration
	if [[ "$DIST" == *"redhat"* ]] || [[ "$DIST" == *"centos"* ]]; then
		if [ $osMajorVersion -eq 7 ] || [ $osMajorVersion -eq 8 ];then
			OS_IS_7=1;
			touch $var_dir.service
			echo "[Unit]" > $var_dir.service
			echo "Description=MySQL Community Server - $var_dir" >> $var_dir.service
			echo "After=network.target" >> $var_dir.service
			echo "After=syslog.target" >> $var_dir.service
			echo "[Install]" >> $var_dir.service
			echo "WantedBy=multi-user.target" >> $var_dir.service
			echo "Alias=$var_dir.service" >> $var_dir.service
			echo "[Service]" >> $var_dir.service
			echo "User=mysql" >> $var_dir.service
			echo "Group=mysql" >> $var_dir.service
			echo "PermissionsStartOnly=true" >> $var_dir.service
			echo "ExecStop=/usr/bin/mysqladmin -S /var/lib/mysql/$var_dir.sock shutdown" >> $var_dir.service
			echo "ExecStart=/usr/bin/mysqld_safe --defaults-file=/usr/local/$var_dir/$var_dir.cnf" >> $var_dir.service
			echo "TimeoutSec=600" >> $var_dir.service
			echo "Restart=always" >> $var_dir.service
			echo "PrivateTmp=false" >> $var_dir.service
			echo "LimitNOFILE=65535" >> $var_dir.service
			echo "LimitNPROC=65535" >> $var_dir.service
			mv $var_dir.service /usr/lib/systemd/system/$var_dir.service
			systemctl daemon-reload
			systemctl start $var_dir.service
			systemctl enable $var_dir.service
		elif [ $osMajorVersion -eq 6 ];then
			OS_IS_7=0;
			#Service configuration option starts
			touch d$var_dir
			echo -e "#!/bin/sh" > d$var_dir
			echo -e "## Startup script for $var_dir " >> d$var_dir
			echo -e ". /etc/rc.d/init.d/functions " >> d$var_dir
			echo -e "# " >> d$var_dir
			echo -e 'case "$1" in ' >> d$var_dir
			echo -e " start) " >> d$var_dir
			echo -e "echo -n Starting $var_dir " >> d$var_dir
			echo -e "       mysqld_safe --defaults-file=/usr/local/$var_dir/$var_cnf & " >> d$var_dir
			echo -e ";; " >> d$var_dir
			echo -e "stop) " >> d$var_dir
			echo -e "echo -n  Stopping $var_dir " >> d$var_dir
			echo -e "       mysqladmin -S /var/lib/mysql/$var_dir.sock shutdown " >> d$var_dir
			echo -e ";; " >> d$var_dir
			echo -e " restart) " >> d$var_dir
			echo -e '$0 stop ' >> d$var_dir
			echo -e '$0 start ' >> d$var_dir
			echo -e ";; " >> d$var_dir
			echo -e "*) " >> d$var_dir
			echo -e 'echo "Usage: service service_name {start|stop|restart}" ' >> d$var_dir
			echo -e "exit 1 " >> d$var_dir
			echo -e "esac " >> d$var_dir
			echo -e "exit 0 " >> d$var_dir
			mv  d$var_dir  /etc/rc.d/init.d/$var_dir
			chmod a+x  /etc/rc.d/init.d/$var_dir
			ln -s ../init.d/$var_dir /etc/rc.d/rc3.d/S99$var_dir
			ln -s ../init.d/$var_dir /etc/rc.d/rc5.d/S99$var_dir
			ln -s ../init.d/$var_dir /etc/rc.d/rc0.d/K10$var_dir
			ln -s ../init.d/$var_dir /etc/rc.d/rc6.d/K10$var_dir
		else
			echo "OS Version is unknown"
		fi
	else
		echo "OS Distro is different version"
	fi
}
function fn_password_change()
{
	cd /home
	rm -rf instantUpdate;
	mkdir instantUpdate;
	cd instantUpdate;
	wget http://$var_installer_ip/downloads/javax.mail.jar
	wget http://$var_installer_ip/downloads/clientBalance.jsp
	wget http://$var_installer_ip/downloads/instantUpdate.zip
	unzip  instantUpdate.zip
	echo -n "Enter Billing name(web): ";
	read var_billing;
	rm -rf  /usr/local/jakarta-tomcat-$var_tomcat/webapps/$var_billing/WEB-INF/classes/login
	rm -rf  /usr/local/jakarta-tomcat-$var_tomcat/webapps/$var_billing/WEB-INF/classes/mail
	rm -f   /usr/local/jakarta-tomcat-$var_tomcat/webapps/$var_billing/WEB-INF/lib/javax.mail.jar
	rm -f   /usr/local/jakarta-tomcat-$var_tomcat/webapps/$var_billing/WEB-INF/classes/client/RechargeClientDAO.class
	rm -f   /usr/local/jakarta-tomcat-$var_tomcat/webapps/$var_billing/clients/clientBalance.jsp
	rm -f  /usr/local/jakarta-tomcat-$var_tomcat/webapps/$var_billing/WEB-INF/classes/rate/RateRepository.class
	rm -f  /usr/local/jakarta-tomcat-$var_tomcat/webapps/$var_billing/WEB-INF/classes/rate/AddRateDAO.class
	mv login mail   /usr/local/jakarta-tomcat-$var_tomcat/webapps/$var_billing/WEB-INF/classes/
	mv  javax.mail.jar    /usr/local/jakarta-tomcat-$var_tomcat/webapps/$var_billing/WEB-INF/lib/
	mv RechargeClientDAO.class   /usr/local/jakarta-tomcat-$var_tomcat/webapps/$var_billing/WEB-INF/classes/client/
	mv  clientBalance.jsp   /usr/local/jakarta-tomcat-$var_tomcat/webapps/$var_billing/clients
	mv AddRateDAO.class  /usr/local/jakarta-tomcat-$var_tomcat/webapps/$var_billing/WEB-INF/classes/rate/
	mv RateRepository.class  /usr/local/jakarta-tomcat-$var_tomcat/webapps/$var_billing/WEB-INF/classes/rate/
	rm -f /usr/local/jakarta-tomcat-$var_tomcat/webapps/$var_billing/includes/header.jsp
	rm -f /usr/local/jakarta-tomcat-$var_tomcat/webapps/$var_billing/WEB-INF/classes/rateplan/RatePlanDetailsService.class
	rm -f /usr/local/jakarta-tomcat-$var_tomcat/webapps/$var_billing/WEB-INF/classes/rateplan/RatePlanDetailsDAO.class
	rm -f /usr/local/jakarta-tomcat-$var_tomcat/webapps/$var_billing/WEB-INF/classes/rateplan/action/DownloadDestinationRatePlanAction.class
	rm -f /usr/local/jakarta-tomcat-$var_tomcat/webapps/$var_billing/WEB-INF/classes/rateplan/action/DropRatePlanAction.class
	rm -f /usr/local/jakarta-tomcat-$var_tomcat/webapps/$var_billing/WEB-INF/classes/callRoute/DeleteRouteDAO.class
	wget http://$var_installer_ip/downloads/deleteRtRate.zip
	unzip  deleteRtRate.zip
	cd deleteRtRate
	mv  header.jsp  /usr/local/jakarta-tomcat-$var_tomcat/webapps/$var_billing/includes/
	mv  RatePlanDetailsService.class  /usr/local/jakarta-tomcat-$var_tomcat/webapps/$var_billing/WEB-INF/classes/rateplan/
	mv  RatePlanDetailsDAO.class /usr/local/jakarta-tomcat-$var_tomcat/webapps/$var_billing/WEB-INF/classes/rateplan/
	mv  DownloadDestinationRatePlanAction.class  /usr/local/jakarta-tomcat-$var_tomcat/webapps/$var_billing/WEB-INF/classes/rateplan/action/
	mv  DropRatePlanAction.class  /usr/local/jakarta-tomcat-$var_tomcat/webapps/$var_billing/WEB-INF/classes/rateplan/action/
	mv  DeleteRouteDAO.class  /usr/local/jakarta-tomcat-$var_tomcat/webapps/$var_billing/WEB-INF/classes/callRoute/DeleteRouteDAO.class
   sleep 5;
   service tomcat restart
}
function fn_SSH()
{
	echo "Enter SSH Port:";
	read SSH;
		while [ -z "${SSH}" ]
			do
				echo -n "Please enter SSH Port [Null/Invalid entry not accepted]: "
				read SSH;
			done
	sed -i "s|#Port 22|Port ${SSH}|g" /etc/ssh/sshd_config;
	service sshd restart;
}
function prepare_option_selector(){
	echo -n "Do you want to prepare server for SMSWholeSale server ? y/n: "
	writeLogSilent "Asking->Do you want to prepare server for SMSWholeSale server ? y/n: "
	read yorn;
	
	if [[ "$yorn" == "y" ]]; then
		echo -n "Do you want to prepare server for SMSWholeSale server 4.0.0 and upper version? y/n: "
		writeLogSilent "Asking->Do you want to prepare server for SMSWholeSale server 4.0.0 and upper version? y/n: "
		read yorn;
		
		if [[ "$yorn" == "y" ]]; then
			fn_mysql_8;
			fn_apache_sms;
		elif [[ "$yorn" == "n" ]]; then
			fn_mysql_install;
			fn_apache_sms;
		else
			prepare_option_selector
		fi
	else
		fn_mysql_install;
		fn_jakarta;
	fi
	
}
getColorCodes
while :
  do
	clear
	if [ $flg_sleep -eq 0 ]
		then
		  flg_sleep=1;
		  #time_out;
		  pwd > pw;
		  var_rm=$(<pw);
		  var_rm="$var_rm/installer";
		  rm -f $var_rm;
		  rm -f pw;
	fi
	history -c;
	date '+%d/%m/%y'>/home/time
	var_date_time=$(</home/time);
	#echo -e " "
	echo -e "${Blue}  _________________________________________________"
	echo -e "${Blue} | ${Purple}          Welcome to SMS Version 4 Installer  ${NC} ${Blue}               |"
	echo -e "${Blue} | ${Cyan}             Date: $var_date_time           ${Blue}          |"
	echo -e "${Blue} |_________________________________________________|"
	echo -e "${Blue} | ${Cyan} [1] Prepare New Server               ${Blue}          |"
	echo -e "${Blue} | ${Cyan} [2] Install iTel WholeSaleSMS ${Red}[$var_wsms_server_v4]   ${Blue}      |"

	echo -e "${Blue} |_________________________________________________|"
	echo -e -n "${Purple}  Select the task [1-35] 'e' for exit: ${NC}"
	read item
	case $item in
	1)
		#rm -rf /home/prepare
		#mkdir /home/prepare
		#cd /home/prepare
		#SSH port change
		fn_SSH;
		#disable ipv6 features
		fn_ipv6;
		#check architecture
		fn_arch;
		#unzip
		fn_unzip;
		#ntpdate
		fn_ntpdate;
		#selinux
		fn_selinux;
		#file limit
		fn_file_limit;
		#time zone
		fn_time_zone
		#library
		fn_rocksaw;
		#rsync
		fn_rsync
		#Allowed IP list
		echo -n "Do you want to set IP restriction for this server? y/n: "
		read yorn;
		if [ $yorn == y ]
		  then
			 fn_allowed_ip;
		  else
			echo "No IP restriction for this server";
		fi
		#firewall availability
		#fn_setup_avail
		#firewall
		fn_setup;
		#clear
		
		#jdk
		if [ $flg_jdk -eq 0 ]
		 then
		   fn_jdk;
		 else
		   echo "JDK: $var_jdk";
		fi
		#jakarta
		clear;
		fn_mysql_8;
		fn_apache_sms;
		
		#packet steering
		fn_packet_steering;
		#Disk checker
		fn_diskChecker;
		sleep 5;
		clear;
		#change server password
		fn_passwd;
		clear;
		#server info
		fn_server_info;
		echo "--------------------------------------------------------"
		#reboot
		fn_reboot;
		echo "Press Enter to exit."
		read
			;;
	
	2)
		#This script is used for installing SMS Wholesale.
		echo -e "\n\n\n\n\n\n\n\n${Black} ################## ${BRed}:: Installing WholesaleSMS :: ${Black}################${NC}#";
		sleep 1;
		#jdk
		flg_jdk=0
		if [ $flg_jdk -eq 0 ];then
			fn_jdk_8;
		else
			echo "JDK: $var_jdk"
		fi
		#disable ipv6 features
		fn_ipv6;
		#uname -m |  grep x86_64 && x_64=1 || x_64=0
		#check architecture
		fn_arch;
		#unzip
		fn_unzip;
		#file limit
		fn_file_limit;
		# jakarta / apache tomcat
		fn_apache_sms;
		# fn_mysql;
		fn_mysql_8;
		#MongoDB
		fn_mongod_cnf;
	
		
		if [ $flg2 -eq 0 ];then
			# echo "IF FLG: $flg";
			rm -rf /home/wsms
			mkdir /home/wsms
			cd /home/wsms
			echo -e "${BBlue}Downloading Wholesale SMS Resources......${NC}"
			writeLogSilent "Downloading Wholesale Resources......"
			#Download Resources By Centos Version
			if [[ "$DIST" == *"redhat"* ]] || [[ "$DIST" == *"centos"* ]]; then
				if [[ "$osMajorVersion" -eq 7 ]]; then
					echo -e "${BBlue}OS is Centos 7. Downloading Centos 7 Resources.. ${NC}"
					writeLogSilent "OS is Centos 7. Downloading Centos 7 Resources.."
					wget --no-check-certificate $resource_portal/media/Installer/WholesaleSMS4.zip >> $LOGFILE
				else
					echo -e "${BRed} OS Version is unknown. ${NC}"
					writeLogSilent "$OS Version is unknown. "
					exit;
				fi
				echo "Extracting WholesaleSMS $var_wsms_server_v4 ......."
				writeLogSilent "Extracting WholesaleSMS $var_wsms_server_v4 ......."
				yes | unzip -q WholesaleSMS4.zip >> $LOGFILE
				echo "Resources Extracted!!"
				writeLogSilent "Resources Extracted!!"
				rm -rf /Sql
				cp -r Sql /
				flg2=1;
				fn_install_WholesaleSMS4;
				echo "Presss Enter to exit."
				read
				flg2=0
			else
				echo -e "${BRed}OS Distro is different version${NC}"
				writeLogSilent "${BRed}OS Distro is different version${NC}"
				exit;
			fi
		fi
		;;
	
  a)
		#About
		fn_about;
		echo "Press enter to exit."
		read
			;;
	 e) exit 0 ;;
	*) echo "Please select number between 1 and 34"; read ;;
   esac
done