# ☕ 咖咖商城 (coffee-shop)

一个基于 **Spring Boot + MyBatis + Thymeleaf** 的在线咖啡商城系统，支持用户注册登录、商品浏览、购物车、订单管理、AI 智能助手等功能。

![Java](https://img.shields.io/badge/Java-1.8-orange)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-2.4.2-brightgreen)
![MySQL](https://img.shields.io/badge/MySQL-8.0+-blue)
![License](https://img.shields.io/badge/License-Apache%202.0-green)

---

## 📋 目录

- [功能特性](#-功能特性)
- [系统截图](#-系统截图)
- [技术架构](#-技术架构)
- [环境要求](#-环境要求)
- [快速开始](#-快速开始)
- [Windows 本地部署](#-windows-本地部署)
- [VPS 服务器部署](#-vps-服务器部署)
- [配置说明](#-配置说明)
- [项目结构](#-项目结构)
- [API 接口](#-api-接口)
- [许可证](#-许可证)

---

## ✨ 功能特性

### 🛍️ 前台用户端

| 功能模块 | 描述 |
|---------|------|
| **商品浏览** | 分类筛选、关键词搜索、商品详情查看 |
| **购物车** | 添加商品、数量调整、全选/批量结算 |
| **订单管理** | 单个/批量下单、支付、查看订单状态、确认收货、取消/删除订单 |
| **收藏功能** | 收藏喜欢的商品、管理收藏列表 |
| **地址管理** | 多地址管理、默认地址设置 |
| **商品评价** | 订单完成后评价商品、查看其他用户评价 |
| **AI 智能助手** | 悬浮式聊天窗口、支持 DeepSeek/Gemini 双模型、咖啡咨询服务 |

### 🔧 后台管理端

| 功能模块 | 描述 |
|---------|------|
| **商品管理** | 商品发布、编辑、上下架、图片上传(OSS) |
| **分类管理** | 商品分类的增删改查 |
| **订单管理** | 待发货/待收货/已完成/已取消订单处理、发货操作 |
| **评论管理** | 查看用户评价、回复评论、删除评论 |
| **用户管理** | 查看用户信息、修改角色权限 |

### 🤖 AI 助手特性

- **悬浮式交互**：右下角咖啡杯图标，点击打开聊天窗口
- **双模型支持**：可切换 DeepSeek（国内直连）和 Gemini（需代理）
- **快捷问题**：推荐咖啡、咖啡风味、冲泡技巧等预设问题
- **历史记录**：自动保存聊天记录，页面刷新后可恢复
- **咖啡主题 UI**：棕色系设计，与商城风格统一

---

## 🛠️ 技术架构

| 层次 | 技术 |
|------|------|
| **后端框架** | Spring Boot 2.4.2 |
| **持久层** | MyBatis + Druid 连接池 |
| **模板引擎** | Thymeleaf |
| **数据库** | MySQL 8.0+ |
| **缓存** | EhCache |
| **文件存储** | 阿里云 OSS |
| **邮件服务** | Spring Boot Mail (QQ 邮箱) |
| **AI 服务** | DeepSeek / Gemini API |
| **HTTP 客户端** | Hutool |
| **构建工具** | Maven |

---

## 📦 环境要求

- **JDK 1.8** 或更高版本
- **Maven 3.6+**
- **MySQL 8.0+**
- **IDE**（推荐 IntelliJ IDEA 或 VS Code）

---

## 🚀 快速开始

```bash
# 1. 克隆项目
git clone https://github.com/your-repo/coffee-shop.git
cd coffee-shop

# 2. 创建数据库并导入数据
mysql -u root -p -e "CREATE DATABASE \`coffee-shop\` CHARACTER SET utf8mb4;"
mysql -u root -p coffee-shop < src/main/resources/coffee-shop.sql
mysql -u root -p coffee-shop < sql/ai_chat_message.sql

# 3. 修改配置文件
# 编辑 src/main/resources/application.yml，设置数据库密码

# 4. 启动项目
mvn spring-boot:run

# 5. 访问系统
# 首页: http://localhost:8080/coffee-shop/
```

**默认账号：**
| 角色 | 邮箱 | 密码 |
|------|------|------|
| 管理员 | admin@qq.com | x12345 |
| 普通用户 | zs@qq.com | x12345 |

---

## 🖥️ Windows 本地部署

### 1. 安装必要软件

#### 1.1 安装 JDK 1.8
1. 下载 JDK 1.8：[Oracle JDK](https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html) 或 [OpenJDK](https://adoptium.net/)
2. 配置环境变量：
   ```powershell
   # 新建系统变量
   JAVA_HOME = C:\Program Files\Java\jdk1.8.0_xxx
   
   # 编辑 Path 变量，添加
   %JAVA_HOME%\bin
   ```
3. 验证：`java -version`

#### 1.2 安装 Maven
1. 下载 Maven：[Maven 官网](https://maven.apache.org/download.cgi)
2. 配置环境变量：
   ```powershell
   MAVEN_HOME = C:\Program Files\Apache\maven\apache-maven-3.x.x
   Path 添加：%MAVEN_HOME%\bin
   ```

#### 1.3 安装 MySQL 8.0
下载并安装：[MySQL 官网](https://dev.mysql.com/downloads/mysql/)

---

### 2. 初始化数据库

```sql
-- 连接 MySQL
mysql -u root -p

-- 创建数据库
CREATE DATABASE `coffee-shop` CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

-- 导入数据
USE `coffee-shop`;
SOURCE E:/JetBrains/Project/coffee-shop/src/main/resources/coffee-shop.sql;
SOURCE E:/JetBrains/Project/coffee-shop/sql/ai_chat_message.sql;
```

---

### 3. 配置项目

编辑 `src/main/resources/application.yml`：

```yaml
spring:
  datasource:
    username: root
    password: 123456    # 你的 MySQL 密码
    url: jdbc:mysql://127.0.0.1:3306/coffee-shop?serverTimezone=Hongkong&useAffectedRows=true&characterEncoding=utf-8
```

---

### 4. 启动项目

**方式一：使用 IDE**
- IntelliJ IDEA 打开项目 → 运行 `CoffeeShopApplication.java`

**方式二：命令行**
```powershell
mvn clean compile
mvn spring-boot:run
```

---

### 5. 访问系统

| 页面 | 地址 |
|------|------|
| 首页 | http://localhost:8080/coffee-shop/ |

> 管理员使用 admin@qq.com 登录后，前台右侧面板可进入「后台管理」。

---

## 🌐 VPS 服务器部署

### 1. 服务器环境准备

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install openjdk-8-jdk maven mysql-server -y

# 验证
java -version
mvn -version
```

### 2. 上传项目

```bash
# Git 方式
git clone https://your-repo-url/coffee-shop.git

# 或 SCP 方式
scp -r ./coffee-shop user@your-server-ip:/home/user/
```

### 3. 初始化数据库

```bash
sudo mysql -u root -p
```

```sql
CREATE DATABASE `coffee-shop` CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
CREATE USER 'coffeeshop'@'localhost' IDENTIFIED BY 'your-password';
GRANT ALL PRIVILEGES ON `coffee-shop`.* TO 'coffeeshop'@'localhost';
FLUSH PRIVILEGES;
exit;
```

```bash
mysql -u coffeeshop -p coffee-shop < src/main/resources/coffee-shop.sql
mysql -u coffeeshop -p coffee-shop < sql/ai_chat_message.sql
```

### 4. 打包运行

```bash
# 打包
mvn clean package -DskipTests

# 后台运行
nohup java -jar target/coffee-shop-0.0.1-SNAPSHOT.jar > app.log 2>&1 &
```

### 5. 使用 Systemd 服务（推荐）

```bash
sudo nano /etc/systemd/system/coffee-shop.service
```

```ini
[Unit]
Description=Coffee Shop Application
After=network.target mysql.service

[Service]
Type=simple
User=user
WorkingDirectory=/home/user/coffee-shop/target
ExecStart=/usr/bin/java -jar coffee-shop-0.0.1-SNAPSHOT.jar
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

```bash
sudo systemctl daemon-reload
sudo systemctl start coffee-shop
sudo systemctl enable coffee-shop
```

### 6. Nginx 反向代理（可选）

```nginx
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://127.0.0.1:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

---

## ⚙️ 配置说明

### 数据库配置
```yaml
spring:
  datasource:
    username: root
    password: 123456
    url: jdbc:mysql://127.0.0.1:3306/coffee-shop
```

### 阿里云 OSS 配置（图片上传）
```yaml
oss:
  bucket-name: your-bucket
  end-point: oss-cn-hangzhou.aliyuncs.com
  access-key: your-access-key
  access-secret: your-access-secret
```

### 邮箱配置（找回密码）
```yaml
spring:
  mail:
    username: your-email@qq.com
    password: your-auth-code    # QQ邮箱授权码
    host: smtp.qq.com
    port: 465
```

### AI 助手配置
```yaml
ai:
  # DeepSeek（国内可直连）
  deepseek:
    api-key: sk-xxx
    base-url: https://api.deepseek.com/chat/completions
    model: deepseek-chat
  
  # Gemini（需要代理）
  gemini:
    api-key: AIzaSy-xxx
    base-url: https://generativelanguage.googleapis.com/v1beta/models
    model: gemini-2.0-flash
  
  # 代理配置（Gemini 使用）
  proxy:
    enabled: true
    host: 127.0.0.1
    port: 10810
```

---

## 📁 项目结构

```
coffee-shop/
├── pom.xml                           # Maven 配置
├── sql/                              # 额外 SQL 脚本
│   └── ai_chat_message.sql
├── docs/                             # 技术文档
│   ├── AI助手技术文档.md
│   └── 通用AI助手集成指南_即插即用版.md
├── src/main/
│   ├── java/com/coffeeshop/
│   │   ├── CoffeeShopApplication.java  # 启动类
│   │   ├── config/                   # 配置类 (AiConfig, DruidConfig)
│   │   ├── controller/               # 控制器 (11个)
│   │   │   ├── AiChatController.java     # AI 聊天接口
│   │   │   ├── OrderController.java      # 订单 (含批量购买)
│   │   │   ├── CartController.java       # 购物车
│   │   │   ├── CommodityController.java  # 商品
│   │   │   └── ...
│   │   ├── service/                  # 业务逻辑层
│   │   ├── mapper/                   # MyBatis Mapper
│   │   └── entity/                   # 实体类
│   └── resources/
│       ├── application.yml           # 主配置文件
│       ├── coffee-shop.sql             # 数据库初始化脚本
│       ├── static/                   # 静态资源
│       │   └── common/
│       │       ├── css/ai-chat.css   # AI 助手样式
│       │       └── js/ai-chat.js     # AI 助手脚本
│       └── templates/                # Thymeleaf 模板
│           ├── front/                # 前台页面 (14个)
│           │   ├── cart.html             # 购物车
│           │   ├── pay.html              # 支付页面
│           │   ├── my-order.html         # 我的订单
│           │   └── ...
│           └── background/           # 后台页面 (13个)
│               ├── goods.html            # 商品管理
│               ├── wait-deliver.html     # 待发货订单
│               └── ...
```

---

## 🔌 API 接口

### AI 聊天接口

| 方法 | 路径 | 说明 |
|------|------|------|
| POST | `/ai/chat` | 发送消息获取 AI 回复 |
| GET | `/ai/history` | 获取聊天历史记录 |
| DELETE | `/ai/history` | 清空聊天历史 |
| GET | `/ai/status` | 检查 AI 服务状态 |

### 订单接口

| 方法 | 路径 | 说明 |
|------|------|------|
| POST | `/buyCommodity` | 单件商品购买 |
| POST | `/batchBuyCommodity` | 批量购买（购物车多选结算） |
| POST | `/deliverGoods` | 订单发货 |
| POST | `/confirmOrder` | 确认收货 |
| POST | `/cancelOrder` | 取消订单 |
| POST | `/deleteOrder` | 删除订单 |

---

## 📄 许可证

本项目基于 [Apache License 2.0](LICENSE) 开源。

---

## 🙏 致谢

感谢所有为本项目做出贡献的开发者！

如有问题或建议，欢迎提交 Issue 或 Pull Request。
