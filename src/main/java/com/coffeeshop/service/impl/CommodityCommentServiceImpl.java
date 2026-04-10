package com.coffeeshop.service.impl;

import org.springframework.stereotype.Service;
import com.coffeeshop.entity.CommodityComment;
import com.coffeeshop.service.BaseService;
import com.coffeeshop.service.CommodityCommentService;

import java.util.List;

/**
 * @ClassName CommodityCommentServiceImpl
 *            商品评价表(CommodityComment)表业务接口实现类
 * @Version 1.0
 **/
@Service("commodityCommentService")
public class CommodityCommentServiceImpl extends BaseService implements CommodityCommentService {

    @Override
    public boolean insert(CommodityComment commodityComment) {
        return commodityCommentMapper.insert(commodityComment) == 1;
    }

    @Override
    public boolean deleteById(Integer id) {
        return commodityCommentMapper.deleteById(id) == 1;
    }

    @Override
    public CommodityComment getById(Integer id) {
        return commodityCommentMapper.getById(id);
    }

    @Override
    public List<CommodityComment> listCommodityComments() {
        return commodityCommentMapper.listCommodityComments();
    }

    @Override
    public List<CommodityComment> listCommodityComments(CommodityComment commodityComment) {
        return commodityCommentMapper.listCommodityComments(commodityComment);
    }

    @Override
    public int countCommodityComments(CommodityComment commodityComment) {
        return commodityCommentMapper.countCommodityComments(commodityComment);
    }

    @Override
    public boolean update(CommodityComment commodityComment) {
        return commodityCommentMapper.update(commodityComment) == 1;
    }

    @Override
    public Double getAvgStar(Integer commodityId) {
        return commodityCommentMapper.getAvgStar(commodityId);
    }

}