package com.coffeeshop.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * AI API 配置类
 * 
 * 功能说明：
 * 1. 使用 @ConfigurationProperties 注解，自动读取 application.yml 中 ai.* 的配置
 * 2. 支持 DeepSeek 和 Gemini 两种 AI 提供商
 * 3. 配置项包括 API Key、请求地址、模型名称
 * 
 * 配置示例 (application.yml)：
 * ai:
 * deepseek:
 * api-key: sk-xxx
 * base-url: https://api.deepseek.com/chat/completions
 * model: deepseek-chat
 * gemini:
 * api-key: xxx
 * base-url: https://generativelanguage.googleapis.com/v1beta/models
 * model: gemini-2.0-flash
 *
 */
@Data // Lombok 注解：自动生成 getter/setter
@Component // 注册为 Spring Bean
@ConfigurationProperties(prefix = "ai") // 绑定 yml 中以 "ai" 开头的配置
public class AiConfig {

    /**
     * DeepSeek API 配置
     * DeepSeek 是一个国产大模型，API 格式兼容 OpenAI
     */
    private DeepSeekConfig deepseek = new DeepSeekConfig();

    /**
     * Gemini API 配置
     * Gemini 是 Google 的大模型，需要科学上网
     */
    private GeminiConfig gemini = new GeminiConfig();

    /**
     * DeepSeek 配置内部类
     */
    @Data
    public static class DeepSeekConfig {
        /**
         * API 密钥
         * 获取方式：访问 https://platform.deepseek.com 注册并创建 API Key
         * 注意：Spring Boot 会自动将 yml 中的 api-key 映射到 apiKey（驼峰转换）
         */
        private String apiKey;

        /**
         * API 请求地址
         * DeepSeek 的聊天接口地址，兼容 OpenAI 格式
         */
        private String baseUrl;

        /**
         * 模型名称
         * 可选值：deepseek-chat（对话模型）、deepseek-coder（代码模型）
         */
        private String model;
    }

    /**
     * Gemini 配置内部类
     */
    @Data
    public static class GeminiConfig {
        /**
         * API 密钥
         * 获取方式：访问 https://aistudio.google.com 创建 API Key
         */
        private String apiKey;

        /**
         * API 请求地址
         * Gemini 的 REST API 基础地址
         * - 直连模式: https://generativelanguage.googleapis.com/v1beta/models
         * - CF代理模式: https://your-domain.com/v1beta/models
         */
        private String baseUrl;

        /**
         * 模型名称
         * 可选值：gemini-pro、gemini-2.0-flash 等
         */
        private String model;

        /**
         * 是否使用代理服务（如 CF Workers 部署的 gemini-balance-lite）
         * - true: API Key 通过 HTTP Header (x-goog-api-key) 传递，适用于 CF 代理
         * - false: API Key 通过 URL 参数 (?key=) 传递，适用于直连 Google API
         * 默认 false，保持原有行为
         */
        private boolean useProxyService = false;
    }

    /**
     * 代理配置
     * 用于访问需要科学上网的 API（如 Gemini）
     */
    private ProxyConfig proxy = new ProxyConfig();

    /**
     * 代理配置内部类
     */
    @Data
    public static class ProxyConfig {
        /**
         * 是否启用代理
         * true: 使用代理访问 Gemini
         * false: 直连（需要网络环境支持）
         */
        private boolean enabled = false;

        /**
         * 代理服务器地址
         * 例如：127.0.0.1
         */
        private String host = "127.0.0.1";

        /**
         * 代理服务器端口
         * 常见端口：7890 (Clash), 1080 (SS)
         */
        private int port = 7890;
    }
}
