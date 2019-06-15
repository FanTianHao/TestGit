package com.ego.controller;

import com.ego.result.FileResult;
import com.ego.service.FileUploadServiceI;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

/**
 * 文件上传Controller
 */
@Controller
@RequestMapping("/fileUpload")
public class FileUploadController {

    @Autowired
    private FileUploadServiceI fileUploadService;

    @RequestMapping("/save")
    @ResponseBody
    public FileResult fileUpload(MultipartFile file) throws IOException {
        // 文件上传
        return fileUploadService.fileUploadSave(file.getOriginalFilename(), file.getInputStream());
        // 模拟正常文件上传
//        FileResult result = new FileResult();
//        result.setSuccess("success");
//        result.setFileUrl("http://192.168.10.24/2019/02/26/155e6052-bdb9-40ff-be7e-9756b2a64b1c.jpg");
//        return result;
    }
}
