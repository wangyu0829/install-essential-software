#!/bin/bash
# 设置颜色
GREEN='\033[0;32m' # 绿色
RED='\033[0;31m'   # 红色
YELLOW='\033[1;33m' # 黄色
NC='\033[0m'       # 恢复默认颜色

# 检查是否 root 用户身份
if [[ $EUID = 0 && "$(ps -o comm= | grep su | sed -n '1p')" = "su" ]]; then
    echo -e "${RED}请以 root 用户身份运行此脚本${NC}"
    exit 1
fi

# 更新软件包列表
apt update;

# upgrade 软件包
apt upgrade -y;
echo -e "${GREEN}软件包更新完毕${NC}"

# 安装常用软件 [git, curl, wget, zsh, tmux, vim]
apt install -y git curl wget zsh nginx tmux vim;

echo -e "${GREEN}git curl wget zsh nginx tmux vim 安装完成 ${NC}"

# 切换目录到 root
cd /root

# 检查 Docker 是否安装完成
if ! command -v docker &> /dev/null; then
    # 安装 Docker
    echo "正在安装 Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh;
    sh get-docker.sh;
    usermod -aG docker "$USER";
    rm get-docker.sh;
    echo -e "${GREEN} Docker安装完成 ${NC}"
else
    echo "Docker 已经存在"
fi

if [[ !($(ls -a /root | grep oh-my-zsh)) ]]; then
    # 安装 oh my zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";
    echo -e "${GREEN}ohmyzsh 安装完成 ${NC}"
else
    echo -e "${GREEN}ohmyzsh 已经存在${NC}"
fi

sleep 3
reboot
