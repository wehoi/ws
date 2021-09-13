#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
clear
ssl="$(cat /etc/stunnel/stunnel.conf | grep -i accept | head -n 2 | cut -d= -f2 | sed 's/ //g' | tr '\n' ' ' | awk '{print $1}')"
ssl2="$(cat /etc/stunnel/stunnel.conf | grep -i accept | head -n 2 | cut -d= -f2 | sed 's/ //g' | tr '\n' ' ' | awk '{print $2}')"
echo -e "**************************************"
echo -e "             สคริปโดยเอเจ"​
echo -e ""
echo -e "     [1]  เปลี่ยนพอร์ต $ssl"
echo -e "     [2]  เปลี่ยนพอร์ต $ssl2"
echo -e "     [x]  ออก"
echo -e "**************************************"
echo -e ""
read -p "   โปรดเลือกออปชั่นที่ต้องการ  [1-2 หรือ x] :  " prot
echo -e ""
case $prot in
1)
read -p "พอร์ตใหม่: " stl
if [ -z $stl ]; then
echo "โปรดระบุพอร์ตที่ต้องดาร"
exit 0
fi
cek=$(netstat -nutlp | grep -w $stl)
if [[ -z $cek ]]; then
sed -i "s/$ssl/$stl/g" /etc/stunnel/stunnel.conf
sed -i "s/   - Stunnel4                : $ssl, $ssl2/   - Stunnel4                : $stl, $ssl2/g" /root/log-install.txt
/etc/init.d/stunnel4 restart > /dev/null
echo -e "\e[032;1mพอร์ต $stl แก้ไขสำเร็จแล้ว\e[0m"
else
echo "พอร์ต $stl ถูกใช้งานแล้ว"
fi
;;
2)
read -p "พอร์ตใหม่: " stl
if [ -z $stl ]; then
echo "โปรดระบุพอร์ตที่ต้องการ"
exit 0
fi
cek=$(netstat -nutlp | grep -w $stl)
if [[ -z $cek ]]; then
sed -i "s/$ssl2/$stl/g" /etc/stunnel/stunnel.conf
sed -i "s/   - Stunnel4                : $ssl, $ssl2/   - Stunnel4                : $ssl, $stl/g" /root/log-install.txt
/etc/init.d/stunnel4 restart > /dev/null
echo -e "\e[032;1mพอร์ต $stl แก้ไขสำเร็จแล้ว\e[0m"
else
echo "พอร์ต $stl ถูกใช้งานแล้ว"
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
