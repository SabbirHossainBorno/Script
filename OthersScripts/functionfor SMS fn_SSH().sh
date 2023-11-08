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


--------------------------------------------------------------------
var_tomcat="8.0.1";



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

function fn_server_mem_status()
{
  echo "Server memory status: ";
  free -m;
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