package com.coffeeshop.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

/**
 * AI 聊天记录实体类
 * 
 * 【功能说明】
 * 对应数据库表 ai_chat_message，用于存储用户与 AI 的对话历史
 * 
 * 【表结构】
 * CREATE TABLE ai_chat_message (
 * id INT AUTO_INCREMENT PRIMARY KEY, -- 主键
 * user_id INT NOT NULL, -- 用户 ID
 * role VARCHAR(10) NOT NULL, -- 消息角色：user/ai
 * content TEXT NOT NULL, -- 消息内容
 * provider VARCHAR(20), -- AI 提供商
 * create_time DATETIME NOT NULL -- 创建时间
 * );
 * 
 * 【设计说明】
 * - 使用 Lombok 注解简化代码
 * - 实现 Serializable 接口，支持序列化（Session 存储等场景）
 *
 */
@Data // Lombok: 自动生成 getter/setter/toString/equals/hashCode
@NoArgsConstructor // Lombok: 自动生成无参构造函数
@AllArgsConstructor // Lombok: 自动生成全参构造函数
@Builder // Lombok: 支持 Builder 模式构建对象
public class AiChatMessage implements Serializable {

    /**
     * 序列化版本号
     * 用于确保类在反序列化时的兼容性
     */
    private static final long serialVersionUID = 1L;

    /**
     * 主键 ID（自增）
     */
    private Integer id;

    /**
     * 用户 ID
     * 关联 user 表的主键，标识这条消息属于哪个用户
     */
    private Integer userId;

    /**
     * 消息角色
     * 
     * 可选值：
     * - "user": 用户发送的消息
     * - "ai": AI 助手的回复
     * 
     * 用于前端区分消息显示样式（用户消息靠右，AI 消息靠左）
     */
    private String role;

    /**
     * 消息内容
     * 
     * 存储实际的对话文本
     * 使用 TEXT 类型，支持长文本
     */
    private String content;

    /**
     * AI 提供商
     * 
     * 可选值：
     * - "deepseek": 使用 DeepSeek API 生成的回复
     * - "gemini": 使用 Gemini API 生成的回复
     * 
     * 记录每条 AI 回复使用的是哪个模型
     */
    private String provider;

    /**
     * 创建时间
     * 
     * 记录消息的发送/生成时间
     * 用于按时间排序显示历史记录
     */
    private Date createTime;
}
