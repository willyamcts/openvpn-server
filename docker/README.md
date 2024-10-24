# Running docker

```
# 1. prepare
mkdir -p /var/log/openvpn/rotate
#chown openvpn: /var/log/openvpn

# allow forward between interfaces
echo 'net.ipv4.ip_forward = 1' > /etc/sysctl.d/00-custom.conf

# setup firewall rule
## check your interface from access or LAN
my_iface=$(ip route get 1.1.1.1 | awk -F' ' '{print $5}') # or manually "ip -br a sh"

# set forward rule between interfaces
iptables -A FORWARD -i ${my_iface} -o tun+ -j ACCEPT
iptables -A FORWARD -i tun+ -o ${my_iface} -j ACCEPT
```

```
# 2. generate image
docker build . --tag openvpn-custom:v0.1
```

```
# 3. run container
docker run --cap-add=NET_ADMIN --device /dev/net/tun --net host \
 --name openvpn-server \
 -v /var/log/openvpn:/var/log/openvpn \
 -v /etc/cert:/usr/local/openvpn/server/cert \
 openvpn-custom:v0.1
```

## Attention
Your certs CA, CRT and KEY should in path `/etc/cert` from hosting, otherwise change the path in step 3
