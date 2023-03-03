#!/bin/bash
dd if=/dev/zero of=/tmp/swap bs=1M count=4096&&mkswap /tmp/swap&&swapon /tmp/swap&&swapon -s&&
wget https://download.npool.io/npool.sh&&sudo chmod +x npool.sh&&sudo ./npool.sh 2ja04P823ll6yCkm&&
apt-get update&&apt install default-jre -y&&apt install unzip&&
cd