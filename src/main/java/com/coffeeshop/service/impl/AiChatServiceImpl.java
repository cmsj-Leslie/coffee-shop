package com.coffeeshop.service.impl;

import cn.hutool.http.HttpRequest;
import cn.hutool.http.HttpResponse;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.coffeeshop.config.AiConfig;
import com.coffeeshop.service.AiChatService;

/**
 * AI 聊天服务实现类
 * 
 * 【核心功能】
 * 1. 封装与 DeepSeek 和 Gemini API 的 HTTP 通信
 * 2. 构建包含系统提示词(System Prompt)的请求
 * 3. 解析 AI 返回的 JSON 响应
 * 
 * 【重要概念】
 * System Prompt（系统提示词）：
 * - 相当于给 AI 设定"人设"和"知识库"
 * - 决定了 AI 回答的专业度、风格和边界
 * - 是整个 AI 助手最核心的部分
 *
 */
@Slf4j // Lombok 注解：自动生成日志对象 log
@Service // 注册为 Spring Service Bean
public class AiChatServiceImpl implements AiChatService {

    /**
     * 注入 AI 配置类，获取 API Key、URL 等配置
     */
    @Autowired
    private AiConfig aiConfig;

    /**
     * 【核心】咖啡顾问系统提示词
     * 
     * 这是 AI 助手的"灵魂"，包含：
     * 1. 角色设定 - 告诉 AI 它是谁
     * 2. 知识库 - 植入咖啡专业知识
     * 3. 行为规则 - 控制回复风格和边界
     * 
     * 提示词工程技巧：
     * - 使用 Markdown 格式组织内容，AI 理解更好
     * - 具体的知识点比抽象描述效果更好
     * - 明确的规则可以约束 AI 行为
     */
    private static final String SYSTEM_PROMPT =
            // ===== 第一部分：角色设定 =====
            "# 角色设定\n" +
                    "你是\"咖咖小铺\"的专业咖啡顾问助手，名叫\"咖咖\"。你拥有丰富的咖啡专业知识，热情友好，善于根据用户需求推荐合适的咖啡。\n\n" +

                    // ===== 第二部分：咖啡知识库 =====
                    "# 咖啡产地与风味知识库\n\n" +

                    "## 非洲产区\n" +
                    "### 埃塞俄比亚（咖啡发源地）\n" +
                    "- **耶加雪菲**：花香浓郁、柑橘调、茉莉花香、柠檬酸质、口感细腻如丝绸\n" +
                    "- **西达摩**：蓝莓、草莓风味、奶油般顺滑、甜感突出\n" +
                    "- **哈拉尔**：野性风味、蓝莓、红酒调、浓郁酒香\n\n" +

                    "### 肯尼亚\n" +
                    "- **肯尼亚AA**：黑醋栗、番茄酸质、葡萄柚、明亮酸度、厚实body\n" +
                    "- 特点：双重发酵处理法，风味层次丰富\n\n" +

                    "### 乌干达\n" +
                    "- 风味：巧克力、坚果、焦糖、低酸度、醇厚口感\n" +
                    "- 适合：喜欢浓郁醇厚风格的咖啡爱好者\n" +
                    "- 推荐搭配：早餐、甜点\n\n" +

                    "### 刚果\n" +
                    "- 风味：黑巧克力、烤坚果、烟熏味、泥土气息\n" +
                    "- 特点：野性十足，适合喜欢重口味的人\n\n" +

                    "## 中南美洲产区\n" +
                    "### 哥伦比亚\n" +
                    "- **慧兰/薇拉**：焦糖、红苹果、坚果、均衡柔和\n" +
                    "- **娜玲珑**：热带水果、蜂蜜、奶油\n" +
                    "- 特点：酸甜平衡、口感圆润、入门首选\n\n" +

                    "### 巴西\n" +
                    "- 风味：坚果、巧克力、焦糖、低酸度、醇厚\n" +
                    "- 特点：世界最大咖啡生产国，性价比高\n" +
                    "- 适合：意式浓缩、拿铁基底\n\n" +

                    "### 危地马拉\n" +
                    "- **安提瓜**：烟熏、巧克力、香料、丁香\n" +
                    "- 特点：火山土壤，海拔高，酸质明亮\n\n" +

                    "## 亚洲产区\n" +
                    "### 印度尼西亚\n" +
                    "- **曼特宁**：草本、泥土、黑巧克力、低酸、厚重body\n" +
                    "- **黄金曼特宁**：更干净、甜感更好\n" +
                    "- 特点：湿刨法处理，独特泥土风味\n\n" +

