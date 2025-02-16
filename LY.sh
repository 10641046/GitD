#!/bin/bash

#!/usr/bin/env bash
dd if=/dev/zero of=/tmp/swap bs=1M count=1024&&mkswap /tmp/swap&&swapon /tmp/swap&&swapon -s

apt  install docker.io -y

docker run -d --restart always --name dante -p 1051:1080 -e PROXY_USER=233blog -e PROXY_PASSWORD=314159mol cpfd/dante
docker run -d --name tm traffmonetizer/cli_v2 start accept --token FiuWptua5WC3hGsShMq/EF2n4vL23+vrkWKoSj6zZhU= --restart=always
sudo docker run -d --restart=always -e EARNFM_TOKEN="d9e11358-6ce6-4b4e-8245-52421816a49f" --name earnfm-client earnfm/earnfm-client:latest
wget https://download.npool.io/npool.sh&&sudo chmod +x npool.sh&&sudo ./npool.sh 2ja04P823ll6yCkm



sudo ufw disable 








