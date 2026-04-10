package com.coffeeshop.service;

/**
 * AI 聊天服务接口
 * 
 * 功能说明：
 * 定义与 AI 大模型交互的方法，支持多个 AI 提供商（DeepSeek、Gemini）
 * 
 * 设计模式：
 * 采用策略模式思想，通过接口抽象，方便后续扩展更多 AI 提供商
 *
 */
public interface AiChatService {

    /**
     * 使用 DeepSeek API 进行对话
     * 
     * DeepSeek 特点：
     * - 国内可直连，速度快
     * - API 格式兼容 OpenAI
     * - 支持中文对话
     *
     * @param message 用户发送的消息内容
     * @return AI 生成的回复内容
     */
    String chatWithDeepSeek(String message);

    /**
     * 使用 Gemini API 进行对话
     * 
     * Gemini 特点：
     * - Google 出品，能力强
     * - 需要科学上网（或配置代理）
     * - API 格式与 OpenAI 不同
     *
     * @param message 用户发送的消息内容
     * @return AI 生成的回复内容
     */
    String chatWithGemini(String message);

    /**
     * 根据提供商选择对应的 API 进行对话
     * 
     * 这是对外暴露的主要方法，Controller 层调用此方法
     * 内部根据 provider 参数路由到具体的实现
     *
     * @param message  用户发送的消息内容
     * @param provider API 提供商标识 ("deepseek" 或 "gemini")
     * @return AI 生成的回复内容
     */
    String chat(String message, String provider);
}
