package com.coffeeshop.mapper;

import com.coffeeshop.entity.UserCoupon;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 用户优惠券表数据库访问层
 */
@Mapper
public interface UserCouponMapper {

    /**
     * 添加用户优惠券
     */
    int insert(UserCoupon userCoupon);

    /**
     * 批量添加用户优惠券
     */
    int batchInsert(@Param("list") List<UserCoupon> list);

    /**
     * 删除用户优惠券
     */
    int deleteById(Integer id);

    /**
     * 根据所属的优惠券ID批量物理清除分发给用户的残余记录
     */
    int deleteByCouponId(Integer couponId);

    /**
     * 查询单条数据
     */
    UserCoupon getById(Integer id);

    /**
     * 查询用户的优惠券列表（带关联 coupon 信息）
     */
    List<UserCoupon> listUserCoupons(UserCoupon userCoupon);

    /**
     * 查询用户可用的优惠券（未使用、未过期、满足金额条件）
     */
    List<UserCoupon> listUsableCoupons(@Param("userId") Integer userId, @Param("totalAmount") Double totalAmount);

    /**
     * 修改用户优惠券
     */
    int update(UserCoupon userCoupon);
}