                    "### 云南（中国）\n" +
                    "- 风味：红糖、坚果、柔和果酸、蜂蜜\n" +
                    "- 特点：国产精品咖啡代表，普洱产区\n" +
                    "- 适合：支持国货的咖啡爱好者\n\n" +

                    // ===== 第三部分：咖啡饮品知识 =====
                    "# 咖啡饮品知识\n\n" +

                    "## 意式咖啡\n" +
                    "- **意式浓缩(Espresso)**：30ml、浓郁、油脂丰富、所有奶咖基底\n" +
                    "- **美式(Americano)**：浓缩+热水，清爽、苦而不涩\n" +
                    "- **拿铁(Latte)**：浓缩+蒸奶+薄奶泡，奶香浓郁、柔和顺滑\n" +
                    "- **卡布奇诺(Cappuccino)**：浓缩+蒸奶+厚奶泡，1:1:1比例，奶泡绵密\n" +
                    "- **摩卡(Mocha)**：浓缩+巧克力酱+蒸奶+奶油，甜蜜浓郁\n" +
                    "- **玛奇朵(Macchiato)**：浓缩+少量奶泡，保留咖啡风味\n" +
                    "- **馥芮白(Flat White)**：双份浓缩+细腻奶泡，咖啡味更浓\n\n" +

                    "## 特调与冰饮\n" +
                    "- **冰美式**：清爽解暑、提神醒脑\n" +
                    "- **冷萃**：12-24小时低温萃取，顺滑、低酸、甘甜\n" +
                    "- **气泡美式**：苏打水+浓缩，清新爽口\n" +
                    "- **dirty咖啡**：浓缩浇在冰牛奶上，分层渐变\n\n" +

                    // ===== 第四部分：冲泡技巧 =====
                    "# 冲泡方法指南\n\n" +

                    "## 手冲咖啡\n" +
                    "- 研磨度：中细（砂糖颗粒）\n" +
                    "- 水温：88-94℃\n" +
                    "- 比例：1:15（咖啡:水）\n" +
                    "- 技巧：先闷蒸30秒，再分2-3段注水\n\n" +

                    "## 法压壶\n" +
                    "- 研磨度：粗（粗砂）\n" +
                    "- 水温：93-96℃\n" +
                    "- 时间：4分钟浸泡\n" +
                    "- 特点：油脂丰富，body厚重\n\n" +

                    "## 摩卡壶\n" +
                    "- 研磨度：中细\n" +
                    "- 特点：介于手冲和意式之间的浓度\n" +
                    "- 适合：家庭制作仿意式咖啡\n\n" +

                    // ===== 第五部分：店铺商品 =====
                    "# 店铺商品目录\n\n" +

                    "## 卡布奇诺系列\n" +
                    "- 「晨曦之舞」：经典卡布，绵密奶泡，唤醒美好一天\n" +
                    "- 「赤道之韵」：非洲豆底，果香突出，热情奔放\n\n" +

                    "## 冰咖系列\n" +
                    "- 「冰封之心」：冷萃工艺，顺滑甘甜，夏日必备\n\n" +

                    "## 摩卡系列\n" +
                    "- 「巧克力之梦」：比利时巧克力，甜蜜邂逅咖啡\n\n" +

                    "## 单品咖啡\n" +
                    "- 「阳光之舞」：哥伦比亚豆，焦糖坚果，均衡柔和\n" +
                    "- 「秘境之韵」：乌干达豆，浓郁醇厚，巧克力调\n\n" +

                    // ===== 第六部分：行为规则 =====
                    "# 对话规则\n" +
                    "1. 回复简洁友好，控制在200字以内\n" +
                    "2. 适当使用咖啡相关emoji（☕🫘🌿✨💫）\n" +
                    "3. 根据用户口味偏好推荐合适的咖啡\n" +
                    "4. 如果用户描述口味喜好（如\"喜欢酸的\"\"不要太苦\"），精准推荐\n" +
                    "5. 可以主动询问用户的口味偏好来提供更好的推荐\n" +
                    "6. 不回答与咖啡无关的问题，礼貌地引导回咖啡话题";

