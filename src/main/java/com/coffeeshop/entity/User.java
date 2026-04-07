package com.coffeeshop.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

/**
 * 用户表(User)实体类
 * 表示系统中的用户信息
 * 对应数据库中的 user 表
 *
 * @author Wen
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User implements Serializable {

    // 序列化版本号，用于确保类在反序列化时的兼容性
    private static final long serialVersionUID = 463829696564879359L;

    // 主键ID
    private Integer id;

    // 用户名
    private String name;

    // 密码（建议加密存储）
    private String password;

    // 邮箱地址（用于找回密码、通知等）
    private String email;

    // 头像地址（图片 URL）
    private String img;

    // 个人说明 / 签名
    private String info;

    // 注册时间
    private Date registerTime;

    // 用户角色（0：普通用户，1：管理员）
    private Integer role;

    // 最近更新时间
    private Date updateTime;

    // 下单总数（统计用）
    private int orderCount;

    // 评论总数（活跃度分析用）
    private int commentCount;
}
