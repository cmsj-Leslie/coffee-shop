package com.coffeeshop.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * 优惠券实体
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Coupon implements Serializable {
    private Integer id;
    private String name;
    private Integer type;        // 1=满减券 2=折扣券
    private Double minAmount;    // 最低使用金额
    private Double reduceAmount; // 满减金额（type=1）
    private Double discount;     // 折扣率（type=2，如0.8表示8折）
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date startTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date endTime;
    private Date createTime;
    private Integer status;      // 1=启用 0=禁用
}
