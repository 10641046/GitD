#!/bin/bash

GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
RED="\e[1;31m"
NC="\e[0m"

KEYPAIR_PATH="$HOME/eclipse-keypair.json"
SCREEN_NAME="eclipse_mining"  # 用于 挖矿界面 和 守护挖矿
THREADS=0  # 用来保存核心数
RPC_URL="https://eclipse.helius-rpc.com"  # 默认 RPC 地址





echo -e "${GREEN}开始安装 screen...${NC}"
  sudo apt update && sudo apt install -y screen
  echo -e "${GREEN}screen 安装完成。${NC}"

  echo -e "${GREEN}开始安装 Rust...${NC}"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source $HOME/.cargo/env

  echo -e "${GREEN}安装 Solana CLI...${NC}"
  curl --proto '=https' --tlsv1.2 -sSfL https://solana-install.solana.workers.dev | bash -s -- -y
  export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"

  echo -e "${GREEN}创建 Solana 钱包...${NC}"
  solana-keygen new --no-passphrase --outfile $KEYPAIR_PATH

  echo -e "${GREEN}安装 Bitz CLI...${NC}"
  cargo install bitz

  echo -e "${GREEN}配置 RPC...${NC}"
  solana config set --url $RPC_URL


  echo -e "${GREEN}安装完成！${NC}"
  read -n 1 -s -r -p "操作完成，按任意键返回菜单..."
  show_menu  # 确保返回主菜单
