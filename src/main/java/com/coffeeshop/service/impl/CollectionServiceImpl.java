package com.coffeeshop.service.impl;

import org.springframework.stereotype.Service;
import com.coffeeshop.entity.Collection;
import com.coffeeshop.service.BaseService;
import com.coffeeshop.service.CollectionService;

import java.util.List;

/**
 * @ClassName CollectionServiceImpl
 *            收藏表(Collection)表业务接口实现类
 * @Version 1.0
 **/
@Service("collectionService")
public class CollectionServiceImpl extends BaseService implements CollectionService {

    @Override
    public boolean insert(Collection collection) {
        return collectionMapper.insert(collection) == 1;
    }

    @Override
    public boolean deleteById(Integer id) {
        return collectionMapper.deleteById(id) == 1;
    }

    @Override
    public Collection getById(Integer id) {
        return collectionMapper.getById(id);
    }

    @Override
    public List<Collection> listCollections() {
        return collectionMapper.listCollections();
    }

    @Override
    public List<Collection> listCollections(Collection collection) {
        return collectionMapper.listCollections(collection);
    }

    @Override
    public int countCollections(Collection collection) {
        return collectionMapper.countCollections(collection);
    }

    @Override
    public boolean update(Collection collection) {
        return collectionMapper.update(collection) == 1;
    }

    @Override
    public List<Integer> getCollectedCommodityIdsByUserId(Integer userId) {
        return collectionMapper.getCollectedCommodityIdsByUserId(userId);
    }

}