package com.coffeeshop.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.coffeeshop.entity.AiChatMessage;

import java.util.List;

/**
 * AI 聊天记录 Mapper 接口
 * 
 * 【功能说明】
 * 定义对 ai_chat_message 表的数据库操作方法
 * 使用 MyBatis 框架，SQL 语句定义在对应的 XML 文件中
 * 
 * 【对应 XML 文件】
 * resources/mybatis/mapper/AiChatMessageMapper.xml
 * 
 * 【设计说明】
 * - 使用 @Mapper 注解，被 Spring 自动扫描并注册为 Bean
 * - 方法名与 XML 中的 id 对应
 * - @Param 注解用于给参数命名，在 XML 中通过 #{名称} 引用
 *
 * @author Wen
 */
@Mapper // MyBatis 注解：声明这是一个 Mapper 接口
public interface AiChatMessageMapper {

    /**
     * 插入一条聊天记录
     * 
     * 【使用场景】
     * 用户发送消息或 AI 回复时调用，将消息保存到数据库
     * 
     * 【对应 SQL】
     * INSERT INTO ai_chat_message (user_id, role, content, provider, create_time)
     * VALUES (#{userId}, #{role}, #{content}, #{provider}, #{createTime})
     *
     * @param message 聊天记录实体（包含用户ID、角色、内容等）
     * @return 影响的行数（成功返回 1）
     */
    int insert(AiChatMessage message);

    /**
     * 查询用户的聊天历史
     * 
     * 【使用场景】
     * 页面加载时调用，获取用户历史对话用于显示
     * 
     * 【对应 SQL】
     * SELECT * FROM ai_chat_message
     * WHERE user_id = #{userId}
     * ORDER BY create_time ASC
     * LIMIT #{limit}
     * 
     * 【排序说明】
     * 按时间正序排列（ASC），这样旧消息在上，新消息在下
     * 符合聊天记录的阅读习惯
     *
     * @param userId 用户 ID
     * @param limit  返回数量限制（如最近 50 条）
     * @return 聊天记录列表
     */
    List<AiChatMessage> listByUserId(@Param("userId") Integer userId, @Param("limit") Integer limit);

    /**
     * 删除用户的所有聊天记录
     * 
     * 【使用场景】
     * 用户点击"清空记录"按钮时调用
     * 
     * 【对应 SQL】
     * DELETE FROM ai_chat_message WHERE user_id = #{userId}
     *
     * @param userId 用户 ID
     * @return 删除的记录数
     */
    int deleteByUserId(@Param("userId") Integer userId);

    /**
     * 统计用户的聊天记录数量
     * 
     * 【使用场景】
     * 可用于显示用户的对话条数统计
     * 
     * 【对应 SQL】
     * SELECT COUNT(*) FROM ai_chat_message WHERE user_id = #{userId}
     *
     * @param userId 用户 ID
     * @return 记录数量
     */
    int countByUserId(@Param("userId") Integer userId);
}
