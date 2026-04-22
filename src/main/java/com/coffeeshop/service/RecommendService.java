package com.coffeeshop.service;

import com.coffeeshop.entity.Collection;
import com.coffeeshop.entity.Commodity;
import com.coffeeshop.entity.CommodityComment;
import com.coffeeshop.entity.Order;
import com.coffeeshop.mapper.CollectionMapper;
import com.coffeeshop.mapper.CommodityCommentMapper;
import com.coffeeshop.mapper.CommodityMapper;
import com.coffeeshop.mapper.OrderMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 基于物品的协同过滤推荐（Item-based CF）
 *
 * 算法流程：
 * 1. 构建用户-商品评分矩阵（购买=3分、评价星级=1~5分、收藏=2分，取最高值）
 * 2. 计算商品间余弦相似度
 * 3. 根据目标用户已交互商品，加权求和得到候选商品推荐分
 * 4. 过滤已交互商品，返回 Top-N
 * 5. 冷启动（新用户/无数据）降级为全局热门
 */
@Service
public class RecommendService {

    @Resource
    private OrderMapper orderMapper;
    @Resource
    private CommodityCommentMapper commodityCommentMapper;
    @Resource
    private CollectionMapper collectionMapper;
    @Resource
    private CommodityMapper commodityMapper;

    private static final int TOP_N = 8;

    /**
     * 为指定用户生成推荐商品列表
     *
     * @param userId 当前登录用户ID
     * @return 推荐商品列表（已填充分类名、折扣、评星）
     */
    public List<Commodity> recommend(Integer userId) {
        // 1. 构建全量用户-商品评分矩阵
        // map: userId -> (commodityId -> score)
        Map<Integer, Map<Integer, Double>> userItemMatrix = buildUserItemMatrix();

        // 2. 当前用户没有任何行为 → 冷启动降级
        Map<Integer, Double> userVector = userItemMatrix.getOrDefault(userId, Collections.emptyMap());
        if (userVector.isEmpty()) {
            return hotFallback();
        }

        // 3. 计算物品相似度矩阵（只计算与目标用户交互过的商品相关的部分，节省计算量）
        // 取所有商品ID
        Set<Integer> allItems = userItemMatrix.values().stream()
                .flatMap(m -> m.keySet().stream())
                .collect(Collectors.toSet());

        // 用户已交互的商品
        Set<Integer> interactedItems = userVector.keySet();

        // 4. 对每个候选商品（未交互），计算推荐分 = Σ sim(candidate, interacted) * userScore(interacted)
        Map<Integer, Double> candidateScores = new HashMap<>();

        for (Integer candidate : allItems) {
            if (interactedItems.contains(candidate)) continue; // 已交互，跳过

            double score = 0.0;
            for (Integer interacted : interactedItems) {
                double sim = cosineSimilarity(candidate, interacted, userItemMatrix);
                if (sim > 0) {
                    score += sim * userVector.get(interacted);
                }
            }
            if (score > 0) {
                candidateScores.put(candidate, score);
            }
        }

        // 5. 按推荐分降序取 Top-N
        List<Integer> topIds = candidateScores.entrySet().stream()
                .sorted(Map.Entry.<Integer, Double>comparingByValue().reversed())
                .limit(TOP_N)
                .map(Map.Entry::getKey)
                .collect(Collectors.toList());

        if (topIds.isEmpty()) {
            return hotFallback();
        }

        // 6. 批量查询商品详情并填充附加字段
        List<Commodity> result = commodityMapper.listCommoditysByIds(topIds);
        enrichCommodities(result);

        // 按推荐分顺序排列（listCommoditysByIds 不保证顺序）
        Map<Integer, Integer> orderMap = new HashMap<>();
        for (int i = 0; i < topIds.size(); i++) {
            orderMap.put(topIds.get(i), i);
        }
        result.sort(Comparator.comparingInt(c -> orderMap.getOrDefault(c.getId(), Integer.MAX_VALUE)));

        return result;
    }

    /**
     * 构建用户-商品评分矩阵
     * 信号权重：购买(status>=0) = 3.0，评价星级 = stars * 1.0，收藏 = 2.0
     * 同一用户对同一商品取最高分
     */
    private Map<Integer, Map<Integer, Double>> buildUserItemMatrix() {
        Map<Integer, Map<Integer, Double>> matrix = new HashMap<>();

        // 购买行为（status >= 0 表示非取消订单）
        List<Order> orders = orderMapper.listAllUserCommodityInteractions();
        for (Order order : orders) {
            matrix.computeIfAbsent(order.getUserId(), k -> new HashMap<>())
                    .merge(order.getCommodityId(), 3.0, (a, b) -> a > b ? a : b);
        }

        // 评价行为（星级直接作为分值）
        List<CommodityComment> comments = commodityCommentMapper.listAllUserCommodityComments();
        for (CommodityComment comment : comments) {
            if (comment.getStars() == null) continue;
            double starScore = comment.getStars().doubleValue();
            matrix.computeIfAbsent(comment.getUserId(), k -> new HashMap<>())
                    .merge(comment.getCommodityId(), starScore, (a, b) -> a > b ? a : b);
        }

        // 收藏行为（隐式正反馈，固定 2.0 分）
        List<Collection> collections = collectionMapper.listAllUserCommodityCollections();
        for (Collection collection : collections) {
            matrix.computeIfAbsent(collection.getUserId(), k -> new HashMap<>())
                    .merge(collection.getCommodityId(), 2.0, (a, b) -> a > b ? a : b);
        }

        return matrix;
    }

    /**
     * 计算两个商品之间的余弦相似度
     * sim(i, j) = Σ(u: r_ui * r_uj) / (||i|| * ||j||)
     */
    private double cosineSimilarity(Integer itemA, Integer itemB,
                                    Map<Integer, Map<Integer, Double>> matrix) {
        double dot = 0.0;
        double normA = 0.0;
        double normB = 0.0;

        for (Map<Integer, Double> userRatings : matrix.values()) {
            Double rA = userRatings.get(itemA);
            Double rB = userRatings.get(itemB);
            if (rA != null) normA += rA * rA;
            if (rB != null) normB += rB * rB;
            if (rA != null && rB != null) {
                dot += rA * rB;
            }
        }

        if (normA == 0 || normB == 0) return 0.0;
        return dot / (Math.sqrt(normA) * Math.sqrt(normB));
    }

    /**
     * 冷启动降级：返回全局销量 Top-N 商品
     */
    private List<Commodity> hotFallback() {
        List<Commodity> hot = commodityMapper.listCommoditysOrderBySaleCount();
        if (hot.size() > TOP_N) hot = hot.subList(0, TOP_N);
        enrichCommodities(hot);
        return hot;
    }

    /**
     * 填充商品的折扣和平均评星（与 CommodityServiceImpl 保持一致）
     */
    private void enrichCommodities(List<Commodity> commodities) {
        commodities.forEach(c -> {
            // 折扣
            if (c.getOriginalPrice() != null && c.getCurrentPrice() != null && c.getOriginalPrice() > 0) {
                double discount = BigDecimal.valueOf(c.getCurrentPrice() / c.getOriginalPrice())
                        .multiply(BigDecimal.valueOf(10))
                        .setScale(1, RoundingMode.HALF_UP)
                        .doubleValue();
                c.setDiscount(discount);
            }
            // 平均评星
            Double avgStar = commodityCommentMapper.getAvgStar(c.getId());
            if (avgStar != null) {
                int rounded = (int) Math.round(avgStar);
                c.setStars(rounded);
            }
        });
    }
}
