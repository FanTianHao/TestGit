package com.ego.service;

import com.ego.result.FileResult;

import java.io.InputStream;

/**
 * Created by ASUS on 2019/5/16.
 */
//文件上传service
public interface FileUploadServiceI {
    //文件上传
    FileResult fileUploadSave(String fileName, InputStream inputStream);
    //文件删除
    Boolean fileDelete(String fileName);
}
