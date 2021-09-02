#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
echo "กำลังดำเนินการ"
clear
uuid=$(cat /etc/trojan/uuid.txt)
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/v2ray/domain)
else
domain=$IP
fi
tr="$(cat ~/log-install.txt | grep -i Trojan | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
		read -rp "รหัสผ่าน: " -e user
		user_EXISTS=$(grep -w $user /etc/trojan/akun.conf | wc -l)

		if [[ ${user_EXISTS} == '1' ]]; then
			echo ""
			echo "มีชื่อในระบบแล้ว โปรดเลือกชื่ออื่น."
			exit 1
		fi
	done
read -p "จำนวนวันใช้งาน: " masaaktif
sed -i '/"'""$uuid""'"$/a\,"'""$user""'"' /etc/trojan/config.json
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
echo -e "### $user $exp" >> /etc/trojan/akun.conf
systemctl restart trojan
trojanlink="trojan://${user}@${domain}:${tr}"
clear
echo -e ""
echo -e "*********************************"
echo -e "         ข้อมูลบัญชี"
echo -e ""
echo -e "ชื่อ​           : ${user}"
echo -e "โฮสต์​         : ${domain}"
echo -e "พอร์ต         : ${tr}"
echo -e "คีย์​           : ${user}"
echo -e "วันหมดอายุ​     : $exp"
echo -e "ลิงค์​          : ${trojanlink}"
echo -e "*********************************"
echo -e "สคริปโดยเอเจ" 
