package com.ego.service;

/**
 * Created by ASUS on 2019/5/22.
 */

import com.ego.pojo.GoodsCategory;
import com.ego.pojo.GoodsCategoryVo;
import com.ego.result.BaseResult;

import java.util.List;

/**
 * 商品分类
 */
public interface GoodsCateGoryServiceI {
    //商品分类-新增分类-查询所有顶级分类
    List<GoodsCategory> selectTopCategory();
    //商品分类-新增分类-根据父Id查询子分类
    List<GoodsCategory> selectCategoryGetByParentId(Short parentId);
    //商品分类-新增分类-商品保存
    BaseResult categorySave(GoodsCategory goodsCategory);
    //商品分类-查询所有商品信息
    List<GoodsCategoryVo> selectCategoryListForView();
    //商品分类-删除分类
    BaseResult categoryDelete(Short id);
    //商品分类-批量删除分类
    BaseResult categoryListDelete(Short[] ids);
    //商品分类-通过主键id查询分类信息
    GoodsCategory categoryGetById(Short id);
    //商品编辑
    BaseResult categoryUpdate(GoodsCategory goodsCategory);
}
