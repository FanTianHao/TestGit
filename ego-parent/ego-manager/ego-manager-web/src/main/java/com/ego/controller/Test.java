package com.ego.controller;

import java.util.*;

/**
 * Created by ASUS on 2019/5/18.
 */
public class Test {
    public static void main(String []args){
        String str = "asdfgh";
        System.out.println(str.length());
        String[] str1 = new String[]{"1","2","3"};
        System.out.println(str1.length);
        List list = new ArrayList();
        list.add(1);
        list.add("1");
        list.add("3");
        list.add(1);
        System.out.println(list.size());
        Map map = new HashMap();
        map.put(1,2);
        map.put(2,2);
        map.put(3,2);
        map.put(4,2);
        map.put(5,2);
        System.out.println(map.size());
    }
}
