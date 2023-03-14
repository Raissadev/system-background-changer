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

# run in background
nohup bash -c "\
	while true; do \
		FILE=\$(ls $_path/* | shuf -n1); \
		gsettings set org.gnome.desktop.background picture-uri \"file://\$FILE\"; \
		sleep $tim; \
	done" > "$LOG_FILE" 2>&1 &
