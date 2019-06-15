package com.ego.mapper;

import com.ego.pojo.GoodsCategory;
import com.ego.pojo.GoodsCategoryExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface GoodsCategoryMapper {
    /**
     * 根据主键批量删除
     * @param ids
     * @return
     */
    int deleteBatchByPrimaryKey(Short[] ids);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_goods_category
     *
     * @mbg.generated Sat May 18 11:56:27 CST 2019
     */
    long countByExample(GoodsCategoryExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_goods_category
     *
     * @mbg.generated Sat May 18 11:56:27 CST 2019
     */
    int deleteByExample(GoodsCategoryExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_goods_category
     *
     * @mbg.generated Sat May 18 11:56:27 CST 2019
     */
    int deleteByPrimaryKey(Short id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_goods_category
     *
     * @mbg.generated Sat May 18 11:56:27 CST 2019
     */
    int insert(GoodsCategory record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_goods_category
     *
     * @mbg.generated Sat May 18 11:56:27 CST 2019
     */
    int insertSelective(GoodsCategory record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_goods_category
     *
     * @mbg.generated Sat May 18 11:56:27 CST 2019
     */
    List<GoodsCategory> selectByExample(GoodsCategoryExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_goods_category
     *
     * @mbg.generated Sat May 18 11:56:27 CST 2019
     */
    GoodsCategory selectByPrimaryKey(Short id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_goods_category
     *
     * @mbg.generated Sat May 18 11:56:27 CST 2019
     */
    int updateByExampleSelective(@Param("record") GoodsCategory record, @Param("example") GoodsCategoryExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_goods_category
     *
     * @mbg.generated Sat May 18 11:56:27 CST 2019
     */
    int updateByExample(@Param("record") GoodsCategory record, @Param("example") GoodsCategoryExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_goods_category
     *
     * @mbg.generated Sat May 18 11:56:27 CST 2019
     */
    int updateByPrimaryKeySelective(GoodsCategory record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_goods_category
     *
     * @mbg.generated Sat May 18 11:56:27 CST 2019
     */
    int updateByPrimaryKey(GoodsCategory record);
}