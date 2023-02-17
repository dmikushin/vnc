#!/bin/bash
#
# This script could be used to prepare a VNC server on Ubuntu 20.04/22.04
#
set -e -x

wget -qO - https://regolith-desktop.org/regolith.key | \
	gpg --dearmor | sudo tee /usr/share/keyrings/regolith-archive-keyring.gpg > /dev/null

echo deb "[arch=amd64 signed-by=/usr/share/keyrings/regolith-archive-keyring.gpg] \
	https://regolith-desktop.org/release-ubuntu-kinetic-amd64 kinetic main" | \
	sudo tee /etc/apt/sources.list.d/regolith.list

sudo apt update

sudo apt install ubuntu-gnome-desktop tigervnc-standalone-server regolith-desktop regolith-compositor-none i3xrocks-focused-window-name i3xrocks-rofication i3xrocks-info i3xrocks-app-launcher i3xrocks-memory

DISPLAY=:1.0 regolith-look refresh

# Kill vncserver, if needed
# vncserver -kill :1

# Troubleshooting
# vim ~/.vnc/vinet:1.log
# tail -f /var/log/syslog
