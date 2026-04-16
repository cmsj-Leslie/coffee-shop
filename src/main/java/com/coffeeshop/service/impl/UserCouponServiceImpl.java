package com.coffeeshop.service.impl;

import com.coffeeshop.entity.UserCoupon;
import com.coffeeshop.service.BaseService;
import com.coffeeshop.service.UserCouponService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("userCouponService")
public class UserCouponServiceImpl extends BaseService implements UserCouponService {

    @Override
    public List<UserCoupon> listUserCoupons(UserCoupon param) {
        return userCouponMapper.listUserCoupons(param);
    }

    @Override
    public List<UserCoupon> listUsableCoupons(Integer userId, Double totalAmount) {
        return userCouponMapper.listUsableCoupons(userId, totalAmount);
    }

    @Override
    public UserCoupon getById(Integer id) {
        return userCouponMapper.getById(id);
    }

    @Override
    public boolean update(UserCoupon userCoupon) {
        return userCouponMapper.update(userCoupon) == 1;
    }
}
