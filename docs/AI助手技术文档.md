# 🤖 AI 聊天助手技术实现文档

## 📁 修改/新增的文件清单

### 后端 (Java/Spring Boot)

| 文件 | 类型 | 作用 |
|------|------|------|
| `AiConfig.java` | 新增 | 配置类，读取 API Key、Base URL 等配置 |
| `AiChatService.java` | 新增 | 服务接口，定义 AI 对话方法 |
| `AiChatServiceImpl.java` | 新增 | 服务实现，**核心业务逻辑**，调用 AI API |
| `AiChatController.java` | 新增 | REST 控制器，暴露 `/ai/chat`、`/ai/history` 接口 |
| `AiChatMessage.java` | 新增 | 实体类，对应数据库表 |
| `AiChatMessageMapper.java` | 新增 | MyBatis Mapper 接口 |
| `AiChatMessageMapper.xml` | 新增 | MyBatis SQL 映射 |
| `application.yml` | 修改 | 添加 AI API 配置项 |

### 前端 (HTML/CSS/JS)

| 文件 | 类型 | 作用 |
|------|------|------|
| `ai-chat.css` | 新增 | 聊天组件样式（悬浮按钮、弹窗、消息气泡） |
| `ai-chat.js` | 新增 | 聊天组件逻辑（发送消息、显示回复、历史记录） |
| `front-common.html` | 修改 | 引入 CSS/JS，注入 contextPath |
| `index.html` 等多个页面 | 修改 | 引入 AI 聊天组件资源 |

### 数据库

| 文件 | 作用 |
|------|------|
| `ai_chat_message.sql` | 建表脚本 |

---

## 🛠️ 采用的技术栈

```
┌─────────────────────────────────────────────────────────────┐
│                        前端技术                              │
├─────────────────────────────────────────────────────────────┤
│  jQuery (AJAX 请求)  +  原生 CSS3 (动画/响应式)              │
│  Thymeleaf (模板引擎，注入 contextPath)                      │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼ HTTP POST/GET
┌─────────────────────────────────────────────────────────────┐
│                        后端技术                              │
├─────────────────────────────────────────────────────────────┤
│  Spring Boot (Web 框架)                                      │
│  @RestController (REST API)                                  │
│  @ConfigurationProperties (配置绑定)                         │
│  MyBatis (数据库操作)                                        │
│  HttpRequest (Hutool HTTP 客户端，调用外部 API)              │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼ HTTPS
┌─────────────────────────────────────────────────────────────┐
│                      外部 AI API                             │
├─────────────────────────────────────────────────────────────┤
│  DeepSeek API (OpenAI 兼容格式)                              │
│  Google Gemini API                                           │
└─────────────────────────────────────────────────────────────┘
```

---

## 🔑 核心技术点讲解

### 1. 配置驱动设计 (`@ConfigurationProperties`)

```yaml
# application.yml
ai:
  deepseek:
    api-key: sk-xxx
    base-url: https://api.deepseek.com/chat/completions
    model: deepseek-chat
```

```java
// AiConfig.java
@ConfigurationProperties(prefix = "ai")
public class AiConfig {
    private DeepSeekConfig deepseek;
    // Spring Boot 自动将 yml 中的值注入
}
```

**讲解要点**：配置与代码分离，方便切换 API 提供商，无需改代码。

---

### 2. 系统提示词工程 (System Prompt)

```java
private static final String SYSTEM_PROMPT = 
    "你是咖咖小铺的专业咖啡顾问..." +
    "# 咖啡产地知识库\n" +
    "## 埃塞俄比亚: 花香、柑橘、柠檬酸质...\n" +
    "# 对话规则\n" +
    "1. 回复简洁，控制在200字以内...";
```

**讲解要点**：
- System Prompt 是 AI 的"人设说明书"
- 包含角色定义、知识库、行为规则
- 决定了 AI 回答的专业度和风格

---

### 3. API 调用封装

