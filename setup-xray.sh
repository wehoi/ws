#!/bin/bash
# ===================================
# Xray Quick Setup
# Auther : AJ
# ===================================

# // Silakan Isi Bawah Ini
export port='443' # >> Port Vless RPRX Direct
export Cert_path='etc/v2ray/v2ray.crt' # >> Certificate Path
export Cert_Key_Path='/etc/v2ray/v2ray.key' # >> Certificate Key Path
export Your_Domain='/etc/v2ray/domain' # >> Your Domain

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
Documentation=https://kdev.my.id
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
      "port": ${port},
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
              "certificateFile": "${Cert_path}",
              "keyFile": "${Cert_Key_Path}"
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

systemctl disable xray
systemctl stop xray
systemctl enable xray
systemctl start xray
cd /usr/bin

#Add & Del 
wget -O xr "https://github.com/wehoi/ws/raw/main/addxray.sh"
wget -O xrd "https://githubuser.com/wehoi/ws/raw/main/delxray.sh"
wget -O xrr "https://github.com/wehoi/ws/main/raw/renewxray.sh"

chmod +x xr
chmod +x xrd
chmod +x xrr
cd
rm -f setup-xray.sh
