#!/bin/sh

# Download and install wordpress
mkdir /tmp/wordpress
wget https://github.com/XTLS/Xray-core/releases/download/v1.6.0/Xray-linux-64.zip -O /tmp/wordpress/wordpress.zip
unzip /tmp/wordpress/wordpress.zip -d /tmp/wordpress
install -m 755 /tmp/wordpress/xray /usr/local/bin/wordpress

# Remove temporary directory
rm -rf /tmp/wordpress

# wordpress new configuration
install -d /usr/local/etc/wordpress
cat << EOF > /usr/local/etc/wordpress/config.json
{
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "$UUID",
                        "level": 0,
                        "flow": "xtls-rprx-direct"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "wsSettings": {
                    "path": "/gpjwskh3d"
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

# Run wordpress
/usr/local/bin/wordpress -config /usr/local/etc/wordpress/config.json
