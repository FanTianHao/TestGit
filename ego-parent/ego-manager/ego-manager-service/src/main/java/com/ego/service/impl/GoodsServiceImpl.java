package com.ego.service.impl;

import com.ego.mapper.GoodsMapper;
import com.ego.pojo.Goods;
import com.ego.result.BaseResult;
import com.ego.service.GoodsServiceI;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.util.HtmlUtils;

/**
 * Created by ASUS on 2019/6/12.
 */
@Service
public class GoodsServiceImpl implements GoodsServiceI{
    @Autowired
    private GoodsMapper goodsMapper;
    //商品列表-保存
    @Override
    public BaseResult goodsSave(Goods goods) {
        if (null != goods) {
            if (null != goods.getGoodsContent() && !"".equals(goods.getGoodsContent().trim())) {
                // 转义
                String htmlEscape = HtmlUtils.htmlEscape(goods.getGoodsContent(), "UTF-8");
                goods.setGoodsContent(htmlEscape);
            }
        }
        int re = goodsMapper.insertSelective(goods);
        if (re > 0) {
            BaseResult result = BaseResult.success();
            result.setMessage(String.valueOf(goods.getGoodsId()));
            return result;
        }
        return BaseResult.error();
    }
}
