package com.coffeeshop.service.impl;

import org.springframework.stereotype.Service;
import com.coffeeshop.entity.Order;
import com.coffeeshop.service.BaseService;
import com.coffeeshop.service.OrderService;

import java.util.List;
import java.util.Map;

/**
 * @ClassName OrderServiceImpl
 *            订单表(Order)表业务接口实现类
 * @Version 1.0
 **/
@Service("orderService")
public class OrderServiceImpl extends BaseService implements OrderService {

    @Override
    public boolean insert(Order order) {
        return orderMapper.insert(order) == 1;
    }

    @Override
    public boolean deleteById(Integer id) {
        return orderMapper.deleteById(id) == 1;
    }

    @Override
    public Order getById(Integer id) {
        return orderMapper.getById(id);
    }

    @Override
    public List<Order> listOrders() {
        return orderMapper.listOrders();
    }

    @Override
    public List<Order> listOrders(Order order) {
        return orderMapper.listOrders(order);
    }

    @Override
    public int countOrders(Order order) {
        return orderMapper.countOrders(order);
    }

    @Override
    public boolean update(Order order) {
        return orderMapper.update(order) == 1;
    }

    @Override
    public Double getTotalRevenue() {
        return orderMapper.getTotalRevenue();
    }

    @Override
    public Integer getTotalOrderCount() {
        return orderMapper.getTotalOrderCount();
    }

    @Override
    public List<Map<String, Object>> getSalesTrend(int days) {
        return orderMapper.getSalesTrend(days);
    }

    @Override
    public List<Map<String, Object>> getTop5Products() {
        return orderMapper.getTop5Products();
    }

    @Override
    public List<Map<String, Object>> getOrderStatusDistribution() {
        return orderMapper.getOrderStatusDistribution();
    }

}