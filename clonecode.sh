#!/bin/bash

# 设置颜色
GREEN='\033[0;32m' # 绿色
RED='\033[0;31m'   # 红色
YELLOW='\033[1;33m' # 黄色
NC='\033[0m'       # 恢复默认颜色
# 提示用户是否需要克隆远程代码库
read -p "是否需要克隆远程代码库？（输入“是”或“否”）: " response

if [[ $response -eq "是" ]]; then
    # Prompt user to input file containing list of repository URLs
    read -p "请输入远程地址（类似于 https://xxx.xxx.xxx.xxx/git/bc.txt: " url_file

    # Check if file exists
    if [ ! -f "$url_file" ]; then
        echo "Error: 文件不存在 '$url_file'."
        exit 1
    fi

    # Read repository URLs from file and clone each one
    while IFS= read -r repo_url; do
        echo "Cloning repository: $repo_url"
        git clone "$repo_url"
    done < "$url_file"

    echo -e "${GREEN}已完成逐个克隆到本地。 ${NC}"
else
    echo -e "${GREEN}已完成逐个克隆到本地。 ${NC}"
fi
