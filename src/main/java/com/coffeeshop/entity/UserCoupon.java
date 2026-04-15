package com.coffeeshop.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

/**
 * 用户优惠券实体
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserCoupon implements Serializable {
    private Integer id;
    private Integer userId;
    private Integer couponId;
    private Integer status;      // 0=未使用 1=已使用
    private Date receiveTime;
    private Date useTime;
    private Integer orderId;

    // 关联字段
    private Coupon coupon;
}
