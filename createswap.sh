#!/usr/bin/env zsh
read -p "请输入要创建的swap大小（单位为M，不需要输入，例如512代表 512M）" swapsize;
sudo fallocate -l ${swapsize}M /swapfile;

sudo chmod 600 /swapfile;

sudo mkswap /swapfile;

sudo swapon /swapfile;

echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

free -h
