

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

#echo -e "${RED}This is red text${RESET}"
#echo -e "${GREEN}This is green text${RESET}"
#echo -e "${YELLOW}This is yellow text${RESET}"
#echo "This is default text"



echo -e "${YELLOW}Do you want to Replace DiskSpaceCheker MailServer Port${RESET}"

echo -e "1. ${GREEN}Yes${RESET}"
echo -e "2. ${RED}No${RESET}"


read option


if [[ $option = '1' ]]; then

cd /usr/local/DiskSpaceChecker

#vi email_properties


line_number=6
new_line="MailSeverPort=587"

sed -i "${line_number}s/.*/${new_line}/" email_properties
ex -sc "x" email_properties

sh /usr/local/DiskSpaceChecker/shutdownDiskSpaceChecker.sh
sh /usr/local/DiskSpaceChecker/shutdownDiskSpaceChecker.sh
sh /usr/local/DiskSpaceChecker/shutdownDiskSpaceChecker.sh

sleep 3

sh /usr/local/DiskSpaceChecker/runDiskSpaceChecker.sh

sleep 2

cat email_properties

else
echo Failed
fi
