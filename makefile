.PHONY: install install_client install_server

all: install

install: install_client install_server

install_client:
	cp vnc /usr/bin/vnc

install_server:
	cp vncuseradd /usr/bin/vncuseradd
	cp vncserver4user /usr/bin/vncserver4user
	mkdir -p /usr/share/vncuseradd
	cp -rf .config /usr/share/vncuseradd/
	cp -rf .vnc /usr/share/vncuseradd/
	cp -rf vnc.service /usr/share/vncuseradd/
