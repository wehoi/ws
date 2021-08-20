#!/bin/bash
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ifconfig.co);
versi=$(cat /home/ver)
if [[ $versi == 1.2 ]]; then
echo "You Have The Latest Version"
exit 0
fi
echo "Start Update"
cd /usr/bin
wget -O menu "https://myserver.aj-net.com/menu.sh"
wget -O usernew "https://myserver.aj-net.com/usernew.sh"
wget -O trial "https://myserver.aj-net.com/trial.sh"
wget -O change-port "https://myserver.aj-net.com/change.sh"
wget -O port-ovpn "https://myserver.aj-net.com/port-ovpn.sh"
wget -O port-ssl "https://myserver.aj-net.com/port-ssl.sh"
wget -O port-wg "https://myserver.aj-net.com/port-wg.sh"
wget -O port-tr "https://myserver.aj-net.com/port-tr.sh"
wget -O port-sstp "https://myserver.aj-net.com/port-sstp.sh"
wget -O port-squid "https://myserver.aj-net.com/port-squid.sh"
wget -O port-ws "https://myserver.aj-net.com/port-ws.sh"
wget -O port-vless "https://myserver.aj-net.com/port-vless.sh"
wget -O wbmn "https://myserver.aj-net.com/webmin.sh"
wget -O xp "https://myserver.aj-net.com/xp.sh"
wget -O limit-speed "https://myserver.aj-net.com/limit-speed.sh"
wget -O add-sstp "https://myserver.aj-net.com/add-sstp.sh"
wget -O add-ws "https://myserver.aj-net.com/add-ws.sh"
wget -O add-vless "https://myserver.aj-net.com/add-vless.sh"
wget -O add-tr "https://myserver.aj-net.com/add-tr.sh"
wget -O del-ws "https://myserver.aj-net.com/del-ws.sh"
wget -O del-vless "https://myserver.aj-net.com/del-vless.sh"
wget -O del-tr "https://myserver.aj-net.com/del-tr.sh"
chmod +x change-port
chmod +x port-ovpn
chmod +x port-ssl
chmod +x port-wg
chmod +x port-sstp
chmod +x port-tr
chmod +x port-squid
chmod +x port-ws
chmod +x port-vless
chmod +x wbmn
chmod +x xp
chmod +x limit-speed
chmod +x del-ws
chmod +x del-vless
chmod +x del-tr
echo "0 5 * * * root clear-log && reboot" > /etc/crontab
echo "0 0 * * * root xp" > /etc/crontab
cd
echo "1.2" > /home/ver
clear
echo " Fix minor Bugs"
echo " Succssfull Update"
echo " Reboot 5 Sec"
sleep 5
rm -f update.sh
reboot
