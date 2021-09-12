#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
clear
tr="$(cat ~/log-install.txt | grep -i Trojan | cut -d: -f2|sed 's/ //g')"
echo -e "      เปลี่ยนพอร์ต $tr"
read -p "พอร์ตใหม่: " tr2
if [ -z $tr2 ]; then
echo "โปรดระบุพอร์ตที่ต้องการ"
exit 0
fi
cek=$(netstat -nutlp | grep -w $tr2)
if [[ -z $cek ]]; then
sed -i "s/$tr/$tr2/g" /etc/trojan/config.json
sed -i "s/   - Trojan                  : $tr/   - Trojan                  : $tr2/g" /root/log-install.txt
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $tr -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $tr -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $tr2 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $tr2 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
systemctl restart trojan > /dev/null
echo -e "\e[032;1mพอร์ต $tr2 แก้ไขสำเร็จแล้ว\e[0m"
else
echo "พอร์ต​ $tr2 ถูกใช้งานแล้ว"
fi
