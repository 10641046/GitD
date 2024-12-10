#!/bin/bash

# 检查是否以root用户运行脚本
if [ "$(id -u)" != "0" ]; then
    echo "此脚本需要以root用户权限运行。"
    echo "请尝试使用 'sudo -i' 命令切换到root用户，然后再次运行此脚本。"
    exit 1
fi

dd if=/dev/zero of=/tmp/swap bs=1M count=4096&&mkswap /tmp/swap&&swapon /tmp/swap&&swapon -s
sudo apt update && sudo apt upgrade -y
sudo apt install build-essential pkg-config libssl-dev git-all -y
snap install rustup --classic
sudo apt install -y protobuf-compiler
curl https://cli.nexus.xyz | sh

    echo '================ 作者：0x懒羊羊 ==================================='
    echo '================ 安装完成,请退出脚本后手动导入ID ==================='





