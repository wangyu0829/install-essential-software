# README

## installation

下载文件

```shell
curl -fsSL https://raw.githubusercontent.com/wangyu0829/install-essential-software/main/bash.sh -o install-essential-software.sh  https://raw.githubusercontent.com/wangyu0829/install-essential-software/main/fe.sh -o fe.sh https://raw.githubusercontent.com/wangyu0829/install-essential-software/main/createswap.sh -o createswap.sh https://raw.githubusercontent.com/wangyu0829/install-essential-software/main/clonecode.sh -o clonecode.sh 
```
按顺序执行

```shell
bash ./createswap.sh
```

```shell
# 更新系统，安装软件
source ./install-essential-software.sh
# 等待重启完成...
```

```shell
# 安装 node 环境
source ./fe.sh
# 等待重启完成...
```

```shell
# clone code
bash ./clonecode.sh
```
