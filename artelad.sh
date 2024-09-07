#!/bin/bash
pm2 delete artelad

cd && rm -rf artela
git clone https://github.com/artela-network/artela
cd artela
LATEST_TAG=$(git describe --tags `git rev-list --tags --max-count=1`)
git checkout $LATEST_TAG
make install

cd $HOME
wget https://github.com/artela-network/artela/releases/download/v0.4.9-rc9/artelad_0.4.9_rc9_Linux_amd64.tar.gz
tar -xvf artelad_0.4.9_rc9_Linux_amd64.tar.gz
cp artelad /usr/local/bin/artelad && cp artelad /root/go/bin/artelad
mkdir libs
mv $HOME/libaspect_wasm_instrument.so $HOME/libs/
mv $HOME/artelad /usr/local/bin/
echo 'export LD_LIBRARY_PATH=$HOME/libs:$LD_LIBRARY_PATH' >> ~/.bash_profile
source ~/.bash_profile
wget -O ~/.artelad/data/priv_validator_state.json  https://snapshots.dadunode.com/artela/priv_validator_state.json

pm2 start artelad -- start && pm2 save && pm2 startup
