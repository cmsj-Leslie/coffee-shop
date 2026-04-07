# 🚀 通用 AI 助手集成指南 (即插即用版)

> **文档说明**
> 
> 这是一个**完全可落地**的集成指南。
> 您只需要按照下列步骤，复制对应的代码文件到您的 Spring Boot 项目中，
> 并修改标注为 `【自定义】` 的部分，即可在 10 分钟内拥有一个智能 AI 助手。
>
> **适用场景**：任何标准的 Spring Boot + Thymeleaf/HTML/JSP 这里的 Web 项目。
> **前置要求**：JDK 1.8+, Maven/Gradle

---

## 📋 目录 (Table of Contents)

1. [准备工作：引入依赖](#1-准备工作引入依赖)
2. [第一步：数据库建表](#2-第一步数据库建表)
3. [第二步：后端代码集成](#3-第二步后端代码集成)
   - [配置类 (AiConfig)](#31-配置类-aiconfig)
   - [实体类 (AiChatMessage)](#32-实体类-aichatmessage)
   - [Mapper 接口与 XML](#33-mapper-接口与-xml)
   - [Service 业务逻辑 (核心)](#34-service-业务逻辑-核心)
   - [Controller 接口](#35-controller-接口)
4. [第三步：前端代码集成](#4-第三步前端代码集成)
   - [样式文件 (ai-chat.css)](#41-样式文件-ai-chatcss)
   - [脚本文件 (ai-chat.js)](#42-脚本文件-ai-chatjs)
   - [引入到页面](#43-引入到页面)
5. [第四步：配置文件设置](#5-第四步配置文件设置)

---

## 1. 准备工作：引入依赖

在您的 `pom.xml` 中添加以下依赖（如果已有则跳过）：

```xml
<!-- 1. Hutool 工具包 (用于发送 HTTP 请求) -->
<dependency>
    <groupId>cn.hutool</groupId>
    <artifactId>hutool-all</artifactId>
    <version>5.8.26</version>
</dependency>

<!-- 2. Lombok (用于简化代码，可选，如果不加需手动生成 getter/setter) -->
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <optional>true</optional>
</dependency>

<!-- 3. MyBatis (通常项目已有) -->
<dependency>
    <groupId>org.mybatis.spring.boot</groupId>
    <artifactId>mybatis-spring-boot-starter</artifactId>
    <version>2.3.1</version>
</dependency>
```

---

## 2. 第一步：数据库建表

在您的数据库中执行以下 SQL 脚本：

```sql
CREATE TABLE IF NOT EXISTS `sys_ai_chat_message` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
    `user_id` VARCHAR(64) NOT NULL COMMENT '用户ID (根据您系统的用户ID类型修改)',
    `role` VARCHAR(10) NOT NULL COMMENT '消息角色: user(用户) / ai(助手)',
    `content` TEXT NOT NULL COMMENT '消息内容',
    `provider` VARCHAR(20) DEFAULT 'deepseek' COMMENT '模型提供商',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    INDEX `idx_user_time` (`user_id`, `create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI助手聊天记录表';
```

---

## 3. 第二步：后端代码集成

> ⚠️ **注意**：复制代码后，请将包名 `package com.example.project...` 修改为您项目的实际包名！

### 3.1 配置类 (AiConfig)

文件路径：`src/main/java/com/example/project/config/AiConfig.java`

```java
package com.example.project.config; // ⬅️ 修改为您的包名

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Data
@Component
@ConfigurationProperties(prefix = "ai")
public class AiConfig {
    
    // 默认模型提供商 details
    private DeepSeekConfig deepseek = new DeepSeekConfig();
    
    // 如果需要 Gemini，可解开注释
    // private GeminiConfig gemini = new GeminiConfig();

    @Data
    public static class DeepSeekConfig {
        private String apiKey;
        private String baseUrl;
        private String model;
    }
}
```

### 3.2 实体类 (AiChatMessage)

文件路径：`src/main/java/com/example/project/entity/AiChatMessage.java`

```java
package com.example.project.entity; // ⬅️ 修改为您的包名

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.Date;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AiChatMessage {
    private Long id;
    private String userId; // 您的用户 ID 类型 (Long/Integer/String)
    private String role;   // "user" 或 "ai"
    private String content;
    private String provider;
    private Date createTime;
}
```

### 3.3 Mapper 接口与 XML

文件路径：`src/main/java/com/example/project/mapper/AiChatMessageMapper.java`

```java
package com.example.project.mapper; // ⬅️ 修改为您的包名

import com.example.project.entity.AiChatMessage;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface AiChatMessageMapper {
    int insert(AiChatMessage message);
    
    List<AiChatMessage> listByUserId(@Param("userId") String userId, @Param("limit") int limit);
    
    int deleteByUserId(@Param("userId") String userId);
}
```

文件路径：`src/main/resources/mapper/AiChatMessageMapper.xml`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<!-- ⬇️ 修改 namespace 为您的 Mapper 全路径 -->
<mapper namespace="com.example.project.mapper.AiChatMessageMapper">

    <insert id="insert" useGeneratedKeys="true" keyProperty="id">
        INSERT INTO sys_ai_chat_message (user_id, role, content, provider, create_time)
        VALUES (#{userId}, #{role}, #{content}, #{provider}, #{createTime})
    </insert>

    <select id="listByUserId" resultType="com.example.project.entity.AiChatMessage">
        SELECT * FROM sys_ai_chat_message
        WHERE user_id = #{userId}
        ORDER BY create_time ASC
        LIMIT #{limit}
    </select>

    <delete id="deleteByUserId">
        DELETE FROM sys_ai_chat_message WHERE user_id = #{userId}
    </delete>
</mapper>
```

### 3.4 Service 业务逻辑 (核心)

文件路径：`src/main/java/com/example/project/service/AiChatService.java`

```java
package com.example.project.service; // ⬅️ 修改为您的包名

import cn.hutool.http.HttpRequest;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.example.project.config.AiConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AiChatService {

    @Autowired
    private AiConfig aiConfig;

    // 🔴【自定义】修改这里的 System Prompt 来改变 AI 的人设
    private static final String SYSTEM_PROMPT = 
        "# 角色设定\n" +
        "你是一个【[修改为您的项目名称]】的智能助手。\n" +
        "1. 你的语气要热情、专业。\n" +
        "2. 你只回答与本项目业务相关的问题。\n" +
        "3. 如果用户问不知道的问题，礼貌拒绝。";

    public String chat(String message) {
        try {
            // 1. 获取配置
            String apiKey = aiConfig.getDeepseek().getApiKey();
            String baseUrl = aiConfig.getDeepseek().getBaseUrl();
            String model = aiConfig.getDeepseek().getModel();

            // 2. 构建请求体 (DeepSeek / OpenAI 兼容格式)
            JSONObject body = new JSONObject();
            body.set("model", model);
            
            JSONArray messages = new JSONArray();
            messages.add(new JSONObject().set("role", "system").set("content", SYSTEM_PROMPT));
            messages.add(new JSONObject().set("role", "user").set("content", message));
            
            body.set("messages", messages);

            // 3. 发送请求
            String response = HttpRequest.post(baseUrl)
                    .header("Authorization", "Bearer " + apiKey)
                    .header("Content-Type", "application/json")
                    .body(body.toString())
                    .timeout(20000)
                    .execute()
                    .body();

            // 4. 解析结果
            JSONObject json = JSONUtil.parseObj(response);
            if (json.containsKey("choices")) {
                return json.getJSONArray("choices")
                        .getJSONObject(0)
                        .getJSONObject("message")
                        .getStr("content");
            }
            return "AI 响应异常: " + response;
            
        } catch (Exception e) {
            e.printStackTrace();
            return "服务繁忙，请稍后再试。";
        }
    }
}
```

### 3.5 Controller 接口

文件路径：`src/main/java/com/example/project/controller/AiChatController.java`

```java
package com.example.project.controller; // ⬅️ 修改为您的包名

import com.example.project.entity.AiChatMessage;
import com.example.project.mapper.AiChatMessageMapper;
import com.example.project.service.AiChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/ai")
public class AiChatController {

    @Autowired
    private AiChatService aiService;
    
    @Autowired
    private AiChatMessageMapper messageMapper;

    @PostMapping("/chat")
    public Map<String, Object> chat(@RequestParam String message, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        // 🔴【自定义】这里获取当前登录用户ID，根据您的系统修改
        // Object user = session.getAttribute("loginUser");
        // String userId = (user != null) ? user.getId() : "guest";
        String userId = "1001"; // 示例ID

        // 1. 调用 AI
        String reply = aiService.chat(message);

        // 2. 保存记录 (可选)
        if (!"guest".equals(userId)) {
           saveMessage(userId, "user", message);
           saveMessage(userId, "ai", reply);
        }

        result.put("success", true);
        result.put("reply", reply);
        return result;
    }
    
    private void saveMessage(String userId, String role, String content) {
        AiChatMessage msg = AiChatMessage.builder()
                .userId(userId).role(role).content(content)
                .provider("deepseek").createTime(new Date()).build();
        messageMapper.insert(msg);
    }
}
```

---

## 4. 第三步：前端代码集成

请将以下文件保存到您的静态资源目录（如 `src/main/resources/static/ai`）。

### 4.1 样式文件 (ai-chat.css)

> 💡 **提示**：这段 CSS 包含了一个漂亮的悬浮按钮和聊天窗口。

```css
/* ai-chat.css */
.ai-fab {
    position: fixed; bottom: 30px; right: 30px; width: 60px; height: 60px;
    background: #007bff; border-radius: 50%; color: white;
    box-shadow: 0 4px 12px rgba(0,0,0,0.2); cursor: pointer; z-index: 9999;
    display: flex; align-items: center; justify-content: center; font-size: 30px;
    transition: transform 0.3s;
}
.ai-fab:hover { transform: scale(1.1); }

.ai-window {
    position: fixed; bottom: 100px; right: 30px; width: 350px; height: 500px;
    background: white; border-radius: 12px; box-shadow: 0 5px 20px rgba(0,0,0,0.15);
    display: flex; flex-direction: column; overflow: hidden; z-index: 9998;
    transform-origin: bottom right; transition: all 0.3s ease;
}
.ai-window.hidden { transform: scale(0); opacity: 0; pointer-events: none; }

.ai-header { padding: 15px; background: #007bff; color: white; display: flex; justify-content: space-between; }
.ai-body { flex: 1; padding: 15px; overflow-y: auto; display: flex; flex-direction: column; gap: 10px; background: #f5f5f5; }
.ai-footer { padding: 10px; border-top: 1px solid #ddd; display: flex; gap: 10px; }
.ai-footer input { flex: 1; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
.ai-footer button { padding: 8px 15px; background: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer; }

/* 消息气泡 */
.msg { padding: 8px 12px; border-radius: 8px; max-width: 80%; word-wrap: break-word; }
.msg.user { align-self: flex-end; background: #007bff; color: white; }
.msg.ai { align-self: flex-start; background: white; border: 1px solid #ddd; color: #333; }
```

### 4.2 脚本文件 (ai-chat.js)

```javascript
// ai-chat.js
$(document).ready(function() {
    // 1. 注入 HTML (如果页面没有)
    if ($('#ai-fab').length === 0) {
        $('body').append(`
            <div id="ai-fab" class="ai-fab">🤖</div>
            <div id="ai-window" class="ai-window hidden">
                <div class="ai-header">智能小助手 <span style="cursor:pointer" onclick="$('#ai-window').addClass('hidden')">×</span></div>
                <div id="ai-msgs" class="ai-body">
                    <div class="msg ai">你好！我是智能助手，有什么可以帮你？</div>
                </div>
                <div class="ai-footer">
                    <input type="text" id="ai-in" placeholder="输入问题...">
                    <button id="ai-btn">发送</button>
                </div>
            </div>
        `);
    }

    // 2. 绑定事件
    $('#ai-fab').click(function() { $('#ai-window').toggleClass('hidden'); });
    
    $('#ai-btn').click(sendMessage);
    $('#ai-in').keypress(function(e) { if(e.which == 13) sendMessage(); });

    function sendMessage() {
        var txt = $('#ai-in').val().trim();
        if(!txt) return;
        
        // 显示用户消息
        $('#ai-msgs').append(`<div class="msg user">${escapeHtml(txt)}</div>`);
        $('#ai-in').val('');
        scrollToBottom();

        // 显示正在输入...
        var loadingId = 'loading-' + Date.now();
        $('#ai-msgs').append(`<div id="${loadingId}" class="msg ai">...</div>`);
        scrollToBottom();

        // 发送请求
        $.post('/ai/chat', { message: txt }, function(res) {
            $('#' + loadingId).remove();
            if(res.success) {
                $('#ai-msgs').append(`<div class="msg ai">${escapeHtml(res.reply)}</div>`);
            } else {
                $('#ai-msgs').append(`<div class="msg ai error">出错了: ${res.message}</div>`);
            }
            scrollToBottom();
        });
    }

    function scrollToBottom() {
        var div = document.getElementById('ai-msgs');
        div.scrollTop = div.scrollHeight;
    }
    
    function escapeHtml(text) {
        return text.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\n/g, "<br>");
    }
});
```

### 4.3 引入到页面

在您项目的公共布局文件（如 `common.html` 或 `layout.html`）的 `</body>` 之前加入：

```html
<!-- 引入 jQuery (如果项目已有可跳过) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- 引入 AI 助手资源 -->
<link rel="stylesheet" href="/static/ai/ai-chat.css">
<script src="/static/ai/ai-chat.js"></script>
```

---

## 5. 第四步：配置文件设置

打开 `src/main/resources/application.yml`，添加以下配置：

```yaml
# 🧠 AI 助手配置
ai:
  deepseek:
    # 🔴【自定义】去 https://platform.deepseek.com 申请 Key
    api-key: sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    base-url: https://api.deepseek.com/chat/completions
    model: deepseek-chat
```

---

## ✅ 完成！

现在启动您的 Spring Boot 项目，访问任意页面，右下角应该会出现一个 🤖 悬浮按钮。点击即可开始对话！

### 🔥 进阶修改建议

1. **修改图标**：在 css 中修改 `.ai-fab` 的 `content` 或 `background-image`。
2. **修改颜色**：将 css 中的 `#007bff` 替换为您项目的主题色。
3. **更智能的回复**：重点调整 `AiChatService.java` 中的 `SYSTEM_PROMPT`，这是 AI 的灵魂。尽量描述清楚它的职责和知识范围。
