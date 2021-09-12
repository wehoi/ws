#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
clear
echo -e ""
echo -e "*************************************"
echo -e "          สคริปโดยเอเจ"​
echo -e ""
echo -e "    [1] รีสตาร์ท​ทั้งหมด"
echo -e "    [2] รีสตาร์ท​ OpenSSH"
echo -e "    [3] รีสตาร์ท​ Dropbear"
echo -e "    [4] รีสตาร์ท​ Stunnel4"
echo -e "    [5] รีสตาร์ท​ OpenVPN"
echo -e "    [6] รีสตาร์ท​ Squid"
echo -e "    [7] รีสตาร์ท​ Nginx"
echo -e "    [8] รีสตาร์ท​ Badvpn"
echo -e "    [x] ออก"
echo -e ""
read -p "    เลือกจาก [1-8 หรือ x] :  " Restart
echo -e ""
echo -e "**************************************"
sleep 1
clear
case $Restart in
                1)
                clear
                /etc/init.d/ssh restart
                /etc/init.d/dropbear restart
                /etc/init.d/stunnel4 restart
                /etc/init.d/openvpn restart
                /etc/init.d/fail2ban restart
                /etc/init.d/cron restart
                /etc/init.d/nginx restart
                /etc/init.d/squid restart
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000
                echo -e ""
                echo -e "**************************************"
                echo -e ""
                echo -e "          Service/s Restarted         "
                echo -e ""
                echo -e "**************************************"
                exit
                ;;
                2)
                clear
                /etc/init.d/ssh restart
                echo -e ""
                echo -e "**************************************"
                echo -e ""
                echo -e "         SSH Service Restarted        "
                echo -e ""
                echo -e "**************************************"
                exit
                ;;
                3)
                clear
                /etc/init.d/dropbear restart
                echo -e ""
                echo -e "**************************************"
                echo -e ""
                echo -e "       Dropbear Service Restarted     "
                echo -e ""
                echo -e "**************************************"
                exit
                ;;
                4)
                clear
                /etc/init.d/stunnel4 restart
                echo -e ""
                echo -e "**************************************"
                echo -e ""
                echo -e "        Stunnel4 Service Restarted    "
                echo -e ""
                echo -e "**************************************"
                exit
                ;;
                5)
                clear
                /etc/init.d/openvpn restart
                echo -e ""
                echo -e "**************************************"
                echo -e ""
                echo -e "       OpenVPN Service Restarted      "
                echo -e ""
                echo -e "**************************************"
                exit
                ;;
                6)
                clear
                /etc/init.d/squid restart
                echo -e ""
                echo -e "**************************************"
                echo -e ""
                echo -e "        Squid3 Service Restarted      "
                echo -e ""
                echo -e "**************************************"
                exit
                ;;
                7)
                clear
                /etc/init.d/nginx restart
                echo -e ""
                echo -e "**************************************"
                echo -e ""
                echo -e "         Nginx Service Restarted      "
                echo -e ""
                echo -e "**************************************"
                exit
                ;;
                8)
                clear
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500
                echo -e ""
                echo -e "**************************************"
                echo -e ""
                echo -e "    Badvpn  Badvpn Service Restarted  "
                echo -e ""
                echo -e "**************************************"
                exit
                ;;
                x)
                clear
                exit
                ;;
        esac
