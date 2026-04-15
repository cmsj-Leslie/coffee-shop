# ☕ 咖咖商城 (coffee-shop)

一个基于 **Spring Boot + MyBatis + Thymeleaf** 的在线咖啡商城系统，支持用户注册登录、商品浏览、购物车、订单管理、AI 智能助手等功能。

![Java](https://img.shields.io/badge/Java-1.8-orange)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-2.4.2-brightgreen)
![MySQL](https://img.shields.io/badge/MySQL-8.0+-blue)
![License](https://img.shields.io/badge/License-Apache%202.0-green)

---

## 📋 目录

- [功能特性](#-功能特性)
- [技术架构](#-技术架构)
- [环境要求](#-环境要求)
- [快速开始](#-快速开始)
- [Windows 本地部署](#️-windows-本地部署)
- [VPS 服务器部署](#-vps-服务器部署)
- [配置说明](#️-配置说明)
- [项目结构](#-项目结构)
- [数据库设计](#-数据库设计)
- [API 接口](#-api-接口)
- [许可证](#-许可证)

---

## ✨ 功能特性

### 🛍️ 前台用户端

| 功能模块 | 描述 |
|---------|------|
| **商品浏览** | 分类筛选、关键词搜索、商品详情查看、折扣计算 |
| **购物车** | 添加商品、数量调整、全选/批量结算 |
| **订单管理** | 单个/批量下单、支付、查看订单状态、确认收货、取消/删除订单 |
| **收藏功能** | 收藏喜欢的商品、管理收藏列表 |
| **个性化推荐** | 基于 Item-based CF 协同过滤算法，融合购买、评价、收藏三重行为信号生成推荐；冷启动降级为全局热销 Top-8 |
| **地址管理** | 多地址管理、默认地址设置 |
| **商品评价** | 订单完成后评价商品、查看其他用户评价 |
| **AI 智能助手** | 悬浮式聊天窗口、支持 DeepSeek/Gemini 双模型、咖啡专业咨询 |
| **找回密码** | 通过邮箱验证码重置密码 |

### 🔧 后台管理端

| 功能模块 | 描述 |
|---------|------|
| **商品管理** | 商品发布、编辑、上下架、图片上传（阿里云 OSS） |
| **分类管理** | 商品分类的增删改查 |
| **订单管理** | 待发货/待收货/已完成/已取消订单处理、录入快递信息发货 |
| **评论管理** | 查看用户评价、回复评论、删除评论 |
| **用户管理** | 查看用户信息、修改角色权限 |

### 🤖 AI 助手特性

- **悬浮式交互**：右下角咖啡杯图标，点击打开聊天窗口
- **双模型支持**：可切换 DeepSeek（国内直连）和 Gemini（需代理）
- **快捷问题**：推荐咖啡、咖啡风味、冲泡技巧等预设问题
- **历史记录**：聊天记录持久化入库，页面刷新后可恢复
- **咖啡主题 UI**：棕色系设计，与商城风格统一

### 📊 数据可视化大屏

- **现代化UI**：使用 **Chart.js** 打造带发光、渐变色阴影效果的现代化纯原生统计图表。
- **多维呈现**：包含四大核心指标卡片（总销售额/总订单数/总用户数/总商品数）、近7天订单趋势折线图、实时订单状态分布环形图（待发货/待收货/已完结/已取消）、以及销量 Top-5 商品排行榜柱状图。

### 🏷️ 营销与全局优惠券系统

- **后台智能发券**：管理员灵活创建「满减券（如满100减20）」与「折扣券（如8折）」，系统后台在创建时会自动实现全员精准分发。
- **前台动态核销**：用户在订单支付结算页下拉自选拥有的且达到门槛的可用优惠券，系统动态实时通过 JS + 后端校验双重拦截，动态计算折后及抵扣金额，并在下单成交后自动锁定核销。

### 💡 核心：ItemCF 个性化智能推荐算法

系统引入了 **基于物品的协同过滤算法（Item-based CF）** 代替原本的随机占位数据，底层实现位于 `RecommendService.java`：
- **① 多信号评分矩阵**：抛弃单一购买评判，深度融合购买行为（3分）、用户收藏行为（2分）、商品订单评价（1~5星级对应的分数）。遇同一用户对单一商品产生多次不同行为，采用 `Math.max()` 提纯最高意向权重。
- **② 相似度计算**：基于构建的评分矩阵，使用经典的 **余弦相似度（Cosine Similarity）** 数学模型，精准计算各商品间的特征潜在相似度。
- **③ 推荐分推导**：对用户尚未购买的候选商品池，通过计算公式 `推荐分 = Σ (sim(候选商品, 用户已有行为的特定商品) × 历史评分)` 来预测用户兴趣期望值。
- **④ 列表截取与兜底**：最终预测得分做倒序排序后，推送到首页截取专属的 **Top-8** 个性化商品。同时引入完善的冷启动逻辑——若探测到全新用户（行为孤岛），则立即且平滑降级为推荐全局历史销量的 **Top-8 爆款排名**。

---

## 🛠️ 技术架构

| 层次 | 技术 |
|------|------|
| **后端框架** | Spring Boot 2.4.2 |
| **持久层** | MyBatis + Druid 连接池 |
| **模板引擎** | Thymeleaf |
| **数据库** | MySQL 8.0+ |
| **文件存储** | 阿里云 OSS |
| **邮件服务** | Spring Boot Mail（QQ 邮箱 SMTP） |
| **AI 服务** | DeepSeek API / Gemini API |
| **推荐算法** | Item-based CF（余弦相似度 + 多信号评分矩阵） |
| **工具库** | Hutool |
| **构建工具** | Maven |

---

## 📦 环境要求

- **JDK 1.8** 或更高版本
- **Maven 3.6+**
- **MySQL 8.0+**
- **IDE**（推荐 IntelliJ IDEA）

---

## 🚀 快速开始

```bash
# 1. 克隆项目
git clone https://github.com/your-username/coffee-shop.git
cd coffee-shop

# 2. 创建数据库并导入数据
mysql -u root -p -e "CREATE DATABASE \`coffee-shop\` CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;"
mysql -u root -p coffee-shop < src/main/resources/coffee-shop.sql

# 3. 配置文件（复制模板并填写实际配置）
cp src/main/resources/application.Backup.yml src/main/resources/application.yml
# 编辑 application.yml，填写数据库密码、邮箱授权码、OSS 密钥等

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

> 管理员登录后，前台右侧面板可进入「后台管理」。

---

## 🖥️ Windows 本地部署

### 1. 安装必要软件

#### 1.1 安装 JDK 1.8
1. 下载 JDK 1.8：[Oracle JDK](https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html) 或 [OpenJDK](https://adoptium.net/)
2. 配置系统环境变量：
   ```
   JAVA_HOME = C:\Program Files\Java\jdk1.8.0_xxx
   Path 添加：%JAVA_HOME%\bin
   ```
3. 验证：`java -version`

#### 1.2 安装 Maven
1. 下载：[Maven 官网](https://maven.apache.org/download.cgi)
2. 配置环境变量：
   ```
   MAVEN_HOME = C:\Program Files\Apache\maven\apache-maven-3.x.x
   Path 添加：%MAVEN_HOME%\bin
   ```
3. 验证：`mvn -version`

#### 1.3 安装 MySQL 8.0
下载并安装：[MySQL 官网](https://dev.mysql.com/downloads/mysql/)

---

### 2. 初始化数据库

```sql
-- 连接 MySQL
mysql -u root -p

-- 创建数据库
CREATE DATABASE `coffee-shop` CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

-- 导入初始数据（包含所有表结构及测试数据）
USE `coffee-shop`;
SOURCE /your/path/coffee-shop/src/main/resources/coffee-shop.sql;
```
                                       
---

### 3. 配置项目

将 `src/main/resources/application.Backup.yml` 复制为 `application.yml`，并填写以下配置：

```yaml
spring:
  datasource:
    username: root
    password: 你的MySQL密码
    url: jdbc:mysql://127.0.0.1:3306/coffee-shop?serverTimezone=Hongkong&useAffectedRows=true&characterEncoding=utf-8

  mail:
    username: 你的QQ邮箱
    password: 你的邮箱授权码   # QQ邮箱→设置→账号→生成授权码

oss:
  bucket-name: 你的OSS桶名
  end-point: oss-cn-hangzhou.aliyuncs.com
  access-key: 你的AccessKey ID
  access-secret: 你的AccessKey Secret

ai:
  deepseek:
    api-key: sk-xxx   # 在 platform.deepseek.com 获取
```

> ⚠️ `application.yml` 已被 `.gitignore` 忽略，填入真实密钥后不会被上传到 Git。

---

### 4. 启动项目

**方式一：IntelliJ IDEA**
打开项目 → 找到 `CoffeeShopApplication.java` → 点击运行

**方式二：命令行**
```powershell
mvn clean compile
mvn spring-boot:run
```

### 5. 访问系统

| 页面 | 地址 |
|------|------|
| 首页 | http://localhost:8080/coffee-shop/ |
| 后台（管理员登录后） | http://localhost:8080/coffee-shop/goods |

---

## 🌐 VPS 服务器部署

### 1. 服务器环境准备

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install openjdk-8-jdk maven mysql-server -y

# 验证
java -version && mvn -version
```

### 2. 上传项目

```bash
git clone https://github.com/your-username/coffee-shop.git
cd coffee-shop
```

### 3. 初始化数据库

```sql
CREATE DATABASE `coffee-shop` CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
CREATE USER 'coffeeshop'@'localhost' IDENTIFIED BY 'your-password';
GRANT ALL PRIVILEGES ON `coffee-shop`.* TO 'coffeeshop'@'localhost';
FLUSH PRIVILEGES;
```

```bash
mysql -u coffeeshop -p coffee-shop < src/main/resources/coffee-shop.sql
```

### 4. 配置并打包

```bash
cp src/main/resources/application.Backup.yml src/main/resources/application.yml
# 编辑 application.yml 填写实际配置
nano src/main/resources/application.yml

# 打包
mvn clean package -DskipTests
```

### 5. 运行

```bash
# 后台运行
nohup java -jar target/coffee-shop-0.0.1-SNAPSHOT.jar > app.log 2>&1 &
```

### 6. 使用 Systemd 托管（推荐）

```bash
sudo nano /etc/systemd/system/coffee-shop.service
```

```ini
[Unit]
Description=Coffee Shop Application
After=network.target mysql.service

[Service]
Type=simple
User=ubuntu
WorkingDirectory=/home/ubuntu/coffee-shop
ExecStart=/usr/bin/java -jar target/coffee-shop-0.0.1-SNAPSHOT.jar
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

```bash
sudo systemctl daemon-reload
sudo systemctl start coffee-shop
sudo systemctl enable coffee-shop
```

### 7. Nginx 反向代理（可选）

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

参考 `src/main/resources/application.Backup.yml` 模板，主要配置项说明：

| 配置项 | 说明 | 是否必须 |
|--------|------|---------|
| `spring.datasource.password` | MySQL 数据库密码 | ✅ 必须 |
| `spring.datasource.url` | 数据库连接地址（数据库名为 `coffee-shop`） | ✅ 必须 |
| `spring.mail.username` | QQ 邮箱地址（用于发送验证码） | 找回密码功能需要 |
| `spring.mail.password` | QQ 邮箱授权码（不是登录密码） | 找回密码功能需要 |
| `oss.access-key` | 阿里云 AccessKey ID | 图片上传需要 |
| `oss.access-secret` | 阿里云 AccessKey Secret | 图片上传需要 |
| `ai.deepseek.api-key` | DeepSeek API Key | AI 助手需要 |
| `ai.gemini.api-key` | Gemini API Key | AI 助手（Gemini）需要 |

---

## 📁 项目结构

```
coffee-shop/
├── pom.xml                              # Maven 依赖配置
├── src/main/
│   ├── java/com/coffeeshop/
│   │   ├── CoffeeShopApplication.java   # Spring Boot 启动类
│   │   ├── config/                      # 配置类
│   │   │   ├── AiConfig.java            # AI 服务配置
│   │   │   └── DruidConfig.java         # 数据源配置
│   │   ├── controller/                  # 控制器层（11个）
│   │   │   ├── BaseController.java      # 公共基类（Session/购物车）
│   │   │   ├── SystemController.java    # 页面跳转（前台+后台）
│   │   │   ├── AiChatController.java    # AI 聊天接口
│   │   │   ├── OrderController.java     # 订单（含批量购买）
│   │   │   ├── CommodityController.java # 商品管理
│   │   │   ├── CartController.java      # 购物车
│   │   │   ├── UserController.java      # 用户信息
│   │   │   ├── LoginController.java     # 登录/注册/找回密码
│   │   │   ├── AddressController.java   # 收货地址
│   │   │   ├── ClassifyController.java  # 商品分类
│   │   │   └── CommentController.java   # 商品评价
│   │   ├── service/                     # 业务逻辑层（含 RecommendService 推荐算法）
│   │   ├── mapper/                      # MyBatis Mapper 接口
│   │   └── entity/                      # 实体类
│   └── resources/
│       ├── application.Backup.yml       # 配置模板（含说明，无真实密钥）
│       ├── coffee-shop.sql              # 数据库初始化脚本（含测试数据）
│       ├── mybatis/mapper/              # MyBatis XML 映射文件
│       ├── static/                      # 静态资源
│       │   └── common/
│       │       ├── css/                 # 样式文件
│       │       └── js/                  # 脚本（含 custom.js / ai-chat.js）
│       └── templates/                   # Thymeleaf 模板
│           ├── index.html               # 商城首页
│           ├── front/                   # 前台页面
│           │   ├── cart.html            # 购物车
│           │   ├── pay.html             # 结算/支付
│           │   ├── my-order.html        # 我的订单
│           │   ├── product.html         # 商品详情
│           │   ├── list.html            # 商品列表
│           │   ├── collection.html      # 我的收藏
│           │   └── ...
│           └── background/              # 后台管理页面
│               ├── goods.html           # 商品列表管理
│               ├── new-goods.html       # 发布新商品
│               ├── edit-goods.html      # 编辑商品
│               ├── wait-deliver.html    # 待发货订单
│               ├── wait-take.html       # 待收货订单
│               ├── finished-order.html  # 已完成订单
│               ├── cancel-order.html    # 已取消订单
│               └── ...
```

---

## 🗄️ 数据库设计

系统共 **10 张数据表**，全部收录在 `src/main/resources/coffee-shop.sql` 中：

| 表名 | 说明 |
|------|------|
| `user` | 用户表（含角色：0=用户/1=管理员） |
| `commodity` | 商品表（含分类、价格、库存、销量） |
| `classify` | 商品分类表 |
| `order` | 订单表（含快递信息、发货时间、订单状态） |
| `cart` | 购物车表 |
| `address` | 收货地址表 |
| `collection` | 收藏表 |
| `commodity_comment` | 商品评价表（支持嵌套回复） |
| `ai_chat_message` | AI 聊天记录表 |
| `coupon` | 优惠券表（满减券/折扣券） |
| `user_coupon` | 用户优惠券关联表 |

---

## 🔌 API 接口

### AI 聊天接口

| 方法 | 路径 | 说明 |
|------|------|------|
| POST | `/ai/chat` | 发送消息获取 AI 回复 |
| GET | `/ai/history` | 获取当前用户聊天历史 |
| DELETE | `/ai/history` | 清空聊天历史 |
| GET | `/ai/status` | 检查 AI 服务可用状态 |

### 订单接口

| 方法 | 路径 | 说明 |
|------|------|------|
| POST | `/buyCommodity` | 单件商品购买 |
| POST | `/batchBuyCommodity` | 批量购买（购物车多选结算） |
| POST | `/deliverGoods` | 管理员发货（填写快递公司+单号） |
| POST | `/confirmOrder` | 用户确认收货 |
| POST | `/cancelOrder` | 取消订单 |
| POST | `/deleteOrder` | 删除订单记录 |

### 商品接口

| 方法 | 路径 | 说明 |
|------|------|------|
| POST | `/addCommodity` | 发布商品 |
| POST | `/updateCommodity` | 编辑商品 |
| POST | `/deleteCommodity` | 删除商品 |
| POST | `/uploadCommodityImg` | 上传商品图片（OSS） |

---

## 📄 许可证

本项目基于 [Apache License 2.0](LICENSE) 开源。

---

## 🙏 致谢

感谢所有为本项目提供灵感和支持的开发者！

如有问题或建议，欢迎提交 [Issue](https://github.com/your-username/coffee-shop/issues)。
