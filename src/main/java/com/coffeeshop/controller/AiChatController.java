package com.coffeeshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.coffeeshop.entity.AiChatMessage;
import com.coffeeshop.entity.User;
import com.coffeeshop.mapper.AiChatMessageMapper;
import com.coffeeshop.service.AiChatService;

import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * AI 聊天控制器
 * 
 * 【功能说明】
 * 提供 AI 咖啡咨询助手的 REST API 接口
 * 
 * 【接口列表】
 * POST /ai/chat - 发送消息并获取 AI 回复
 * GET /ai/history - 获取当前用户的聊天历史
 * DELETE /ai/history - 清空当前用户的聊天记录
 * GET /ai/status - 检查 AI 服务状态（调试用）
 * 
 * 【设计说明】
 * - 使用 @RestController，所有方法返回 JSON
 * - 通过 Session 获取当前登录用户
 * - 只有登录用户的聊天记录才会持久化到数据库
 *
 */
@RestController // 声明为 REST 控制器（返回 JSON 而非视图）
@RequestMapping("/ai") // 所有接口以 /ai 开头
public class AiChatController {

    /**
     * AI 聊天服务，负责调用 AI API
     */
    @Autowired
    private AiChatService aiChatService;

    /**
     * 聊天记录 Mapper，负责数据库操作
     */
    @Autowired
    private AiChatMessageMapper aiChatMessageMapper;

    /**
     * AI 对话接口
     * 
     * 【接口说明】
     * 接收用户消息，调用 AI API 获取回复，同时保存聊天记录
     * 
     * 【请求方式】POST
     * 【请求路径】/ai/chat
     * 【请求参数】
     * - message: 用户发送的消息内容（必填）
     * - provider: AI 提供商，"deepseek" 或 "gemini"（选填，默认 deepseek）
     * 
     * 【返回格式】
     * {
     * "success": true,
     * "reply": "AI 的回复内容",
     * "provider": "deepseek"
     * }
     *
     * @param message  用户消息
     * @param provider API 提供商
     * @param session  HTTP Session（自动注入，用于获取登录用户）
     * @return 包含 AI 回复的 JSON 对象
     */
    @PostMapping("/chat")
    public Map<String, Object> chat(
            @RequestParam String message, // 必填参数
            @RequestParam(defaultValue = "deepseek") String provider, // 可选参数，默认 deepseek
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        try {
            // ===== 1. 调用 AI 服务获取回复 =====
            String reply = aiChatService.chat(message, provider);
            result.put("success", true);
            result.put("reply", reply);
            result.put("provider", provider);

            // ===== 2. 如果用户已登录，保存聊天记录到数据库 =====
            User loginUser = (User) session.getAttribute("loginUser");
            if (loginUser != null) {
                Date now = new Date();

                // 保存用户消息
                AiChatMessage userMessage = AiChatMessage.builder()
                        .userId(loginUser.getId()) // 关联用户 ID
                        .role("user") // 消息角色：用户
                        .content(message) // 消息内容
                        .provider(provider) // 使用的 AI 提供商
                        .createTime(now) // 创建时间
                        .build();
                aiChatMessageMapper.insert(userMessage);

                // 保存 AI 回复（时间戳 +1ms 确保排序正确）
                AiChatMessage aiMessage = AiChatMessage.builder()
                        .userId(loginUser.getId())
                        .role("ai") // 消息角色：AI
                        .content(reply)
                        .provider(provider)
                        .createTime(new Date(now.getTime() + 1)) // 确保排在用户消息之后
                        .build();
                aiChatMessageMapper.insert(aiMessage);
            }
            // 注意：未登录用户的消息不会保存，刷新页面后消失

        } catch (Exception e) {
            // 异常处理：返回友好的错误提示
            result.put("success", false);
            result.put("reply", "抱歉，服务出现问题，请稍后再试 😅");
            result.put("error", e.getMessage());
        }

        return result;
    }

    /**
     * 获取聊天历史记录
     * 
     * 【接口说明】
     * 返回当前登录用户最近的 50 条聊天记录
     * 用于页面刷新后恢复历史对话
     * 
     * 【请求方式】GET
     * 【请求路径】/ai/history
     * 
     * 【返回格式】
     * {
     * "success": true,
     * "history": [
     * {"id": 1, "role": "user", "content": "推荐咖啡", "time": "2024-01-01 12:00:00"},
     * {"id": 2, "role": "ai", "content": "...", "time": "2024-01-01 12:00:01"}
     * ],
     * "count": 2
     * }
     *
     * @param session HTTP Session
     * @return 聊天历史列表
     */
    @GetMapping("/history")
    public Map<String, Object> getHistory(HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        // 检查用户是否登录
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            result.put("success", false);
            result.put("message", "请先登录");
            result.put("history", Collections.emptyList());
            return result;
        }

        try {
            // 查询最近 50 条记录（按时间正序排列）
            List<AiChatMessage> history = aiChatMessageMapper.listByUserId(loginUser.getId(), 50);

            // 转换为前端需要的格式
            List<Map<String, Object>> historyList = new ArrayList<>();
            for (AiChatMessage msg : history) {
                Map<String, Object> item = new HashMap<>();
                item.put("id", msg.getId());
                item.put("role", msg.getRole()); // "user" 或 "ai"
                item.put("content", msg.getContent());
                item.put("time", msg.getCreateTime());
                historyList.add(item);
            }

            result.put("success", true);
            result.put("history", historyList);
            result.put("count", historyList.size());

        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "获取历史记录失败：" + e.getMessage());
            result.put("history", Collections.emptyList());
        }

        return result;
    }

    /**
     * 清空聊天历史记录
     * 
     * 【接口说明】
     * 删除当前登录用户的所有聊天记录
     * 
     * 【请求方式】DELETE
     * 【请求路径】/ai/history
     * 
     * 【返回格式】
     * {
     * "success": true,
     * "message": "已清空 10 条聊天记录",
     * "deleted": 10
     * }
     *
     * @param session HTTP Session
     * @return 操作结果
     */
    @DeleteMapping("/history")
    public Map<String, Object> clearHistory(HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        // 检查用户是否登录
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            result.put("success", false);
            result.put("message", "请先登录");
            return result;
        }

        try {
            // 删除该用户的所有聊天记录
            int deleted = aiChatMessageMapper.deleteByUserId(loginUser.getId());
            result.put("success", true);
            result.put("message", "已清空 " + deleted + " 条聊天记录");
            result.put("deleted", deleted);

        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "清空失败：" + e.getMessage());
        }

        return result;
    }

    /**
     * 检查 AI 服务状态（调试接口）
     * 
     * 【接口说明】
     * 用于检查 AI 服务是否正常运行
     * 
     * 【请求方式】GET
     * 【请求路径】/ai/status
     *
     * @return 服务状态信息
     */
    @GetMapping("/status")
    public Map<String, Object> getStatus() {
        Map<String, Object> result = new HashMap<>();

        // 检查服务是否注入成功
        if (aiChatService == null) {
            result.put("error", "aiChatService is null");
            return result;
        }

        result.put("message", "咖咖小助手已就绪 ☕");
        result.put("deepseek", "configured");
        result.put("gemini", "configured");
        return result;
    }
}
