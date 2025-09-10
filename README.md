# Docker Install Script

一个用于 **Debian 11/12** 的 Docker 一键安装脚本。  
脚本会自动完成以下步骤：
- 安装必要依赖
- 添加 Docker 官方软件源和 GPG key
- 安装最新版 Docker CE
- 安装 Buildx / Compose 插件
- 自动将当前用户加入 `docker` 用户组

---

## 使用方法

### 一行命令安装
```bash
curl -fsSL dkr.kosno.de | sudo bash
