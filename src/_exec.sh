#!/bin/bash

read -p "Time: " tim
read -p "Folder: " _path

tim=$((tim * 60))
LOG_FILE="/tmp/log_wallpapers_s"

if [ -z "$tim" ]; then
    echo "Error: time interval is empty"
    exit 1
fi

if [ -z "$_path" ]; then
	echo "Error: folder is empty"
	exit 1
elif [ -d $_path ]; then
	echo $_path
else
	echo "Not is folder. Tent ./imgs-ex"
	exit 1
fi

cat > /etc/systemd/system/sys-background-manager.service <<EOF
[Unit]
Description=Random wallpaper changer
After=network-online.target

[Service]
Type=simple
User=$(whoami)
ExecStart=/bin/bash /usr/local/bin/sys-background-manager.sh
Restart=always
RestartSec=60

[Install]
WantedBy=multi-user.target
EOF

# run in background
cat > /usr/local/bin/sys-background-manager.sh <<EOF
#!/bin/bash

while true; do
    FILE=\$(ls $_path/* | shuf -n1)
    gsettings set org.gnome.desktop.background picture-uri "file://\$FILE"
    sleep $tim
done
EOF

chmod +x /usr/local/bin/sys-background-manager.sh
systemctl daemon-reload

echo "Wallpaper changer service created successfully."
echo "To start the service, run 'systemctl start wallpaper'"