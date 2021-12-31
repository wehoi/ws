#!/bin/bash
direct="$(cat ~/log-install.txt | grep -w "XRAY DIRECT" | cut -d: -f2|sed 's/ //g')"
echo -e "พอร์ต​ใหม่ $direct"
read -p "โปรดระบุพอร์ตที่ต้องการ: " direct1
if [ -z $direct1 ]; then
echo "Please Input Port"
exit 0
fi

cek=$(netstat -nutlp | grep -w $direct1)
if [[ -z $cek ]]; then
sed -i "s/$direct/$direct1/g" /etc/xray-mini/vless-direct.json
sed -i "s/   - XRAY DIRECT             : $direct/   - XRAY DIRECT             : $direct1/g" /root/log-install.txt
sed -i "s/   - XRAY SPLICE             : $direct/   - XRAY SPLICE             : $direct1/g" /root/log-install.txt
systemctl stop xray-mini@vless-direct > /dev/null
systemctl enable xray-mini@vless-direct > /dev/null
systemctl start xray-mini@vless-direct > /dev/null
systemctl stop xray-mini@vless-splice > /dev/null
systemctl enable xray-mini@vless-splice > /dev/null
systemctl start xray-mini@vless-splice > /dev/null


echo -e "\e[032;1mพอร์ต $direct1 แก้ไขสำเร็จแล้ว\e[0m"
else
echo "พอร์ต $direct1 ถูกใช้งานแล้ว"
fi
