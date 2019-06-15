package com.ego.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by ASUS on 2019/5/13.
 */
@Controller
public class PageController {
    @RequestMapping("/{page}")
    public  String page(@PathVariable String page){
        System.out.println("pageController-->"+page);
        return page;
    }
}
