# Running docker

```
# 1. prepare
mkdir -p /var/log/openvpn/rotate
#chown openvpn: /var/log/openvpn

# 2. allow forward between interfaces
echo 'net.ipv4.ip_forward = 1' > /etc/sysctl.d/00-custom.conf

# 3. setup firewall rule - set forward rule between interfaces (do you have should other fw for control traffic I/O, don't worry this rule)
iptables -A FORWARD -o tun+ -j ACCEPT
iptables -A FORWARD -i tun+ -j ACCEPT
```

```
# 4. generate image
cd openvpn-server/docker
docker build . --tag openvpn-custom:v0.1
```

```
# 5. run container
docker run --cap-add=NET_ADMIN --device /dev/net/tun --net host \
 --name openvpn-server \
 -v /var/log/openvpn:/var/log/openvpn \
 -v ./cert:/usr/local/openvpn/server/cert \
 openvpn-custom:v0.1
```

## Attention
Your certs CA, CRT and KEY should in path `<...>/openvpn-server/docker/cert` in your host, otherwise change the path `./cert` in step 5
