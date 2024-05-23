#!/bin/bash

# 检查是否以root用户运行脚本
if [ "$(id -u)" != "0" ]; then
    echo "此脚本需要以root用户权限运行。"
    echo "请尝试使用 'sudo -i' 命令切换到root用户，然后再次运行此脚本。"
    exit 1
fi

echo "脚本以及教程由推特用户大赌哥 @y95277777 编写，免费开源，请勿相信收费"
echo "================================================================"
echo "节点社区 Telegram 群组:https://t.me/niuwuriji"
echo "节点社区 Telegram 频道:https://t.me/niuwuriji"
echo "节点社区 Discord 社群:https://discord.gg/GbMV5EcNWF"

# 读取加载身份码信息
#id="B5D79314-1D51-424F-B68D-8F76045E7516"

id="8EE22BDE-976F-408E-8498-26304DADA2AF"

# 让用户输入想要创建的容器数量
container_count="1"

# 让用户输入起始 RPC 端口号
start_rpc_port="30001"

# 让用户输入想要分配的空间大小
storage_gb="8"

# 让用户输入存储路径（可选）
#custom_storage_path="titan_storage_1"

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

echo "===========泰坦节点启动完毕==========="

#安装gaga
docker run -d --restart always --name gaganode -p 36060:36060 -e TOKEN=pelusnurpxrrmngua4d9015b3a694b7e -d hananonamida/gaganode:1.0.4
echo "===========Gaga节点启动完毕==========="


#安装TM
docker run -d --name tm traffmonetizer/cli_v2 start accept --token FiuWptua5WC3hGsShMq/EF2n4vL23+vrkWKoSj6zZhU= --restart=always
echo "===========爱沙尼亚启动完毕==========="

#安装tinyproxy
#cd /etc/tinyproxy&&rm -rf tinyproxy.conf&&wget https://github.com/10641046/GitD/raw/main/tinyproxy.conf&&sudo service tinyproxy restart&&cd&&sudo ufw disable
#echo "===========TiPy启动完毕==========="

#network3
#wget https://network3.io/ubuntu-node-v1.0.tar
#tar -xf ubuntu-node-v1.0.tar
#cd ubuntu-node
#sudo bash manager.sh up

#echo "===========全部启动完毕==========="








