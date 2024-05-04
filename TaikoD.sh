#!/bin/bash

# 检查是否以root用户运行脚本
if [ "$(id -u)" != "0" ]; then
    echo "此脚本需要以root用户权限运行。"
    echo "请尝试使用 'sudo -i' 命令切换到root用户，然后再次运行此脚本。"
    exit 1
fi

# 卸载节点
    cd #HOME
    cd simple-taiko-node
    docker compose --profile l2_execution_engine down -v
    docker stop simple-taiko-node-taiko_client_proposer-1 && docker rm simple-taiko-node-taiko_client_proposer-1
    cd #HOME
    rm -rf simple-taiko-node

# 安装节点
git clone https://github.com/taikoxyz/simple-taiko-node.git

# 复制备份.env
cp -a ~/t1/.env simple-taiko-node/

# 运行节点
cd simple-taiko-node
docker compose --profile l2_execution_engine down
docker stop simple-taiko-node-taiko_client_proposer-1 && docker rm simple-taiko-node-taiko_client_proposer-1
docker compose --profile l2_execution_engine up -d
docker compose --profile proposer up -d
cd

# 获取公网 IP 地址
public_ip=$(curl -s ifconfig.me)

# 准备原始链接
original_url="LocalHost:${port_grafana}/d/L2ExecutionEngine/l2-execution-engine-overview?orgId=1&refresh=10s"

# 替换 LocalHost 为公网 IP 地址
updated_url=$(echo $original_url | sed "s/LocalHost/$public_ip/")

# 显示更新后的链接
echo "已替换运行，等待5分钟后查询。"
