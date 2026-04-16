package com.coffeeshop.controller;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.coffeeshop.dto.ResponseResult;
import com.coffeeshop.entity.Cart;
import com.coffeeshop.entity.Commodity;
import com.coffeeshop.entity.Order;
import com.coffeeshop.entity.UserCoupon;
import com.coffeeshop.entity.Coupon;

import java.util.Date;

/**
 * 订单控制器
 *
 */
@RestController
public class OrderController extends BaseController {

    /**
     * 购买商品
     */
    @PostMapping("/buyCommodity")
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult buyCommodity(@RequestParam("cartId") Integer cartId, Integer addressId) {
        // 获取购物车信息
        Cart cart = cartService.getById(cartId);
        Commodity commodity = cart.getCommodity();
        if (commodity.getInventory() < cart.getCount()) {
            result.setCode(500);
            result.setMessage("库存不足，购买失败");
        } else {
            // 更新库存
            commodity.setInventory(commodity.getInventory() - cart.getCount());
            // 更新销售量
            commodity.setSaleCount(commodity.getSaleCount() + cart.getCount());
            if (commodityService.update(commodity)) {
                // 减库存成功，生成订单
                Order order = Order.builder()
                        .userId(loginUser.getId())
                        .commodityId(commodity.getId())
                        .orderNumber(System.currentTimeMillis() + "")
                        .content(commodity.getClassify() + "-" + commodity.getName() + "*" + cart.getCount())
                        .createTime(new Date())
                        .payTime(new Date())
                        .status(0)
                        .addressId(addressId)
                        .build();
                if (orderService.insert(order)) {
                    // 订单生成成功，删除购物车
                    if (cartService.deleteById(cartId)) {
                        result.setCode(200);
                        result.setMessage("购买成功，等待发货 ...");
                    } else {
                        result.setCode(500);
                        result.setMessage("服务器出错");
                    }
                } else {
                    result.setCode(500);
                    result.setMessage("服务器出错");
                }
            } else {
                result.setCode(500);
                result.setMessage("服务器出错");
            }
        }
        return result;
    }

    /**
     * 批量购买商品
     */
    @PostMapping("/batchBuyCommodity")
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult batchBuyCommodity(@RequestParam("cartIds") String cartIds, Integer addressId, Integer userCouponId) {
        String[] ids = cartIds.split(",");
        String orderPrefix = System.currentTimeMillis() + "";
        int successCount = 0;
        StringBuilder errorMsg = new StringBuilder();

        // 计算总金额
        double totalAmount = 0;
        for (String id : ids) {
            Cart cart = cartService.getById(Integer.parseInt(id.trim()));
            if (cart != null) {
                totalAmount += cart.getCommodity().getCurrentPrice() * cart.getCount();
            }
        }

        // 计算优惠券折扣
        double actualAmount = totalAmount;
        Integer couponId = null;
        if (userCouponId != null && userCouponId > 0) {
            UserCoupon userCoupon = userCouponService.getById(userCouponId);
            if (userCoupon != null && userCoupon.getStatus() == 0) {
                Coupon coupon = userCoupon.getCoupon();
                // 二次校验：优惠券是否在有效期内 && 订单金额是否满足最低门槛
                boolean isValid = coupon != null
                        && coupon.getEndTime() != null && coupon.getEndTime().after(new Date())
                        && (coupon.getMinAmount() == null || totalAmount >= coupon.getMinAmount());
                if (isValid) {
                    if (coupon.getType() == 1) {
                        actualAmount = totalAmount - coupon.getReduceAmount();
                    } else if (coupon.getType() == 2) {
                        actualAmount = totalAmount * coupon.getDiscount();
                    }
                    actualAmount = Math.max(actualAmount, 0);
                    couponId = coupon.getId();
                }
                // 若校验不通过，couponId 保持 null，按原价结算
            }
        }

        for (int i = 0; i < ids.length; i++) {
            Integer cartId = Integer.parseInt(ids[i].trim());
            Cart cart = cartService.getById(cartId);
            Commodity commodity = cart.getCommodity();

            if (commodity.getInventory() < cart.getCount()) {
                errorMsg.append(commodity.getName()).append("库存不足；");
                continue;
            }

            // 更新库存
            commodity.setInventory(commodity.getInventory() - cart.getCount());
            // 更新销售量
            commodity.setSaleCount(commodity.getSaleCount() + cart.getCount());

            if (commodityService.update(commodity)) {
                // 生成订单（使用统一订单号前缀 + 序号）
                Order order = Order.builder()
                        .userId(loginUser.getId())
                        .commodityId(commodity.getId())
                        .orderNumber(orderPrefix + "-" + (i + 1))
                        .content(commodity.getClassify() + "-" + commodity.getName() + "*" + cart.getCount())
                        .createTime(new Date())
                        .payTime(new Date())
                        .status(0)
                        .addressId(addressId)
                        .totalAmount(totalAmount)
                        .actualAmount(actualAmount)
                        .couponId(couponId)
                        .build();

                if (orderService.insert(order)) {
                    cartService.deleteById(cartId);
                    successCount++;
                }
            }
        }

        // 标记优惠券已使用
        if (userCouponId != null && userCouponId > 0 && successCount > 0) {
            UserCoupon uc = UserCoupon.builder()
                    .id(userCouponId)
                    .status(1)
                    .useTime(new Date())
                    .build();
            userCouponService.update(uc);
        }

        if (successCount == ids.length) {
            result.setCode(200);
            result.setMessage("购买成功，共" + successCount + "件商品，等待发货 ...");
        } else if (successCount > 0) {
            result.setCode(200);
            result.setMessage("部分购买成功：" + successCount + "件。" + errorMsg.toString());
        } else {
            result.setCode(500);
            result.setMessage("购买失败：" + errorMsg.toString());
        }

        return result;
    }

    /**
     * 发货
     */
    @PostMapping("/deliverGoods")
    public ResponseResult deliverGoods(@RequestParam("id") Integer id, String courierNumber, String courierCompany) {
        // 获取订单信息
        Order order = orderService.getById(id);
        order.setCourierNumber(courierNumber);
        order.setCourierCompany(courierCompany);
        order.setShippingTime(new Date());
        order.setStatus(1);
        // 更新订单信息
        if (orderService.update(order)) {
            result.setCode(200);
            result.setMessage("发货成功");
        } else {
            result.setCode(500);
            result.setMessage("服务器出错");
        }
        return result;
    }

    /**
     * 取消订单
     */
    @PostMapping("/cancelOrder")
    public ResponseResult cancelOrder(Integer id) {
        Order param = Order.builder().id(id).status(-1).build();
        if (orderService.update(param)) {
            result.setCode(200);
            result.setMessage("取消订单成功");
        } else {
            result.setCode(500);
            result.setMessage("服务器出错");
        }
        return result;
    }

    /**
     * 确认收货
     */
    @PostMapping("/confirmOrder")
    public ResponseResult confirmOrder(Integer id) {
        Order param = Order.builder().id(id).status(2).successTime(new Date()).build();
        if (orderService.update(param)) {
            result.setCode(200);
            result.setMessage("确认收货成功");
        } else {
            result.setCode(500);
            result.setMessage("服务器出错");
        }
        return result;
    }

    /**
     * 删除订单
     */
    @PostMapping("/deleteOrder")
    public ResponseResult deleteOrder(Integer id) {
        if (orderService.deleteById(id)) {
            result.setCode(200);
            result.setMessage("删除订单成功");
        } else {
            result.setCode(500);
            result.setMessage("服务器出错");
        }
        return result;
    }

}