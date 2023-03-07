#!/bin/bash
dd if=/dev/zero of=/tmp/swap bs=1M count=2048&&mkswap /tmp/swap&&swapon /tmp/swap&&swapon -s&&
wget https://download.npool.io/npool.sh&&sudo chmod +x npool.sh&&sudo ./npool.sh UexE8Ds3NFWQr84R&&
cd