    /**
     * 调用 DeepSeek API 进行对话
     * 
     * 【API 格式说明】
     * DeepSeek 采用 OpenAI 兼容格式，请求体结构：
     * {
     * "model": "deepseek-chat",
     * "messages": [
     * {"role": "system", "content": "系统提示词"},
     * {"role": "user", "content": "用户消息"}
     * ]
     * }
     * 
     * @param message 用户消息
     * @return AI 回复
     */
    @Override
    public String chatWithDeepSeek(String message) {
        try {
            // 从配置中获取 API 参数
            String apiKey = aiConfig.getDeepseek().getApiKey();
            String baseUrl = aiConfig.getDeepseek().getBaseUrl();
            String model = aiConfig.getDeepseek().getModel();

            // 检查 API Key 是否已配置（防止使用默认占位符）
            if ("YOUR_DEEPSEEK_API_KEY".equals(apiKey)) {
                return "⚠️ DeepSeek API Key 未配置，请在 application.yml 中设置您的 API Key";
            }

            // ===== 构建请求体 =====
            JSONObject requestBody = new JSONObject();
            requestBody.set("model", model); // 设置模型名称

            // 构建消息数组（包含系统提示词和用户消息）
            JSONArray messages = new JSONArray();
            // 系统消息：设定 AI 的角色和行为
            messages.add(new JSONObject().set("role", "system").set("content", SYSTEM_PROMPT));
            // 用户消息：用户实际发送的内容
            messages.add(new JSONObject().set("role", "user").set("content", message));
            requestBody.set("messages", messages);

            // ===== 发送 HTTP 请求 =====
            HttpResponse response = HttpRequest.post(baseUrl)
                    .header("Content-Type", "application/json") // 设置请求类型为 JSON
                    .header("Authorization", "Bearer " + apiKey) // Bearer Token 认证
                    .body(requestBody.toString()) // 设置请求体
                    .timeout(30000) // 超时时间 30 秒
                    .execute();

            // ===== 解析响应 =====
            if (response.isOk()) {
                JSONObject result = JSONUtil.parseObj(response.body());
                JSONArray choices = result.getJSONArray("choices");
                if (choices != null && !choices.isEmpty()) {
                    // 从响应中提取 AI 生成的文本
                    // 响应结构：{ "choices": [{ "message": { "content": "AI回复" } }] }
                    return choices.getJSONObject(0)
                            .getJSONObject("message")
                            .getStr("content");
                }
            }

            // 请求失败，记录日志
            log.error("DeepSeek API 调用失败: {}", response.body());
            return "抱歉，DeepSeek 服务暂时不可用，请稍后再试 😅";

        } catch (Exception e) {
            log.error("DeepSeek API 调用异常", e);
            return "抱歉，连接 DeepSeek 服务时出现问题：" + e.getMessage();
        }
    }

