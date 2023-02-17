.PHONY: install

all: install

install:
	cp vnc /usr/bin/vnc
	cp vncuseradd /usr/bin/vncuseradd
	cp vncserver4user /usr/bin/vncserver4user
	mkdir -p /usr/share/vncuseradd
	cp -rf .config /usr/share/vncuseradd/
	cp -rf .vnc /usr/share/vncuseradd/

