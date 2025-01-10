#!/usr/bin/env bash

dd if=/dev/zero of=/tmp/swap bs=1M count=1024&&mkswap /tmp/swap&&swapon /tmp/swap&&swapon -s

apt  install docker.io -y

docker run -d --restart always --name dante -p 1051:1080 -e PROXY_USER=xiejia -e PROXY_PASSWORD=ls@2029 cpfd/dante

docker run -d --name tm traffmonetizer/cli_v2 start accept --token FiuWptua5WC3hGsShMq/EF2n4vL23+vrkWKoSj6zZhU= --restart=always

docker run --name repocket -e RP_EMAIL=k18893919@outlook.com -e RP_API_KEY=b04b3c6c-b50f-40cf-9346-1a2cce48326b -d --restart=always repocket/repocket


docker run -d \
--name network3-01 \
-e EMAIL=188939190@qq.com \
-p 8080:8080/tcp \
-v /root/wireguard:/usr/local/etc/wireguard \
--health-cmd="curl -fs http://localhost:8080/ || exit 1" \
--health-interval=30s \
--health-timeout=5s \
--health-retries=5 \
--health-start-period=30s \
--privileged \
--device=/dev/net/tun \
--cap-add=NET_ADMIN \
--restart always \
aron666/network3-ai &&
docker run -d \
--name autoheal \
-e AUTOHEAL_CONTAINER_LABEL=all \
-v /var/run/docker.sock:/var/run/docker.sock \
--restart always \
willfarrell/autoheal

sudo ufw disable 
