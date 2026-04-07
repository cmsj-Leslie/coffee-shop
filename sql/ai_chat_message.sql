-- AI 聊天记录表
-- 用于保存用户与 AI 助手的对话历史

CREATE TABLE IF NOT EXISTS ai_chat_message (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
    user_id INT NOT NULL COMMENT '用户ID',
    role VARCHAR(10) NOT NULL COMMENT '消息角色: user(用户)/ai(AI助手)',
    content TEXT NOT NULL COMMENT '消息内容',
    provider VARCHAR(20) COMMENT 'AI提供商: deepseek/gemini',
    create_time DATETIME NOT NULL COMMENT '创建时间',
    INDEX idx_user_id (user_id),
    INDEX idx_create_time (create_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI聊天记录表';
