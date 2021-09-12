#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
clear
read -p "         ชื่อ       :  " User
egrep "^$User" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
read -p "         จำนวนวันที่ต้องการเพิ่ม     :  " Days
Today=`date +%s`
Days_Detailed=$(( $Days * 86400 ))
Expire_On=$(($Today + $Days_Detailed))
Expiration=$(date -u --date="1970-01-01 $Expire_On sec GMT" +%Y/%m/%d)
Expiration_Display=$(date -u --date="1970-01-01 $Expire_On sec GMT" '+%d %b %Y')
passwd -u $User
usermod -e  $Expiration $User
egrep "^$User" /etc/passwd >/dev/null
echo -e "$Pass\n$Pass\n"|passwd $User &> /dev/null
clear
echo -e ""
echo -e "****************************************"
echo -e ""
echo -e "    ชื่อ​            :  $User"
echo -e "    จำนวนวันที่เพิ่ม    :  $Days วัน"
echo -e "    วันหมดอายุ      :  $Expiration_Display" 
echo -e ""
echo -e "****************************************"
echo -e "สคริปโดยเอเจ" 
else
clear
echo -e ""
echo -e "****************************************"
echo -e ""
echo -e "        ไม่มีบัญชีในระบบ        "
echo -e ""
echo -e "****************************************"
fi
