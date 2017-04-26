#!/bin/bash

# Instala en carpeta definida
FOLDER="~"

cd $FOLDER

# ethereum y geth

sudo apt-get install software-properties-common
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt-get update
sudo apt-get install -y ethereum 

# sudo apt-get install -y build-essential golang
# git clone https://github.com/ethereum/go-ethereum
# cd go-ethereum
# make geth

cd $FOLDER

# nodejs

curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt-get install -y nodejs

# Ya no es necesario al parecer
# sudo apt-get install https://npmjs.com/install.sh | sudo sh

# Se pueden usar librerias para hacer más comoda la instalación
# geth-private: https://github.com/hiddentao/geth-private
# npm install -g geth-private
# Ethereum RPC client: https://github.com/ethereumjs/testrpc
# npm install -g ethereumjs-testrpc
