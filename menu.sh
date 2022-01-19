#!/bin/bash
clear
# VPS Information
Checkstart1=$(ip route | grep default | cut -d ' ' -f 3 | head -n 1);
if [[ $Checkstart1 == "venet0" ]]; then 
    clear
	  lan_net="venet0"
    typevps="OpenVZ"
    sleep 1
else
    clear
		lan_net="eth0"
    typevps="KVM"
    sleep 1
fi
clear
# DNS Patch
tipeos2=$(uname -m)
# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"
# Download
download=`grep -e "lo:" -e "wlan0:" -e "eth0" /proc/net/dev  | awk '{print $2}' | paste -sd+ - | bc`
downloadsize=$(($download/1073741824))
# Upload
upload=`grep -e "lo:" -e "wlan0:" -e "eth0" /proc/net/dev | awk '{print $10}' | paste -sd+ - | bc`
uploadsize=$(($upload/1073741824))
# Getting CPU Information
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
cpu_usage+=" %"
# Shell Version
shellversion=""
shellversion=Bash
shellversion+=" Version" 
shellversion+=" ${BASH_VERSION/-*}" 
versibash=$shellversion
# Getting OS Information
source /etc/os-release
Versi_OS=$VERSION
ver=$VERSION_ID
Tipe=$NAME
URL_SUPPORT=$HOME_URL
basedong=$ID
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
WKT=$(curl -s ipinfo.io/timezone )
domain=$(cat /etc/v2ray/domain)
Sver=$(cat /home/version)
tele=$(cat /home/contact)
DAY=$(date +%A)
DATE=$(date +%m/%d/%Y)
IPVPS=$(curl -s ipinfo.io/ip )
	cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
	cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
	freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
	tram=$( free -m | awk 'NR==2 {print $2}' )
	uram=$( free -m | awk 'NR==2 {print $3}' )
	fram=$( free -m | awk 'NR==2 {print $4}' )
	swap=$( free -m | awk 'NR==4 {print $2}' )
echo -e "************************************************************" | lolcat
echo -e "***********************  ยินดีต้อนรับ **************************" | lolcat
echo -e "*********************** สคริปโดย AJ *************************" | lolcat
echo -e "************************************************************" | lolcat
echo -e "                       ข้อมูลระบบ"
	echo -e "    VPS Type             :  $typevps"
	echo -e "    CPU Model            :  $cname"
	echo -e "    CPU Frequency        :  $freq MHz"
	echo -e "    Number Of Cores      :  $cores"
	echo -e "    CPU Usage            :  $cpu_usage"
	echo -e "    Operating System     :  "`hostnamectl | grep "Operating System" | cut -d ' ' -f5-`
	echo -e "    OS Family            :  `uname -s`"	
	echo -e "    Kernel               :  `uname -r`"
	echo -e "    Bash Ver             :  $versibash"
	echo -e "    Total Amount Of RAM  :  $tram MB"
	echo -e "    Used RAM             :  $uram MB"
	echo -e "    Free RAM             :  $fram MB"
	echo -e "    System Uptime        :  $uptime $DF( From VPS Booting )"
	echo -e "    Download             :  $downloadsize GB ( From Startup / VPS Booting )"
	echo -e "    Upload               :  $uploadsize GB ( From Startup / VPS Booting )"
	echo -e "    Isp Name             :  $ISP"
	echo -e "    Domain               :  $domain"	
        echo -e "    Ip Vps               :  $IPVPS"	
	echo -e "    City                 :  $CITY"
	echo -e "    Time                 :  $WKT"
	echo -e "    Day                  :  $DAY"
	echo -e "    Date                 :  $DATE"
	echo -e "    Telegram             :  @yallaaj"
echo -e "************************************************************" | lolcat
echo -e "* menu         : สารบัญคำสั่ง"
echo -e "************************************************************" | lolcat
echo -e "                     SSH AND OPENVPN"
echo -e "* new          : สร้างบัญชี SSH & OpenVPN"
echo -e "* renew        : ต่ออายุบัญชี SSH & OpenVPN"
echo -e "* deluser      : ลบบัญชี SSH & OpenVPN"
echo -e "* check        : แสดงบัญชีผู้ใช้งาน SSH & OpenVPN"
echo -e "* user         : แสดงบัญชี SSH & OpenVPN ทั้งหมด"
echo -e "* delete       : ลบบัญชี SSH & OpenVPN ที่หมดอายุแล้ว"
echo -e "* autokill     : ตั้งค่าการเข้าใช้งานหลายบัญชี"
echo -e "* multi        : แสดงบัญชีที่เข้าใช้งานหลายเครื่อง"
echo -e "* restart      : รีสตาร์ท  Dropbear, Squid3, OpenVPN และ SSH"
echo -e "************************************************************" | lolcat
echo -e "                     VMESS"
echo -e "* vr           : สร้างบัญชี VMESS"
echo -e "* vrd          : ลบบัญชี VMESS"
echo -e "* vrc          : ตรวจสอบผู้ใช้งานบัญชี VMESS"             
echo -e "* vrr          : ต่ออายุบัญชี VMESS"                     
echo -e "************************************************************" | lolcat                  
echo -e "                     VLESS"
echo -e "* vs           : สร้างบัญชี VLESS"
echo -e "* vsd          : ลบบัญชี VLESS"
echo -e "* vsc          : ตรวจสอบผู้ใช้งานบัญชี VLESS"             
echo -e "* vsr          : ต่ออายุบัญชี VLESS"
echo -e "************************************************************"  | lolcat
echo -e "                     TROJAN"
echo -e "* tj           : สร้างบัญชี TROJAN"
echo -e "* tjd          : ลบบัญชี TROJAN"
echo -e "* tjc          : ตรวจสอบผู้ใช้งานบัญชี TROJAN"             
echo -e "* trr          : ต่ออายุบัญชี TROJAN"
echo -e "************************************************************" | lolcat
echo -e "                     XRAY"
echo -e "* vxr          : สร้างบัญชี XRAY"
echo -e "* vxrd         : ลบบัญชี XRAY"             
echo -e "* vxrr         : ต่ออายุบัญชี XRAY"
echo -e "************************************************************" | lolcat     
echo -e "                    ตั้งค่าระบบ"
echo -e "* cert         : ต่ออายุ Certificate ของบัญชี V2ray" 
echo -e "* port         : แก้ไขหรือเปลี่ยนพอร์ต"
echo -e "* web          : ติดตั้ง Webmin"
echo -e "* reboot       : รีบูตเครื่อง"
echo -e "* speedtest    : ตรวจสอบความเร็วเซิฟเวอร์"
echo -e "* info         : แสดงข้อมูลระบบ"
echo -e "* exit         : ออกจากระบบ"
echo -e "************************************************************" | lolcat
echo -e " ขอบคุณมากที่ใช้บริการของเรา"
echo -e " Copyright ©AJ"
echo -e ""
