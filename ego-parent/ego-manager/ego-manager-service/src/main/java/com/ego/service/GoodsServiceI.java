package com.ego.service;

import com.ego.pojo.Goods;
import com.ego.result.BaseResult;

/**
 * Created by ASUS on 2019/6/12.
 */

public interface GoodsServiceI {
    //商品列表-保存
    BaseResult goodsSave(Goods goods);
}