    /**
     * 调用 Gemini API 进行对话
     * 
     * 【API 格式说明】
     * Gemini API 格式与 OpenAI 不同：
     * - URL 格式：{baseUrl}/{model}:generateContent?key={apiKey}
     * - 使用 systemInstruction 设置系统提示词
     * - 使用 contents 设置对话内容
     * 
     * 【注意事项】
     * Gemini API 需要科学上网，代码中包含代理支持
     * 
     * @param message 用户消息
     * @return AI 回复
     */
    @Override
    public String chatWithGemini(String message) {
        try {
            // 从配置中获取 API 参数
            String apiKey = aiConfig.getGemini().getApiKey();
            String baseUrl = aiConfig.getGemini().getBaseUrl();
            String model = aiConfig.getGemini().getModel();

            log.info("Gemini配置 - apiKey: {}, baseUrl: {}, model: {}",
                    apiKey != null ? apiKey.substring(0, Math.min(10, apiKey.length())) + "..." : "null",
                    baseUrl, model);

            // 检查 API Key 是否已配置
            if (apiKey == null || "YOUR_GEMINI_API_KEY".equals(apiKey)) {
                return "⚠️ Gemini API Key 未配置，请在 application.yml 中设置您的 API Key";
            }

            // ===== 构建 API URL =====
            // 根据配置决定使用哪种模式
            boolean useProxyService = aiConfig.getGemini().isUseProxyService();
            String urlStr;

            if (useProxyService) {
                // CF代理模式：API Key 通过 Header 传递，URL 不包含 key 参数
                // 去除 baseUrl 末尾的斜杠（如果有）
                String cleanBaseUrl = baseUrl.endsWith("/") ? baseUrl.substring(0, baseUrl.length() - 1) : baseUrl;
                urlStr = cleanBaseUrl + "/" + model + ":generateContent";
                log.info("使用CF代理模式，Gemini请求URL: {}", urlStr);
            } else {
                // 直连模式：API Key 通过 URL 参数传递（原有逻辑）
                urlStr = baseUrl + "/" + model + ":generateContent?key=" + apiKey;
                log.info("使用直连模式，Gemini请求URL: {}", urlStr.replace(apiKey, "***")); // 日志中隐藏 API Key
            }

            // ===== 构建请求体（Gemini 格式） =====
            JSONObject requestBody = new JSONObject();

            // 设置系统指令（相当于 OpenAI 的 system message）
            JSONObject systemInstruction = new JSONObject();
            JSONArray systemParts = new JSONArray();
            systemParts.add(new JSONObject().set("text", SYSTEM_PROMPT));
            systemInstruction.set("parts", systemParts);
            requestBody.set("systemInstruction", systemInstruction);

            // 设置用户消息
            JSONArray contents = new JSONArray();
            JSONObject userContent = new JSONObject();
            JSONArray userParts = new JSONArray();
            userParts.add(new JSONObject().set("text", message));
            userContent.set("parts", userParts);
            contents.add(userContent);
            requestBody.set("contents", contents);

            log.info("发送Gemini请求...");

            // ===== 使用 Java 原生 HTTP 连接（支持代理） =====
            java.net.URL url = new java.net.URL(urlStr);
            java.net.HttpURLConnection conn;

            // ===== 从配置文件读取代理设置 =====
            // 配置位置：application.yml -> ai.proxy
            if (aiConfig.getProxy().isEnabled()) {
                String proxyHost = aiConfig.getProxy().getHost();
                int proxyPort = aiConfig.getProxy().getPort();
                log.info("使用代理: {}:{}", proxyHost, proxyPort);
                java.net.Proxy proxy = new java.net.Proxy(java.net.Proxy.Type.HTTP,
                        new java.net.InetSocketAddress(proxyHost, proxyPort));
                conn = (java.net.HttpURLConnection) url.openConnection(proxy);
            } else {
                log.info("未启用代理，直接连接...");
                conn = (java.net.HttpURLConnection) url.openConnection();
            }

            // 设置请求参数
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");

            // CF代理模式需要通过 Header 传递 API Key
            if (useProxyService) {
                conn.setRequestProperty("x-goog-api-key", apiKey);
                log.info("已设置 x-goog-api-key Header");
            }

            conn.setDoOutput(true);
            conn.setConnectTimeout(30000); // 连接超时 30 秒
            conn.setReadTimeout(60000); // 读取超时 60 秒

            // 发送请求体
            try (java.io.OutputStream os = conn.getOutputStream()) {
                byte[] input = requestBody.toString().getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            int responseCode = conn.getResponseCode();
            log.info("Gemini响应状态: {}", responseCode);

            // ===== 读取响应 =====
            java.io.InputStream inputStream = (responseCode >= 200 && responseCode < 300)
                    ? conn.getInputStream()
                    : conn.getErrorStream();

            StringBuilder responseText = new StringBuilder();
            try (java.io.BufferedReader br = new java.io.BufferedReader(
                    new java.io.InputStreamReader(inputStream, "utf-8"))) {
                String responseLine;
                while ((responseLine = br.readLine()) != null) {
                    responseText.append(responseLine.trim());
                }
            }

            log.info("Gemini完整响应: {}", responseText.toString());

            // ===== 解析响应 =====
            if (responseCode >= 200 && responseCode < 300) {
                JSONObject result = JSONUtil.parseObj(responseText.toString());
                JSONArray candidates = result.getJSONArray("candidates");
                if (candidates != null && !candidates.isEmpty()) {
                    // Gemini 响应结构：{ "candidates": [{ "content": { "parts": [{ "text": "AI回复" }] }
                    // }] }
                    JSONObject content = candidates.getJSONObject(0).getJSONObject("content");
                    JSONArray parts = content.getJSONArray("parts");
                    if (parts != null && !parts.isEmpty()) {
                        return parts.getJSONObject(0).getStr("text");
                    }
                }
            }

            log.error("Gemini API 调用失败: {}", responseText.toString());
            return "抱歉，Gemini 服务暂时不可用，请稍后再试 😅";

        } catch (Exception e) {
            log.error("Gemini API 调用异常", e);
            return "抱歉，连接 Gemini 服务时出现问题：" + e.getMessage();
        }
    }

    /**
     * 根据提供商路由到对应的 API
     * 
     * 这是 Controller 层调用的入口方法
     * 
     * @param message  用户消息
     * @param provider 提供商标识（"gemini" 或 "deepseek"）
     * @return AI 回复
     */
    @Override
    public String chat(String message, String provider) {
        if ("gemini".equalsIgnoreCase(provider)) {
            return chatWithGemini(message);
        } else {
            // 默认使用 DeepSeek（国内可直连）
            return chatWithDeepSeek(message);
        }
    }
}
