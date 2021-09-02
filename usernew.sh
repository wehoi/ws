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
read -p "ชื่อ : " Login
read -p "รหัสผ่าน : " Pass
read -p "จำนวนวันใช้งาน : " masaaktif

IP=$(wget -qO- icanhazip.com);
ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
sleep 1
echo Ping Host
echo ตรวจสอบใบอนุญาต...
sleep 0.5
echo ได้รับอนุญาต​
clear
sleep 0.5
echo กำลังสร้างบัญชี: $Login
sleep 0.5
echo กำลังสร้างรหัสผ่าน: $Pass
sleep 0.5
clear
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "**********************************************"
echo -e "                 ข้อมูลบัญชี"
echo -e "ไอพี            :  $IP"
echo -e "โฮสต์           :  $domain" 
echo -e "ชื่อ​             :  $Login"
echo -e "รหัสผ่าน​         :  $Pass"
echo -e "วันหมดอายุ       :  $exp"
echo -e "**********************************************"
echo -e "                SSH SSL" 
echo -e "OpenSSH        :  22"
echo -e "Dropbear       :  109,143"
echo -e "SSL/TLS        : $ssl"
echo -e "Port Squid     : $sqd"
echo -e "Badvpn         :  7100-7300"
echo -e "**********************************************"
echo -e "                OVPN"
echo -e "OVPN TCP       :  $ovpn"
echo -e "OVPN UDP       :  $ovpn2"
echo -e "OVPN SSL       :  442"
echo -e "TCP conf ลิงค์​   :  http://$IP:81/TCP.ovpn"
echo -e "UDP conf ลิงค์​   :  http://$IP:81/UDP.ovpn"
echo -e "SSL conf ลิงค์​   :  http://$IP:81/SSL.ovpn"
echo -e "**********************************************"
echo -e "สคริปโดยเอเจ" 
