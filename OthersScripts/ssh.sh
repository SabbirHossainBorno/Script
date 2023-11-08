sed 's/port 22/port 64555/g' sshd_config

sed -i 's/port 22/port 22/g' sshd_config
cat sshd_config

sed -i 's/port 22/port 64555/' sshd_config

sed -i 's/port 64555/port 22/gI' sshd_config
cat sshd_config

cat sshd_config | grep -F 'port '