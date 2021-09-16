#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
echo "กำลังดำเนินการ"
clear
sleep 1
echo Membuat Directory
mkdir /root/backup
sleep 1
echo Start Backup
clear
cp /etc/passwd backup/
cp /etc/group backup/
cp /etc/shadow backup/
cp /etc/gshadow backup/
cp /etc/ppp/chap-secrets backup/chap-secrets
cp -r /var/lib/premium-script/ backup/premium-script
cp -r /etc/v2ray backup/v2ray
cp -r /home/vps/public_html backup/public_html
cd /root
zip -r backup.zip /root
cp -r backup.zip /home/vps/public_html
cd
clear

echo -e "นี่คือลิงก์แบ๊กอัพของท่าน.

Link download: http://$MYIP:81/backup.zip

หากต้องการรีสโตร์ข้อมูล ท่านสามารถคัดลอกลิงก์นี้แล้วไปวางในหน้าของรีสโตร์ในวีพีเอสของท่าน. 

ขอบคุณที่ใช้บริการของเรา"
echo -e ""
rm -rf /root/backup
rm -r /root/backup.zip
