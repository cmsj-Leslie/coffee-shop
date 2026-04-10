package com.coffeeshop.service;

import com.coffeeshop.entity.Collection;

import java.util.List;

/**
 * @InterfaceName CollectionService
 *                收藏表(Collection)表业务接口
 * @Version 1.0
 **/
public interface CollectionService {

    /**
     * @param collection 实例对象
     * @return 是否成功
     *         添加Collection
     */
    boolean insert(Collection collection);

    /**
     * @param id 主键
     * @return 是否成功
     *         删除Collection
     */
    boolean deleteById(Integer id);

    /**
     * @param id 主键
     * @return 实例对象
     *         查询单条数据
     */
    Collection getById(Integer id);

    /**
     * @return 对象列表
     *         查询全部数据
     *         分页使用MyBatis的插件实现
     */
    List<Collection> listCollections();

    /**
     * @param collection 实例对象
     * @return 对象列表
     *         实体作为筛选条件查询数据
     */
    List<Collection> listCollections(Collection collection);

    /**
     * @param collection 实例对象
     * @return 结果数量
     *         实体作为筛选条件获取结果数量
     */
    int countCollections(Collection collection);

    /**
     * @param collection 实例对象
     * @return 是否成功
     *         修改数据，哪个属性不为空就修改哪个属性
     */
    boolean update(Collection collection);

    /**
     * 获取用户收藏的所有商品ID（优化N+1查询）
     * 
     * @param userId 用户ID
     * @return 商品ID列表
     */
    List<Integer> getCollectedCommodityIdsByUserId(Integer userId);

}