#!/bin/bash
cd /usr/local/apache-tomcat-7.0.59/webapps/
ls
today=$(date '+%Y%m%d')
echo "$today"
echo "Please Select Your Billing And Paste It Here: "
read billing
cd /usr/local/apache-tomcat-7.0.59/webapps/$billing/sms/history
echo "----------Backup fetchLiveSMSLog.jsp---------- "
sleep 1
mv fetchLiveSMSLog.jsp fetchLiveSMSLog.jsp_$today
echo "Backup Done"
find fetchLiveSMSLog.jsp_$today
echo "New fetchLiveSMSLog.jsp Downloading......"
wget http://149.20.188.57/SMS_FILE/fetchLiveSMSLog.jsp.gz
gunzip fetchLiveSMSLog.jsp.gz
find fetchLiveSMSLog.jsp
echo "fetchLiveSMSLog.jsp Replace Done"
echo ""
echo "-------------------------------"
echo ""
cd /usr/local/apache-tomcat-7.0.59/webapps/$billing/sms/provider
echo "----------Backup testSMPPConnection.jsp---------- "
sleep 1
mv testSMPPConnection.jsp testSMPPConnection.jsp_$today
echo "Backup Done"
find testSMPPConnection.jsp_$today
echo "New testSMPPConnection.jsp Downloading......"
wget http://149.20.188.57/SMS_FILE/testSMPPConnection.jsp.gz
gunzip testSMPPConnection.jsp.gz
find testSMPPConnection.jsp
echo "testSMPPConnection.jsp Replace Done"
