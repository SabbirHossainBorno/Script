#!/bin/bash
script="preShifT"
author_name="# Mirza Golam Abbas Shahneel"
version="# 1.0.8.8"
modified="# Modified_19022019_1546";
lastModifications="
#Multithreaded RSync for Service Shfiting - Done
#Tomcat shifting with failure check - Done
#Task - Need to add RSync DB with failure check - Done
#Task - Added Successful current table skip - Done;
#Task - Added DBHealthChecker crontab value - Done
#Task - SMS and Balance db shifting add - Done
#Task - Array add to service selection - Done;
#Task - Array add to database selection - Done
#Task - Need to check new server for any running service before setting time. - Done
#Task - Mail Delivery configured - Test required
#Task - IP Configuration enhanced
#Task Need to check running signaling cdr files shifting or not - 
#Task - Need to check cdr is left or not
#Task: configured switch emailInfo.cfg
#Task: configured user input before tomcat shifting
#v_1088: Installer IP Changed"
#Task: copy JDK to new server - 
#Need to test this script finaly
###################################################
# Current version modifications
#--------------------------------------------------
# Added swp directory for switch delivery mail
# Added a cdr directory skip option 
# Added signaling size indicator
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
var_installer_ip='149.20.186.19';
var_jdk="/usr/java/jdk1.6.0_13";
var_tomcat="7.0.61";
flg_jdk=0;
localPath='/usr/local'
mkdir -p $localPath/src/ServiceShifting
resourcePath="$localPath/src/ServiceShifting"
rm -f $resourcePath/*
####Need to remove below information
#oSrvrPrt=64555
#oSrvrUsr=root
#oSrvrIP=191.96.12.50
#nSrvrPrt=22
#nSrvrUsr=root
#nSrvrIP=98.158.148.10
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
chkNwSrv="$resourcePath/chkNwSrv"
mkdir -p /home/swp
dlvryMail="/home/swp/deliveryEmail.cfg"
declare -i tmStClr="";
declare -i dbChkClear="";
declare -i srvChkClear="";
declare -a partitionServices=(iTelSwitchPlusMediaProxy iTelSwitchPlusSignaling);
newMysqlPass="mysql -u root";
mysqlPass="mysql -u root";
logWrtng="/home/preShifting.log"
#oldMySQLDir='/var/lib/mysql/'
newMySQLDir='/var/lib/mysql/'
SSHSOCKET=~/.ssh/teeCon
rSncPort="ssh -o ControlPath=$SSHSOCKET -p 22"
>$listofshift;>$dbs;>$configNewIP;>$tomcatBckUp;>$varList;>$chkNwSrv;>$dlvryMail;>$logWrtng;
##############Initial Checkup###############
trap ctrl_c INT
function ctrl_c() {
        echo "** Exiting the script as you pressed CTRL-C"; echo "** Exiting the script as you pressed CTRL-C" >>$logWrtng 2>&1
		history -c
		scrptLoc=$(cat $localPath/src/scrptLoc);
		cd $scrptLoc;
		rm -f $script
		
		ssh -S $SSHSOCKET -O exit -p $nSrvrPrt $nSrvrUsr@$nSrvrIP >>$logWrtng 2>&1
		
		ls ~/.ssh/ >>$logWrtng 2>&1
		
		exit 1;
}
#trap exit INT
declare -a instlld=();
declare -a toBinstlld=();
function fn_ipv6()
{
  clear;
  echo -e "${Green}Checking IPv6 status: ${NC}";
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
	else
	   echo -e "${Green}IPv6 disabled${NC}";
  fi
  
  
}
function fn_scp()
{
declare -i scpFlag=0
scpStat=`rpm -qa | grep openssh-clients`
if [ -z $scpStat ];then
	`yum -y install openssh-clients > /dev/null 2>&1`
	scpStat=`rpm -qa | grep openssh-clients`
	if [ -z $scpStat ]; then
		scpFlag=0
	else
		scpFlag=1
		instlld+=(openssh-clients);
	fi
else
		scpFlag=1
		instlld+=(openssh-clients);
fi
return $scpFlag
}
function fn_lsof()
{
declare -i lsofFlag=0
lsofStat=`rpm -qa | grep lsof`
if [ -z $lsofStat ];then
	`yum -y install lsof > /dev/null 2>&1`
	lsofStat=`rpm -qa | grep lsof`
	if [ -z $lsofStat ]; then
		lsofFlag=0
	else
		lsofFlag=1
		instlld+=(lsof);
	fi
else
		lsofFlag=1
		instlld+=(lsof);
fi
return $lsofFlag
}
function fn_zip()
{
declare -i zipFlag=0
zipStat=`rpm -qa | grep -w zip`
if [ -z $zipStat ];then
	`yum -y install zip > /dev/null 2>&1`
	zipStat=`rpm -qa | grep -w zip`
	if [ -z $zipStat ]; then
		zipFlag=0
		instlld+=(zip);
	else
		zipFlag=1
		instlld+=(zip);
	fi
else
		zipFlag=1
fi
return $zipFlag
}
function fn_unzip()
{
declare -i unzipFlag=0
unzipStat=`rpm -qa | grep unzip`
if [ -z $unzipStat ];then
	`yum -y install unzip > /dev/null 2>&1`
	unzipStat=`rpm -qa | grep unzip`
	if [ -z $unzipStat ]; then
		unzipFlag=0
	else
		unzipFlag=1
		instlld+=(unzip);
	fi
else
		unzipFlag=1
		instlld+=(unzip);
fi
return $unzipFlag
}
function fn_crnTbs()
{
declare -i crontabsFlag=0
crontabsStat=`rpm -qa | grep crontabs`
if [ -z $crontabsStat ];then
	`yum -y install crontabs > /dev/null 2>&1`
	crontabsStat=`rpm -qa | grep crontabs`
	if [ -z $crontabsStat ]; then
		crontabsFlag=0
	else
		crontabsFlag=1
		instlld+=(crontabs);
	fi
else
		crontabsFlag=1
		instlld+=(crontabs);
fi
return $crontabsFlag
}
function fn_rSync()
{
declare -i rsyncFlag=0
rsyncStat=`rpm -qa | grep rsync`
if [ -z $rsyncStat ];then
	`yum -y install rsync > /dev/null 2>&1`
	rsyncStat=`rpm -qa | grep rsync`
	if [ -z $rsyncStat ]; then
		rsyncFlag=0
	else
		rsyncFlag=1
		instlld+=(rsync);
	fi
else
		rsyncFlag=1
		instlld+=(rsync);
fi
return $rsyncFlag
}
function fn_arch()
{
  uname -m |  grep x86_64 && x_64=1 || x_64=0
  if [ $x_64 -eq 1 ]
    then
     echo -e "${Purple}$x_64: x86_64${NC}";
     #jdk
     else
       echo -e "${Purple}$x_64: x86_32${NC}";
       #jdk-32
     fi
}
function fn_selinux()
{
  echo -e "${Green}Disabling selinux...${NC}";
  sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
  ip6tables  -F
  service ip6tables stop
  chkconfig ip6tables off
}
function fn_setup()
{
  setup;
}
function fn_jdk()
{
         jdk_search_t=$(date +%s);
         echo -e "${Green}Searching for jdk. Please wait...${NC}";
         flg_jdk=1;
         find  /usr/ -name jdk1.6*  | grep jdk1.6* && var_jdk=1  || var_jdk=0
          if [ $var_jdk -eq 1 ]
           then
           #echo "Java found"
           #find /usr/java/jdk* > jd ;tail +1 < jd |  head -n1  > jdk ;not supported by rhel 5
           find  /usr/ -name jdk1.6* > jd ; head -1 jd > jdk
           var_jdk=$(<jdk)
           echo $var_jdk
           jdk_search_et=$(date +%s)
           echo -e "${Green}JDK search time: $((jdk_search_et-jdk_search_t)) secs.${NC}";
           rm -f jd jdk;
         else
           echo -e "${Green}installing java, please wait...${NC}"
           if [ $x_64 -eq 1 ]
            then
                #jdk-64
                echo -e "${Green}Downloading x86_64 jdk... ${NC}";
                cd /usr/
                wget http://$var_installer_ip/downloads/jdk-6u25-linux-x64.bin
				#wget http://$var_installer_ip/downloads/jdk-7u25-linux-x64.tar.gz
                chmod a+x jdk-6u25-linux-x64.bin
                ./jdk-6u25-linux-x64.bin
				#tar -zxvf jdk-7u25-linux-x64.tar.gz
                var_jdk="/usr/jdk1.6.0_25"
                echo $var_jdk
             else
               #jdk-32
               echo -e "${Green}Downloading x86_32 jdk... ${NC}";
               cd /usr/
               wget http://$var_installer_ip/downloads/jdk6.tar.gz
			   #wget http://$var_installer_ip/downloads/jdk-7u51-linux-i586.tar.gz
               
               tar -zxvf jdk6.tar.gz
               ./jdk-6u13-linux-i586-rpm.bin
			   #tar -zxvf  jdk-7u51-linux-i586.tar.gz
               var_jdk="/usr/java/jdk1.6.0_13"
               echo $var_jdk
             fi
          fi
}
function fn_my_dot_cnf()
{
        #find /etc -name my.cnf | grep my.cnf && var_mycnf=1 || var_mycnf=0
		mysql -e"\q" && var_mysql=1 || var_mysql=0
        if [ $var_mysql -eq 1 ]
         then
          echo -e "${Green}mysql exists. Please configure my.cnf${NC}"
         else
          echo -e "${Green}configuring my.cnf${NC}"
          echo "[mysqld]">/etc/my.cnf
          echo "datadir=/var/lib/mysql">>/etc/my.cnf
		  echo "socket=/var/lib/mysql/mysql.sock">>/etc/my.cnf
		  echo "user=mysql">>/etc/my.cnf
		  echo "# Disabling symbolic-links is recommended to prevent assorted security risks">>/etc/my.cnf
		  echo "symbolic-links=0">>/etc/my.cnf
		  echo "log-bin">>/etc/my.cnf
          echo "server-id=100">>/etc/my.cnf
          echo "max_connections=1000">>/etc/my.cnf
		  echo "[mysqld_safe]">>/etc/my.cnf
		  echo "log-error=/var/log/mysqld.log">>/etc/my.cnf
		  echo "pid-file=/var/run/mysqld/mysqld.pid">>/etc/my.cnf
         fi
}
function fn_mysqlInfo()
{
	mysqlStrt=0;
	while [ $mysqlStrt -eq "0" ];do
		$mysqlPass -e"\q" >>$logWrtng 2>&1 && mysqlRnng=1 || mysqlRnng=0
		if [ $mysqlRnng -eq 1 ];then
			echo "MySQL Running...";
			mysqlStrt=1;
			oldMySQLDir=$($mysqlPass -e"show variables like 'datadir'\G" | grep "Value" | gawk -F": " '{print $2}');
			echo $oldMySQLDir >>$logWrtng 2>&1
		else
			echo "MySQL is not running...";
			mysqlStrt=0;
			echo "Restarting MySQL...";
			service mysqld restart >>logss 2>&1 && myStart=1 || myStart=0;
			if [ $myStart -eq 1 ];then
				mysqlStrt=1;
				echo "MySQL started successfully...";
				return 1
			else
				mysqlStrt=0;
				echo "Couldn't start MySQL...";
				exit
			fi
		fi
	done
}
function fn_mysql()
{
        cd /
        mysql -e "\q" && var_mysql=1 || var_mysql=0
        if [ $var_mysql -eq 1 ]
          then
             echo -e "${Green}mysql exists${NC}"
          else
            if [ $x_64 -eq 1 ]
            then
             echo -e "${Green}Installing 64-bit mysql...${NC}";
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
		     unzip mysql-5.1.61.zip
		     cd mysql-5.1.61
             rpm -ivh --nodeps perl-DBI-1.609-4.el6.x86_64.rpm
             rpm -ivh --nodeps perl-DBD-MySQL-4.013-3.el6.x86_64.rpm
             rpm -ivh  mysql-libs-5.1.61-4.el6.x86_64.rpm 
             rpm -ivh --nodeps mysql-5.1.61-4.el6.x86_64.rpm
             rpm -ivh pkgconfig-0.23-9.1.el6.x86_64.rpm
             rpm -ivh  keyutils-libs-1.4-4.el6.x86_64.rpm
             rpm -ivh keyutils-libs-devel-1.4-4.el6.x86_64.rpm
             rpm -ivh libsepol-devel-2.0.41-4.el6.x86_64.rpm
             rpm -ivh libselinux-2.0.94-5.3.el6.x86_64.rpm
             rpm -ivh libselinux-devel-2.0.94-5.3.el6.x86_64.rpm 
             rpm -ivh libcom_err-1.41.12-12.el6.x86_64.rpm
             rpm -ivh libcom_err-devel-1.41.12-12.el6.x86_64.rpm
             rpm -ivh  krb5-libs-1.9-33.el6.x86_64.rpm
             rpm -ivh krb5-devel-1.9-33.el6.x86_64.rpm
             rpm -ivh zlib-1.2.3-27.el6.x86_64.rpm
             rpm -ivh zlib-devel-1.2.3-27.el6.x86_64.rpm
             rpm -ivh  openssl-1.0.0-20.el6_2.5.x86_64.rpm
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
            echo -e "${Green}Installing 32-bit mysql...${NC}";
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
function fn_file_limit()
{
         echo -e "${Green}Checkig file limit...${NC}";
         grep "* - nofile 500000"  /etc/security/limits.conf  && var_limit=1  || var_limit=0
         if [ $var_limit -eq 1 ]
          then
           echo -e "${Green}file limit exists${NC}"
          else
           echo -e "${Green}configuring file limit...${NC}"
           echo "* - nofile 500000">>/etc/security/limits.conf
           cat  /proc/sys/fs/file-max
           echo 500000 > /proc/sys/fs/file-max
           ulimit -n 500000
           ulimit -n
          fi
         grep "fs.file-max" /etc/sysctl.conf  && var_sysctl=1  || var_sysctl=0
         if [ $var_sysctl -eq 1 ]
          then
           echo -e "${Green}file-max exists${NC}"
         else
           echo -e "${Green}file-max not exists${NC}"
           echo "fs.file-max =500000">>/etc/sysctl.conf
           echo 500000 > /proc/sys/fs/file-max
           ulimit -n 500000
           ulimit -n
         fi
}
##############Initial Checkup Ends###############
function fn_Con(){
		conSuccssfl="";
		
		SSHSOCKET=~/.ssh/teeCon
		ssh -M -f -N -o ControlPath=$SSHSOCKET -p $nSrvrPrt $nSrvrUsr@$nSrvrIP
		ssh -o ControlPath=$SSHSOCKET -p $nSrvrPrt $nSrvrUsr@$nSrvrIP "hostname && mkdir -p $resourcePath" && conSuccssfl=1 || conSuccssfl=0
		if [ $conSuccssfl -eq 1 ];then
			echo -e "${BPurple}$($logDate) Connection establishment successfull${NC}" >>$logWrtng 2>&1
			echo -e "${BPurple}$($logDate) Connection establishment successfull${NC}"
		else
			echo -e "${BRed}$($logDate) Connection establishment was not successfull${NC}" >>$logWrtng 2>&1
			echo -e "${BRed}$($logDate) Connection establishment was not successfull${NC}" >>$logWrtng 2>&1
			exit
		fi						
}


function fn_input(){
	echo "----------------------------------------------------------------"
			echo -en "${BBlue}Enter Switch Reference ID: ${NC}";
			read swRefID;
			while [ -z "${swRefID}" ];do
				echo -n "Please enter Reference number [Null/Invalid entry not accepted]: "
				read swRefID;
			done		
	echo "----------------------------------------------------------------"
			echo -en "${BBlue}Sales executive Email ID: ${NC}";
			read var_sales_email;
			var_sales=$var_sales_email;
			
			if [ -z "${var_sales}" ];then
				var_sales="Demo";
				echo "Sales executive: $var_sales";
			else
				echo "Sales executive: $var_sales";
			fi
	echo "----------------------------------------------------------------"
			echo -en "${BBlue}Enter Customer Email ID: ${NC}";
			read email;
			
			if [ -z "${email}" ];then
				email="noreply-support@revesoft.com";
				echo "Current email id: $email";
			else
				echo "Current email id: $email";
			fi
	echo "----------------------------------------------------------------"
			echo -en "${BBlue}Enter Billing name (Press Enter to skip): ${NC}"
			read varBilling;
			
			if [ -z "${varBilling}" ];then
				varBilling="billing";
				echo "Current Billing Name: $varBilling";
			else
				echo "Current Billing Name: $varBilling";
			fi
			
	echo "----------------------------------------------------------------"
			echo -en "${BBlue}Enter Old Server IP: ${NC}";
			read oSrvrIP;
			while [[ ! $oSrvrIP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]];do
				echo -n "Please enter Old Server IP [Null/Invalid entry not accepted]: "
				read oSrvrIP;
			done
	#echo "----------------------------------------------------------------"
	#		echo -en "${BBlue}Enter Old Server User: ${NC}";
	#		read oSrvrUsr;
	#echo "----------------------------------------------------------------"
	#		echo -en "${BBlue}Enter Old Server SSH Port: ${NC}";
	#		read oSrvrPrt;
			#new server info 
	echo "----------------------------------------------------------------"
			echo -en "${BBlue}Enter New Server IP: ${NC}";
				read nSrvrIP;
				while [[ ! $nSrvrIP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]];do
					echo -n "Please enter New Server IP [Null/Invalid entry not accepted]: "
					read nSrvrIP;
				done
	echo "----------------------------------------------------------------"
			echo -en "${BBlue}Enter New Server User (Press Enter for Default): ${NC}";
				read nSrvrUsr;
				if [ -z "${nSrvrUsr}" ];then
					nSrvrUsr="root";
					echo "Current User ID: $nSrvrUsr";
				else
					echo "Current User ID: $nSrvrUsr";
				fi
	echo "----------------------------------------------------------------"
			echo -en "${BBlue}Enter New Server SSH Port (Press Enter for Default) : ${NC}";
				read nSrvrPrt;
				if [ -z "${nSrvrPrt}" ];then
					nSrvrPrt="22";
					echo "Current SSH Port: $nSrvrPrt";
				else
					echo "Current SSH Port: $nSrvrPrt";
				fi
				rSncPort="ssh -o ControlPath=$SSHSOCKET -p $nSrvrPrt"
	#echo "----------------------------------------------------------------"
			#echo -en "${BBlue}Enter Billing name:  ${NC}";
				#read varBilling;
	#Task - Need to escalate mysql pass to fn_input 
	echo "----------------------------------------------------------------"
			echo -en "${BBlue}Enter MySQL User (Press Enter to skip): ${NC}"
				read myUser;
	echo "----------------------------------------------------------------"
			echo -en "${BBlue}Enter MySQL Password (Press Enter to skip): ${NC}"
				read myPassword;
	echo "----------------------------------------------------------------"
	if [ -z $myUser ] && [ -z $myPassword ];then
			echo -e "${BRed}MySQL doesn't have any password${NC}";
			mysqlPass="mysql -u root";
	elif [ -z $myPassword ];then
			echo -e "${BRed}MySQL doesn't have any password${NC}";
			mysqlPass="mysql -u root";
	elif [ -z $myUser ];then
			echo -e "${BRed}MySQL doesn't have any password${NC}";
			mysqlPass="mysql -u root -p$myPassword";
	else
			echo -e "${BRed}MySQL password is set${NC}";
			mysqlPass="mysql -u $myUser -p$myPassword";
	fi
	echo -e "${BBlue}$mysqlPass${NC}";
	echo "----------------------------------------------------------------"
			echo -en "${BBlue}Enter New Server MySQL User (Press Enter to skip): ${NC}"
				read myNewUser;
	echo "----------------------------------------------------------------"
			echo -en "${BBlue}Enter New Server MySQL Password (Press Enter to skip): ${NC}"
				read myNewPassword;
	echo "----------------------------------------------------------------"
	if [ -z $myNewUser ] && [ -z $myNewPassword ];then
			echo -e "${BRed}MySQL doesn't have any password${NC}";
			newMysqlPass="mysql -u root";
	elif [ -z $myNewPassword ];then
			echo -e "${BRed}MySQL doesn't have any password${NC}";
			newMysqlPass="mysql -u root";
	elif [ -z $myNewUser ];then
			echo -e "${BRed}MySQL doesn't have any password${NC}";
			newMysqlPass="mysql -u root -p$myNewPassword";
	else
			echo -e "${BRed}MySQL password is set${NC}";
			newMysqlPass="mysql -u $myNewUser -p$myNewPassword";
	fi
	echo -e "${BRed}$newMysqlPass${NC}";
}
function fn_time_zone(){
	#echo -en "${BBlue}Do you want to change server time and date? y/n: ${NC}"
	yorn=$tmStClr
	#if [ $yorn == y ] || [ $yorn == Y ] || [ $yorn == YES ] || [ $yorn == yes ]
	 # then
		bckDate=$($logDate)
		#cat /etc/sysconfig/clock > $resourcePath/clock
		ssh -o ControlPath=$SSHSOCKET -p $nSrvrPrt $nSrvrUsr@$nSrvrIP "mv /etc/sysconfig/clock /etc/sysconfig/clock$bckDate" >>$logWrtng 2>&1
		scp -o ControlPath=$SSHSOCKET  -rP $nSrvrPrt /etc/sysconfig/clock $nSrvrUsr@$nSrvrIP:/etc/sysconfig/ >>$logWrtng 2>&1
		
		tzS=$(cat /etc/sysconfig/clock | grep "ZONE" | gawk -F"\"" '{print $2}');
		
		#mv /etc/localtime /etc/localtime_$bckDate
		#ln -s /usr/share/zoneinfo/$tzS /etc/localtime
		
		ssh -o ControlPath=$SSHSOCKET -p $nSrvrPrt $nSrvrUsr@$nSrvrIP "mv /etc/localtime /etc/localtime_$bckDate" >>$logWrtng 2>&1
		ssh -o ControlPath=$SSHSOCKET -p $nSrvrPrt $nSrvrUsr@$nSrvrIP "ln -s /usr/share/zoneinfo/$tzS /etc/localtime" >>$logWrtng 2>&1
		
		#date (month)(day)(hour)(minute)(year).(Seconds)
		newSrvrDate=$(date +%m%d%H%M%Y.%S) && echo $($logDate) Current Server Date - $newSrvrDate >>$logWrtng 2>&1 
		ssh -o ControlPath=$SSHSOCKET -p $nSrvrPrt $nSrvrUsr@$nSrvrIP "date $newSrvrDate" >>$logWrtng 2>&1
		newDate=$(ssh -o ControlPath=$SSHSOCKET -p $nSrvrPrt $nSrvrUsr@$nSrvrIP "date");
		
		echo -e "${BBlue}Date and time has been changed.${NC}"
		echo "$($logDate) Server time is $newDate is set " >>$logWrtng 2>&1
	 #else
	  # echo -e "${BBlue}Date and time remain unchanged.${NC}"
	   #echo "$($logDate) Server date and time remain unchanged " >>$logWrtng 2>&1
	   
	 #fi
}
function fn_DBList(){
#Database Input
declare -a arrayListOfDBs=();
for i in $(ls $oldMySQLDir | grep  BalanceServer) $(ls $oldMySQLDir | grep  Failed) $(ls $oldMySQLDir | grep  IPChanger) $(ls $oldMySQLDir | grep  SMSSystem) $(ls $oldMySQLDir | grep  Successful) $(ls $oldMySQLDir | grep  iTelBilling)  ;do
arrayListOfDBs+=($i);
done
totalDBS=${#arrayListOfDBs[@]}
declare -a arrayListOfSrvcs=();
echo -e "${BBlue}---------------------------------------------------${NC}"
echo -e "${BBlue}Please select the list of databases to be shifted...${NC}"
echo -e "${BBlue}----------------------------------------------------${NC}"
echo -e "${BBlue}$($logDate) Select 1 to ${#arrayListOfDBs[@]} from menu, Press 0 if you are done${NC}" >>$logWrtng 2>&1
echo -e "${BBlue}Select 1 to ${#arrayListOfDBs[@]} from menu, Press 0 if you are done${NC}";
echo -e "${BBlue}---------------------------------------------------${NC}"
while [ -z $dbsID ];
do
	for (( i=1; i<${totalDBS}+1; i++ ));
	do
		dbsPath=${arrayListOfDBs[$i-1]}
		echo -e "${Blue}$($logDate) $i : $dbsPath ${NC}" >>$logWrtng 2>&1 
		echo -e "${Blue}  $i : $dbsPath ${NC}"; 
	done
	echo -e "${Purple}$($logDate) Please select Database ID from 1 to $totalDBS , '0' to complete the list : ${NC} " >>$logWrtng 2>&1
	echo -e "${Purple}Please select Database ID from 1 to $totalDBS , '0' to complete the list : ${NC} "
	read -a dbsID;
	
	echo $($logDate) ${dbsID[@]} >>$logWrtng 2>&1
	
	for dbsIDs in ${dbsID[@]};do
		if [ -z $dbsIDs ];then
			echo -e "${Red}$($logDate) Null Input ${NC}" >>$logWrtng 2>&1
			echo -e "${Red}Null Input ${NC}";sleep 1;clear
		elif [[ $dbsIDs -eq 0 ]] ;then
			echo -e "${Red}$($logDate) Database enlistment complete ${NC}" >>$logWrtng 2>&1
			echo -e "${Red}Database enlistment complete ${NC}";sleep 1;clear
			>$dbs
			for i in ${arrayListOfSrvcs[@]};do
				echo $i >> $dbs;
			done
			dbsID=1;break;
		elif [[ $dbsIDs -lt 1 ]] || [[ $dbsIDs -gt $totalDBS ]];then
			echo -e "${Red}$($logDate) Wrong Input value ${NC}" >>$logWrtng 2>&1
			echo -e "${Red}Wrong Input value ${NC}";
			unset dbsID;clear
		elif [ $dbsIDs -le ${#arrayListOfDBs[@]} ] && [ $dbsIDs -gt 0 ]  ;then
			echo -e "${BBlue}$($logDate) ${arrayListOfDBs[$dbsIDs-1]} added to shifting list ${NC}" >>$logWrtng 2>&1
			echo -e "${BBlue}${arrayListOfDBs[$dbsIDs-1]} added to shifting list ${NC}"
			arrayListOfSrvcs+=(${arrayListOfDBs[$dbsIDs-1]});
			unset dbsID;clear;continue;
		fi
	done
done
arrayListOfSrvcs=($(sort -u $dbs));
>$dbs;
for i in ${arrayListOfSrvcs[@]};do
	echo $i >> $dbs;
done
declare -a dbExists=();
for i in $(cat $dbs);do
	dbExists+=($(ssh -o ControlPath=$SSHSOCKET -p $nSrvrPrt $nSrvrUsr@$nSrvrIP "ls $newMySQLDir | grep -w $i"));
done
if [ -z ${dbExists[0]} ];then 
	echo -e "${BBlue}$($logDate) Continuing with the next step${NC}" >>$logWrtng 2>&1
	echo -e "${BBlue}Continuing with the next step${NC}"
	dbChkClear=1;
else
	echo -e "${BBlue}$($logDate) ${dbExists[@]}${NC}\n${BRed}Above database are already running in the new server${NC}" >>$logWrtng 2>&1
	echo -e "${BBlue}${dbExists[@]}${NC}\n${BRed}Above database are already running in the new server${NC}";
	dbChkClear=0;
	exit
fi
#cat $dbs | grep "iTelBilling" > $resourcePath/iTelBilling_dbs_$dbs_date >>$logWrtng 2>&1
#cat $dbs | grep "Successful" > $resourcePath/Successful_dbs_$dbs_date && sed -i "/iTelBilling/d" $resourcePath/Successful_dbs_$dbs_date >>$logWrtng 2>&1
#cat $dbs | grep "Failed" > $resourcePath/Failed_dbs_$dbs_date >>$logWrtng 2>&1
#cat $dbs | grep "BalanceServer" > $resourcePath/BalanceServer_dbs_$dbs_date >>$logWrtng 2>&1
#cat $dbs | grep "IPChanger" > $resourcePath/IPChanger_dbs_$dbs_date >>$logWrtng 2>&1
}
function fn_SrvList(){
#Shiftable Service Input
declare -a availableService=();
for i in $(ls $localPath/ | grep BalanceServer) $(ls $localPath/ | grep ByteSaverMediaProxy) $(ls $localPath/ | grep ByteSaverSignalConverter) $(ls $localPath/ | grep CreditCardServer) $(ls $localPath/ | grep DiskSpaceChecker) $(ls $localPath/ | grep DBHealthChecker) $(ls $localPath/ | grep IPChanger) $(ls $localPath/ | grep iTelBilling) $(ls $localPath/ | grep iTelAppsServer) $(ls $localPath/ | grep iTelAutoSignUp) $(ls $localPath/ | grep iTelDataBackup) $(ls $localPath/ | grep iTelSwitchPlusMediaProxy) $(ls $localPath/ | grep iTelSwitchPlusSignaling) $(ls $localPath/ | grep MobileBilling) $(ls $localPath/ | grep MoneyTransfer) $(ls $localPath/ | grep PaymentServer) $(ls $localPath/ | grep PushSender) $(ls $localPath/ | grep RadiusServer) $(ls $localPath/ | grep SwitchInstaller) $(ls $localPath/ | grep SMS_Server) $(ls $localPath/ | grep TopUpServer) ;do
availableService+=($i);
done
totalService=${#availableService[@]}
declare -a arrayListOfSrvcs=();
echo -e "${BBlue}---------------------------------------------------${NC}"
echo -e "${BBlue}Please select the list of services to be shifted...${NC}"
echo -e "${BBlue}$($logDate) Select 1 to ${#availableService[@]} from menu, Press 0 if you are done${NC}" >>$logWrtng 2>&1
echo -e "${BBlue}Select 1 to ${#availableService[@]} from menu, Press 0 if you are done${NC}";
echo -e "${BBlue}---------------------------------------------------${NC}"
while [ -z $serviceID ];
do
	for (( i=1; i<${totalService}+1; i++ ));
	do
		servicePath=${availableService[$i-1]}
		echo -e "${Green}$($logDate) $i : $servicePath ${NC}" >>$logWrtng 2>&1  
		echo -e "${Green}$i : $servicePath ${NC}"; 
	done
	echo -e "${Purple}$($logDate) Please select Service ID from 1 to $totalService , '0' to complete the list : ${NC} " >>$logWrtng 2>&1 
	echo -e "${Purple}Please select Service ID from 1 to $totalService , '0' to complete the list : ${NC} "
	read -a serviceID;
	echo $($logDate) ${serviceID[@]} >>$logWrtng 2>&1 
	
	for serviceIDs in ${serviceID[@]};do
		if [ -z $serviceIDs ];then
			echo -e "${Red}$($logDate) Null Input ${NC}" >>$logWrtng 2>&1 
			echo -e "${Red}Null Input ${NC}";sleep 1;clear
		elif [[ $serviceIDs -eq 0 ]] ;then
			echo -e "${Red}$($logDate) Shiftable Service enlistment complete ${NC}" >>$logWrtng 2>&1
			echo -e "${Red}Shiftable Service enlistment complete ${NC}";
			>$listofshift
			for i in ${arrayListOfSrvcs[@]};do
				echo $i >> $listofshift;
			done
			serviceID=1;
			break;
		elif [[ $serviceIDs -lt 1 ]] || [[ $serviceIDs -gt $totalService ]];then
			echo -e "${Red}$($logDate) Wrong Input value ${NC}" >>$logWrtng 2>&1
			echo -e "${Red}Wrong Input value ${NC}";
			unset serviceID;clear
		elif [ $serviceIDs -le ${#availableService[@]} ] && [ $serviceIDs -gt 0 ]  ;then
			echo -e "${BBlue}$($logDate) ${availableService[$serviceIDs-1]} added to shifting list \n${NC}" >>$logWrtng 2>&1
			echo -e "${BBlue}${availableService[$serviceIDs-1]} added to shifting list \n${NC}"
			arrayListOfSrvcs+=(${availableService[$serviceIDs-1]});
			unset serviceID;clear;
			continue;
		fi
	done
done
arrayListOfSrvcs=($(sort -u $listofshift));
>$listofshift;
for i in ${arrayListOfSrvcs[@]};do
	echo $i >> $listofshift;
done
declare -a serviceExists=();
for i in $(cat $listofshift);do
	serviceExists+=($(ssh -o ControlPath=$SSHSOCKET -p $nSrvrPrt $nSrvrUsr@$nSrvrIP "ls $localPath/ | grep -w $i"));
done
if [ -z ${serviceExists[0]} ];then 
	echo -e "${BBlue}Continuing with the next step${NC}";
	srvChkClear=1;
else
	echo -e "${BBlue}${serviceExists[@]}${NC}\n${BRed}Above servers are already running in the new server${NC}";
	srvChkClear=0
	exit
fi
}
#Task - Need to change IP configuration parameters
function fn_servicConf()
{
#Configure IP Changing script
for servIces in $(cat $listofshift); do
	if [[ $servIces =~ ^BalanceServer ]];then
		echo -e "$($logDate) Configuring $servIces" >>$logWrtng 2>&1;
		dbCon=$(cat $localPath/$servIces/DatabaseConnection*xml | grep "mysql:/" | gawk -F"//" '{print $2}' | gawk -F"\"" '{print $1}')
		echo $dbCon | grep "/" && ipSet=1 || ipSet=0 
		if [ $ipSet -eq 1 ];then
			dbBlncSrvrCon=$(echo $dbCon | grep "/" | gawk -F/ '{print $2}');
			else
			dbBlncSrvrCon=$dbCon;
		fi
		echo -e "$newMysqlPass -D $dbBlncSrvrCon -e\"update vbBalance set bindIP='$nSrvrIP' where bindIP='$oSrvrIP';\"" >> $configNewIP
	elif [[ $servIces =~ ^ByteSaverMediaProxy ]];then
		echo -e "$($logDate) Configuring $servIces" >>$logWrtng 2>&1;
		#echo -e "sed -i \"s/$oSrvrIP/${nSrvrIP}/g\" $localPath/$servIces/rtpProperties.cfg" >> $configNewIP
		serverCFG="$localPath/$servIces/rtpProperties.cfg"
		echo "sed -i \"s/$oSrvrIP/${nSrvrIP}/g\" $serverCFG" >> $configNewIP
		echo "sed -i \"/voiceListenIP/c\\voiceListenIP=${nSrvrIP}\" $serverCFG" >> $configNewIP
		
		isadditionalMediaIP=$(cat $serverCFG  | grep "^additionalMediaIP")
		
		if [[ ! -z "$isadditionalMediaIP" ]]; then
			echo "sed -E -i 's/^(additionalMediaIP.*)$/#\1/g' $serverCFG" >> $configNewIP
		fi
		
		echo "sed -i \"/localListenIP/c\\localListenIP=${nSrvrIP}\" $serverCFG" >> $configNewIP
		echo "sed -i \"/remoteSignalingIP/c\\remoteSignalingIP=${nSrvrIP}\" $serverCFG" >> $configNewIP
		echo "" >> $configNewIP
		echo -e "sh $localPath/$servIces/softlink.sh" >> $configNewIP
	elif [[ $servIces =~ ^ByteSaverSignalConverter ]];then
		echo -e "$($logDate) Configuring $servIces" >>$logWrtng 2>&1;
		#echo -e "sed -i \"s/$oSrvrIP/${nSrvrIP}/g\" $localPath/$servIces/server.cfg" >> $configNewIP
		
		serverCFG="$localPath/$servIces/server.cfg"
		echo "sed -i \"s/$oSrvrIP/${nSrvrIP}/g\" $serverCFG" >> $configNewIP
		echo "sed -i \"/dialerBindAddress/c\\dialerBindAddress=${nSrvrIP}\" $serverCFG" >> $configNewIP
		echo "sed -i \"/switchBindAddress/c\\switchBindAddress=${nSrvrIP}\" $serverCFG" >> $configNewIP
		echo "sed -i \"/mediaProxyIP/c\\mediaProxyIP=${nSrvrIP}\" $serverCFG" >> $configNewIP
		echo "sed -i \"/localMediaProxyBindIP/c\\localMediaProxyBindIP=${nSrvrIP}\" $serverCFG" >> $configNewIP
		echo "sed -i \"/localProvisioningBindIP/c\\localProvisioningBindIP=${nSrvrIP}\" $serverCFG" >> $configNewIP
		echo "" >> $configNewIP
		
		echo -e "sh $localPath/$servIces/softlink.sh" >> $configNewIP
	elif [[ $servIces =~ ^DiskSpaceChecker ]];then
		echo -e "$($logDate) Configuring $servIces" >>$logWrtng 2>&1;
		echo -e "sed -i \"s/$oSrvrIP/${nSrvrIP}/g\" $localPath/$servIces/email_properties" >> $configNewIP
		echo -e "sh $localPath/$servIces/softlink.sh" >> $configNewIP
	elif [[ $servIces =~ ^IPChanger ]];then
		echo -e "$($logDate) Configuring $servIces" >>$logWrtng 2>&1;
		#echo -e "sed -i \"s/$oSrvrIP/${nSrvrIP}/g\" $localPath/$servIces/IPChangerProperties.cfg" >> $configNewIP
		
		serverCFG="$localPath/$servIces/IPChangerProperties.cfg"
		echo "sed -i \"s/$oSrvrIP/${nSrvrIP}/g\" $serverCFG" >> $configNewIP
		echo "sed -i \"/voiceListenIPList/c\\voiceListenIPList=${nSrvrIP};${nSrvrIP};${nSrvrIP};${nSrvrIP};\" $serverCFG" >> $configNewIP
		echo "" >> $configNewIP
		
		echo -e "sh $localPath/$servIces/softlink.sh" >> $configNewIP
	elif [[ $servIces =~ ^iTelAppsServer ]];then
		echo -e "$($logDate) Configuring $servIces" >>$logWrtng 2>&1;
		#echo -e "sed -i \"s/$oSrvrIP/${nSrvrIP}/g\" $localPath/$servIces/Configuration.properties" >> $configNewIP
		#echo -e "sed -i \"s/$oSrvrIP/${nSrvrIP}/g\" $localPath/$servIces/Configuration.txt" >> $configNewIP
		
		serverCFG="$localPath/$servIces/Configuration.properties"
		serverCFG2="$localPath/$servIces/Configuration.txt"
		echo "sed -i \"/bindAddress/c\\bindAddress=${nSrvrIP}\" $serverCFG" >> $configNewIP
		echo "sed -i \"/bindAddress/c\\bindAddress=${nSrvrIP}\" $serverCFG2" >> $configNewIP
		echo "sed -i \"/webAddress/c\\webAddress=${nSrvrIP}\" $serverCFG" >> $configNewIP
		echo "sed -i \"s/$oSrvrIP/${nSrvrIP}/g\" $serverCFG" >> $configNewIP
		echo "sed -i \"s/$oSrvrIP/${nSrvrIP}/g\" $serverCFG2" >> $configNewIP
		echo "" >> $configNewIP
		
		echo -e "sh $localPath/$servIces/softlink.sh" >> $configNewIP
	elif [[ $servIces =~ ^SMS_Server ]];then
		echo -e "$($logDate) Configuring $servIces" >>$logWrtng 2>&1;
		#echo -e "sed -i \"s/$oSrvrIP/${nSrvrIP}/g\" $localPath/$servIces/Configuration.txt" >> $configNewIP
		
		serverCFG="$localPath/$servIces/Configuration.txt"
		echo "sed -i \"/bindAddress/c\\bindAddress=${nSrvrIP}\" $serverCFG" >> $configNewIP
		echo "sed -i \"s/$oSrvrIP/${nSrvrIP}/g\" $serverCFG" >> $configNewIP
		echo "" >> $configNewIP
		echo -e "sh $localPath/$servIces/softlink.sh" >> $configNewIP
	elif [[ $servIces =~ ^iTelAutoSignUp ]];then
		echo -e "$($logDate) Configuring $servIces" >>$logWrtng 2>&1;
		#echo -e "sed -i \"s/$oSrvrIP/${nSrvrIP}/g\" $localPath/$servIces/config/SignUp.conf" >> $configNewIP
		
		serverCFG="$localPath/$servIces/config/SignUp.conf"
		echo "sed -i \"/localBindIP/c\\localBindIP=${nSrvrIP}\" $serverCFG" >> $configNewIP
		echo "sed -i \"/switchIP/c\\switchIP=${nSrvrIP}\" $serverCFG" >> $configNewIP
		echo "sed -i \"/bindAddress/c\\bindAddress=${nSrvrIP}\" $serverCFG" >> $configNewIP
		echo "sed -i \"s/$oSrvrIP/${nSrvrIP}/g\" $serverCFG" >> $configNewIP
		echo "" >> $configNewIP
		
		echo -e "sh $localPath/$servIces/softlink.sh" >> $configNewIP
	elif [[ $servIces =~ ^MobileBilling ]];then
		echo -e "$($logDate) Configuring $servIces" >>$logWrtng 2>&1;
		#echo -e "sed -i \"s/$oSrvrIP/${nSrvrIP}/g\" $localPath/$servIces/Configuration.properties" >> $configNewIP
		
		serverCFG="$localPath/$servIces/Configuration.properties"
		echo "sed -i \"/bindAddress/c\\bindAddress=${nSrvrIP}\" $serverCFG" >> $configNewIP
		echo "sed -i \"s/$oSrvrIP/${nSrvrIP}/g\" $serverCFG" >> $configNewIP
		echo "" >> $configNewIP
		echo -e "sh $localPath/$servIces/softlink.sh" >> $configNewIP
	elif [[ $servIces =~ ^TopUpServer ]];then
		echo -e "$($logDate) Configuring $servIces" >>$logWrtng 2>&1;
		#echo -e "sed -i \"s/$oSrvrIP/${nSrvrIP}/g\" $localPath/$servIces/Configuration.properties" >> $configNewIP
		
		serverCFG="$localPath/$servIces/Configuration.properties"
		echo "sed -i \"/bindAddress/c\\bindAddress=${nSrvrIP}\" $serverCFG" >> $configNewIP
		echo "sed -i \"/webAddress/c\\webAddress=${nSrvrIP}\" $serverCFG" >> $configNewIP
		echo "sed -i \"s/$oSrvrIP/${nSrvrIP}/g\" $serverCFG" >> $configNewIP
		echo "" >> $configNewIP
		echo -e "sh $localPath/$servIces/softlink.sh" >> $configNewIP
	elif [[ $servIces =~ ^iTelSwitchPlusSignaling ]];then
		echo -e "$($logDate) Configuring $servIces" >>$logWrtng 2>&1;
		#echo -e "sed -i \"s/$oSrvrIP/${nSrvrIP}/g\" $localPath/$servIces/config/server.cfg" >> $configNewIP
		
		serverCFG="$localPath/$servIces/config/server.cfg"
		emailInfoCFG="$localPath/$servIces/config/emailInfo.cfg"
		
		echo "sed -i \"s/$oSrvrIP/${nSrvrIP}/g\" $emailInfoCFG" >> $configNewIP
		
		echo "mNprt=\$(grep mediaNode $serverCFG | gawk -F: '{print \$2}')" >> $configNewIP
		echo "sed -i \"s/$oSrvrIP/${nSrvrIP}/g\" $serverCFG" >> $configNewIP
		echo "sed -i \"/orgBindIP/c\\orgBindIP=${nSrvrIP}\" $serverCFG" >> $configNewIP
		echo "sed -i \"/terBindIP/c\\terBindIP=${nSrvrIP}\" $serverCFG" >> $configNewIP
		echo "sed -i \"/registrationReceiverIPList/c\\registrationReceiverIPList=${nSrvrIP}\" $serverCFG" >> $configNewIP
		echo "sed -i \"/mediaNode/c\\mediaNode=${nSrvrIP}:\${mNprt}\" $serverCFG" >> $configNewIP
		echo "sed -i \"/mediaListenIP/c\\mediaListenIP=${nSrvrIP}\" $serverCFG" >> $configNewIP
		
		echo -e "sh $localPath/$servIces/softlink.sh" >> $configNewIP
	elif [[ $servIces =~ ^iTelSwitchPlusMediaProxy ]];then
		echo -e "$($logDate) Configuring $servIces" >>$logWrtng 2>&1;
		#echo -e "sed -i \"s/$oSrvrIP/${nSrvrIP}/g\" $localPath/$servIces/rtpProperties.cfg" >> $configNewIP
		
		serverCFG="$localPath/$servIces/rtpProperties.cfg"
		echo "sed -i \"/localListenIP/c\\localListenIP=${nSrvrIP}\" $serverCFG" >> $configNewIP
		echo "sed -i \"/remoteSignalingIP/c\\remoteSignalingIP=${nSrvrIP}\" $serverCFG" >> $configNewIP
		echo "sed -i \"s/$oSrvrIP/${nSrvrIP}/g\" $serverCFG" >> $configNewIP
		echo "" >> $configNewIP
		echo -e "sh $localPath/$servIces/softlink.sh" >> $configNewIP
	elif [[ $servIces =~ ^iTelBilling ]];then
		echo -e "$($logDate) Configuring $servIces" >>$logWrtng 2>&1;
		#echo -e "sed -i \"s/$oSrvrIP/${nSrvrIP}/g\" $localPath/$servIces/iTelSwitchPlusMediaProxy/rtpProperties.cfg" >> $configNewIP
		
		serverCFG="$localPath/$servIces/iTelSwitchPlusMediaProxy/rtpProperties.cfg"
		echo "sed -i \"/localListenIP/c\\localListenIP=${nSrvrIP}\" $serverCFG" >> $configNewIP
		echo "sed -i \"/remoteSignalingIP/c\\remoteSignalingIP=${nSrvrIP}\" $serverCFG" >> $configNewIP
		echo "sed -i \"s/$oSrvrIP/${nSrvrIP}/g\" $serverCFG" >> $configNewIP
		echo "" >> $configNewIP
		echo -e "sh $localPath/$servIces/iTelSwitchPlusMediaProxy/softlink.sh" >> $configNewIP
		#echo -e "sed -i \"s/$oSrvrIP/${nSrvrIP}/g\" $localPath/$servIces/iTelSwitchPlusSignaling/config/server.cfg" >> $configNewIP
		
		serverCFG2="$localPath/$servIces/iTelSwitchPlusSignaling/config/server.cfg"
		echo "mNprt=\$(grep mediaNode $serverCFG2 | gawk -F: '{print \$2}')" >> $configNewIP
		echo "sed -i \"s/$oSrvrIP/${nSrvrIP}/g\" $serverCFG2" >> $configNewIP
		echo "sed -i \"/orgBindIP/c\\orgBindIP=${nSrvrIP}\" $serverCFG2" >> $configNewIP
		echo "sed -i \"/terBindIP/c\\terBindIP=${nSrvrIP}\" $serverCFG2" >> $configNewIP
		echo "sed -i \"/registrationReceiverIPList/c\\registrationReceiverIPList=${nSrvrIP}\" $serverCFG2" >> $configNewIP
		echo "sed -i \"/mediaNode/c\\mediaNode=${nSrvrIP}:\${mNprt}\" $serverCFG2" >> $configNewIP
		echo "sed -i \"/mediaListenIP/c\\mediaListenIP=${nSrvrIP}\" $serverCFG2" >> $configNewIP
		echo -e "sh $localPath/$servIces/iTelSwitchPlusSignaling/softlink.sh" >> $configNewIP
	elif [[ $servIces =~ ^DBHealthChecker ]];then
		echo -e "$($logDate) Configuring $servIces" >>$logWrtng 2>&1;
		echo -e "$($logDate) $servIces doesn't require IP configuration" >>$logWrtng 2>&1;
		
		dbcString=$(echo $servIces | gawk -FDBHealthChecker '{ print $2 }');
		echo "echo \"cd /usr/local/$servIces\" >/etc/rc.d/init.d/dbHealthchecker$dbcString.sh" >>$configNewIP
		echo "echo \"sh shutdownDBHealthChecker.sh\" >>/etc/rc.d/init.d/dbHealthchecker$dbcString.sh" >>$configNewIP
		echo "echo \"rm -f DBHealthChecker.log\" >>/etc/rc.d/init.d/dbHealthchecker$dbcString.sh" >>$configNewIP
		echo "echo \"sh runDBHealthChecker.sh\" >>/etc/rc.d/init.d/dbHealthchecker$dbcString.sh" >>$configNewIP
		echo "chmod a+x /etc/rc.d/init.d/dbHealthchecker$dbcString.sh" >>$configNewIP
		echo "crontab -l > dbHCcron;" >>$configNewIP
		echo "dbHcwcl=\$(wc -l dbHCcron | gawk '{print \$1 }');" >>$configNewIP
		echo "if [ \$dbHcwcl -gt 0 ]" >>$configNewIP
		echo "then" >>$configNewIP
		echo "echo \"0 0,12 * * *   /etc/rc.d/init.d/dbHealthchecker$dbcString.sh\" >> dbHCcron;" >>$configNewIP
		echo "else" >>$configNewIP
		echo "echo \"0 0,12 * * *   /etc/rc.d/init.d/dbHealthchecker$dbcString.sh\"> dbHCcron;" >>$configNewIP
		echo "fi" >>$configNewIP
		echo "crontab dbHCcron;" >>$configNewIP
		echo "rm -f dbHCcron;" >>$configNewIP	
		echo -e "sh $localPath/$servIces/softlink.sh" >> $configNewIP
		
	elif [[ $servIces =~ ^PushSender ]];then
		echo -e "$($logDate) $servIces doesn't require IP configuration" >>$logWrtng 2>&1;
		echo -e "sh $localPath/$servIces/softlink.sh" >> $configNewIP
	elif [[ $servIces =~ ^PaymentServers ]];then
		echo -e "$($logDate) $servIces doesn't require IP configuration" >>$logWrtng 2>&1;
		echo -e "sh $localPath/$servIces/softlink.sh" >> $configNewIP
	elif [[ $servIces =~ ^CreditCardServer ]];then
		echo -e "$($logDate) $servIces doesn't require IP configuration" >>$logWrtng 2>&1;
		echo -e "sh $localPath/$servIces/softlink.sh" >> $configNewIP
	elif [[ $servIces =~ ^MoneyTransfer ]];then
		echo -e "$($logDate) $servIces doesn't require IP configuration" >>$logWrtng 2>&1;
		echo -e "sh $localPath/$servIces/softlink.sh" >> $configNewIP
	elif [[ $servIces =~ ^SwitchInstaller ]];then
		echo -e "$($logDate) $servIces doesn't require IP configuration" >>$logWrtng 2>&1;
		echo -e "sh $localPath/$servIces/softlink.sh" >> $configNewIP
	else
		echo "$servIces";
		echo -e "$($logDate) No service found to configure new IP" >>$logWrtng 2>&1;
	fi
	
	#Prepare Service file and softlink.sh
	
	if [[ $servIces =~ ^iTelBilling ]];then
		echo -e "${BBlue}Configuring service file for $servIces${NC}";
		
		for partServIces in ${partitionServices[@]};do
			partServicesName=$servIces\_$partServIces
			fndRnfl=$(find $localPath/$servIces/$partServIces/ -name run*.sh)
			#cat $fndRnfl | grep jdk  | gawk -F"/bin/java" '{print $1}' >> $resourcePath/jdkList;
			fndShfl=$(find $localPath/$servIces/$partServIces/ -name shut*.sh)
			echo $servIces/$partServIces $partServicesName
			echo $($logDate) $servIces/$partServIces $partServicesName >>$logWrtng 2>&1
			
			>$localPath/$servIces/$partServIces/$partServicesName
			echo $($logDate) $localPath/$servIces/$partServIces/$partServicesName >>$logWrtng 2>&1
			
			echo "#!/bin/sh">$localPath/$servIces/$partServIces/$partServicesName
			echo "## $partServicesName   This shell script takes care of starting and stopping $partServicesName">>$localPath/$servIces/$partServIces/$partServicesName
			echo "# Source function library.">>$localPath/$servIces/$partServIces/$partServicesName
			echo ". /etc/rc.d/init.d/functions">>$localPath/$servIces/$partServIces/$partServicesName
			echo "#">>$localPath/$servIces/$partServIces/$partServicesName
			var="\$1">>$localPath/$servIces/$partServIces/$partServicesName
			echo "case \"$var\" in">>$localPath/$servIces/$partServIces/$partServicesName
			echo "start)">>$localPath/$servIces/$partServIces/$partServicesName
			echo "echo -n \"Starting $partServicesName: ">>$localPath/$servIces/$partServIces/$partServicesName
			echo "\"">>$localPath/$servIces/$partServIces/$partServicesName
			echo "$fndRnfl">>$localPath/$servIces/$partServIces/$partServicesName
			echo ";;">>$localPath/$servIces/$partServIces/$partServicesName
			echo "stop)">>$localPath/$servIces/$partServIces/$partServicesName
			echo "echo -n \"Stopping $partServicesName:">>$localPath/$servIces/$partServIces/$partServicesName
			echo "\"">>$localPath/$servIces/$partServIces/$partServicesName
			echo " $fndShfl">>$localPath/$servIces/$partServIces/$partServicesName
			echo "sleep 2">>$localPath/$servIces/$partServIces/$partServicesName
			echo ";;">>$localPath/$servIces/$partServIces/$partServicesName
			echo "restart)">>$localPath/$servIces/$partServIces/$partServicesName
			var="\$0">>$localPath/$servIces/$partServIces/$partServicesName
			echo "$var stop">>$localPath/$servIces/$partServIces/$partServicesName
			echo "$var start">>$localPath/$servIces/$partServIces/$partServicesName
			echo ";;">>$localPath/$servIces/$partServIces/$partServicesName
			echo "*)">>$localPath/$servIces/$partServIces/$partServicesName
			echo "echo \"Usage: $var {start|stop|restart}\"">>$localPath/$servIces/$partServIces/$partServicesName
			echo "exit 1">>$localPath/$servIces/$partServIces/$partServicesName
			echo "esac">>$localPath/$servIces/$partServIces/$partServicesName
			echo "exit 0">>$localPath/$servIces/$partServIces/$partServicesName
			
			>$localPath/$servIces/$partServIces/softlink.sh
			echo -e "cp $localPath/$servIces/$partServIces/$partServicesName /etc/rc.d/init.d/">>$localPath/$servIces/$partServIces/softlink.sh
			echo -e "chmod 755 /etc/rc.d/init.d/$partServicesName">>$localPath/$servIces/$partServIces/softlink.sh
			echo -e "chmod 755 $fndRnfl">>$localPath/$servIces/$partServIces/softlink.sh
			echo -e "chmod 755 $fndShfl">>$localPath/$servIces/$partServIces/softlink.sh
			echo -e "ln -s ../init.d/$partServicesName /etc/rc.d/rc3.d/S99$partServicesName">>$localPath/$servIces/$partServIces/softlink.sh
			echo -e "ln -s ../init.d/$partServicesName /etc/rc.d/rc5.d/S99$partServicesName">>$localPath/$servIces/$partServIces/softlink.sh
			echo -e "ln -s ../init.d/$partServicesName /etc/rc.d/rc0.d/K10$partServicesName">>$localPath/$servIces/$partServIces/softlink.sh
			echo -e "ln -s ../init.d/$partServicesName /etc/rc.d/rc6.d/K10$partServicesName">>$localPath/$servIces/$partServIces/softlink.sh	
		done
	else
		fndRnfl=$(find $localPath/$servIces/ -name run*.sh)
		#cat $fndRnfl | grep jdk  | gawk -F"/bin/java" '{print $1}' >> $resourcePath/jdkList;
		fndShfl=$(find $localPath/$servIces/ -name shut*.sh)
		echo $($logDate) $servIces  >>$logWrtng 2>&1
		>$localPath/$servIces/$servIces
		echo $($logDate) $localPath/$servIces/$servIces >>$logWrtng 2>&1
		
		echo "#!/bin/sh">$localPath/$servIces/$servIces
		echo "## $servIces   This shell script takes care of starting and stopping $servIces">>$localPath/$servIces/$servIces
		echo "# Source function library.">>$localPath/$servIces/$servIces
		echo ". /etc/rc.d/init.d/functions">>$localPath/$servIces/$servIces
		echo "#">>$localPath/$servIces/$servIces
		var="\$1">>$localPath/$servIces/$servIces
		echo "case \"$var\" in">>$localPath/$servIces/$servIces
		echo "start)">>$localPath/$servIces/$servIces
		echo "echo -n \"Starting $servIces: ">>$localPath/$servIces/$servIces
		echo "\"">>$localPath/$servIces/$servIces
		echo "$fndRnfl">>$localPath/$servIces/$servIces
		echo ";;">>$localPath/$servIces/$servIces
		echo "stop)">>$localPath/$servIces/$servIces
		echo "echo -n \"Stopping $servIces:">>$localPath/$servIces/$servIces
		echo "\"">>$localPath/$servIces/$servIces
		echo " $fndShfl">>$localPath/$servIces/$servIces
		echo "sleep 2">>$localPath/$servIces/$servIces
		echo ";;">>$localPath/$servIces/$servIces
		echo "restart)">>$localPath/$servIces/$servIces
		var="\$0">>$localPath/$servIces/$servIces
		echo "$var stop">>$localPath/$servIces/$servIces
		echo "$var start">>$localPath/$servIces/$servIces
		echo ";;">>$localPath/$servIces/$servIces
		echo "*)">>$localPath/$servIces/$servIces
		echo "echo \"Usage: $var {start|stop|restart}\"">>$localPath/$servIces/$servIces
		echo "exit 1">>$localPath/$servIces/$servIces
		echo "esac">>$localPath/$servIces/$servIces
		echo "exit 0">>$localPath/$servIces/$servIces
		
		>$localPath/$servIces/softlink.sh
		echo -e "cp $localPath/$servIces/$servIces /etc/rc.d/init.d/">>$localPath/$servIces/softlink.sh
		echo -e "chmod 755 /etc/rc.d/init.d/$servIces">>$localPath/$servIces/softlink.sh
		echo -e "chmod 755 $fndRnfl">>$localPath/$servIces/softlink.sh
		echo -e "chmod 755 $fndShfl">>$localPath/$servIces/softlink.sh
		echo -e "ln -s ../init.d/$servIces /etc/rc.d/rc3.d/S99$servIces">>$localPath/$servIces/softlink.sh
		echo -e "ln -s ../init.d/$servIces /etc/rc.d/rc5.d/S99$servIces">>$localPath/$servIces/softlink.sh
		echo -e "ln -s ../init.d/$servIces /etc/rc.d/rc0.d/K10$servIces">>$localPath/$servIces/softlink.sh
		echo -e "ln -s ../init.d/$servIces /etc/rc.d/rc6.d/K10$servIces">>$localPath/$servIces/softlink.sh
	fi
done
}
function newTomcatBackUp(){
	echo "dbsRdable=\$(date +%Y_%m_%d_%H_%M_%S)" >> $tomcatBckUp
	echo "jktLoc=\$(find $localPath/ -name jakarta*7.0.61 | grep -m 1 "$localPath/jakarta")" >> $tomcatBckUp
	echo "if [ -z \$jktLoc ];then" >> $tomcatBckUp
	echo "	echo \"No Tomcat Found\"" >> $tomcatBckUp
	echo "else" >> $tomcatBckUp
	echo "	service tomcat stop" >> $tomcatBckUp
	echo "	service tomcat stop" >> $tomcatBckUp
	echo "	kill -9 \$(lsof -i :80 -t)" >> $tomcatBckUp
	echo "	mv \$jktLoc \$jktLoc\_\$dbsRdable" >> $tomcatBckUp
	echo "fi" >> $tomcatBckUp
	ssh -o ControlPath=$SSHSOCKET -p $nSrvrPrt $nSrvrUsr@$nSrvrIP "bash -s" -- < $tomcatBckUp >>$logWrtng 2>&1;
}
fn_srvJDK(){
	for i in $(cat $listofshift);do
		fndRnfl=$(find $localPath/$i/ -name run*.sh)
		cat $fndRnfl | grep jdk  | gawk -F"/bin/java" '{print $1}' | gawk -F'/' '{print $NF}' >> $resourcePath/jdkList;
	done
	for jdkVar in $(sort -u $resourcePath/jdkList);do
		echo $jdkVar;
		chkJDKNewSrvr=($(ssh -o ControlPath=$SSHSOCKET -p $nSrvrPrt $nSrvrUsr@$nSrvrIP "ls /usr/ | grep $jdkVar"));
		if [ -z $chkJDKNewSrvr ];then
			echo "$jdkVar not found";
			echo "Taking $jdkVar to new server";
			echo "$($logDate) Taking $jdkVar to new server" >>$logWrtng 2>&1;
			#rsync -chavzPq --update -vv --log-file=$resourcePath/rSync$jdkVar.log -e "$rSncPort" /usr/$jdkVar $nSrvrUsr@$nSrvrIP:/usr/ >>$logWrtng 2>&1 &
			
			declare -i rSyncJDKStat=1;
			while [ $rSyncJDKStat -ne 0 ];do
				echo $rSncPort >>$logWrtng 2>&1;
				rsync -chavzPq --update -vv --log-file=$resourcePath/rSync$jdkVar.log -e "$rSncPort" /usr/$jdkVar $nSrvrUsr@$nSrvrIP:/usr/ >>$logWrtng 2>&1 &
				
				echo $! > proCess;
				prcsID=$(cat proCess);
				#Checking if processes are still running or completed
				prcsAlive=$(lsof -tp $prcsID);
				until [ -z $prcsAlive ];do
					#echo -e "${Purple}The process $prcsAlive is still going on${NC}"
					echo -e "${Purple}$($logDate) The process $prcsAlive is still going on${NC}" >>$logWrtng 2>&1
					sleep 5;
					prcsAlive=$(lsof -tp $prcsID);
				done
				rSyncStatus=$(tail -n 1 $resourcePath/rSync$jdkVar.log | grep "_exit_cleanup" | gawk -F"about to call exit[(]" '{print $2}' | gawk -F"[)]" '{print $1}')
				
				echo $rSyncStatus >>$logWrtng 2>&1
				if [ $rSyncStatus -eq 0 ];then
					echo -e "${BPurple}$($logDate) Shifting of $jdkVar service is successful${NC}" >>$logWrtng 2>&1;
					echo -e "${BPurple}Shifting of $jdkVar service is successful${NC}";
					rSyncJDKStat=0
				else
					echo -e "${BRed}$($logDate) Shifting of $jdkVar service was unsuccessful${NC}" >>$logWrtng 2>&1;
					echo -e "${BRed}Shifting of $jdkVar service was unsuccessful${NC}";
					rSyncJDKStat=1
				fi
			done
		else
			echo $chkJDKNewSrvr;
			echo "$jdkVar Already exists";
			echo "$($logDate) $jdkVar Already exists" >>$logWrtng 2>&1;
		fi
	done
}
function preShiftProc(){
if [ $srvChkClear -eq 1 ] && [ $dbChkClear -eq 1 ];then
	cRntMnth=$($mysqlPass --skip-column-name -e"select unix_timestamp(now())/(60*60*24*30) as thisMonth;" | cut -f1 | gawk -F. '{print $1}');
	for dbSList in $(cat $dbs);do
		#echo $dbSList;
		#echo $nSrvrPrt $oldMySQLDir$dbSList  $nSrvrUsr@$nSrvrIP:$newMySQLDir
		if [[ $dbSList =~ ^Failed ]]; 
			then 
				echo -e "${BBlue}Do you want to skip Old Failed CDR for $dbSList: ${NC}";
				read yorn;
				if [ $yorn == y ] || [ $yorn == Y ] || [ $yorn == YES ] || [ $yorn == yes ];then
					echo -e "$($logDate) ${BRed}Copying except old Failed CDR${NC}" >>$logWrtng 2>&1;
					echo -e "${BRed}Copying except old Failed CDR${NC}";
					echo 0 > $keepOldTables$dbSList;
					declare -i rSyncFldDB=1;
					while [ $rSyncFldDB -ne 0 ];do
						echo $($logDate) $rSncPort >>$logWrtng 2>&1;
						rsync -chavzPq --update --exclude 'vb*_*' -vv --log-file=$resourcePath/rSyncDB$dbSList.log -e "$rSncPort" $oldMySQLDir/$dbSList/ $nSrvrUsr@$nSrvrIP:$newMySQLDir/$dbSList >>$logWrtng 2>&1 &
						echo $! > proCess;
						prcsID=$(cat proCess);
						#Checking if processes are still running or completed
						prcsAlive=$(lsof -tp $prcsID);
						until [ -z $prcsAlive ];do
							#echo "The process $prcsAlive is still going on"
							echo "$($logDate) The process $prcsAlive is still going on" >>$logWrtng 2>&1
							sleep 5;
							prcsAlive=$(lsof -tp $prcsID);
						done
						rSyncStatus=$(tail -n 1 $resourcePath/rSyncDB$dbSList.log | grep "_exit_cleanup" | gawk -F"about to call exit[(]" '{print $2}' | gawk -F"[)]" '{print $1}')
						echo $($logDate) $rSyncStatus >>$logWrtng 2>&1
						if [ $rSyncStatus -eq 0 ];then
							ssh -o ControlPath=$SSHSOCKET -p $nSrvrPrt $nSrvrUsr@$nSrvrIP "chown -R mysql:mysql $newMySQLDir/$dbSList;chgrp mysql $newMySQLDir/$dbSList" >>$logWrtng 2>&1 &
							echo -e "${BPurple}$($logDate) Shifting of $dbSList database is successful${NC}" >>$logWrtng 2>&1;
							echo -e "${BPurple}Shifting of $dbSList database is successful${NC}";
							rSyncFldDB=0
						else
							echo -e "${BRed}$($logDate) Shifting of $dbSList database was unsuccessful${NC}" >>$logWrtng 2>&1;
							echo -e "${BRed}Shifting of $dbSList database was unsuccessful${NC}";
							rSyncFldDB=1
						fi
					done
				else
					echo -e "$($logDate) ${BRed}$($logDate) Keeping Old Failed CDR${NC}" >>$logWrtng 2>&1;
					echo -e "${BRed}Keeping Old Failed CDR${NC}";
					echo 1 > $keepOldTables$dbSList;
					declare -i rSyncFldDB=1;
					while [ $rSyncFldDB -ne 0 ];do
						echo $($logDate) $rSncPort >>$logWrtng 2>&1;
						rsync -chavzPq --update -vv --log-file=$resourcePath/rSyncDB$dbSList.log -e "$rSncPort" $oldMySQLDir/$dbSList/ $nSrvrUsr@$nSrvrIP:$newMySQLDir/$dbSList >>$logWrtng 2>&1 &
						echo $! > proCess;
						prcsID=$(cat proCess);
						#Checking if processes are still running or completed
						prcsAlive=$(lsof -tp $prcsID);
						until [ -z $prcsAlive ];do
							#echo "The process $prcsAlive is still going on"
							echo "$($logDate) The process $prcsAlive is still going on" >>$logWrtng 2>&1
							sleep 5;
							prcsAlive=$(lsof -tp $prcsID);
						done
						rSyncStatus=$(tail -n 1 $resourcePath/rSyncDB$dbSList.log | grep "_exit_cleanup" | gawk -F"about to call exit[(]" '{print $2}' | gawk -F"[)]" '{print $1}')
						echo $($logDate) $rSyncStatus >>$logWrtng 2>&1
						if [ $rSyncStatus -eq 0 ];then
							ssh -o ControlPath=$SSHSOCKET -p $nSrvrPrt $nSrvrUsr@$nSrvrIP "chown -R mysql:mysql $newMySQLDir/$dbSList;chgrp mysql $newMySQLDir/$dbSList" >>$logWrtng 2>&1 &
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
			#scp -o ControlPath=$SSHSOCKET  -rP $nSrvrPrt $oldMySQLDir/$dbSList  $nSrvrUsr@$nSrvrIP:$newMySQLDir/
			#ssh -o ControlPath=$SSHSOCKET -p $nSrvrPrt $nSrvrUsr@$nSrvrIP "chown -R mysql:mysql $newMySQLDir$dbSList;chgrp mysql $newMySQLDir/$dbSList"
			declare -i rSyncSccsDB=1;
			while [ $rSyncSccsDB -ne 0 ];do
				echo $($logDate) $rSncPort >>$logWrtng 2>&1;
				rsync -chavzPq --update --exclude "vb*_$cRntMnth*" -vv --log-file=$resourcePath/rSyncDB$dbSList.log -e "$rSncPort" $oldMySQLDir/$dbSList/ $nSrvrUsr@$nSrvrIP:$newMySQLDir/$dbSList >>$logWrtng 2>&1 &
				#rsync -chavzPq --update -vv --log-file=$resourcePath/rSyncDB$dbSList.log -e "$rSncPort" $oldMySQLDir/$dbSList/ $nSrvrUsr@$nSrvrIP:$newMySQLDir/$dbSList >>$logWrtng 2>&1 &
				echo $! > proCess;
				prcsID=$(cat proCess);
				#Checking if processes are still running or completed
				prcsAlive=$(lsof -tp $prcsID);
				until [ -z $prcsAlive ];do
					#echo "The process $prcsAlive is still going on"
					echo "$($logDate) The process $prcsAlive is still going on" >>$logWrtng 2>&1
					sleep 5;
					prcsAlive=$(lsof -tp $prcsID);
				done
				rSyncStatus=$(tail -n 1 $resourcePath/rSyncDB$dbSList.log | grep "_exit_cleanup" | gawk -F"about to call exit[(]" '{print $2}' | gawk -F"[)]" '{print $1}')
				echo $rSyncStatus >>$logWrtng 2>&1
				if [ $rSyncStatus -eq 0 ];then
					ssh -o ControlPath=$SSHSOCKET -p $nSrvrPrt $nSrvrUsr@$nSrvrIP "chown -R mysql:mysql $newMySQLDir/$dbSList;chgrp mysql $newMySQLDir/$dbSList" >>$logWrtng 2>&1 &
					echo -e "${BPurple}$($logDate) Shifting of $dbSList database is successful${NC}" >>$logWrtng 2>&1;
					echo -e "${BPurple}Shifting of $dbSList database is successful${NC}";
					rSyncSccsDB=0
				else
					echo -e "${BRed}$($logDate) Shifting of $dbSList database was unsuccessful${NC}" >>$logWrtng 2>&1;
					echo -e "${BRed}Shifting of $dbSList database was unsuccessful${NC}";
					rSyncSccsDB=1
				fi
			done
		elif [[ "$dbSList" =~ ^BalanceServer ]];
			then
			declare -i rSyncSmsBlncDB=1;
			while [ $rSyncSmsBlncDB -ne 0 ];do
				echo $($logDate) $rSncPort >>$logWrtng 2>&1;
				rsync -chavzPq --update -vv --log-file=$resourcePath/rSyncDB$dbSList.log -e "$rSncPort" $oldMySQLDir/$dbSList/ $nSrvrUsr@$nSrvrIP:$newMySQLDir/$dbSList >>$logWrtng 2>&1 &
				echo $! > proCess;
				prcsID=$(cat proCess);
				#Checking if processes are still running or completed
				prcsAlive=$(lsof -tp $prcsID);
				until [ -z $prcsAlive ];do
					#echo "The process $prcsAlive is still going on"
					echo "$($logDate) The process $prcsAlive is still going on" >>$logWrtng 2>&1
					sleep 5;
					prcsAlive=$(lsof -tp $prcsID);
				done
				rSyncStatus=$(tail -n 1 $resourcePath/rSyncDB$dbSList.log | grep "_exit_cleanup" | gawk -F"about to call exit[(]" '{print $2}' | gawk -F"[)]" '{print $1}')
				echo $($logDate) $rSyncStatus >>$logWrtng 2>&1
				if [ $rSyncStatus -eq 0 ];then
					ssh -o ControlPath=$SSHSOCKET -p $nSrvrPrt $nSrvrUsr@$nSrvrIP "chown -R mysql:mysql $newMySQLDir/$dbSList;chgrp mysql $newMySQLDir/$dbSList" >>$logWrtng 2>&1 &
					echo -e "${BPurple}$($logDate) Shifting of $dbSList database is successful" >>$logWrtng 2>&1;
					echo -e "${BPurple}Shifting of $dbSList database is successful";
					rSyncSmsBlncDB=0
				else
					echo -e "${BRed}$($logDate) Shifting of $dbSList database was unsuccessful${NC}" >>$logWrtng 2>&1;
					echo -e "${BRed}Shifting of $dbSList database was unsuccessful${NC}";
					rSyncSmsBlncDB=1
				fi
			done
		
		elif [[ "$dbSList" =~ ^iTelBilling ]] || [[ "$dbSList" =~ ^SMS ]]; #Task Need to check successful works fine or not. - Done
			then
			echo -e "$($logDate) ${BRed}$($logDate) Not taking $dbSList database${NC}" >>$logWrtng 2>&1
			echo -e "${BRed}Not taking $dbSList database${NC}"	
		else
			echo -e "$($logDate) ${BRed}$($logDate) Not taking $dbSList database${NC}" >>$logWrtng 2>&1
			echo -e "${BRed}Not taking $dbSList database${NC}"
		fi
	done
	rm -f $resourcePath/rSyncDB*.log
		
	#Check and re-sync services
	###################RSync Service Starts############
	declare -a procServices=();
	declare -a procIDS=();
	##########################
	#Including services into array
	for i in $(cat $listofshift );do
		#echo $i;
		procServices+=($i);
	done
	echo ${procServices[@]} 
	echo $($logDate) ${#procServices[@]} >>$logWrtng 2>&1
	#Syncing files 
	while [ ${#procServices[@]} -ne 0 ];do
		echo ${#procServices[@]};
		for (( i=0; i<${#procServices[@]}; i++ ));do
			if [ -z ${procServices[i]} ];then
				echo "Nothing to shift"
				echo "$($logDate) Nothing to shift" >>$logWrtng 2>&1
				#Task - Need to check if the running switch signaling is shifted fine or not
			elif [[ "${procServices[i]}" =~ ^iTelSwitchPlusSignaling ]];then
				cRntMnth=$($mysqlPass --skip-column-name -e"select unix_timestamp(now())/(60*60*24*30) as thisMonth;" | cut -f1 | gawk -F. '{print $1}');
				echo $cRntMnth
				echo $SSHSOCKET >>$logWrtng 2>&1;
				echo $rSncPort >>$logWrtng 2>&1;
				echo $($logDate) ${procServices[i]} >>$logWrtng 2>&1;
				
				dbSListF=$(cat $localPath/${procServices[i]}/DatabaseConnection_Failed.xml | grep "mysql:/" | gawk -F"///" '{print $2}' | gawk -F"\"" '{print $1}')
				if [ -z $dbSListF ];then
				dbSListF=$(cat $localPath/${procServices[i]}/DatabaseConnection_Failed.xml | grep "mysql:/" | gawk -F"//" '{print $2}' | gawk -F"\"" '{print $1}' | gawk -F"/" '{print $2}')
				fi
				OldFldTables=$(cat $keepOldTables$dbSListF);
				echo $keepOldTables$dbSListF $OldFldTables >>$logWrtng 2>&1;
				if [ $OldFldTables == 1 ];then
					#sigDiskUsg=$(du -sh $localPath/${procServices[i]} --exclude="debugAndC*" --exclude="successfulSQLCSV*" --exclude="bill/*");
					sigDiskUsg=$(du -sh $localPath/${procServices[i]} --exclude "*.log*" --exclude "debugAndCdrCSV*/vb*$cRntMnth.*" --exclude "successfulSQLCSV*/vb*$cRntMnth.*");
					echo -e "${BBlue}Signaling directory size is $sigDiskUsg ${NC}"; echo -e "${BBlue}Signaling directory size is $sigDiskUsg ${NC}">>$logWrtng 2>&1
					
					rsync -chavzPq --update -vv --exclude "*.log*" --exclude "bill/*" --exclude "debugAndCdrCSV/*" --exclude "debugAndCdrCSV_Processed/*" --exclude "successfulSQLCSV/*" --exclude "successfulSQLCSV_Processed/*" --log-file=$resourcePath/rSync${procServices[i]}.log -e "$rSncPort" $localPath/${procServices[i]} $nSrvrUsr@$nSrvrIP:$localPath/ >>$logWrtng 2>&1 &
					
					echo $! > proCess;
					procIDS+=($(cat proCess));
				else
					sigDiskUsg=$(du -sh $localPath/${procServices[i]} --exclude "*.log*" --exclude "bill/*" --exclude "debugAndCdrCSV/*" --exclude "debugAndCdrCSV_Processed/*" --exclude "successfulSQLCSV/*" --exclude "successfulSQLCSV_Processed/*");
					echo -e "${BBlue}Signaling directory size is $sigDiskUsg ${NC}"; echo -e "${BBlue}Signaling directory size is $sigDiskUsg ${NC}">>$logWrtng 2>&1
					
					rsync -chavzPq --update -vv --exclude "*.log*" --exclude "bill/*" --exclude "debugAndCdrCSV/*" --exclude "debugAndCdrCSV_Processed/*" --exclude "successfulSQLCSV/*" --exclude "successfulSQLCSV_Processed/*" --log-file=$resourcePath/rSync${procServices[i]}.log -e "$rSncPort" $localPath/${procServices[i]} $nSrvrUsr@$nSrvrIP:$localPath/ >>$logWrtng 2>&1 &
					
					echo $! > proCess;
					procIDS+=($(cat proCess));
				fi
			else
				echo $SSHSOCKET >>$logWrtng 2>&1;
				echo $rSncPort >>$logWrtng 2>&1;
				echo $($logDate) ${procServices[i]} >>$logWrtng 2>&1;
				rsync -chavzPq --update -vv --exclude '*.log.*' --exclude 'logs/*' --log-file=$resourcePath/rSync${procServices[i]}.log -e "$rSncPort" $localPath/${procServices[i]} $nSrvrUsr@$nSrvrIP:$localPath/ >>$logWrtng 2>&1 &
				echo $! > proCess;
				procIDS+=($(cat proCess));
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
					rm -f $i;
					#mv $resourcePath/$i /$i_$(date +%s)	#Task need to remove this
				else
					echo -e "${BRed}$($logDate) Shifting of $serviceName service was unsuccessful${NC}" >>$logWrtng 2>&1;
					echo -e "${BRed}Shifting of $serviceName service was unsuccessful${NC}";
					procServices+=($serviceName);
			fi
		done
	done
	echo ${#procServices[@]}
	rm -f rSync*.log
		###################RSync Service Ends#########
		#		for srvSList in $(cat $listofshift);do
		#			echo -e "---------------------------------------------" >>$logWrtng 2>&1;
		#			echo $($logDate) $srvSList >>$logWrtng 2>&1;
		#			echo -e "---------------------------------------------" >>$logWrtng 2>&1;
		#			scp -o ControlPath=$SSHSOCKET  -rP $nSrvrPrt $localPath/$srvSList  $nSrvrUsr@$nSrvrIP:$localPath/
		#		done
		#		for srvSList in $(cat $listofshift);do
		#			echo -e "---------------------------------------------" >>$logWrtng 2>&1;
		#			echo $($logDate) $srvSList >>$logWrtng 2>&1;
		#			echo -e "---------------------------------------------" >>$logWrtng 2>&1;
		#			ssh -o ControlPath=$SSHSOCKET -p $nSrvrPrt $nSrvrUsr@$nSrvrIP "cd $localPath/$srvSList && sh softlink.sh"
		#		done
		#Change Server IP
		echo -e "---------------------------------------------" >>$logWrtng 2>&1;
		echo -e "$($logDate) Configuring New IP in the services" >>$logWrtng 2>&1;
		echo -e "---------------------------------------------" >>$logWrtng 2>&1;
		#Task - Need to check if connection losses
		declare -i ipConfigured=0;
		while [ $ipConfigured -eq 0 ];do
			ssh -o ControlPath=$SSHSOCKET -p $nSrvrPrt $nSrvrUsr@$nSrvrIP "bash -s" -- < $configNewIP >>$logWrtng 2>&1 && ipConfigured=1 || ipConfigured=0;
			
			if [ $ipConfigured == 0 ];then
				echo -e "${BRed}IP or softlink configuration failed! Do you want to do this manually? ${NC}";
				read yorn;
				if [ $yorn == y ] || [ $yorn == Y ] || [ $yorn == YES ] || [ $yorn == yes ];then
					ipConfigured=1;
				else
					ipConfigured=0;
				fi
			fi
		done
		#Task: copy JDK to new server - 
		fn_srvJDK;
		
		#Task: send old tomcat to new server - Done
		jktLocOld=$(find $localPath/ -name jakarta*7.0.61 | grep -m 1 "$localPath/jakarta")
		echo "jktLocOld:$jktLocOld" >> $varList
		echo $($logDate) $jktLocOld  >>$logWrtng 2>&1;
		if [ -z $jktLocOld ];then
			echo -e "${BRed}$($logDate) No Tomcat Found${NC}" >>$logWrtng 2>&1;
			echo -e "${BRed}No Tomcat Found${NC}";
		else
			#Task: Backup new server tomcat - Done
			echo -en "${BBlue}Do you want to shift web/billing?: ${NC}"
				read yorn;
				if [ $yorn == y ] || [ $yorn == Y ] || [ $yorn == YES ] || [ $yorn == yes ]
				  then
				  echo -en "${BBlue}Did you remove all unnecessary logs from tomcat?: ${NC}"
					read yorn;
					if [ $yorn == y ] || [ $yorn == Y ] || [ $yorn == YES ] || [ $yorn == yes ]
						then
						echo -e "${BGreen}$($logDate) Shifting billing/web${NC}" >>$logWrtng 2>&1;
						echo -e "${BGreen}Thanks for the information. Shifting billing/web${NC}"
					else
						echo -e "${BRed}$($logDate) Taking full webserver${NC}" >>$logWrtng 2>&1;
						echo -e "${BRed}Taking full webserver${NC}"
					fi
					newTomcatBackUp
					#Syncing files 
					declare -i rSyncTomcatStat=1;
					while [ $rSyncTomcatStat -ne 0 ];do
						echo $rSncPort >>$logWrtng 2>&1;
						rsync -chavzPq --update -vv --log-file=$resourcePath/rSyncTomcat.log --exclude 'logs/catalina.*' --exclude 'logs/host-manager.*' --exclude 'logs/localhost.*' --exclude 'logs/localhost_access_log.*' --exclude 'logs/localhost.*' --exclude 'logs/manager.*' -e "$rSncPort" $jktLocOld $nSrvrUsr@$nSrvrIP:$localPath/ >>$logWrtng 2>&1 &
						echo $! > proCess;
						prcsID=$(cat proCess);
						
						#Checking if processes are still running or completed
						
						prcsAlive=$(lsof -tp $prcsID);
						until [ -z $prcsAlive ];do
							#echo -e "${Purple}The process $prcsAlive is still going on${NC}"
							echo -e "${Purple}$($logDate) The process $prcsAlive is still going on${NC}" >>$logWrtng 2>&1
							sleep 5;
							prcsAlive=$(lsof -tp $prcsID);
						done
						
						rSyncStatus=$(tail -n 1 $resourcePath/rSyncTomcat.log | grep "_exit_cleanup" | gawk -F"about to call exit[(]" '{print $2}' | gawk -F"[)]" '{print $1}')
						serviceName="Tomcat"
						echo $rSyncStatus >>$logWrtng 2>&1
						if [ $rSyncStatus -eq 0 ];then
							echo -e "${BPurple}$($logDate) Shifting of $serviceName service is successful${NC}" >>$logWrtng 2>&1;
							echo -e "${BPurple}Shifting of $serviceName service is successful${NC}";
							rSyncTomcatStat=0
						else
							echo -e "${BRed}$($logDate) Shifting of $serviceName service was unsuccessful${NC}" >>$logWrtng 2>&1;
							echo -e "${BRed}Shifting of $serviceName service was unsuccessful${NC}";
							rSyncTomcatStat=1
						fi
					done
				else
					echo -e "${BRed}$($logDate) Not shifting billing/web${NC}" >>$logWrtng 2>&1;
					echo -e "${BRed}Not shifting billing/web${NC}"
			fi
			#rsync -chavzPq --update -vv --log-file=$resourcePath/rSyncTomcat.log -e "$rSncPort" $jktLocOld $nSrvrUsr@$nSrvrIP:$localPath/ &
			# >>$logWrtng 2>&1
			#scp -o ControlPath=$SSHSOCKET  -rP $nSrvrPrt $jktLocOld  $nSrvrUsr@$nSrvrIP:$localPath/ >>$logWrtng 2>&1
		fi
	
	else
		exit;
fi
}
###########################
#Initiation of PreShiftTask
###########################
pwd > $localPath/src/scrptLoc
#System Check
#fn_arch
#fn_ipv6
#fn_file_limit
#fn_selinux
#fn_setup
#Command Check
fn_scp
fn_lsof
fn_zip
fn_unzip
fn_crnTbs
fn_rSync
#Required tools installation
#fn_my_dot_cnf
#fn_mysql
#fn_jdk
#Task - list of all variables to be used in new server.
function fn_varList(){
echo "localPath:$localPath" >> $varList
echo "resourcePath:$resourcePath" >> $varList
echo "dbs:$dbs" >> $varList
echo "listofshift:$listofshift" >> $varList
echo "oSrvr:$oSrvrIP $oSrvrUsr $oSrvrPrt" >> $varList
echo "nSrvr:$nSrvrIP $nSrvrUsr $nSrvrPrt" >> $varList
echo "mysqlPass:$mysqlPass" >> $varList
echo "newMysqlPass:$newMysqlPass" >> $varList
echo "logWrtng:$logWrtng" >> $varList
echo "oldMySQLDir:$oldMySQLDir" >> $varList
echo "newMySQLDir:$newMySQLDir" >> $varList
echo "rSncPort:\"ssh -o ControlPath=\$SSHSOCKET -p $nSrvrPrt\"" >> $varList
echo "varBilling:$varBilling" >> $varList
echo "var_sales_email:$var_sales_email" >> $varList
echo "email:$email" >> $varList
}
echo -e "${Purple}Required commands installed - ${instlld[@]}${NC}";
clear;
declare -i ipRstriction=0;
while [ $ipRstriction -eq 0 ];do
	echo -e "${BRed}Please make sure the new server has no IP restriction${NC}";
	echo -en "${BBlue}Is the IP restriction disabled in new server? (y/n): ${NC}";
	read ipAlowd;
	if [ $ipAlowd == y ] || [ $ipAlowd == Y ] || [ $ipAlowd == YES ] || [ $ipAlowd == yes ];then
		echo -e "${Green}Proceeding to next step${NC}";
		ipRstriction=1;
		
		#Task: Get all the inputs
		fn_input;
		#Task: Establishing Connection - Done
		fn_Con;
		date +%s > $resourcePath/initate
		fn_mysqlInfo
		#oldMySQLDir=$($mysqlPass -e "show variables like 'datadir'\G" | grep -w "Value" | gawk '{ print $2 }');
		newMySQLDir=$(ssh -o ControlPath=$SSHSOCKET -p $nSrvrPrt  $nSrvrUsr@$nSrvrIP "$newMysqlPass --skip-column-name -e\"select VARIABLE_VALUE from information_schema.global_variables where VARIABLE_NAME like 'datadir'\"")
		if [ -z $newMySQLDir ];then
			echo "Setting default MySQL Directory at variable" >>$logWrtng 2>&1;
			echo "Setting default MySQL Directory at variable";
			newMySQLDir='/var/lib/mysql'
		fi
		echo $newMySQLDir >>$logWrtng 2>&1;
		
		cRntMnth=$($mysqlPass --skip-column-name -e"select unix_timestamp(now())/(60*60*24*30) as thisMonth;" | cut -f1 | gawk -F. '{print $1}');
		###################################################
		#Task - Need to set running service in new server before time setup
		#fn_time_zone;
				
		echo -e "${Green}Checking and preparing required services in the new server${NC}" >>$logWrtng 2>&1;
		echo -e "${Green}Checking and preparing required services in the new server${NC}"
		echo -e "mkdir -p $resourcePath;" >$chkNwSrv
		echo -e "cd $resourcePath;">>$chkNwSrv
		echo -e "rm -f newSrvPrep;">>$chkNwSrv
		echo -e "wget http://149.20.186.19/downloads/shifT/newSrvPrep">>$chkNwSrv
		echo -e "chmod a+x newSrvPrep;">>$chkNwSrv
		echo -e "./newSrvPrep;">>$chkNwSrv
		chmod a+x $chkNwSrv
		
		ssh -o ControlPath=$SSHSOCKET -p $nSrvrPrt $nSrvrUsr@$nSrvrIP "bash -s" -- < $chkNwSrv >>$logWrtng 2>&1;
		echo -e "${Green}New Server and Checkup Complete${NC}" >>$logWrtng 2>&1;
		echo -e "${Green}New Server and Checkup Complete${NC}"
		
		declare -a runngSrvcs=();
		#for i in $(ls $localPath/ | grep CreditCardServer) $(ls $localPath/ | grep iTelBilling) $(ls $localPath/ | grep iTelAutoSignUp) $(ls $localPath/ | grep iTelDataBackup) $(ls $localPath/ | grep iTelSwitchPlusMediaProxy) $(ls $localPath/ | grep iTelSwitchPlusSignaling) $(ls $localPath/ | grep MobileBilling) $(ls $localPath/ | grep MoneyTransfer) $(ls $localPath/ | grep PaymentServer) $(ls $localPath/ | grep SMS_Server) $(ls $localPath/ | grep TopUpServer);do
		for i in CreditCardServer iTelBilling iTelAutoSignUp iTelDataBackup iTelSwitchPlusMediaProxy iTelSwitchPlusSignaling MobileBilling MoneyTransfer PaymentServer SMS_Server TopUpServer;do
			
			chkSrvcNewSrvr=($(ssh -o ControlPath=$SSHSOCKET -p $nSrvrPrt $nSrvrUsr@$nSrvrIP "ls $localPath/ | grep $i"));
			if [ -z $chkSrvcNewSrvr ];then
				echo "$i not found";
			else
				#echo $chkSrvcNewSrvr;
				runngSrvcs+=($chkSrvcNewSrvr);
			fi
		done
		if [[ -z "${runngSrvcs[0]}" ]];then 
			echo -e "${BBlue}$($logDate) Continuing with the timezone setup${NC}" >> $logWrtng 2>&1
			echo -e "${BBlue}Continuing with the timezone setup${NC}";
			tmStClr=1;
			fn_time_zone;
		else
			echo -e "${BBlue}$($logDate) ${runngSrvcs[@]}${NC}\n${BRed}Above services are already running in the new server${NC}" >> $logWrtng 2>&1
			echo -e "${BBlue}${runngSrvcs[@]}${NC}\n${BRed}Above services are already running in the new server${NC}";
			tmStClr=0
			echo -e "${BRed}$($logDate) New time might impact existing services.\nDo you still want to continue with the time setup?${NC}" >> $logWrtng 2>&1
			echo -e "${BRed}New time might impact existing services.\nDo you still want to continue with the time setup?${NC}";
			read yorn;
			if [ $yorn == y ] || [ $yorn == Y ] || [ $yorn == YES ] || [ $yorn == yes ];then
				echo -e "${BBlue}$($logDate) Continuing with the timezone setup${NC}" >> $logWrtng 2>&1
				echo -e "${BBlue}Continuing with the timezone setup${NC}"
				fn_time_zone;
			else
			   echo "$($logDate) Server date and time remain unchanged " >>$logWrtng 2>&1
			   echo -e "${BBlue}Date and time remain unchanged.${NC}"
			fi
		fi
		fn_varList;
		fn_SrvList;#2
		fn_DBList;#1
		fn_servicConf;
		preShiftProc;
		echo -e "${BBlue}Shifting took $((($(date +%s) - $(cat $resourcePath/initate))/60)) min${NC}"
		echo -e "${BBlue}$($logDate) Shifting took $((($(date +%s) - $(cat $resourcePath/initate))/60)) min${NC}" >>$logWrtng 2>&1;
	else
		echo "";
		echo "";
		echo -e "${BRed}Please disable IP restriction first${NC}";
		echo "";
		echo "";
		ipRstriction=0;
	fi
done
history -c
scrptLoc=$(cat $localPath/src/scrptLoc);
cd $scrptLoc;
rm -f $script
ssh -S $SSHSOCKET -O exit -p $nSrvrPrt $nSrvrUsr@$nSrvrIP >>$logWrtng 2>&1
