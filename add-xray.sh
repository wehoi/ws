#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
echo "Checking VPS"
clear
source /var/lib/premium-script/ipvps.conf

	clear
  	echo -e ""
	echo -e "Menambah User Xray"
	echo -e "------------------"
	read -p "Username : " user
	if grep -qw "$user" /kaizen/xray/xray-clients.txt; then
		echo -e ""
		echo -e "User '$user' already exist."
		echo -e ""
		exit 0
	fi
	read -p "Duration (day) : " duration
	
	uuid=$(cat /proc/sys/kernel/random/uuid)
	exp=$(date -d +${duration}days +%Y-%m-%d)
	expired=$(date -d "${exp}" +"%d %b %Y")
	domain=$(cat /etc/v2ray/domain)
	email=${user}@${domain}
	echo -e "${user}\t${uuid}\t${exp}" >> /kaizen/xray/xray-clients.txt
	cat /usr/local/etc/xray/config.json | jq '.inbounds[0].settings.clients += [{"id": "'${uuid}'","flow": "xtls-rprx-direct","email": "'${email}'"}]' > /usr/local/etc/xray/config_tmp.json
	mv -f /usr/local/etc/xray/config_tmp.json /usr/local/etc/xray/config.json
	cat /usr/local/etc/xray/config.json | jq '.inbounds[1].settings.clients += [{"id": "'${uuid}'","email": "'${email}'"}]' > /usr/local/etc/xray/config_tmp.json
	mv -f /usr/local/etc/xray/config_tmp.json /usr/local/etc/xray/config.json
	service xray restart
	
	clear
echo -e "===========-XRAY/VLESS-=========="
echo -e "Remarks        : ${user}"
echo -e "IP             : ${MYIP}"
echo -e "Port XTLS      : 443"
echo -e "id             : ${uuid}"
echo -e "Encryption     : none"
echo -e "Flow           : xtls-rprx-direct"
echo -e "Network        : tcp"
echo -e "Security       : xtls"
echo -e "Allow Insecure : enable"
echo -e "================================="
echo -e "XRAY XTLS      : vless://$uuid@$domain:443?security=xtls&flow=xtls-rprx-direct#vless_xtls_${user}"
echo -e "================================="
echo -e "QR Code Link   : https://api.qrserver.com/v1/create-qr-code/?size=400x400&data=vless://$uuid@$domain:443?security=xtls&flow=xtls-rprx-direct#vless_xtls_${user}"
echo -e "================================="
echo -e "Expired On     : $expired"
echo -e ""
