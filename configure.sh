#!/bin/sh

# Download and install wordpress
mkdir /tmp/wordpress
curl -L -H "Cache-Control: no-cache" -o /tmp/wordpress/wordpress.zip https://github.com/XTLS/Xray-core/releases/download/v1.4.2/Xray-linux-64.zip
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
