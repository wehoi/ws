#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
echo "กำลังดำเนินการ"
clear
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/v2ray/domain)
else
domain=$IP
fi
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "ชื่อ: " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/v2ray/trojan.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "จำนวนวันใช้งาน (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#tls$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/v2ray/trojan.json
systemctl restart v2ray@trojan
trojanlink="trojan://${user}@${domain}:443"
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
