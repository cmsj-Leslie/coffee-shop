package com.coffeeshop.service;

import com.coffeeshop.entity.UserCoupon;

import java.util.List;

public interface UserCouponService {
    List<UserCoupon> listUsableCoupons(Integer userId, Double totalAmount);
    List<UserCoupon> listUserCoupons(UserCoupon param);
    UserCoupon getById(Integer id);
    boolean update(UserCoupon userCoupon);
}
