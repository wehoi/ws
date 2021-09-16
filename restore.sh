#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
echo "ฟังชั่นนี้ใช้ได้เฉพาะการแบ๊กอัพด้วยสคริปนี้"
echo "โปรดใส่ลิงก์แบ๊กอัพของท่าน."
echo "ท่านสามารถตรวจสอบการแบ๊กอัพของท่านในอีเมลของท่านหรือแบ๊กอัพด้วยnginx."
read -rp "Link File: " -e url
wget -O backup.zip "$url"
unzip backup.zip
rm -f backup.zip
sleep 1
echo Start Restore
cd /root/backup
cp passwd /etc/
cp group /etc/
cp shadow /etc/
cp gshadow /etc/
cp chap-secrets /etc/ppp/
cp -r premium-script /var/lib/
cp -r trojan /etc/
cp -r v2ray /etc/
cp -r public_html /home/vps/
cp crontab /etc/
strt
rm -rf /root/backup
rm -f backup.zip
echo Done
