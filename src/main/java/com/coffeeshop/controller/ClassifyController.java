package com.coffeeshop.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.coffeeshop.dto.ResponseResult;
import com.coffeeshop.entity.Classify;

import java.util.Date;

/**
 * 商品分类控制器
 *
 */
@RestController
public class ClassifyController extends BaseController {

    /**
     * 添加分类
     */
    @PostMapping("/addClassify")
    public ResponseResult addClassify(@RequestParam("name") String name) {
        // 根据名称查询，判断新增的分类是否已经重复
        Classify classify = Classify.builder().name(name).build();
        if (classifyService.countClassifys(classify) > 0) {
            result.setCode(500);
            result.setMessage("当前商品分类已存在");
        } else {
            // 新增
            classify.setCreateTime(new Date());
            if (classifyService.insert(classify)) {
                result.setCode(200);
                result.setMessage("新增商品分类成功");
            } else {
                result.setCode(500);
                result.setMessage("服务器出错");
            }
        }
        return result;
    }

    /**
     * 更新商品分类
     */
    @PostMapping("/updateClassify")
    public ResponseResult updateClassify(@RequestParam("id") Integer id, @RequestParam("name") String name) {
        // 根据名称查询，判断新增的分类是否已经重复
        Classify classify = Classify.builder().name(name).build();
        if (classifyService.countClassifys(classify) > 0) {
            result.setCode(500);
            result.setMessage("当前商品分类已存在");
        } else {
            classify = classifyService.getById(id);
            classify.setName(name);
            if (classifyService.update(classify)) {
                result.setCode(200);
                result.setMessage("更新商品分类名称成功");
            } else {
                result.setCode(500);
                result.setMessage("服务器出错");
            }
        }
        return result;
    }

    /**
     * 删除商品分类
     */
    @PostMapping("/deleteClassify")
    public ResponseResult deleteClassify(@RequestParam("id") Integer id) {
        // 删除
        if (classifyService.deleteById(id)) {
            result.setCode(200);
            result.setMessage("删除商品分类成功");
        } else {
            result.setCode(500);
            result.setMessage("服务器出错");
        }
        return result;
    }

    /**
     * 获取单条分类详情（用于编辑百科弹窗回显）
     */
    @GetMapping("/getClassify")
    public ResponseResult getClassify(@RequestParam("id") Integer id) {
        Classify classify = classifyService.getById(id);
        result.setCode(200);
        result.setData(classify);
        return result;
    }

    /**
     * 更新百科富文本及排序属性
     */
    @PostMapping("/updateWiki")
    public ResponseResult updateWiki(
            @RequestParam("id") Integer id, 
            @RequestParam(value = "description", required = false) String description, 
            @RequestParam(value = "coverImage", required = false) String coverImage,
            @RequestParam(value = "sortOrder", defaultValue = "99") Integer sortOrder) {
        Classify classify = classifyService.getById(id);
        if (classify != null) {
            classify.setDescription(description);
            classify.setCoverImage(coverImage);
            classify.setSortOrder(sortOrder);
            try {
                classifyService.update(classify);
                result.setCode(200);
                result.setMessage("百科与排序更新成功");
            } catch (Exception e) {
                result.setCode(500);
                result.setMessage("服务器异常");
            }
        } else {
            result.setCode(500);
            result.setMessage("分类不存在");
        }
        return result;
    }
}
