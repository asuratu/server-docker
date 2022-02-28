Hulk Docker 游戏 api docker
===================

* 此 docker-compose.yml 启用 hulk 的 api 逻辑, 运行main分支
* 正式环境当使用反向代理服务器时,需要修改nginx配置文件的 set_real_ip_from 的值,默认为: 172.16.0.0/16;

### 软件版本

软件 | 版本
---|---
Docker | 20.10.5
Compose | 1.29.0
Nginx | 1.20
PHP | 7.4

### 项目库

项目 | 库
---|---
管理后台-PHP | git@codeup.aliyun.com:611e180776b0c8e58d793ed6/Appcoach_Server/hulk/server/hulk-server.git
 
### Docker 加速

* Aliyun Docker 加速地址: [https://1zd0fyx9.mirror.aliyuncs.com](https://1zd0fyx9.mirror.aliyuncs.com)
* 设置方法: [https://developer.aliyun.com/article/29941 ](https://developer.aliyun.com/article/29941)
* 把用户添加到docker组,免去以前用sudo 执行docker命令, 添加成功后要ubuntu要退出重进不使用才生效
```sh
sudo usermod -aG docker ubuntu
```
---

### 安装/更新 在服务器上运行需加 sudo

安装 docker-composer
* 安装方法: [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)
```sh
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```
安装 make
```sh
sudo apt-get install build-essential
```
---

### 安装 (必须按步骤操作)

STEP: 1
```sh
docker-compose up --build
```

STEP: 2
```sh
make release
```

### 更新

* 更新 php
```sh
make update
```
* 切换 develop 分支
```sh
make update-dev
```
* 切换 main 分支
```sh
make update-main
```

### Mac 开发环境本地运行
* docker-compose -f dev.yml up -d

### 后台运行环境
* docker-compose up -d
