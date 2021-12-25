source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/v2ray/domain)
else
domain=$IP
fi
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do                read -rp "User: " -e user
                CLIENT_EXISTS=$(grep -w $user /etc/v2ray/trojan.json | wc -l)

                if [[ ${CLIENT_EXISTS} == '1' ]]; then
                        echo ""
                        echo "A client with the specified name was already created, please choose another name."
                        exit 1
                fi
        done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#tls$/a\### '"$user $exp"'\
},{"password": "'""$user""'","email": "'""$user""'"' /etc/v2ray/trojan.json
systemctl restart v2ray@trojan
trojanlink="trojan://${user}@${domain}:443"
clear
echo -e ""
echo -e "___________vpn trojan___________"
echo -e "Remarks        : ${user}"
echo -e "Host/IP        : ${domain}"
echo -e "port           : 443"
echo -e "Key            : ${user}"
echo -e "link           : ${trojanlink}"
echo -e "________________________________"
echo -e "Expired On     : $exp"
echo -e "By java"
