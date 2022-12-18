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

VNCCONF=~/.vnc/tigervnc.conf
touch $VNCCONF
mv $VNCCONF $VNCCONF.bak
echo '$geometry = "1920x1080";' >> $VNCCONF
echo '$localhost = "yes";' >> $VNCCONF
echo '$SecurityTypes = "None";' >> $VNCCONF
echo '1;' >> $VNCCONF

mkdir -p ~/.vnc
touch ~/.vnc/xstartup
mv ~/.vnc/xstartup ~/.vnc/xstartup.bak
echo "#!/bin/bash" >> ~/.vnc/xstartup
#echo "xrdb $HOME/.Xresources" >> ~/.vnc/xstartup
# For 20.04 it was echo "regolith-session &" >> ~/.vnc/xstartup
echo "regolith-session" >> ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup
touch ~/.Xresources

vncserver -SecurityTypes None

mkdir -p ~/.config/regolith2
echo "regolith.wallpaper.file: ~/wallpaper.jpg" >> ~/.config/regolith2/Xresources
echo "regolith.wallpaper.options: stretched" >> ~/.config/regolith2/Xresources
echo "regolith.lockscreen.wallpaper.file: ~/wallpaper.jpg" >> ~/.config/regolith2/Xresources
echo "regolith.lockscreen.wallpaper.options: stretched" >> ~/.config/regolith2/Xresources
echo "i3-wm.mod: Mod1" >> ~/.config/regolith2/Xresources
echo "i3-wm.alt: Mod4" >> ~/.config/regolith2/Xresources

DISPLAY=:1.0 regolith-look refresh

# Kill vncserver, if needed
# vncserver -kill :1

# Troubleshooting
# vim ~/.vnc/vinet:1.log
# tail -f /var/log/syslog
