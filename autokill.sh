#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
echo "กำลังดำเนินการ"
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[ON]${Font_color_suffix}"
Error="${Red_font_prefix}[OFF]${Font_color_suffix}"
cek=$(grep -c -E "^# Autokill" /etc/cron.d/tendang)
if [[ "$cek" = "1" ]]; then
sts="${Info}"
else
sts="${Error}"
fi
clear
echo -e ""
echo -e "**************************************"
echo -e "             สคริปโดยเอเจ"​
echo -e ""
echo -e "     สถาานะการตัดบัญชีอัตโนมัติ $sts        "
echo -e ""
echo -e "     [1]  ตัดบัญชีหลังจาก 5 นาที"
echo -e "     [2]  ตัดบัญชีหลังจาก 10 นาที"
echo -e "     [3]  ตัดบัญชีหลังจาก 15 นาที"
echo -e "     [4]  ปิดการตัดบัญชีแบบอัตโนมัติ"
echo -e "     [x]  ออก"
echo -e "**************************************"                                                                                                          
echo -e ""
read -p "    โปรดเลือกออปชั่นที่ต้องการ [1-4 หรือ x] :  " AutoKill
read -p "     Multilogin Maximum Number Of Allowed: " max
echo -e ""
case $AutoKill in
                1)
                echo -e ""
                sleep 1
                clear
                echo > /etc/cron.d/tendang
                echo "# Autokill" >>/etc/cron.d/tendang
                echo "*/5 * * * *  root /usr/bin/tendang $max" >>/etc/cron.d/tendang
                echo -e ""
                echo -e "**************************************"
                echo -e ""
                echo -e "      Allowed MultiLogin : $max"
                echo -e "      AutoKill Every     : 5 Minutes"      
                echo -e ""
                echo -e "**************************************"                                                                                                                                 
                exit                                                                  
                ;;
                2)
                echo -e ""
                sleep 1
                clear
                echo > /etc/cron.d/tendang
                echo "# Autokill" >>/etc/cron.d/tendang
                echo "*/10 * * * *  root /usr/bin/tendang $max" >>/etc/cron.d/tendang
                echo -e ""
                echo -e "**************************************"
                echo -e ""
                echo -e "      Allowed MultiLogin : $max"
                echo -e "      AutoKill Every     : 10 Minutes"
                echo -e ""
                echo -e "**************************************"
                exit
                ;;
                3)
                echo -e ""
                sleep 1
                clear
                echo > /etc/cron.d/tendang
                echo "# Autokill" >>/etc/cron.d/tendang
                echo "*/15 * * * *  root /usr/bin/tendang $max" >>/etc/cron.d/tendang
                echo -e ""
                echo -e "**************************************"
                echo -e ""
                echo -e "      Allowed MultiLogin : $max"
                echo -e "      AutoKill Every     : 15 Minutes"
                echo -e ""
                echo -e "**************************************"
                exit
                ;;
                4)
                clear
                echo > /etc/cron.d/tendang
                echo -e ""
                echo -e "**************************************"
                echo -e ""
                echo -e "      AutoKill MultiLogin Turned Off  "
                echo -e ""
                echo -e "**************************************"
                exit
                ;;
                x)
                clear
                exit
                ;;
        esac
