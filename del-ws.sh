#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/v2ray/config.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		echo ""
		echo "ไม่มีบัญชีในระบบ!"
		exit 1
	fi

	clear
	echo ""
	echo " เลือกบัญชีที่ต้องการลบ"
	echo " พิมพ์​ CTRL+C เพื่อย้อนกลับ"
	echo " *************************"
	echo " ไม่มีบัญชีที่หมดอายุ"
	grep -E "^### " "/etc/v2ray/config.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
user=$(grep -E "^### " "/etc/v2ray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/etc/v2ray/config.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
sed -i "/^### $user $exp/,/^},{/d" /etc/v2ray/config.json
sed -i "/^### $user $exp/,/^},{/d" /etc/v2ray/none.json
rm -f /etc/v2ray/$user-tls.json /etc/v2ray/$user-none.json
systemctl restart v2ray
systemctl restart v2ray@none
clear
echo " ลบบัญชีเรียบร้อยแล้ว"
echo " **************************"
echo " ชื่อ          : $user"
echo " วันหมดอายุ​    : $exp"
echo " **************************"
echo " สคริปโดยเอเจ" 
