#!/bin/bash

#!/usr/bin/env bash
dd if=/dev/zero of=/tmp/swap bs=1M count=1024&&mkswap /tmp/swap&&swapon /tmp/swap&&swapon -s

apt  install docker.io -y

docker run -d --restart always --name dante -p 1051:1080 -e PROXY_USER=233blog -e PROXY_PASSWORD=314159mol cpfd/dante
docker run -d --name tm traffmonetizer/cli_v2 start accept --token FiuWptua5WC3hGsShMq/EF2n4vL23+vrkWKoSj6zZhU= --restart=always
sudo docker run -d --restart=always -e EARNFM_TOKEN="6afbe6b9-db39-49b5-af32-bf36a8734d80" --name earnfm-client earnfm/earnfm-client:latest
wget https://download.npool.io/npool.sh&&sudo chmod +x npool.sh&&sudo ./npool.sh 2ja04P823ll6yCkm



sudo ufw disable 








