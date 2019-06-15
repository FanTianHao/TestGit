package com.ego.controller;

import com.ego.pojo.Goods;
import com.ego.pojo.GoodsCategory;
import com.ego.pojo.GoodsCategoryVo;
import com.ego.result.BaseResult;
import com.ego.service.BrandServiceI;
import com.ego.service.FileUploadServiceI;
import com.ego.service.GoodsCateGoryServiceI;

import com.ego.service.GoodsServiceI;
import com.fasterxml.jackson.databind.util.BeanUtil;
import com.sun.xml.internal.rngom.parse.host.Base;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.List;


/**
 * Created by ASUS on 2019/5/14.
 * 商品添加页面
 * 商品列表页面
 * 根据父ID查询商品分类
 * 新增商品-保存
 */
@Controller
@RequestMapping("/product")
public class ProductController {
    private Logger logger = LoggerFactory.getLogger(ProductController.class);
    @Autowired
    private GoodsCateGoryServiceI goodsCategoryService;
    @Autowired
    private FileUploadServiceI fileUploadService;
    @Autowired
    private BrandServiceI brandService;
    @Autowired
    private GoodsServiceI goodsService;
    /**
     * 商品添加页面
     */
    @RequestMapping("/category/add")
    public String categoryAdd(Model model) {
        model.addAttribute("gcList",goodsCategoryService.selectTopCategory());
        return "product/category/category-add";
    }
    /**
     * 商品列表页面
     */
    @RequestMapping("/category/list")
    public String categoryList(Model model){
        model.addAttribute("goodsCategoryList", goodsCategoryService.selectCategoryListForView());
        return "product/category/category-list";
    }
    /**
     * 根据父ID查询商品分类
     */
    @RequestMapping("/category/getByParentId")
    @ResponseBody
    public List<GoodsCategory> selectCategoryGetByParentId(GoodsCategory goodsCategory) {
        return goodsCategoryService.selectCategoryGetByParentId(goodsCategory.getParentId());
    }
    /**
     * 新增商品-保存
     */
    @RequestMapping("/category/save")
    @ResponseBody
    public BaseResult categorySave(GoodsCategory goodsCategory){
        return goodsCategoryService.categorySave(goodsCategory);
    }
    /**
     * 商品分类-删除商品分类
     */
    @RequestMapping("/category/delete")
    @ResponseBody
    public BaseResult categoryDelete(Short id){
        //根据主键查询商品分类
        GoodsCategory gc = goodsCategoryService.categoryGetById(id);
        //健壮性
        if(gc == null){
            return BaseResult.error();
        }
        BaseResult result = null;
        //查看是否有子类
        if(1 == gc.getLevel()){
            //查询二级分类
            List<GoodsCategory> gcSecond = goodsCategoryService.selectCategoryGetByParentId(gc.getId());
            //如果不为空
            if(gcSecond != null && !gcSecond.isEmpty()){
                for(GoodsCategory gcs : gcSecond){
                    //查询三级分类
                    List<GoodsCategory> gcThird = goodsCategoryService.selectCategoryGetByParentId(gcs.getId());
                    if(gcThird != null && !gcThird.isEmpty()){
                        Short[] tids = getCategoryIds(gcThird);
                        //删除第三层
                        result = goodsCategoryService.categoryListDelete(tids);
                        //如果删除成功,查看有没有图片,有就删除
                        if(result.getCode()==200){
                            batchDeleteImage(gcThird);
                        }
                    }
                    Short[] sids = getCategoryIds(gcSecond);
                    //删除第三层
                    result = goodsCategoryService.categoryListDelete(sids);
                    //如果删除成功,查看有没有图片,有就删除
                    if(result.getCode()==200){
                        batchDeleteImage(gcSecond);
                    }
                }
            }
        }
        if(2 == gc.getLevel()){
            //查询三级分类
            List<GoodsCategory> gcThird = goodsCategoryService.selectCategoryGetByParentId(gc.getId());
            if(gcThird != null && !gcThird.isEmpty()){
                Short[] tids = getCategoryIds(gcThird);
                //删除第三层
                result = goodsCategoryService.categoryListDelete(tids);
                //如果删除成功,查看有没有图片,有就删除
                if(result.getCode()==200){
                    batchDeleteImage(gcThird);
                }
            }

        }

        //根据主键删除商品分类
        //通过主键删除商品分类
        result = goodsCategoryService.categoryDelete(id);
        //如果删除成功
        if (result.getCode() == 200 || result.getCode().equals(200)) {
            // 且图片存在，删除图片
            if (null != gc.getImage() && gc.getImage().length() > 0) {
                fileUploadService.fileDelete(gc.getImage());
                return BaseResult.success();
            }
        }
        return result;
    }

