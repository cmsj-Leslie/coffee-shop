package com.coffeeshop.service.impl;

import cn.hutool.core.util.ObjectUtil;
import org.springframework.stereotype.Service;
import com.coffeeshop.entity.Classify;
import com.coffeeshop.entity.Commodity;
import com.coffeeshop.service.BaseService;
import com.coffeeshop.service.CommodityService;

import java.math.BigDecimal;
import java.util.List;

/**
 * @ClassName CommodityServiceImpl
 *            商品【咖啡豆】表(Commodity)表业务接口实现类
 * @Version 1.0
 **/
@Service("commodityService")
public class CommodityServiceImpl extends BaseService implements CommodityService {

    @Override
    public boolean insert(Commodity commodity) {
        return commodityMapper.insert(commodity) == 1;
    }

    @Override
    public boolean deleteById(Integer id) {
        return commodityMapper.deleteById(id) == 1;
    }

    @Override
    public Commodity getById(Integer id) {
        Commodity commodity = commodityMapper.getById(id);
        // 获取分类名称
        Classify classify = classifyMapper.getById(commodity.getClassifyId());
        if (ObjectUtil.isNotEmpty(classify)) {
            commodity.setClassify(classify.getName());
        }
        // 计算折扣
        Double originalPrice = commodity.getOriginalPrice();
        Double currentPrice = commodity.getCurrentPrice();
        if (originalPrice != null && originalPrice > 0 && currentPrice != null) {
            Double discount = new BigDecimal(currentPrice / originalPrice).multiply(new BigDecimal(10))
                    .setScale(1, BigDecimal.ROUND_HALF_UP).doubleValue();
            commodity.setDiscount(discount);
        }
        // 获取平均星星数
        Double avgStar = commodityCommentMapper.getAvgStar(commodity.getId());
        if (ObjectUtil.isNotEmpty(avgStar)) {
            avgStar = new BigDecimal(avgStar).setScale(0, BigDecimal.ROUND_HALF_UP).doubleValue();
        }
        commodity.setStars(ObjectUtil.isNotEmpty(avgStar) ? avgStar.intValue() : null);
        return commodity;
    }

    @Override
    public List<Commodity> listCommoditys() {
        List<Commodity> commodities = commodityMapper.listCommoditys();
        commodities.forEach(temp -> {
            // 获取分类名称
            Classify classify = classifyMapper.getById(temp.getClassifyId());
            if (ObjectUtil.isNotEmpty(classify)) {
                temp.setClassify(classify.getName());
            }
            // 计算折扣
            Double originalPrice = temp.getOriginalPrice();
            Double currentPrice = temp.getCurrentPrice();
            if (originalPrice != null && originalPrice > 0 && currentPrice != null) {
                Double discount = new BigDecimal(currentPrice / originalPrice).multiply(new BigDecimal(10))
                        .setScale(1, BigDecimal.ROUND_HALF_UP).doubleValue();
                temp.setDiscount(discount);
            }
            // 获取平均星星数
            Double avgStar = commodityCommentMapper.getAvgStar(temp.getId());
            if (ObjectUtil.isNotEmpty(avgStar)) {
                avgStar = new BigDecimal(avgStar).setScale(0, BigDecimal.ROUND_HALF_UP).doubleValue();
            }
            temp.setStars(ObjectUtil.isNotEmpty(avgStar) ? avgStar.intValue() : null);
        });
        return commodities;
    }

