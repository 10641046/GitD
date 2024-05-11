#!/bin/bash

# 检查是否以root用户运行脚本
if [ "$(id -u)" != "0" ]; then
    echo "此脚本需要以root用户权限运行。"
    echo "请尝试使用 'sudo -i' 命令切换到root用户，然后再次运行此脚本。"
    exit 1
fi

#设置虚拟内存
dd if=/dev/zero of=/tmp/swap bs=1M count=2048&&mkswap /tmp/swap&&swapon /tmp/swap&&swapon -s
#--------融合硬盘
dd if=/dev/zero of=./VirtBlock.img bs=1M count=62000
losetup /dev/loop5 VirtBlock.img
pvcreate /dev/loop5
pvcreate /dev/sda
vgcreate lvm_data /dev/loop5
vgextend lvm_data /dev/sda
lvcreate -l 100%VG -n vg_data lvm_data
mkfs -t ext4 /dev/lvm_data/vg_data

mkdir "/mnt/c1"
mount "/dev/lvm_data/vg_data" "/mnt/c1"
echo '/dev/lvm_data/vg_data /mnt/c1 /mnt/c1 ext4 defaults,nofail,discard 0 2' | sudo tee -a /etc/fstab
#------------------------
#安装容器
apt  install docker.io -y
#创建新的容器存储目录
sudo mkdir /mnt/c1/docker
echo '{ "data-root": "/mnt/c1/docker"}' | sudo tee -a /etc/docker/daemon.json
sudo systemctl stop docker
sudo systemctl start docker


wget -O ga+titan.sh https://github.com/10641046/GitD/raw/main/ga+titan.sh && chmod +x ga+titan.sh && ./ga+titan.sh










