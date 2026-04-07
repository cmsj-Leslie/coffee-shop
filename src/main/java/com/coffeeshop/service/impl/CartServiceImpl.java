package com.coffeeshop.service.impl;

import org.springframework.stereotype.Service;
import com.coffeeshop.entity.Cart;
import com.coffeeshop.entity.Commodity;
import com.coffeeshop.service.BaseService;
import com.coffeeshop.service.CartService;

import java.util.List;

/**
 * @author Wen
 * @ClassName CartServiceImpl
 *            购物车(Cart)表业务接口实现类
 * @date 2025-11-28 09:35:00
 * @Version 1.0
 **/
@Service("cartService")
public class CartServiceImpl extends BaseService implements CartService {

    @Override
    public boolean insert(Cart cart) {
        return cartMapper.insert(cart) == 1;
    }

    @Override
    public boolean deleteById(Integer id) {
        return cartMapper.deleteById(id) == 1;
    }

    @Override
    public Cart getById(Integer id) {
        Cart cart = cartMapper.getById(id);
        Commodity commodity = commodityMapper.getById(cart.getCommodityId());
        commodity.setClassify(classifyMapper.getById(commodity.getClassifyId()).getName());
        cart.setCommodity(commodity);
        return cart;
    }

    @Override
    public List<Cart> listCarts() {
        List<Cart> carts = cartMapper.listCarts();
        carts.forEach(cart -> {
            Commodity commodity = commodityMapper.getById(cart.getCommodityId());
            commodity.setClassify(classifyMapper.getById(commodity.getClassifyId()).getName());
            cart.setCommodity(commodity);
        });
        return carts;
    }

    @Override
    public List<Cart> listCarts(Cart cart) {
        List<Cart> carts = cartMapper.listCarts(cart);
        carts.forEach(temp -> {
            Commodity commodity = commodityMapper.getById(temp.getCommodityId());
            commodity.setClassify(classifyMapper.getById(commodity.getClassifyId()).getName());
            temp.setCommodity(commodity);
        });
        return carts;
    }

    @Override
    public int countCarts(Cart cart) {
        return cartMapper.countCarts(cart);
    }

    @Override
    public boolean update(Cart cart) {
        return cartMapper.update(cart) == 1;
    }

}