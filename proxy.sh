#!/bin/bash

# 检查是否以root用户运行脚本
if [ "$(id -u)" != "0" ]; then
    echo "此脚本需要以root用户权限运行。"
    echo "请尝试使用 'sudo -i' 命令切换到root用户，然后再次运行此脚本。"
    exit 1
fi

sudo apt update
apt  install docker.io -y
docker run -d --restart always --name dante -p 7890:1080 -e PROXY_USER=roota1 -e PROXY_PASSWORD=roota2 cpfd/dante
