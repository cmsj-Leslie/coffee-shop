package com.coffeeshop.service.impl;

import com.coffeeshop.entity.Coupon;
import com.coffeeshop.entity.User;
import com.coffeeshop.entity.UserCoupon;
import com.coffeeshop.service.BaseService;
import com.coffeeshop.service.CouponService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service("couponService")
public class CouponServiceImpl extends BaseService implements CouponService {

    @Override
    public boolean insert(Coupon coupon) {
        return couponMapper.insert(coupon) == 1;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteById(Integer id) {
        userCouponMapper.deleteByCouponId(id);
        return couponMapper.deleteById(id) == 1;
    }

    @Override
    public Coupon getById(Integer id) {
        return couponMapper.getById(id);
    }

    @Override
    public List<Coupon> listCoupons() {
        return couponMapper.listCoupons();
    }

    @Override
    public boolean update(Coupon coupon) {
        return couponMapper.update(coupon) == 1;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void distributeToAllUsers(Integer couponId) {
        // 查询所有用户
        List<User> users = userMapper.listUsers();
        if (users.isEmpty()) {
            return;
        }

        // 批量创建用户优惠券
        List<UserCoupon> userCoupons = new ArrayList<>();
        Date now = new Date();
        for (User user : users) {
            UserCoupon uc = UserCoupon.builder()
                    .userId(user.getId())
                    .couponId(couponId)
                    .status(0)
                    .receiveTime(now)
                    .build();
            userCoupons.add(uc);
        }

        userCouponMapper.batchInsert(userCoupons);
    }
}
