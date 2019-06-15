package com.ego.util;


import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Created by ASUS on 2019/5/16.
 */
//时间日期格式转换工具类
public class DateUtil {
    //格式
    public final static String pattern_date = "yyyy/MM/dd";

    public static String getDateStr(LocalDateTime date, String pattern){
        //JDK1.7版本
        //SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        //return simpleDateFormat.format(date);

        //JDK1.8版本
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern(pattern);
        return dateTimeFormatter.format(date);
    }
    //测试
    public static void main(String[] args){
        String dateStr = DateUtil.getDateStr(LocalDateTime.now(),DateUtil.pattern_date);
        System.out.println(dateStr);
    }

}
