#!/bin/bash
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray-mini/vless-direct.json")
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
	grep -E "^### " "/etc/xray-mini/vless-direct.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
user=$(grep -E "^### " "/etc/xray-mini/vless-direct.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/etc/xray-mini/vless-direct.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
sed -i "/^### $user $exp/,/^},{/d" /etc/xray-mini/vless-direct.json
sed -i "/^### $user $exp/,/^},{/d" /etc/xray-mini/vless-splice.json

# // Restarting Service
systemctl stop xray-mini@vless-direct
systemctl stop xray-mini@vless-splice
systemctl disable xray-mini@vless-direct
systemctl disable xray-mini@vless-splice
systemctl enable xray-mini@vless-direct
systemctl enable xray-mini@vless-splice
systemctl start xray-mini@vless-direct
systemctl start xray-mini@vless-splice
systemctl restart xray-mini@vless-direct
systemctl restart xray-mini@vless-splice

clear
echo " ลบบัญชีเรียบร้อยแล้ว"
echo " **************************"
echo " ชื่อ          : $user"
echo " วันหมดอายุ​    : $exp"
echo " **************************"
echo " สคริปโดยเอเจ" 
