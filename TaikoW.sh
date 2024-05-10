#!/bin/bash

# 检查是否以root用户运行脚本
if [ "$(id -u)" != "0" ]; then
    echo "此脚本需要以root用户权限运行。"
    echo "请尝试使用 'sudo -i' 命令切换到root用户，然后再次运行此脚本。"
    exit 1
fi

#修改 beacon rpc
#sed -i 's|^L1_BEACON_HTTP=.*|L1_BEACON_HTTP=http://unstable.holesky.beacon-api.nimbus.team|' ~/simple-taiko-node/.env

#修改 prover rpc
#sed -i 's|^PROVER_ENDPOINTS=.*|PROVER_ENDPOINTS=http://kenz-prover.hekla.kzvn.xyz:9876,http://hekla.stonemac65.xyz:9876,http://taiko.web3crypt.net:9876,http://198.244.201.79:9876|' ~/simple-taiko-node/.env

#修改 GAS
#sed -i 's|^TX_GAS_LIMIT=.*|TX_GAS_LIMIT=9000000|' ~/simple-taiko-node/.env
#sed -i 's|^BLOCK_PROPOSAL_FEE=.*|BLOCK_PROPOSAL_FEE=60|' ~/simple-taiko-node/.env


#备份.env
#rm -rf t1&&mkdir t1&&cp -a ~/simple-taiko-node/.env /root/t1/

#停止节点
cd simple-taiko-node
docker compose  --profile l2_execution_engine down
docker stop simple-taiko-node-taiko_client_proposer-1 && docker rm simple-taiko-node-taiko_client_proposer-1&&cd

#运行节点
cd simple-taiko-node&&docker compose --profile l2_execution_engine up -d&&docker compose --profile proposer up -d
cd
