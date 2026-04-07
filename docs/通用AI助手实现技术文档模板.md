# 🤖 通用 AI 助手集成技术文档 (通用模板)

> 📌 **文档说明**
> 本文档基于 Spring Boot + jQuery 技术栈，提供一套可复用的 AI 聊天助手集成方案。
> 方案核心特点：**配置驱动、低耦合、支持多模型切换（DeepSeek/Gemini/OpenAI）**。
> 适用于任何 B/S 架构的 Web 项目。

---

## 🏗️ 1. 整体架构设计

采用前后端分离的交互模式，通过 WebSocket 或 HTTP 轮询（本项目使用简单的 HTTP POST）实现对话。

```mermaid
graph TD
    User[用户] -->|点击悬浮球| Frontend[前端 UI 组件]
    Frontend -->|AJAX POST /ai/chat| Backend[后端 API]
    Backend -->|读取配置| Config[AiConfig 配置类]
    Backend -->|构建 Prompt| Service[AiChatService]
    Service -->|HTTP 请求| AI_Provider[外部 AI 模型 (DeepSeek/Gemini)]
    Service -.->|持久化| Database[(MySQL 数据库)]
```

---

## 💾 2. 数据库设计 (通用 SQL)

无论什么项目，聊天记录的存储结构基本一致。

```sql
CREATE TABLE IF NOT EXISTS `sys_ai_chat_message` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键',
    `user_id` VARCHAR(64) NOT NULL COMMENT '用户标识 (根据项目实际情况调整类型)',
    `role` VARCHAR(20) NOT NULL COMMENT '角色: user(用户) / system(系统) / assistant(AI)',
    `content` TEXT NOT NULL COMMENT '消息内容',
    `model_provider` VARCHAR(50) COMMENT '模型提供商 (如 deepseek, gemini)',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    INDEX `idx_user_time` (`user_id`, `create_time`)
) COMMENT='AI 助手聊天记录表';
```

---

## ☕ 3. 后端核心实现 (Java / Spring Boot)

### 3.1 配置文件 (`application.yml`)
将模型配置与代码分离，方便随时切换模型或更新 Key。

```yaml
ai:
  # 默认使用的提供商
  default-provider: deepseek
  
  # 代理配置 (可选，用于访问被墙的 API)
  proxy:
    enabled: false
    host: 127.0.0.1
    port: 7890

  deepseek:
    api-key: sk-xxxxxxxxxxxxxxxxxxxx
    base-url: https://api.deepseek.com/chat/completions
    model: deepseek-chat
    
  gemini:
    api-key: xxxxxxxxxxxxxxxxxxxx
    base-url: https://generativelanguage.googleapis.com/v1beta/models
    model: gemini-pro
```

### 3.2 配置映射类 (`AiConfig.java`)
使用 `@ConfigurationProperties` 自动读取配置。

```java
@Data
@Component
@ConfigurationProperties(prefix = "ai")
public class AiConfig {
    private String defaultProvider;
    private ProxyConfig proxy;
    private ModelConfig deepseek;
    private ModelConfig gemini;

    @Data
    public static class ModelConfig {
        private String apiKey;
        private String baseUrl;
        private String model;
    }
    
    @Data
    public static class ProxyConfig {
        private boolean enabled;
        private String host;
        private int port;
    }
}
```

### 3.3 核心服务接口 (`AiChatService.java`)
定义通用接口，屏蔽不同 AI 厂商的 SDK 差异。

```java
public interface AiChatService {
    /**
     * 发送消息并获取回复
     * @param userId 用户ID (用于上下文记忆)
     * @param message 用户消息
     * @return AI 回复内容
     */
    String chat(String userId, String message);
}
```

### 3.4 核心实现逻辑 (Prompt Engineering)
这是**复用时最需要修改**的部分。在此处定义 AI 的"人设"。

