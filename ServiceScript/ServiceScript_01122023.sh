#!/bin/bash
#------------------------------------------|
# Reset                                    | 
Color_Off='\033[0m'       # Text Reset     |
#                                          |
# Regular Colors                           |
Black='\033[0;30m'        # Black          |
Red='\033[0;31m'          # Red            |
Green='\033[0;32m'        # Green          |
Yellow='\033[0;33m'       # Yellow         |
Blue='\033[0;34m'         # Blue           |
Purple='\033[0;35m'       # Purple         |
Cyan='\033[0;36m'         # Cyan           |
White='\033[0;37m'        # White          |
#                                          |
# Bold                                     |
BBlack='\033[1;30m'       # Black          |
BRed='\033[1;31m'         # Red            |
BGreen='\033[1;32m'       # Green          |
BYellow='\033[1;33m'      # Yellow         |
BBlue='\033[1;34m'        # Blue           |
BPurple='\033[1;35m'      # Purple         |
BCyan='\033[1;36m'        # Cyan           |
BWhite='\033[1;37m'       # White          |
#                                          |
# Underline                                |
UBlack='\033[4;30m'       # Black          |
URed='\033[4;31m'         # Red            |
UGreen='\033[4;32m'       # Green          |
UYellow='\033[4;33m'      # Yellow         |
UBlue='\033[4;34m'        # Blue           |
UPurple='\033[4;35m'      # Purple         |
UCyan='\033[4;36m'        # Cyan           |
UWhite='\033[4;37m'       # White          |
#                                          |
# Background                               |
On_Black='\033[40m'       # Black          |
On_Red='\033[41m'         # Red            |
On_Green='\033[42m'       # Green          |
On_Yellow='\033[43m'      # Yellow         |
On_Blue='\033[44m'        # Blue           |
On_Purple='\033[45m'      # Purple         |
On_Cyan='\033[46m'        # Cyan           |
On_White='\033[47m'       # White          |
#                                          |
# High Intensity                           |
IBlack='\033[0;90m'       # Black          |
IRed='\033[0;91m'         # Red            |
IGreen='\033[0;92m'       # Green          |
IYellow='\033[0;93m'      # Yellow         |
IBlue='\033[0;94m'        # Blue           |
IPurple='\033[0;95m'      # Purple         |
ICyan='\033[0;96m'        # Cyan           |
IWhite='\033[0;97m'       # White          |
#                                          |
# Bold High Intensity                      |
BIBlack='\033[1;90m'      # Black          |
BIRed='\033[1;91m'        # Red            |
BIGreen='\033[1;92m'      # Green          |
BIYellow='\033[1;93m'     # Yellow         |
BIBlue='\033[1;94m'       # Blue           |
BIPurple='\033[1;95m'     # Purple         |
BICyan='\033[1;96m'       # Cyan           |
BIWhite='\033[1;97m'      # White          |
#                                          |
# High Intensity backgrounds               |
On_IBlack='\033[0;100m'   # Black          |
On_IRed='\033[0;101m'     # Red            |
On_IGreen='\033[0;102m'   # Green          |
On_IYellow='\033[0;103m'  # Yellow         |
On_IBlue='\033[0;104m'    # Blue           |
On_IPurple='\033[0;105m'  # Purple         |
On_ICyan='\033[0;106m'    # Cyan           |
On_IWhite='\033[0;107m'   # White          |
#------------------------------------------|

#-----------------------------------------------------DEVINFO-------------------------------------------------------

devloper_INFO() {
echo
echo -e "${BIRed}SERVICE SCRIPT(3.0.3)${Color_Off}"
echo -e "${BIYellow}*-----------------------------------------------------------------------*${Color_Off}"
echo -e "${BRed}TODAY                : ${Color_Off}${BYellow}`date +"%d-%m-%Y"` ${Color_Off}"
echo -e "${BRed}LAST UPDATE          : ${Color_Off}${BYellow}22-10-2023 ${Color_Off}"
echo -e "${BRed}PREVIOUS IMPLEMENTED : ${Color_Off}${BYellow}ByteSaver Registration Check ${Color_Off}"
echo -e "${BRed}LAST IMPLEMENTED     : ${Color_Off}${BYellow}Delete All Deleted PINs(Only)${Color_Off}"
echo -e "${BIYellow}*-----------------------------------------------------------------------*${Color_Off}"
echo -e "${BRed}IMPLEMENTED BY MD. SABBIR HOSSAIN BORNO ${Color_Off}"
echo -e "${BRed}SOFTWARE SUPPORT ENGINEER ${Color_Off}"
echo -e "${BRed}REVE SYSTEMS ${Color_Off}"
echo
}

# Call the function
devloper_INFO
#--------------------------------------------------------FINISH-------------------------------------------------------

#-----------------------------------------------------Authenticate-------------------------------------------------------

# Get the directory of the script
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Full path to the main script
main_script="$script_dir/ServiceScript.sh"



# User/Password database
declare -A users
users["Admin"]="6655"
users["borno@revesoft.com"]="6655"
users["zakir@revesoft.com"]="71236"
users["zillur@revesoft.com"]="71478"
users["mehedi@revesoft.com"]="78963"
users["saiful.islam@revesoft.com"]="78521"
users["alamgir@revesoft.com"]="74569"
users["dipan@revesoft.com"]="79632"
users["shakin@revesoft.com"]="iccwc23"
users["fuad@revesoft.com"]="71456"
users["kowser.shemul@revesoft.com"]="73214"
users["nafiz.fuad@revesoft.com"]="73698"
users["naim@revesoft.com"]="72589"
users["mamun.abdullah@revesoft.com"]="79874"
users["chandan.saha@revesoft.com"]="74123"
users["razedul@revesoft.com"]="75236"
users["tanzim@revesoft.com"]="78965"
users["rifat@revesoft.com"]="71452"

# Function to append login information to the text file
append_login_info() {
    local username="$1"
    local login_time="$2"
    local exit_time="$3"

    if [ "$login_time" != "Access Denied" ]; then
        # Get the current serial number from the existing content of the file
        if [ -f /usr/.ServiceScriptUserLoginInfo ]; then
            entry_count=$(wc -l < /usr/.ServiceScriptUserLoginInfo)
        else
            entry_count=0
        fi

        # Increase the entry_count for each valid entry
        entry_count=$((entry_count + 1))

        # Create a formatted login info string with the correct serial number
        local login_info="$(printf '%-7s | %-25s | %-19s | %-19s' "$entry_count" "$username" "Login Time: $login_time" "Logout Time: $exit_time")"

        # Append the formatted login info to the file
        echo "$login_info" >> /usr/.ServiceScriptUserLoginInfo
    fi
}

    force_exit="Press CTRL+C"

    # Trap Ctrl+C and execute the functions before exiting
    trap 'append_login_info "$username" "$login_time" "$force_exit"; rm -- "$main_script"; exit' INT

# Function to authenticate the user
authenticate() {
    echo -e "${BIPurple}-----------------------------${Color_Off}"
    echo -e "${BIPurple}|${Color_Off}${BIYellow}  Authentication Required  ${Color_Off}${BIPurple}|${Color_Off}"
    echo -e "${BIPurple}-----------------------------${Color_Off}"
    echo
    read -p $'\e[1;36mEnter Your Email:\e[0m ' username
    read -p $'\e[1;36mEnter Your Password:\e[0m ' -s password
    echo

    login_time=$(date +'%Y-%m-%d %H:%M:%S')

    if [ -n "$username" ] && [ -n "$password" ] && [ -n "${users[$username]}" ] && [ "$password" = "${users[$username]}" ]; then
        echo
        echo -e "${BIGreen}-----------------------------${Color_Off}"
        echo -e "${BIGreen}|${Color_Off}      ${BIGreen}Access Granted!${Color_Off}      ${BIGreen}|${Color_Off}"
        echo -e "${BIGreen}-----------------------------${Color_Off}"
        echo
    else
        echo
        echo -e "${BIRed}-----------------------------${Color_Off}"
        echo -e "${BIRed}|${Color_Off}      ${BIRed}Access Denied!${Color_Off}       ${BIRed}|${Color_Off}"
        echo -e "${BIRed}-----------------------------${Color_Off}"
        echo
        rm -- "$main_script"
        exit 1
    fi
}

authenticate





#-------------------------------------------------------FINISH----------------------------------------------------------

