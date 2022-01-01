#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
echo "Checking VPS"
	clear
	echo -e "Menambah Masa Aktif User Xray"
	echo -e "-----------------------------"
	read -p "Username : " user
	if ! grep -qw "$user" /kaizen/xray/xray-clients.txt; then
		echo -e ""
		echo -e "User '$user' does not exist."
		echo -e ""
		exit 0
	fi
	read -p "Duration (day) : " extend

	uuid=$(cat /kaizen/xray/xray-clients.txt | grep -w $user | awk '{print $2}')
	exp_old=$(cat /kaizen/xray/xray-clients.txt | grep -w $user | awk '{print $3}')
	diff=$((($(date -d "${exp_old}" +%s)-$(date +%s))/(86400)))
	duration=$(expr $diff + $extend + 1)
	exp_new=$(date -d +${duration}days +%Y-%m-%d)
	exp=$(date -d "${exp_new}" +"%d %b %Y")

	sed -i "/\b$user\b/d" /kaizen/xray/xray-clients.txt
	echo -e "$user\t$uuid\t$exp_new" >> /kaizen/xray/xray-clients.txt

	clear
	echo -e "Maklumat User Xray Terbaru"
	echo -e "--------------------------"
	echo -e "Username : $user"
	echo -e "Expired date : $exp"
	echo -e ""
