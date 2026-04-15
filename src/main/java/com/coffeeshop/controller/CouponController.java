package com.coffeeshop.controller;

import com.coffeeshop.dto.ResponseResult;
import com.coffeeshop.entity.Coupon;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;

/**
 * 优惠券控制器
 */
@RestController
public class CouponController extends BaseController {

    @PostMapping("/addCoupon")
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult addCoupon(Coupon coupon) {
        coupon.setCreateTime(new Date());
        coupon.setStatus(1);
        if (couponService.insert(coupon)) {
            couponService.distributeToAllUsers(coupon.getId());
            result.setCode(200);
            result.setMessage("优惠券创建成功，已发放给所有用户");
            result.setData(coupon);
        } else {
            result.setCode(500);
            result.setMessage("创建失败");
        }
        return result;
    }

    @PostMapping("/deleteCoupon")
    public ResponseResult deleteCoupon(Integer id) {
        if (couponService.deleteById(id)) {
            result.setCode(200);
            result.setMessage("删除成功");
        } else {
            result.setCode(500);
            result.setMessage("删除失败");
        }
        return result;
    }

    @PostMapping("/updateCoupon")
    public ResponseResult updateCoupon(Coupon coupon) {
        if (couponService.update(coupon)) {
            result.setCode(200);
            result.setMessage("更新成功");
        } else {
            result.setCode(500);
            result.setMessage("更新失败");
        }
        return result;
    }
}
