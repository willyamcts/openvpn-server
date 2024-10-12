#!/bin/bash

# Guides:
# - https://github.com/OpenVPN/openvpn
# - https://community.openvpn.net/openvpn/wiki/Openvpn24ManPage

OPENVPN_VERSION=2.6.12
CONFIG_DIR=/usr/local/openvpn

# requeriments
apt update
apt install gcc pkg-config make \
 libnl-genl-3-dev libcap-ng-dev libssl-dev \
 liblzo2-dev liblz4-dev \
 libpam0g-dev -y

# download openvpn version $OPENVPN_VERSION
cd /usr/src
wget -O openvpn-${OPENVPN_VERSION}.tar.gz \
 https://github.com/OpenVPN/openvpn/releases/download/v${OPENVPN_VERSION}/openvpn-${OPENVPN_VERSION}.tar.gz
tar -xf openvpn-${OPENVPN_VERSION}.tar.gz
cd openvpn-${OPENVPN_VERSION}

# compile/install
mkdir -p $CONFIG_DIR
./configure --sysconfdir=$CONFIG_DIR
make -j$(nproc)
make install #DESTDIR=/usr/src/openvpn

# running
/usr/local/sbin/openvpn --cd $CONFIG_DIR --config server.conf
