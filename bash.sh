#!/bin/bash
# 设置颜色
GREEN='\033[0;32m' # 绿色
RED='\033[0;31m'   # 红色
YELLOW='\033[1;33m' # 黄色
NC='\033[0m'       # 恢复默认颜色

# 5. 提示输入要下载的代码库连接地址
# 提示用户是否需要克隆远程代码库
read -p "是否需要克隆远程代码库？（输入“是”或“否”）:" user_choice


if [[ "$user_choice" == "是" ]]; then
    # 提示用户输入远程地址
    read -p "请输入远程地址（类似于 https://xxx.xxx.xxx.xxx/git/bc.txt）: " remote_url

    # 使用换行符分隔仓库地址
    IFS=$'\n' read -ra repo_array <<< "$(curl -s "$remote_url")"

    # 循环克隆仓库
    for repo_url in "${repo_array[@]}"; do
        git clone "$repo_url"
    done;

    echo -e "${GREEN}已完成逐个克隆到本地。 ${NC}"
else
    echo -e "${YELLOW}用户选择不克隆远程代码库。${NC}"
fi


if [[ !($(ls -a /root | grep oh-my-zsh)) ]]; then
# 安装 oh my zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";
    echo -e "${GREEN}ohmyzsh 安装完成 ${NC}"
else
    echo -e "${GREEN}ohmyzsh 已经存在${NC}"
fi
