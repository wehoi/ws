#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
clear
tls="$(cat ~/log-install.txt | grep -w "Vless TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vless None TLS" | cut -d: -f2|sed 's/ //g')"
echo -e "***************************************"
echo -e ""
echo -e "     [1]  เปลี่ยนพอร์ต Vless TLS $tls"
echo -e "     [2]  เปลี่ยนพอร์ต Vless None TLS $none"
echo -e "     [x]  ออก"
echo -e "***************************************"
echo -e ""
read -p "    โปรดเลือกออปชั่นที่ต้องการ [1-2 หรือ x] :  " prot
echo -e ""
case $prot in
1)
read -p "พอร์ต​ใหม่: " tls1
if [ -z $tls1 ]; then
echo "โปรดระบุพอร์ตที่ต้องการ"
exit 0
fi
cek=$(netstat -nutlp | grep -w $tls1)
if [[ -z $cek ]]; then
sed -i "s/$tls/$tls1/g" /etc/v2ray/vless.json
sed -i "s/   - V2RAY Vless TLS         : $tls/   - V2RAY Vless TLS         : $tls1/g" /root/log-install.txt
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $tls -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $tls -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $tls1 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $tls1 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
systemctl restart v2ray@vless > /dev/null
echo -e "\e[032;1mพอร์ต $tls1 แก้ไขสำเร็จแล้ว\e[0m"
else
echo "พอร์ต $tls1 ถูกใช้งานแล้ว"
fi
;;
2)
read -p "พอร์ตใหม่: " none1
if [ -z $none1 ]; then
echo "โปรดระบุพอร์ตที่ต้องการ"
exit 0
fi
cek=$(netstat -nutlp | grep -w $none1)
if [[ -z $cek ]]; then
sed -i "s/$none/$none1/g" /etc/v2ray/vnone.json
sed -i "s/   - V2RAY Vless None TLS    : $none/   - V2RAY Vless None TLS    : $none1/g" /root/log-install.txt
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $none -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $none -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $none1 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $none1 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
systemctl restart v2ray@vnone > /dev/null
echo -e "\e[032;1mพอร์ต $none1 แก้ไขสำเร็จแล้ว\e[0m"
else
echo "พอร์ต $none1 ถูกใช้งานแล้ว"
fi
;;
x)
exit
menu
;;
*)
echo "โปรดเลือกคำสั่งให้ถูกต้อง"
;;
esac
