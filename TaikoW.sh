#!/bin/bash

# 检查是否以root用户运行脚本
if [ "$(id -u)" != "0" ]; then
    echo "此脚本需要以root用户权限运行。"
    echo "请尝试使用 'sudo -i' 命令切换到root用户，然后再次运行此脚本。"
    exit 1
fi

#停止节点
cd simple-taiko-node&&docker compose  --profile l2_execution_engine down&&cd
cd simple-taiko-node&&docker stop simple-taiko-node-taiko_client_proposer-1 && docker rm simple-taiko-node-taiko_client_proposer-1&&cd
#运行节点
cd simple-taiko-node&&docker compose --profile l2_execution_engine up -d&&docker compose --profile proposer up -d
cd
