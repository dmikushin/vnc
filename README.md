# One-liner to connect to VNC in the same way as to SSH

Connect to VNC server with Remmina as specified in the given .json configuration.

The VNC server should be running locally on the remove SSH server. This script performs SSH-tunnelled VNC port forwarding, and then opens VNC session with Remmina.

## Client Installation

```
sudo apt install remmina make python3-pip
sudo pip3 install command_runner
sudo make install_client
```

Usage:

1. Provide an `.ssh/config` connection rule to connect to your SSH server as `ssh my_ssh_server`
2. Provide `.vnc/my_ssh_server` file with the following:

```
{
    "server": "my_ssh_server",
    "server_port": "5901",
    "client_port": "15901"
}
```

Adjust server port to the actually used VNC server port, and make sure the client port is free on your client machine.

3. Connect to the VNC server:

```
vnc my_ssh_server
```

## Server Installation

Visit `vncserver_setup.sh` script for initial setup of Regolith Desktop, then continue with the following:

```
sudo make install_server
```

Usage: create a user account, preconfigured for VNC desktop broadcast, and start it (managed by systemd service):

```
vncuseradd johnsmith
```

