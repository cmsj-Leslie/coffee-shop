package com.coffeeshop.service;

import com.coffeeshop.mapper.*;

import javax.annotation.Resource;

/**
 * : 基础业务逻辑类
 *
 * @author: WenZeTong
 * @date 2025-12-18 12:18:00
 * @Version: 1.0
 */
public class BaseService {

    @Resource
    protected AddressMapper addressMapper;

    @Resource
    protected CartMapper cartMapper;

    @Resource
    protected ClassifyMapper classifyMapper;

    @Resource
    protected CollectionMapper collectionMapper;

    @Resource
    protected CommodityCommentMapper commodityCommentMapper;

    @Resource
    protected CommodityMapper commodityMapper;

    @Resource
    protected OrderMapper orderMapper;

    @Resource
    protected UserMapper userMapper;

}
