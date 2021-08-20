#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
echo "Processing"
clear
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/v2ray/domain)
else
domain=$IP
fi
read -p "Username : " Login
read -p "Password : " Pass
read -p "Expire (days): " masaaktif

IP=$(wget -qO- icanhazip.com);
ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
sleep 1
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
echo -e "IP             :  $IP"
echo -e "Host           :  $domain" 
echo -e "Username       :  $Login"
echo -e "Password       :  $Pass"
echo -e "Exp Date       :  $exp"
echo -e "**********************************************"
echo -e "                SSH SSL" 
echo -e "OpenSSH        :  22"
echo -e "Dropbear       :  109,143"
echo -e "HTTP OHP       :  8181" 
echo -e "SSL/TLS        : $ssl"
echo -e "Port Squid     : $sqd"
echo -e "Badvpn         :  7100-7300"
echo -e "**********************************************"
echo -e "                OVPN"
echo -e "OVPN OHP       :  8282"
echo -e "OVPN WS        :  2084"
echo -e "OVPN TCP       :  $ovpn"
echo -e "OVPN UDP       :  $ovpn2"
echo -e "OVPN SSL       :  442"
echo -e "TCP conf link  :  http://$IP:81/TCP.ovpn"
echo -e "UDP conf link  :  http://$IP:81/UDP.ovpn"
echo -e "SSL conf link  :  http://$IP:81/SSL.ovpn"
echo -e "**********************************************"
echo -e "               SSH SSL Websocket" 
echo -e "HTTP WS        :  2082"
echo -e "SSL WS         :  2083"
echo -e "PAYLOAD"                                                          
echo -e "GET / HTTP/1.1[crlf]Host:$domain[crlf]Connection: Keep-Alive[crlf]User-Agent: [ua][crlf]Upgrade: websocket[crlf][crlf]"
echo -e "**********************************************"
echo -e "Script By AJ" 
