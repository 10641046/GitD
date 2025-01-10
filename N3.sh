#!/usr/bin/env bash

docker run -d \
--name network3-01 \
-e EMAIL=mabethboumba@hotmail.com \
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
