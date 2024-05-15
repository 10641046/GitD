#!/bin/bash

#停止节点
#cd simple-taiko-node&&docker compose  --profile l2_execution_engine down&&cd
#cd simple-taiko-node&&docker stop simple-taiko-node-taiko_client_proposer-1 && docker rm simple-taiko-node-taiko_client_proposer-1&&cd
#运行节点
cd simple-taiko-node&&docker compose --profile l2_execution_engine up -d&&docker compose --profile proposer up -d
#cd
