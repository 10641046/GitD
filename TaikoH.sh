#!/bin/bash

# 检查是否以root用户运行脚本
if [ "$(id -u)" != "0" ]; then
    echo "此脚本需要以root用户权限运行。"
    echo "请尝试使用 'sudo -i' 命令切换到root用户，然后再次运行此脚本。"
    exit 1
fi

#修改 beacon rpc
#sed -i 's|^L1_BEACON_HTTP=.*|L1_BEACON_HTTP=http://138.201.221.84:5052|' ~/simple-taiko-node/.env

#修改 prover rpc
#sed -i 's|^PROVER_ENDPOINTS=.*|PROVER_ENDPOINTS=http://198.244.201.79:9876,https://prover-hekla.taiko.tools,https://prover2-hekla.taiko.tools,http://taiko-a7-prover.zkpool.io,http://146.59.55.26:9876,http://kenz-prover.hekla.kzvn.xyz:9876,http://hekla.stonemac65.xyz:9876,http://51.91.70.42:9876,http://taiko.web3crypt.net:9876,http://148.113.17.127:9876,http://hekla.prover.taiko.coinblitz.pro:9876,http://taiko-testnet.m51nodes.xyz:9876,http://148.113.16.26:9876,http://51.161.118.103:9876,http://162.19.98.173:9876,http://49.13.215.95:9876,http://49.13.143.184:9876,http://49.13.210.192:9876,http://159.69.242.22:9876,http://49.13.69.238:9876,http://taiko.guru:9876,http://taiko.donkamote.xyz:9876|' ~/simple-taiko-node/.env

#更换blockpi：
#sed -i 's|^L1_ENDPOINT_HTTP=.*|L1_ENDPOINT_HTTP=http://138.201.221.84:8545|' ~/simple-taiko-node/.env
#sed -i 's|^L1_ENDPOINT_WS=.*|L1_ENDPOINT_WS=ws://138.201.221.84:8546|' ~/simple-taiko-node/.env

#修改 GAS
#sed -i 's|^TX_GAS_LIMIT=.*|TX_GAS_LIMIT=9000000|' ~/simple-taiko-node/.env
sed -i 's|^BLOCK_PROPOSAL_FEE=.*|BLOCK_PROPOSAL_FEE=240|' ~/simple-taiko-node/.env


#备份.env
rm -rf t1&&mkdir t1&&cp -a ~/simple-taiko-node/.env /root/t1/

#停止节点
cd simple-taiko-node
docker compose  --profile l2_execution_engine down
docker stop simple-taiko-node-taiko_client_proposer-1 && docker rm simple-taiko-node-taiko_client_proposer-1&&cd

#运行节点
cd simple-taiko-node&&docker compose --profile l2_execution_engine up -d&&docker compose --profile proposer up -d
cd
