package com.ego.service;

import com.ego.pojo.Brand;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by ASUS on 2019/6/10.
 */

public interface BrandServiceI {
    //商品列表 - 品牌
    List<Brand> selectBrandList();
}
