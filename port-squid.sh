#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
clear
sqd="$(cat /etc/squid/squid.conf | grep -i http_port | awk '{print $2}' | head -n1)"
sqd2="$(cat /etc/squid/squid.conf | grep -i http_port | awk '{print $2}' | tail -n1)"
echo -e "**************************************"
echo -e "             สคริปโดยเอเจ"​
echo -e ""
echo -e "     [1]  เปลี่ยนพอร์ต $sqd"
echo -e "     [2]  เปลี่ยนพอร์ต $sqd2"
echo -e "     [x]  ออก"
echo -e "**************************************"
echo -e ""
read -p "    โปรดเลือกออปชั่นที่ต้องการ [1-2 หรือ x] :  " prot
echo -e ""
case $prot in
1)
read -p "พอร์ตใหม่: " squid
if [ -z $squid ]; then
echo "โปรดระบุพอร์ตที่ต้องการ"
exit 0
fi
cek=$(netstat -nutlp | grep -w $squid)
if [[ -z $cek ]]; then
sed -i "s/$sqd/$squid/g" /etc/squid/squid.conf
sed -i "s/$sqd/$squid/g" /root/log-install.txt
/etc/init.d/squid restart > /dev/null
echo -e "\e[032;1mพอร์ต $squid แก้ไขสำเร็จแล้ว\e[0m"
else
echo "พอร์ต $squid ถูกใช้งานแล้ว"
fi
;;
2)
read -p "พอร์ตใหม่: " squid
if [ -z $squid ]; then
echo "โปรดระบุพอร์ตที่ต้องการ"
exit 0
fi
cek=$(netstat -nutlp | grep -w $squid)
if [[ -z $cek ]]; then
sed -i "s/$sqd2/$squid/g" /etc/squid/squid.conf
sed -i "s/$sqd2/$squid/g" /root/log-install.txt
/etc/init.d/squid restart > /dev/null
echo -e "\e[032;1mพอร์ต $squid แก้ไขสำเร็จแล้ว\e[0m"
else
echo "พอร์ต $squid ถูกใช้งานแล้ว"
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

