package com.coffeeshop.service;

import com.coffeeshop.entity.Order;

import java.util.List;

/**
 * @author Wen
 * @InterfaceName OrderService
 *                订单表(Order)表业务接口
 * @date 2026-01-10 12:58:00
 * @Version 1.0
 **/
public interface OrderService {

    /**
     * @param order 实例对象
     * @return 是否成功
     *         添加Order
     */
    boolean insert(Order order);

    /**
     * @param id 主键
     * @return 是否成功
     *         删除Order
     */
    boolean deleteById(Integer id);

    /**
     * @param id 主键
     * @return 实例对象
     *         查询单条数据
     */
    Order getById(Integer id);

    /**
     * @return 对象列表
     *         查询全部数据
     *         分页使用MyBatis的插件实现
     */
    List<Order> listOrders();

    /**
     * @param order 实例对象
     * @return 对象列表
     *         实体作为筛选条件查询数据
     */
    List<Order> listOrders(Order order);

    /**
     * @param order 实例对象
     * @return 结果数量
     *         实体作为筛选条件获取结果数量
     */
    int countOrders(Order order);

    /**
     * @param order 实例对象
     * @return 是否成功
     *         修改数据，哪个属性不为空就修改哪个属性
     */
    boolean update(Order order);

}