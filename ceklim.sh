#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
clear
echo " "
echo "*******************************************";
echo " ";
if [ -e "/root/log-limit.txt" ]; then
echo "ผู้ใช้งานที่ละเมิดกฎ";
echo "Time - Username - Number of Multilogin"
echo "-------------------------------------";
cat /root/log-limit.txt
else
echo " ไม่มีผู้ใช้งานที่ละเมิดกฎ"
echo " "
echo " or"
echo " "
echo " The user-limit script not been executed."
fi
echo " ";
echo "*******************************************";
echo " ";
