#!/bin/bash
# ===================================
# Xray Quick Setup
# Auther : AJ
# ===================================


# // Creating UUID
export uuid=$(cat /proc/sys/kernel/random/uuid)

# // Installing Requirement
apt update -y
apt upgrade  -y
apt install zip unzip gzip curl wget nano vim -y

# // Downloading Core
wget -O /usr/local/xray "https://raw.githubusercontent.com/wehoi/ws/main/xray-mini"
chmod +x /usr/local/xray
# // Make Config Folder
mkdir -p /etc/xray/
mkdir -p /var/log/xray/
touch acces.log
touch error.log
touch trojan-acces.log
touch trojan-error.log
cd

# // Installing Service
cat > /etc/systemd/system/xray.service << END
[Unit]
Description=XRay 
Documentation=https://sydjwd.live
After=syslog.target network-online.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/xray -c /etc/xray/xrayxtls.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
END

# // XRay XTLS RPRX Direct
cat > /etc/xray/xrayxtls.json << END
{
  "inbounds": [
    {
      "port": 443,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid}",
            "flow": "xtls-rprx-direct"
#XRay
          }
        ],
        "decryption": "none",
        "fallbacks": [
          {
            "dest": 60000,
            "alpn": "",
            "xver": 1
          },
          {
            "dest": 60001,
            "alpn": "h2",
            "xver": 1
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "xtls",
        "xtlsSettings": {
          "minVersion": "1.2",
          "certificates": [
            {
              "certificateFile": "etc/v2ray/v2ray.crt",
              "keyFile": "/etc/v2ray/v2ray.key}"
            }
          ]
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
END
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 443 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
systemctl daemon-reload
systemctl disable xray
systemctl stop xray
systemctl enable xray
systemctl start xray
cd /usr/bin

#Add & Del 
wget -O xrr "https://github.com/wehoi/ws/raw/main/addxray.sh"
wget -O xrrd "https://github.com/wehoi/ws/raw/main/delxray.sh"
wget -O xrrr "https://github.com/wehoi/ws/main/raw/renewxray.sh"

chmod +x xrr
chmod +x xrrd
chmod +x xrrr
cd
rm -f setup-xray.sh
