#!/bin/bash
# Renew xray
# ===============

# Color
RED="\e[1;31m"
GREEN="\e[0;32m"
NC="\e[0m"

# Validate Your IP Address
MYIP=$(wget -qO- icanhazip.com);
echo "Checking Auth For Permission"
IZIN=$( curl -s script.pakya.my.id/License/auth.txt | grep $MYIP )
if [[ $MYIP == "" ]]; then
    echo "No Database Founded !"
    exit 1
elif [[ $MYIP = $IZIN ]]; then
    echo -e "${GREEN}Granted !${NC} Your IP Adress Is Registered"
else
    echo -e "${RED}Denied !${NC} Your IP Adress Is Not Registered";
    echo "Please Contact Admin For Buying Scripts"
    exit 0
fi
clear
CLIENT_001=$( grep -c -E "^#DEPAN " "/etc/xray-mini/config.json" )
echo "    =================================================="
echo "               LIST VLESS CLIENT ON THIS VPS"
echo "    =================================================="
grep -e "^#DEPAN " "/etc/xray-mini/config.json" | cut -d ' ' -f 2-8 | nl -s ') '
	until [[ ${CLIENT_002} -ge 1 && ${CLIENT_002} -le ${CLIENT_001} ]]; do
		if [[ ${CLIENT_002} == '1' ]]; then
                echo "    =================================================="
			read -rp "    Please Input an Client Number (1-${CLIENT_001}) : " CLIENT_002
		else
                echo "    =================================================="
			read -rp "    Please Input an Client Number (1-${CLIENT_001}) : " CLIENT_002
		fi
	done

# // Clear
clear
clear && clear && clear
clear;clear;clear

# // Expired Date
read -p "Expired  : " Jumlah_Hari

user=$( grep -E "^#DEPAN " "/etc/xray-mini/config.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_002}"p)
exp=$( grep -E "^#DEPAN " "/etc/xray-mini/config.json" | cut -d ' ' -f 8 | sed -n "${CLIENT_002}"p)

# // Date Configration
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $Jumlah_Hari))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`

# // Input To System Configuration
sed -i "s/#DEPAN Username : $user | Expired : $exp/#DEPAN Username : $user | Expired : $exp4/g" /etc/xray-mini/config.json
sed -i "s/#BELAKANG Username : $user | Expired : $exp/#BELAKANG Username : $user | Expired : $exp4/g" /etc/xray-mini/config.json

read -p "Press Enter For Back To XRay Menu/ CTRL+C To Cancel : "
xray-menu