#!/bin/bash

# 检查是否 root 用户身份
if [[$EUID -ne 0]]; then
    echo "请以 root 用户身份运行此脚本"
    exit 1
fi

# 设置颜色
GREEN='\033[0;32m' # 绿色
RED='\033[0;31m'   # 红色
YELLOW='\033[1;33m' # 黄色
NC='\033[0m'       # 恢复默认颜色

# 更新软件包列表
apt update

# upgrade 软件包
apt upgrade -y

echo "${GREEN}软件包更新完毕${NC}"

# 安装常用软件 [git, curl, wget, zsh, tmux, vim]
apt install -y git curl wget zsh nginx tmux vim 

echo "${GREEN}已安装 git curl wget zsh nginx tmux vim ${NC}"

# 切换目录到 root
cd /root

# 安装 oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "${GREEN}已安装 ohmyzsh ${NC}"

# 安装 docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh ./get-docker.sh

echo "${GREEN}已安装 docker ${NC}"


# 安装开发环境相关

# 1. nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source /root/.zshrc

# 2. node
nvm install node

node_version = $(node -v)
corepack_required_version = "v16.9.0"

is_satisfy = "$node_version" > "$corepack_required_version"
if [[ $is_satisfy ]]; then
    echo "${GREEN}Node.js 版本大于 16.9.0，执行 corepack enable 命令${NC}"
    corepack enable
    echo "${GREEN}corepack 已启动${NC}"
else
    echo "Node.js 版本为$node_version，无需执行 corepack enable"
fi

# 3. 如果当前node版本不支持 corepack，需要手动安装 包管理工具，如 pnpm
if [[ !$is_satisfy ]]; then
    npm install pnpm
    echo "${GREEN}pnpm 已安装${NC}"
fi

# 4. 安装 nrm
pnpm install -g nrm

echo "${GREEN}已安装 nrm ${NC}"

# 5. 提示输入要下载的代码库连接地址
# 提示用户是否需要克隆远程代码库
read -p "${YELLOW}是否需要克隆远程代码库？（输入“是”或“否”）: ${NC}" user_choice

if [[ "$user_choice" == "是" ]]; then
    # 提示用户输入远程地址
    read -p "${YELLOW}请输入远程地址（类似于 https://xxx.xxx.xxx.xxx/git/bc.txt）: ${NC}" remote_url

    # 使用换行符分隔仓库地址
    IFS=$'\n' read -ra repo_array <<< "$(curl -s "$remote_url")"

    # 循环克隆仓库
    for repo_url in "${repo_array[@]}"; do
        git clone "$repo_url"
    done

    echo "${GREEN}已完成逐个克隆到本地。 ${NC}"
else
    echo "用户选择不克隆远程代码库。"
fi

echo "脚本执行完毕！感谢使用。"
