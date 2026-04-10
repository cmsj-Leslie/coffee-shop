package com.coffeeshop.service.impl;

import org.springframework.stereotype.Service;
import com.coffeeshop.entity.Classify;
import com.coffeeshop.entity.Commodity;
import com.coffeeshop.service.BaseService;
import com.coffeeshop.service.ClassifyService;

import java.util.List;

/**
 * @ClassName ClassifyServiceImpl
 *            归类(Classify)表业务接口实现类
 * @Version 1.0
 **/
@Service("classifyService")
public class ClassifyServiceImpl extends BaseService implements ClassifyService {

    @Override
    public boolean insert(Classify classify) {
        return classifyMapper.insert(classify) == 1;
    }

    @Override
    public boolean deleteById(Integer id) {
        return classifyMapper.deleteById(id) == 1;
    }

    @Override
    public Classify getById(Integer id) {
        return classifyMapper.getById(id);
    }

    @Override
    public List<Classify> listClassifys() {
        List<Classify> classifies = classifyMapper.listClassifys();
        classifies.forEach(classify -> {
            Commodity param = Commodity.builder().classifyId(classify.getId()).build();
            classify.setCount(commodityMapper.countCommoditys(param));
        });
        return classifies;
    }

    @Override
    public List<Classify> listClassifys(Classify classify) {
        List<Classify> classifies = classifyMapper.listClassifys(classify);
        classifies.forEach(temp -> {
            Commodity param = Commodity.builder().classifyId(temp.getId()).build();
            temp.setCount(commodityMapper.countCommoditys(param));
        });
        return classifies;
    }

    @Override
    public int countClassifys(Classify classify) {
        return classifyMapper.countClassifys(classify);
    }

    @Override
    public boolean update(Classify classify) {
        return classifyMapper.update(classify) == 1;
    }

}