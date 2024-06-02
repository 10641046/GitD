#!/bin/bash

# 检查是否以root用户运行脚本
if [ "$(id -u)" != "0" ]; then
    echo "此脚本需要以root用户权限运行。"
    echo "请尝试使用 'sudo -i' 命令切换到root用户，然后再次运行此脚本。"
    exit 1
fi


dd if=/dev/zero of=./VirtBlock.img bs=1M count=135000

losetup /dev/loop5 VirtBlock.img
pvcreate /dev/loop5
pvcreate /dev/sda
pvcreate /dev/sdb

vgcreate lvm_data /dev/loop5
vgextend lvm_data /dev/sda
vgextend lvm_data /dev/sdb

lvcreate -l 100%VG -n vg_data lvm_data
mkfs -t ext4 /dev/lvm_data/vg_data

mkdir "/mnt/c1"
mount "/dev/lvm_data/vg_data" "/mnt/c1"
echo '/dev/lvm_data/vg_data /mnt/c1 /mnt/c1 ext4 defaults,nofail,discard 0 2' | sudo tee -a /etc/fstab

apt  install docker.io -y

sudo mkdir /mnt/c1/docker
echo '{ "data-root": " /mnt/c1/docker"}' | sudo tee -a /etc/docker/daemon.json
sudo systemctl stop docker
sudo systemctl start docker



# 检查并安装 Node.js 和 npm
export HOME=/mnt/c1

#Node.js
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

#npm
sudo apt-get install -y npm

# 检查并安装 PM2
npm install pm2@latest -g

# 检查Go环境


# 节点安装功能
install_nodejs_and_npm
install_pm2
# 设置变量
read -r -p "请输入你想设置的节点名称: " NODE_MONIKER
export NODE_MONIKER=$NODE_MONIKER
export HOME=/mnt/c1
    # 更新和安装必要的软件
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y curl iptables build-essential git wget jq make gcc nano tmux htop nvme-cli pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip libleveldb-dev lz4 snapd

    # 安装 Go
        sudo rm -rf /usr/local/go
        curl -L https://go.dev/dl/go1.22.0.linux-amd64.tar.gz | sudo tar -xzf - -C /usr/local
        echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile
        source $HOME/.bash_profile
        go version
    # 安装所有二进制文件
    cd $HOME
    git clone https://github.com/artela-network/artela
    cd artela
    git checkout v0.4.7-rc6
    make install

    # 配置artelad
    artelad config chain-id artela_11822-1
    artelad init "$NODE_MONIKER" --chain-id artela_11822-1
    artelad config node tcp://localhost:3457

    # 获取初始文件和地址簿
    curl -L https://snapshots-testnet.nodejumper.io/artela-testnet/genesis.json > $HOME/.artelad/config/genesis.json
    curl -L https://snapshots-testnet.nodejumper.io/artela-testnet/addrbook.json > $HOME/.artelad/config/addrbook.json

    # 配置节点
    SEEDS=""
    PEERS="ca8bce647088a12bc030971fbcce88ea7ffdac50@84.247.153.99:26656,a3501b87757ad6515d73e99c6d60987130b74185@85.239.235.104:3456,2c62fb73027022e0e4dcbdb5b54a9b9219c9b0c1@51.255.228.103:26687,fbe01325237dc6338c90ddee0134f3af0378141b@158.220.88.66:3456,fde2881b06a44246a893f37ecb710020e8b973d1@158.220.84.64:3456,12d057b98ecf7a24d0979c0fba2f341d28973005@116.202.162.188:10656,9e2fbfc4b32a1b013e53f3fc9b45638f4cddee36@47.254.66.177:26656,92d95c7133275573af25a2454283ebf26966b188@167.235.178.134:27856,2dd98f91eaea966b023edbc88aa23c7dfa1f733a@158.220.99.30:26680"
    sed -i 's|^persistent_peers *=.*|persistent_peers = "'$PEERS'"|' $HOME/.artelad/config/config.toml

    # 配置端口
    node_address="tcp://localhost:3457"
    sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:3458\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:3457\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:3460\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:3456\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":3466\"%" $HOME/.artelad/config/config.toml
    sed -i -e "s%^address = \"tcp://localhost:1317\"%address = \"tcp://0.0.0.0:3417\"%; s%^address = \":8080\"%address = \":3480\"%; s%^address = \"localhost:9090\"%address = \"0.0.0.0:3490\"%; s%^address = \"localhost:9091\"%address = \"0.0.0.0:3491\"%; s%:8545%:3445%; s%:8546%:3446%; s%:6065%:3465%" $HOME/.artelad/config/app.toml
    echo "export Artela_RPC_PORT=$node_address" >> $HOME/.bash_profile
    source $HOME/.bash_profile   

    pm2 start artelad -- start && pm2 save && pm2 startup
    
    # 下载快照
    artelad tendermint unsafe-reset-all --home $HOME/.artelad --keep-addr-book
    curl https://snapshots-testnet.nodejumper.io/artela-testnet/artela-testnet_latest.tar.lz4 | lz4 -dc - | tar -xf - -C $HOME/.artelad
    mv $HOME/.artelad/priv_validator_state.json.backup $HOME/.artelad/data/priv_validator_state.json

    # 使用 PM2 启动节点进程

    pm2 restart artelad

    echo '====================== 安装完成,请退出脚本后执行 source $HOME/.bash_profile 以加载环境变量 ==========================='
    source /mnt/c1/.bash_profile

    #nkn
    wget https://download.npool.io/npool.sh&&sudo chmod +x npool.sh&&sudo ./npool.sh 2ja04P823ll6yCkm

    #S5
    wget -O proxy.sh https://github.com/10641046/GitD/raw/main/proxy.sh && chmod +x proxy.sh && ./proxy.sh

