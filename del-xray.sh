#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
echo "Checking VPS"
clear
	clear
	echo -e "Memadam User Xray"
	echo -e "-----------------"
	read -p "Username : " user
	echo -e ""
	if ! grep -qw "$user" /kaizen/xray/xray-clients.txt; then
		echo -e ""
		echo -e "User '$user' does not exist."
		echo -e ""
		exit 0
	fi
	uuid="$(cat /kaizen/xray/xray-clients.txt | grep -w "$user" | awk '{print $2}')"

	cat /usr/local/etc/xray/config.json | jq 'del(.inbounds[0].settings.clients[] | select(.id == "'${uuid}'"))' > /usr/local/etc/xray/config_tmp.json
	mv -f /usr/local/etc/xray/config_tmp.json /usr/local/etc/xray/config.json
	cat /usr/local/etc/xray/config.json | jq 'del(.inbounds[1].settings.clients[] | select(.id == "'${uuid}'"))' > /usr/local/etc/xray/config_tmp.json
	mv -f /usr/local/etc/xray/config_tmp.json /usr/local/etc/xray/config.json
	sed -i "/\b$user\b/d" /kaizen/xray/xray-clients.txt
	service xray restart
clear
echo -e ""
echo " ================================"
echo " Akaun Xray Vless berjaya dipadam"
echo " ================================"
echo -e ""
