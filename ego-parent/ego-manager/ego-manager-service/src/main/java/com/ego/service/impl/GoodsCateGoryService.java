package com.ego.service.impl;

import com.ego.mapper.GoodsCategoryMapper;
import com.ego.pojo.GoodsCategory;
import com.ego.pojo.GoodsCategoryExample;
import com.ego.pojo.GoodsCategoryVo;
import com.ego.result.BaseResult;
import com.ego.service.GoodsCateGoryServiceI;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by ASUS on 2019/5/22.
 *
 * 商品分类-新增分类-查询所有顶级分类
 * 商品分类-新增分类-根据父Id查询子分类
 */
@Service
public class GoodsCateGoryService implements GoodsCateGoryServiceI{
    @Autowired
    private GoodsCategoryMapper goodsCategoryMapper;
    //商品分类-新增分类-查询所有顶级分类
    @Override
    public List<GoodsCategory> selectTopCategory() {
        //创建查询对象
        GoodsCategoryExample example = new GoodsCategoryExample();
        //where条件
        example.createCriteria().andParentIdEqualTo((short)0).andLevelEqualTo((byte)1);
        List<GoodsCategory> list = goodsCategoryMapper.selectByExample(example);
        return (null == list || list.isEmpty()) ? null : list;
    }
    //商品分类-新增分类-根据父Id查询子分类
    @Override
    public List<GoodsCategory> selectCategoryGetByParentId(Short parentId) {
        //创建查询对象
        GoodsCategoryExample example = new GoodsCategoryExample();
        example.createCriteria().andParentIdEqualTo(parentId);
        List<GoodsCategory> list = goodsCategoryMapper.selectByExample(example);
        return (null == list || list.isEmpty()) ? null : list;
    }
    //商品分类-新增分类-商品保存
    @Override
    public BaseResult categorySave(GoodsCategory goodsCategory) {
        // insertSelective 选择性插入
        int result = goodsCategoryMapper.insertSelective(goodsCategory);
        return result > 0 ? BaseResult.success() : BaseResult.error();
    }
    //商品分类-查询所有商品信息
    @Override
    public List<GoodsCategoryVo> selectCategoryListForView() {
        //创建查询对象
        GoodsCategoryExample example = new GoodsCategoryExample();
        // 设置查询参数  parent 0   level 1
        example.createCriteria().andParentIdEqualTo((short) 0).andLevelEqualTo((byte) 1);
        //查询第一级
        List<GoodsCategory> gcList1 = goodsCategoryMapper.selectByExample(example);
        //清除查询数据
        example.clear();
        //循环处理第一级分类
        List<GoodsCategoryVo> gcvList1 = new ArrayList<>();
        for(GoodsCategory gc1 : gcList1){
            //创建VO对象
            GoodsCategoryVo gcv1 = new GoodsCategoryVo();
            //拷贝所有属性值 gc1的值给gcv1
            BeanUtils.copyProperties(gc1,gcv1);
            //设置查询参数
            example.createCriteria().andParentIdEqualTo(gc1.getId()).andLevelEqualTo((byte) 2);
            //查询第二级
            List<GoodsCategory> gcList2 = goodsCategoryMapper.selectByExample(example);
            //清除查询数据
            example.clear();
            //循环处理第二级分类
            List<GoodsCategoryVo> gcvList2 = new ArrayList<>();
            for(GoodsCategory gc2 : gcList2){
                //创建VO对象
                GoodsCategoryVo gcv2 = new GoodsCategoryVo();
                //拷贝所有属性值 gc1的值给gcv1
                BeanUtils.copyProperties(gc2,gcv2);
                //设置查询参数
                example.createCriteria().andParentIdEqualTo(gc2.getId()).andLevelEqualTo((byte) 3);
                //查询第三级
                List<GoodsCategory> gcList3 = goodsCategoryMapper.selectByExample(example);
                //清除查询数据
                example.clear();
                //循环处理第三级分类
                List<GoodsCategoryVo> gcvList3 = new ArrayList<>();
                for(GoodsCategory gc3 : gcList3){
                    //创建VO对象
                    GoodsCategoryVo gcv3 = new GoodsCategoryVo();
                    //拷贝所有属性值 gc1的值给gcv1
                    BeanUtils.copyProperties(gc3,gcv3);
                    //添加列表
                    gcvList3.add(gcv3);
                }
                // 添加至列表子级
                gcv2.setChildren(gcvList3);
                // 添加列表
                gcvList2.add(gcv2);
            }
            // 添加至列表子级
            gcv1.setChildren(gcvList2);
            // 添加列表
            gcvList1.add(gcv1);
        }
        return gcvList1;
    }

    /**
     *  商品分类-删除分类
     * @param id
     * @return
     */
    @Override
    public BaseResult categoryDelete(Short id) {
        int result = goodsCategoryMapper.deleteByPrimaryKey(id);
        return result>0?BaseResult.success():BaseResult.error();
    }
    /**
     *  商品分类-批量删除分类
     * @param ids
     * @return
     */
    @Override
    public BaseResult categoryListDelete(Short[] ids) {
        int result = goodsCategoryMapper.deleteBatchByPrimaryKey(ids);
        return result>0?BaseResult.success():BaseResult.error();
    }
    /**
     *  商品分类-根据主键id查询分类信息
     * @param id
     * @return
     */
    @Override
    public GoodsCategory categoryGetById(Short id) {
        return goodsCategoryMapper.selectByPrimaryKey(id);
    }
    /**
     *  商品编辑
     * @param
     * @return
     */
    @Override
    public BaseResult categoryUpdate(GoodsCategory goodsCategory) {
        //选择性编辑
        int result = goodsCategoryMapper.updateByPrimaryKeySelective(goodsCategory);
        return result>0?BaseResult.success():BaseResult.error();
    }
}
