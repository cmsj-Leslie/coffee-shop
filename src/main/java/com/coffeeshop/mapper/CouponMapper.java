package com.coffeeshop.mapper;

import com.coffeeshop.entity.Coupon;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 优惠券表数据库访问层
 */
@Mapper
public interface CouponMapper {

    /**
     * 添加优惠券
     */
    int insert(Coupon coupon);

    /**
     * 删除优惠券
     */
    int deleteById(Integer id);

    /**
     * 查询单条数据
     */
    Coupon getById(Integer id);

    /**
     * 查询全部优惠券
     */
    List<Coupon> listCoupons();

    /**
     * 修改优惠券
     */
    int update(Coupon coupon);
}
