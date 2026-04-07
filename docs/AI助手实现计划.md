# AI 聊天记录数据库存储实现计划

## 目标
实现 AI 助手聊天记录的数据库持久化，支持跨页面、跨会话保留对话历史。

## 需要创建的文件

### 1. 数据库表
创建 `ai_chat_message` 表存储聊天记录

```sql
CREATE TABLE ai_chat_message (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL COMMENT '用户ID',
    role VARCHAR(10) NOT NULL COMMENT '消息角色: user/ai',
    content TEXT NOT NULL COMMENT '消息内容',
    provider VARCHAR(20) COMMENT 'AI提供商: deepseek/gemini',
    create_time DATETIME NOT NULL COMMENT '创建时间',
    INDEX idx_user_id (user_id),
    INDEX idx_create_time (create_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI聊天记录表';
```

---

### 2. 后端文件

#### [NEW] [AiChatMessage.java](file:///e:/JetBrains/Project/kaka-shop/src/main/java/com/coffee/shop/entity/AiChatMessage.java)
实体类，对应 `ai_chat_message` 表

#### [NEW] [AiChatMessageMapper.java](file:///e:/JetBrains/Project/kaka-shop/src/main/java/com/coffee/shop/mapper/AiChatMessageMapper.java)
Mapper 接口

#### [NEW] [AiChatMessageMapper.xml](file:///e:/JetBrains/Project/kaka-shop/src/main/resources/mybatis/mapper/AiChatMessageMapper.xml)
MyBatis SQL 映射文件

#### [MODIFY] [AiChatController.java](file:///e:/JetBrains/Project/kaka-shop/src/main/java/com/coffee/shop/controller/AiChatController.java)
- 添加获取历史记录 API: `GET /ai/history`
- 添加清空记录 API: `DELETE /ai/history`
- 修改 chat API 保存消息到数据库

---

### 3. 前端文件

#### [MODIFY] [ai-chat.js](file:///e:/JetBrains/Project/kaka-shop/src/main/resources/static/common/js/ai-chat.js)
- 页面加载时从后端获取历史记录
- 添加"清空记录"按钮功能

#### [MODIFY] [ai-chat.css](file:///e:/JetBrains/Project/kaka-shop/src/main/resources/static/common/css/ai-chat.css)
- 添加清空按钮样式

---

## API 设计

| 接口 | 方法 | 说明 |
|------|------|------|
| `/ai/chat` | POST | 发送消息（增加保存到数据库） |
| `/ai/history` | GET | 获取当前用户的聊天历史（最近50条） |
| `/ai/history` | DELETE | 清空当前用户的聊天记录 |

---

## 注意事项
- 只有登录用户才能保存聊天记录
- 未登录用户的聊天不会持久化（仅当前页面有效）
- 限制返回最近 50 条记录，避免数据过多
