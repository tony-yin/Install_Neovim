#! /bin/bash

## Install requirements
yum install -y \
    epel-release \
    gcc \
    g++ \
    lrzsz \
    git \
    openssl-devel \
    zlib-devel \
    python-pip \

rc=$?
if [ $rc -ne 0 ]; then
    echo "Install requirements failed!"
    exit $rc
else
    echo "Install requirements successfully!"
fi

# Install Python3
tar -zxvf Python-3.6.0.tgz
cd Python-3.6.0
./configure
make
make install


# Install neovim 
#wget https://github.com/neovim/neovim/releases/download/v0.3.1/nvim.appimage
#chmod u+x nvim.appimage && ./nvim.appimage
chmod u+x nvim.appimage
ln -s nvim.appimage /usr/bin/nvim

rc=$?
if [ $rc -ne 0 ]; then
    echo "Install neovim failed!"
    exit $rc
else
    echo "Install neovim successfully!"
fi

# Config neovim
mkdir -p ~/.config
git clone git@github.com:tony-yin/vim-config.git ~/.config/nvim
ln -s ~/.config/nvim ~/.vim
pip3 install --user --upgrade PyYAML
cd ~/.config/nvim
./venv.sh

rc=$?
if [ $rc -ne 0 ]; then
    echo "Config neovim failed!"
    exit $rc
else
    echo "Config neovim successfully!"
fi

echo "Init env successfully!"

# Install Plugin
nvim
