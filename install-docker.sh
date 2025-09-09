#!/bin/bash
set -e

# 一键安装 Docker (适用于 Debian 11/12)

# 确认以 root 或 sudo 运行
if [ "$EUID" -ne 0 ]; then
  echo "请使用 root 用户或在命令前加 sudo"
  exit
fi

echo ">>> 更新系统依赖..."
apt update
apt install -y ca-certificates curl gnupg lsb-release

echo ">>> 添加 Docker GPG key..."
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo ">>> 添加 Docker 软件源..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
  > /etc/apt/sources.list.d/docker.list

echo ">>> 安装 Docker..."
apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 加入 docker 用户组
if [ -n "$SUDO_USER" ]; then
  usermod -aG docker "$SUDO_USER"
  echo "✅ 用户 $SUDO_USER 已加入 docker 组，请重新登录或运行 'newgrp docker'"
else
  echo "⚠️  当前未检测到 sudo 用户，请手动把需要的用户加入 docker 组"
fi

echo ">>> 检查版本..."
docker --version
echo "🎉 Docker 已安装完成"
