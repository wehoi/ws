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
tls="$(cat ~/log-install.txt | grep -w "Vless TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vless None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "ชื่อ: " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/v2ray/vless.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "มีชื่อในระบบแล้ว โปรดเลือกชื่ออื่น."
			exit 1
		fi
	done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "จำนวนวันใช้งาน: " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#tls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/v2ray/vless.json
sed -i '/#none$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/v2ray/vnone.json
vlesslink1="vless://${uuid}@${domain}:$tls?path=/v2ray&security=tls&encryption=none&type=ws#${user}"
vlesslink2="vless://${uuid}@${domain}:$none?path=/v2ray&encryption=none&type=ws#${user}"
systemctl restart v2ray@vless
systemctl restart v2ray@vnone
clear
echo -e ""
echo -e "*********************************"
echo -e "         ขู้อมูลบัญชี"
echo -e ""
echo -e "ชื่อ​             : ${user}"
echo -e "โดเมน​           : ${domain}"
echo -e "TLS พอร์ต       : $tls"
echo -e "HTTP พอร์ต      : $none"
echo -e "ไอดี            : ${uuid}"
echo -e "รหัสลับ​          : none"
echo -e "เน็ตเวิร์ค​         : ws"
echo -e "เส้นทาง          : /v2ray"
echo -e "วันหมดอายุ​       : $exp"
echo -e "*********************************"
echo -e "ลิงค์​ TLS​        : ${vlesslink1}"
echo -e "*********************************"
echo -e "ลิงค์​ HTTP     ​   : ${vlesslink2}"
echo -e "*********************************"
echo -e "สคริปโดยเอเจ" 
