# Running docker

```
# prepare
mkdir -p /var/log/openvpn/rotate
#chown openvpn: /var/log/openvpn
```

```
# generate image
docker build . --tag openvpn-custom:v0.1
```

```
# run container
docker run --cap-add=NET_ADMIN --device /dev/net/tun --net host \
 --name openvpn-server \
 -v /var/log/openvpn:/var/log/openvpn \
 -v /etc/cert:/usr/local/openvpn/server/cert \
 openvpn-custom:v0.1
```

```
# check your interface from access and interface tun
ip -br a sh

# set forward rule between interfaces
iptables -A FORWARD -i <iface_network> -o tun0 -j ACCEPT
iptables -A FORWARD -i tun0 -o <iface_network> -j ACCEPT
```
