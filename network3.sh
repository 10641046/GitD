#!/bin/bash

# 检查是否以root用户运行脚本
if [ "$(id -u)" != "0" ]; then
    echo "此脚本需要以root用户权限运行。"
    echo "请尝试使用 'sudo -i' 命令切换到root用户，然后再次运行此脚本。"
    exit 1
fi


wget https://network3.io/ubuntu-node-v1.0.tar
tar -xf ubuntu-node-v1.0.tar
cd ubuntu-node
sudo bash manager.sh up


done
# 获取公网 IP 地址
public_ip=$(curl -s ifconfig.me)

# 准备原始链接
original_url="https://account.network3.ai/main?o=${port_grafana}:8080"

# 替换 LocalHost 为公网 IP 地址
updated_url=$(echo $original_url | sed "s/LocalHost/$public_ip/")

# 显示更新后的链接
echo "请通过以下链接绑定设备：$updated_url"







