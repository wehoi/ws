#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
clear
IP=$(wget -qO- icanhazip.com);
ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
Login=trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
hari="1"
Pass=1
echo Ping Host
echo Permission validating...
sleep 0.5
echo Permission accepted
clear
sleep 0.5
echo Creating account: $Login
sleep 0.5
echo Generating password: $Pass
sleep 0.5
clear
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "**********************************************"
echo -e "                 Account Details"
echo -e "Domain     :  ${domain}"
echo -e "Host       :  $IP"
echo -e "Username   :  $Login"
echo -e "Password   :  $Pass"
echo -e "OpenSSH    :  22"
echo -e "Dropbear   :  109, 143"
echo -e "SSL/TLS    : $ssl"
echo -e "Port Squid : $sqd"
echo -e "Badvpn     :  7100-7300"
echo -e "Exp date   :  $exp"
echo -e ""
echo -e "**********************************************"
echo -e "           Ovpn Config Download Link"
echo -e "TCP :  $ovpn  http://$IP:81/TCP.ovpn"
echo -e "UDP :  $ovpn2 http://$IP:81/UDP.ovpn"
echo -e "SSL :  442    http://$IP:81/SSL.ovpn"
echo -e ""
echo -e "**********************************************"


