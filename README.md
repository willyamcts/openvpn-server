# OpenVPN Server
OpenVPN server implementation basic and configuration specific by client

# Setup
The requirements are incorporated into scripts, but to follow the guidelines exactly you need to have Docker installed. Guide for Docker instalation [here](https://docs.docker.com/engine/install/), for Debian [here](https://raw.githubusercontent.com/willyamcts/openvpn-server/refs/heads/test/test/docker.install)

```
apt update
apt install -y git logrotate

git clone <this repository>
cp openvpn-server/openvpn.rotate /etc/logrotate.d/
```

# Suggestions for improvements 
Suggestions are welcome, use language PT-BR or EN, open the issue please and select correct tag (improvement, bug, ...)