    //list中的id转成数组
    private Short[] getCategoryIds(List<GoodsCategory> list){
        Short[] ids = new Short[list.size()];
        //遍历list
        for(int i=0; i<list.size(); i++){
            ids[i] = list.get(i).getId();
        }
        return ids;
    }
    //批量删除图片
    private boolean batchDeleteImage(List<GoodsCategory> list){
            try {
                //遍历list
                for(int i=0; i<list.size(); i++) {
                    String images = list.get(i).getImage();
                    if (images != null && !images.isEmpty()) {
                        //文件删除
                        fileUploadService.fileDelete(images);
                    }
                }
            } catch (Exception e) {
                logger.error("批量删除文件失败，失败原因：" + e.getMessage());
                return false;
            }
        return true;
    }
    /**
     * 商品分类-编辑商品分类
     */
    @RequestMapping(value = "/category/edit/{id}", method = RequestMethod.GET)
    public String categoryEdit(@PathVariable("id") Short id, Model model){
        // 查询所有一级分类
        model.addAttribute("gcfList", goodsCategoryService.selectTopCategory());
        // 查询当前商品分类信息
        GoodsCategory gc = goodsCategoryService.categoryGetById(id);
        model.addAttribute("goodsCategory", gc);
        // 返显一级和二级分类标识
        Short gcFristId = 0;
        Short gcSecondId = 0;

        // 返显一级分类
        if (2 == gc.getLevel()) {
            gcFristId = gc.getParentId();
        }

        // 返显二级分类
        if (3 == gc.getLevel()) {
            // 查询上级分类
            GoodsCategory goodsCategory = goodsCategoryService.categoryGetById(gc.getParentId());
            gcFristId = goodsCategory.getParentId();
            gcSecondId = goodsCategory.getId();

            // 查询二级分类列表
            model.addAttribute("gcsList", goodsCategoryService.selectCategoryGetByParentId(goodsCategory.getParentId()));
        }

        model.addAttribute("gcFristId", gcFristId);
        model.addAttribute("gcSecondId", gcSecondId);
        return "product/category/category-edit";
    }

    //商品编辑
    @RequestMapping("/category/update")
    @ResponseBody
    public BaseResult categoryUpdate(GoodsCategoryVo gcv){
        //新创建一个gc对象
        GoodsCategory gc = new GoodsCategory();
        //将vo对象复制给gc对象
        BeanUtils.copyProperties(gcv,gc);
        //删除图片标识
        boolean flag = false;
        //判断是否上传了图片
        if(gcv.getUpdateImage() != null && gcv.getUpdateImage().length()>0){
            gc.setImage(gcv.getUpdateImage());
            flag=true;
        }
        //修改商品分类
        BaseResult result = goodsCategoryService.categoryUpdate(gc);
        if(result.getCode()==200){
            if(flag){
                fileUploadService.fileDelete(gcv.getUpdateImage());
            }
        }
        return result;
    }
    /**
     * 商品列表
     */
    @RequestMapping("/list")
    public String productList(){
        return "product/product-list";
    }
    /**
     * 商品列表-添加新商品
     */
    @RequestMapping("/add")
    public String productAdd(Model model){
        //商品列表一级菜单
        model.addAttribute("gcList",goodsCategoryService.selectTopCategory());
        //商品列表-商品品牌
        model.addAttribute("brandList",brandService.selectBrandList());
        return "product/product-add";
    }
    /**
     * 商品列表 -保存商品
     */
    @RequestMapping("/save")
    @ResponseBody
    public BaseResult goodsSave(Goods goods) {
        return goodsService.goodsSave(goods);
    }

    @RequestMapping("/test")
    @ResponseBody
    public String test() {
        return "hahahaha";
    }
}