```java
// DeepSeek API (OpenAI 兼容格式)
JSONObject requestBody = new JSONObject();
requestBody.set("model", "deepseek-chat");
requestBody.set("messages", [
    {"role": "system", "content": SYSTEM_PROMPT},
    {"role": "user", "content": userMessage}
]);

HttpRequest.post(baseUrl)
    .header("Authorization", "Bearer " + apiKey)
    .body(requestBody.toString())
    .execute();
```

**讲解要点**：
- 大多数 AI API 遵循 OpenAI 格式
- `messages` 数组包含对话历史
- `system` 角色用于设定 AI 行为

---

### 4. 前端悬浮组件实现

```javascript
// 动态创建 DOM
function createAiChatWidget() {
    var html = `
        <button class="ai-chat-fab">☕</button>
        <div class="ai-chat-popup">...</div>
    `;
    $('body').append(html);
}

// 事件委托 (处理动态元素)
$(document).on('click', '#ai-send-btn', sendMessage);
```

```css
/* 悬浮按钮定位 */
.ai-chat-fab {
    position: fixed;
    bottom: 30px;
    right: 30px;
    z-index: 9999;
}

/* 弹窗动画 */
.ai-chat-popup {
    transform: translateY(20px) scale(0.95);
    opacity: 0;
    transition: all 0.3s ease;
}
.ai-chat-popup.show {
    transform: translateY(0) scale(1);
    opacity: 1;
}
```

**讲解要点**：
- `position: fixed` 实现悬浮效果
- CSS `transition` 实现平滑动画
- 事件委托解决动态元素绑定问题

---

### 5. 聊天记录持久化

```
用户发送消息 → 后端保存到数据库 → AI 回复 → 保存 AI 回复
页面刷新 → 前端请求 /ai/history → 后端查询数据库 → 返回历史记录
```

**关键代码**：
```java
// 保存消息
AiChatMessage msg = AiChatMessage.builder()
    .userId(loginUser.getId())
    .role("user")
    .content(message)
    .createTime(new Date())
    .build();
aiChatMessageMapper.insert(msg);
```

---

## 📊 架构图

```
┌──────────────┐      AJAX       ┌──────────────┐
│   Browser    │ ───────────────▶│  Spring Boot │
│  (jQuery)    │◀─────────────── │  Controller  │
└──────────────┘      JSON       └──────┬───────┘
                                        │
                        ┌───────────────┼───────────────┐
                        ▼               ▼               ▼
                ┌──────────────┐ ┌──────────────┐ ┌──────────────┐
                │  AiService   │ │   MyBatis    │ │   Session    │
                │ (调用AI API) │ │ (存储历史)   │ │ (用户登录)   │
                └──────┬───────┘ └──────────────┘ └──────────────┘
                       │
                       ▼
                ┌──────────────┐
                │ DeepSeek API │
                │ Gemini API   │
                └──────────────┘
```

---

## 🎓 如何教别人做类似功能

### 第一步：选择 AI API
- 推荐：DeepSeek (国内可直连)、OpenAI、Gemini
- 获取 API Key

### 第二步：后端封装
1. 创建配置类读取 API Key
2. 创建 Service 封装 HTTP 请求
3. 编写 System Prompt（**最重要**）
4. 创建 Controller 暴露接口

### 第三步：前端实现
1. 创建聊天 UI（输入框、消息列表）
2. 用 AJAX 发送请求
3. 显示 AI 回复

### 第四步（可选）：持久化
1. 建表存储消息
2. 登录时加载历史

---

## 💡 核心要点总结

| 技术点 | 重要性 | 说明 |
|--------|--------|------|
| System Prompt | ⭐⭐⭐⭐⭐ | 决定 AI 的专业度和回答质量 |
| API 封装 | ⭐⭐⭐⭐ | 隔离第三方依赖，方便切换 |
| 配置外置 | ⭐⭐⭐ | API Key 不硬编码，安全且灵活 |
| 前端悬浮组件 | ⭐⭐⭐ | 用户体验的关键 |
| 历史持久化 | ⭐⭐ | 增强功能，非必需 |