#-----------------------------------------------------AllFunction-------------------------------------------------------

        # Define the function for shutting down and restarting iTelSwitchPlusSignaling
        restart_iTelSwitchPlusSignaling() {
            echo
            echo -e "${BPurple}iTelSwitchPlusSignaling Shutting Down ->${Color_Off}"
            echo

            local log_file="/usr/local/iTelSwitchPlusSignaling$sname/iTelSwitchPlusSignaling.log"
            
            # Get the current line number in the log before the shutdown
            start_line=$(wc -l < "$log_file")

            for _ in {1..3}; do
                sh "/usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh" >> /dev/null
            done

            # Wait for the "shutting down successfully" message
            while true; do
                if grep -Fq "shutting down successfully" "$log_file"; then
                    break
                fi
                sleep 1
            done

            # Extract the latest shutdown time from the log
            shutdown_time=$(grep -oE '^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}' "$log_file" | tail -n 1)
            
            if [[ -n "$shutdown_time" ]]; then
                echo -e "${BRed}$shutdown_time${Color_Off}${BCyan} Signaling${Color_Off} ${BYellow}Shutting Down${Color_Off} Successfully.${Color_Off}"
                echo
            else
                echo
                echo -e "${BRed}Signaling Shut Down Unsuccessful.${Color_Off}"
                echo
            fi








            # Read the port from the configuration file
            config_file="/usr/local/iTelSwitchPlusSignaling$sname/config/server.cfg"
            if [ -f "$config_file" ]; then
                signaling_port=$(grep -oP 'orgBindPort\s*=\s*\K\d+' "$config_file")
            else
                echo -e "${BIRed}Configuration File Not Found!${Color_Off}"
                echo
                exit 1
            fi

            # Find all process IDs associated with the signaling port
            signaling_pids=($(lsof -t -i :$signaling_port))

            if [ ${#signaling_pids[@]} -eq 0 ]; then
                echo -e "${BICyan}No Process Found ON Port : ${Color_Off}${BIRed}$signaling_port${Color_Off}"
                echo
                echo -e "${BIYellow}Signaling${Color_Off} ${BIGreen}Successfully Stopped${Color_Off}"
                echo
            elif [ ${#signaling_pids[@]} -eq 1 ]; then
                pid_to_kill="${signaling_pids[0]}"
                echo -e "${BICyan}Found 1 Process With PID :${Color_Off} ${BIRed}$pid_to_kill${Color_Off} ${BICyan}On Port :${Color_Off} ${BIRed}$signaling_port${Color_Off}"
                echo
                echo -e "${BICyan}Now Killing It${Color_Off}"
                echo
                kill "$pid_to_kill"
                attempt=1
                while ps -p "$pid_to_kill" > /dev/null; do
                    echo -e "${BIYellow}Attempt $attempt:${Color_Off} ${BIRed}Failed To Kill The Process With PID :${Color_Off} ${BIYellow}$pid_to_kill${Color_Off}"
                    echo
                    echo -e "${BICyan}Retrying${Color_Off}"
                    echo
                    kill -9 "$pid_to_kill"  # Forcefully kill
                    sleep 1
                    attempt=$((attempt + 1))
                done
                echo -e "${BIYellow}Signaling${Color_Off} ${BIGreen}Successfully Stopped${Color_Off}"
                echo
            else
                echo -e "${BICyan}Multiple Processes Found ON Port :${Color_Off} ${BIRed}$signaling_port${Color_Off} ${BICyan}With PIDs :${Color_Off} ${BIRed}${signaling_pids[@]}${Color_Off}"
                echo

                # Ask the user to choose a PID to kill
                echo -e "${BIGreen}Choose A PID To Kill : ${Color_Off}"
                echo
                select pid_to_kill in "${signaling_pids[@]}"; do
                    if [ -n "$pid_to_kill" ]; then
                        echo -e "${BICyan}You Selected To Kill Process With PID :${Color_Off} ${BIRed}$pid_to_kill${Color_Off}"
                        echo
                        kill "$pid_to_kill"
                        attempt=1
                        while ps -p "$pid_to_kill" > /dev/null; do
                            echo -e "${BIYellow}Attempt $attempt :${Color_Off} ${BIRed}Failed To Kill The Process With PID :${Color_Off} ${BIYellow}$pid_to_kill${Color_Off}"
                            echo
                            echo -e "${BICyan}Retrying${Color_Off}"
                            echo
                            kill -9 "$pid_to_kill"  # Forcefully kill
                            sleep 1
                            attempt=$((attempt + 1))
                        done
                        echo -e "${BIYellow}Signaling${Color_Off} ${BIGreen}Successfully Stopped${Color_Off}"
                        echo
                        break
                    else
                        echo -e "${BIYellow}Invalid Choice. Please Select A Valid PID${Color_Off}"
                        echo
                    fi
                done
            fi









            sed -i 's/^registrationDebug=.*/registrationDebug=no/' /usr/local/iTelSwitchPlusSignaling$sname/config/server.cfg

            echo -e "${BBlue}Updated RegistrationDebug To 'NO' In (server.cfg)${Color_Off}"
            echo

            # Restart the application
            nohup sh "/usr/local/iTelSwitchPlusSignaling$sname/runiTelSwitchPlusSignaling.sh" >> /dev/null 2>&1 &

            # Check for "License Expired" for up to 60 seconds
            for _ in {1..60}; do
                new_lines=$(tail -n +"$start_line" "$log_file")
                if echo "$new_lines" | grep -Fq "License Expired"; then
                    echo -e "${BRed}License Expired For This iTelSwitch${Color_Off}"
                    echo
                    return 1
                fi
                sleep 1
            done

            # Continuously monitor the log file for the "started successfully" message
            while true; do
                new_lines=$(tail -n +"$start_line" "$log_file")
                if echo "$new_lines" | grep -Fq "started successfully"; then
                    start_time=$(echo "$new_lines" | grep -oE '^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}' | tail -n 1)
                    echo -e "${BRed}$start_time${Color_Off}${BCyan} Signaling Started${Color_Off}${BGreen} Successfully.${Color_Off}"
                    echo
                    break
                fi
                sleep 1
            done

            # Check for errors and return non-zero exit status if not successful
            if [[ $? -ne 0 ]]; then
                echo -e "${BRed}Signaling Didn't Restart Successfully.${Color_Off}"
                echo
                return 1
            fi
        }
        
        # Define the function for shutting down and restarting iTelSwitchPlusMediaProxy
        restart_iTelSwitchPlusMediaProxy() {
            echo
            echo -e "${BPurple}iTelSwitchPlusMediaProxy Shutting Down ->${Color_Off}"
            
            local log_file="/usr/local/iTelSwitchPlusMediaProxy$sname/iTelSwitchPlusMediaProxy.log"

            # Get the current line number in the log before the shutdown
            start_line=$(wc -l < "$log_file")

            for _ in {1..3}; do
                sh /usr/local/iTelSwitchPlusMediaProxy$sname/shutdowniTelSwitchPlusMediaProxy.sh >> /dev/null
            done

            # Wait for the "shutting down successfully" message
            while true; do
            if grep -Fq "Inside shutdown method" "$log_file" || grep -Fq "shutting down successfully" "$log_file"; then
            break
            fi
            sleep 1
            done


            # Extract the latest shutdown time from the log
            shutdown_time=$(grep -oE '^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}' "$log_file" | tail -n 1)

            if [[ -n "$shutdown_time" ]]; then
                echo
                echo -e "${BRed}$shutdown_time${Color_Off}${BCyan} MediaProxy${Color_Off} ${BYellow}Shutting Down${Color_Off} ${BGreen}Successfully.${Color_Off}"
                echo
            else
                echo
                echo -e "${BRed}Media Proxy Shut Down Unsuccessful.${Color_Off}"
                echo
            fi






            # Read the port from the configuration file
            config_file="/usr/local/iTelSwitchPlusMediaProxy$sname/rtpProperties.cfg"
            if [ -f "$config_file" ]; then
                media_port=$(grep -oP 'localListenPort\s*=\s*\K\d+' "$config_file")
            else
                echo -e "${BIRed}Configuration File Not Found!${Color_Off}"
                echo
                exit 1
            fi

            # Find all process IDs associated with the Media port
            media_pids=($(lsof -t -i :$media_port))

            if [ ${#media_pids[@]} -eq 0 ]; then
                echo -e "${BICyan}No Process Found ON Port : ${Color_Off}${BIRed}$media_port${Color_Off}"
                echo
                echo -e "${BIYellow}Media Proxy${Color_Off} ${BIGreen}Successfully Stopped${Color_Off}"
                echo
            elif [ ${#media_pids[@]} -eq 1 ]; then
                pid_to_kill="${media_pids[0]}"
                echo -e "${BICyan}Found 1 Process With PID :${Color_Off} ${BIRed}$pid_to_kill${Color_Off} ${BICyan}On Port :${Color_Off} ${BIRed}$media_port${Color_Off}"
                echo
                echo -e "${BICyan}Now Killing It${Color_Off}"
                echo
                kill "$pid_to_kill"
                attempt=1
                while ps -p "$pid_to_kill" > /dev/null; do
                    echo -e "${BIYellow}Attempt $attempt:${Color_Off} ${BIRed}Failed To Kill The Process With PID :${Color_Off} ${BIYellow}$pid_to_kill${Color_Off}"
                    echo
                    echo -e "${BICyan}Retrying${Color_Off}"
                    echo
                    kill -9 "$pid_to_kill"  # Forcefully kill
                    sleep 1
                    attempt=$((attempt + 1))
                done
                echo -e "${BIYellow}Media Proxy${Color_Off} ${BIGreen}Successfully Stopped${Color_Off}"
                echo
            else
                echo -e "${BICyan}Multiple Processes Found ON Port :${Color_Off} ${BIRed}$media_port${Color_Off} ${BICyan}With PIDs :${Color_Off} ${BIRed}${media_pids[@]}${Color_Off}"
                echo

                # Ask the user to choose a PID to kill
                echo -e "${BIGreen}Choose A PID To Kill : ${Color_Off}"
                echo
                select pid_to_kill in "${media_pids[@]}"; do
                    if [ -n "$pid_to_kill" ]; then
                        echo -e "${BICyan}You Selected To Kill Process With PID :${Color_Off} ${BIRed}$pid_to_kill${Color_Off}"
                        echo
                        kill "$pid_to_kill"
                        attempt=1
                        while ps -p "$pid_to_kill" > /dev/null; do
                            echo -e "${BIYellow}Attempt $attempt :${Color_Off} ${BIRed}Failed To Kill The Process With PID :${Color_Off} ${BIYellow}$pid_to_kill${Color_Off}"
                            echo
                            echo -e "${BICyan}Retrying${Color_Off}"
                            echo
                            kill -9 "$pid_to_kill"  # Forcefully kill
                            sleep 1
                            attempt=$((attempt + 1))
                        done
                        echo -e "${BIYellow}Media Proxy${Color_Off} ${BIGreen}Successfully Stopped${Color_Off}"
                        echo
                        break
                    else
                        echo -e "${BIYellow}Invalid Choice. Please Select A Valid PID${Color_Off}"
                        echo
                    fi
                done
            fi





            # Restart the application
            nohup sh /usr/local/iTelSwitchPlusMediaProxy$sname/runiTelSwitchPlusMediaProxy.sh >> /dev/null 2>&1 &
            
            # Continuously monitor the log file for the "started successfully" message
            while true; do
                new_lines=$(tail -n +"$start_line" "$log_file")
                if echo "$new_lines" | grep -Fq "started successfully"; then
                    start_time=$(echo "$new_lines" | grep -oE '^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}' | tail -n 1)
                    echo -e "${BRed}$start_time${Color_Off}${BCyan} Media Proxy Started${Color_Off} ${BGreen}Successfully.${Color_Off}"
                    echo
                    echo
                    break
                fi
                sleep 1
            done

            # Check for errors and return non-zero exit status if not successful
            if [[ $? -ne 0 ]]; then
                echo -e "${BRed}Media Proxy Didn't Restart Successfully.${Color_Off}"
                return 1
            fi
        }

        # Define the function for shutting down and restarting ByteSaverSignaling
        restart_ByteSaverSignaling() {
            echo -e "${BPurple}ByteSaverSignalingConverter Shutting Down ->${Color_Off}"
            
            # Get the current line number in the log
            start_line=$(wc -l < "/usr/local/ByteSaverSignalConverter$opcode/SignalingProxy.log")

            for _ in {1..3}; do
                sh "/usr/local/ByteSaverSignalConverter$opcode/shutdownByteSaverSignalConverter.sh" >> /dev/null
                #sleep 2
            done

            sed -i 's/^debug=.*/debug=0/' /usr/local/ByteSaverSignalConverter$opcode/server.cfg
            echo
            echo -e "${BBlue}Updated Debug To '0' In (server.cfg)${Color_Off}"
            echo







            # Read the port from the configuration file
            config_file="/usr/local/ByteSaverSignalConverter$opcode/server.cfg"
            if [ -f "$config_file" ]; then
                signaling_port=$(grep -oP 'dialerBindPort\s*=\s*\K\d+' "$config_file")
            else
                echo -e "${BIRed}Configuration File Not Found!${Color_Off}"
                echo
                exit 1
            fi

            # Find all process IDs associated with the Signaling port
            signaling_pids=($(lsof -t -i :$signaling_port))

            if [ ${#signaling_pids[@]} -eq 0 ]; then
                echo -e "${BICyan}No Process Found ON Port : ${Color_Off}${BIRed}$signaling_port${Color_Off}"
                echo
                echo -e "${BICyan}SignalingConverter${Color_Off} ${BIYellow}Stopped${Color_Off} ${BIGreen}Successfully${Color_Off}"
                echo
            elif [ ${#signaling_pids[@]} -eq 1 ]; then
                pid_to_kill="${signaling_pids[0]}"
                echo -e "${BICyan}Found 1 Process With PID :${Color_Off} ${BIRed}$pid_to_kill${Color_Off} ${BICyan}On Port :${Color_Off} ${BIRed}$signaling_port${Color_Off}"
                echo
                echo -e "${BICyan}Now Killing It${Color_Off}"
                echo
                kill "$pid_to_kill"
                attempt=1
                while ps -p "$pid_to_kill" > /dev/null; do
                    echo -e "${BIYellow}Attempt $attempt:${Color_Off} ${BIRed}Failed To Kill The Process With PID :${Color_Off} ${BIYellow}$pid_to_kill${Color_Off}"
                    echo
                    echo -e "${BICyan}Retrying${Color_Off}"
                    echo
                    kill -9 "$pid_to_kill"  # Forcefully kill
                    sleep 1
                    attempt=$((attempt + 1))
                done
                echo -e "${BICyan}SignalingConverter${Color_Off} ${BIYellow}Stopped${Color_Off} ${BIGreen}Successfully${Color_Off}"
                echo
            else
                echo -e "${BICyan}Multiple Processes Found ON Port :${Color_Off} ${BIRed}$signaling_port${Color_Off} ${BICyan}With PIDs :${Color_Off} ${BIRed}${signaling_pids[@]}${Color_Off}"
                echo

                # Ask the user to choose a PID to kill
                echo -e "${BIGreen}Choose A PID To Kill : ${Color_Off}"
                echo
                select pid_to_kill in "${signaling_pids[@]}"; do
                    if [ -n "$pid_to_kill" ]; then
                        echo -e "${BICyan}You Selected To Kill Process With PID :${Color_Off} ${BIRed}$pid_to_kill${Color_Off}"
                        echo
                        kill "$pid_to_kill"
                        attempt=1
                        while ps -p "$pid_to_kill" > /dev/null; do
                            echo -e "${BIYellow}Attempt $attempt :${Color_Off} ${BIRed}Failed To Kill The Process With PID :${Color_Off} ${BIYellow}$pid_to_kill${Color_Off}"
                            echo
                            echo -e "${BICyan}Retrying${Color_Off}"
                            echo
                            kill -9 "$pid_to_kill"  # Forcefully kill
                            sleep 1
                            attempt=$((attempt + 1))
                        done
                        echo -e "${BICyan}SignalingConverter${Color_Off} ${BIYellow}Stopped${Color_Off} ${BIGreen}Successfully${Color_Off}"
                        echo
                        break
                    else
                        echo -e "${BIYellow}Invalid Choice. Please Select A Valid PID${Color_Off}"
                        echo
                    fi
                done
            fi








            nohup sh "/usr/local/ByteSaverSignalConverter$opcode/runByteSaverSignalConverter.sh" >> /dev/null 2>&1 &
            sleep 8
            
            local log_file="/usr/local/ByteSaverSignalConverter$opcode/SignalingProxy.log"
            local temp_log="/tmp/ByteSaverLogTemp_$$.txt"  # Create a temporary file
            
            # Extract new log entries to the temporary file
            tail -n +"$start_line" "$log_file" > "$temp_log"

            # Check shutdown status
            if grep -Fq "shutting down successfully" "$temp_log"; then
                echo -e "${BCyan}SignalingConverter${Color_Off} ${BYellow}Shutting Down${Color_Off} ${BGreen}Successfully.${Color_Off}"
                sleep 2
                echo
            else
                echo
                echo -e "${BRed}SignalingConverter Not ${BYellow}shutting Down${Color_Off}.${Color_Off}"
                sleep 2
                echo
            fi
            
            # Check start status
            if grep -Fq "started successfully" "$temp_log"; then
                echo -e "${BCyan}SignalingConverter${Color_Off} ${BYellow}Started${Color_Off} ${BGreen}Successfully.${Color_Off}"
                echo
            else
                echo -e "${BRed}SignalingConverter Didn't Start.${Color_Off}"
                echo
            fi

            # Clean up the temporary file
            rm -f "$temp_log"
        }

        # Define the function for shutting down and restarting ByteSaverMediaProxy
        restart_ByteSaverMediaProxy() {
            echo
            echo -e "${BPurple}ByteSaverMediaProxy Shutting Down ->${Color_Off}"
            echo

            local log_file="/usr/local/ByteSaverMediaProxy$opcode/MediaProxy.log"
            
            # Get the current line number in the log
            start_line=$(wc -l < "/usr/local/ByteSaverMediaProxy$opcode/MediaProxy.log")
            
            for _ in {1..3}; do
                sh /usr/local/ByteSaverMediaProxy$opcode/shutdownByteSaverMediaProxy.sh >> /dev/null
                #sleep 2
            done





            # Read the port from the configuration file
            config_file="/usr/local/ByteSaverMediaProxy$opcode/rtpProperties.cfg"
            if [ -f "$config_file" ]; then
                media_port=$(grep -oP 'localListenPort\s*=\s*\K\d+' "$config_file")
            else
                echo -e "${BIRed}Configuration File Not Found!${Color_Off}"
                echo
                exit 1
            fi

            # Find all process IDs associated with the Media port
            media_pids=($(lsof -t -i :$media_port))

            if [ ${#media_pids[@]} -eq 0 ]; then
                echo -e "${BICyan}No Process Found ON Port : ${Color_Off}${BIRed}$media_port${Color_Off}"
                echo
                echo -e "${BICyan}MediaProxy${Color_Off} ${BIYellow}Stopped${Color_Off} ${BIGreen}Successfully${Color_Off}"
                echo
            elif [ ${#media_pids[@]} -eq 1 ]; then
                pid_to_kill="${media_pids[0]}"
                echo -e "${BICyan}Found 1 Process With PID :${Color_Off} ${BIRed}$pid_to_kill${Color_Off} ${BICyan}On Port :${Color_Off} ${BIRed}$media_port${Color_Off}"
                echo
                echo -e "${BICyan}Now Killing It${Color_Off}"
                echo
                kill "$pid_to_kill"
                attempt=1
                while ps -p "$pid_to_kill" > /dev/null; do
                    echo -e "${BIYellow}Attempt $attempt:${Color_Off} ${BIRed}Failed To Kill The Process With PID :${Color_Off} ${BIYellow}$pid_to_kill${Color_Off}"
                    echo
                    echo -e "${BICyan}Retrying${Color_Off}"
                    echo
                    kill -9 "$pid_to_kill"  # Forcefully kill
                    sleep 1
                    attempt=$((attempt + 1))
                done
                echo -e "${BICyan}MediaProxy${Color_Off} ${BIYellow}Stopped${Color_Off} ${BIGreen}Successfully${Color_Off}"
                echo
            else
                echo -e "${BICyan}Multiple Processes Found ON Port :${Color_Off} ${BIRed}$media_port${Color_Off} ${BICyan}With PIDs :${Color_Off} ${BIRed}${media_pids[@]}${Color_Off}"
                echo

                # Ask the user to choose a PID to kill
                echo -e "${BIGreen}Choose A PID To Kill : ${Color_Off}"
                echo
                select pid_to_kill in "${media_pids[@]}"; do
                    if [ -n "$pid_to_kill" ]; then
                        echo -e "${BICyan}You Selected To Kill Process With PID :${Color_Off} ${BIRed}$pid_to_kill${Color_Off}"
                        echo
                        kill "$pid_to_kill"
                        attempt=1
                        while ps -p "$pid_to_kill" > /dev/null; do
                            echo -e "${BIYellow}Attempt $attempt :${Color_Off} ${BIRed}Failed To Kill The Process With PID :${Color_Off} ${BIYellow}$pid_to_kill${Color_Off}"
                            echo
                            echo -e "${BICyan}Retrying${Color_Off}"
                            echo
                            kill -9 "$pid_to_kill"  # Forcefully kill
                            sleep 1
                            attempt=$((attempt + 1))
                        done
                        echo -e "${BICyan}MediaProxy${Color_Off} ${BIYellow}Stopped${Color_Off} ${BIGreen}Successfully${Color_Off}"
                        echo
                        break
                    else
                        echo -e "${BIYellow}Invalid Choice. Please Select A Valid PID${Color_Off}"
                        echo
                    fi
                done
            fi






            nohup sh /usr/local/ByteSaverMediaProxy$opcode/runByteSaverMediaProxy.sh >> /dev/null 2>&1 &
            sleep 5

            local log_file="/usr/local/ByteSaverMediaProxy$opcode/MediaProxy.log"
            local temp_log="/tmp/ByteSaverLogTemp_$$.txt"  # Create a temporary file

            # Extract new log entries to the temporary file
            tail -n +"$start_line" "$log_file" > "$temp_log"
                        
            # Check shutdown status
            if grep -Fq "shutting down successfully" "$temp_log"; then
                echo -e "${BCyan}MediaProxy${Color_Off} ${BYellow}Shutting Down${Color_Off} ${BGreen}Successfully.${Color_Off}"
                sleep 2
                echo
            else
                echo -e "${BRed}MediaProxy Not ${BYellow}shutting Down${Color_Off}.${Color_Off}"
                sleep 2
                echo
            fi
            
            # Check start status
            if grep -Fq "started successfully" "$temp_log"; then
                echo -e "${BCyan}MediaProxy${Color_Off} ${BIYellow}Started${Color_Off} ${BGreen}Successfully.${Color_Off}"
                echo
                echo
            else
                echo -e "${BRed}MediaProxy Didn't Start.${Color_Off}"
                echo
            fi
            
            # Clean up the temporary file
            rm -f "$temp_log"
        }

        #Define the function for restaring Jakarta-Tomcat [7]
        function restart_jakartaTomcat7 {
            # Find the Tomcat service name based on its script content
            service_file=$(grep -iRl 'jakarta-tomcat-7.0.61' /etc/init.d/* | head -n 1)
            if [ -z "$service_file" ]; then
                echo -e "${BIRed}Service File Not Found${Color_Off}"
                echo
                return
            fi
            service_name=$(basename "$service_file")


            # Print the found service file
            echo -e "${BIGreen}Found${Color_Off} ${BIRed}Jakarta - Tomcat [7]${Color_Off} ${BICyan}Service File :${Color_Off} ${BIRed}$service_name${Color_Off}"
            echo

            # Stop Tomcat service three times
            echo -e "${BICyan}Stopping${Color_Off} ${BIYellow}Jakarta - Tomcat [7]${Color_Off}"
            echo
            for i in {1..3}; do
                service $service_name stop
                sleep 1  # Adjust the sleep time if needed
            done

            echo

            # Check if Tomcat is still running and kill the process if needed
            if pgrep -f 'jakarta-tomcat-7.0.61' > /dev/null; then
                echo -e "${BIYellow}Jakarta - Tomcat [7]${Color_Off} ${BIRed}Did Not Stop Properly${Color_Off}"
                echo
                echo -e "${BICyan}Now Killing The Process${Color_Off}"
                echo
                pkill -f 'jakarta-tomcat-7.0.61' > /dev/null 2>&1 &
                
                # Display process information after killing
                processes_info=$(ps aux | grep -v grep | grep -E 'jakarta-tomcat-7.0.61' --color=auto)
                if [ -n "$processes_info" ]; then
                    echo -e "${BICyan}Process After Killing${Color_Off}"
                    echo
                    echo "$processes_info"
                    echo
                else
                    echo -e "${BIYellow}Jakarta - Tomcat [7]${Color_Off} ${BIGreen}Stop Successfully${Color_Off}"
                    echo
                fi
            fi

            # Delete Catalina directory
            echo -e "${BICyan}Deleting Catalina Folder${Color_Off}"
            echo
            rm -rf /usr/local/jakarta-tomcat-7.0.61/work/Catalina > /dev/null 2>&1 &

            # Delete catalina.out file
            echo -e "${BICyan}Deleting [catalina.out] File${Color_Off}"
            echo
            rm -f /usr/local/jakarta-tomcat-7.0.61/logs/catalina.out > /dev/null 2>&1 &

            # Start Tomcat service without displaying the "Starting tomcat" message
            echo -e "${BICyan}Starting${Color_Off} ${BIYellow}Jakarta - Tomcat [7]${Color_Off}"
            echo
            service $service_name start
            echo

            # Sleep for a few seconds to allow Tomcat to start
            sleep 5

            # Check if Tomcat has started
            if pgrep -f 'jakarta-tomcat-7.0.61' > /dev/null; then
                echo -e "${BIYellow}Jakarta - Tomcat [7]${Color_Off} ${BIGreen}Started Successfully${Color_Off}"
                echo
            else
                echo -e "${BIYellow}Jakarta - Tomcat [7]${Color_Off} ${BIRed}Failed To Start${Color_Off}"
                echo
            fi

            # Wait for Tomcat to start
            echo -e "${BICyan}Waiting For ${BIRed}iTelSwitch Web Billing${Color_Off} ${BICyan}Startup${Color_Off}"
            echo
            while ! grep -q 'Server startup in' /usr/local/jakarta-tomcat-7.0.61/logs/catalina.out > /dev/null 2>&1; do
                sleep 1
            done
            echo -e "${BIRed}iTelSwitch Web Billing${Color_Off} ${BICyan}Is${Color_Off} ${BIGreen}Up Now!${Color_Off}"
            echo
            echo -e "${BIYellow}Jakarta - Tomcat [7]${Color_Off} ${BIGreen}Restarted Successfully${Color_Off}"
            echo
        }

        #Define the function for restaring Jakarta-Tomcat [9]
        function restart_jakartaTomcat9 {
            # Find the Tomcat service name based on its script content
            service_file=$(grep -iRl 'jakarta-tomcat-9.0.17' /etc/init.d/* | head -n 1)
            systemctl daemon-reload
            if [ -z "$service_file" ]; then
                echo -e "${BIRed}Service File Not Found${Color_Off}"
                echo
                return
            fi
            service_name=$(basename "$service_file")

            # Print the found service file
            echo -e "${BIGreen}Found${Color_Off} ${BIRed}Jakarta - Tomcat [9]${Color_Off} ${BICyan}Service File :${Color_Off} ${BIRed}$service_name${Color_Off}"
            echo

            # Stop Tomcat service three times
            echo -e "${BICyan}Stopping${Color_Off} ${BIYellow}Jakarta - Tomcat [9]${Color_Off}"
            echo
            for i in {1..3}; do
                service $service_name stop
                sleep 1  # Adjust the sleep time if needed
            done

            echo

            # Check if Tomcat is still running and kill the process if needed
            if pgrep -f 'jakarta-tomcat-9.0.17' > /dev/null; then
                echo -e "${BIYellow}Jakarta - Tomcat [9]${Color_Off} ${BIRed}Did Not Stop Properly${Color_Off}"
                echo
                echo -e "${BICyan}Now Killing The Process${Color_Off}"
                echo
                pkill -f 'jakarta-tomcat-9.0.17' > /dev/null 2>&1 &
                
                # Display process information after killing
                processes_info=$(ps aux | grep -v grep | grep -E 'jakarta-tomcat-9.0.17' --color=auto)
                if [ -n "$processes_info" ]; then
                    echo -e "${BICyan}Process After Killing${Color_Off}"
                    echo
                    echo "$processes_info"
                    echo
                else
                    echo -e "${BIYellow}Jakarta - Tomcat [9]${Color_Off} ${BIGreen}Stop Successfully${Color_Off}"
                    echo
                fi
            fi

            # Delete Catalina directory
            echo -e "${BICyan}Deleting Catalina Folder${Color_Off}"
            echo
            rm -rf /usr/local/jakarta-tomcat-9.0.17/work/Catalina > /dev/null 2>&1 &

            # Delete catalina.out file
            echo -e "${BICyan}Deleting [catalina.out] File${Color_Off}"
            echo
            rm -f /usr/local/jakarta-tomcat-9.0.17/logs/catalina.out > /dev/null 2>&1 &

            # Start Tomcat service without displaying the "Starting tomcat" message
            echo -e "${BICyan}Starting${Color_Off} ${BIYellow}Jakarta - Tomcat [9]${Color_Off}"
            echo
            service $service_name start
            echo

            # Sleep for a few seconds to allow Tomcat to start
            sleep 5

            # Check if Tomcat has started
            if pgrep -f 'jakarta-tomcat-9.0.17' > /dev/null; then
                echo -e "${BIYellow}Jakarta - Tomcat [9]${Color_Off} ${BIGreen}Started Successfully${Color_Off}"
                echo
            else
                echo -e "${BIYellow}Jakarta - Tomcat [9]${Color_Off} ${BIRed}Failed To Start${Color_Off}"
                echo
            fi

            # Wait for Tomcat to start
            echo -e "${BICyan}Waiting For ${BIRed}SBC Web Billing${Color_Off} ${BICyan}Startup${Color_Off}"
            echo
            while ! grep -q 'Server startup in' /usr/local/jakarta-tomcat-9.0.17/logs/catalina.out > /dev/null 2>&1; do
                sleep 1
            done
            echo -e "${BIRed}SBC Web Billing${Color_Off} ${BICyan}Is${Color_Off} ${BIGreen}Up Now!${Color_Off}"
            echo
            echo -e "${BIYellow}Jakarta - Tomcat [9]${Color_Off} ${BIGreen}Restarted Successfully${Color_Off}"
            echo
        }

        #Define the function for restaring Apache-Tomcat
        function restart_apacheTomcat {
            # Find the Tomcat service name based on its script content
            service_file=$(grep -iRl 'apache-tomcat-7.0.59' /etc/init.d/* | head -n 1)
            if [ -z "$service_file" ]; then
                echo -e "${BIRed}Service File Not Found${Color_Off}"
                echo
                return
            fi
            service_name=$(basename "$service_file")


            # Print the found service file
            echo -e "${BIGreen}Found${Color_Off} ${BIRed}Apache - Tomcat${Color_Off} ${BICyan}Service File :${Color_Off} ${BIRed}$service_name${Color_Off}"
            echo

            # Stop Tomcat service three times
            echo -e "${BICyan}Stopping${Color_Off} ${BIYellow}Apache - Tomcat${Color_Off}"
            echo
            for i in {1..3}; do
                service $service_name stop
                sleep 1  # Adjust the sleep time if needed
            done

            echo

            # Check if Tomcat is still running and kill the process if needed
            if pgrep -f 'apache-tomcat-7.0.59' > /dev/null; then
                echo -e "${BIYellow}Apache - Tomcat${Color_Off} ${BIRed}Did Not Stop Properly${Color_Off}"
                echo
                echo -e "${BICyan}Now Killing The Process${Color_Off}"
                echo
                pkill -f 'apache-tomcat-7.0.59' > /dev/null 2>&1 &
                
                # Display process information after killing
                processes_info=$(ps aux | grep -v grep | grep -E 'apache-tomcat-7.0.59' --color=auto)
                if [ -n "$processes_info" ]; then
                    echo -e "${BICyan}Process After Killing${Color_Off}"
                    echo
                    echo "$processes_info"
                    echo
                else
                    echo -e "${BIYellow}Apache - Tomcat${Color_Off} ${BIGreen}Stop Successfully${Color_Off}"
                    echo
                fi
            fi

            # Delete Catalina directory
            echo -e "${BICyan}Deleting Catalina Folder${Color_Off}"
            echo
            rm -rf /usr/local/apache-tomcat-7.0.59/work/Catalina > /dev/null 2>&1 &

            # Delete catalina.out file
            echo -e "${BICyan}Deleting [catalina.out] File${Color_Off}"
            echo
            rm -f /usr/local/apache-tomcat-7.0.59/logs/catalina.out > /dev/null 2>&1 &

            # Start Tomcat service without displaying the "Starting tomcat" message
            echo -e "${BICyan}Starting${Color_Off} ${BIYellow}Apache - Tomcat${Color_Off}"
            echo
            service $service_name start
            echo

            # Sleep for a few seconds to allow Tomcat to start
            sleep 5

            # Check if Tomcat has started
            if pgrep -f 'apache-tomcat-7.0.59' > /dev/null; then
                echo -e "${BIYellow}Apache - Tomcat${Color_Off} ${BIGreen}Started Successfully${Color_Off}"
                echo
            else
                echo -e "${BIYellow}Apache - Tomcat${Color_Off} ${BIRed}Failed To Start${Color_Off}"
                echo
            fi

            # Wait for Tomcat to start
            echo -e "${BICyan}Waiting For ${BIRed}SMS Web Billing${Color_Off} ${BICyan}Startup${Color_Off}"
            echo
            while ! grep -q 'Server startup in' /usr/local/apache-tomcat-7.0.59/logs/catalina.out > /dev/null 2>&1; do
                sleep 1
            done
            echo -e "${BIRed}SMS Web Billing${Color_Off} ${BICyan}Is${Color_Off} ${BIGreen}Up Now!${Color_Off}"
            echo
            echo -e "${BIYellow}Apache - Tomcat${Color_Off} ${BIGreen}Restarted Successfully${Color_Off}"
            echo
        }

        # Define the function for deleteing log file for services
        delete_serviceLog() {
            echo
            echo -e "${BGreen}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
            echo
            if [[ -z "$opcode" ]];
            then
            echo -e "${BRed}Skiping ByteSaver Log Delete Process....${Color_Off}"
            echo
            else
            echo -e "${BYellow}Deleting ByteSaver Log File ${Color_Off}"
            echo
            cd /usr/local/ByteSaverSignalConverter$opcode/
            rm -f SignalingProxy.log.*
            cd /usr/local/ByteSaverSignalConverter$opcode/logs/
            rm -rf `date "+%Y"`*
            cd /usr/local/ByteSaverMediaProxy$opcode/
            rm -f MediaProxy.log.*
            cd /usr/local/ByteSaverMediaProxy$opcode/logs/
            rm -rf `date "+%Y"`*
            echo -e "${BRed}Deleted ByteSaver Log File Done. ${Color_Off}"

            sed -i 's/^debug=.*/debug=0/' /usr/local/ByteSaverSignalConverter$opcode/server.cfg
            echo
            echo -e "${BBlue}Updated Debug To '0' In (server.cfg)${Color_Off}"
            echo
            fi
            
            sleep 3
            
            if [[ -z "$sname" ]];
            then
            echo -e "${BRed}Skiping Switch Log Delete Process....${Color_Off}"
            else
            echo
            echo -e "${BYellow}Deleting iTelSwitch Log File ${Color_Off}"
            echo
            cd /usr/local/iTelSwitchPlusSignaling$sname/
            rm -f iTelSwitchPlusSignaling.log.*
            cd /usr/local/iTelSwitchPlusMediaProxy$sname/
            rm -f iTelSwitchPlusMediaProxy.log.*
            sed -i 's/^registrationDebug=.*/registrationDebug=no/' /usr/local/iTelSwitchPlusSignaling$sname/config/server.cfg
            echo
            echo -e "${BBlue}Updated RegistrationDebug To 'NO' In (server.cfg)${Color_Off}"
            echo
            echo -e "${BRed}Deleted iTelSwitch Log File Done. ${Color_Off}"
            fi
        
            sleep 3
            
            echo
            echo -e "${BGreen}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
            echo
        }

        # Define the function for stop iTelSwitchSignaling
        stop_iTelSwitchPlusSignaling() {
            echo -e "${BPurple}Stopping iTelSwitchPlusSignaling :${Color_Off}"

            local log_file="/usr/local/iTelSwitchPlusSignaling$sname/iTelSwitchPlusSignaling.log"
            
            # Get the current line number in the log before the shutdown
            start_line=$(wc -l < "$log_file")

            for _ in {1..3}; do
                sh "/usr/local/iTelSwitchPlusSignaling$sname/shutdowniTelSwitchPlusSignaling.sh" >> /dev/null
            done

            # Wait for the "shutting down successfully" message
            while ! grep -Fq "shutting down successfully" "$log_file"; do
                sleep 1
            done

            # Extract the latest shutdown time from the log
            shutdown_time=$(grep -oE '^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}' "$log_file" | tail -n 1)
            
            if [[ -n "$shutdown_time" ]]; then
                echo
                echo -e "${BRed}$shutdown_time${Color_Off}${BCyan} Signaling${Color_Off} ${BYellow}Shutting Down${Color_Off} Successfully.${Color_Off}"
                echo
            else
                echo
                echo -e "${BRed}Signaling Shut Down Unsuccessful.${Color_Off}"
                echo
            fi
            ps aux | grep -v grep | grep 'iTelSwitchPlusSignaling' --color=auto
            echo
            echo
        }

        #Define the function for stopping Jakarta - Tomcat
        stop_jakartaTomcat() {
            echo -e "${BPurple}Stopping Jakarta - Tomcat :${Color_Off}"
            echo
            # Find the Tomcat service name based on its script content
            service_file=$(grep -iRl 'jakarta-tomcat-7.0.61' /etc/init.d/* | head -n 1)
            if [ -z "$service_file" ]; then
                echo -e "${BIRed}Service File Not Found${Color_Off}"
                echo
                return
            fi
            service_name=$(basename "$service_file")


            # Print the found service file
            echo -e "${BIGreen}Found${Color_Off} ${BIRed}Jakarta - Tomcat [7]${Color_Off} ${BICyan}Service File :${Color_Off} ${BIRed}$service_name${Color_Off}"
            echo

            # Stop Tomcat service three times
            echo -e "${BICyan}Stopping${Color_Off} ${BIYellow}Jakarta - Tomcat [7]${Color_Off}"
            echo
            for i in {1..3}; do
                service $service_name stop
                sleep 1  # Adjust the sleep time if needed
            done

            echo

            # Check if Tomcat is still running and kill the process if needed
            if pgrep -f 'jakarta-tomcat-7.0.61' > /dev/null; then
                echo -e "${BIYellow}Jakarta - Tomcat [7]${Color_Off} ${BIRed}Did Not Stop Properly${Color_Off}"
                echo
                echo -e "${BICyan}Now Killing The Process${Color_Off}"
                echo
                pkill -f 'jakarta-tomcat-7.0.61' > /dev/null 2>&1 &
                
                # Display process information after killing
                processes_info=$(ps aux | grep -v grep | grep -E 'jakarta-tomcat-7.0.61' --color=auto)
                if [ -n "$processes_info" ]; then
                    echo -e "${BICyan}Process After Killing${Color_Off}"
                    echo
                    echo "$processes_info"
                    echo
                else
                    echo -e "${BIYellow}Jakarta - Tomcat [7]${Color_Off} ${BIGreen}Stop Successfully${Color_Off}"
                    echo
                fi
            fi
        }


#-----------------------------------------------------Exit---------------------------------------------------------

echo
echo
echo -e "${BCyan}************************************************************${Color_Off}${BYellow}[ DETAILS---USR->LOCAL ]${Color_Off}${BCyan}******************************************************************${Color_Off}"
echo
cd /usr/local/ && ls
echo 
echo -e "${BCyan}**********************************************************************${Color_Off}${BYellow}[ END ]${Color_Off}${BCyan}*************************************************************************${Color_Off}"
echo
echo

list_itelSwitch=$(cd /usr/local/ && ls | grep -e iTelSwitchPlus | sed 's/iTelSwitchPlus//; s/MediaProxy//; s/Signaling//' | sort | uniq | sed 's/^/-> /')
#echo "$list_itelSwitch"
list_ByteSaver=$(cd /usr/local/ && ls | grep -e ByteSaver | sed 's/ByteSaver//; s/MediaProxy//; s/SignalConverter//' | sort | uniq | sed 's/^/-> /')
#echo "$list_ByteSaver"
list_SBC=$(cd /usr/local/ && ls | grep -e iTelSB | sed 's/iTelSBC//; s/MediaProxy//; s/Signaling//' | sort | uniq | sed 's/^/-> /')
#echo "$list_SBC"
list_DBHC=$(cd /usr/local/ && ls | grep -e DBHealthChecker | sed 's/DBHealthChecker//;' | sort | uniq | sed 's/^/-> /')
#echo "$list_DBHC"

timeout_duration=60  # Timeout in seconds

while true; do
echo
echo -e "*${BCyan}-------------------------${Color_Off}${URed}RESTART${Color_Off}${BCyan}-------------------------${Color_Off}*"
echo -e "*${BIPurple}Which Service Do You Want To Restart???${Color_Off}                  *"
echo -e "*${BBlue}[1]${Color_Off}--------${BGreen}ByteSaver${Color_Off}                                     *"
echo -e "*${BBlue}[BS]${Color_Off}${White}----------${Color_Off}${BYellow}SingnalingCoverter${Color_Off}                         *"
echo -e "*${BBlue}[BM]${Color_Off}${White}----------${Color_Off}${BYellow}MediaProxy${Color_Off}                                 *"
echo -e "*${BBlue}[2]${Color_Off}--------${BGreen}iTelSwitchPlus${Color_Off}                                *"
echo -e "*${BBlue}[SS]${Color_Off}${White}----------${Color_Off}${BYellow}Singnaling${Color_Off}                                 *"
echo -e "*${BBlue}[SM]${Color_Off}${White}----------${Color_Off}${BYellow}MediaProxy${Color_Off}                                 *"
echo -e "*${BBlue}[3]${Color_Off}--------${BGreen}Jakarta  - Tomcat[7]${Color_Off}                          *"
echo -e "*${BBlue}[T9]${Color_Off}-------${BGreen}Jakarta  - Tomcat[9]${Color_Off}                          *"
echo -e "*${BBlue}[4]${Color_Off}--------${BGreen}Apache   - Tomcat${Color_Off}                             *"
echo -e "*${BBlue}[5]${Color_Off}--------${BGreen}All Services Restart${Color_Off}                          *"
echo -e "*${BBlue}[SBC]${Color_Off}------${BGreen}SBC All Services Restart${Color_Off}                      *"
echo -e "*${BBlue}[HR]${Color_Off}-------${BGreen}Hard Restart${Color_Off}                                  *"
echo -e "*${BCyan}-------------------------${Color_Off}${URed}CHECK${Color_Off}${BCyan}---------------------------${Color_Off}*"
echo -e "*${BIPurple}What You Wnat To Check???${Color_Off}                                *"
echo -e "*${BBlue}[6]${Color_Off}--------${BGreen}Memory check${Color_Off}                                  *"
echo -e "*${BBlue}[7]${Color_Off}--------${BGreen}HDD Check${Color_Off}                                     *"
echo -e "*${BBlue}[8]${Color_Off}--------${BGreen}CPU Usage Check${Color_Off}                               *"
echo -e "*${BBlue}[9]${Color_Off}--------${BGreen}Running Call Check${Color_Off}                            *"
echo -e "*${BBlue}[10]${Color_Off}-------${BGreen}Running Proccess Check${Color_Off}                        *"
echo -e "*${BCyan}---------------------${Color_Off}${URed}SERVICE PERFORM${Color_Off}${BCyan}---------------------${Color_Off}*"
echo -e "*${BIPurple}What Service Do You Want To Perform???${Color_Off}                   *"
echo -e "*${BBlue}[11]${Color_Off}-------${BGreen}Memory Free${Color_Off}                                   *"
echo -e "*${BBlue}[12]${Color_Off}-------${BGreen}HDD Space Reduce${Color_Off}                              *"
echo -e "*${BBlue}[13]${Color_Off}-------${BGreen}Billing Password Change${Color_Off}                       *"
echo -e "*${BBlue}[14]${Color_Off}-------${BGreen}Max Call Limite Change${Color_Off}                        *"
echo -e "*${BBlue}[15]${Color_Off}-------${BGreen}Pin Expire Time${Color_Off}                               *"
echo -e "*${BBlue}[16]${Color_Off}-------${BGreen}DiskSpaceChecker Modification${Color_Off}                 *"
echo -e "*${BBlue}[SST]${Color_Off}------${BGreen}Service Stop${Color_Off}                                  *"
echo -e "*${BBlue}[BRC]${Color_Off}------${BGreen}ByteSaver Registration Check${Color_Off}                  *"
echo -e "*${BBlue}[17]${Color_Off}-------${BGreen}Delete All Deleted PINs(Only)${Color_Off}                 *"
echo -e "*${BCyan}------------------------${Color_Off}${URed}Installer${Color_Off}${BCyan}------------------------${Color_Off}*"
echo -e "*${BBlue}[I]${Color_Off}--------${BGreen}All Installer${Color_Off}                                 *"
echo -e "*${BCyan}-------------------------${Color_Off}${BRed}******${Color_Off}${BCyan}--------------------------${Color_Off}*"
echo -e "${BCyan}--------------------${Color_Off}${BIPurple}PRESS [e] FOR EXIT${Color_Off}${BCyan}---------------------${Color_Off}"
echo 
echo -e "${BCyan}---------------${Color_Off}${BIPurple}PRESS [SH] FOR SERVER HEALTH${Color_Off}${BCyan}----------------${Color_Off}"
echo
echo -e "${BCyan}-----------${Color_Off}${BIPurple}PRESS [SCON] FOR SERVER CONFIGURATION${Color_Off}${BCyan}-----------${Color_Off}"
echo
echo -e "${BCyan}PRESS & ENTER PLEASE:${Color_Off} " 
echo

    read -t $timeout_duration option || true
    echo
    
    if [[ -z "$option" ]]; then
        echo -e "${On_IRed}Timeout Reached. Script Is Exiting Due To Inactivity.${Color_Off}"
        echo
        break
    fi
    
    case $option in
        1)
            #-----------------------------------------------------ByteSaverRestart------------------------------------------------------------
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(ByteSaver)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            echo -e "${BYellow}List Of ByteSaver:${Color_Off}"
            echo "$list_ByteSaver"
            echo
            echo -e "${BGreen}Enter Your Oparator Code: ${Color_Off}"
            read opcode
            echo
            restart_ByteSaverSignaling
            echo
            restart_ByteSaverMediaProxy
            ps aux | grep -v grep | grep 'ByteSaver' --color=auto
            echo
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BBlue}                            FINISH                         ${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ;;
            #----------------------------------------------------------Finish-----------------------------------------------------------
        BS)
            #-------------------------------------------------ByteSaverSignalingRestart---------------------------------------------------------
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(ByteSaver SignalingConverter Restart)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            echo -e "${BYellow}List Of ByteSaver:${Color_Off}"
            echo "$list_ByteSaver"
            echo
            echo -e "${BGreen}Enter Your Oparator Code: ${Color_Off}"
            read opcode           
            echo
            restart_ByteSaverSignaling
            ps aux | grep -v grep | grep 'ByteSaverSignalConverter' --color=auto
            echo
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BBlue}                            FINISH                         ${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ;;
            #----------------------------------------------------------Finish-----------------------------------------------------------
        BM)
            #---------------------------------------------------ByteSaverMediaRestart--------------------------------------------------------
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(ByteSaver MediaProxy Restart)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            echo -e "${BYellow}List Of ByteSaver:${Color_Off}"
            echo "$list_ByteSaver"
            echo
            echo -e "${BGreen}Enter Your Oparator Code: ${Color_Off}"
            read opcode
            echo
            restart_ByteSaverMediaProxy
            ps aux | grep -v grep | grep 'ByteSaverMediaProxy' --color=auto
            echo
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BBlue}                            FINISH                         ${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ;;
            #-----------------------------------------------------Finish------------------------------------------------------------
        2)
            #------------------------------------------------iTelSwitchRestart---------------------------------------------------------
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(iTelSwitchPlus)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            echo -e "${BYellow}List Of iTelSwitch:${Color_Off}"
            echo "$list_itelSwitch"
            echo
            echo -e "${BGreen}Enter Your iTelSwitchPlus Name: ${Color_Off}"
            read sname
            echo
            # Check if the log4j.properties_2023Yr file exists(Signaling)
            cd /usr/local/iTelSwitchPlusSignaling$sname/
            echo -e "${BCyan}iTelSwitchPlus(Signaling)${Color_Off}"
            echo
            if ls | grep -q "log4j.properties_2023Yr"; then
                echo -e "${BRed}N.B: Found Backup log4j.properties File.${Color_Off}"
                echo
                echo -e "${BYellow}Skipping Backup & Download For New log4j File.${Color_Off}"
                # Call the function to restart iTelSwitchPlusMediaProxy
                cd /usr/local/
                restart_iTelSwitchPlusSignaling
            else
                # Backup the existing log4j.properties file
                echo -e "${BYellow}Taking Backup Old log4j File.${Color_Off}"
                mv log4j.properties "log4j.properties_$(date '+%YYr_%mMon_%dDay_%HHr_%MMin_%SSec')"
                echo
                echo -e "${BCyan}Backed Up log4j.properties To :${Color_Off}"
                echo
                ls | grep -e "log4j.properties_20"
                echo
                sleep 2

                # Download the new log4j.properties file
                echo
                echo -e "${BCyan}Downloading New Log4j File. ${Color_Off}"
                echo
                wget http://149.20.188.7/log4j.properties_signaling
                echo
                echo -e "${BGreen}Re-Naming. ${Color_Off}"
                echo
                mv log4j.properties_signaling log4j.properties
                echo -e "${BCyan}Current Log4j File :${Color_Off}"
                echo
                ls --time=ctime -l log4j.properties
                echo

                # Call the function to restart iTelSwitchPlusMediaProxy
                cd /usr/local/
                restart_iTelSwitchPlusSignaling
            fi
            echo
            echo
            # Check if the log4j.properties_2023Yr file exists
            cd /usr/local/iTelSwitchPlusMediaProxy$sname/
            echo -e "${BCyan}iTelSwitchPlus(MediaProxy)${Color_Off}"
            echo
            if ls | grep -q "log4j.properties_2023Yr"; then
                echo -e "${BRed}N.B: Found Backup log4j.properties File.${Color_Off}"
                echo
                echo -e "${BYellow}Skipping Backup & Download For New log4j File.${Color_Off}"
                # Call the function to restart iTelSwitchPlusMediaProxy
                restart_iTelSwitchPlusMediaProxy
            else
                # Backup the existing log4j.properties file
                echo -e "${BYellow}Taking Backup Old log4j File.${Color_Off}"
                mv log4j.properties "log4j.properties_$(date '+%YYr_%mMon_%dDay_%HHr_%MMin_%SSec')"
                echo
                echo -e "${BCyan}Backed Up log4j.properties To :${Color_Off}"
                echo
                ls | grep -e "log4j.properties_20"
                echo
                sleep 2

                # Download the new log4j.properties file
                echo
                echo -e "${BCyan}Downloading New Log4j File. ${Color_Off}"
                echo
                wget http://149.20.188.7/log4j.properties_media
                echo
                echo -e "${BGreen}Re-Naming. ${Color_Off}"
                echo
                mv log4j.properties_media log4j.properties
                echo -e "${BCyan}Current Log4j File :${Color_Off}"
                echo
                ls --time=ctime -l log4j.properties
                echo

                # Call the function to restart iTelSwitchPlusMediaProxy
                restart_iTelSwitchPlusMediaProxy
            fi
            ps aux | grep -v grep | grep 'iTelSwitchPlus' --color=auto
            echo
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BBlue}                            FINISH                         ${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ;;
            #-----------------------------------------------------Finish------------------------------------------------------------
        SS)
            #----------------------------------------------iTelSwitchSignalingRestart----------------------------------------------------------
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(iTelSwitchPlus Signaling Restart)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            echo -e "${BYellow}List Of iTelSwitch:${Color_Off}"
            echo "$list_itelSwitch"
            echo
            echo -e "${BGreen}Enter Your iTelSwitchPlus Name: ${Color_Off}"
            read sname
            restart_iTelSwitchPlusSignaling
            ps aux | grep -v grep | grep 'iTelSwitchPlus' --color=auto
            echo
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BBlue}                            FINISH                         ${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ;;
            #-------------------------------------------------------Finish----------------------------------------------------------
        SM)
            #------------------------------------------------iTelSwitchMediaRestart------------------------------------------------------
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(iTelSwitchPlus MediaProxy Restart)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            echo -e "${BYellow}List Of iTelSwitch:${Color_Off}"
            echo "$list_itelSwitch"
            echo
            echo -e "${BGreen}Enter Your Switch Name: ${Color_Off}"
            read sname
            restart_iTelSwitchPlusMediaProxy
            ps aux | grep -v grep | grep 'iTelSwitchPlus' --color=auto
            echo
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BBlue}                            FINISH                         ${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ;;
            #-------------------------------------------------------Finish----------------------------------------------------------
        3)
            #-------------------------------------------------JakartaTomcat[7]Restart--------------------------------------------------------
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(Jakarta - Tomcat[7])${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            restart_jakartaTomcat7
            echo
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BBlue}                            FINISH                         ${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo    
            ;;
            #-------------------------------------------------------Finish----------------------------------------------------------
        4)
            #-------------------------------------------------ApacheTomcatRestart-----------------------------------------------------
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(Apache - Tomcat)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            restart_apacheTomcat
            echo
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BBlue}                            FINISH                         ${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ;;
            #---------------------------------------------------------Finish--------------------------------------------------------
        T9)
            #-------------------------------------------------JakartaTomcat[9]Restart-----------------------------------------------------
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(Jakarta - Tomcat[9])${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            restart_jakartaTomcat9
            echo
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BBlue}                            FINISH                         ${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ;;
            #---------------------------------------------------------Finish--------------------------------------------------------
        5)
            #----------------------------------------------------ServerALLServiceRestart-----------------------------------------------------
            echo -e "${BGreen}Restarting All Services & Clear All Unwanted Log Files & Memory Free${Color_Off}"
            echo
            echo -e "${BYellow}List Of ByteSaver:${Color_Off}"
            echo "$list_ByteSaver"
            echo
            echo -e "${BGreen}Enter Your Oparator Code: ${Color_Off}"
            read opcode
            echo
            echo -e "${BYellow}List Of iTelSwitch:${Color_Off}"
            echo "$list_itelSwitch"
            echo
            echo -e "${BGreen}Enter Your iTelSwitchPlus Name: ${Color_Off}"
            read sname
            echo
            echo -e "${BYellow}List Of DBHealthChecker:${Color_Off}"
            echo "$list_DBHC"
            echo 
            echo -e "${BGreen}Enter Your DBHealthChacker Name: ${Color_Off}"
            read dbhcname
            echo
            #-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*HDDReduce*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Service--${Color_Off}${BRed}(HDD Reduce)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            delete_serviceLog
            echo 

            until [[ $choice == e ]]
            do           
            echo -e "${BGreen}Want To Reduce More? [y/n]${Color_Off}"
            read choice
            echo
            
            case $choice in
            y)
            echo -e "${BYellow}List Of ByteSaver:${Color_Off}"
            echo "$list_ByteSaver"
            echo
            echo -e "${BGreen}Enter Another Oparator Code: ${Color_Off}"
            read opcode2
            echo
            echo -e "${BYellow}List Of iTelSwitch:${Color_Off}"
            echo "$list_itelSwitch"
            echo
            echo -e "${BGreen}Enter Another iTelSwitchPlus Name: ${Color_Off}"
            read sname2
            echo   
            echo
            echo -e "${BYellow}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
            echo
            if [[ -z "$opcode2" ]];
            then
            echo -e "${BRed}Skiping ByteSaver Log Delete Process....${Color_Off}"
            echo
            else
            echo -e "${BPurple}Deleting ByteSaver Log File.......... ${Color_Off}"
            echo
            cd /usr/local/ByteSaverSignalConverter$opcode2/
            rm -f SignalingProxy.log.*
            cd /usr/local/ByteSaverSignalConverter$opcode2/logs/
            rm -rf `date "+%Y"`*
            cd /usr/local/ByteSaverMediaProxy$opcode2/
            rm -f MediaProxy.log.*
            cd /usr/local/ByteSaverMediaProxy$opcode2/logs/
            rm -rf `date "+%Y"`*
            sed -i 's/^debug=.*/debug=0/' /usr/local/ByteSaverSignalConverter$opcode2/server.cfg
            echo
            echo -e "${BBlue}Updated Debug To '0' In (server.cfg)${Color_Off}"
            echo
            echo -e "${BRed}Deleted ByteSaver Log File Done. ${Color_Off}"
            fi
            
            sleep 3
            
            if [[ -z "$sname2" ]];
            then
            echo -e "${BRed}Skiping Switch Log Delete Process....${Color_Off}"
            else
            echo
            echo -e "${BPurple}Deleting iTelSwitch Log File......... ${Color_Off}"
            echo
            cd /usr/local/iTelSwitchPlusSignaling$sname2/
            rm -f iTelSwitchPlusSignaling.log.*
            cd /usr/local/iTelSwitchPlusMediaProxy$sname2/
            rm -f iTelSwitchPlusMediaProxy.log.*
            sed -i 's/^registrationDebug=.*/registrationDebug=no/' /usr/local/iTelSwitchPlusSignaling$sname2/config/server.cfg
            echo
            echo -e "${BBlue}Updated RegistrationDebug To 'NO' In (server.cfg)${Color_Off}"
            echo
            echo -e "${BRed}Deleted iTelSwitch Log File Done. ${Color_Off}"
            fi
        
            sleep 3
            
            echo
            echo -e "${BGreen}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
            echo
            ;;
            *)
            echo -e "${BGreen}We Are Forward To The Next Step.${Color_Off}"
            echo
            break;
            ;;
            esac
            done
            #-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*ByteSaver*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(ByteSaver)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            restart_ByteSaverSignaling           
            echo
            echo            
            restart_ByteSaverMediaProxy
            #-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*iTelSwitch*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(iTelSwitchPlus)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            # Check if the log4j.properties_2023Yr file exists(Signaling)
            cd /usr/local/iTelSwitchPlusSignaling$sname/
            echo -e "${BCyan}iTelSwitchPlus(Signaling)${Color_Off}"
            echo
            if ls | grep -q "log4j.properties_2023Yr"; then
                echo -e "${BRed}N.B: Found Backup log4j.properties File.${Color_Off}"
                echo
                echo -e "${BYellow}Skipping Backup & Download For New log4j File.${Color_Off}"
                # Call the function to restart iTelSwitchPlusMediaProxy
                cd /usr/local/
                restart_iTelSwitchPlusSignaling
            else
                # Backup the existing log4j.properties file
                echo -e "${BYellow}Taking Backup Old log4j File.${Color_Off}"
                mv log4j.properties "log4j.properties_$(date '+%YYr_%mMon_%dDay_%HHr_%MMin_%SSec')"
                echo
                echo -e "${BCyan}Backed Up log4j.properties To :${Color_Off}"
                echo
                ls | grep -e "log4j.properties_20"
                echo
                sleep 2

                # Download the new log4j.properties file
                echo
                echo -e "${BCyan}Downloading New Log4j File. ${Color_Off}"
                echo
                wget http://149.20.188.7/log4j.properties_signaling
                echo
                echo -e "${BGreen}Re-Naming. ${Color_Off}"
                echo
                mv log4j.properties_signaling log4j.properties
                echo -e "${BCyan}Current Log4j File :${Color_Off}"
                echo
                ls --time=ctime -l log4j.properties
                echo

                # Call the function to restart iTelSwitchPlusMediaProxy
                cd /usr/local/
                restart_iTelSwitchPlusSignaling
            fi

            echo
            echo

            # Check if the log4j.properties_2023Yr file exists(MediaProxy)
            cd /usr/local/iTelSwitchPlusMediaProxy$sname/
            echo -e "${BCyan}iTelSwitchPlus(MediaProxy)${Color_Off}"
            echo
            if ls | grep -q "log4j.properties_2023Yr"; then
                echo -e "${BRed}N.B: Found Backup log4j.properties File.${Color_Off}"
                echo
                echo -e "${BYellow}Skipping Backup & Download For New log4j File.${Color_Off}"
                # Call the function to restart iTelSwitchPlusMediaProxy
                restart_iTelSwitchPlusMediaProxy
            else
                # Backup the existing log4j.properties file
                echo -e "${BYellow}Taking Backup Old log4j File.${Color_Off}"
                mv log4j.properties "log4j.properties_$(date '+%YYr_%mMon_%dDay_%HHr_%MMin_%SSec')"
                echo
                echo -e "${BCyan}Backed Up log4j.properties To :${Color_Off}"
                echo
                ls | grep -e "log4j.properties_20"
                echo
                sleep 2

                # Download the new log4j.properties file
                echo
                echo -e "${BCyan}Downloading New Log4j File. ${Color_Off}"
                echo
                wget http://149.20.188.7/log4j.properties_media
                echo
                echo -e "${BGreen}Re-Naming. ${Color_Off}"
                echo
                mv log4j.properties_media log4j.properties
                echo -e "${BCyan}Current Log4j File :${Color_Off}"
                echo
                ls --time=ctime -l log4j.properties
                echo

                # Call the function to restart iTelSwitchPlusMediaProxy
                restart_iTelSwitchPlusMediaProxy
            fi
            #-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*DiskSpaceChecker*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(DiskSpaceChecker)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            echo -e "${BPurple}Changing MailServer Port:${Color_Off}"
            # Path to the email_properties file
            file_path="/usr/local/DiskSpaceChecker/email_properties"
            # Check if the file exists
            if [ -f "$file_path" ]; then
                # Extract the current port value
                current_port=$(grep -oP 'MailSeverPort=\K\d+' "$file_path")
                # Display the current port value
                echo
                echo -e "${BIGreen}Current MailServer Port:${Color_Off} ${BIRed}$current_port${Color_Off}"
                echo
                # Set the new port value
                new_port=587
                # Replace the existing port value with the new port
                sed -i "s/MailSeverPort=.*/MailSeverPort=$new_port/" "$file_path"
                echo -e "${BIGreen}New MailServer Port:${Color_Off} ${BIRed}$new_port${Color_Off}"
                echo
            else
                echo -e "${BIRed}File $file_path Not Found.${Color_Off}"
            fi
            echo -e "${BPurple}DiskSpaceChecker Shuting Down:${Color_Off}"
            sh /usr/local/DiskSpaceChecker/shutdownDiskSpaceChecker.sh
            sh /usr/local/DiskSpaceChecker/shutdownDiskSpaceChecker.sh
            sh /usr/local/DiskSpaceChecker/shutdownDiskSpaceChecker.sh
            echo

            sleep 5

            echo
            sh /usr/local/DiskSpaceChecker/runDiskSpaceChecker.sh

            sleep 5
            #-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*DBHealthChecker*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(DBHealthChecker)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            echo -e "${BPurple}DBHealthChecker Shuting Down:${Color_Off}"
            sh /usr/local/DBHealthChecker$dbhcname/shutdownDBHealthChecker.sh
            sh /usr/local/DBHealthChecker$dbhcname/shutdownDBHealthChecker.sh
            sh /usr/local/DBHealthChecker$dbhcname/shutdownDBHealthChecker.sh
            echo

            sleep 5

            echo

            sh /usr/local/DBHealthChecker$dbhcname/runDBHealthChecker.sh

            sleep 5
            #-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*AppServer*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(iTelAppsServer)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            echo -e "${BPurple}DBHealthChecker Shuting Down:${Color_Off}"
            sh /usr/local/iTelAppsServer$sname/shutdowniTelAppsServer.sh
            sh /usr/local/iTelAppsServer$sname/shutdowniTelAppsServer.sh
            sh /usr/local/iTelAppsServer$sname/shutdowniTelAppsServer.sh
            echo

            sleep 5

            echo

            sh /usr/local/iTelAppsServer$sname/runiTelAppsServer.sh
            
            sleep 5
            #-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*JakartaTomcat*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(Jakarta - Tomcat)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            restart_jakartaTomcat7
            #-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*MemoryClean*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Service--${Color_Off}${BRed}(Memory Clean)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            free -m
            echo
            echo 1 > /proc/sys/vm/drop_caches
            echo
            echo -e "${BGreen}Memory Free Complete.${Color_Off}"
            echo
            free -m
            sleep 2
            echo
            #-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*ShowAllProcess*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Service--${Color_Off}${BRed}(All Process Check)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ps aux | grep -v grep | grep 'ByteSaver' --color=auto
            ps aux | grep -v grep | grep 'iTelSwitch' --color=auto
            ps aux | grep -v grep | grep 'jakarta-tomcat-7' --color=auto
            echo
            sleep 5
            echo
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BBlue}                            FINISH                         ${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ;;
            #---------------------------------------------------------Finish--------------------------------------------------------
        6)
            #-------------------------------------------------------MemoryCheck-----------------------------------------------------
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Service--${Color_Off}${BRed}(Memory Check)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            free -m
            echo
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BBlue}                            FINISH                         ${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ;;
            #---------------------------------------------------------Finish--------------------------------------------------------
        7)
            #----------------------------------------------------CheckingStorage-----------------------------------------------------
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Service--${Color_Off}${BRed}(Storage/HDD Check)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            df -hT
            echo
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BBlue}                            FINISH                         ${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ;;
            #---------------------------------------------------------Finish--------------------------------------------------------
        8)
            #--------------------------------------------------------CPUCheck-----------------------------------------------------
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Service--${Color_Off}${BRed}(Cpu Check)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            echo -e "${BRed}N.B: For Quit, Please Press (CTRL+C).${Color_Off}"
            echo
            top
            echo
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BBlue}                            FINISH                         ${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ;;
            #---------------------------------------------------------Finish--------------------------------------------------------
        9)
            #-------------------------------------------------------RunningCall-----------------------------------------------------
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Service--${Color_Off}${BRed}(Running Call Check)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            echo -e "${BYellow}List Of iTelSwitch:${Color_Off}"
            echo "$list_itelSwitch"
            echo
            echo -e "${BGreen}Enter Switch Name:${Color_Off}"
            read sname
            echo
            cd /usr/local/jakarta-tomcat-7.0.61/webapps/ && ls
            echo
            echo -e "${BGreen}Enter Billing Name : ${Color_Off}"
            read billingname
            echo
            #cat /usr/local/jakarta-tomcat-7.0.61/webapps/$billingname/WEB-INF/classes/*.xml
            iTelBillingDB=$(grep -o 'jdbc:mysql:///[^?"]*' "/usr/local/jakarta-tomcat-7.0.61/webapps/$billingname/WEB-INF/classes/DatabaseConnection.xml" | sed -e 's/.*\/\/\([^?]*\)/\1/')
            echo -e "${BCyan}iTelBilling Database Name:${Color_Off} ${BRed}"$iTelBillingDB"${Color_Off}"
            echo
            echo -e "${BGreen}Put The Database Name Here : ${Color_Off}"
            read dbname
            echo
            # SQL query to retrieve the count
            SQL_QUERY="SELECT COUNT(*) FROM vbRunningCall WHERE connectTime > 1;"

            echo -e "${BGreen}-----Checking Total Connected Calls------${Color_Off}"
            echo
            for ((i = 1; i <= 10; i++)); do
                query_result=$(mysql -u root -D"$dbname" -s -N -e "$SQL_QUERY")
                #echo -e "${BGreen}--------- Checking Time $i ---------${Color_Off}"
                echo -e "${BYellow}Total Connected Calls: ${Color_Off} ${BRed}$query_result${Color_Off}"
                echo
                sleep 1  # Wait for 1 seconds before the next iteration
            done
            echo -e "${BGreen}-----Checking Total Running Calls------${Color_Off}"
            echo
            timeout 10s tail -f /usr/local/iTelSwitchPlusSignaling$sname/iTelSwitchPlusSignaling.log | grep --color=auto 'Total Running' -i
            echo
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BBlue}                            FINISH                         ${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ;;
            #---------------------------------------------------------Finish--------------------------------------------------------
        10)
            #----------------------------------------------------RunningServices-----------------------------------------------------
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Service--${Color_Off}${BRed}(All Process Check)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            echo
            ps aux | grep -v grep | grep 'jar' --color=auto
            sleep 5
            echo
            echo
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BBlue}                            FINISH                         ${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ;;
            #---------------------------------------------------------Finish--------------------------------------------------------
        11)
            #-------------------------------------------------------MemoryFree-----------------------------------------------------
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Service--${Color_Off}${BRed}(Memory Free)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            free -m
            echo
            echo 1 > /proc/sys/vm/drop_caches
            echo
            echo -e "${BGreen}Memory Free Complete.${Color_Off}"
            echo
            free -m
            echo
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BBlue}                            FINISH                         ${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ;;
            #---------------------------------------------------------Finish--------------------------------------------------------
        12)
            #-------------------------------------------------------HDDReduce-----------------------------------------------------
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Service--${Color_Off}${BRed}(HDD Reduce)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            echo -e "${BYellow}List Of ByteSaver:${Color_Off}"
            echo "$list_ByteSaver"
            echo
            echo -e "${BCyan}Enter Your Oparator Code: ${Color_Off}"
            read opcode
            echo
            echo -e "${BYellow}List Of iTelSwitch:${Color_Off}"
            echo "$list_itelSwitch"
            echo
            echo -e "${BCyan}Enter Your iTelSwitchPlus Name: ${Color_Off}"
            read sname
            
            delete_serviceLog
            
            until [[ $choice == e ]]
            do
            
            echo -e "${BCyan}Want To Reduce More? [y/n]${Color_Off}"
            read choice
            echo
            
                case $choice in
                    y)
                    echo -e "${BYellow}List Of ByteSaver:${Color_Off}"
                    echo "$list_ByteSaver"
                    echo
                    echo -e "${BCyan}Enter Another Oparator Code: ${Color_Off}"
                    read opcode2
                    echo
                    echo -e "${BYellow}List Of iTelSwitch:${Color_Off}"
                    echo "$list_itelSwitch"
                    echo
                    echo -e "${BCyan}Enter Another iTelSwitchPlus Name: ${Color_Off}"
                    read sname2
                    echo   
                    echo -e "${BGreen}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
                    echo
                    if [[ -z "$opcode2" ]];
                    then
                    echo
                    echo -e "${BRed}Skiping ByteSaver Log Delete Process....${Color_Off}"
                    echo
                    else
                    echo -e "${BYellow}Deleting ByteSaver Log File.......... ${Color_Off}"
                    echo
                    cd /usr/local/ByteSaverSignalConverter$opcode2/
                    rm -f SignalingProxy.log.*
                    cd /usr/local/ByteSaverSignalConverter$opcode2/logs/
                    rm -rf `date "+%Y"`*
                    cd /usr/local/ByteSaverMediaProxy$opcode2/
                    rm -f MediaProxy.log.*
                    cd /usr/local/ByteSaverMediaProxy$opcode2/logs/
                    rm -rf `date "+%Y"`*
                    sed -i 's/^debug=.*/debug=0/' /usr/local/ByteSaverSignalConverter$opcode2/server.cfg
                    echo
                    echo -e "${BBlue}Updated Debug To '0' In (server.cfg)${Color_Off}"
                    echo
                    echo -e "${BRed}Deleted ByteSaver Log File Done. ${Color_Off}"
                    fi
                    
                    sleep 3
                    
                    if [[ -z "$sname2" ]];
                    then
                    echo
                    echo -e "${BRed}Skiping Switch Log Delete Process....${Color_Off}"
                    else
                    echo
                    echo -e "${BYellow}Deleting iTelSwitch Log File......... ${Color_Off}"
                    echo
                    cd /usr/local/iTelSwitchPlusSignaling$sname2/
                    rm -f iTelSwitchPlusSignaling.log.*
                    cd /usr/local/iTelSwitchPlusMediaProxy$sname2/
                    rm -f iTelSwitchPlusMediaProxy.log.*
                    sed -i 's/^registrationDebug=.*/registrationDebug=no/' /usr/local/iTelSwitchPlusSignaling$sname2/config/server.cfg
                    echo
                    echo -e "${BBlue}Updated RegistrationDebug To 'NO' In (server.cfg)${Color_Off}"
                    echo
                    echo -e "${BRed}Deleted iTelSwitch Log File Done. ${Color_Off}"
                    fi
                
                    sleep 3
                    
                    echo
                    echo -e "${BGreen}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
                    echo
                    ;;
                    *)
                    echo -e "${BPurple}We Are Forward To The Next Step.${Color_Off}"
                    echo
                    break;
                    ;;
                    esac
                done    
            
            

            echo -e "${BCyan}Want To Drop Failed Table? [y/n]${Color_Off}"
            read choice

            if [[ $choice == 'y' ]]
            then
            echo
            echo -e "${BRed}!!!!!!!--------------- BE CAREFUL --------------!!!!!!!${Color_Off}"
            echo
            echo -e "${BRed}!!!!!!!------ Don't Drop Last Month Table ------!!!!!!!${Color_Off}"
            echo
            sleep 2
            # Function to drop tables within a given range
            drop_tables_in_range() {
                local db_name="$1"
                local table_name="$2"
                local start_table="$3"
                local last_table="$4"

                valid_range=false
                existing_tables=""

                for ((i=start_table; i<=last_table; i++)); do
                    table_to_check="${table_name}_$i"
                    exists=$(mysql -u root --force -D "$db_name" -e "SHOW TABLES LIKE '$table_to_check';" | grep -o "$table_to_check")
                    if [ -z "$exists" ]; then
                        echo
                        echo -e "${On_IRed}WARNING:${Color_Off}${BRed} Table${Color_Off} ${BYellow}$table_to_check${Color_Off} ${BRed}Does Not Exist.${Color_Off}"
                        echo
                    else
                        existing_tables+=" $table_to_check"
                    fi
                done

                if [ -z "$existing_tables" ]; then
                    echo
                    echo -e "${On_IRed}WARNING:${Color_Off}${BRed} No Existing Tables Found Within The Specified Range.${Color_Off}"
                    echo
                else
                    for table_to_drop in $existing_tables; do
                        echo -e "${BCyan}Dropping Table :${Color_Off} ${BRed}$table_to_drop${Color_Off}"
                        mysql -u root --force -D "$db_name" -e "DROP TABLE IF EXISTS $table_to_drop;"
                    done
                    echo
                    echo -e "${BGreen}Tables Dropped For${Color_Off} ${BRed}$table_name${Color_Off}${BGreen}.${Color_Off}"
                    echo
                fi
            }

            # Move to the appropriate directory
            cd /usr/local/jakarta-tomcat-7.0.61/webapps/

            # List directories (billing names)
            echo
            echo -e "${BCyan}Available Billing :${Color_Off}"
            echo
            ls

            # Read billing name from user input
            echo
            echo -e "${BGreen}Enter Billing Name: ${Color_Off}"
            read billingname
            echo

            # Extract MySQL connection details from DatabaseConnection_Failed.xml
            failed_db_name=$(grep -o 'jdbc:mysql:///[^?"]*' "/usr/local/jakarta-tomcat-7.0.61/webapps/$billingname/WEB-INF/classes/DatabaseConnection_Failed.xml" | sed -e 's/.*\/\/\([^?]*\)/\1/')

            # Connect to the failed database and show tables
            echo -e "${BGreen}Tables In${Color_Off} ${BRed}$failed_db_name:${Color_Off}"
            echo
            mysql -u root --force -D "$failed_db_name" -e "SHOW TABLES;"

            # Loop through table names
            table_names=(
                "vbAuthFailedCDR"
                "vbFailedCDR"
                "vbFailedSummaryCDR"
                "vbPacket"
            )

            # Loop through table names
            for table_name in "${table_names[@]}"; do
                while true; do
                    while true; do
                        echo
                        echo -e "${BGreen}Enter Start Table Number For${Color_Off} ${BRed}$table_name${Color_Off} ${BYellow}(Press Enter To Skip)${Color_Off}${BGreen}: ${Color_Off}"
                        read start_table
                        echo
                        if [ -z "$start_table" ]; then
                            echo -e "${BYellow}Skipping${Color_Off} ${BRed}$table_name${Color_Off}"
                            break 2  # Break out of both loops
                        fi

                        echo -e "${BGreen}Enter Last Table Number For${Color_Off} ${BRed}$table_name${Color_Off} ${BYellow}(Press Enter For Just 1 Table)${Color_Off}${BGreen}: ${Color_Off}"
                        read last_table
                        echo

                        if [ -z "$last_table" ]; then
                            last_table="$start_table"
                        fi

                        if [ "$start_table" -gt "$last_table" ]; then
                            echo -e "${On_IRed}WARNING:${Color_Off}${BRed} Invalid Range. Start Table Number Can't Be Greater Than Last Table Number.${Color_Off}"
                            echo
                        else
                            exists=$(mysql -u root --force -D "$failed_db_name" -e "SHOW TABLES LIKE '${table_name}_$start_table';" | grep -o "${table_name}_$start_table")
                            if [ -z "$exists" ]; then
                                echo -e "${On_IRed}WARNING:${Color_Off}${BRed} Table${Color_Off} ${BYellow}$start_table${Color_Off} ${BRed}Does Not Exist. Please Enter A Valid Range.${Color_Off}"
                                echo
                            else
                                drop_tables_in_range "$failed_db_name" "$table_name" "$start_table" "$last_table"
                                break
                            fi
                        fi
                    done

                    break
                done
            done

            # Show remaining tables
            echo
            echo -e "${BGreen}Remaining Tables :${Color_Off}"
            echo
            mysql -u root --force -D "$failed_db_name" -e "SHOW TABLES;"
            echo
            echo -e "${BGreen}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
            echo
            echo -e "${BPurple}We Are Forward To The Next Step.${Color_Off}"
            echo 
            else
            echo
            echo -e "${BBlue}Thanks For Your Choice!!${Color_Off}"
            echo
            echo -e "${BGreen}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
            echo
            echo -e "${BPurple}We Are Forward To The Next Step.${Color_Off}"
            echo  
            fi


            echo -e "${BCyan}Want To GZIP From (var/lib/mysql)? [y/n]${Color_Off}"
            read choice

            if [[ $choice == 'y' ]]
            then
            echo
            echo -e "${BRed}!!!!!!!--------------- BE CAREFUL --------------!!!!!!!${Color_Off}"
            echo
            echo -e "${BRed}!!!!!!!--- Do Not GZIP More Than 50 At A Time ---!!!!!!!${Color_Off}"
            echo
            # Move to the directory
            cd /var/lib/mysql
            # Function to validate input range
            validate_input_range() {
                local start=$1
                local last=$2
                local max_difference=100
                local start_number=$(echo "$start" | sed 's/^0*//')
                local last_number=$(echo "$last" | sed 's/^0*//')
                local difference=$((last_number - start_number + 1))
                if [[ $difference -gt $max_difference ]]; then
                    echo -e "${BRed}You Can't GZIP More Than $max_difference (mysqld-bin) Files At A Time.${Color_Off}"
                    echo
                    return 1
                fi
                if [[ $start_number -gt $last_number ]]; then
                    echo -e "${BRed}Start File Number Must Be Less Than OR Equal To The Last File Number.${Color_Off}"
                    echo
                    return 1
                fi
                return 0
            }
            # List non-gzipped files excluding mysqld-bin.index and the last file
            echo -e "${BYellow}Available NON-GZIPPED (mysqld-bin) Files :${Color_Off}"
            echo
            non_gzipped_files=$(ls mysqld-bin.* | grep -vE '(\.gz$|mysqld-bin\.index$)' | awk -F'.' '{print $0}' | head -n -1)
            echo "$non_gzipped_files"
            echo
            # Read start and last file numbers from user input with validation
            while true; do
                echo -e "${BGreen}Enter Start (mysqld-bin) File Number Just (${Color_Off}${BYellow}e.g., 325${Color_Off}${BGreen}): ${Color_Off}"
                read -r start_number
                echo
                echo -e "${BGreen}Enter Last (mysqld-bin) File Number Just(${Color_Off}${BYellow}e.g., 424${Color_Off}${BGreen}): ${Color_Off}"
                read -r last_number
                echo

                if ! [[ "$start_number" =~ ^[0-9]+$ ]] || ! [[ "$last_number" =~ ^[0-9]+$ ]]; then
                    echo
                    echo -e "${BRed}Invalid Input. Please Enter Valid Numbers.${Color_Off}"
                    echo
                else
                    if validate_input_range "$start_number" "$last_number"; then
                        break
                    fi
                fi
            done
            # Loop through file numbers and gzip each non-gzipped file
            for ((i=start_number; i<=last_number; i++)); do
                current_file="mysqld-bin.$(printf "%06d" $i)"
                if [ -f "$current_file" ] && ! [[ $current_file =~ \.gz$ ]]; then
                    gzip "$current_file"
                    echo
                    echo -e "${BGreen}Gzipping Completed For :${Color_Off} ${BRed}$current_file${Color_Off}"
                fi
            done
            echo
            echo -e "${BGreen}Gzipping Completed For NON-GZIPPED (mysqld-bin) Files Between${Color_Off} ${BRed}$start_number${Color_Off} ${BGreen}&${Color_Off} ${BRed}$last_number${Color_Off}${BGreen}.${Color_Off}"
            echo
            echo
            ls mysqld-bin.*
            echo
            echo -e "${BGreen}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
            echo
            else
            echo
            echo -e "${BBlue}Thanks For Your Choice!!${Color_Off}"
            echo
            echo -e "${BGreen}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
            echo
              
            fi




            echo
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BBlue}                            FINISH                         ${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ;;
            #---------------------------------------------------------Finish--------------------------------------------------------
        13)
            #----------------------------------------------------BillingAccessChange-----------------------------------------------------
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Service--${Color_Off}${BRed}(Billing Access Change)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            echo -e "${BCyan}Choose Your Billing Option[1/2].${Color_Off}"
            echo -e "${BBlue}1. iTelBilling${Color_Off}"
            echo -e "${BBlue}2. iTelSMS${Color_Off}"
            echo
            
            echo -e "${BCyan}INPUT: ${Color_Off}"
            read billingOp 
            echo

            if [[ $billingOp == 1 ]]
            then

            echo -e "${BGreen}------------iTelBilling-------------- ${Color_Off}"
            echo
            cd /usr/local/jakarta-tomcat-7.0.61/webapps/ && ls
            echo

            echo -e ${BGreen}"Enter Billing Name : ${Color_Off}"

            read billingname
            echo

            #cat /usr/local/jakarta-tomcat-7.0.61/webapps/$billingname/WEB-INF/classes/*.xml
            iTelBillingDB=$(grep -o 'jdbc:mysql:///[^?"]*' "/usr/local/jakarta-tomcat-7.0.61/webapps/$billingname/WEB-INF/classes/DatabaseConnection.xml" | sed -e 's/.*\/\/\([^?]*\)/\1/')
            echo -e "${BCyan}iTelBilling Database Name:${Color_Off} ${BRed}"$iTelBillingDB"${Color_Off}"
            echo
            echo -e "${BGreen}Put The Database Name Here : ${Color_Off}"
            read dbname
            echo

            mysql -u root --force -D $dbname -e "select * from vbUser\G;"
            echo

            echo -e "${BGreen}Please Enter usUserName : ${Color_Off}"
            read usUserName
            echo

            echo -e "${BGreen}Please Enter usUserID : ${Color_Off}"
            read usUserID
            echo

            mysql -u root --force -D $dbname -e "drop table vbUser_`date +"%Y%m%d"`; drop table vbSequencer_`date +"%Y%m%d"`;"

            mysql -u root --force -D $dbname -e "create table vbUser_`date +"%Y%m%d"` like vbUser; insert into vbUser_`date +"%Y%m%d"` (select * from vbUser); create table vbSequencer_`date +"%Y%m%d"` like vbSequencer; insert into vbSequencer_`date +"%Y%m%d"`(select * from vbSequencer);"

            mysql -u root --force -D $dbname -e "update vbUser set usPassword='ld/G0H198wXmukcRhga/xVwZ/fA=' where usUserID=$usUserID; update vbUser set usMaxRetryTime=10,usStatus=0 where usUserID=$usUserID; update vbSequencer set table_LastModificationTime = UNIX_TIMESTAMP(NOW())*1000 where table_name in ('vbUser');"
            echo
            echo -e "${BPurple} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
            echo -e "${BPurple}|${Color_Off}${BGreen}             NEW BILLING ACCESS            ${Color_Off}${BPurple}|${Color_Off}"
            echo -e "${BPurple} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
            echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
            echo -e "  ${BCyan}User Name     : ${Color_Off}${BRed}$usUserName ${Color_Off}"
            echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
            echo -e "  ${BCyan}New  Password : ${Color_Off}${BRed}SystemERROR404${Color_Off}"
            echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
            echo -e "${BPurple} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
            echo



            elif [[ $billingOp == 2 ]]
            then

            echo -e "${BGreen}--------------iTelSMS---------------- ${Color_Off}"
            echo
            cd /usr/local/apache-tomcat-7.0.59/webapps && ls
            echo

            echo -e ${BGreen}"Enter Billing Name : ${Color_Off}"

            read billingname
            echo

            #cat /usr/local/apache-tomcat-7.0.59/webapps/$billingname/WEB-INF/classes/*.xml
            iTelSMSDB=$(grep -o 'jdbc:mysql:///[^?"]*' "/usr/local/apache-tomcat-7.0.59/webapps/$billingname/WEB-INF/classes/DatabaseConnection.xml" | sed -e 's/.*\/\/\([^?]*\)/\1/')
            echo -e "${BCyan}iTelBilling Database Name:${Color_Off} ${BRed}"$iTelSMSDB"${Color_Off}"
            echo
            echo -e "${BGreen}Put The Database Name Here : ${Color_Off}"
            read dbname
            echo

            mysql -u root --force -D $dbname -e "select * from vbUser\G;"
            echo
            
            
            echo -e "${BGreen}Please Enter usUserName : ${Color_Off}"
            read usUserName
            echo
            echo -e "${BGreen}Please Enter usUserID : ${Color_Off}"
            read usUserID
            echo 
            

            mysql -u root --force -D $dbname -e "drop table vbUser_`date +"%Y%m%d"`; drop table vbSequencer_`date +"%Y%m%d"`;"

            mysql -u root --force -D $dbname -e "create table vbUser_`date +"%Y%m%d"` like vbUser; insert into vbUser_`date +"%Y%m%d"` (select * from vbUser); create table vbSequencer_`date +"%Y%m%d"` like vbSequencer; insert into vbSequencer_`date +"%Y%m%d"` (select * from vbSequencer);"

            mysql -u root --force -D $dbname -e "update vbUser set usPassword='ld/G0H198wXmukcRhga/xVwZ/fA=' where usUserID=$usUserID; update vbUser set usMaxRetryTime=10,usStatus=0 where usUserID=$usUserID; update vbSequencer set table_LastModificationTime = UNIX_TIMESTAMP(NOW())*1000 where table_name in ('vbUser');"
            
            echo
            echo -e "${BPurple} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
            echo -e "${BPurple}|${Color_Off}${BGreen}             NEW BILLING ACCESS            ${Color_Off}${BPurple}|${Color_Off}"
            echo -e "${BPurple} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
            echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
            echo -e "  ${BCyan}User Name     : ${Color_Off}${BRed}$usUserName ${Color_Off}"
            echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
            echo -e "  ${BCyan}New  Password : ${Color_Off}${BRed}SystemERROR404${Color_Off}"
            echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
            echo -e "${BPurple} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
            echo
            else 
            
            echo -e "${BRed}Invalid Billing Option${Color_Off}"
            echo
            fi
            echo -e "${BGreen} Billing Access Changed Successfully.${Color_Off}"
            echo
            echo -e "${BRed}!!--> Please Copy The Billing Access <--!!${Color_Off}"
            echo
            sleep 5
            echo
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BBlue}                            FINISH                         ${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ;;
            #---------------------------------------------------------Finish--------------------------------------------------------
        14)
            #----------------------------------------------------MaxCallLimitChange-----------------------------------------------------
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Service--${Color_Off}${BRed}(Max Call Limit Change)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            echo -e "${BGreen}------------iTelBilling-------------- ${Color_Off}"
            echo
            cd /usr/local/jakarta-tomcat-7.0.61/webapps/ && ls
            echo

            echo -e ${BGreen}"Enter Billing Name : ${Color_Off}"

            read billingname
            echo

            #cat /usr/local/jakarta-tomcat-7.0.61/webapps/$billingname/WEB-INF/classes/*.xml
            iTelBillingDB=$(grep -o 'jdbc:mysql:///[^?"]*' "/usr/local/jakarta-tomcat-7.0.61/webapps/$billingname/WEB-INF/classes/DatabaseConnection.xml" | sed -e 's/.*\/\/\([^?]*\)/\1/')
            echo -e "${BCyan}iTelBilling Database Name:${Color_Off} ${BRed}"$iTelBillingDB"${Color_Off}"
            echo
            echo -e "${BGreen}Put The Database Name Here : ${Color_Off}"
            read dbname
            echo
            echo -e "${BCyan}Enter Max-Call Limite : ${Color_Off}"
            read callLim 
            echo
            
            mysql -u root --force -D $dbname -e "drop table vbClient_`date +"%Y%m%d"`; drop table vbSequencer_`date +"%Y%m%d"`;"

            mysql -u root --force -D $dbname -e "create table vbClient_`date +"%Y%m%d"` like vbClient; insert into vbClient_`date +"%Y%m%d"` (select * from vbClient); create table vbSequencer_`date +"%Y%m%d"` like vbSequencer; insert into vbSequencer_`date +"%Y%m%d"` (select * from vbSequencer);"

            
            mysql -u root --force -D $dbname -e "update vbClient set clMaxCalls=$callLim where clAccountID in (select pinAccountID from vbPin);"
            
            echo
            echo -e "${BRed}Set Max-Call Limit :${Color_Off} ${BGreen}$callLim${Color_Off}"
            
            echo
            sleep 3

            echo -e "${BGreen}Want To Restart iTelSwitch & Tomcat? [y/n] ${Color_Off}"
            read choice 
            echo

            if [[ $choice == y ]]
            then
            
            #-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*iTelSwitchRestart*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(iTelSwitchPlus Signaling)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            echo -e "${BYellow}List Of iTelSwitch:${Color_Off}"
            echo "$list_itelSwitch"
            echo
            echo -e "${BGreen}Enter iTelSwitchPlus Name: ${Color_Off}"
            read sname
            echo            
            restart_iTelSwitchPlusSignaling
            #-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*JakartaTomcatRestart*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(Jakarta - Tomcat)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            restart_jakartaTomcat7
            echo
            else 
            echo -e "${BRed}Need to Restart iTelSwitch & Tomcat Manually${Color_Off}"
            echo
            fi
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BBlue}                            FINISH                         ${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ;;
            #---------------------------------------------------------Finish--------------------------------------------------------
        15)
            #----------------------------------------------------ChangePinExpirTIme-----------------------------------------------------
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Service--${Color_Off}${BRed}(Change All Pin Expire Time)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            echo -e "${BGreen}------------INFO - iTelBilling-------------- ${Color_Off}"
            echo
            cd /usr/local/jakarta-tomcat-7.0.61/webapps/ && ls
            echo

            echo -e "${BGreen}Enter Billing Name : ${Color_Off}"

            read billingname
            echo

            #cat /usr/local/jakarta-tomcat-7.0.61/webapps/$billingname/WEB-INF/classes/*.xml
            iTelBillingDB=$(grep -o 'jdbc:mysql:///[^?"]*' "/usr/local/jakarta-tomcat-7.0.61/webapps/$billingname/WEB-INF/classes/DatabaseConnection.xml" | sed -e 's/.*\/\/\([^?]*\)/\1/')
            echo -e "${BCyan}iTelBilling Database Name:${Color_Off} ${BRed}"$iTelBillingDB"${Color_Off}"
            echo
            echo -e "${BGreen}Put The Database Name Here : ${Color_Off}"
            echo
            read dbname
            echo

            echo -e "${BGreen}Select The Year.${Color_Off}"
            echo
            echo -e "${BRed}1. 2025${Color_Off}" #1767225599000
            echo -e "${BRed}2. 2026${Color_Off}" #1798761599000
            echo -e "${BRed}3. 2027${Color_Off}" #1830297599000
            echo -e "${BRed}4. 2028${Color_Off}" #1861919999000
            echo -e "${BRed}5. 2029${Color_Off}" #1893455999000
            echo -e "${BRed}6. 2030${Color_Off}" #1924991999000
            echo -e "${BRed}7. Other${Color_Off}"
            echo
            read year
            echo

            if [[ $year == 1 ]]
            then
            mysql -u root --force -D $dbname -e "drop table vbPin_`date +"%Y%m%d"`; drop table vbSequencer_`date +"%Y%m%d"`;"

            mysql -u root --force -D $dbname -e "create table vbPin_`date +"%Y%m%d"` like vbPin; insert into vbPin_`date +"%Y%m%d"` (select * from vbPin); create table vbSequencer_`date +"%Y%m%d"` like vbSequencer; insert into vbSequencer_`date +"%Y%m%d"` (select * from vbSequencer);"

            
            mysql -u root --force -D $dbname -e "update vbPin set pinExpirationTime=1767225599000;"
            
            sleep 3
            echo
            echo -e "${BCyan}All Pin's Expire Time Is Now - 31-12-2025(11:59:59 PM)${Color_Off}"
            echo
            
            elif [[ $year == 2 ]]
            then
            mysql -u root --force -D $dbname -e "drop table vbPin_`date +"%Y%m%d"`; drop table vbSequencer_`date +"%Y%m%d"`;"

            mysql -u root --force -D $dbname -e "create table vbPin_`date +"%Y%m%d"` like vbPin; insert into vbPin_`date +"%Y%m%d"` (select * from vbPin); create table vbSequencer_`date +"%Y%m%d"` like vbSequencer; insert into vbSequencer_`date +"%Y%m%d"` (select * from vbSequencer);"
            
            mysql -u root --force -D $dbname -e "update vbPin set pinExpirationTime=1798761599000;"
            
            sleep 3
            echo
            echo -e "${BCyan}All Pin's Expire Time Is Now - 31-12-2026(11:59:59 PM)${Color_Off}"
            echo
            
            elif [[ $year == 3 ]]
            then
            mysql -u root --force -D $dbname -e "drop table vbPin_`date +"%Y%m%d"`; drop table vbSequencer_`date +"%Y%m%d"`;"

            mysql -u root --force -D $dbname -e "create table vbPin_`date +"%Y%m%d"` like vbPin; insert into vbPin_`date +"%Y%m%d"` (select * from vbPin); create table vbSequencer_`date +"%Y%m%d"` like vbSequencer; insert into vbSequencer_`date +"%Y%m%d"` (select * from vbSequencer);"

            
            mysql -u root --force -D $dbname -e "update vbPin set pinExpirationTime=1830297599000;"
            
            sleep 3
            echo
            echo -e "${BCyan}All Pin's Expire Time Is Now - 31-12-2027(11:59:59 PM)${Color_Off}"
            echo
            
            elif [[ $year == 4 ]]
            then
            mysql -u root --force -D $dbname -e "drop table vbPin_`date +"%Y%m%d"`; drop table vbSequencer_`date +"%Y%m%d"`;"

            mysql -u root --force -D $dbname -e "create table vbPin_`date +"%Y%m%d"` like vbPin; insert into vbPin_`date +"%Y%m%d"` (select * from vbPin); create table vbSequencer_`date +"%Y%m%d"` like vbSequencer; insert into vbSequencer_`date +"%Y%m%d"` (select * from vbSequencer);"

            
            mysql -u root --force -D $dbname -e "update vbPin set pinExpirationTime=1861919999000;"
            
            sleep 3
            echo
            echo -e "${BCyan}All Pin's Expire Time Is Now - 31-12-2028(11:59:59 PM)${Color_Off}"
            echo
            
            elif [[ $year == 5 ]]
            then
            mysql -u root --force -D $dbname -e "drop table vbPin_`date +"%Y%m%d"`; drop table vbSequencer_`date +"%Y%m%d"`;"

            mysql -u root --force -D $dbname -e "create table vbPin_`date +"%Y%m%d"` like vbPin; insert into vbPin_`date +"%Y%m%d"` (select * from vbPin); create table vbSequencer_`date +"%Y%m%d"` like vbSequencer; insert into vbSequencer_`date +"%Y%m%d"` (select * from vbSequencer);"

            
            mysql -u root --force -D $dbname -e "update vbPin set pinExpirationTime=1893455999000;"
            
            sleep 3
            echo
            echo -e "${BCyan}All Pin's Expire Time Is Now - 31-12-2029(11:59:59 PM)${Color_Off}"
            echo
            
            elif [[ $year == 6 ]]
            then
            mysql -u root --force -D $dbname -e "drop table vbPin_`date +"%Y%m%d"`; drop table vbSequencer_`date +"%Y%m%d"`;"

            mysql -u root --force -D $dbname -e "create table vbPin_`date +"%Y%m%d"` like vbPin; insert into vbPin_`date +"%Y%m%d"` (select * from vbPin); create table vbSequencer_`date +"%Y%m%d"` like vbSequencer; insert into vbSequencer_`date +"%Y%m%d"` (select * from vbSequencer);"

            
            mysql -u root --force -D $dbname -e "update vbPin set pinExpirationTime=1924991999000;"
            
            sleep 3
            echo
            echo -e "${BCyan}All Pin's Expire Time Is Now - 31-12-2030(11:59:59 PM)${Color_Off}"
            echo
            
            elif [[ $year == 7 ]]
            then
            echo
            echo -e "${BRed}Please Go To 'https://www.epochconverter.com/' This Website.${Color_Off}"
            echo -e "${BRed}Convert Your Desire Year To "Timestamp in milliseconds:"${Color_Off}"
            echo -e "${BRed}Then Paste It Bellow Section.${Color_Off}"
            sleep 2
            echo
            echo -e "${BGreen}Enter Custom Year : ${Color_Off}"
            read cusYear
            echo
            echo -e "${BGreen}Enter Timestamp In Milliseconds : ${Color_Off}"
            read timestamp
            echo
            mysql -u root --force -D $dbname -e "drop table vbPin_`date +"%Y%m%d"`; drop table vbSequencer_`date +"%Y%m%d"`;"

            mysql -u root --force -D $dbname -e "create table vbPin_`date +"%Y%m%d"` like vbPin; insert into vbPin_`date +"%Y%m%d"` (select * from vbPin); create table vbSequencer_`date +"%Y%m%d"` like vbSequencer; insert into vbSequencer_`date +"%Y%m%d"` (select * from vbSequencer);"

            
            mysql -u root --force -D $dbname -e "update vbPin set pinExpirationTime=$timestamp;"
            
            sleep 3
            echo -e "${BCyan}All Pin's Expire Time Is Now - 31-12-$cusYear(11:59:59 PM)${Color_Off}"
            echo


            else
            echo -e "${BRed}Invalid Option!!${Color_Off}"
            fi
            echo
            sleep 3
            #-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*iTelSwitchRestart*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(iTelSwitchPlus Signaling)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            echo -e "${BYellow}List Of iTelSwitch:${Color_Off}"
            echo "$list_itelSwitch"
            echo
            echo -e "${BGreen}Enter iTelSwitchPlus Name: ${Color_Off}"
            read sname
            echo            
            restart_iTelSwitchPlusSignaling
            #-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*JakartaTomcatRestart*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(Jakarta - Tomcat)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            restart_jakartaTomcat7
            echo
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BBlue}                            FINISH                         ${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ;;
            #---------------------------------------------------------Finish--------------------------------------------------------
        I)
            #------------------------------------------------------AllInstaller-----------------------------------------------------
            installerScript_timeout_duration=30

            while true; do
                echo -e "${BPurple} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
                echo -e "${BPurple}|${Color_Off}${BGreen}                 Installer                 ${Color_Off}${BPurple}|${Color_Off}"
                echo -e "${BPurple} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
                echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
                echo -e "  ${BCyan}1.  Main Installer${Color_Off}"
                echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
                echo -e "  ${BCyan}2.  SMS V4 Installer${Color_Off}"
                echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
                echo -e "  ${BCyan}3.  SMS V4 Updater${Color_Off}"
                echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
                echo -e "  ${BCyan}4T. Service Shift${Color_Off}${BRed} - (TEST MODE)${Color_Off}"
                echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
                echo -e "  ${BCyan}5.  Dependencey Install${Color_Off}"
                echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
                echo -e "  ${BCyan}6.  2FA Installer${Color_Off}"
                echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
                echo -e "  ${BCyan}7.  Repository Update For CentOS 6${Color_Off}"
                echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
                echo -e "  ${BCyan}8.  Server Security${Color_Off}"
                echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
                echo -e "  ${BCyan}9.  iTelSwitch Updater(7.0.5)${Color_Off}"
                echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
                echo -e "  ${BCyan}10. REVE SMS Shift${Color_Off}"
                echo -e "${BPurple}|${Color_Off}                                           ${BPurple}|${Color_Off}"
                echo -e "${BPurple} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
                echo -e "${BPurple}|${Color_Off}${BGreen}             Pree [e] For Exit             ${Color_Off}${BPurple}|${Color_Off}"
                echo -e "${BPurple} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
                echo
                echo -e "${BCyan}Which Installer You Want To Run?${Color_Off}"
                echo

                read -t $installerScript_timeout_duration choice || true
                
                if [[ -z "$choice" ]]; then
                    echo -e "${On_IRed}Timeout Reached. Installer Script Is Exiting Due To Inactivity.${Color_Off}"
                    echo
                    break
                fi
                
                case $choice in
                    1)
                        echo -e "${BGreen}---------Main Installer---------${Color_Off}"
                        echo
                        echo
                        rm -f Installer
                        wget 'http://149.20.186.19/installerweb/fileurl.do?filepath=installerweb:download:Installer'
                        mv  fileurl.do?filepath=installerweb:download:Installer  Installer
                        chmod a+x Installer
                        ./Installer 
                        echo
                        echo
                        ;;
                    2)
                        echo -e "${BGreen}---------iTelSMS V4 Installer---------${Color_Off}"
                        echo
                        echo
                        rm -rf sms_v4_installer
                        wget https://supportresources.revesoft.com:4430/media/Installer/sms_v4_installer --no-check-certificate
                        chmod a+x sms_v4_installer
                        ./sms_v4_installer
                        echo
                        echo
                        ;;
                    3)
                        echo -e "${BGreen}---------iTelSMS V4 Updater---------${Color_Off}"
                        echo
                        echo
                        rm -f sms_switch_updatev4.sh 
                        wget https://supportresources.revesoft.com:4430/media/Scripts/sms_switch_updatev4.sh --no-check-certificate
                        chmod a+x sms_switch_updatev4.sh 
                        ./sms_switch_updatev4.sh
                        echo
                        echo
                        ;;
                    4T)
                        echo -e "${BGreen}---------Service Shift---------${Color_Off}"
                        echo
                        echo -e "${BYellow}---------Checking SCREEN---------${Color_Off}"
                        echo

                        if ! command -v screen &> /dev/null; then
                            echo -e "${BRed}SCREEN Is Not Installed.${Color_Off}"
                            echo
                            echo -e "${BYellow}Installing SCREEN...${Color_Off}"
                            echo
                            yum install screen -y
                        else
                            echo -e "${BCyan}SCREEN Is Already Installed.${Color_Off}"
                        fi

                        # Check if there are any existing screen sessions with the name "Shifting"
                        if screen -ls | grep -q "Shifting"; then
                            echo -e "${BCyan}Existing screen session 'Shifting' found.${Color_Off}"
                            echo -e "${BCyan}Terminating existing session...${Color_Off}"
                            screen -S Shifting -X quit
                            sleep 2
                        fi

                        # Create a new screen session named "Shifting" and execute commands
                        echo -e "${BCyan}Creating new screen session 'Shifting'...${Color_Off}"
                        screen -dmS Shifting bash -c '
                            echo "Inside the new screen session"
                            echo "Current working directory: $(pwd)"
                            echo "Downloading menuShift..."
                            rm -f menuShift
                            wget http://training.revesoft.com/downloads/shifT/menuShift
                            chmod 755 menuShift
                            echo "Executing menuShift..."
                            ./menuShift
                            echo "Finished executing menuShift"
                            sleep 5
                            exit
                        '

                        # Wait for the screen session to finish executing
                        sleep 10

                        echo
                        echo
                        ;;
                    5)
                        echo -e "${BGreen}---------Dpendencey Install---------${Color_Off}"
                        echo
                        if ! rpm -q lsof > /dev/null; then
                        echo
                        echo -e "${BYellow}lsof${Color_Off}${BPurple} package is not installed. Installing...${Color_Off}"
                        echo
                        yum install lsof -y
                        else
                        echo
                            echo -e "${BYellow}lsof${Color_Off}${BGreen} package is already installed. Skipping...${Color_Off}"
                            echo
                        fi
                        
                        sleep 1
                        
                        if ! rpm -q zip > /dev/null; then
                        echo
                            echo -e "${BYellow}zip${Color_Off}${BPurple} package is not installed. Installing...${Color_Off}"
                            echo
                            yum install zip -y
                        else
                        echo
                            echo -e "${BYellow}zip${Color_Off}${BGreen} package is already installed. Skipping...${Color_Off}"
                            echo
                        fi
                        
                        sleep 1
                        
                        if ! rpm -q wget > /dev/null; then
                        echo
                            echo -e "${BYellow}wget${Color_Off}${BPurple} package is not installed. Installing...${Color_Off}"
                            echo
                            yum install wget -y
                        else
                        echo
                            echo -e "${BYellow}wget${Color_Off}${BGreen} package is already installed. Skipping...${Color_Off}"
                            echo
                        fi
                        
                        sleep 1
                        
                        if ! rpm -q rsync > /dev/null; then
                        echo
                            echo -e "${BYellow}rsync${Color_Off}${BPurple} package is not installed. Installing...${Color_Off}"
                            echo
                            yum install rsync -y
                        else
                        echo
                            echo -e "${BYellow}rsync${Color_Off}${BGreen} package is already installed. Skipping...${Color_Off}"
                            echo
                        fi
                        
                        sleep 1
                        
                        if ! rpm -q screen > /dev/null; then
                        echo
                            echo -e "${BYellow}screen${Color_Off}${BPurple} package is not installed. Installing...${Color_Off}"
                            echo
                            yum install screen -y
                        else
                        echo
                            echo -e "${BYellow}screen${Color_Off}${BGreen} package is already installed. Skipping...${Color_Off}"
                            echo
                        fi

                        echo
                        echo
                        ;;
                    6)
                        echo -e "${BGreen}---------2FA V2 Installer---------${Color_Off}"
                        echo
                        echo
                        rm -f 2FAInstaller_V2.sh
                        wget http://dashboard.revesecure.com/download/v2/2FAInstaller_V2.sh
                        chmod a+x 2FAInstaller_V2.sh
                        ./2FAInstaller_V2.sh
                        echo
                        echo
                        ;;
                    7)
                        echo -e "${BGreen}---------Repository Update For CentOS 6---------${Color_Off}"
                        echo
                        echo
                        yum repo:
                        cd /etc/yum.repos.d/
                        mv CentOS-Base.repo CentOS-Base.repo_$(date +%F)
                        wget http://mirrors.cloud.tencent.com/repo/centos6_base.repo
                        mv centos6_base.repo CentOS-Base.repo
                        yum makecache
                        echo
                        echo
                        ;;
                    8)
                        echo -e "${BGreen}---------Server Security---------${Color_Off}"
                        echo
                        echo
                        rm -rf ServerSecurity.sh
                        wget http://149.20.188.102:70/ServerSecurity.sh
                        chmod 555 ServerSecurity.sh
                        sh ServerSecurity.sh
                        echo
                        echo
                        ;;
                    9)
                        echo -e "${BGreen}---------iTelSwitch Update(7.0.5)---------${Color_Off}"
                        echo
                        echo
                        rm -rf up_new.sh
                        wget http://training.revesoft.com/resource/scripts/up_new.sh
                        chmod a+x up_new.sh
                        ./up_new.sh 
                        echo
                        echo
                        ;;
                    10)
                        echo -e "${BGreen}---------REVE SMS Shift---------${Color_Off}"
                        echo
                        echo
                        rm -rf SMSShift.sh
                        wget http://149.20.188.102:70/SMSShift.sh
                        chmod 555 SMSShift.sh
                        sh SMSShift.sh
                        echo
                        echo
                        ;;
                    e)
                        echo -e "${BPurple}Thanks${Color_Off}"
                        echo
                        break
                        ;;
                    *)
                        echo -e "${BRed}Please Enter Valid Serial NO.${Color_Off}"
                        echo
                        ;;
                esac
                echo
            done
            ;;
            #---------------------------------------------------------Finish--------------------------------------------------------
        SH)
            #--------------------------------------------------CheckingServerHealth-----------------------------------------------------
            echo -e "${BGreen}*---------------CHECKING SERVER HEALTH---------------------*${Color_Off}"
            echo
            echo -e "${BGreen}---------Checking Memory---------${Color_Off}"
            free -m
            sleep 2
            echo -e "${BGreen}---------Checking Storage--------${Color_Off}"
            df -hT
            sleep 2
            echo -e "${BGreen}----------Checking CPU-----------${Color_Off}"
            echo
            echo -e "${BRed}N.B: For Quit, Please Press (CTRL+C).${Color_Off}"
            echo
            top
            ;;
            #---------------------------------------------------------Finish--------------------------------------------------------
        HR)
            #------------------------------------------------------HardRestart-----------------------------------------------------
            echo -e "${BGreen}Restarting Services & Clear All Unwanted Log Files & Memory Free${Color_Off}"
            echo
            echo -e "${BYellow}List Of ByteSaver:${Color_Off}"
            echo "$list_ByteSaver"
            echo
            echo -e "${BGreen}Enter Your Oparator Code: ${Color_Off}"
            read opcode
            echo
            echo -e "${BYellow}List Of iTelSwitch:${Color_Off}"
            echo "$list_itelSwitch"
            echo
            echo -e "${BGreen}Enter Your iTelSwitchPlus Name: ${Color_Off}"
            read sname
            echo 
            #-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*HDDReduce*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Service--${Color_Off}${BRed}(HDD Reduce)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo 
            delete_serviceLog
            echo
            until [[ $choice == e ]]
            do
            
            echo -e "${BGreen}Want To Reduce More? [y/n]${Color_Off}"
            read choice
            echo
            
            case $choice in
            y)
            echo -e "${BYellow}List Of ByteSaver:${Color_Off}"
            echo "$list_ByteSaver"
            echo
            echo -e "${BGreen}Enter Another Oparator Code: ${Color_Off}"
            read opcode2
            echo
            echo -e "${BYellow}List Of iTelSwitch:${Color_Off}"
            echo "$list_itelSwitch"
            echo
            echo -e "${BGreen}Enter Another iTelSwitchPlus Name: ${Color_Off}"
            read sname2
            echo   
            echo
            echo -e "${BYellow}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
            echo
            if [[ -z "$opcode2" ]];
            then
            echo -e "${BRed}Skiping ByteSaver Log Delete Process....${Color_Off}"
            echo
            else
            echo -e "${BPurple}Deleting ByteSaver Log File.......... ${Color_Off}"
            echo
            cd /usr/local/ByteSaverSignalConverter$opcode2/
            rm -f SignalingProxy.log.*
            cd /usr/local/ByteSaverSignalConverter$opcode2/logs/
            rm -rf `date "+%Y"`*
            cd /usr/local/ByteSaverMediaProxy$opcode2/
            rm -f MediaProxy.log.*
            cd /usr/local/ByteSaverMediaProxy$opcode2/logs/
            rm -rf `date "+%Y"`*
            sed -i 's/^debug=.*/debug=0/' /usr/local/ByteSaverSignalConverter$opcode2/server.cfg
            echo
            echo -e "${BBlue}Updated Debug To '0' In (server.cfg)${Color_Off}"
            echo
            echo -e "${BRed}Deleted ByteSaver Log File Done. ${Color_Off}"
            fi
            
            sleep 3
            
            if [[ -z "$sname2" ]];
            then
            echo -e "${BRed}Skiping Switch Log Delete Process....${Color_Off}"
            else
            echo
            echo -e "${BPurple}Deleting iTelSwitch Log File......... ${Color_Off}"
            echo
            cd /usr/local/iTelSwitchPlusSignaling$sname2/
            rm -f iTelSwitchPlusSignaling.log.*
            cd /usr/local/iTelSwitchPlusMediaProxy$sname2/
            rm -f iTelSwitchPlusMediaProxy.log.*
            sed -i 's/^registrationDebug=.*/registrationDebug=no/' /usr/local/iTelSwitchPlusSignaling$sname2/config/server.cfg
            echo
            echo -e "${BBlue}Updated RegistrationDebug To 'NO' In (server.cfg)${Color_Off}"
            echo
            echo -e "${BRed}Deleted iTelSwitch Log File Done. ${Color_Off}"
            fi
        
            sleep 3
            
            echo
            echo -e "${BGreen}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
            echo
            ;;
            *)
            echo -e "${BGreen}We Are Forward To The Next Step.${Color_Off}"
            echo
            break;
            ;;
            esac
            done
            #-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*ByteSaver*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(ByteSaver)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            restart_ByteSaverSignaling            
            echo
            echo           
            restart_ByteSaverMediaProxy
            #-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*iTelSwitch*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(iTelSwitchPlus)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            # Check if the log4j.properties_2023Yr file exists(Signaling)
            cd /usr/local/iTelSwitchPlusSignaling$sname/
            echo -e "${BCyan}iTelSwitchPlus(Signaling)${Color_Off}"
            echo
            if ls | grep -q "log4j.properties_2023Yr"; then
                echo -e "${BRed}N.B: Found Backup log4j.properties File.${Color_Off}"
                echo
                echo -e "${BYellow}Skipping Backup & Download For New log4j File.${Color_Off}"
                # Call the function to restart iTelSwitchPlusMediaProxy
                cd /usr/local/
                restart_iTelSwitchPlusSignaling
            else
                # Backup the existing log4j.properties file
                echo -e "${BYellow}Taking Backup Old log4j File.${Color_Off}"
                mv log4j.properties "log4j.properties_$(date '+%YYr_%mMon_%dDay_%HHr_%MMin_%SSec')"
                echo
                echo -e "${BCyan}Backed Up log4j.properties To :${Color_Off}"
                echo
                ls | grep -e "log4j.properties_20"
                echo
                sleep 2

                # Download the new log4j.properties file
                echo
                echo -e "${BCyan}Downloading New Log4j File. ${Color_Off}"
                echo
                wget http://149.20.188.7/log4j.properties_signaling
                echo
                echo -e "${BGreen}Re-Naming. ${Color_Off}"
                echo
                mv log4j.properties_signaling log4j.properties
                echo -e "${BCyan}Current Log4j File :${Color_Off}"
                echo
                ls --time=ctime -l log4j.properties
                echo

                # Call the function to restart iTelSwitchPlusMediaProxy
                cd /usr/local/
                restart_iTelSwitchPlusSignaling
            fi

            echo
            echo

            # Check if the log4j.properties_2023Yr file exists
            cd /usr/local/iTelSwitchPlusMediaProxy$sname/
            echo -e "${BCyan}iTelSwitchPlus(MediaProxy)${Color_Off}"
            echo
            if ls | grep -q "log4j.properties_2023Yr"; then
                echo -e "${BRed}N.B: Found Backup log4j.properties File.${Color_Off}"
                echo
                echo -e "${BYellow}Skipping Backup & Download For New log4j File.${Color_Off}"
                # Call the function to restart iTelSwitchPlusMediaProxy
                restart_iTelSwitchPlusMediaProxy
            else
                # Backup the existing log4j.properties file
                echo -e "${BYellow}Taking Backup Old log4j File.${Color_Off}"
                mv log4j.properties "log4j.properties_$(date '+%YYr_%mMon_%dDay_%HHr_%MMin_%SSec')"
                echo
                echo -e "${BCyan}Backed Up log4j.properties To :${Color_Off}"
                echo
                ls | grep -e "log4j.properties_20"
                echo
                sleep 2

                # Download the new log4j.properties file
                echo
                echo -e "${BCyan}Downloading New Log4j File. ${Color_Off}"
                echo
                wget http://149.20.188.7/log4j.properties_media
                echo
                echo -e "${BGreen}Re-Naming. ${Color_Off}"
                echo
                mv log4j.properties_media log4j.properties
                echo -e "${BCyan}Current Log4j File :${Color_Off}"
                echo
                ls --time=ctime -l log4j.properties
                echo

                # Call the function to restart iTelSwitchPlusMediaProxy
                restart_iTelSwitchPlusMediaProxy
            fi
            #-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*JakartaTomcat*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(Jakarta - Tomcat)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            restart_jakartaTomcat7
            #-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*MemoryClean*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Service--${Color_Off}${BRed}(Memory Clean)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            free -m
            echo
            echo 1 > /proc/sys/vm/drop_caches
            echo
            echo -e "${BGreen}Memory Free Complete.${Color_Off}"
            echo
            free -m
            sleep 2
            echo
            #-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*ShowAllProcess*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Service--${Color_Off}${BRed}(All Process Check)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ps aux | grep -v grep | grep 'ByteSaver' --color=auto
            ps aux | grep -v grep | grep 'iTelSwitch' --color=auto
            ps aux | grep -v grep | grep 'jakarta-tomcat-7' --color=auto
            echo
            sleep 5
            echo
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BBlue}                            FINISH                         ${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ;;
            #---------------------------------------------------------Finish--------------------------------------------------------
        SBC)
            #----------------------------------------------------SBCAllServiceRestart-----------------------------------------------------
            echo -e "${BGreen}Restarting SBC Switch & Jakarta - Tomcat & Clear All Unwanted Log Files & Memory Free${Color_Off}"
            echo
            echo -e "${BYellow}List Of iTelSBC:${Color_Off}"
            echo "$list_SBC"
            echo
            echo -e "${BGreen}Enter Your iTelSBC Name: ${Color_Off}"
            read sbcname
            echo 

            #-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*HDDReduce*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Service--${Color_Off}${BRed}(HDD Reduce)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            echo -e "${BGreen}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
            echo
            if [[ -z "$sbcname" ]];
            then
            echo -e "${BRed}Skiping SBC Log Delete Process....${Color_Off}"
            else
            echo
            echo -e "${BPurple}Deleting iTelSBC Log File......... ${Color_Off}"
            echo
            cd /usr/local/iTelSBCSignaling$sbcname/
            rm -f iTelSwitchPlusSignaling-20*
            cd /usr/local/iTelSBCMediaProxy$sbcname/
            rm -f iTelSwitchPlusMediaProxy.log.*
            echo -e "${BRed}Deleted iTelSBC Log File Done. ${Color_Off}"
            fi
        
            sleep 3
            
            echo
            echo -e "${BYellow}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
            echo
            echo   

            until [[ $choice == e ]]
            do
            
            echo -e "${BGreen}Want To Reduce More? [y/n]${Color_Off}"
            read choice
            echo
            
            case $choice in
            y)
            cd /usr/local/ && ls | grep -e iTelSBC
            echo
            echo -e "${BGreen}Enter Another iTelSBC Name: ${Color_Off}"
            read sbcname2
            echo   
            echo
            echo -e "${BYellow}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
            echo
        
            if [[ -z "$sbcname2" ]];
            then
            echo -e "${BRed}Skiping SBC Log Delete Process....${Color_Off}"
            else
            echo
            echo -e "${BPurple}Deleting iTelSBC Log File......... ${Color_Off}"
            echo
            cd /usr/local/iTelSBCSignaling$sbcname/
            rm -f iTelSwitchPlusSignaling-20*
            cd /usr/local/iTelSBCMediaProxy$sbcname/
            rm -f iTelSwitchPlusMediaProxy.log.*
            echo -e "${BRed}Deleted iTelSBC Log File Done. ${Color_Off}"
            fi
        
            sleep 3
            
            echo
            echo -e "${BGreen}Your HDD Is Now : ${Color_Off}${BCyan}`df -lh | awk '{if ($6 == "/") { print $5 }}'` ${Color_Off}"
            echo
            ;;
            *)
            echo -e "${BGreen}We Are Forward To The Next Step.${Color_Off}"
            echo
            break;
            ;;
            esac
            done            
            #-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*iTelSBC*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(iTelSBC)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            if [[ -z "$sbcname" ]];
            then
            echo -e "${BRed}Skiping SBC Restart Process....${Color_Off}"
            else
            echo
            echo -e "${BPurple}Restarting iTelSBC......... ${Color_Off}"
            echo
            echo -e "${BPurple}iTelSBCSignaling Shuting Down:${Color_Off}"
            sh /usr/local/iTelSBCSignaling$sbcname/shutdowniTelSBCSignaling.sh
            sh /usr/local/iTelSBCSignaling$sbcname/shutdowniTelSBCSignaling.sh   
            sh /usr/local/iTelSBCSignaling$sbcname/shutdowniTelSBCSignaling.sh
            echo

            sleep 2

            sh /usr/local/iTelSBCSignaling$sbcname/runiTelSBCSignaling.sh

            sleep 8

            echo
            echo -e "${BPurple}iTelSBCMediaProxy Shuting Down:${Color_Off}"
            sh /usr/local/iTelSBCMediaProxy$sbcname/shutdowniTelSBCMediaProxy.sh
            sh /usr/local/iTelSBCMediaProxy$sbcname/shutdowniTelSBCMediaProxy.sh
            sh /usr/local/iTelSBCMediaProxy$sbcname/shutdowniTelSBCMediaProxy.sh
            echo

            sleep 2

            sh /usr/local/iTelSBCMediaProxy$sbcname/runiTelSBCMediaProxy.sh
            echo
            ps aux | grep -v grep | grep 'iTelSBC' --color=auto
            fi
            sleep 3
            #-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*JakartaTomcat*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
            echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(Jakarta - Tomcat[9])${Color_Off}"
            echo
            restart_jakartaTomcat9
            #-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*MemoryClean*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Service--${Color_Off}${BRed}(Memory Clean)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            free -m
            echo
            echo 1 > /proc/sys/vm/drop_caches
            echo
            echo -e "${BGreen}Memory Free Complete.${Color_Off}"
            echo
            free -m
            echo
            #-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*ShowAllProcess*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Service--${Color_Off}${BRed}(All Process Check)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ps aux | grep -v grep | grep 'iTelSBC' --color=auto
            ps aux | grep -v grep | grep 'jakarta-tomcat-9' --color=auto
            echo
            sleep 5
            echo
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BBlue}                            FINISH                         ${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ;;
            #--------------------------------------------------------Finish--------------------------------------------------------
        BRC)
            #-----------------------------------------------------ByteSaverRegistrationCheck-----------------------------------------------------
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Registration Check--${Color_Off}${BRed}(ByteSaver)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            echo -e "${BYellow}List Of ByteSaver:${Color_Off}"
            echo "$list_ByteSaver"
            echo
            echo -e "${BGreen}Enter Your Operator Code: ${Color_Off}"
            read opcode
            sed -i 's/^debug=.*/debug=1/' /usr/local/ByteSaverSignalConverter$opcode/server.cfg
            echo
            echo -e "${BPurple}Updated Debug To '1' In (server.cfg)${Color_Off}"
            echo
            cd /usr/local/ByteSaverSignalConverter$opcode

            # Initialize a timer and set the timeout to 60 seconds
            timeout=60
            end_time=$(date -d "+$timeout seconds" +%s)

            echo -e "${BICyan}Checking Registration Status :${Color_Off}"
            echo

            # Get the current position in the log file
            log_file="SignalingProxy.log"
            log_position=$(wc -l < "$log_file")

            while true; do
                # Check if the current time is greater than or equal to the end time
                current_time=$(date +%s)
                if [ "$current_time" -ge "$end_time" ]; then
                    echo -e "${BYellow}-----------------------------------${Color_Off}"
                    echo -e "${BYellow}|${Color_Off}${BRed}         Not Registered          ${Color_Off}${BYellow}|${Color_Off}"
                    echo -e "${BYellow}-----------------------------------${Color_Off}"
                    break
                fi

                # Get new lines added to the log file
                new_log_position=$(wc -l < "$log_file")
                lines_added=$((new_log_position - log_position))
                
                # If there are new lines, search for the value in those lines
                if [ "$lines_added" -gt 0 ]; then
                    # If there are new lines, search for the value in those lines and discard the output
                    tail -n "$lines_added" "$log_file" | grep -a "Received from switch\|200 OK" > /dev/null
                    if [ $? -eq 0 ]; then
                        echo -e "${BYellow}-----------------------------------${Color_Off}"
                        echo -e "${BYellow}|${Color_Off}${BGreen}     Registered Successfully     ${Color_Off}${BYellow}|${Color_Off}"
                        echo -e "${BYellow}-----------------------------------${Color_Off}"
                        break
                    fi
                fi

                # Update the log position for the next iteration
                log_position="$new_log_position"
                
                # Sleep for 1 second before checking again
                sleep 1
            done

            sed -i 's/^debug=.*/debug=0/' server.cfg
            echo
            echo -e "${BPurple}Updated Debug To '0' In (server.cfg)${Color_Off}"
            echo
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BBlue}                            FINISH                         ${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ;;
            #---------------------------------------------------------Finish--------------------------------------------------------
        SCON)
            #--------------------------------------------------CheckServerConfiguration-----------------------------------------------------
            cpuinfo=$(lscpu | grep 'Model name'| gawk -F '            ' '{print $2}')
            ramInfoKB=$(cat /proc/meminfo | grep 'MemTotal:'| gawk -F ' ' '{print $2}')
            ramInfo=$(($ramInfoKB / 1024))
            ramInfo=`expr $(($ramInfo / 1024)) + 1`
            core=$(nproc)
            hdd=$(dmesg | grep blocks | grep '/' | gawk -F '(' '{print $2}' | gawk -F '/' '{print $1}' )
            if [[ -f '/etc/os-release' ]]; then
                os=$(cat /etc/os-release  | grep "PRETTY_NAME" | gawk -F '=' '{print $2}')
            else
                os=$(cat /etc/redhat-release)
            fi

            mounted_on_root=$(df -h  | grep -P '.* /$'  | gawk -F ' ' '{print $2}')

            echo -e "${BCyan}|${Color_Off}${BCyan}--------------------------------------------------------------------${Color_Off}${BCyan}|${Color_Off}"
            echo -e "${BCyan}|${Color_Off}${BYellow}        Server Configuration${Color_Off}                                        ${BCyan}|${Color_Off}"
            echo -e "${BCyan}|${Color_Off}${BCyan}--------------------------------------------------------------------${Color_Off}${BCyan}|${Color_Off}"
            echo -e "${BCyan}|${Color_Off}${BGreen}Cpu Info          :${Color_Off}${BRed} $cpuinfo${Color_Off} ${BCyan}|${Color_Off}"
            echo -e "${BCyan}|${Color_Off}${BGreen}CPU Core          :${Color_Off}${BRed} $core${Color_Off}                                               ${BCyan}|${Color_Off}"
            echo -e "${BCyan}|${Color_Off}${BGreen}Hard Disk         :${Color_Off}${BRed} $hdd${Color_Off}                                          ${BCyan}|${Color_Off}"
            echo -e "${BCyan}|${Color_Off}${BGreen}Ram               :${Color_Off}${BRed} $ramInfo GB${Color_Off}                                           ${BCyan}|${Color_Off}"
            echo -e "${BCyan}|${Color_Off}${BGreen}OS INFO           :${Color_Off}${BRed} $os${Color_Off}                         ${BCyan}|${Color_Off}"
            echo -e "${BCyan}|${Color_Off}${BGreen}Mounted On Root   :${Color_Off}${BRed} $mounted_on_root${Color_Off}                                            ${BCyan}|${Color_Off}"
            echo -e "${BCyan}|${Color_Off}${BCyan}--------------------------------------------------------------------${Color_Off}${BCyan}|${Color_Off}"
            sleep 5
            ;;
            #---------------------------------------------------------Finish--------------------------------------------------------
        16)
            #--------------------------------------------------DiskSpaceCheckerModification-----------------------------------------------------
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Service--${Color_Off}${BRed}(DiskSpaceChecker Modification)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            # Path to the email_properties file
            file_path="/usr/local/DiskSpaceChecker/email_properties"
            # Check if the file exists
            if [ -f "$file_path" ]; then
                # Extract the current port value
                current_port=$(grep -oP 'MailSeverPort=\K\d+' "$file_path")
                # Display the current port value
                echo -e "${BIGreen}Current MailServer Port:${Color_Off} ${BIRed}$current_port${Color_Off}"
                echo
                # Set the new port value
                new_port=587
                # Replace the existing port value with the new port
                sed -i "s/MailSeverPort=.*/MailSeverPort=$new_port/" "$file_path"
                echo -e "${BIGreen}New MailServer Port:${Color_Off} ${BIRed}$new_port${Color_Off}"
                echo
            else
                echo -e "${BIRed}File $file_path Not Found.${Color_Off}"
            fi
            echo -e "${BICyan}Restarting DiskSpaceChecker.${Color_Off}"
            echo
            echo -e "${BPurple}DiskSpaceChecker Shuting Down:${Color_Off}"
            echo
            sh /usr/local/DiskSpaceChecker/shutdownDiskSpaceChecker.sh
            sh /usr/local/DiskSpaceChecker/shutdownDiskSpaceChecker.sh
            sh /usr/local/DiskSpaceChecker/shutdownDiskSpaceChecker.sh
            echo

            sleep 2

            sh /usr/local/DiskSpaceChecker/runDiskSpaceChecker.sh
            echo
            sleep 5
            echo
            ps aux | grep -v grep | grep 'DiskSpaceChecker' --color=auto
            echo
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BBlue}                           FINISH                          ${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ;;
            #---------------------------------------------------------Finish--------------------------------------------------------
        SST)
            #-------------------------------------------------------ServiceStop-----------------------------------------------------
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Service--${Color_Off}${BRed}(Stop)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            echo -e "${BYellow}List Of iTelSwitch:${Color_Off}"
            echo "$list_itelSwitch"
            echo
            echo -e "${BGreen}Enter Your iTelSwitchPlus Name: ${Color_Off}"
            read sname
            echo 
            stop_iTelSwitchPlusSignaling
            stop_jakartaTomcat
            echo
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BBlue}                           FINISH                          ${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ;;
            #---------------------------------------------------------Finish--------------------------------------------------------
        17)
            #-------------------------------------------------------ServiceStop-----------------------------------------------------
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Service--${Color_Off}${BRed}(Delete All Deteled PIN (ONLY))${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            echo -e "${BGreen}iTelBilling List ${Color_Off}"
            echo
            cd /usr/local/jakarta-tomcat-7.0.61/webapps/ && ls
            echo

            echo -e ${BGreen}"Enter Billing Name : ${Color_Off}"

            read billingname
            echo

            #cat /usr/local/jakarta-tomcat-7.0.61/webapps/$billingname/WEB-INF/classes/*.xml
            iTelBillingDB=$(grep -o 'jdbc:mysql:///[^?"]*' "/usr/local/jakarta-tomcat-7.0.61/webapps/$billingname/WEB-INF/classes/DatabaseConnection.xml" | sed -e 's/.*\/\/\([^?]*\)/\1/')
            echo -e "${BCyan}iTelBilling Database Name:${Color_Off} ${BRed}"$iTelBillingDB"${Color_Off}"
            echo
            echo -e "${BGreen}Put The Database Name Here : ${Color_Off}"
            read dbname
            echo

            SQL_QUERY1="SELECT COUNT(*) FROM vbClient WHERE clAccountID IN (SELECT pinAccountID FROM vbPin) AND clIsDeleted = 1;"
            vbClient_deleted_pins_count=$(mysql -u root -D"$dbname" -s -N -e "$SQL_QUERY1")
            echo -e "${BYellow}Total Deleted PINs In vbClient Table :${Color_Off} ${BRed}$vbClient_deleted_pins_count${Color_Off}"
            echo

            SQL_QUERY2="select count(*) from vbClientDetails where cdClientAccountID in(select pinAccountID from vbPin) and cdIsDeleted = '1';"
            vbClientDetails_deleted_pins_count=$(mysql -u root -D"$dbname" -s -N -e "$SQL_QUERY2")
            echo -e "${BYellow}Total Deleted PINs In vbClientDetails Table :${Color_Off} ${BRed}$vbClientDetails_deleted_pins_count${Color_Off}"
            echo

            SQL_QUERY3="select count(*) from vbPin where pinIsDeleted = '1';"
            vbPin_deleted_pins_count=$(mysql -u root -D"$dbname" -s -N -e "$SQL_QUERY3")
            echo -e "${BYellow}Total Deleted PINs In vbPin Table :${Color_Off} ${BRed}$vbPin_deleted_pins_count${Color_Off}"
            echo

            # Function to check if a Backup Table exists
            BK_table_exists() {
                local vbClient="vbClient_`date +"%Y%m%d"`"
                local vbClientDetails="vbClientDetails_`date +"%Y%m%d"`"
                local vbPin="vbPin_`date +"%Y%m%d"`"
                
                local result=$(mysql -u root --skip-column-names -D "$dbname" -e "SHOW TABLES LIKE '$vbClient'")
                if [ -n "$result" ]; then
                    echo -e "${BIRed}vbClient_`date +"%Y%m%d"`${Color_off}${BIBlue} Already Exist${Color_off}"
                    echo
                    mysql -u root --force -D $dbname -e "ALTER TABLE vbClient_`date +"%Y%m%d"` RENAME vbClient_`date +"%Y%m%d"`_2;"
                    echo -e "${BICyan}Re-Naming Existing Backup Table : vbClient_`date +"%Y%m%d"`_2 ${Color_off}"
                    echo
                else
                    return 1  # Table does not exist
                fi

                local result=$(mysql -u root --skip-column-names -D "$dbname" -e "SHOW TABLES LIKE '$vbClientDetails'")
                if [ -n "$result" ]; then
                    echo -e "${BIRed}vbClientDetails_`date +"%Y%m%d"`${Color_off}${BIBlue} Already Exist${Color_off}"
                    echo
                    mysql -u root --force -D $dbname -e "ALTER TABLE vbClientDetails_`date +"%Y%m%d"` RENAME vbClientDetails_`date +"%Y%m%d"`_2;"
                    echo -e "${BICyan}Re-Naming Existing Backup Table : vbClientDetails_`date +"%Y%m%d"`_2 ${Color_off}"
                    echo
                else
                    return 1  # Table does not exist
                fi

                local result=$(mysql -u root --skip-column-names -D "$dbname" -e "SHOW TABLES LIKE '$vbPin'")
                if [ -n "$result" ]; then
                    echo -e "${BIRed}vbPin_`date +"%Y%m%d"`${Color_off}${BIBlue} Already Exist${Color_off}"
                    echo
                    mysql -u root --force -D $dbname -e "ALTER TABLE vbPin_`date +"%Y%m%d"` RENAME vbPin_`date +"%Y%m%d"`_2;"
                    echo -e "${BICyan}Re-Naming Existing Backup Table : vbPin_`date +"%Y%m%d"`_2 ${Color_off}"
                    echo
                else
                    return 1  # Table does not exist
                fi
            }

            BK_table_exists

            echo -e "${BCyan}Taking Backup Of vbPin, vbClient, vbClientDetails Table${Color_Off}"
            echo
            mysql -u root --force -D $dbname -e "CREATE TABLE vbClient_`date +"%Y%m%d"` LIKE vbClient; INSERT INTO vbClient_`date +"%Y%m%d"` (SELECT * FROM vbClient);"
            echo -e "${BGreen}Table Created${Color_Off} ${BRed}vbClient_`date +"%Y%m%d"`${Color_Off}"
            echo
            mysql -u root --force -D $dbname -e "CREATE TABLE vbClientDetails_`date +"%Y%m%d"` LIKE vbClientDetails; INSERT INTO vbClientDetails_`date +"%Y%m%d"` (SELECT * FROM vbClientDetails);"
            echo -e "${BGreen}Table Created${Color_Off} ${BRed}vbClientDetails_`date +"%Y%m%d"`${Color_Off}"
            echo
            mysql -u root --force -D $dbname -e "CREATE TABLE vbPin_`date +"%Y%m%d"` LIKE vbPin; INSERT INTO vbPin_`date +"%Y%m%d"` (SELECT * FROM vbPin);"
            echo -e "${BGreen}Table Created${Color_Off} ${BRed}vbPin_`date +"%Y%m%d"`${Color_Off}"
            echo

            echo -e "${BCyan}Deleteing All Deleted PINS From vbPin, vbClient, vbClientDetails Table${Color_Off}"
            echo
            mysql -u root --force -D $dbname -e "delete from vbClient where clAccountID in(select pinAccountID from vbPin) and clIsDeleted = '1';"
            echo -e "${BYellow}Delete All Deleted PINs From${Color_Off} ${BRed}vbClient${Color_Off}"
            echo
            mysql -u root --force -D $dbname -e "delete from vbClientDetails where cdClientAccountID in(select pinAccountID from vbPin) and cdIsDeleted = '1';"
            echo -e "${BYellow}Delete All Deleted PINs From${Color_Off} ${BRed}vbClientDetails${Color_Off}"
            echo
            mysql -u root --force -D $dbname -e "delete from vbPin where pinIsDeleted = '1';"
            echo -e "${BYellow}Delete All Deleted PINs From${Color_Off} ${BRed}vbPin${Color_Off}"
            echo
            
            sleep 3

            echo -e "${BGreen}Want To Restart iTelSwitch & Tomcat? [y/n] ${Color_Off}"
            read choice 
            echo

            if [[ $choice == y ]]
            then
            
            #-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*iTelSwitchRestart*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(iTelSwitchPlus Signaling)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            echo -e "${BYellow}List Of iTelSwitch:${Color_Off}"
            echo "$list_itelSwitch"
            echo
            echo -e "${BGreen}Enter iTelSwitchPlus Name: ${Color_Off}"
            read sname
            echo            
            restart_iTelSwitchPlusSignaling
            #-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*JakartaTomcatRestart*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BCyan}Restarting Service--${Color_Off}${BRed}(Jakarta - Tomcat)${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            restart_jakartaTomcat7
            echo
            else 
            echo -e "${BRed}Need to Restart iTelSwitch & Tomcat Manually${Color_Off}"
            echo
            fi
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BBlue}                            FINISH                         ${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ;;
            #---------------------------------------------------------Finish--------------------------------------------------------
        e)
            #-----------------------------------------------------------------------------------------------------------------
            echo -e "*${BRed}------------* THANKS FOR USING THIS SCRIPT *-------------${Color_Off}*"
            echo
            echo -e "*${BRed}-------------------------${Color_Off}${BYellow}EXIT${Color_Off}${BRed}----------------------------${Color_Off}*"
            echo
            break
            ;;
            #-----------------------------------------------------------------------------------------------------------------
        T)
            #-----------------------------------------------------Developer-Test-Option------------------------------------------------------------
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BRed}                  [ DEVELOPER TEST OPTION ]                 ${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            echo -e "${URed}Developer Test Option.${Color_Off}"
            echo
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo -e "${BRed}                         [ FINISH ]                         ${Color_Off}"
            echo -e "${BBlue}*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*${Color_Off}"
            echo
            ;;
            #--------------------------------------------------------------Exit---------------------------------------------------
        *)
            echo -e "${BRed}Please Enter Valid Serial NO.${Color_Off}"
            ;;
    esac
    echo
done
    # Capture the exact exit time of the script
    exit_time=$(date +'%Y-%m-%d %H:%M:%S')

    # Append login information to the file
    append_login_info "$username" "$login_time" "$exit_time"

    rm -- "$main_script"

    