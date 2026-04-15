package com.coffeeshop.service;

import com.coffeeshop.entity.Coupon;

import java.util.List;

public interface CouponService {
    boolean insert(Coupon coupon);
    boolean deleteById(Integer id);
    Coupon getById(Integer id);
    List<Coupon> listCoupons();
    boolean update(Coupon coupon);
    void distributeToAllUsers(Integer couponId);
}