#泰坦
id="EB88C971-3F33-4BF7-8D3C-360823A4913D"
container_count="1"
start_rpc_port="30001"
storage_gb="20"
apt update
# 检查 Docker 是否已安装
if ! command -v docker &> /dev/null
then
    echo "未检测到 Docker，正在安装..."
    apt-get install ca-certificates curl gnupg lsb-release -y
    # 安装 Docker 最新版本
    apt-get install docker.io -y
else
    echo "Docker 已安装。"
fi
apt-get install tinyproxy -y
# 拉取Docker镜像
docker pull nezha123/titan-edge:1.5
# 创建用户指定数量的容器
for ((i=1; i<=container_count; i++))
do
    current_rpc_port=$((start_rpc_port + i - 1))

    # 判断用户是否输入了自定义存储路径
    if [ -z "$custom_storage_path" ]; then
        # 用户未输入，使用默认路径
        storage_path="$PWD/titan_storage_$i"
    else
        # 用户输入了自定义路径，使用用户提供的路径
        storage_path="$custom_storage_path"
    fi
    # 确保存储路径存在
    mkdir -p "$storage_path"
    # 运行容器，并设置重启策略为always
    container_id=$(docker run -d --restart always -v "$storage_path:/root/.titanedge/storage" --name "titan$i" --net=host  nezha123/titan-edge:1.5)
    echo "节点 titan$i 已经启动 容器ID $container_id"
    sleep 30
    # 修改宿主机上的config.toml文件以设置StorageGB值和端口
    docker exec $container_id bash -c "\
        sed -i 's/^[[:space:]]*#StorageGB = .*/StorageGB = $storage_gb/' /root/.titanedge/config.toml && \
        sed -i 's/^[[:space:]]*#ListenAddress = \"0.0.0.0:1234\"/ListenAddress = \"0.0.0.0:$current_rpc_port\"/' /root/.titanedge/config.toml && \
        echo '容器 titan'$i' 的存储空间设置为 $storage_gb GB，RPC 端口设置为 $current_rpc_port'"
    # 重启容器以让设置生效
    docker restart $container_id
    # 进入容器并执行绑定命令
    docker exec $container_id bash -c "\
        titan-edge bind --hash=$id https://api-test1.container1.titannet.io/api/v2/device/binding"
    echo "节点 titan$i 已绑定."
done

#安装TM
docker run -d --name tm traffmonetizer/cli_v2 start accept --token FiuWptua5WC3hGsShMq/EF2n4vL23+vrkWKoSj6zZhU= --restart=always

echo "===========artela节点启动完毕==========="
echo "===========nkn节点启动完毕==========="
echo "===========S5启动完毕==========="
echo "===========泰坦节点启动完毕==========="
echo "===========爱沙尼亚启动完毕==========="