```java
@Service
public class AiChatServiceImpl implements AiChatService {
    
    // 🔴 【核心修改点】系统提示词 (System Prompt)
    // 在这里定义 AI 的角色、职责、知识库和限制。
    private static final String SYSTEM_PROMPT = """
            # 角色设定
            你是一个专业的[项目领域]助手。
            
            # 你的职责
            1. 回答用户关于[业务范围]的问题。
            2. 语气风格：[热情/专业/幽默]。
            
            # 知识库
            - [核心概念1]: [解释]
            - [核心概念2]: [解释]
            
            # 限制
            - 严禁回答与业务无关的政治、暴力话题。
            - 回复尽量控制在 200 字以内。
            """;

    @Override
    public String chat(String userId, String message) {
        // 1. 构建请求体 (以 OpenAI 格式为例，DeepSeek 兼容此格式)
        JSONObject body = new JSONObject();
        body.set("model", config.getDeepseek().getModel());
        
        JSONArray messages = new JSONArray();
        // 1.1 注入系统人设
        messages.put(new JSONObject().put("role", "system").put("content", SYSTEM_PROMPT));
        // 1.2 (可选) 注入历史记录以实现多轮对话
        // messages.addAll(loadHistory(userId));
        // 1.3 注入当前用户消息
        messages.put(new JSONObject().put("role", "user").put("content", message));
        
        body.set("messages", messages);

        // 2. 发送 HTTP 请求 (使用 Hutool 或 RestTemplate)
        // ... 具体 HTTP 调用代码参考项目源码 ...
    }
}
```

---

## 🎨 4. 前端集成方案 (HTML/CSS/JS)

为了方便移植，建议将 AI 助手封装为一个**独立的 JS 组件**。

### 4.1 目录结构
建议在 `static` 目录下建立独立文件夹：
```
/static/ai-widget/
  ├── ai-chat.css    # 核心样式 (悬浮球、弹窗)
  ├── ai-chat.js     # 核心逻辑 (UI 渲染、事件绑定)
  └── assets/        # 图标资源
```

### 4.2 引入方式
在任何页面 (如 `layout.html` 或 `index.html`) 底部引入即可生效：
```html
<!-- 引入 AI 助手依赖 -->
<link rel="stylesheet" href="/static/ai-widget/ai-chat.css">
<script src="/static/ai-widget/ai-chat.js"></script>

<!-- 在 JS 中初始化 -->
<script>
    $(document).ready(function() {
        // userId 可从 Session 获取，用于区分用户
        AiChatWidget.init({ userId: '[[${session.user.id}]]' });
    });
</script>
```

### 4.3 `ai-chat.js` 模板逻辑
采用**动态注入 DOM** 的方式，无需修改页面原有的 HTML 结构。

```javascript
const AiChatWidget = {
    init: function(config) {
        this.renderUI();
        this.bindEvents();
    },

    renderUI: function() {
        const html = `
            <div id="ai-fab" class="ai-fab">🤖</div>
            <div id="ai-window" class="ai-window hidden">
                <div class="ai-header">智能助手 <span class="close">×</span></div>
                <div class="ai-body" id="ai-messages"></div>
                <div class="ai-footer">
                    <input type="text" id="ai-input" placeholder="输入问题...">
                    <button id="ai-send">发送</button>
                </div>
            </div>
        `;
        $('body').append(html); // 动态追加到 body
    },
    
    // ... 发送消息 AJAX 请求逻辑 ...
};
```

---

## 🚀 5. 快速移植指南 (如何套用到新项目)

拿到这个模板后，只需 **3 步** 即可集成到新项目：

### 第一步：后端复制代码
1. 复制 `AiConfig.java`、`AiChatService.java`、`Controller` 到新项目的对应包下。
2. 引入必要的依赖 (如 `hutool-http`, `fastjson` 等)。
3. **关键**：修改 `AiChatServiceImpl.java` 中的 `SYSTEM_PROMPT`，把"咖啡顾问"改成新项目的业务角色（比如"电商客服"、"教务老师"）。

### 第二步：配置环境
1. 在 `application.yml` 中添加 API Key 和 Base URL。
2. 执行 SQL 脚本创建表（如果不需要保存记录，可跳过）。

### 第三步：前端引入
1. 把 `ai-chat.css` 和 `ai-chat.js` 复制到静态资源目录。
2. 在公共布局文件（如 `header.html` 或 `footer.html`）中引入这两个文件。

---

## 🛠️ 6. 常见定制化场景

| 需求 | 修改位置 |
| :--- | :--- |
| **更换 AI 模型** | 修改 `application.yml` 里的 `model` 和 `base-url` |
| **改变 AI 说话语气** | 修改后端 `Service` 中的 `SYSTEM_PROMPT` |
| **限制只回答特定问题** | 在 Prompt 中加入："严禁回答与 [业务] 无关的问题" |
| **修改图标/颜色** | 修改 `ai-chat.css` |
| **增加上下文记忆** | 在后端发送请求前，从数据库查询最近 10 条记录放入 `messages` 列表 |