    @Override
    public List<Commodity> listCommoditys(Commodity commodity) {
        List<Commodity> commodities = commodityMapper.listCommoditys(commodity);
        commodities.forEach(temp -> {
            // 获取分类名称
            Classify classify = classifyMapper.getById(temp.getClassifyId());
            if (ObjectUtil.isNotEmpty(classify)) {
                temp.setClassify(classify.getName());
            }
            // 计算折扣
            Double originalPrice = temp.getOriginalPrice();
            Double currentPrice = temp.getCurrentPrice();
            if (originalPrice != null && originalPrice > 0 && currentPrice != null) {
                Double discount = new BigDecimal(currentPrice / originalPrice).multiply(new BigDecimal(10))
                        .setScale(1, BigDecimal.ROUND_HALF_UP).doubleValue();
                temp.setDiscount(discount);
            }
            // 获取平均星星数
            Double avgStar = commodityCommentMapper.getAvgStar(temp.getId());
            if (ObjectUtil.isNotEmpty(avgStar)) {
                avgStar = new BigDecimal(avgStar).setScale(0, BigDecimal.ROUND_HALF_UP).doubleValue();
            }
            temp.setStars(ObjectUtil.isNotEmpty(avgStar) ? avgStar.intValue() : null);
        });
        return commodities;
    }

    @Override
    public List<Commodity> listCommoditys(String keyWord) {
        List<Commodity> commodities = commodityMapper.listCommoditysByKeyWord(keyWord);
        commodities.forEach(temp -> {
            // 获取分类名称
            Classify classify = classifyMapper.getById(temp.getClassifyId());
            if (ObjectUtil.isNotEmpty(classify)) {
                temp.setClassify(classify.getName());
            }
            // 计算折扣
            Double originalPrice = temp.getOriginalPrice();
            Double currentPrice = temp.getCurrentPrice();
            if (originalPrice != null && originalPrice > 0 && currentPrice != null) {
                Double discount = new BigDecimal(currentPrice / originalPrice).multiply(new BigDecimal(10))
                        .setScale(1, BigDecimal.ROUND_HALF_UP).doubleValue();
                temp.setDiscount(discount);
            }
            // 获取平均星星数
            Double avgStar = commodityCommentMapper.getAvgStar(temp.getId());
            if (ObjectUtil.isNotEmpty(avgStar)) {
                avgStar = new BigDecimal(avgStar).setScale(0, BigDecimal.ROUND_HALF_UP).doubleValue();
            }
            temp.setStars(ObjectUtil.isNotEmpty(avgStar) ? avgStar.intValue() : null);
        });
        return commodities;
    }

    @Override
    public int countCommoditys(Commodity commodity) {
        return commodityMapper.countCommoditys(commodity);
    }

    @Override
    public boolean update(Commodity commodity) {
        return commodityMapper.update(commodity) == 1;
    }

    @Override
    public List<Commodity> listCommoditysOrderBySaleCount() {
        List<Commodity> commodities = commodityMapper.listCommoditysOrderBySaleCount();
        commodities.forEach(temp -> {
            // 获取分类名称
            Classify classify = classifyMapper.getById(temp.getClassifyId());
            if (ObjectUtil.isNotEmpty(classify)) {
                temp.setClassify(classify.getName());
            }
            // 计算折扣
            Double originalPrice = temp.getOriginalPrice();
            Double currentPrice = temp.getCurrentPrice();
            if (originalPrice != null && originalPrice > 0 && currentPrice != null) {
                Double discount = new BigDecimal(currentPrice / originalPrice).multiply(new BigDecimal(10))
                        .setScale(1, BigDecimal.ROUND_HALF_UP).doubleValue();
                temp.setDiscount(discount);
            }
            // 获取平均星星数
            Double avgStar = commodityCommentMapper.getAvgStar(temp.getId());
            if (ObjectUtil.isNotEmpty(avgStar)) {
                avgStar = new BigDecimal(avgStar).setScale(0, BigDecimal.ROUND_HALF_UP).doubleValue();
            }
            temp.setStars(ObjectUtil.isNotEmpty(avgStar) ? avgStar.intValue() : null);
        });
        return commodities;
    }

    @Override
    public List<Commodity> listLowInventory(int threshold) {
        List<Commodity> commodities = commodityMapper.listLowInventory(threshold);
        commodities.forEach(temp -> {
            Classify classify = classifyMapper.getById(temp.getClassifyId());
            if (ObjectUtil.isNotEmpty(classify)) {
                temp.setClassify(classify.getName());
            }
        });
        return commodities;
    }

}