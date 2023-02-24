#!/bin/bash
dd if=/dev/zero of=/tmp/swap bs=1M count=4096&&mkswap /tmp/swap&&swapon /tmp/swap&&swapon -s&&
wget https://download.npool.io/npool.sh&&sudo chmod +x npool.sh&&sudo ./npool.sh ImtXqCfYUynqyBLj&&
apt-get update&&apt install default-jre -y&&apt install unzip&&
curl -o app-linux-amd64.tar.gz https://assets.coreservice.io/public/package/22/app/1.0.3/app-1_0_3.tar.gz && tar -zxf app-linux-amd64.tar.gz && rm -f app-linux-amd64.tar.gz && cd ./app-linux-amd64 && sudo ./app service install
./app service start&&
sleep 25s&&
sudo ./apps/gaganode/gaganode config set --token=meytmkvyybzywuamxsshomhk
./app restart&&
cd